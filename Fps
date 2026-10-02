--[[
    ════════════════════════════════════════════════
    ███████╗██╗  ██╗██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗██████╗██████╗ ███████╗
    ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝
    █████╗  ███████║██████╔╝██║  ██║██║  ██║██║   ██║███████╗██║     ██████╔╝███████╗
    ██╔══╝  ╚════██║██╔══██╗██║  ██║██║  ██║██║   ██║╚════██║██║     ██╔══██╗╚════██║
    ██║          ██║██████╔╝██████╔╝██████╔╝╚██████╔╝███████║╚██████╗██║  ██║███████║
    ╚═╝          ╚═╝╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝
    ════════════════════════════════════════════════
    ⚡ FPS FLICK V1.6 - F4eddyScrips
    📅 Versión: 1.6
    ════════════════════════════════════════════════
]]--

-- F4eddyScrips - FPS FLICK V1.6

getgenv().F4eddyScrips = getgenv().F4eddyScrips or {}
local F4eddyScrips = getgenv().F4eddyScrips

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

if not WindUI then return end

-- Configuración predeterminada
F4eddyScrips.Language = "Español"
F4eddyScrips.AimbotEnabled = false
F4eddyScrips.WallCheck = false
F4eddyScrips.SmoothAim = 5
F4eddyScrips.FOVSize = 100
F4eddyScrips.FOVEnabled = false
F4eddyScrips.FOVColor = Color3.fromRGB(0, 133, 255)
F4eddyScrips.SpeedEnabled = false
F4eddyScrips.SpeedValue = 16
F4eddyScrips.CustomFOVEnabled = false
F4eddyScrips.CustomFOV = 70
F4eddyScrips.HitSoundEnabled = false
F4eddyScrips.HitSoundID = "rbxassetid://6534947240"
F4eddyScrips.HitSoundVolume = 0.5
F4eddyScrips.OriginalHitSounds = {}
F4eddyScrips.ESPSettings = {
    Outline = {Enabled = false, Color = Color3.fromRGB(255, 255, 255)},
    Name = {Enabled = false, Color = Color3.fromRGB(255, 255, 0)},
    Skeleton = {Enabled = false, Color = Color3.fromRGB(0, 133, 255)},
    Tracer = {Enabled = false, Color = Color3.fromRGB(0, 255, 255)}
}

-- Tabla de sonidos del Hit Sound (sin emojis)
F4eddyScrips.HitSounds = {
    ["Bell"] = "rbxassetid://6534947240",
    ["Bameware"] = "rbxassetid://3124331820",
    ["Skeet"] = "rbxassetid://6937353691",
    ["Cod Hitmarker"] = "rbxassetid://160432334",
    ["Neverlose"] = "rbxassetid://8679627751",
    ["Minecraft"] = "rbxassetid://4018616850"
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Función para sustituir Hit Sound
function F4eddyScrips.ReplaceHitSound(sound)
    if sound:IsA("Sound") and sound.Name == "HitSound" then
        if not F4eddyScrips.OriginalHitSounds[sound] then
            F4eddyScrips.OriginalHitSounds[sound] = sound.SoundId
        end
        
        if F4eddyScrips.HitSoundEnabled then
            sound.SoundId = F4eddyScrips.HitSoundID
            sound.Volume = F4eddyScrips.HitSoundVolume
        else
            if F4eddyScrips.OriginalHitSounds[sound] then
                sound.SoundId = F4eddyScrips.OriginalHitSounds[sound]
            end
        end
    end
end

-- Aplicar en los sonidos existentes
function F4eddyScrips.ReplaceAllHitSounds()
    for _, descendant in pairs(game:GetDescendants()) do
        F4eddyScrips.ReplaceHitSound(descendant)
    end
end

-- Monitorear nuevos sonidos agregados
game.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Sound") and descendant.Name == "HitSound" then
        wait(0.05)
        F4eddyScrips.ReplaceHitSound(descendant)
    end
end)

game.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Sound") and descendant.Name == "HitSound" then
        descendant:GetPropertyChangedSignal("SoundId"):Connect(function()
            if F4eddyScrips.HitSoundEnabled and descendant.SoundId ~= F4eddyScrips.HitSoundID then
                descendant.SoundId = F4eddyScrips.HitSoundID
            end
        end)
    end
end)

-- FOV Circle
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local FOVGui = Instance.new("ScreenGui")
FOVGui.Name = "F4eddyScrips_FOVCircle"
FOVGui.ResetOnSpawn = false
FOVGui.IgnoreGuiInset = true
FOVGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FOVGui.Parent = PlayerGui

local FOVCircleFrame = Instance.new("Frame")
FOVCircleFrame.Name = "Circle"
FOVCircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircleFrame.BackgroundColor3 = Color3.fromRGB(0, 133, 255)
FOVCircleFrame.BackgroundTransparency = 1
FOVCircleFrame.BorderSizePixel = 0
FOVCircleFrame.Size = UDim2.new(0, 200, 0, 200)
FOVCircleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircleFrame.Visible = false
FOVCircleFrame.ZIndex = 999
FOVCircleFrame.Parent = FOVGui

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(0, 133, 255)
CircleStroke.Thickness = 2
CircleStroke.Transparency = 0
CircleStroke.Parent = FOVCircleFrame

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FOVCircleFrame

