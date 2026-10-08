local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer

------------------------------------------------------------------ Settings
local CFG = {
	SpeedCap = 1.15,
	HopRatio = 1.515,
	HopMin = 40,
	HopGap = 0.06,
	HopGapMin = 0.06,
	HopGapMax = 0.2,
	HopRetries = 6,
	HopLift = 42,
	LandOffset = 14,
	LandSettle = 0.08,
	DropDelay = 0.05,
	GrabInterval = 0.03,
	RegrabFar = 40,
	Height = 70,
	ClimbShare = 0.5,
	CarryRatio = 0.9,
	EasyRatio = 1.3,
}
local FPS = { 60, 30, 0.15 }

------------------------------------------------------------------ Colors (Pure Black + Electric Blue)
local PURE_BLACK = Color3.fromRGB(0, 0, 0)
local DARK_PANEL = Color3.fromRGB(8, 10, 16)
local ACCENT_BLUE = Color3.fromRGB(0, 140, 255)
local DARK_BLUE = Color3.fromRGB(0, 60, 120)
local TEXT_WHITE = Color3.fromRGB(240, 245, 255)
local TEXT_DIM = Color3.fromRGB(120, 140, 170)

local RARITY_COLORS = {
	Color3.fromRGB(180, 180, 180), Color3.fromRGB(80, 220, 120), Color3.fromRGB(0, 150, 255),
	Color3.fromRGB(170, 90, 255), Color3.fromRGB(255, 170, 40), Color3.fromRGB(255, 70, 70),
	Color3.fromRGB(255, 80, 200), Color3.fromRGB(0, 230, 230),
}

------------------------------------------------------------------ Game Handles
local function safeRequire(getter)
	local ok, result = pcall(function()
		return require(getter())
	end)
	return ok and result or nil
end

local networkingFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Networking")
local EggState = safeRequire(function() return ReplicatedStorage.Client.EggState end)
local Assets = safeRequire(function() return ReplicatedStorage.Data.Assets end)
local Mutations = safeRequire(function() return ReplicatedStorage.Shared.Modules.Mutations end)

local function remote(name)
	return networkingFolder:FindFirstChild(name)
end

local function root()
	local character = localPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart")
end

------------------------------------------------------------------ Shield
local shield = { Original = nil, Clone = nil, Links = {}, Connection = nil, Added = nil }

local function walkSpeed()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local speed = humanoid and humanoid.WalkSpeed or 16
	if shield.Original and shield.Original.Health > 0 then
		speed = math.min(speed, shield.Original.WalkSpeed)
	end
	local ok, result = pcall(function()
		local stat = localPlayer:FindFirstChild("leaderstats")
		stat = stat and stat:FindFirstChild("Speed")
		local util = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
		return stat and util.SpeedPowerToWalkSpeed(stat.Value) or nil
	end)
	if ok and type(result) == "number" and result > 0 then
		speed = math.min(speed, result)
	end
	return speed
end

local function shieldControls(humanoid)
	pcall(function()
		local scripts = localPlayer:FindFirstChild("PlayerScripts")
		local module = scripts and scripts:FindFirstChild("PlayerModule")
		if module then
			local controls = require(module):GetControls()
			if type(controls) == "table" then
				controls.humanoid = humanoid
			end
		end
	end)
end

local function shieldAnimate(character)
	local animate = character and character:FindFirstChild("Animate")
	if animate and animate:IsA("LocalScript") then
		task.spawn(function()
			animate.Enabled = false
			task.wait()
			animate.Enabled = true
		end)
	end
end

local function shieldUnlink()
	for _, link in ipairs(shield.Links) do
		pcall(function() link:Disconnect() end)
	end
	table.clear(shield.Links)
end

local groundedStates = {
	[Enum.HumanoidStateType.Running] = true,
	[Enum.HumanoidStateType.RunningNoPhysics] = true,
	[Enum.HumanoidStateType.Landed] = true,
}

local function grounded(humanoid)
	if not humanoid or humanoid.Health <= 0 or humanoid.FloorMaterial == Enum.Material.Air then
		return false
	end
	return groundedStates[humanoid:GetState()] == true
end

