local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local player = Player
local getgenv = getgenv or function() return _G end

local isEnemy, estaEnLobby, IsInMatchStrict
local esEnemigoValido, esCuchillo, esPistola, obtenerPistola
local startTargetMonitor, stopTargetMonitor
do
local playerGui = player:WaitForChild("PlayerGui")
local dmvsInvalidateRedirectSelection
local dmvsClearTargetParts
local function dmvsDisconnectConnectionList(list)
    if not list then return end
    for i = #list, 1, -1 do
        local connection = list[i]
        list[i] = nil
        if connection and connection.Connected then connection:Disconnect() end
    end
end
local dmvsIsInfectionMode
local function dmvsIsTargetAlive(target)
    local character = target
    if typeof(target) == "Instance" and target:IsA("Player") then
        character = target.Character
    end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    if dmvsIsInfectionMode and dmvsIsInfectionMode() then
        return character:GetAttribute("InfectionDowned") ~= true
    end
    return humanoid.Health >= 99
end
local function dmvsGetInGameScoreboard()
    local gui = player:FindFirstChild("PlayerGui")
    local main = gui and gui:FindFirstChild("Main")
    local frame = main and main:FindFirstChild("MainGameFrame")
    return frame and frame:FindFirstChild("IngameScore") or nil
end

local dmvsTeamResolverState = {
    Snapshot = {},
    Scoreboard = nil,
    InGame = false,
    LocalGame = nil,
    LastRefresh = 0,
    RefreshInterval = 2,
    Dirty = true,
    WatchConnections = {}
}

local function dmvsInvalidateScoreboard()
    dmvsTeamResolverState.Dirty = true
end