F4eddyScrips.FOVCircle = {
    Frame = FOVCircleFrame,
    Stroke = CircleStroke,
    Gui = FOVGui
}

function F4eddyScrips.GetClosestPlayer()
    local ClosestPlayer = nil
    local ShortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChild("Humanoid")

            if humanoidRootPart and head and humanoid and humanoid.Health > 0 then
                local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)

                if onScreen then
                    local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - viewportCenter).Magnitude

                    if distance < F4eddyScrips.FOVSize and distance < ShortestDistance then
                        if F4eddyScrips.WallCheck then
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

                            local rayResult = workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * 1000, raycastParams)

                            if rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(character) then
                                ClosestPlayer = player
                                ShortestDistance = distance
                            end
                        else
                            ClosestPlayer = player
                            ShortestDistance = distance
                        end
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

-- Sistema ESP
F4eddyScrips.ESPObjects = {}

function F4eddyScrips.CreateESP(player)
    if F4eddyScrips.ESPObjects[player] then return end
    F4eddyScrips.ESPObjects[player] = {Outline = {}, Name = nil, Skeleton = {}, Tracer = nil}
end

function F4eddyScrips.RemoveESP(player)
    if F4eddyScrips.ESPObjects[player] then
        for _, obj in pairs(F4eddyScrips.ESPObjects[player].Outline) do
            if obj then pcall(function() obj:Remove() end) end
        end
        for _, obj in pairs(F4eddyScrips.ESPObjects[player].Skeleton) do
            if obj then pcall(function() obj:Remove() end) end
        end
        if F4eddyScrips.ESPObjects[player].Name then pcall(function() F4eddyScrips.ESPObjects[player].Name:Remove() end) end
        if F4eddyScrips.ESPObjects[player].Tracer then pcall(function() F4eddyScrips.ESPObjects[player].Tracer:Remove() end) end
        F4eddyScrips.ESPObjects[player] = nil
    end
end

function F4eddyScrips.SetupCharacterDeath(player)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                F4eddyScrips.RemoveESP(player)
            end)
        end
    end
end

-- TEMA AZUL Y NEGRO
WindUI:AddTheme({
    Name = "F4eddyScrips Blue & Black Theme",

    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0085ff"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#000000"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),

    Background = Color3.fromHex("#0a0a0a"),
    BackgroundTransparency = 0,

    Outline = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0085ff"), Transparency = 0 },
        ["50"] = { Color = Color3.fromHex("#0055cc"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#002299"), Transparency = 0 },
    }, {
        Rotation = 90,
    }),

    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#1a1a1a"),
    Icon = Color3.fromHex("#0085ff"),
    Hover = Color3.fromHex("#0085ff"),

    WindowBackground = Color3.fromHex("#0a0a0a"),
    WindowShadow = Color3.fromHex("#000000"),

    DialogBackground = Color3.fromHex("#0a0a0a"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#FFFFFF"),
    DialogContent = Color3.fromHex("#FFFFFF"),
    DialogIcon = Color3.fromHex("#0085ff"),

    WindowTopbarButtonIcon = Color3.fromHex("#0085ff"),
    WindowTopbarTitle = Color3.fromHex("#FFFFFF"),
    WindowTopbarAuthor = Color3.fromHex("#0085ff"),
    WindowTopbarIcon = Color3.fromHex("#0085ff"),

    TabBackground = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#1a1a1a"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#0f0f0f"), Transparency = 0 },
    }, {
        Rotation = 0,
    }),
    TabTitle = Color3.fromHex("#FFFFFF"),
    TabIcon = Color3.fromHex("#0085ff"),

    ElementBackground = Color3.fromHex("#1a1a1a"),
    ElementTitle = Color3.fromHex("#FFFFFF"),
    ElementDesc = Color3.fromHex("#AAAAAA"),
    ElementIcon = Color3.fromHex("#0085ff"),

    PopupBackground = Color3.fromHex("#0a0a0a"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#FFFFFF"),
    PopupContent = Color3.fromHex("#FFFFFF"),
    PopupIcon = Color3.fromHex("#0085ff"),

    Toggle = Color3.fromHex("#1a1a1a"),
    ToggleBar = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0085ff"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#0055cc"), Transparency = 0 },
    }, {
        Rotation = 0,
    }),

    Checkbox = Color3.fromHex("#1a1a1a"),
    CheckboxIcon = Color3.fromHex("#0085ff"),

    Slider = Color3.fromHex("#1a1a1a"),
    SliderThumb = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0085ff"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#0044aa"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})

F4eddyScrips.Window = WindUI:CreateWindow({
    Title = "F4eddyScrips Flick Fps",
    Author = "F4eddyScrips",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "F4eddyScrips Blue & Black Theme",
    Keybind = Enum.KeyCode.RightControl,
})

F4eddyScrips.Window:EditOpenButton({
    Title = "Open F7D",
    Icon = "zap",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 3,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#0085ff")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("#0055cc")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#000000"))
    }),
    Enabled = true,
    Draggable = true,
})

-- PESTAÑAS
F4eddyScrips.TabMain = F4eddyScrips.Window:Tab({Title = "Main", Icon = "zap"})
F4eddyScrips.TabAimbot = F4eddyScrips.Window:Tab({Title = "Aimbot", Icon = "crosshair"})
F4eddyScrips.TabESP = F4eddyScrips.Window:Tab({Title = "ESP", Icon = "eye"})
F4eddyScrips.TabRage = F4eddyScrips.Window:Tab({Title = "Rage", Icon = "zap"})