local function shieldSwap()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 or (shield.Clone and shield.Clone.Parent == character) or not grounded(humanoid) then
		return
	end

	local clone = humanoid:Clone()
	humanoid.Parent = nil
	clone.Parent = character
	workspace.CurrentCamera.CameraSubject = clone
	shieldControls(clone)
	shieldAnimate(character)
	shield.Original = humanoid
	shield.Clone = clone

	table.insert(shield.Links, humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if clone.Parent ~= nil then
			clone.WalkSpeed = humanoid.WalkSpeed
		end
	end))

	table.insert(shield.Links, clone.Died:Connect(function()
		shieldUnlink()
		shield.Original, shield.Clone = nil, nil
		local current = localPlayer.Character
		if current and humanoid.Parent == nil then
			humanoid.Parent = current
			workspace.CurrentCamera.CameraSubject = humanoid
			shieldControls(humanoid)
		end
		pcall(function() clone:Destroy() end)
		humanoid.Health = 0
	end))
end

local function shieldUndo()
	shieldUnlink()
	local character = localPlayer.Character
	local original, clone = shield.Original, shield.Clone
	shield.Original, shield.Clone = nil, nil
	if original and clone and character and original.Parent == nil and clone.Parent == character then
		original.Parent = character
		workspace.CurrentCamera.CameraSubject = original
		shieldControls(original)
		pcall(function() clone:Destroy() end)
		shieldAnimate(character)
	end
end

local function shieldStart()
	shieldSwap()
	local n = 0
	shield.Connection = RunService.Heartbeat:Connect(function(dt)
		n += dt
		local character = localPlayer.Character
		local missing = not (shield.Clone and character and shield.Clone.Parent == character)
		if (missing and 0.25 or 3) <= n then
			n = 0
			shieldSwap()
		end
	end)
end

local function shieldStop()
	if shield.Connection then
		shield.Connection:Disconnect()
		shield.Connection = nil
	end
	shieldUndo()
end

------------------------------------------------------------------ Carry / Delivery State
local state = { Carrying = false, Uid = nil, Delivered = 0, Busy = false, Cancel = false, Mult = 1, PulledAt = 0, HeldSeen = 0, GuessedDrop = false, AutoSteal = false }

if type(EggState) == "table" and type(EggState.CarryChanged) == "table" and type(EggState.CarryChanged.Connect) == "function" then
	EggState.CarryChanged:Connect(function(arg)
		local carrying = type(arg) == "table" and arg.IsCarrying == true
		if carrying and arg.GuardDisabled == true then
			carrying = false
		end
		state.GuessedDrop = false
		if carrying then
			state.HeldSeen = os.clock()
		end
		if carrying and type(arg.Uid) == "string" then
			state.Uid = arg.Uid
			local mult = tonumber(arg.SpeedMultiplier)
			if mult and mult > 0 then
				state.Mult = mult
			end
		end
		state.Carrying = carrying
	end)
end

pcall(function()
	remote("RE/EggWorld/FieldEggRedeemVerdict").OnClientEvent:Connect(function()
		state.Delivered = os.clock()
	end)
end)

pcall(function()
	remote("RE/RigSync/Refresh").OnClientEvent:Connect(function(arg)
		if type(arg) == "table" and arg.Action == "Relocate" then
			state.PulledAt = os.clock()
		end
	end)
end)

local function takeEgg(uid)
	if type(uid) == "string" and type(EggState) == "table" and type(EggState.CarryFieldEgg) == "function" then
		pcall(EggState.CarryFieldEgg, uid)
	end
end

local function dropEgg()
	if type(EggState) == "table" and type(EggState.DropFieldEgg) == "function" then
		pcall(EggState.DropFieldEgg, "PlayerRequest")
	end
end

local function promptNear(position, radius)
	local best, bestDistance = nil, radius
	for _, child in ipairs(workspace:GetChildren()) do
		if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
			local prompt = child:FindFirstChild("CarryAreaEgg")
			if prompt and prompt:IsA("ProximityPrompt") then
				local distance = (child.Position - position).Magnitude
				if distance < bestDistance then
					best, bestDistance = prompt, distance
				end
			end
		end
	end
	return best
end

