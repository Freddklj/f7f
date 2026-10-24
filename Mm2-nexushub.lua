local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ConfigFileName = "NexusHub_MM2_Config.json"
local CustomSoundId = "rbxassetid://4499400560"

local DefaultConfig = {
    SilentAim = false,
    GunSilentAim = false,
    KnifeSilentAim = false,
    LeadShot = false,
    WallCheck = false,
    
    HitboxExpand = false,
    HitboxSize = 4,
    HitboxVisible = false,
    
    KnifeHoming = false,     
    KnifeTriggerDist = 25,
    KnifeAura = false,
    KnifeAuraDist = 15,
    KnifeLegitMode = false,
    
    NotifyRoles = false,
    NotifyGunPickup = false,
    NotifyGunDrop = false,
    
    WalkSpeedEnabled = false,
    WalkSpeedValue = 24,
    JumpPowerEnabled = false,
    JumpPowerValue = 80,
    
    AntiFling = false,
    SecondLife = false,
    
    AutoGrabGun = false,
    ShowGrabBtn = false,
    GrabDistance = 15,

    ShowInvisBtn = false,
    
    DesyncEnabled = false,
    ShowDesyncBtn = false,
    
    AntiSilentAim = false,
    AntiSilentAimKey = "X",
    
    Murder_Fill = false, Murder_Outline = false, Murder_Tracer = false, Murder_Name = false, Murder_Dist = false,
    Sheriff_Fill = false, Sheriff_Outline = false, Sheriff_Tracer = false, Sheriff_Name = false, Sheriff_Dist = false,
    Hero_Fill = false, Hero_Outline = false, Hero_Tracer = false, Hero_Name = false, Hero_Dist = false,
    Innocent_Fill = false, Innocent_Outline = false, Innocent_Tracer = false, Innocent_Name = false, Innocent_Dist = false,
    Lobby_Fill = false, Lobby_Outline = false, Lobby_Tracer = false, Lobby_Name = false, Lobby_Dist = false,
    Gun_Fill = false, Gun_Outline = false, Gun_Name = false, Gun_Dist = false, Gun_Tracer = false,
    
    FillTransparency = 0.5,
    OutlineTransparency = 0,
    
    InstantRole = false,
    AntiLag = false,
    DisableFootstep = false,
    ShowRoundTimer = false,
    
    FlingSheriff = false,
    FlingMurderer = false,
    FlingHero = false,
    FlingAll = false,
    
    CoinsReach = false,
    AutoFarmCoins = false,
    
    CoinsRemove = false,
    OptimizerCoins = false,
    
    CustomTheme = "Original",
    
    GamepadEnabled = false,
    SilentAimKey = "ButtonR2",
    InvisibleKey = "ButtonY",
    GrabGunKey = "ButtonB",
    
    AutoPrankBomb = false,
    
    GuiPositions = {}
}

local function DeepCopy(orig)
    local copy = {}
    if type(orig) == 'table' then
        for orig_key, orig_value in next, orig, nil do
            copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
        end
    else
        copy = orig
    end
    return copy
end

local Config = DeepCopy(DefaultConfig)