-- DICCIONARIOS DE TRADUCCIÓN
F4eddyScrips.UI = {}

local Translations = {
    ["Español"] = {
        LanguageTitle = "Idioma / Language",
        LanguageDesc = "Selecciona el idioma del Hub",
        ShowFPS_Title = "Mostrar FPS",
        ShowFPS_Desc = "Muestra el contador de FPS en la esquina superior derecha",
        HitSound_Title = "Activar Hit Sound",
        HitSound_Desc = "Reemplaza el sonido de impacto del juego",
        ChooseSound_Title = "Elegir Sonido",
        ChooseSound_Desc = "Selecciona qué sonido se reproducirá al golpear a un enemigo",
        HitVolume_Title = "Volumen de Hit Sound",
        HitVolume_Desc = "Ajusta el volumen del sonido (0.1 = bajo, 2.0 = alto)",
        
        Aimbot_Title = "Activar Aimbot",
        Aimbot_Desc = "Apunta automáticamente al objetivo más cercano dentro del FOV",
        WallCheck_Title = "Wall Check",
        WallCheck_Desc = "Verifica si hay paredes entre tú y el objetivo",
        Smooth_Title = "Suavizado (Smooth)",
        Smooth_Desc = "Controla la suavidad del apuntado. Menor = más pegajoso, Mayor = más suave",
        ShowFOV_Title = "Mostrar FOV",
        ShowFOV_Desc = "Círculo visual que muestra el alcance del aimbot en pantalla",
        FOVSize_Title = "Tamaño del FOV",
        FOVSize_Desc = "Define el radio del círculo de alcance del aimbot",
        FOVColor_Title = "Color del FOV",
        FOVColor_Desc = "Personaliza el color del círculo de FOV",
        
        ESPBox_Title = "ESP Box",
        ESPBox_Desc = "Dibuja cajas alrededor de los jugadores",
        ESPBoxColor_Title = "Color de Box",
        ESPBoxColor_Desc = "Elige el color de las cajas",
        ESPName_Title = "ESP Name",
        ESPName_Desc = "Muestra nombre y distancia encima de los jugadores",
        ESPNameColor_Title = "Color del Nombre",
        ESPNameColor_Desc = "Elige el color de los nombres",
        ESPSkeleton_Title = "ESP Skeleton",
        ESPSkeleton_Desc = "Dibuja líneas formando el esqueleto de los jugadores",
        ESPSkeletonColor_Title = "Color del Skeleton",
        ESPSkeletonColor_Desc = "Elige el color del esqueleto",
        ESPTracer_Title = "ESP Tracer",
        ESPTracer_Desc = "Dibuja líneas hacia los jugadores desde la parte inferior",
        ESPTracerColor_Title = "Color del Tracer",
        ESPTracerColor_Desc = "Elige el color de las líneas de tracer",
        
        Speed_Title = "Speed Hack",
        Speed_Desc = "Activa la velocidad personalizada de movimiento",
        SpeedVal_Title = "Valor de Velocidad",
        SpeedVal_Desc = "Define la velocidad de movimiento (16 = normal, 25 = máximo seguro)",
        FOV_Title = "Campo de Visión (FOV)",
        FOV_Desc = "Altera el campo de visión de la cámara (60 = normal, 300 = ultra wide)"
    },
    ["English"] = {
        LanguageTitle = "Language / Idioma",
        LanguageDesc = "Select the Hub language",
        ShowFPS_Title = "Show FPS",
        ShowFPS_Desc = "Displays FPS counter in the top right corner",
        HitSound_Title = "Enable Hit Sound",
        HitSound_Desc = "Replaces the game's hit sound",
        ChooseSound_Title = "Choose Sound",
        ChooseSound_Desc = "Select which sound will play when hitting an enemy",
        HitVolume_Title = "Hit Sound Volume",
        HitVolume_Desc = "Adjusts sound volume (0.1 = low, 2.0 = high)",
        
        Aimbot_Title = "Enable Aimbot",
        Aimbot_Desc = "Automatically aims at the closest target inside FOV",
        WallCheck_Title = "Wall Check",
        WallCheck_Desc = "Checks for walls between you and the target",
        Smooth_Title = "Smooth Aim",
        Smooth_Desc = "Controls aim smoothness. Lower = stickier, Higher = smoother",
        ShowFOV_Title = "Show FOV",
        ShowFOV_Desc = "Visual circle showing aimbot reach on screen",
        FOVSize_Title = "FOV Size",
        FOVSize_Desc = "Sets the radius of aimbot reach circle",
        FOVColor_Title = "FOV Color",
        FOVColor_Desc = "Customize the color of the FOV circle",
        
        ESPBox_Title = "ESP Box",
        ESPBox_Desc = "Draws 2D boxes around players",
        ESPBoxColor_Title = "Box Color",
        ESPBoxColor_Desc = "Choose box color",
        ESPName_Title = "ESP Name",
        ESPName_Desc = "Shows name and distance above players",
        ESPNameColor_Title = "Name Color",
        ESPNameColor_Desc = "Choose text color",
        ESPSkeleton_Title = "ESP Skeleton",
        ESPSkeleton_Desc = "Draws lines forming players' skeletons",
        ESPSkeletonColor_Title = "Skeleton Color",
        ESPSkeletonColor_Desc = "Choose skeleton color",
        ESPTracer_Title = "ESP Tracer",
        ESPTracer_Desc = "Draws lines to players from screen bottom",
        ESPTracerColor_Title = "Tracer Color",
        ESPTracerColor_Desc = "Choose tracer lines color",
        
        Speed_Title = "Speed Hack",
        Speed_Desc = "Enables custom movement speed",
        SpeedVal_Title = "Speed Value",
        SpeedVal_Desc = "Sets movement speed (16 = default, 25 = max safe)",
        FOV_Title = "Field of View (FOV)",
        FOV_Desc = "Changes camera field of view (60 = default, 300 = ultra wide)"
    }
}