local function snapshot()
	local list = {}
	local ok, result = pcall(function()
		return remote("RF/EggWorld/AskFieldEggSnapshot"):InvokeServer()
	end)
	local records = ok and type(result) == "table" and result.Records or nil
	if type(records) ~= "table" then
		return list
	end
	for _, record in pairs(records) do
		if type(record) == "table" and type(record.Uid) == "string" and (record.State == "Slot" or record.State == "Dropped") and typeof(record.BottomCFrame) == "CFrame" then
			list[#list + 1] = record
		end
	end
	return list
end

local function eggPosition(uid)
	for _, record in ipairs(snapshot()) do
		if record.Uid == uid then
			return record.BottomCFrame.Position
		end
	end
	return nil
end

------------------------------------------------------------------ Egg Data
local function describe(record)
	local directory = type(Assets) == "table" and Assets.Directory or nil
	local entry = type(directory) == "table" and directory[tostring(record.AssetCategory)] or nil
	local info = { Uid = record.Uid, Category = tostring(record.AssetCategory), Name = tostring(record.AssetCategory), Icon = "", Rarity = 0, Value = 0 }

	if type(entry) == "table" then
		info.Name = tostring(entry.DisplayName or record.AssetCategory)
		local icon = entry.Icon
		if icon ~= nil and tostring(icon) ~= "" then
			icon = tostring(icon)
			info.Icon = tonumber(icon) and ("rbxassetid://" .. icon) or icon
		end
		if type(entry.Rarity) == "table" then
			info.Rarity = tonumber(entry.Rarity.RarityNumber or entry.Rarity.Rank) or 0
		end

		local scale = tonumber(record.AssetScale) or 1
		local factor = scale > 5 and (scale / 5) ^ 1.2 * 19.637875755794113 or scale ^ 1.85
		local mutation = 1
		if type(Mutations) == "table" and type(Mutations.EarningsFor) == "function" then
			local okM, resM = pcall(Mutations.EarningsFor, type(record.Mutations) == "table" and record.Mutations or {})
			if okM and type(resM) == "number" then
				mutation = resM
			end
		end
		info.Value = (tonumber(entry.EarningRate) or 0) * factor * mutation
	end

	return info
end

local function money(value)
	local units = { { 1e12, "T" }, { 1e9, "B" }, { 1e6, "M" }, { 1e3, "K" } }
	for _, u in ipairs(units) do
		if value >= u[1] then
			return string.format("$%.2f%s/s", value / u[1], u[2])
		end
	end
	return string.format("$%d/s", math.floor(value + 0.5))
end

------------------------------------------------------------------ Instant TP Logic
local status = function(text) end

local function frozenCamera()
	local camera = workspace.CurrentCamera
	if not camera then return function() end end
	local oldType = camera.CameraType
	local frame = camera.CFrame
	pcall(function()
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CFrame = frame
	end)
	return function()
		pcall(function() camera.CameraType = oldType end)
	end
end

local fpsGen = 0
local function fpsOn()
	if typeof(setfpscap) ~= "function" then return end
	fpsGen += 1
	local mine = fpsGen
	task.spawn(function()
		local high = true
		local started = os.clock()
		while fpsGen == mine and os.clock() - started < 60 do
			pcall(setfpscap, high and FPS[1] or FPS[2])
			high = not high
			task.wait(FPS[3])
		end
	end)
end

local function fpsOff()
	fpsGen += 1
	if typeof(setfpscap) == "function" then
		pcall(setfpscap, 240)
	end
end

local stealClone = nil
local function dropClone()
	local copy = stealClone
	stealClone = nil
	if copy then pcall(function() copy:Destroy() end) end
end

local function postClone()
	dropClone()
	local character = localPlayer.Character
	if not character then return end
	local was = character.Archivable
	character.Archivable = true
	local copy = character:Clone()
	character.Archivable = was
	if copy then
		for _, d in ipairs(copy:GetDescendants()) do
			if d:IsA("LuaSourceContainer") or d:IsA("Humanoid") then
				pcall(function() d:Destroy() end)
			elseif d:IsA("BasePart") then
				d.Anchored = true
				d.CanCollide = false
				d.CanTouch = false
				d.CanQuery = false
			end
		end
		copy.Name = "Clone"
		copy.Parent = workspace
		stealClone = copy
	end
end

local function lineInfo()
	local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	world = world and world:FindFirstChild("Areas")
	world = world and world:FindFirstChild("SeparationLine")
	local ok = world and world:IsA("BasePart")
	return ok and world.Position.X or 552.2, ok and world.Position.Y or 67.67
end

local function homePoint()
	for _, def in ipairs({
		{ { "GearGiver_Slap", "Podium" }, Vector3.new(-16.415, 21.072, -6.106) },
		{ { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" }, Vector3.new(-26.776, 1.75, 18.665) },
		{ { "__OBJECTS", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" }, Vector3.new(-26.776, 1.75, 18.665) },
	}) do
		local node = workspace
		for _, name in ipairs(def[1]) do
			node = node and node:FindFirstChild(name) or nil
		end
		if node and node:IsA("BasePart") then
			return node.CFrame:PointToWorldSpace(def[2])
		end
	end
	return Vector3.new(528.7, 70.57, -364.11)
end

local function place(position)
	local r = root()
	if not r then return end
	pcall(function()
		r.CFrame = CFrame.new(position) * CFrame.Angles(0, math.rad(90), 0)
		r.AssemblyLinearVelocity = Vector3.zero
		r.AssemblyAngularVelocity = Vector3.zero
	end)
end

local function runToEgg(uid, egg)
	local lineX = lineInfo()
	local home = homePoint()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.PlatformStand = false
		if character:FindFirstChildWhichIsA("Tool") then
			pcall(function() humanoid:UnequipTools() end)
		end
	end

	local r = root()
	if not r then return false end
	local stage = "field"
	if r.Position.X < lineX - 2 and Vector3.new(r.Position.X - home.X, 0, r.Position.Z - home.Z).Magnitude > 20 then
		stage = "safe"
	end

	local started, lastTake = os.clock(), 0
	while os.clock() - started < 120 and not state.Cancel do
		r = root()
		if not r then return false end
		local flatEgg = Vector3.new(egg.X - r.Position.X, 0, egg.Z - r.Position.Z)
		if stage == "field" and flatEgg.Magnitude <= 2.5 then
			break
		end
		local target = egg
		if stage == "safe" then
			if Vector3.new(home.X - r.Position.X, 0, home.Z - r.Position.Z).Magnitude <= 6 then
				stage = "field"
			else
				target = home
			end
		end

		local flat = Vector3.new(target.X - r.Position.X, 0, target.Z - r.Position.Z)
		local unit = flat.Magnitude > 0.01 and flat.Unit or Vector3.zero
		local speed = math.max(walkSpeed() * CFG.SpeedCap, 8)
		local v = unit * math.min(speed, flat.Magnitude / 0.05)
		pcall(function()
			r.AssemblyLinearVelocity = Vector3.new(v.X, r.AssemblyLinearVelocity.Y, v.Z)
			if humanoid and unit.Magnitude > 0 then
				humanoid:Move(unit, false)
			end
		end)

		if stage == "field" and flatEgg.Magnitude <= 9 and os.clock() - lastTake > 0.1 then
			lastTake = os.clock()
			takeEgg(uid)
		end
		RunService.Heartbeat:Wait()
	end

	return state.Carrying or (r ~= nil and Vector3.new(egg.X - r.Position.X, 0, egg.Z - r.Position.Z).Magnitude <= 6)
end

local function grab(uid, timeout)
	local waited, since = 0, 1
	while not state.Carrying and waited < timeout and not state.Cancel do
		local r = root()
		local egg = eggPosition(uid)
		local dt = math.max(RunService.Heartbeat:Wait(), 1 / 240)
		waited += dt
		since += dt
		if r and egg then
			local delta = egg - r.Position
			if delta.Magnitude > 2 then
				local pace = math.max(walkSpeed() * CFG.SpeedCap, 16)
				local v = delta / math.max(0.08, dt)
				if v.Magnitude > pace then v = v.Unit * pace end
				pcall(function()
					r.AssemblyLinearVelocity = v + Vector3.new(0, workspace.Gravity * dt * 0.5, 0)
				end)
			end
			if since >= CFG.GrabInterval then
				since = 0
				local prompt = promptNear(egg - Vector3.new(0, 3, 0), 10)
				if prompt and typeof(fireproximityprompt) == "function" then
					pcall(function() prompt.HoldDuration = 0 end)
					pcall(fireproximityprompt, prompt)
				end
				task.spawn(takeEgg, uid)
			end
		end
	end
	return state.Carrying and state.Uid == uid
end

local function runHome(lineX, laneZ)
	local started = os.clock()
	local home = homePoint()
	local checkpoint = lineX - 7
	local height = CFG.Height
	local share = math.clamp(CFG.ClimbShare, 0.1, 0.9)
	local descent = height * math.sqrt(1 - share * share) / share
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	local r = root()
	if r and character and height > 0.5 and home.Y + height - 2 > r.Position.Y then
		pcall(function()
			character:PivotTo(CFrame.new(Vector3.new(r.Position.X, home.Y + height, r.Position.Z)) * r.CFrame.Rotation)
		end)
	end

	local speed = walkSpeed() * CFG.SpeedCap
	local last = os.clock()
	while state.Carrying and state.Delivered < started and not state.Cancel do
		r = root()
		if not r then return false end
		local dt = math.max(os.clock() - last, 1 / 240)
		last = os.clock()

		local toHome = r.Position.X <= checkpoint + 2
		local target = toHome and home or Vector3.new(checkpoint, home.Y, laneZ)
		if toHome and Vector3.new(home.X - r.Position.X, 0, home.Z - r.Position.Z).Magnitude < 2 then break end

		local flat = Vector3.new(target.X - r.Position.X, 0, target.Z - r.Position.Z)
		local remaining = toHome and 0 or math.max(0, r.Position.X - checkpoint)
		local wantY = home.Y + height
		if toHome or remaining <= descent then
			wantY = home.Y + height * math.clamp(remaining / math.max(descent, 1), 0, 1)
		end
		local vy = math.clamp((wantY - r.Position.Y) / 0.12, -speed * share, speed * share)
		local horizontal = math.sqrt(math.max(speed * speed - vy * vy, 0))
		local v = flat.Magnitude > 0.01 and flat.Unit * math.min(horizontal, flat.Magnitude / 0.05) or Vector3.zero
		pcall(function() r.AssemblyLinearVelocity = Vector3.new(v.X, vy, v.Z) end)
		RunService.Heartbeat:Wait()
	end

	if state.Carrying and state.Delivered < started and not state.Cancel then
		task.wait(0.2)
		dropEgg()
	end
	return state.Delivered >= started
end

local function instantTP(uid)
	local started = os.clock()
	local lineX, lineY = lineInfo()
	local r = root()
	if not r then return false end
	local laneZ = math.clamp(r.Position.Z, -425, -300)
	local landing = Vector3.new(lineX + CFG.LandOffset, lineY + 3.35, laneZ)

	local hopStep = math.max(walkSpeed() * CFG.HopRatio, CFG.HopMin)
	local hopY = r.Position.Y + CFG.HopLift
	local x = r.Position.X
	local releaseCamera = frozenCamera()
	pcall(postClone)
	fpsOn()

	while x - hopStep > landing.X and not state.Cancel do
		if not state.Carrying then
			if not grab(uid, 3) then break end
		end

		local nextX = x - hopStep
		status(string.format("Teleportando... X %d", math.floor(nextX)))
		local held = 0
		while held < CFG.HopGap do
			place(Vector3.new(nextX, hopY, laneZ))
			held += RunService.Heartbeat:Wait()
		end
		x = nextX
	end

	place(landing)
	dropClone()

	if state.Carrying and not state.Cancel do
		task.wait(CFG.DropDelay)
		dropEgg()
		releaseCamera()
		status("Re-tomando huevo...")
		if not grab(uid, 3) then
			fpsOff()
			return false
		end
	end
	releaseCamera()

	local ok = false
	if state.Carrying then
		ok = runHome(lineX, laneZ)
	end
	fpsOff()
	return ok or state.Delivered >= started
end

local function singleStealAttempt(uid)
	local egg = eggPosition(uid)
	if not egg then
		status("El huevo ya no existe")
		return false
	end
	if state.Carrying and state.Uid ~= uid then
		dropEgg()
		task.wait(0.3)
	end
	fpsOn()
	if not runToEgg(uid, egg) then
		fpsOff()
		return false
	end
	if not grab(uid, 3) then
		fpsOff()
		return false
	end
	local delivered = instantTP(uid)
	fpsOff()
	return delivered
end

------------------------------------------------------------------ UI Construction (Pitch Black + Electric Blue)
local function parentGui()
	if typeof(gethui) == "function" then
		local ok, result = pcall(gethui)
		if ok and typeof(result) == "Instance" then return result end
	end
	return CoreGui
end

local function make(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do inst[k] = v end
	return inst
end

local function corner(parent, radius)
	make("UICorner", { CornerRadius = UDim.new(0, radius or 6) }).Parent = parent
end

local function stroke(parent, color, thickness)
	make("UIStroke", { Thickness = thickness or 1, Color = color or ACCENT_BLUE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }).Parent = parent
end

local old = parentGui():FindFirstChild("yslemEgg")
if old then old:Destroy() end

local gui = make("ScreenGui", { Name = "yslemEgg", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true })
gui.Parent = parentGui()

local W, H, HEADER = 160, 190, 22
local window = make("Frame", { Size = UDim2.fromOffset(W, H), Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2), BackgroundColor3 = PURE_BLACK, BorderSizePixel = 0 })
window.Parent = gui
corner(window, 12)
stroke(window, ACCENT_BLUE, 1.5)

-- Header
local header = make("Frame", { Size = UDim2.new(1, -8, 0, HEADER), Position = UDim2.fromOffset(4, 4), BackgroundColor3 = DARK_PANEL, BorderSizePixel = 0 })
header.Parent = window
corner(header, 8)
stroke(header, DARK_BLUE, 1)

local title = make("TextLabel", {
	Size = UDim2.new(1, -44, 1, 0), Position = UDim2.fromOffset(6, 0), Font = Enum.Font.GothamBlack, TextSize = 11,
	TextColor3 = ACCENT_BLUE, TextXAlignment = Enum.TextXAlignment.Left, Text = "yslemEgg", BackgroundTransparency = 1,
})
title.Parent = header

local function headerButton(txt, xOffset)
	local b = make("TextButton", { Size = UDim2.fromOffset(16, 14), Position = UDim2.new(1, xOffset, 0.5, -7), BackgroundColor3 = PURE_BLACK, Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = TEXT_WHITE, Text = txt, AutoButtonColor = true })
	b.Parent = header
	corner(b, 5)
	stroke(b, DARK_BLUE, 1)
	return b
end
local minimize = headerButton("-", -38)
local close = headerButton("x", -18)

local body = make("Frame", { Size = UDim2.new(1, -10, 1, -(HEADER + 10)), Position = UDim2.fromOffset(5, HEADER + 6), BackgroundTransparency = 1 })
body.Parent = window

local list = make("ScrollingFrame", {
	Size = UDim2.new(1, 0, 1, -56), BackgroundColor3 = DARK_PANEL, BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = ACCENT_BLUE,
	CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
})
list.Parent = body
corner(list, 8)
stroke(list, DARK_BLUE, 1)
make("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }).Parent = list
make("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }).Parent = list

local statusLabel = make("TextLabel", {
	Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(0, 0, 1, -50), Font = Enum.Font.GothamMedium, TextSize = 9,
	TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = "Selecciona huevo", BackgroundTransparency = 1,
})
statusLabel.Parent = body

status = function(msg)
	statusLabel.Text = tostring(msg)
end

local function actionButton(txt, pos, size)
	local b = make("TextButton", { Size = size, Position = pos, BackgroundColor3 = DARK_PANEL, Font = Enum.Font.GothamBlack, TextSize = 11, TextColor3 = TEXT_WHITE, Text = txt, AutoButtonColor = true })
	b.Parent = body
	corner(b, 8)
	stroke(b, ACCENT_BLUE, 1)
	return b
end

local refreshButton = actionButton("Refresh", UDim2.new(0, 0, 1, -34), UDim2.new(0.4, -2, 0, 34))
local stealButton = actionButton("Steal", UDim2.new(0.4, 2, 1, -34), UDim2.new(0.6, -2, 0, 34))

local selectedUid = nil
local rows = {}
local lastSnapshotHash = ""

local function setSelected(uid)
	selectedUid = uid
	for rowUid, row in pairs(rows) do
		local on = rowUid == uid
		row.Frame.BackgroundColor3 = on and DARK_BLUE or PURE_BLACK
		row.Stroke.Color = on and ACCENT_BLUE or DARK_BLUE
	end
end

local function rebuild()
	for _, row in pairs(rows) do
		row.Frame:Destroy()
	end
	table.clear(rows)

	local infos = {}
	local hashStr = ""
	for _, record in ipairs(snapshot()) do
		infos[#infos + 1] = describe(record)
		hashStr ..= record.Uid .. ";"
	end
	lastSnapshotHash = hashStr

	table.sort(infos, function(a, b) return a.Value > b.Value end)

	local still = false
	for index, info in ipairs(infos) do
		still = still or info.Uid == selectedUid
		local frame = make("TextButton", { Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = PURE_BLACK, LayoutOrder = index, Text = "", AutoButtonColor = true })
		frame.Parent = list
		corner(frame, 6)
		local rowStroke = make("UIStroke", { Thickness = 1, Color = DARK_BLUE, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
		rowStroke.Parent = frame

		make("ImageLabel", { Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(4, 4), BackgroundTransparency = 1, Image = info.Icon, ScaleType = Enum.ScaleType.Fit }).Parent = frame
		
		local nLabel = make("TextLabel", {
			Size = UDim2.new(1, -28, 0, 12), Position = UDim2.fromOffset(26, 2), Font = Enum.Font.GothamBold, TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Text = info.Name,
			TextColor3 = RARITY_COLORS[math.clamp(info.Rarity, 1, #RARITY_COLORS)] or TEXT_WHITE, BackgroundTransparency = 1,
		})
		nLabel.Parent = frame

		local vLabel = make("TextLabel", {
			Size = UDim2.new(1, -28, 0, 10), Position = UDim2.fromOffset(26, 15), Font = Enum.Font.GothamMedium, TextSize = 8,
			TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left, Text = money(info.Value), BackgroundTransparency = 1,
		})
		vLabel.Parent = frame

		rows[info.Uid] = { Frame = frame, Stroke = rowStroke }
		frame.MouseButton1Click:Connect(function()
			setSelected(info.Uid)
			status("Selec: " .. info.Name)
		end)
	end

	setSelected(still and selectedUid or nil)
	if #infos == 0 then
		status("Sin huevos en mapa")
	end
end

------------------------------------------------------------------ Steal Loop & Events
refreshButton.MouseButton1Click:Connect(function()
	if not state.Busy then rebuild() end
end)

stealButton.MouseButton1Click:Connect(function()
	if state.AutoSteal then
		state.AutoSteal = false
		state.Cancel = true
		status("Cancelando...")
		stealButton.Text = "Steal"
		return
	end

	if not selectedUid then
		status("Selecciona un huevo")
		return
	end

	state.AutoSteal = true
	state.Cancel = false
	stealButton.Text = "Stop"

	task.spawn(function()
		while state.AutoSteal and not state.Cancel and gui.Parent do
			-- Verificación: ¿El huevo todavía existe?
			if not eggPosition(selectedUid) then
				status("El huevo fue robado / Desapareció")
				state.AutoSteal = false
				rebuild()
				break
			end

			state.Busy = true
			status("Robando...")
			local ok = singleStealAttempt(selectedUid)
			state.Busy = false

			if ok then
				status("¡Robado con éxito!")
				state.AutoSteal = false
				rebuild()
				break
			end

			-- Si falló el intento, comprobar de nuevo si el huevo sigue ahí antes de reintentar
			if not eggPosition(selectedUid) then
				status("Robado por otro jugador")
				state.AutoSteal = false
				rebuild()
				break
			end

			task.wait(0.2)
		end

		state.AutoSteal = false
		state.Busy = false
		stealButton.Text = "Steal"
	end)
end)

-- Auto Refresh Loop (Detecta cuando alguien roba un huevo)
task.spawn(function()
	while gui.Parent do
		task.wait(1.5)
		if not state.Busy and body.Visible then
			local currentHash = ""
			for _, record in ipairs(snapshot()) do
				currentHash ..= record.Uid .. ";"
			end
			if currentHash ~= lastSnapshotHash then
				rebuild()
			end
		end
	end
end)

-- Dragging UI
do
	local dragging, startPos, startInput
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging, startPos, startInput = true, window.Position, input.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - startInput
			window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	body.Visible = not minimized
	window.Size = minimized and UDim2.fromOffset(W, HEADER + 8) or UDim2.fromOffset(W, H)
end)

close.MouseButton1Click:Connect(function()
	state.AutoSteal = false
	state.Cancel = true
	fpsOff()
	shieldStop()
	gui:Destroy()
end)

rebuild()
shieldStart()