local Themes = {
    Original = {
        Background = Color3.fromRGB(15, 15, 20),
        Sidebar = Color3.fromRGB(20, 20, 25),
        Accent = Color3.fromRGB(0, 170, 255),
        AccentDark = Color3.fromRGB(0, 80, 150),
        Ghost = Color3.fromRGB(140, 50, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(30, 30, 35),
        InputBG = Color3.fromRGB(10, 10, 15)
    },
    Red = {
        Background = Color3.fromRGB(20, 15, 15),
        Sidebar = Color3.fromRGB(25, 20, 20),
        Accent = Color3.fromRGB(255, 0, 0),
        AccentDark = Color3.fromRGB(150, 0, 0),
        Ghost = Color3.fromRGB(255, 50, 140),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(35, 30, 30),
        InputBG = Color3.fromRGB(15, 10, 10)
    },
    Blue = {
        Background = Color3.fromRGB(15, 15, 20),
        Sidebar = Color3.fromRGB(20, 20, 25),
        Accent = Color3.fromRGB(0, 100, 255),
        AccentDark = Color3.fromRGB(0, 50, 150),
        Ghost = Color3.fromRGB(50, 140, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(30, 30, 35),
        InputBG = Color3.fromRGB(10, 10, 15)
    },
    Verde = {
        Background = Color3.fromRGB(15, 20, 15),
        Sidebar = Color3.fromRGB(20, 25, 20),
        Accent = Color3.fromRGB(0, 255, 0),
        AccentDark = Color3.fromRGB(0, 150, 0),
        Ghost = Color3.fromRGB(140, 255, 50),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(30, 35, 30),
        InputBG = Color3.fromRGB(10, 15, 10)
    },
    Purple = {
        Background = Color3.fromRGB(20, 15, 20),
        Sidebar = Color3.fromRGB(25, 20, 25),
        Accent = Color3.fromRGB(170, 0, 255),
        AccentDark = Color3.fromRGB(80, 0, 150),
        Ghost = Color3.fromRGB(200, 50, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(35, 30, 35),
        InputBG = Color3.fromRGB(15, 10, 15)
    },
    Yellow = {
        Background = Color3.fromRGB(20, 20, 15),
        Sidebar = Color3.fromRGB(25, 25, 20),
        Accent = Color3.fromRGB(255, 255, 0),
        AccentDark = Color3.fromRGB(150, 150, 0),
        Ghost = Color3.fromRGB(255, 255, 50),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(35, 35, 30),
        InputBG = Color3.fromRGB(15, 15, 10)
    },
    Branco = {
        Background = Color3.fromRGB(240, 240, 240),
        Sidebar = Color3.fromRGB(220, 220, 220),
        Accent = Color3.fromRGB(0, 120, 255),
        AccentDark = Color3.fromRGB(0, 80, 200),
        Ghost = Color3.fromRGB(100, 100, 100),
        Text = Color3.fromRGB(0, 0, 0),
        TextDim = Color3.fromRGB(80, 80, 80),
        ItemBG = Color3.fromRGB(200, 200, 200),
        InputBG = Color3.fromRGB(180, 180, 180)
    },
    Preto = {
        Background = Color3.fromRGB(10, 10, 10),
        Sidebar = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(255, 255, 255),
        AccentDark = Color3.fromRGB(150, 150, 150),
        Ghost = Color3.fromRGB(100, 100, 100),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        ItemBG = Color3.fromRGB(30, 30, 30),
        InputBG = Color3.fromRGB(20, 20, 20)
    }
}

local function LoadConfigDataOnly()
    if isfile and isfile(ConfigFileName) then
        local content = readfile(ConfigFileName)
        local success, decoded = pcall(function() return HttpService:JSONDecode(content) end)
        if success and decoded then 
            for key, value in pairs(decoded) do 
                if key ~= "GuiPositions" then
                    if Config[key] ~= nil then 
                        Config[key] = value 
                    end
                else
                    Config.GuiPositions = value or {}
                end
            end
        end
    end
end

LoadConfigDataOnly()

local RoleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),
    Sheriff = Color3.fromRGB(0, 0, 255),
    Hero = Color3.fromRGB(255, 255, 0),
    Innocent = Color3.fromRGB(0, 255, 0),
    Lobby = Color3.fromRGB(150, 150, 150),
    Gun = Color3.fromRGB(255, 255, 255)
}

local Theme
if Config.CustomTheme and Themes[Config.CustomTheme] then
    Theme = Themes[Config.CustomTheme]
else
    Config.CustomTheme = "Original"
    Theme = Themes.Original
end

local foundGunDrop = nil
local RoleCache = {} 
local tabs = {} 
local lastMyRole = "FORCE_RESET" 
local rolesNotified = false
local playerDataRemote = nil
local ShootGui, GrabFrame, InvisFrame, DesyncFrame, ToggleButton, MainFrame, ShootButton
local InvisActive = false
local FirstRow, SecondRow, ThirdRow

local desync_on = false
local ghostPart = nil
local desyncChair = nil
local desyncWeld = nil

local flingActive = false
local flingAllActive = false
local flingTargetPlayer = nil
local flingThread = nil
local flingInProgress = false

local closesthitpart = nil
local closestKnifePart = nil
local knifeEquipped = false
local murder = nil
local originalKnifeThrown = nil

local coinOrig = {}
local coinReachConn = nil
local autoFarmCoinsRunning = false
local autoFarmCoinsThread = nil

local coinsRemoveConn = nil
local optimizerCoinsConn = nil

local footstepConnection = nil
local roundTimerGui = nil
local roundTimerConnection = nil

local gamepadConnections = {}
local gamepadActive = false
local keyCodes = {
    ButtonR2 = Enum.KeyCode.ButtonR2,
    ButtonY = Enum.KeyCode.ButtonY,
    ButtonB = Enum.KeyCode.ButtonB,
    ButtonA = Enum.KeyCode.ButtonA,
    ButtonX = Enum.KeyCode.ButtonX,
    ButtonL2 = Enum.KeyCode.ButtonL2,
    ButtonR1 = Enum.KeyCode.ButtonR1,
    ButtonL1 = Enum.KeyCode.ButtonL1,
    DPadUp = Enum.KeyCode.DPadUp,
    DPadDown = Enum.KeyCode.DPadDown,
    DPadLeft = Enum.KeyCode.DPadLeft,
    DPadRight = Enum.KeyCode.DPadRight
}

local isRTPressed = false
local lastRTInputTime = 0
local rtHoldDuration = 0

local secondLifeConnection = nil

local notifyOrder = 0

local gunTracerLine = nil
local desyncTracerLine = nil

local prankBombConnection = nil

local antiSilentAimData = {
    savedCFrame = nil,
    savedVelocity = nil
}

if _G.NexusHubLoaded then
    if CoreGui:FindFirstChild("NexusHubMain") then CoreGui.NexusHubMain:Destroy() end
    if CoreGui:FindFirstChild("ShootGui_Overlay_V19") then CoreGui.ShootGui_Overlay_V19:Destroy() end
    if CoreGui:FindFirstChild("NexusRoleAlert") then CoreGui.NexusRoleAlert:Destroy() end
    if CoreGui:FindFirstChild("NexusTracersGui") then CoreGui.NexusTracersGui:Destroy() end
    if CoreGui:FindFirstChild("NexusNotifyContainer") then CoreGui.NexusNotifyContainer:Destroy() end
    if CoreGui:FindFirstChild("NexusGrabGunBtn") then CoreGui.NexusGrabGunBtn:Destroy() end
    if CoreGui:FindFirstChild("NexusInvisBtn") then CoreGui.NexusInvisBtn:Destroy() end
    if CoreGui:FindFirstChild("NexusDesyncBtn") then CoreGui.NexusDesyncBtn:Destroy() end
    if CoreGui:FindFirstChild("NexusRoundTimer") then CoreGui.NexusRoundTimer:Destroy() end
end
_G.NexusHubLoaded = true

local function AddCorner(instance, radius) 
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
    return corner 
end

local function AddStroke(instance, color, thickness) 
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = instance
    return stroke 
end

local function PlayClickSound()
    task.spawn(function()
        local s = Instance.new("Sound")
        s.Name = "NexusClickSound"
        s.SoundId = CustomSoundId
        s.Volume = 1
        s.Parent = CoreGui
        s:Play()
        s.Ended:Connect(function()
            s:Destroy()
        end)
    end)
end

local function MakeDraggableCornersOnly(frame)
    local dragging, dragInput, dragStart, startPos
    
    local cornerSize = 20
    
    local function createCornerDetector(position, size)
        local detector = Instance.new("Frame")
        detector.Name = "DragCorner_" .. position
        detector.Size = UDim2.new(0, size, 0, size)
        detector.BackgroundTransparency = 1
        detector.ZIndex = frame.ZIndex + 1
        detector.Parent = frame
        
        if position == "TopLeft" then
            detector.Position = UDim2.new(0, 0, 0, 0)
        elseif position == "TopRight" then
            detector.Position = UDim2.new(1, -size, 0, 0)
        elseif position == "BottomLeft" then
            detector.Position = UDim2.new(0, 0, 1, -size)
        elseif position == "BottomRight" then
            detector.Position = UDim2.new(1, -size, 1, -size)
        end
        
        return detector
    end
    
    local topLeftDetector = createCornerDetector("TopLeft", cornerSize)
    local topRightDetector = createCornerDetector("TopRight", cornerSize)
    local bottomLeftDetector = createCornerDetector("BottomLeft", cornerSize)
    local bottomRightDetector = createCornerDetector("BottomRight", cornerSize)
    
    local function startDragging(input)
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
    
    local detectors = {topLeftDetector, topRightDetector, bottomLeftDetector, bottomRightDetector}
    
    for _, detector in ipairs(detectors) do
        detector.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                PlayClickSound()
                startDragging(input)
            end
        end)
    end
    
    for _, detector in ipairs(detectors) do
        detector.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
    end
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function MakeDraggable(frame, trigger)
    trigger = trigger or frame
    local dragging, dragInput, dragStart, startPos
    trigger.InputBegan:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function() 
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end 
            end) 
        end 
    end)
    trigger.InputChanged:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
            dragInput = input 
        end 
    end)
    UserInputService.InputChanged:Connect(function(input) 
        if dragging and input == dragInput then 
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end 
    end)
end

