-- yslemEgg | Instant TP (Black & Blue Universal Fix)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

------------------------------------------------------------------ Safe Folder & Service Loaders
local function safeRequire(getter)
	local ok, result = pcall(function()
		return require(getter())
	end)
	return ok and result or nil
end

-- Timeout para evitar que el script se congele en WaitForChild
local packages = ReplicatedStorage:WaitForChild("Packages", 3)
local networkingFolder = packages and packages:WaitForChild("Networking", 3)

local EggState = safeRequire(function() return ReplicatedStorage:WaitForChild("Client", 3):WaitForChild("EggState", 3) end)
local Assets = safeRequire(function() return ReplicatedStorage:WaitForChild("Data", 3):WaitForChild("Assets", 3) end)
local Mutations = safeRequire(function() 
	local shared = ReplicatedStorage:WaitForChild("Shared", 3)
	local mods = shared and shared:WaitForChild("Modules", 3)
	return mods and mods:WaitForChild("Mutations", 3)
end)

local function remote(name)
	return networkingFolder and networkingFolder:FindFirstChild(name)
end

local function root()
	local character = localPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart")
end

------------------------------------------------------------------ Configuration
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

------------------------------------------------------------------ Humanoid Shield
local shield = { Original = nil, Clone = nil, Links = {}, Connection = nil }

local function walkSpeed()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local speed = humanoid and humanoid.WalkSpeed or 16
	if shield.Original and shield.Original.Health > 0 then
		speed = math.min(speed, shield.Original.WalkSpeed)
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

local function shieldUnlink()
	for _, link in ipairs(shield.Links) do
		pcall(function() link:Disconnect() end)
	end
	table.clear(shield.Links)
end

local function grounded(humanoid)
	if not humanoid or humanoid.Health <= 0 or humanoid.FloorMaterial == Enum.Material.Air then
		return false
	end
	return true
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
	shield.Original = humanoid
	shield.Clone = clone

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

local function shieldStop()
	if shield.Connection then
		shield.Connection:Disconnect()
		shield.Connection = nil
	end
	shieldUnlink()
	local character = localPlayer.Character
	if shield.Original and shield.Clone and character then
		shield.Original.Parent = character
		workspace.CurrentCamera.CameraSubject = shield.Original
		pcall(function() shield.Clone:Destroy() end)
	end
	shield.Original, shield.Clone = nil, nil
end

------------------------------------------------------------------ Carry / Delivery State
local state = { Carrying = false, Uid = nil, Delivered = 0, Busy = false, Cancel = false, AutoSteal = false }

if type(EggState) == "table" and type(EggState.CarryChanged) == "table" and type(EggState.CarryChanged.Connect) == "function" then
	EggState.CarryChanged:Connect(function(arg)
		local carrying = type(arg) == "table" and arg.IsCarrying == true
		if carrying and arg.GuardDisabled == true then
			carrying = false
		end
		if carrying and type(arg.Uid) == "string" then
			state.Uid = arg.Uid
		end
		state.Carrying = carrying
	end)
end

local verdictRemote = remote("RE/EggWorld/FieldEggRedeemVerdict")
if verdictRemote then
	verdictRemote.OnClientEvent:Connect(function()
		state.Delivered = os.clock()
	end)
end

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

local function snapshot()
	local list = {}
	local askRemote = remote("RF/EggWorld/AskFieldEggSnapshot")
	if not askRemote then return list end

	local ok, result = pcall(function()
		return askRemote:InvokeServer()
	end)
	local records = ok and type(result) == "table" and result.Records or nil
	if type(records) ~= "table" then
		return list
	end
	for _, record in pairs(records) do
		if type(record) == "table" and type(record.Uid) == "string" and (record.State == "Slot" or record.State == "Dropped") and typeof(record.BottomCFrame) == "CFrame" then
			table.insert(list, record)
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
		info.Value = (tonumber(entry.EarningRate) or 0) * factor
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

------------------------------------------------------------------ Teleport Logic
local status = function(text) end

local function lineInfo()
	local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
	world = world and world:FindFirstChild("Areas")
	world = world and world:FindFirstChild("SeparationLine")
	local ok = world and world:IsA("BasePart")
	return ok and world.Position.X or 552.2, ok and world.Position.Y or 67.67
end

local function homePoint()
	return Vector3.new(528.7, 70.57, -364.11)
end

local function place(position)
	local r = root()
	if not r then return end
	pcall(function()
		r.CFrame = CFrame.new(position) * CFrame.Angles(0, math.rad(90), 0)
		r.AssemblyLinearVelocity = Vector3.zero
	end)
end

local function singleStealAttempt(uid)
	local egg = eggPosition(uid)
	if not egg then
		status("El huevo no existe")
		return false
	end
	
	status("Moviéndose al huevo...")
	place(egg + Vector3.new(0, 3, 0))
	task.wait(0.1)
	takeEgg(uid)
	task.wait(0.2)

	if not state.Carrying then
		return false
	end

	status("Entregando huevo...")
	local home = homePoint()
	place(home)
	task.wait(0.2)
	dropEgg()

	return true
end

------------------------------------------------------------------ UI Creation
local function getParentGui()
	if typeof(gethui) == "function" then
		local ok, result = pcall(gethui)
		if ok and result then return result end
	end
	local ok, core = pcall(function() return CoreGui end)
	if ok and core then return core end
	return localPlayer:WaitForChild("PlayerGui")
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

local parentUI = getParentGui()
local old = parentUI:FindFirstChild("yslemEgg")
if old then old:Destroy() end

local gui = make("ScreenGui", { Name = "yslemEgg", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
gui.Parent = parentUI

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
		table.insert(infos, describe(record))
		hashStr = hashStr .. record.Uid .. ";"
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

------------------------------------------------------------------ Button Listeners
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
			if not eggPosition(selectedUid) then
				status("Huevo no disponible")
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

			task.wait(0.3)
		end

		state.AutoSteal = false
		state.Busy = false
		stealButton.Text = "Steal"
	end)
end)

-- Auto Refresh Loop
task.spawn(function()
	while gui.Parent do
		task.wait(2)
		if not state.Busy and body.Visible then
			local currentHash = ""
			for _, record in ipairs(snapshot()) do
				currentHash = currentHash .. record.Uid .. ";"
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
	shieldStop()
	gui:Destroy()
end)

rebuild()