local function updateText(elem, title, desc)
    if not elem then return end
    if elem.SetTitle then pcall(function() elem:SetTitle(title) end) end
    if elem.SetDesc then pcall(function() elem:SetDesc(desc) end) end
    if elem.SetDescription then pcall(function() elem:SetDescription(desc) end) end
end

function F4eddyScrips.ApplyLanguage(lang)
    local t = Translations[lang] or Translations["Español"]
    
    updateText(F4eddyScrips.UI.LangDropdown, t.LanguageTitle, t.LanguageDesc)
    updateText(F4eddyScrips.UI.ToggleFPS, t.ShowFPS_Title, t.ShowFPS_Desc)
    updateText(F4eddyScrips.UI.ToggleHitSound, t.HitSound_Title, t.HitSound_Desc)
    updateText(F4eddyScrips.UI.DropHitSound, t.ChooseSound_Title, t.ChooseSound_Desc)
    updateText(F4eddyScrips.UI.SliderHitVol, t.HitVolume_Title, t.HitVolume_Desc)
    
    updateText(F4eddyScrips.UI.ToggleAimbot, t.Aimbot_Title, t.Aimbot_Desc)
    updateText(F4eddyScrips.UI.ToggleWallCheck, t.WallCheck_Title, t.WallCheck_Desc)
    updateText(F4eddyScrips.UI.SliderSmooth, t.Smooth_Title, t.Smooth_Desc)
    updateText(F4eddyScrips.UI.ToggleShowFOV, t.ShowFOV_Title, t.ShowFOV_Desc)
    updateText(F4eddyScrips.UI.SliderFOVSize, t.FOVSize_Title, t.FOVSize_Desc)
    updateText(F4eddyScrips.UI.ColorFOV, t.FOVColor_Title, t.FOVColor_Desc)
    
    updateText(F4eddyScrips.UI.ToggleESPBox, t.ESPBox_Title, t.ESPBox_Desc)
    updateText(F4eddyScrips.UI.ColorESPBox, t.ESPBoxColor_Title, t.ESPBoxColor_Desc)
    updateText(F4eddyScrips.UI.ToggleESPName, t.ESPName_Title, t.ESPName_Desc)
    updateText(F4eddyScrips.UI.ColorESPName, t.ESPNameColor_Title, t.ESPNameColor_Desc)
    updateText(F4eddyScrips.UI.ToggleESPSkeleton, t.ESPSkeleton_Title, t.ESPSkeleton_Desc)
    updateText(F4eddyScrips.UI.ColorESPSkeleton, t.ESPSkeletonColor_Title, t.ESPSkeletonColor_Desc)
    updateText(F4eddyScrips.UI.ToggleESPTracer, t.ESPTracer_Title, t.ESPTracer_Desc)
    updateText(F4eddyScrips.UI.ColorESPTracer, t.ESPTracerColor_Title, t.ESPTracerColor_Desc)
    
    updateText(F4eddyScrips.UI.ToggleSpeed, t.Speed_Title, t.Speed_Desc)
    updateText(F4eddyScrips.UI.SliderSpeed, t.SpeedVal_Title, t.SpeedVal_Desc)
    updateText(F4eddyScrips.UI.SliderCustomFOV, t.FOV_Title, t.FOV_Desc)
end

-- ============================================
-- ABA MAIN
-- ============================================

F4eddyScrips.UI.LangDropdown = F4eddyScrips.TabMain:Dropdown({
    Title = "Idioma / Language",
    Desc = "Selecciona el idioma del Hub",
    Values = {
        { Title = "Español", Icon = "globe" },
        { Title = "English", Icon = "globe" }
    },
    Value = "Español",
    Callback = function(option)
        F4eddyScrips.Language = option.Title
        F4eddyScrips.ApplyLanguage(option.Title)
        F4eddyScrips.Window:Notify({
            Title = "Idioma / Language",
            Description = (option.Title == "Español" and "Idioma cambiado a: Español") or "Language changed to: English",
            Duration = 2
        })
    end
})

F4eddyScrips.TabMain:Divider({Text = "FPS"})

-- FPS Counter
F4eddyScrips.FPSText = Drawing.new("Text")
F4eddyScrips.FPSText.Size = 20
F4eddyScrips.FPSText.Center = false
F4eddyScrips.FPSText.Outline = true
F4eddyScrips.FPSText.Color = Color3.fromRGB(0, 133, 255)
F4eddyScrips.FPSText.Visible = false
F4eddyScrips.FPSText.Text = "FPS: 0"
F4eddyScrips.FPSText.ZIndex = 1000