local function ApplyThemeToGUI()
    if MainFrame then
        MainFrame.BackgroundColor3 = Theme.Background
        local mainStroke = MainFrame:FindFirstChildOfClass("UIStroke")
        if mainStroke then
            mainStroke.Color = Theme.Accent
        end
    end
    
    if Sidebar then
        Sidebar.BackgroundColor3 = Theme.Sidebar
    end
    
    if TitleLabel then
        TitleLabel.TextColor3 = Theme.Accent
    end
    
    for _, tab in ipairs(tabs) do
        if tab.Btn then
            tab.Btn.BackgroundColor3 = Theme.Background
            tab.Btn.TextColor3 = Theme.TextDim
            if tab.Frame and tab.Frame.Visible then
                tab.Btn.BackgroundColor3 = Theme.AccentDark
                tab.Btn.TextColor3 = Theme.Text
            end
        end
    end
    
    if ShootButton then
        ShootButton.BackgroundColor3 = Theme.Background
        ShootButton.TextColor3 = Theme.Accent
        local shootStroke = ShootButton:FindFirstChildOfClass("UIStroke")
        if shootStroke then
            shootStroke.Color = Theme.Accent
            local gradient = shootStroke:FindFirstChildOfClass("UIGradient")
            if gradient then
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Theme.Accent),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1.00, Theme.Accent)
                }
            end
        end
    end
    
    if GrabFrame then
        GrabFrame.BackgroundColor3 = Theme.Background
        local grabStroke = GrabFrame:FindFirstChildOfClass("UIStroke")
        if grabStroke then
            grabStroke.Color = Theme.Accent
        end
    end
    
    if GrabBtn then
        GrabBtn.TextColor3 = Theme.Accent
    end
    
    if InvisFrame then
        InvisFrame.BackgroundColor3 = Theme.Background
        local invisStroke = InvisFrame:FindFirstChildOfClass("UIStroke")
        if invisStroke then
            invisStroke.Color = Theme.Ghost
        end
    end
    
    if InvisBtn then
        InvisBtn.TextColor3 = Theme.Ghost
    end
    
    if DesyncFrame then
        DesyncFrame.BackgroundColor3 = Theme.Background
        local desyncStroke = DesyncFrame:FindFirstChildOfClass("UIStroke")
        if desyncStroke then
            if desync_on then
                desyncStroke.Color = Color3.fromRGB(0, 255, 150)
            else
                desyncStroke.Color = Theme.Ghost
            end
        end
    end
    
    if DesyncBtn then
        if desync_on then
            DesyncBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
        else
            DesyncBtn.TextColor3 = Theme.Ghost
        end
    end
    
    if NotifyContainer then
        for _, notify in ipairs(NotifyContainer:GetDescendants()) do
            if notify:IsA("TextLabel") and notify.Text == "NEXUS MM2" then
                notify.TextColor3 = Theme.Accent
            elseif notify:IsA("Frame") and notify:FindFirstChildOfClass("UIStroke") then
                notify.BackgroundColor3 = Theme.Sidebar
                local stroke = notify:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Color = Theme.Accent
                end
            end
        end
    end
    
    if FirstRow then
        for _, child in ipairs(FirstRow:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Theme.ItemBG
                child.TextColor3 = Config.CustomTheme == child.Text and Theme.Accent or Theme.TextDim
            end
        end
    end
    
    if SecondRow then
        for _, child in ipairs(SecondRow:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Theme.ItemBG
                child.TextColor3 = Config.CustomTheme == child.Text and Theme.Accent or Theme.TextDim
            end
        end
    end
    
    if ThirdRow then
        for _, child in ipairs(ThirdRow:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Theme.ItemBG
                child.TextColor3 = Config.CustomTheme == child.Text and Theme.Accent or Theme.TextDim
            end
        end
    end
    
    if ghostPart then
        local ghostColor = Theme.Ghost
        ghostPart.Color = ghostColor
        local highlight = ghostPart:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight.FillColor = ghostColor
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
        local bbGui = ghostPart:FindFirstChildOfClass("BillboardGui")
        if bbGui then
            local txt = bbGui:FindFirstChildOfClass("TextLabel")
            if txt then
                txt.TextColor3 = ghostColor
            end
        end
    end
end

local function SetTheme(themeName)
    if Themes[themeName] then
        Theme = Themes[themeName]
        Config.CustomTheme = themeName
        ApplyThemeToGUI()
        return true
    end
    return false
end

local function ApplySecondLife(state)
    if state then
        local function setupGodmode(character)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if secondLifeConnection then
                    secondLifeConnection:Disconnect()
                end
                secondLifeConnection = humanoid.HealthChanged:Connect(function()
                    if humanoid.Health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
            end
        end

        if LocalPlayer.Character then
            setupGodmode(LocalPlayer.Character)
        end

        LocalPlayer.CharacterAdded:Connect(function(character)
            task.wait(0.5)
            setupGodmode(character)
        end)
    else
        if secondLifeConnection then
            secondLifeConnection:Disconnect()
            secondLifeConnection = nil
        end
    end
end

local function ApplyDisableFootstep(state)
    if state then
        local function removeFootsteps()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "Footsteps" then
                    obj:Destroy()
                end
            end
        end

        removeFootsteps()

        footstepConnection = Workspace.DescendantAdded:Connect(function(obj)
            if obj.Name == "Footsteps" then
                task.wait(0.1)
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
        end)
    else
        if footstepConnection then
            footstepConnection:Disconnect()
            footstepConnection = nil
        end
    end
end

local function ApplyShowRoundTimer(state)
    if state then
        roundTimerGui = Instance.new("ScreenGui")
        roundTimerGui.Name = "NexusRoundTimer"
        roundTimerGui.Parent = CoreGui
        roundTimerGui.IgnoreGuiInset = true
        roundTimerGui.ResetOnSpawn = false
        roundTimerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local timerFrame = Instance.new("Frame")
        timerFrame.Size = UDim2.new(0, 150, 0, 40)
        timerFrame.Position = UDim2.new(0.5, -75, 0, 20)
        timerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        timerFrame.BackgroundTransparency = 0.5
        timerFrame.BorderSizePixel = 0
        timerFrame.Parent = roundTimerGui
        AddCorner(timerFrame, 6)
        AddStroke(timerFrame, Theme.Accent, 1)

        local timerLabel = Instance.new("TextLabel")
        timerLabel.Size = UDim2.new(1, 0, 1, 0)
        timerLabel.BackgroundTransparency = 1
        timerLabel.Text = "00:00"
        timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        timerLabel.Font = Enum.Font.GothamBlack
        timerLabel.TextSize = 20
        timerLabel.TextStrokeTransparency = 0.5
        timerLabel.Parent = timerFrame

        local function updateTimer()
            local timerPart = Workspace:FindFirstChild("RoundTimerPart")
            if timerPart and timerPart:FindFirstChild("SurfaceGui") then
                local surfaceGui = timerPart.SurfaceGui
                local timerObj = surfaceGui:FindFirstChild("Timer")
                if timerObj and timerObj:IsA("TextLabel") then
                    timerLabel.Text = timerObj.Text
                else
                    timerLabel.Text = "00:00"
                end
            else
                timerLabel.Text = "00:00"
            end
        end

        updateTimer()
        roundTimerConnection = RunService.Heartbeat:Connect(updateTimer)
    else
        if roundTimerConnection then
            roundTimerConnection:Disconnect()
            roundTimerConnection = nil
        end
        if roundTimerGui then
            roundTimerGui:Destroy()
            roundTimerGui = nil
        end
    end
end

local NotifyContainer = Instance.new("ScreenGui")
NotifyContainer.Name = "NexusNotifyContainer"
NotifyContainer.Parent = CoreGui
NotifyContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotifyContainer.IgnoreGuiInset = true

local NotifyList = Instance.new("Frame")
NotifyList.Size = UDim2.new(0, 300, 1, 0)
NotifyList.AnchorPoint = Vector2.new(0, 0)
NotifyList.Position = UDim2.new(0, 20, 0.8, 0)
NotifyList.BackgroundTransparency = 1
NotifyList.Parent = NotifyContainer

local NotifyLayout = Instance.new("UIListLayout")
NotifyLayout.Parent = NotifyList
NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Top
NotifyLayout.Padding = UDim.new(0, 8)

local function NexusNotify(title, text, duration)
    notifyOrder = notifyOrder - 1

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 60)
    Frame.BackgroundColor3 = Theme.Sidebar
    Frame.BackgroundTransparency = 0.1
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = notifyOrder
    Frame.Parent = NotifyList
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = Frame
    Stroke.Color = Theme.Accent
    Stroke.Thickness = 1.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame
    
    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Parent = Frame
    TitleLbl.Size = UDim2.new(1, -10, 0, 20)
    TitleLbl.Position = UDim2.new(0, 10, 0, 5)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title
    TitleLbl.Font = Enum.Font.GothamBlack
    TitleLbl.TextColor3 = Theme.Accent
    TitleLbl.TextSize = 14
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local MsgLbl = Instance.new("TextLabel")
    MsgLbl.Parent = Frame
    MsgLbl.Size = UDim2.new(1, -10, 0, 30)
    MsgLbl.Position = UDim2.new(0, 10, 0, 25)
    MsgLbl.BackgroundTransparency = 1
    MsgLbl.Text = text
    MsgLbl.Font = Enum.Font.GothamSemibold
    MsgLbl.TextColor3 = Theme.Text
    MsgLbl.TextSize = 12
    MsgLbl.TextXAlignment = Enum.TextXAlignment.Left
    MsgLbl.TextWrapped = true
    
    Frame.BackgroundTransparency = 1
    TitleLbl.TextTransparency = 1
    MsgLbl.TextTransparency = 1
    Stroke.Transparency = 1
    
    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(TitleLbl, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(MsgLbl, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    
    task.delay(duration or 3, function()
        if Frame then
            TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(TitleLbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            TweenService:Create(MsgLbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
            task.wait(0.3)
            Frame:Destroy()
        end
    end)
end

local function GetLeadShotPosition(targetRootPart)
    local currentPos = targetRootPart.Position
    if Config.LeadShot then 
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
        currentPos = currentPos + (targetRootPart.Velocity * ping * 1.5) 
    end
    return currentPos
end

local function PerformSilentAimDirectly()
    if not Config.SilentAim then
        return false
    end
    
    local gun = nil
    
    for _, i in ipairs(LocalPlayer.Character:GetChildren()) do
        if i:IsA("Tool") and (string.find(string.lower(i.Name), "gun") or i.Name == "Revolver") then
            gun = i
            break
        end
    end
    
    if not gun then
        for _, i in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if i:IsA("Tool") and (string.find(string.lower(i.Name), "gun") or i.Name == "Revolver") then
                gun = i
                break
            end
        end
    end
    
    if not gun then
        return false
    end
    
    local targetPlr = nil
    for plrName, role in pairs(RoleCache) do
        if role == "Murderer" then
            targetPlr = Players:FindFirstChild(plrName)
            if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
                break
            else
                targetPlr = nil
            end
        end
    end
    
    if not targetPlr or not targetPlr.Character or not targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    if Config.WallCheck then
        local origin = Camera.CFrame.Position
        local targetPosRaw = targetPlr.Character.HumanoidRootPart.Position
        local direction = (targetPosRaw - origin).Unit * (targetPosRaw - origin).Magnitude
        
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, targetPlr.Character, workspace:FindFirstChild("GunDrop")}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        
        if workspace:Raycast(origin, direction, rayParams) then
            return false
        end
    end
    
    local wasInBackpack = (gun.Parent == LocalPlayer.Backpack)
    if wasInBackpack then
        LocalPlayer.Character.Humanoid:EquipTool(gun)
        task.wait(0.1)
    end
    
    local targetRoot = targetPlr.Character.HumanoidRootPart
    local targetPos = GetLeadShotPosition(targetRoot)
    
    local args = {CFrame.new(Camera.CFrame.Position, targetPos), CFrame.new(targetPos)}
    
    if gun:FindFirstChild("Shoot") then
        gun.Shoot:FireServer(unpack(args))
        
        if wasInBackpack and gun.Parent == LocalPlayer.Character then
            gun.Parent = LocalPlayer.Backpack
        end
        return true
    end
    
    return false
end

local function getGunTarget()
    if not Config.GunSilentAim then return nil end
    
    local myRole = RoleCache[LocalPlayer.Name]
    if myRole ~= "Sheriff" and myRole ~= "Hero" then
        return nil
    end
    
    for plrName, role in pairs(RoleCache) do
        if role == "Murderer" then
            local plr = Players:FindFirstChild(plrName)
            if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local humanoidrootpart = plr.Character.HumanoidRootPart
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                
                if humanoidrootpart and humanoid and humanoid.Health > 0 then
                    return humanoidrootpart
                end
            end
        end
    end
    
    return nil
end

local function hasKnife(player)
    if not player or not player.Character then return false end
    
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if name:find("knife") or name:find("fac") or name == "knife" or name == "murder knife" then
                return true
            end
        end
    end
    
    for _, item in pairs(player.Character:GetChildren()) do
        if item:IsA("Tool") then
            local name = item.Name:lower()
            if name:find("knife") or name:find("fac") or name == "knife" or name == "murder knife" then
                return true
            end
        end
    end
    
    return false
end

local function detectMurder()
    while true do
        task.wait(1)
        
        local foundMurder = nil
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and hasKnife(player) then
                foundMurder = player
                break
            end
        end
        
        murder = foundMurder
    end
end

local function getdirection(origin, position)
    return (position - origin).Unit
end

local function getclosestplayer()
    if not Config.KnifeSilentAim then return nil end
    if not knifeEquipped then return nil end

    local viewportSize = Camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)

    local closestpart = nil
    local closestdistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player ~= murder and player.Character then
            local humanoidrootpart = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")

            if humanoidrootpart and humanoid and humanoid.Health > 0 then
                local screenpos, onscreen = Camera:WorldToViewportPoint(humanoidrootpart.Position)

                if onscreen then
                    local distance = (Vector2.new(screenpos.X, screenpos.Y) - center).Magnitude

                    if distance < closestdistance then
                        closestdistance = distance
                        closestpart = humanoidrootpart
                    end
                end
            end
        end
    end

    return closestpart
end

local function hookKnifeThrown()
    local character = LocalPlayer.Character
    if not character then return end
    
    local knifeTool = character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    if not knifeTool then return end
    
    local knifeEvents = knifeTool:FindFirstChild("Events")
    if not knifeEvents then return end
    
    local knifeThrownEvent = knifeEvents:FindFirstChild("KnifeThrown")
    if not knifeThrownEvent then return end
    
    if not originalKnifeThrown then
        originalKnifeThrown = knifeThrownEvent.FireServer
    end
    
    knifeThrownEvent.FireServer = function(self, ...)
        local args = {...}
        
        if closestKnifePart and knifeEquipped and Config.KnifeSilentAim then
            local targetPos = closestKnifePart.Position
            local characterPos = character:GetPivot().Position
            
            local direction = (targetPos - characterPos).Unit
            
            local newCFrame = CFrame.new(characterPos, characterPos + direction)
            
            if #args >= 1 then
                args[1] = newCFrame
            end
        end
        
        return originalKnifeThrown(self, unpack(args))
    end
end

local oldnamecall
oldnamecall = hookmetamethod(game, "__namecall", function(...)
    local method = getnamecallmethod()
    local arguments = {...}
    local self = arguments[1]

    if self == workspace and not checkcaller() and method == "Raycast" and Config.GunSilentAim then
        local hitpart = closesthitpart
        
        if hitpart then
            local origin = arguments[2]
            local direction = getdirection(origin, hitpart.Position) * 1000
            arguments[3] = direction
            return oldnamecall(unpack(arguments))
        end
    end
    
    if self == workspace and not checkcaller() and method == "Raycast" and Config.KnifeSilentAim and knifeEquipped then
        local hitpart = closestKnifePart
        
        if hitpart then
            local origin = arguments[2]
            local direction = getdirection(origin, hitpart.Position) * 1000
            arguments[3] = direction
            return oldnamecall(unpack(arguments))
        end
    end

    return oldnamecall(...)
end)

local function PerformGrabGun()
    PlayClickSound()
    
    local gunDrop = Workspace:FindFirstChild("GunDrop") 
    if not gunDrop then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                gunDrop = obj
                break
            end
        end
    end
    
    if gunDrop and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local Root = LocalPlayer.Character.HumanoidRootPart
        gunDrop.CanCollide = false
        gunDrop.CFrame = Root.CFrame + Vector3.new(0, 0, -2)
        gunDrop.Velocity = Vector3.new(0,0,0)
        
        if GrabBtn then
            GrabBtn.Text = "SUCCESS"
            GrabBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
            local grabStroke = GrabFrame:FindFirstChildOfClass("UIStroke")
            if grabStroke then
                grabStroke.Color = Color3.fromRGB(0, 255, 100)
            end
            
            task.delay(0.5, function()
                if GrabBtn then
                    GrabBtn.Text = "GRAB GUN"
                    GrabBtn.TextColor3 = Theme.Accent
                    if grabStroke then
                        grabStroke.Color = Theme.Accent
                    end
                end
            end)
        end
        return true
    else
        return false
    end
end

local function GetKeyCodeFromString(keyString)
    return keyCodes[keyString] or Enum.KeyCode[keyString]
end

local function SetupGamepadControls()
    for _, conn in pairs(gamepadConnections) do
        conn:Disconnect()
    end
    gamepadConnections = {}
    
    if Config.GamepadEnabled then
        local silentAimKey = GetKeyCodeFromString(Config.SilentAimKey)
        if silentAimKey then
            local connBegan = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == silentAimKey then
                    isRTPressed = true
                    lastRTInputTime = tick()
                    rtHoldDuration = 0
                    
                    if Config.SilentAim then
                        PerformSilentAimDirectly()
                    end
                end
            end)
            
            local connEnded = UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == silentAimKey then
                    isRTPressed = false
                    rtHoldDuration = 0
                end
            end)
            
            table.insert(gamepadConnections, connBegan)
            table.insert(gamepadConnections, connEnded)
        end
        
        local invisibleKey = GetKeyCodeFromString(Config.InvisibleKey)
        if invisibleKey then
            local conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == invisibleKey then
                    ToggleInvis()
                end
            end)
            table.insert(gamepadConnections, conn)
        end
        
        local grabGunKey = GetKeyCodeFromString(Config.GrabGunKey)
        if grabGunKey then
            local conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == grabGunKey then
                    PerformGrabGun()
                end
            end)
            table.insert(gamepadConnections, conn)
        end
        
        task.spawn(function()
            while Config.GamepadEnabled do
                if isRTPressed and Config.SilentAim then
                    local currentTime = tick()
                    rtHoldDuration = currentTime - lastRTInputTime
                    
                    if rtHoldDuration > 0.3 then
                        PerformSilentAimDirectly()
                        lastRTInputTime = currentTime
                    end
                end
                task.wait(0.05)
            end
        end)
        
        gamepadActive = true
    else
        gamepadActive = false
        isRTPressed = false
    end
end

local function ApplyCoinsRemove(state)
    if state then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                local coinVisual = obj:FindFirstChild("CoinVisual")
                if coinVisual then
                    coinVisual:Destroy()
                end
                obj:Destroy()
            end
        end
        
        coinsRemoveConn = Workspace.DescendantAdded:Connect(function(obj)
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                task.wait(0.1)
                local coinVisual = obj:FindFirstChild("CoinVisual")
                if coinVisual then
                    coinVisual:Destroy()
                end
                obj:Destroy()
            end
        end)
    else
        if coinsRemoveConn then
            coinsRemoveConn:Disconnect()
            coinsRemoveConn = nil
        end
    end
end

local function ApplyOptimizerCoins(state)
    if state then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                if not obj.Parent then continue end
                obj.Material = Enum.Material.Plastic
                obj.Color = Color3.fromRGB(255, 255, 0)
                if obj:FindFirstChildOfClass("ParticleEmitter") then
                    for _, emitter in ipairs(obj:GetChildren()) do
                        if emitter:IsA("ParticleEmitter") then
                            emitter.Enabled = false
                        end
                    end
                end
            end
        end
        
        optimizerCoinsConn = Workspace.DescendantAdded:Connect(function(obj)
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                task.wait(0.1)
                if not obj.Parent then return end
                obj.Material = Enum.Material.Plastic
                obj.Color = Color3.fromRGB(255, 255, 0)
                if obj:FindFirstChildOfClass("ParticleEmitter") then
                    for _, emitter in ipairs(obj:GetChildren()) do
                        if emitter:IsA("ParticleEmitter") then
                            emitter.Enabled = false
                        end
                    end
                end
            end
        end)
    else
        if optimizerCoinsConn then
            optimizerCoinsConn:Disconnect()
            optimizerCoinsConn = nil
        end
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") then
                if not obj.Parent then continue end
                obj.Material = Enum.Material.Neon
                obj.Color = Color3.fromRGB(255, 215, 0)
                if obj:FindFirstChildOfClass("ParticleEmitter") then
                    for _, emitter in ipairs(obj:GetChildren()) do
                        if emitter:IsA("ParticleEmitter") then
                            emitter.Enabled = true
                        end
                    end
                end
            end
        end
    end
end

local GrabGunGui = Instance.new("ScreenGui")
GrabGunGui.Name = "NexusGrabGunBtn"
GrabGunGui.Parent = CoreGui
GrabGunGui.IgnoreGuiInset = true
GrabGunGui.ResetOnSpawn = false

GrabFrame = Instance.new("Frame")
GrabFrame.Parent = GrabGunGui
GrabFrame.Size = UDim2.new(0, 80, 0, 30)
GrabFrame.Position = UDim2.new(0.7, 0, 0.5, 0)
GrabFrame.BackgroundColor3 = Theme.Background
GrabFrame.BackgroundTransparency = 0.5
GrabFrame.Visible = false
GrabFrame.BorderSizePixel = 0
AddCorner(GrabFrame, 6)
local GrabStroke = AddStroke(GrabFrame, Theme.Accent, 1.5)

local GrabBtn = Instance.new("TextButton")
GrabBtn.Parent = GrabFrame
GrabBtn.Size = UDim2.new(1, 0, 1, 0)
GrabBtn.BackgroundTransparency = 1
GrabBtn.Text = "GRAB GUN"
GrabBtn.TextColor3 = Theme.Accent
GrabBtn.Font = Enum.Font.GothamBlack
GrabBtn.TextSize = 11
GrabBtn.AutoButtonColor = true
GrabBtn.Name = "GrabButtonText"

MakeDraggableCornersOnly(GrabFrame)
GrabBtn.MouseButton1Click:Connect(PerformGrabGun)

local InvisGui = Instance.new("ScreenGui")
InvisGui.Name = "NexusInvisBtn"
InvisGui.Parent = CoreGui
InvisGui.IgnoreGuiInset = true
InvisGui.ResetOnSpawn = false

InvisFrame = Instance.new("Frame")
InvisFrame.Parent = InvisGui
InvisFrame.Size = UDim2.new(0, 80, 0, 30)
InvisFrame.Position = UDim2.new(0.7, 0, 0.6, 0)
InvisFrame.BackgroundColor3 = Theme.Background
InvisFrame.BackgroundTransparency = 0.5
InvisFrame.Visible = false
InvisFrame.BorderSizePixel = 0
AddCorner(InvisFrame, 6)
local InvisStroke = AddStroke(InvisFrame, Theme.Ghost, 1.5)

local InvisBtn = Instance.new("TextButton")
InvisBtn.Parent = InvisFrame
InvisBtn.Size = UDim2.new(1, 0, 1, 0)
InvisBtn.BackgroundTransparency = 1
InvisBtn.Text = "INVISIBLE"
InvisBtn.TextColor3 = Theme.Ghost
InvisBtn.Font = Enum.Font.GothamBlack
InvisBtn.TextSize = 11
InvisBtn.AutoButtonColor = true
MakeDraggableCornersOnly(InvisFrame)

local DesyncGui = Instance.new("ScreenGui")
DesyncGui.Name = "NexusDesyncBtn"
DesyncGui.Parent = CoreGui
DesyncGui.IgnoreGuiInset = true
DesyncGui.ResetOnSpawn = false

DesyncFrame = Instance.new("Frame")
DesyncFrame.Parent = DesyncGui
DesyncFrame.Size = UDim2.new(0, 80, 0, 30)
DesyncFrame.Position = UDim2.new(0.7, 0, 0.7, 0)
DesyncFrame.BackgroundColor3 = Theme.Background
DesyncFrame.BackgroundTransparency = 0.5
DesyncFrame.Visible = false
DesyncFrame.BorderSizePixel = 0
AddCorner(DesyncFrame, 6)
local DesyncStroke = AddStroke(DesyncFrame, Theme.Ghost, 1.5)

local DesyncBtn = Instance.new("TextButton")
DesyncBtn.Parent = DesyncFrame
DesyncBtn.Size = UDim2.new(1, 0, 1, 0)
DesyncBtn.BackgroundTransparency = 1
DesyncBtn.Text = "DESYNC"
DesyncBtn.TextColor3 = Theme.Ghost
DesyncBtn.Font = Enum.Font.GothamBlack
DesyncBtn.TextSize = 11
DesyncBtn.AutoButtonColor = true
MakeDraggableCornersOnly(DesyncFrame)

local FLING_TIMEOUT = 2.5

local function FlingPlayer(targetPlayer)
    flingInProgress = true
    local myChar = LocalPlayer.Character
    if not myChar then flingInProgress = false return end
    local myHum = myChar:FindFirstChildOfClass("Humanoid")
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not (myHum and myRoot) then flingInProgress = false return end

    local targetChar = targetPlayer.Character
    if not targetChar then flingInProgress = false return end
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetHum and targetHum.RootPart
    local targetHead = targetChar:FindFirstChild("Head")
    local accessory = targetChar:FindFirstChildOfClass("Accessory")
    local handle = accessory and accessory:FindFirstChild("Handle")

    local oldPos = myRoot.CFrame

    repeat
        task.wait()
        workspace.CurrentCamera.CameraSubject = targetHead or handle or targetHum
    until workspace.CurrentCamera.CameraSubject == targetHead or handle or targetHum

    local function forcePosition(basePart, offset, angle)
        local targetCF = CFrame.new(basePart.Position) * offset * angle
        myRoot.CFrame = targetCF
        myChar:SetPrimaryPartCFrame(targetCF)
        myRoot.Velocity = Vector3.new(9e7, 9e8, 9e7)
        myRoot.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end

    local function flingBasePart(basePart)
        local start = tick()
        local ang = 0
        repeat
            if myRoot and targetHum then
                ang = ang + 100
                for _, off in ipairs{
                    CFrame.new(0, 1.5, 0),
                    CFrame.new(0, -1.5, 0),
                    CFrame.new(2.25, 1.5, -2.25),
                    CFrame.new(-2.25, -1.5, 2.25)
                } do
                    forcePosition(basePart, off + targetHum.MoveDirection, CFrame.Angles(math.rad(ang), 0, 0))
                    task.wait()
                end
            end
        until basePart.Velocity.Magnitude > 500 or tick() - start > FLING_TIMEOUT
    end

    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlingVelocity"
    bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = myRoot
    myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local targetPart = targetRoot or targetHead or handle
    if targetPart then
        flingBasePart(targetPart)
    end

    bv:Destroy()
    myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

    repeat
        task.wait()
        workspace.CurrentCamera.CameraSubject = myHum
    until workspace.CurrentCamera.CameraSubject == myHum

    repeat
        local cf = oldPos * CFrame.new(0, 0.5, 0)
        myRoot.CFrame = cf
        myChar:SetPrimaryPartCFrame(cf)
        myHum:ChangeState(Enum.HumanoidStateType.GettingUp)
        for _, part in ipairs(myChar:GetChildren()) do
            if part:IsA("BasePart") then
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            end
        end
        task.wait()
    until (myRoot.Position - oldPos.p).Magnitude < 25
    
    flingInProgress = false
end

local function FlingAllLoop()
    flingInProgress = true
    local players = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(players, plr)
        end
    end
    if #players == 0 then flingInProgress = false return end

    local index = 1
    while flingAllActive do
        local target = players[index]
        if target and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
            flingActive = true
            flingTargetPlayer = target
            FlingPlayer(target)
            flingActive = false
        end
        index = index % #players + 1
        task.wait(0.5)
    end
    flingInProgress = false
end

local function StartFling(targetRoleOrPlayer)
    if flingInProgress then
        NexusNotify("FLING", "Aguarde, o fling está em andamento!", 3)
        return
    end
    
    if flingThread then
        task.cancel(flingThread)
        flingThread = nil
    end
    flingActive = false
    flingAllActive = false

    if targetRoleOrPlayer == "all" then
        flingAllActive = true
        flingThread = task.spawn(FlingAllLoop)
    else
        local targetPlayer
        if type(targetRoleOrPlayer) == "string" then
            for plrName, role in pairs(RoleCache) do
                if role == targetRoleOrPlayer then
                    targetPlayer = Players:FindFirstChild(plrName)
                    break
                end
            end
        else
            targetPlayer = targetRoleOrPlayer
        end
        if targetPlayer then
            flingActive = true
            flingTargetPlayer = targetPlayer
            flingThread = task.spawn(FlingPlayer, targetPlayer)
        end
    end
end

local function StopFling()
    flingActive = false
    flingAllActive = false
    if flingThread then
        task.cancel(flingThread)
        flingThread = nil
    end
    Config.FlingSheriff = false
    Config.FlingMurderer = false
    Config.FlingHero = false
    Config.FlingAll = false
    flingInProgress = false
end

local function ToggleFling(roleName)
    PlayClickSound()
    if flingInProgress then
        NexusNotify("FLING", "Aguarde, o fling está em andamento!", 3)
        return
    end
    if (roleName == "Sheriff" and Config.FlingSheriff) or
       (roleName == "Murderer" and Config.FlingMurderer) or
       (roleName == "Hero" and Config.FlingHero) then
        StopFling()
    else
        StopFling()
        StartFling(roleName)
        if roleName == "Sheriff" then
            Config.FlingSheriff = true
        elseif roleName == "Murderer" then
            Config.FlingMurderer = true
        elseif roleName == "Hero" then
            Config.FlingHero = true
        end
    end
end

local function ToggleFlingAll()
    PlayClickSound()
    if flingInProgress then
        NexusNotify("FLING", "Aguarde, o fling está em andamento!", 3)
        return
    end
    if Config.FlingAll then
        StopFling()
    else
        StopFling()
        StartFling("all")
        Config.FlingAll = true
    end
end

local function ToggleFlingPlayer(playerName)
    PlayClickSound()
    if flingInProgress then
        NexusNotify("FLING", "Aguarde, o fling está em andamento!", 3)
        return
    end
    local plr = Players:FindFirstChild(playerName)
    if not plr then
        NexusNotify("FLING", "Player not found!", 3)
        return
    end

    if flingActive and flingTargetPlayer == plr then
        StopFling()
    else
        StopFling()
        StartFling(plr)
    end
end

ShootGui = Instance.new("ScreenGui")
ShootGui.Name = "ShootGui_Overlay_V19"
ShootGui.Parent = CoreGui
ShootGui.Enabled = false
ShootGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ShootButton = Instance.new("TextButton")
ShootButton.Parent = ShootGui
ShootButton.BackgroundColor3 = Theme.Background
ShootButton.BackgroundTransparency = 0.5
ShootButton.Position = UDim2.new(0.65, 0, 0.6, 0)
ShootButton.Size = UDim2.new(0, 220, 0, 80)
ShootButton.Font = Enum.Font.GothamBold
ShootButton.Text = "NEXUS AIM"
ShootButton.TextColor3 = Theme.Accent
ShootButton.TextSize = 24
ShootButton.AutoButtonColor = false
ShootButton.TextStrokeTransparency = 0.8

local ShootCorner = Instance.new("UICorner")
ShootCorner.CornerRadius = UDim.new(0, 10)
ShootCorner.Parent = ShootButton

local ShootStroke = Instance.new("UIStroke")
ShootStroke.Parent = ShootButton
ShootStroke.Color = Theme.Accent
ShootStroke.Thickness = 2
ShootStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local ShootGradient = Instance.new("UIGradient")
ShootGradient.Parent = ShootStroke
ShootGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Theme.Accent),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1.00, Theme.Accent)
}
ShootGradient.Rotation = 45