local function dmvsWatchScoreboard(score)
    local state = dmvsTeamResolverState
    if state.Scoreboard == score then return end
    dmvsDisconnectConnectionList(state.WatchConnections)
    state.Scoreboard = score
    if not score then return end
    local watchTeams
    watchTeams = function()
        dmvsInvalidateScoreboard()
        dmvsDisconnectConnectionList(state.WatchConnections)
        state.WatchConnections[#state.WatchConnections + 1] = score.ChildAdded:Connect(watchTeams)
        state.WatchConnections[#state.WatchConnections + 1] = score.ChildRemoved:Connect(watchTeams)
        for _, name in ipairs({"TeamRed", "TeamBlue"}) do
            local folder = score:FindFirstChild(name)
            if folder then
                state.WatchConnections[#state.WatchConnections + 1] = folder.ChildAdded:Connect(dmvsInvalidateScoreboard)
                state.WatchConnections[#state.WatchConnections + 1] = folder.ChildRemoved:Connect(dmvsInvalidateScoreboard)
            end
        end
    end
    watchTeams()
end

local function dmvsRefreshScoreboardTeams(force)
    local state = dmvsTeamResolverState
    local now = os.clock()
    local localGame = player:GetAttribute("Game")
    if not force and not state.Dirty and now - state.LastRefresh < state.RefreshInterval
        and state.LocalGame == localGame
        and (not state.Scoreboard or state.Scoreboard.Parent) then
        return state.Snapshot
    end

    state.LastRefresh = now
    state.LocalGame = localGame
    local snapshot = {}
    local score = dmvsGetInGameScoreboard()
    if score ~= state.Scoreboard then dmvsWatchScoreboard(score) end
    for _, teamName in ipairs({"TeamRed", "TeamBlue"}) do
        local teamFolder = score and score:FindFirstChild(teamName)
        if teamFolder then
            local team = teamName == "TeamRed" and "Red" or "Blue"
            for _, entry in ipairs(teamFolder:GetChildren()) do
                if entry:IsA("GuiObject") then
                    snapshot[string.lower(entry.Name)] = team
                end
            end
        end
    end
    state.Snapshot = snapshot
    state.Dirty = false
    state.InGame = score ~= nil and snapshot[string.lower(player.Name)] ~= nil
    return snapshot
end

local dmvsInfectionRoleAttributes = {"InfectionInfected", "IsInfected", "Infected", "IsZombie", "Zombie"}
local dmvsInfectionModeAttributes = {"GameMode", "MatchMode", "Mode"}
local dmvsInfectionState = {
    Active = false,
    LastRefresh = -math.huge,
    RefreshInterval = 0.4,
    RoleTeams = {},
    Inferred = {},
    Targets = {},
    Converted = {},
    ConvertedAt = {},
    Pending = {},
    LateJoiners = {},
    LastLocalGame = nil,
    LastMatchId = nil,
    HasMatchContext = false,
    RoundEnded = false
}

local function dmvsInfectionReadMarker(holder)
    if not holder then return nil end
    if holder:GetAttribute("InfectionPatientZero") == true then return true end
    local sawSurvivor = false
    for _, name in ipairs(dmvsInfectionRoleAttributes) do
        local value = holder:GetAttribute(name)
        if typeof(value) == "boolean" then
            if value then return true end
            sawSurvivor = true
        elseif typeof(value) == "string" then
            local normalized = value:lower()
            if normalized == "infected" or normalized == "infection" or normalized == "zombie" or normalized == "true" then
                return true
            end
            if normalized == "survivor" or normalized == "human" or normalized == "false" then
                sawSurvivor = true
            end
        end
    end
    if sawSurvivor then return false end
    return nil
end

local function dmvsInfectionHasPatientZero(other)
    if other:GetAttribute("InfectionPatientZero") == true then return true end
    local character = other.Character
    if not character then return false end
    if character:GetAttribute("InfectionPatientZero") == true then return true end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return humanoid ~= nil and humanoid:GetAttribute("InfectionPatientZero") == true
end

local function dmvsInfectionAttribute(playerInstance)
    if not playerInstance then return nil end
    local character = playerInstance.Character
    local characterStatus = dmvsInfectionReadMarker(character)
    local playerStatus = dmvsInfectionReadMarker(playerInstance)
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local humanoidStatus = dmvsInfectionReadMarker(humanoid)
    if characterStatus == true or playerStatus == true or humanoidStatus == true then return true end
    if characterStatus == false or playerStatus == false or humanoidStatus == false then return false end
    return nil
end

local function dmvsReadInfectionRoster(teams)
    local frame = playerGui:FindFirstChild("Main")
    frame = frame and frame:FindFirstChild("MainGameFrame")
    if not frame then return end
    local playerFrame = frame:FindFirstChild("PlayersFrame")
    local regularFrame = frame:FindFirstChild("IngameScore")
    local playerNames = {}
    local displayCandidates = {}
    local ambiguousDisplays = {}
    for _, other in ipairs(Players:GetPlayers()) do
        playerNames[other.Name:lower()] = other
        playerNames[tostring(other.UserId)] = other
        local displayKey = other.DisplayName:lower()
        if displayCandidates[displayKey] then ambiguousDisplays[displayKey] = true end
        displayCandidates[displayKey] = other
    end
    for displayKey, other in pairs(displayCandidates) do
        if not ambiguousDisplays[displayKey] and not playerNames[displayKey] then
            playerNames[displayKey] = other
        end
    end
    local function collect(group, team)
        if not group then return end
        for _, entry in ipairs(group:GetChildren()) do
            if entry:IsA("GuiObject") then
                local other = playerNames[entry.Name:lower():gsub("^@", "")]
                if not other then
                    local entryUserId = entry:GetAttribute("UserId")
                    if entryUserId then other = playerNames[tostring(entryUserId)] end
                end
                if not other then
                    for _, sub in ipairs(entry:GetDescendants()) do
                        if sub:IsA("TextLabel") and (sub.Name == "PlayerName" or sub.Name == "TextLabel") then
                            other = playerNames[sub.Text:lower():gsub("^@", "")]
                            if other then break end
                        end
                    end
                end
                if other then teams[other] = team end
            end
        end
    end
    if regularFrame then
        collect(regularFrame:FindFirstChild("TeamRed"), "Red")
        collect(regularFrame:FindFirstChild("TeamBlue"), "Blue")
    end
    if playerFrame then
        collect(playerFrame:FindFirstChild("TeamRedFrame"), "Red")
        collect(playerFrame:FindFirstChild("TeamBlueFrame"), "Blue")
    end
end

local function dmvsClearInfectionRound(ended)
    local state = dmvsInfectionState
    table.clear(state.Converted)
    table.clear(state.ConvertedAt)
    table.clear(state.Pending)
    table.clear(state.LateJoiners)
    table.clear(state.Inferred)
    table.clear(state.Targets)
    table.clear(state.RoleTeams)
    state.Active = false
    state.RoundEnded = ended == true
    state.LastRefresh = -math.huge
    if dmvsInvalidateRedirectSelection then dmvsInvalidateRedirectSelection() end
end

local function dmvsRefreshInfectionState(force)
    local state = dmvsInfectionState
    local now = os.clock()
    local localGame = player:GetAttribute("Game")
    local matchId = player:GetAttribute("MatchId")
    if state.HasMatchContext and (localGame ~= state.LastLocalGame or matchId ~= state.LastMatchId) then
        dmvsClearInfectionRound(false)
    end
    state.HasMatchContext = true
    state.LastLocalGame = localGame
    state.LastMatchId = matchId
    if not force and now - state.LastRefresh < state.RefreshInterval then
        return state
    end
    state.LastRefresh = now
    local regularRoster = dmvsRefreshScoreboardTeams(false)
    local foundPatientZero = false
    local ownCharacter = player.Character
    local myRoot = ownCharacter and ownCharacter:FindFirstChild("HumanoidRootPart")
    local allPlayers = Players:GetPlayers()
    for _, other in ipairs(allPlayers) do
        if dmvsInfectionHasPatientZero(other) then
            local compatible = other == player
            if not compatible then
                compatible = true
                local otherGame = other:GetAttribute("Game")
                local otherMatch = other:GetAttribute("MatchId")
                if localGame ~= nil and localGame ~= ""
                    and otherGame ~= nil and otherGame ~= "" and localGame ~= otherGame then
                    compatible = false
                end
                if (localGame == nil or localGame == "")
                    and otherGame ~= nil and otherGame ~= "" then
                    compatible = false
                end
                if matchId ~= nil and matchId ~= ""
                    and otherMatch ~= nil and otherMatch ~= "" and matchId ~= otherMatch then
                    compatible = false
                end
                local theirCharacter = other.Character
                local theirRoot = theirCharacter and theirCharacter:FindFirstChild("HumanoidRootPart")
                if myRoot and theirRoot and (myRoot.Position - theirRoot.Position).Magnitude > 1200 then
                    compatible = false
                end
            end
            if compatible then
                foundPatientZero = true
                break
            end
        end
    end
    local modeAttribute
    for _, name in ipairs(dmvsInfectionModeAttributes) do
        local value = player:GetAttribute(name)
        if typeof(value) == "string" and value ~= "" then
            modeAttribute = value:lower()
            break
        end
    end
    if not modeAttribute then
        for _, name in ipairs(dmvsInfectionModeAttributes) do
            local value = workspace:GetAttribute(name)
            if typeof(value) == "string" and value ~= "" then
                modeAttribute = value:lower()
                break
            end
        end
    end
    local active = not state.RoundEnded and
        (modeAttribute == "infection" or
            (not modeAttribute and (foundPatientZero or
                (state.Active and not dmvsTeamResolverState.InGame))))
    if not active then
        if modeAttribute and modeAttribute ~= "infection" and next(state.LateJoiners) ~= nil then
            table.clear(state.LateJoiners)
        end
        if state.Active or next(state.Targets) ~= nil then
            if modeAttribute and modeAttribute ~= "infection" then
                dmvsClearInfectionRound(false)
            else
                state.Active = false
                table.clear(state.Targets)
                table.clear(state.Inferred)
                table.clear(state.RoleTeams)
                if dmvsInvalidateRedirectSelection then dmvsInvalidateRedirectSelection() end
            end
        end
        return state
    end
    state.Active = true
    local teams = {}
    dmvsReadInfectionRoster(teams)
    state.RoleTeams = teams
    local infectedTeam
    local ambiguousTeam = false
    local markers = {}
    for _, other in ipairs(allPlayers) do
        local marker = dmvsInfectionAttribute(other)
        markers[other] = marker
        if marker == true or state.Converted[other] == true then
            local team = teams[other]
            if team then
                if infectedTeam and infectedTeam ~= team then ambiguousTeam = true end
                infectedTeam = team
            end
        end
    end
    local inferred = {}
    if infectedTeam and not ambiguousTeam then
        for other, team in pairs(teams) do
            if team == infectedTeam and markers[other] ~= false then
                inferred[other] = true
            end
        end
    end
    state.Inferred = inferred
    local function createTargets()
        local targets = {}
        for _, other in ipairs(allPlayers) do
            if markers[other] == true or state.Converted[other] == true
                or (markers[other] ~= false and inferred[other] == true) then
                targets[other] = true
            end
        end
        return targets
    end
    local targets = createTargets()
    local infectedRoots = {}
    for infectedPlayer in pairs(targets) do
        local infectedCharacter = infectedPlayer.Character
        local infectedRoot = infectedCharacter and infectedCharacter:FindFirstChild("HumanoidRootPart")
        if infectedRoot and infectedRoot:IsA("BasePart") then
            infectedRoots[#infectedRoots + 1] = infectedRoot
        end
    end
    for _, other in ipairs(allPlayers) do
        if other ~= player and state.LateJoiners[other] and markers[other] == nil
            and not targets[other] and other.Character then
            local rosterTeam = teams[other] or regularRoster[other.Name:lower()]
            local otherGame = other:GetAttribute("Game")
            local otherMatch = other:GetAttribute("MatchId")
            local sameGame = localGame ~= nil and localGame ~= "" and otherGame == localGame
            local sameMatch = matchId ~= nil and matchId ~= "" and otherMatch == matchId
            local differentGame = localGame ~= nil and localGame ~= "" and otherGame ~= nil
                and otherGame ~= "" and otherGame ~= localGame
            local differentMatch = matchId ~= nil and matchId ~= "" and otherMatch ~= nil
                and otherMatch ~= "" and otherMatch ~= matchId
            if not differentGame and not differentMatch then
                local sharesInfectedTeam = false
                for infectedPlayer in pairs(targets) do
                    local infectedRobloxTeam = infectedPlayer.Team
                    if infectedRobloxTeam and other.Team == infectedRobloxTeam
                        and (markers[infectedPlayer] == true or state.Converted[infectedPlayer] == true
                            or inferred[infectedPlayer] == true) then
                        sharesInfectedTeam = true
                        break
                    end
                end
                local nearInfected = false
                if not rosterTeam and not sameGame and not sameMatch and not sharesInfectedTeam then
                    local characterRoot = other.Character:FindFirstChild("HumanoidRootPart")
                    if characterRoot and characterRoot:IsA("BasePart") then
                        local position = characterRoot.Position
                        for _, infectedRoot in ipairs(infectedRoots) do
                            if (infectedRoot.Position - position).Magnitude <= 300 then
                                nearInfected = true
                                break
                            end
                        end
                    end
                end
                local participates = rosterTeam ~= nil or sameGame or sameMatch
                    or sharesInfectedTeam or nearInfected
                if participates and (not infectedTeam or ambiguousTeam or not rosterTeam or rosterTeam == infectedTeam) then
                    targets[other] = true
                end
            end
        end
    end
    local pending = state.Pending
    local changed = true
    while changed do
        changed = false
        for index = #pending, 1, -1 do
            local entry = pending[index]
            if now - entry.Time > 10 or entry.Killer.Parent ~= Players or entry.Victim.Parent ~= Players then
                table.remove(pending, index)
            elseif targets[entry.Killer] and not targets[entry.Victim]
                and (not state.ConvertedAt[entry.Killer]
                    or state.ConvertedAt[entry.Killer] <= entry.Time) then
                state.Converted[entry.Victim] = true
                state.ConvertedAt[entry.Victim] = entry.Time
                targets[entry.Victim] = true
                table.remove(pending, index)
                changed = true
            elseif targets[entry.Killer] then
                table.remove(pending, index)
            end
        end
    end
    local previous = state.Targets
    local targetChanged = false
    for other in pairs(previous) do
        if not targets[other] then targetChanged = true; break end
    end
    if not targetChanged then
        for other in pairs(targets) do
            if not previous[other] then targetChanged = true; break end
        end
    end
    state.Targets = targets
    if targetChanged and dmvsInvalidateRedirectSelection then
        dmvsInvalidateRedirectSelection()
    end
    return state
end

dmvsIsInfectionMode = function()
    return dmvsRefreshInfectionState(false).Active
end

local function dmvsIsInfectedTarget(targetPlayer)
    if not targetPlayer then return false end
    local state = dmvsRefreshInfectionState(false)
    return state.Active and state.Targets[targetPlayer] == true
end

local function dmvsInfectionMatchAllowed(targetPlayer, allowMissingCharacter)
    if not targetPlayer or targetPlayer == player or not targetPlayer.Parent
        or (not allowMissingCharacter and not targetPlayer.Character) then
        return false
    end
    local myGame = player:GetAttribute("Game")
    local targetGame = targetPlayer:GetAttribute("Game")
    if myGame ~= nil and myGame ~= "" and targetGame ~= nil and targetGame ~= "" and myGame ~= targetGame then
        return false
    end
    if (myGame == nil or myGame == "") and targetGame ~= nil and targetGame ~= "" then
        return false
    end
    local myMatch = player:GetAttribute("MatchId")
    local targetMatch = targetPlayer:GetAttribute("MatchId")
    if myMatch ~= nil and myMatch ~= "" and targetMatch ~= nil and targetMatch ~= "" and myMatch ~= targetMatch then
        return false
    end
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local otherRoot = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if myRoot and otherRoot and (myRoot.Position - otherRoot.Position).Magnitude > 1200 then
        return false
    end
    return true
end

local function dmvsInfectionMarkDirty()
    dmvsInfectionState.LastRefresh = -math.huge
end

local function dmvsInfectionOnKill(killer, victim)
    if typeof(killer) ~= "Instance" or not killer:IsA("Player")
        or typeof(victim) ~= "Instance" or not victim:IsA("Player")
        or killer == victim or not dmvsIsInfectionMode()
        or (killer ~= player and not dmvsInfectionMatchAllowed(killer, true))
        or (victim ~= player and not dmvsInfectionMatchAllowed(victim, true)) then
        return
    end
    local state = dmvsRefreshInfectionState(false)
    if state.Targets[victim] then return end
    if state.Targets[killer] then
        state.Converted[victim] = true
        state.ConvertedAt[victim] = os.clock()
        state.LastRefresh = -math.huge
        dmvsRefreshInfectionState(true)
    else
        if #state.Pending >= 96 then table.remove(state.Pending, 1) end
        state.Pending[#state.Pending + 1] = {Killer = killer, Victim = victim, Time = os.clock()}
        state.LastRefresh = -math.huge
    end
end

local dmvsIsInSameGame
dmvsIsInSameGame = function(targetPlayer)
    if not targetPlayer or targetPlayer == player or not targetPlayer.Parent then
        return false
    end

    if dmvsIsInfectionMode() then
        return dmvsInfectionMatchAllowed(targetPlayer) and dmvsIsInfectedTarget(targetPlayer)
    end

    local roster = dmvsRefreshScoreboardTeams(false)
    if not dmvsTeamResolverState.InGame or not roster[string.lower(targetPlayer.Name)] then
        return false
    end

    local myGame = player:GetAttribute("Game")
    local targetGame = targetPlayer:GetAttribute("Game")
    if myGame ~= nil and myGame ~= "" and targetGame ~= nil and targetGame ~= "" then
        if myGame ~= targetGame then return false end
    elseif (myGame == nil or myGame == "") and targetGame ~= nil and targetGame ~= "" then
        return false
    end

    local myMatch = player:GetAttribute("MatchId")
    local targetMatch = targetPlayer:GetAttribute("MatchId")
    if myMatch ~= nil and myMatch ~= "" and targetMatch ~= nil and targetMatch ~= "" and myMatch ~= targetMatch then
        return false
    end

    return true
end

local function dmvsResolvePlayerTeam(targetPlayer)
    if not targetPlayer then return nil end

    local snapshot = dmvsRefreshScoreboardTeams(false)
    local byName = snapshot[string.lower(targetPlayer.Name)]

    if not byName and targetPlayer.DisplayName then
        byName = snapshot[string.lower(targetPlayer.DisplayName)]
    end

    if byName then
        return byName
    end

    local attr = targetPlayer:GetAttribute("Team") or targetPlayer:GetAttribute("team")
    if attr ~= nil and tostring(attr) ~= "" then
        return tostring(attr)
    end

    if targetPlayer.Team then
        return targetPlayer.Team.Name
    end

    local teamColor = targetPlayer.TeamColor
    if teamColor and teamColor.Name ~= "White" and teamColor.Name ~= "Medium stone grey" then
        return "Color:" .. teamColor.Name
    end

    return nil
end

local function dmvsPlayersAreEnemies(firstPlayer, secondPlayer)
    if not firstPlayer or not secondPlayer or firstPlayer == secondPlayer then
        return false
    end
    if dmvsIsInfectionMode() then
        return dmvsIsInfectedTarget(secondPlayer)
    end

    local firstTeam = dmvsResolvePlayerTeam(firstPlayer)
    local secondTeam = dmvsResolvePlayerTeam(secondPlayer)

    if firstTeam ~= nil and secondTeam ~= nil then
        return firstTeam ~= secondTeam
    end

    return true
end

local function updateMyTeam()
    dmvsInvalidateScoreboard()
    if dmvsInvalidateRedirectSelection then dmvsInvalidateRedirectSelection() end
end

local function updateEnemy()
    dmvsInvalidateScoreboard()
    dmvsInfectionMarkDirty()
    if dmvsInvalidateRedirectSelection then dmvsInvalidateRedirectSelection() end
end

local dmvsTeamPlayerConnections = {}
local dmvsInfectionCharacterConnections = {}

local function disconnectPlayerTeamEvents(p)
    dmvsDisconnectConnectionList(dmvsInfectionCharacterConnections[p])
    dmvsInfectionCharacterConnections[p] = nil
    local connections = dmvsTeamPlayerConnections[p]
    if connections then
        dmvsDisconnectConnectionList(connections)
        dmvsTeamPlayerConnections[p] = nil
    end
end

local function dmvsWatchInfectionCharacter(p, character)
    dmvsDisconnectConnectionList(dmvsInfectionCharacterConnections[p])
    dmvsInfectionCharacterConnections[p] = nil
    if not character then return end
    local connections = {}
    dmvsInfectionCharacterConnections[p] = connections
    local function changed(name)
        if name == "InfectionPatientZero" or name == "InfectionInfected"
            or name == "IsInfected" or name == "Infected"
            or name == "IsZombie" or name == "Zombie" then
            dmvsInfectionMarkDirty()
            updateEnemy()
        end
    end
    connections[#connections + 1] = character.AttributeChanged:Connect(changed)
    local function bindHumanoid(humanoid)
        if humanoid and humanoid:IsA("Humanoid") then
            connections[#connections + 1] = humanoid.AttributeChanged:Connect(changed)
        end
    end
    bindHumanoid(character:FindFirstChildOfClass("Humanoid"))
    connections[#connections + 1] = character.ChildAdded:Connect(function(child)
        if child:IsA("Humanoid") then
            bindHumanoid(child)
            dmvsInfectionMarkDirty()
        end
    end)
end

local function setupPlayerEvents(p)
    if not p or p == player or not p.Parent then return end
    disconnectPlayerTeamEvents(p)
    dmvsTeamPlayerConnections[p] = {
        p:GetPropertyChangedSignal("Team"):Connect(updateEnemy),
        p:GetPropertyChangedSignal("TeamColor"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("Team"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("team"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("Game"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("MatchId"):Connect(updateEnemy),
        p.AttributeChanged:Connect(function(name)
            if name == "InfectionPatientZero" or name == "InfectionInfected"
                or name == "IsInfected" or name == "Infected"
                or name == "IsZombie" or name == "Zombie" then
                dmvsInfectionMarkDirty()
                updateEnemy()
            end
        end),
        p.CharacterAdded:Connect(function(character)
            dmvsWatchInfectionCharacter(p, character)
            dmvsInfectionMarkDirty()
            updateEnemy()
        end),
        p.CharacterRemoving:Connect(function(character)
            dmvsWatchInfectionCharacter(p, nil)
            dmvsInfectionMarkDirty()
            if dmvsClearTargetParts then dmvsClearTargetParts(character) end
        end)
    }
    dmvsWatchInfectionCharacter(p, p.Character)
    updateEnemy()
end

local nexvyrTargetConnections = {}
local nexvyrTargetMonitorActive = false
local nexvyrTargetMonitorSession = 0
local function nexvyrMonitorConnection(connection)
    nexvyrTargetConnections[#nexvyrTargetConnections + 1] = connection
    return connection
end
local function nexvyrStartTargetMonitor()
    if nexvyrTargetMonitorActive then return end
    nexvyrTargetMonitorActive = true
    nexvyrTargetMonitorSession += 1
    local session = nexvyrTargetMonitorSession
    local function localChanged() updateMyTeam(); dmvsInfectionMarkDirty() end
    for _, name in ipairs({"Team", "TeamColor"}) do
        nexvyrMonitorConnection(player:GetPropertyChangedSignal(name):Connect(localChanged))
    end
    for _, name in ipairs({"Team", "team", "Game", "MatchId", "GameMode", "MatchMode", "Mode"}) do
        nexvyrMonitorConnection(player:GetAttributeChangedSignal(name):Connect(localChanged))
    end
    nexvyrMonitorConnection(player.AttributeChanged:Connect(function(name)
        if name == "InfectionPatientZero" or name == "InfectionInfected" or name == "IsInfected"
            or name == "Infected" or name == "IsZombie" or name == "Zombie" then dmvsInfectionMarkDirty() end
    end))
    nexvyrMonitorConnection(player.CharacterAdded:Connect(dmvsInfectionMarkDirty))
    nexvyrMonitorConnection(playerGui.DescendantAdded:Connect(function(instance)
        if instance.Name == "IngameScore" or instance.Name == "TeamRed" or instance.Name == "TeamBlue" then
            dmvsInvalidateScoreboard(); dmvsInfectionMarkDirty()
        end
    end))
    nexvyrMonitorConnection(playerGui.DescendantRemoving:Connect(function(instance)
        if instance == dmvsTeamResolverState.Scoreboard or instance.Name == "IngameScore"
            or instance.Name == "TeamRed" or instance.Name == "TeamBlue" then
            dmvsInvalidateScoreboard(); dmvsInfectionMarkDirty()
        end
    end))
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= player then setupPlayerEvents(other) end
    end
    nexvyrMonitorConnection(Players.PlayerAdded:Connect(function(other)
        dmvsInfectionState.LateJoiners[other] = true
        setupPlayerEvents(other)
        dmvsInfectionMarkDirty()
    end))
    nexvyrMonitorConnection(Players.PlayerRemoving:Connect(function(other)
        disconnectPlayerTeamEvents(other)
        for i = #dmvsInfectionState.Pending, 1, -1 do
            local entry = dmvsInfectionState.Pending[i]
            if entry.Killer == other or entry.Victim == other then table.remove(dmvsInfectionState.Pending, i) end
        end
        for _, bucket in ipairs({"Converted", "ConvertedAt", "LateJoiners", "Inferred", "Targets", "RoleTeams"}) do
            dmvsInfectionState[bucket][other] = nil
        end
        updateEnemy()
    end))
    dmvsInvalidateScoreboard()
    dmvsInfectionMarkDirty()
    task.spawn(function()
        local registered = {}
        local listeners = {
            ["RE/Combat/Killed"] = dmvsInfectionOnKill,
            ["RE/Match/PlayerRespawned"] = dmvsInfectionMarkDirty,
            ["RE/Match/StartRoundGui"] = function() dmvsClearInfectionRound(false) end,
            ["RE/Match/MatchResults"] = function()
                if dmvsInfectionState.Active then dmvsClearInfectionRound(true) end
            end
        }
        while nexvyrTargetMonitorActive and session == nexvyrTargetMonitorSession do
            local packages = ReplicatedStorage:FindFirstChild("Packages")
            local networking = packages and packages:FindFirstChild("Networking")
            local finished = true
            for name, callback in pairs(listeners) do
                if not registered[name] then
                    local remote = networking and networking:FindFirstChild(name)
                    if remote and remote:IsA("RemoteEvent") then
                        nexvyrMonitorConnection(remote.OnClientEvent:Connect(callback))
                        registered[name] = true
                    else
                        finished = false
                    end
                end
            end
            if finished then break end
            task.wait(2)
        end
    end)
end
local function nexvyrStopTargetMonitor()
    if not nexvyrTargetMonitorActive then return end
    nexvyrTargetMonitorActive = false
    nexvyrTargetMonitorSession += 1
    dmvsDisconnectConnectionList(nexvyrTargetConnections)
    for other in pairs(dmvsTeamPlayerConnections) do disconnectPlayerTeamEvents(other) end
    dmvsDisconnectConnectionList(dmvsTeamResolverState.WatchConnections)
    dmvsTeamResolverState.Scoreboard = nil
    dmvsTeamResolverState.Snapshot = {}
    dmvsTeamResolverState.InGame = false
    dmvsTeamResolverState.Dirty = true
    dmvsClearInfectionRound(false)
end
startTargetMonitor = nexvyrStartTargetMonitor
stopTargetMonitor = nexvyrStopTargetMonitor

isEnemy = function(targetPlayer)
    if not dmvsIsInSameGame(targetPlayer) or not targetPlayer.Character then return false end
    if not dmvsIsTargetAlive(targetPlayer) then return false end
    return dmvsPlayersAreEnemies(player, targetPlayer)
end
local SAFE_ZONES = {
    {Center = Vector3.new(-320.50, 280.82, 16.00), Radius = 500},
    {Center = Vector3.new(1564.14, -155.45, 40.04), Radius = 300}
}
estaEnLobby = function()
    local character = player.Character
    if not character then return true end
    if character:FindFirstChildOfClass("ForceField") then return true end
    if player.Team then
        local name = player.Team.Name:lower()
        if name:find("lobby") or name:find("spectat") or name:find("espectador")
            or name:find("menu") or name:find("dead") then return true end
    end
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        for _, zone in ipairs(SAFE_ZONES) do
            if (root.Position - zone.Center).Magnitude <= zone.Radius then return true end
        end
    end
    return false
end
IsInMatchStrict = function()
    if estaEnLobby() then return false end
    dmvsRefreshScoreboardTeams(false)
    return dmvsTeamResolverState.InGame or dmvsIsInfectionMode()
end
esEnemigoValido = function(other)
    if not isEnemy(other) then return false end
    local character = other.Character
    return character ~= nil and not character:FindFirstChildOfClass("ForceField")
        and dmvsIsTargetAlive(other)
end
esCuchillo = function(tool)
    if not tool or not tool:IsA("Tool") then return false end
    if tool:FindFirstChild("Slash") or tool:FindFirstChild("SlashStart") then return true end
    local name = tool.Name:lower()
    return name:find("knife", 1, true) ~= nil or name:find("cuchillo", 1, true) ~= nil
        or name:find("dagger", 1, true) ~= nil
end
esPistola = function(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local beam = tool:FindFirstChild("showBeam")
    return beam ~= nil and beam:IsA("RemoteEvent")
end
obtenerPistola = function()
    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if esPistola(tool) then return tool end
        end
    end
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if esPistola(tool) then return tool end
        end
    end
    return nil
end
end

getgenv().RoxHubAutoEventFarm = false

task.spawn(function()
    local Networking, RemoteFarm
    while task.wait(0.05) do
        if not getgenv().RoxHubAutoEventFarm then continue end
        pcall(function()
            if not RemoteFarm then
                Networking = ReplicatedStorage:FindFirstChild("Packages")
                Networking = Networking and Networking:FindFirstChild("Networking")
                RemoteFarm = Networking and Networking:FindFirstChild("RE/Events/CollectEventSpawnable")
            end
            if RemoteFarm then RemoteFarm:FireServer() end
        end)
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local container = workspace:FindFirstChild("SpawnablesClient")
            if container then
                for _, obj in ipairs(container:GetChildren()) do
                    if not getgenv().RoxHubAutoEventFarm then break end
                    local touchPart = obj:FindFirstChild("Touch")
                    if touchPart then
                        pcall(function()
                            firetouchinterest(hrp, touchPart, 0)
                            firetouchinterest(hrp, touchPart, 1)
                        end)
                    end
                end
            end
        end
    end
end)

local KILLALL_MOVE_SPEED               = 39.9
local KILLALL_APPROACH_DISTANCE        = 2.5
local KILLALL_APPROACH_TOLERANCE       = 0.35
local KILLALL_SWING_INTERVAL           = 0.5
local KILLALL_SAFE_GROUND_THRESHOLD    = 3
local KILLALL_STICK_MAX_TIME           = 2.5
local KILLALL_STICK_MAX_DISTANCE       = 20
local KILLALL_VOID_PROTECTION          = 15
local KILLALL_HEALTH_STALL_TIME        = 1.5
local KILLALL_TARGET_GRACE_TIME        = 1.2
local KILLALL_PITCH_DEGREES            = 90
local KILLALL_HEIGHT_OFFSET            = 1.9
local KILLALL_HIDE_DEPTH               = 4
local KILLALL_HIDE_DURATION            = 0.5
local KILLALL_KNIFE_RANGE_Y            = 4.5
local KILLALL_PREDICTION_TIME          = 0.08
local KILLALL_JITTER_AMPLITUDE         = 0.8
local KILLALL_JITTER_SWITCH_MIN        = 0.05
local KILLALL_JITTER_SWITCH_MAX        = 0.12
local KILLALL_JITTER_LERP_SPEED        = 25
local KILLALL_UNDERGROUND_DEPTH        = 5
local KILLALL_UNDERGROUND_TOLERANCE    = 1.5
local KILLALL_TRIGGER_RADIUS           = 6.0
local KILLALL_VALIDATION_TOLERANCE     = 1.0
local KILLALL_VALIDATION_FRAMES        = 3

local RoxConnectionManager = {}
RoxConnectionManager.__index = RoxConnectionManager
function RoxConnectionManager.new() return setmetatable({ Items = {} }, RoxConnectionManager) end
function RoxConnectionManager:Add(task) self.Items[#self.Items + 1] = task; return task end
function RoxConnectionManager:Cleanup()
    for i = #self.Items, 1, -1 do
        local item = self.Items[i]
        self.Items[i] = nil
        local t = typeof(item)
        if t == "RBXScriptConnection" then pcall(function() item:Disconnect() end)
        elseif t == "Instance" then pcall(function() item:Destroy() end)
        elseif t == "function" then pcall(item) end
    end
end

local RoxKillAll = {}
RoxKillAll.__index = RoxKillAll

function RoxKillAll.new()
    return setmetatable({
        running = false,
        connections = RoxConnectionManager.new(),
        savedCollisions = {},
        swingAccumulator = 0,
        safePosition = nil,
        sticking = false,
        stickingStartTime = 0,
        lastEnemyHealth = nil,
        lastHealthChangeTime = 0,
        lastTargetSeenTime = 0,
        currentTarget = nil,
        lockedTargetPlayer = nil,
        lastStickTarget = nil,
        lastStickTargetHum = nil,
        hiding = false,
        hidingUntil = 0,
        targetFloor = nil,
        targetFloorY = nil,
        lastFloorTarget = nil,
        inKnifeRangeNow = false,
        forceDescent = false,
        jitterSide = 1,
        jitterCurrent = 0,
        jitterNextSwitch = 0,
        lastSetCFrame = nil,
        validFrames = 0,
        killActivated = false,
    }, RoxKillAll)
end

function RoxKillAll:DisableCollisions()
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            if self.savedCollisions[part] == nil then
                self.savedCollisions[part] = part.CanCollide
            end
            part.CanCollide = false
        end
    end
end

function RoxKillAll:RestoreCollisions()
    for part, value in pairs(self.savedCollisions) do
        if part.Parent then
            pcall(function() part.CanCollide = value end)
        end
    end
    table.clear(self.savedCollisions)
end

function RoxKillAll:GetRoot(p)
    local char = p and p.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then return root end
    return nil
end

function RoxKillAll:GetHumanoid(p)
    local char = p and p.Character
    return char and char:FindFirstChildOfClass("Humanoid") or nil
end

function RoxKillAll:GetFloorY(targetRoot)
    local hum = targetRoot.Parent and targetRoot.Parent:FindFirstChildOfClass("Humanoid")
    local hip = hum and tonumber(hum.HipHeight) or 2
    return targetRoot.Position.Y - hip - targetRoot.Size.Y / 2
end

function RoxKillAll:GetPlatformFloorY(targetRoot)
    if not targetRoot then return nil end
    if self.lastFloorTarget == targetRoot and self.targetFloorY then
        return self.targetFloorY
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { player.Character, targetRoot.Parent }
    local origin = targetRoot.Position + Vector3.new(0, 3, 0)
    local result = workspace:Raycast(origin, Vector3.new(0, -500, 0), params)
    if result then
        self.targetFloorY = result.Position.Y
        self.lastFloorTarget = targetRoot
        return self.targetFloorY
    end
    self.targetFloorY = self:GetFloorY(targetRoot)
    self.lastFloorTarget = targetRoot
    return self.targetFloorY
end

function RoxKillAll:IsInKnifeRange(myRoot, targetRoot)
    if not myRoot or not targetRoot then return false end
    local delta = targetRoot.Position - myRoot.Position
    local horizontal = Vector3.new(delta.X, 0, delta.Z).Magnitude
    local vertical = math.abs(delta.Y)
    return horizontal <= (KILLALL_APPROACH_DISTANCE + KILLALL_APPROACH_TOLERANCE) and vertical <= KILLALL_KNIFE_RANGE_Y
end

function RoxKillAll:IsLockedTargetValid()
    local lp = self.lockedTargetPlayer
    if not lp then return false end
    if not lp.Parent then return false end
    if not esEnemigoValido(lp) then return false end
    local char = lp.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return false end
    if hum.Health <= 0 then return false end
    return root
end

function RoxKillAll:GetClosestEnemy()
    local myRoot = self:GetRoot(player)
    if not myRoot then return nil end
    local lockedRoot = self:IsLockedTargetValid()
    if lockedRoot then return lockedRoot end
    self.lockedTargetPlayer = nil
    self.currentTarget = nil
    local best, bestDist, bestPlayer = nil, nil, nil
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= player and esEnemigoValido(other) then
            local hum = self:GetHumanoid(other)
            local root = self:GetRoot(other)
            if root and hum and hum.Health > 0 then
                local dist = (root.Position - myRoot.Position).Magnitude
                if not bestDist or dist < bestDist then
                    best, bestDist, bestPlayer = root, dist, other
                end
            end
        end
    end
    if bestPlayer then self.lockedTargetPlayer = bestPlayer end
    return best
end

function RoxKillAll:IsInMatch() return IsInMatchStrict() end

function RoxKillAll:ResetState()
    self.sticking = false
    self.stickingStartTime = 0
    self.lastEnemyHealth = nil
    self.lastHealthChangeTime = 0
    self.targetFloor = nil
    self.inKnifeRangeNow = false
    self.forceDescent = false
    self.jitterSide = 1
    self.jitterCurrent = 0
    self.jitterNextSwitch = 0
    self.lastSetCFrame = nil
    self.validFrames = 0
    self.killActivated = false
    self:RestoreCollisions()
    local hum = self:GetHumanoid(player)
    if hum and hum.PlatformStand then pcall(function() hum.PlatformStand = false end) end
end

function RoxKillAll:ReturnToSafePosition(myRoot)
    if not self.safePosition or not myRoot then return end
    if myRoot.Position.Y < (self.safePosition.Y - KILLALL_SAFE_GROUND_THRESHOLD) then
        pcall(function()
            myRoot.CFrame = CFrame.new(self.safePosition)
            myRoot.AssemblyLinearVelocity  = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
        end)
    end
end

function RoxKillAll:ForceReturnToSafe(myRoot)
    if not self.safePosition or not myRoot then return end
    pcall(function()
        myRoot.CFrame = CFrame.new(self.safePosition)
        myRoot.AssemblyLinearVelocity  = Vector3.zero
        myRoot.AssemblyAngularVelocity = Vector3.zero
    end)
end

function RoxKillAll:IsFallingIntoVoid(myRoot)
    if not self.safePosition or not myRoot then return false end
    return myRoot.Position.Y < (self.safePosition.Y - KILLALL_VOID_PROTECTION)
end

function RoxKillAll:HideBelowMap()
    local myRoot = self:GetRoot(player)
    if not myRoot then return end
    local baseY = self.safePosition and self.safePosition.Y or myRoot.Position.Y
    local hideY = baseY - KILLALL_HIDE_DEPTH
    local x, z = myRoot.Position.X, myRoot.Position.Z
    pcall(function()
        myRoot.CFrame = CFrame.new(x, hideY, z)
        myRoot.AssemblyLinearVelocity  = Vector3.zero
        myRoot.AssemblyAngularVelocity = Vector3.zero
    end)
    self.hiding = true
    self.hidingUntil = os.clock() + KILLALL_HIDE_DURATION
end

function RoxKillAll:IsKnife(tool)
    if not (tool and tool:IsA("Tool")) then return false end
    if tool:FindFirstChild("fire") or tool:FindFirstChild("showBeam") then return false end
    return tool:FindFirstChild("Slash") ~= nil or tool:FindFirstChild("SlashStart") ~= nil
end

function RoxKillAll:FindKnife()
    local char = player.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if self:IsKnife(child) then return child, true end
        end
    end
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if self:IsKnife(child) then return child, false end
        end
    end
    return nil, false
end

function RoxKillAll:SwingKnife(dt)
    self.swingAccumulator = self.swingAccumulator + dt
    if self.swingAccumulator < KILLALL_SWING_INTERVAL then return end
    self.swingAccumulator = 0
    local tool, equipped = self:FindKnife()
    if not tool then return end
    if not equipped then
        local hum = self:GetHumanoid(player)
        if not hum then return end
        pcall(function() hum:EquipTool(tool) end)
        if tool.Parent ~= player.Character then return end
    end
    pcall(function() tool:Activate() end)
end

function RoxKillAll:UpdateJitter(dt)
    local now = os.clock()
    if now >= self.jitterNextSwitch then
        self.jitterSide = (math.random() < 0.5) and 1 or -1
        self.jitterNextSwitch = now + KILLALL_JITTER_SWITCH_MIN + math.random() * (KILLALL_JITTER_SWITCH_MAX - KILLALL_JITTER_SWITCH_MIN)
    end
    local targetOffset = self.jitterSide * KILLALL_JITTER_AMPLITUDE
    self.jitterCurrent = self.jitterCurrent + (targetOffset - self.jitterCurrent) * math.clamp(dt * KILLALL_JITTER_LERP_SPEED, 0, 1)
end

function RoxKillAll:CheckServerValidation(myRoot)
    if self.killActivated then return true end
    if not self.lastSetCFrame then return false end
    local diff = (myRoot.Position - self.lastSetCFrame.Position).Magnitude
    if diff <= KILLALL_VALIDATION_TOLERANCE then
        self.validFrames = self.validFrames + 1
        if self.validFrames >= KILLALL_VALIDATION_FRAMES then
            self.killActivated = true
            self.swingAccumulator = KILLALL_SWING_INTERVAL
            return true
        end
    else
        self.validFrames = 0
    end
    return false
end

function RoxKillAll:ForceUnderground(myRoot, targetRoot)
    if not myRoot or not targetRoot then return end
    local floorY = self:GetPlatformFloorY(targetRoot)
    if not floorY then return end
    local targetY = floorY - KILLALL_UNDERGROUND_DEPTH
    if myRoot.Position.Y > targetY + KILLALL_UNDERGROUND_TOLERANCE then
        pcall(function()
            myRoot.CFrame = CFrame.new(myRoot.Position.X, targetY, myRoot.Position.Z)
            myRoot.AssemblyLinearVelocity  = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
        end)
    end
end

function RoxKillAll:ApproachTarget(myRoot, targetRoot, dt)
    dt = dt or 0
    local myPos = myRoot.Position
    local targetPos = targetRoot.Position
    local deltaXZ = Vector3.new(targetPos.X - myPos.X, 0, targetPos.Z - myPos.Z)
    local hDist = deltaXZ.Magnitude

    if hDist <= KILLALL_TRIGGER_RADIUS then
        if not self.sticking then
            local lookTarget = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
            local targetCF = CFrame.lookAt(myPos, lookTarget)
            self.lastSetCFrame = targetCF
            pcall(function()
                myRoot.CFrame = targetCF
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
            end)
            if self:CheckServerValidation(myRoot) then
                self.sticking = true
                self.stickingStartTime = os.clock()
                self.lastStickTarget = targetRoot
                self.targetFloor = nil
                self.forceDescent = true
                local hum = self:GetHumanoid(targetRoot.Parent)
                self.lastEnemyHealth = hum and hum.Health or nil
                self.lastHealthChangeTime = os.clock()
                self.lastStickTargetHum = hum
                self.jitterCurrent = 0
            end
        end
        return
    end

    self.lastSetCFrame = nil
    self.validFrames = 0
    local dir = deltaXZ.Unit
    local perp = Vector3.new(-dir.Z, 0, dir.X)
    self:UpdateJitter(dt)
    local step = KILLALL_MOVE_SPEED * dt
    local travel = math.min(step, math.max(0, hDist - KILLALL_TRIGGER_RADIUS))
    local maxJitterByDistance = math.sqrt(math.max(0, travel * (2 * hDist - travel))) * 0.85
    local jitterFactor = math.clamp((hDist - KILLALL_TRIGGER_RADIUS) / 8, 0, 1)
    local desiredJitter = self.jitterCurrent * jitterFactor
    local actualJitter = math.clamp(desiredJitter, -maxJitterByDistance, maxJitterByDistance)

    local baseX = myPos.X + dir.X * travel
    local baseZ = myPos.Z + dir.Z * travel
    local newX = baseX + perp.X * actualJitter
    local newZ = baseZ + perp.Z * actualJitter

    local floorY = self:GetPlatformFloorY(targetRoot)
    local newY
    if floorY then newY = floorY - KILLALL_UNDERGROUND_DEPTH else newY = myP
... (Restantes: 82 KB)