local lastTime = tick()
local frameCount = 0
local currentFPS = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    if currentTime - lastTime >= 1 then
        currentFPS = frameCount
        frameCount = 0
        lastTime = currentTime
        F4eddyScrips.FPSText.Text = "FPS: " .. tostring(currentFPS)
    end

    if F4eddyScrips.FPSText.Visible then
        local textWidth = 70
        F4eddyScrips.FPSText.Position = Vector2.new(Camera.ViewportSize.X - textWidth, 10)
    end
end)

F4eddyScrips.UI.ToggleFPS = F4eddyScrips.TabMain:Toggle({
    Title = "Mostrar FPS",
    Desc = "Muestra el contador de FPS en la esquina superior derecha",
    Default = false,
    Callback = function(v)
        F4eddyScrips.FPSText.Visible = v
    end
})

F4eddyScrips.TabMain:Divider({Text = "Hit Sound"})

F4eddyScrips.UI.ToggleHitSound = F4eddyScrips.TabMain:Toggle({
    Title = "Activar Hit Sound",
    Desc = "Reemplaza el sonido de impacto del juego",
    Default = false,
    Callback = function(v)
        F4eddyScrips.HitSoundEnabled = v
        F4eddyScrips.ReplaceAllHitSounds()
    end
})

F4eddyScrips.UI.DropHitSound = F4eddyScrips.TabMain:Dropdown({
    Title = "Elegir Sonido",
    Desc = "Selecciona qué sonido se reproducirá al golpear a un enemigo",
    Values = {
        { Title = "Bell", Icon = "bell" },
        { Title = "Bameware", Icon = "zap" },
        { Title = "Skeet", Icon = "target" },
        { Title = "Cod Hitmarker", Icon = "crosshair" },
        { Title = "Neverlose", Icon = "zap" },
        { Title = "Minecraft", Icon = "box" }
    },
    Value = "Bell",
    Callback = function(option)
        local soundID = F4eddyScrips.HitSounds[option.Title]
        if soundID then
            F4eddyScrips.HitSoundID = soundID
            F4eddyScrips.ReplaceAllHitSounds()
            F4eddyScrips.Window:Notify({
                Title = "Hit Sound",
                Description = "Sonido cambiado a: " .. option.Title,
                Duration = 2
            })
        end
    end
})

F4eddyScrips.UI.SliderHitVol = F4eddyScrips.TabMain:Slider({
    Title = "Volumen de Hit Sound",
    Desc = "Ajusta el volumen del sonido (0.1 = bajo, 2.0 = alto)",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 2.0,
        Default = 0.5,
    },
    Callback = function(value)
        F4eddyScrips.HitSoundVolume = value
        F4eddyScrips.ReplaceAllHitSounds()
    end
})

-- ============================================
-- ABA AIMBOT
-- ============================================

F4eddyScrips.UI.ToggleAimbot = F4eddyScrips.TabAimbot:Toggle({
    Title = "Activar Aimbot",
    Desc = "Apunta automáticamente al objetivo más cercano dentro del FOV",
    Default = false,
    Callback = function(v)
        F4eddyScrips.AimbotEnabled = v
    end
})

F4eddyScrips.UI.ToggleWallCheck = F4eddyScrips.TabAimbot:Toggle({
    Title = "Wall Check",
    Desc = "Verifica si hay paredes entre tú y el objetivo",
    Default = false,
    Callback = function(v) F4eddyScrips.WallCheck = v end
})

F4eddyScrips.UI.SliderSmooth = F4eddyScrips.TabAimbot:Slider({
    Title = "Suavizado (Smooth)",
    Desc = "Controla la suavidad del apuntado. Menor = más pegajoso, Mayor = más suave",
    Step = 1,
    Value = {
        Min = 1,
        Max = 20,
        Default = 5,
    },
    Callback = function(value)
        F4eddyScrips.SmoothAim = value
    end
})

F4eddyScrips.UI.ToggleShowFOV = F4eddyScrips.TabAimbot:Toggle({
    Title = "Mostrar FOV",
    Desc = "Círculo visual que muestra el alcance del aimbot en pantalla",
    Default = false,
    Callback = function(v)
        F4eddyScrips.FOVEnabled = v
        F4eddyScrips.FOVCircle.Frame.Visible = v
    end
})

F4eddyScrips.UI.SliderFOVSize = F4eddyScrips.TabAimbot:Slider({
    Title = "Tamaño del FOV",
    Desc = "Define el radio del círculo de alcance del aimbot",
    Step = 10,
    Value = {
        Min = 10,
        Max = 300,
        Default = 100,
    },
    Callback = function(value)
        F4eddyScrips.FOVSize = value
        local size = value * 2
        F4eddyScrips.FOVCircle.Frame.Size = UDim2.new(0, size, 0, size)
    end
})