task.spawn(function()
    while ShootGui do
        if ShootGui.Enabled then
            ShootGradient.Rotation = (ShootGradient.Rotation + 2) % 360
            local t = tick() % 2
            local alpha = 0.5 + 0.5 * math.sin(t * math.pi)
            ShootButton.TextColor3 = Theme.Accent:Lerp(Color3.fromRGB(255, 255, 255), alpha)
        end
        task.wait(0.03)
    end
end)

MakeDraggableCornersOnly(ShootButton)

if Config.SilentAim then
    ShootGui.Enabled = true
end

local function PerformSilentAimMouse()
    PlayClickSound()
    if not Config.SilentAim then
        return
    end
    
    local success = PerformSilentAimDirectly()
    
    if success then
        ShootButton.Text = "FIRED"
        ShootStroke.Color = Color3.fromRGB(255, 50, 50)
        
        task.delay(0.2, function()
            ShootButton.Text = "NEXUS AIM"
            ShootStroke.Color = Theme.Accent
        end)
    else
        ShootButton.Text = "NO TARGET"
        ShootStroke.Color = Color3.fromRGB(255, 50, 50)
        
        task.delay(0.5, function()
            ShootButton.Text = "NEXUS AIM"
            ShootStroke.Color = Theme.Accent
        end)
    end