F4eddyScrips.UI.ColorFOV = F4eddyScrips.TabAimbot:Colorpicker({
    Title = "Color del FOV",
    Desc = "Personaliza el color del círculo de FOV",
    Default = Color3.fromRGB(0, 133, 255),
    Callback = function(c)
        F4eddyScrips.FOVColor = c
        F4eddyScrips.FOVCircle.Stroke.Color = c
    end
})

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        F4eddyScrips.SetupCharacterDeath(player)
        player.CharacterAdded:Connect(function()
            F4eddyScrips.RemoveESP(player)
            wait(0.5)
            F4eddyScrips.SetupCharacterDeath(player)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        F4eddyScrips.SetupCharacterDeath(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    F4eddyScrips.RemoveESP(player)
end)

-- ============================================
-- ABA ESP
-- ============================================

F4eddyScrips.UI.ToggleESPBox = F4eddyScrips.TabESP:Toggle({
    Title = "ESP Box",
    Desc = "Dibuja cajas alrededor de los jugadores",
    Default = false,
    Callback = function(v) F4eddyScrips.ESPSettings.Outline.Enabled = v end
})

F4eddyScrips.UI.ColorESPBox = F4eddyScrips.TabESP:Colorpicker({
    Title = "Color de Box",
    Desc = "Elige el color de las cajas",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(c) F4eddyScrips.ESPSettings.Outline.Color = c end
})

F4eddyScrips.UI.ToggleESPName = F4eddyScrips.TabESP:Toggle({
    Title = "ESP Name",
    Desc = "Muestra nombre y distancia encima de los jugadores",
    Default = false,
    Callback = function(v) F4eddyScrips.ESPSettings.Name.Enabled = v end
})

F4eddyScrips.UI.ColorESPName = F4eddyScrips.TabESP:Colorpicker({
    Title = "Color del Nombre",
    Desc = "Elige el color de los nombres",
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(c) F4eddyScrips.ESPSettings.Name.Color = c end
})

F4eddyScrips.UI.ToggleESPSkeleton = F4eddyScrips.TabESP:Toggle({
    Title = "ESP Skeleton",
    Desc = "Dibuja líneas formando el esqueleto de los jugadores",
    Default = false,
    Callback = function(v) F4eddyScrips.ESPSettings.Skeleton.Enabled = v end
})

F4eddyScrips.UI.ColorESPSkeleton = F4eddyScrips.TabESP:Colorpicker({
    Title = "Color del Skeleton",
    Desc = "Elige el color del esqueleto",
    Default = Color3.fromRGB(0, 133, 255),
    Callback = function(c) F4eddyScrips.ESPSettings.Skeleton.Color = c end
})

F4eddyScrips.UI.ToggleESPTracer = F4eddyScrips.TabESP:Toggle({
    Title = "ESP Tracer",
    Desc = "Dibuja líneas hacia los jugadores desde la parte inferior",
    Default = false,
    Callback = function(v) F4eddyScrips.ESPSettings.Tracer.Enabled = v end
})

F4eddyScrips.UI.ColorESPTracer = F4eddyScrips.TabESP:Colorpicker({
    Title = "Color del Tracer",
    Desc = "Elige el color de las líneas de tracer",
    Default = Color3.fromRGB(0, 255, 255),
    Callback = function(c) F4eddyScrips.ESPSettings.Tracer.Color = c end
})

-- ============================================
-- ABA RAGE
-- ============================================

F4eddyScrips.UI.ToggleSpeed = F4eddyScrips.TabRage:Toggle({
    Title = "Speed Hack",
    Desc = "Activa la velocidad personalizada de movimiento",
    Default = false,
    Callback = function(v)
        F4eddyScrips.SpeedEnabled = v
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v and F4eddyScrips.SpeedValue or 16
        end
    end
})

F4eddyScrips.UI.SliderSpeed = F4eddyScrips.TabRage:Slider({
    Title = "Valor de Velocidad",
    Desc = "Define la velocidad de movimiento (16 = normal, 25 = máximo seguro)",
    Step = 1,
    Value = {
        Min = 16,
        Max = 25,
        Default = 16,
    },
    Callback = function(value)
        F4eddyScrips.SpeedValue = value
        if F4eddyScrips.SpeedEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = value
            end
        end
    end
})

F4eddyScrips.UI.SliderCustomFOV = F4eddyScrips.TabRage:Slider({
    Title = "Campo de Visión (FOV)",
    Desc = "Altera el campo de visión de la cámara (60 = normal, 300 = ultra wide)",
    Step = 10,
    Value = {
        Min = 60,
        Max = 300,
        Default = 70,
    },
    Callback = function(value)
        F4eddyScrips.CustomFOV = value
        F4eddyScrips.CustomFOVEnabled = true
    end
})

-- Activar Español como idioma principal al ejecutar
F4eddyScrips.ApplyLanguage("Español")

-- ============================================
-- FUNCIÓN DE ACTUALIZAR ESP
-- ============================================

function F4eddyScrips.UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local shouldRemoveESP = false

            if not player.Character then
                shouldRemoveESP = true
            else
                local char = player.Character
                local humanoid = char:FindFirstChild("Humanoid")
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")

                if not humanoid or humanoid.Health <= 0 or not rootPart or not head then
                    shouldRemoveESP = true
                else
                    local localChar = LocalPlayer.Character
                    if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                        local distance = (rootPart.Position - localChar.HumanoidRootPart.Position).Magnitude
                        if distance > 1000 then
                            shouldRemoveESP = true
                        end
                    end
                end
            end

            if shouldRemoveESP then
                F4eddyScrips.RemoveESP(player)
            elseif player.Character then
                F4eddyScrips.CreateESP(player)

                local char = player.Character
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")

                if rootPart and head then
                    -- ESP Box
                    if F4eddyScrips.ESPSettings.Outline.Enabled then
                        if #F4eddyScrips.ESPObjects[player].Outline == 0 then
                            for i = 1, 4 do
                                local line = Drawing.new("Line")
                                line.Thickness = 2
                                line.Transparency = 1
                                table.insert(F4eddyScrips.ESPObjects[player].Outline, line)
                            end
                        end

                        local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                        if onScreen then
                            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height / 2

                            F4eddyScrips.ESPObjects[player].Outline[1].From = Vector2.new(pos.X - width, headPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[1].To = Vector2.new(pos.X + width, headPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[1].Color = F4eddyScrips.ESPSettings.Outline.Color
                            F4eddyScrips.ESPObjects[player].Outline[1].Visible = true

                            F4eddyScrips.ESPObjects[player].Outline[2].From = Vector2.new(pos.X - width, legPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[2].To = Vector2.new(pos.X + width, legPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[2].Color = F4eddyScrips.ESPSettings.Outline.Color
                            F4eddyScrips.ESPObjects[player].Outline[2].Visible = true

                            F4eddyScrips.ESPObjects[player].Outline[3].From = Vector2.new(pos.X - width, headPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[3].To = Vector2.new(pos.X - width, legPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[3].Color = F4eddyScrips.ESPSettings.Outline.Color
                            F4eddyScrips.ESPObjects[player].Outline[3].Visible = true

                            F4eddyScrips.ESPObjects[player].Outline[4].From = Vector2.new(pos.X + width, headPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[4].To = Vector2.new(pos.X + width, legPos.Y)
                            F4eddyScrips.ESPObjects[player].Outline[4].Color = F4eddyScrips.ESPSettings.Outline.Color
                            F4eddyScrips.ESPObjects[player].Outline[4].Visible = true
                        else
                            for _, line in pairs(F4eddyScrips.ESPObjects[player].Outline) do
                                line.Visible = false
                            end
                        end
                    else
                        for _, line in pairs(F4eddyScrips.ESPObjects[player].Outline) do
                            line.Visible = false
                        end
                    end

                    -- ESP Name com Distância
                    if F4eddyScrips.ESPSettings.Name.Enabled then
                        if not F4eddyScrips.ESPObjects[player].Name then
                            F4eddyScrips.ESPObjects[player].Name = Drawing.new("Text")
                            F4eddyScrips.ESPObjects[player].Name.Center = true
                            F4eddyScrips.ESPObjects[player].Name.Outline = true
                            F4eddyScrips.ESPObjects[player].Name.Size = 13
                        end

                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))

                        local localChar = LocalPlayer.Character
                        local distance = 0
                        if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                            distance = (rootPart.Position - localChar.HumanoidRootPart.Position).Magnitude
                        end

                        local distanceText = string.format("%dm", math.floor(distance))
                        F4eddyScrips.ESPObjects[player].Name.Text = player.Name .. " | " .. distanceText

                        F4eddyScrips.ESPObjects[player].Name.Position = Vector2.new(pos.X, pos.Y)
                        F4eddyScrips.ESPObjects[player].Name.Color = F4eddyScrips.ESPSettings.Name.Color
                        F4eddyScrips.ESPObjects[player].Name.Visible = onScreen
                    elseif F4eddyScrips.ESPObjects[player].Name then
                        F4eddyScrips.ESPObjects[player].Name.Visible = false
                    end

                    -- ESP Skeleton
                    if F4eddyScrips.ESPSettings.Skeleton.Enabled then
                        if #F4eddyScrips.ESPObjects[player].Skeleton == 0 then
                            for i = 1, 5 do
                                local line = Drawing.new("Line")
                                line.Thickness = 1
                                line.Transparency = 1
                                table.insert(F4eddyScrips.ESPObjects[player].Skeleton, line)
                            end
                        end

                        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
                        local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm")
                        local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
                        local leftLeg = char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftUpperLeg")
                        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg")

                        if torso then
                            local headP, headOnScreen = Camera:WorldToViewportPoint(head.Position)
                            local torsoP, torsoOnScreen = Camera:WorldToViewportPoint(torso.Position)

                            if headOnScreen and torsoOnScreen then
                                F4eddyScrips.ESPObjects[player].Skeleton[1].From = Vector2.new(headP.X, headP.Y)
                                F4eddyScrips.ESPObjects[player].Skeleton[1].To = Vector2.new(torsoP.X, torsoP.Y)
                                F4eddyScrips.ESPObjects[player].Skeleton[1].Color = F4eddyScrips.ESPSettings.Skeleton.Color
                                F4eddyScrips.ESPObjects[player].Skeleton[1].Visible = true

                                if leftArm then
                                    local armP, armOnScreen = Camera:WorldToViewportPoint(leftArm.Position)
                                    if armOnScreen then
                                        F4eddyScrips.ESPObjects[player].Skeleton[2].From = Vector2.new(torsoP.X, torsoP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[2].To = Vector2.new(armP.X, armP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[2].Color = F4eddyScrips.ESPSettings.Skeleton.Color
                                        F4eddyScrips.ESPObjects[player].Skeleton[2].Visible = true
                                    else
                                        F4eddyScrips.ESPObjects[player].Skeleton[2].Visible = false
                                    end
                                end

                                if rightArm then
                                    local armP, armOnScreen = Camera:WorldToViewportPoint(rightArm.Position)
                                    if armOnScreen then
                                        F4eddyScrips.ESPObjects[player].Skeleton[3].From = Vector2.new(torsoP.X, torsoP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[3].To = Vector2.new(armP.X, armP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[3].Color = F4eddyScrips.ESPSettings.Skeleton.Color
                                        F4eddyScrips.ESPObjects[player].Skeleton[3].Visible = true
                                    else
                                        F4eddyScrips.ESPObjects[player].Skeleton[3].Visible = false
                                    end
                                end

                                if leftLeg then
                                    local legP, legOnScreen = Camera:WorldToViewportPoint(leftLeg.Position)
                                    if legOnScreen then
                                        F4eddyScrips.ESPObjects[player].Skeleton[4].From = Vector2.new(torsoP.X, torsoP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[4].To = Vector2.new(legP.X, legP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[4].Color = F4eddyScrips.ESPSettings.Skeleton.Color
                                        F4eddyScrips.ESPObjects[player].Skeleton[4].Visible = true
                                    else
                                        F4eddyScrips.ESPObjects[player].Skeleton[4].Visible = false
                                    end
                                end

                                if rightLeg then
                                    local legP, legOnScreen = Camera:WorldToViewportPoint(rightLeg.Position)
                                    if legOnScreen then
                                        F4eddyScrips.ESPObjects[player].Skeleton[5].From = Vector2.new(torsoP.X, torsoP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[5].To = Vector2.new(legP.X, legP.Y)
                                        F4eddyScrips.ESPObjects[player].Skeleton[5].Color = F4eddyScrips.ESPSettings.Skeleton.Color
                                        F4eddyScrips.ESPObjects[player].Skeleton[5].Visible = true
                                    else
                                        F4eddyScrips.ESPObjects[player].Skeleton[5].Visible = false
                                    end
                                end
                            else
                                for _, line in pairs(F4eddyScrips.ESPObjects[player].Skeleton) do
                                    line.Visible = false
                                end
                            end
                        else
                            for _, line in pairs(F4eddyScrips.ESPObjects[player].Skeleton) do
                                line.Visible = false
                            end
                        end
                    else
                        for _, line in pairs(F4eddyScrips.ESPObjects[player].Skeleton) do
                            line.Visible = false
                        end
                    end

                    -- ESP Tracer
                    if F4eddyScrips.ESPSettings.Tracer.Enabled then
                        if not F4eddyScrips.ESPObjects[player].Tracer then
                            F4eddyScrips.ESPObjects[player].Tracer = Drawing.new("Line")
                            F4eddyScrips.ESPObjects[player].Tracer.Thickness = 1
                            F4eddyScrips.ESPObjects[player].Tracer.Transparency = 1
                        end

                        local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                        F4eddyScrips.ESPObjects[player].Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        F4eddyScrips.ESPObjects[player].Tracer.To = Vector2.new(pos.X, pos.Y)
                        F4eddyScrips.ESPObjects[player].Tracer.Color = F4eddyScrips.ESPSettings.Tracer.Color
                        F4eddyScrips.ESPObjects[player].Tracer.Visible = onScreen
                    elseif F4eddyScrips.ESPObjects[player].Tracer then
                        F4eddyScrips.ESPObjects[player].Tracer.Visible = false
                    end
                end
            end
        end
    end
end

-- ============================================
-- DETECTAR RESPAWN
-- ============================================

LocalPlayer.CharacterAdded:Connect(function(character)
    wait(0.5)
    
    if F4eddyScrips.SpeedEnabled then
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = F4eddyScrips.SpeedValue
        end
    end
end)

-- ============================================
-- LOOP PRINCIPAL
-- ============================================

RunService.RenderStepped:Connect(function()
    if F4eddyScrips.FOVCircle and F4eddyScrips.FOVCircle.Frame then
        F4eddyScrips.FOVCircle.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        F4eddyScrips.FOVCircle.Frame.Visible = F4eddyScrips.FOVEnabled
    end

    if F4eddyScrips.CustomFOVEnabled then
        Camera.FieldOfView = F4eddyScrips.CustomFOV
    end

    if F4eddyScrips.AimbotEnabled then
        local target = F4eddyScrips.GetClosestPlayer()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild("Head")
            if targetPart then
                local targetPos = targetPart.Position
                local cameraPos = Camera.CFrame.Position
                local targetCFrame = CFrame.new(cameraPos, targetPos)
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1 / F4eddyScrips.SmoothAim)
            end
        end
    end

    if F4eddyScrips.SpeedEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if char.Humanoid.WalkSpeed ~= F4eddyScrips.SpeedValue then
                char.Humanoid.WalkSpeed = F4eddyScrips.SpeedValue
            end
        end
    end

    pcall(F4eddyScrips.UpdateESP)
end)

-- ============================================
-- NOTIFICAÇÃO DE CARREGAMENTO
-- ============================================

WindUI:Notify({
    Title = "F4eddyScrips CARREGADO",
    Content = "F4eddyScrips CARREGADO COM SUCESSO!",
    Duration = 4,
    Icon = "zap",
})

print("F4eddyScrips Flick Fps V1.6 - Carregado com sucesso!")