end

ShootButton.MouseButton1Click:Connect(PerformSilentAimMouse)

local function getRoles()
    if not playerDataRemote then
        playerDataRemote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
    end
    
    if playerDataRemote then
        local success, data = pcall(function()
            return playerDataRemote:InvokeServer()
        end)
        
        if success and data then
            local newRoles = {}
            local hasMurder = false
            
            for plr, plrData in pairs(data) do
                if plrData.Dead or not plrData.Role or plrData.Role == "" then
                    newRoles[plr] = "Lobby"
                else
                    newRoles[plr] = plrData.Role
                end
                
                if plrData.Role == "Murderer" then
                    hasMurder = true
                end
            end
            
            if not hasMurder then
                rolesNotified = false
            end
            
            return newRoles
        end
    end
    return nil
end

local function ShowRoleAlert(role)
    if not Config.InstantRole then
        return
    end
    
    if role == "Hero" then
        return
    end
    
    if CoreGui:FindFirstChild("NexusRoleAlert") then
        CoreGui.NexusRoleAlert:Destroy()
    end
    
    local AlertGui = Instance.new("ScreenGui")
    AlertGui.Name = "NexusRoleAlert"
    AlertGui.Parent = CoreGui
    AlertGui.IgnoreGuiInset = true
    
    local yPosition = 0.35
    
    local MainLabel = Instance.new("TextLabel")
    MainLabel.Parent = AlertGui
    MainLabel.Size = UDim2.new(1, 0, 0, 100)
    MainLabel.Position = UDim2.new(0, 0, yPosition, 0)
    MainLabel.BackgroundTransparency = 1
    MainLabel.Font = Enum.Font.GothamBlack
    MainLabel.Text = "YOU ARE " .. string.upper(role)
    MainLabel.TextColor3 = RoleColors[role] or Color3.fromRGB(255, 255, 255)
    MainLabel.TextSize = 0
    MainLabel.TextStrokeTransparency = 0.5
    MainLabel.TextStrokeColor3 = Color3.new(0,0,0)
    
    TweenService:Create(MainLabel, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 60}):Play()
    
    local sound = Instance.new("Sound", AlertGui)
    sound.SoundId = "rbxassetid://10548111966"
    sound.Volume = 2
    sound:Play()
    
    task.delay(4, function()
        if MainLabel then
            TweenService:Create(MainLabel, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
            task.wait(0.5)
            if AlertGui then
                AlertGui:Destroy()
            end
        end
    end)
end

task.spawn(function()
    while true do
        local roles = getRoles()
        if roles then
            RoleCache = roles
            local myRole = RoleCache[LocalPlayer.Name] or "Lobby"
            
            if myRole ~= "Lobby" and myRole ~= lastMyRole then
                lastMyRole = myRole
                ShowRoleAlert(myRole)
            elseif myRole == "Lobby" then
                lastMyRole = "Lobby"
            end
            
            local hasMurder = false
            for _, r in pairs(RoleCache) do
                if r == "Murderer" then
                    hasMurder = true
                    break
                end
            end
            
            if not hasMurder then
                rolesNotified = false
            end
            
            if Config.NotifyRoles and not rolesNotified then
                local m, s = "None", "None"
                
                for p, r in pairs(RoleCache) do
                    if r == "Murderer" then
                        m = p
                    elseif r == "Sheriff" then
                        s = p
                    end
                end
                
                if m ~= "None" then
                    NexusNotify("ROLES REVEALED", "Murderer: " .. m .. "\nSheriff: " .. s, 5)
                    rolesNotified = true
                end
            end
        end
        task.wait(0.25)
    end
end)

local wasGunDropped = false

task.spawn(function()
    while true do
        local dropped = Workspace:FindFirstChild("GunDrop", true)
        foundGunDrop = dropped
        
        if GrabFrame then
            GrabFrame.Visible = Config.ShowGrabBtn and not Config.GamepadEnabled
        end
        
        if InvisFrame then
            InvisFrame.Visible = Config.ShowInvisBtn and not Config.GamepadEnabled
        end
        
        if DesyncFrame then
            DesyncFrame.Visible = Config.ShowDesyncBtn and Config.DesyncEnabled and not Config.GamepadEnabled
        end

        if dropped and not wasGunDropped then
            if Config.NotifyGunDrop then
                NexusNotify("GUN DROPPED", "The gun has been dropped on the map!", 4)
            end
        end
        
        if wasGunDropped and not dropped and Config.NotifyGunPickup then
            task.wait(0.5)
            for _, p in ipairs(Players:GetPlayers()) do
                local char = p.Character
                if char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or (p.Backpack and (p.Backpack:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Revolver")))) then
                    NexusNotify("GUN TAKEN", p.Name .. " picked up the gun!", 4)
                    break
                end
            end
        end
        
        wasGunDropped = (dropped ~= nil)
        task.wait(0.2)
    end
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            if Config.WalkSpeedEnabled then
                hum.WalkSpeed = Config.WalkSpeedValue
            end
            
            if Config.JumpPowerEnabled then
                hum.UseJumpPower = true
                hum.JumpPower = Config.JumpPowerValue
            end
        end
    end
end)

local function GetKnifeRemote()
    if not LocalPlayer.Character then
        return nil
    end
    
    local tool = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    
    if tool then
        return tool:FindFirstChild("HandleTouched", true)
    end
    
    return nil
end

RunService.RenderStepped:Connect(function()
    if Config.HitboxExpand then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                    root.Transparency = Config.HitboxVisible and 0.5 or 1
                    root.CanCollide = false
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        if Config.KnifeAura and RoleCache[LocalPlayer.Name] == "Murderer" then
            local myChar = LocalPlayer.Character
            local knife = myChar and myChar:FindFirstChild("Knife")
            
            if knife and knife:FindFirstChild("Handle") then
                local targetFound = false
                
                for _, enemy in ipairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character then
                        local eRoot = enemy.Character:FindFirstChild("HumanoidRootPart")
                        local eHum = enemy.Character:FindFirstChild("Humanoid")
                        local eRole = RoleCache[enemy.Name]
                        
                        if eRoot and eHum and eHum.Health > 0 and eRole ~= "Murderer" and eRole ~= "Lobby" then
                            local dist = (eRoot.Position - myChar.HumanoidRootPart.Position).Magnitude
                            
                            if dist <= Config.KnifeAuraDist then
                                eRoot.CFrame = knife.Handle.CFrame
                                eRoot.Velocity = Vector3.new(0,0,0)
                                eRoot.RotVelocity = Vector3.new(0,0,0)
                                
                                local remote = GetKnifeRemote()
                                if remote then
                                    pcall(function()
                                        remote:FireServer(eRoot)
                                    end)
                                end
                                
                                if Config.KnifeLegitMode then
                                    targetFound = true
                                    break
                                end
                            end
                        end
                    end
                    
                    if Config.KnifeLegitMode and targetFound then
                        break
                    end
                end
            end
        end
        task.wait()
    end
end)

RunService.RenderStepped:Connect(function()
    if Config.KnifeHoming and RoleCache[LocalPlayer.Name] == "Murderer" then
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj.Name == "ThrowingKnife" then
                if not obj:IsDescendantOf(LocalPlayer.Character) then
                    local targetFound = false
                    
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local enemyRoot = plr.Character.HumanoidRootPart
                            local role = RoleCache[plr.Name]
                            
                            if role ~= "Lobby" and role ~= "Murderer" then
                                local knifePos = nil
                                
                                if obj:FindFirstChild("BladePosition") then
                                    knifePos = obj.BladePosition.Position
                                elseif obj:IsA("BasePart") then
                                    knifePos = obj.Position
                                elseif obj:FindFirstChild("Handle") then
                                    knifePos = obj.Handle.Position
                                end
                                
                                if knifePos then
                                    local dist = (knifePos - enemyRoot.Position).Magnitude
                                    
                                    if dist <= Config.KnifeTriggerDist then
                                        enemyRoot.CFrame = CFrame.new(knifePos)
                                        
