local v8 = game:GetService("Players")
local v9 = game:GetService("TeleportService")
local v10 = game:GetService("ReplicatedStorage")
local v11 = v8.LocalPlayer
local v12 = v10.Remotes:WaitForChild("BuyCase")
local v13 = game:GetService("RunService")
local v14 = game:GetService("VirtualUser")
local v15 = game:GetService("Workspace")
local v16 = game:GetService("UserInputService")
local v10 = game:GetService("ReplicatedStorage")
local v17 = require(v10.Modules:WaitForChild("Item"))
local v18 = v10.Remotes:WaitForChild("TradeItem")
local v19 = v10.Remotes:WaitForChild("Trade")
local v20 = v11.PlayerGui.Main.MainTradingFrame
local v21 = v11:WaitForChild("SkinsFolder")
local v22 = v10.Remotes:WaitForChild("EquipItem")
local v23 = v11:WaitForChild("Backpack")
local v24 = v11:GetMouse()
local v25 = game:GetService("UserInputService")
local v26 = game:GetService("TweenService")
local v27 = v8.LocalPlayer
local v28 = v27:WaitForChild("PlayerGui")
local v29 = game:GetService("HttpService")
local v27 = game:GetService("Players").LocalPlayer
local v30 = game:GetService("RunService")
local v31 = nil
local v32 = v10.Remotes:WaitForChild("TradeItem")
local v8 = game:GetService("Players")
local v29 = game:GetService("HttpService")
local v25 = game:GetService("UserInputService")
task.wait(708 - (667 + 40))
local v27 = v8.LocalPlayer
if not v27 then
    local v784 = 1310 - (436 + 874)
    while true do
        if v784 == (1606 - (762 + 844)) then
            repeat
                task.wait()
            until v8.LocalPlayer
            v27 = v8.LocalPlayer
            break
        end
    end
end
local v33 = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local v34 = v33:CreateWindow({
    ["Name"] = "F4edddyScript By LuxUC8",
    ["LoadingTitle"] = "F4edddyScript",
    ["LoadingSubtitle"] = "By LuxUC8",
    ["ConfigurationSaving"] = { ["Enabled"] = true, ["FolderName"] = "F4edddyScriptConfig", ["FileName"] = "F4edddyScript" },
    ["KeySystem"] = false,
})
local function v35()
    local v151 = 0 - 0
    local v152
    local v153
    local v154
    while true do
        if v151 == 0 then
            local v913 = 0
            while true do
                if (2 - 1) == v913 then
                    v151 = 1 + 0
                    break
                end
                if v913 == (0 + 0) then
                    v152, v153, v154 = pcall(function()
                        local v1280 = 0
                        local v1281
                        local v1282
                        local v1283
                        local v1284
                        local v1285
                        while true do
                            if v1280 == (476 - (209 + 267)) then
                                v1281 = 0 - 0
                                v1282 = nil
                                v1280 = 2 - 1
                            end
                            if v1280 == 1 then
                                v1283 = nil
                                v1284 = nil
                                v1280 = 1713 - (1611 + 100)
                            end
                            if v1280 == 2 then
                                v1285 = nil
                                while true do
                                    if v1281 == (0 + 0) then
                                        v1282 = v11:FindFirstChildOfClass("PlayerGui")
                                        if not v1282 then
                                            return nil, nil
                                        end
                                        v1281 = 785 - (14 + 770)
                                    end
                                    if v1281 == (1788 - (1165 + 619)) then
                                        return v1285:FindFirstChild("TeamRedFrame"),
                                            v1285:FindFirstChild("TeamBlueFrame")
                                    end
                                    if v1281 == 3 then
                                        v1285 = v1284:FindFirstChild("PlayersFrame")
                                        if not v1285 then
                                            return nil, nil
                                        end
                                        v1281 = 4
                                    end
                                    if v1281 == (2 - 0) then
                                        v1284 = v1283:FindFirstChild("MainGameFrame")
                                        if not v1284 then
                                            return nil, nil
                                        end
                                        v1281 = 384 - (229 + 152)
                                    end
                                    if v1281 == (195 - (107 + 87)) then
                                        v1283 = v1282:FindFirstChild("Main")
                                        if not v1283 then
                                            return nil, nil
                                        end
                                        v1281 = 2 - 0
                                    end
                                end
                                break
                            end
                        end
                    end)
                    if not v152 or not v153 or not v154 then
                        return nil, nil
                    end
                    v913 = 1 + 0
                end
            end
        end
        if (1 + 0) == v151 then
            return v153, v154
        end
    end
end
local function v36(v155)
    local v156 = 0 - 0
    local v157
    while true do
        if v156 == 0 then
            local v914 = 0 - 0
            while true do
                if v914 == (1 + 0) then
                    v156 = 15 - (13 + 1)
                    break
                end
                if v914 == (0 + 0) then
                    v157 = {}
                    for v1286, v1287 in ipairs(v155:GetChildren()) do
                        if v1287:IsA("Frame") then
                            table.insert(v157, v1287.Name)
                        end
                    end
                    v914 = 1
                end
            end
        end
        if v156 == (1 + 0) then
            return v157
        end
    end
end
local function v37(v158)
    return tostring(v158):gsub("%s+", "")
end
local function v38()
    local v159 = 1058 - (987 + 71)
    local v160
    local v161
    local v162
    local v163
    local v164
    local v165
    local v166
    local v167
    local v168
    local v169
    while true do
        if v159 == 0 then
            local v915 = 0
            while true do
                if v915 == (2 - 1) then
                    v162 = v36(v160)
                    v163 = v36(v161)
                    v915 = 2 - 0
                end
                if 0 == v915 then
                    v160, v161 = v35()
                    if not v160 or not v161 then
                        return {}
                    end
                    v915 = 700 - (514 + 185)
                end
                if v915 == (1 + 1) then
                    v159 = 1
                    break
                end
            end
        end
        if v159 == 1 then
            v164, v165 = false, false
            v166, v167 = {}, {}
            for v1055, v1056 in ipairs(v162) do
                local v1057 = 0 - 0
                local v1058
                while true do
                    if v1057 == (0 - 0) then
                        v1058 = v37(v1056)
                        v166[v1058] = true
                        v1057 = 1505 - (771 + 733)
                    end
                    if 1 == v1057 then
                        if v1058 == v37(v11.Name) then
                            v164 = true
                        end
                        break
                    end
                end
            end
            for v1059, v1060 in ipairs(v163) do
                local v1061 = 0 - 0
                local v1062
                while true do
                    if v1061 == (0 - 0) then
                        local v1289 = 0
                        while true do
                            if v1289 == 0 then
                                v1062 = v37(v1060)
                                v167[v1062] = true
                                v1289 = 1168 - (407 + 760)
                            end
                            if v1289 == 1 then
                                v1061 = 1 + 0
                                break
                            end
                        end
                    end
                    if v1061 == (1 + 0) then
                        if v1062 == v37(v11.Name) then
                            v165 = true
                        end
                        break
                    end
                end
            end
            v159 = 2 + 0
        end
        if v159 == 2 then
            if not (v164 or v165) then
                return {}
            end
            v168 = (v164 and v167) or v166
            v169 = {}
            for v1063, v1064 in pairs(v168) do
                for v1156, v1157 in ipairs(v8:GetPlayers()) do
                    if (v37(v1157.Name) == v1063) and (v1157 ~= v11) then
                        table.insert(v169, v1157)
                    end
                end
            end
            v159 = 1857 - (169 + 1685)
        end
        if (1 + 2) == v159 then
            return v169
        end
    end
end
local function v39(v170)
    local v171 = game:GetService("Players")
    local v172 = game:GetService("ReplicatedStorage")
    local v173 = game:GetService("UserInputService")
    local v174 = game:GetService("RunService")
    local v175 = game:GetService("TweenService")
    local v176 = v171.LocalPlayer
    local v177 = v176:WaitForChild("PlayerGui")
    if v177:FindFirstChild("F4edddyScriptItemViewer") then
        v177:FindFirstChild("F4edddyScriptItemViewer"):Destroy()
    end
    local v178 = v170
    local v179 = Instance.new("ScreenGui")
    v179.Name = "F4edddyScriptItemViewer"
    v179.ResetOnSpawn = false
    v179.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v179.IgnoreGuiInset = true
    v179.Parent = v177
    local v186 = Instance.new("BlurEffect")
    v186.Size = 391 - (41 + 350)
    v186.Parent = game.Lighting
    local function v190()
        return v173.TouchEnabled and not v173.KeyboardEnabled
    end
    local v191 = Instance.new("Frame")
    v191.Name = "MainFrame"
    v191.AnchorPoint = Vector2.new(0.5, 0.5 - 0)
    v191.Position = UDim2.new(0.5 - 0, 0 - 0, 0.5, 0 - 0)
    v191.Size = (v190() and UDim2.new(0.88 + 0, 887 - (790 + 97), 0 - 0, 94 + 226))
        or UDim2.new(0 + 0, 550, 0, 565 - (235 + 10))
    v191.BackgroundColor3 = Color3.fromRGB(11 + 4, 30 - 15, 25)
    v191.BorderSizePixel = 1183 - (887 + 296)
    v191.ClipsDescendants = true
    v191.Parent = v179
    local v200 = Instance.new("UICorner")
    v200.CornerRadius = UDim.new(0, 15)
    v200.Parent = v191
    local v203 = Instance.new("UIStroke")
    v203.Color = Color3.fromRGB(1145 - (512 + 533), 1524 - (662 + 762), 797 - (334 + 343))
    v203.Thickness = 3 - 2
    v203.Transparency = 0.7
    v203.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v203.Parent = v191
    local v210 = Instance.new("Frame")
    v210.Name = "Header"
    v210.Size = UDim2.new(490 - (198 + 291), 0 + 0, 574 - (141 + 433), 28)
    v210.BackgroundColor3 = Color3.fromRGB(1196 - 941, 107, 30 + 23)
    v210.BorderSizePixel = 0
    v210.Parent = v191
    local v216 = Instance.new("UIGradient")
    v216.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0 - 0, Color3.fromRGB(700 - 445, 210 - (72 + 31), 53)),
        ColorSequenceKeypoint.new(1 + 0, Color3.fromRGB(255, 69, 0 + 0)),
    })
    v216.Rotation = 18 + 72
    v216.Parent = v210
    local v220 = Instance.new("UICorner")
    v220.CornerRadius = UDim.new(0 - 0, 10 + 5)
    v220.Parent = v210
    local v223 = Instance.new("Frame")
    v223.Size = UDim2.new(1 - 0, 1403 - (1333 + 70), 1832 - (701 + 1131), 142 - (55 + 72))
    v223.Position = UDim2.new(156 - (99 + 57), 0 - 0, 1 + 0, -(1594 - (1243 + 336)))
    v223.BackgroundColor3 = Color3.fromRGB(1584 - (774 + 555), 33 + 36, 799 - (150 + 649))
    v223.BorderSizePixel = 0
    v223.Parent = v210
    local v229 = Instance.new("TextLabel")
    v229.Size = UDim2.new(1 + 0, -50, 1, 0)
    v229.Position = UDim2.new(0 - 0, 15, 0 - 0, 1984 - (1122 + 862))
    v229.BackgroundTransparency = 1 - 0
    v229.Text = "F4edddyScript Inventory Viewer"
    v229.TextColor3 = Color3.new(1 + 0, 1, 1 - 0)
    v229.Font = Enum.Font.GothamBold
    v229.TextSize = (v190() and 12) or (9 + 5)
    v229.TextXAlignment = Enum.TextXAlignment.Left
    v229.Parent = v210
    local v241 = Instance.new("TextButton")
    v241.Size = UDim2.new(0, 7 + 15, 743 - (549 + 194), 15 + 7)
    v241.Position = UDim2.new(3 - 2, -30, 0.5 + 0, -(16 - 5))
    v241.BackgroundColor3 = Color3.fromRGB(220, 43 + 7, 179 - 129)
    v241.Text = "X"
    v241.TextColor3 = Color3.new(1, 1704 - (453 + 1250), 2 - 1)
    v241.Font = Enum.Font.GothamBold
    v241.TextSize = 14
    v241.BorderSizePixel = 0
    v241.Parent = v210
    local v251 = Instance.new("UICorner")
    v251.CornerRadius = UDim.new(0, 6 + 0)
    v251.Parent = v241
    local v254 = false
    local v255 = nil
    local v256 = nil
    v210.InputBegan:Connect(function(v785)
        if
            (v785.UserInputType == Enum.UserInputType.MouseButton1) or (v785.UserInputType == Enum.UserInputType.Touch)
        then
            local v916 = 575 - (203 + 372)
            local v917
            while true do
                if (0 + 0) == v916 then
                    v917 = 0
                    while true do
                        if v917 == 1 then
                            v256 = v191.Position
                            break
                        end
                        if v917 == 0 then
                            v254 = true
                            v255 = v785.Position
                            v917 = 2 - 1
                        end
                    end
                    break
                end
            end
        end
    end)
    v173.InputChanged:Connect(function(v786)
        if
            v254
            and (
                (v786.UserInputType == Enum.UserInputType.MouseMovement)
                or (v786.UserInputType == Enum.UserInputType.Touch)
            )
        then
            local v918 = v786.Position - v255
            v191.Position = UDim2.new(v256.X.Scale, v256.X.Offset + v918.X, v256.Y.Scale, v256.Y.Offset + v918.Y)
        end
    end)
    v173.InputEnded:Connect(function(v787)
        if
            (v787.UserInputType == Enum.UserInputType.MouseButton1) or (v787.UserInputType == Enum.UserInputType.Touch)
        then
            v254 = false
        end
    end)
    local v257 = Instance.new("Frame")
    v257.Size = UDim2.new(1383 - (978 + 404), 0 - 0, 1, -(41 + 4))
    v257.Position = UDim2.new(0, 318 - (56 + 262), 0 + 0, 159 - (108 + 6))
    v257.BackgroundTransparency = 1 + 0
    v257.BorderSizePixel = 0 + 0
    v257.Parent = v191
    local v263 = Instance.new("ScrollingFrame")
    v263.Size = UDim2.new(1953 - (653 + 1299), -(18 + 2), 1 + 0, -20)
    v263.Position = UDim2.new(0 - 0, 1932 - (1042 + 880), 0, 10)
    v263.BackgroundTransparency = 1 + 0
    v263.BorderSizePixel = 1002 - (16 + 986)
    v263.ScrollBarThickness = 4
    v263.ScrollBarImageColor3 = Color3.fromRGB(1473 - (700 + 518), 107, 172 - 119)
    v263.ScrollBarImageTransparency = 0.7 - 0
    v263.CanvasSize = UDim2.new(1511 - (617 + 894), 0 - 0, 458 - (271 + 187), 1584 - (731 + 853))
    v263.AutomaticCanvasSize = Enum.AutomaticSize.Y
    v263.Parent = v257
    local v275 = Instance.new("UIGridLayout")
    v275.CellSize = (v190() and UDim2.new(0.48 - 0, 1521 - (199 + 1322), 0, 333 - 163))
        or UDim2.new(0 + 0, 1900 - (1291 + 369), 0 + 0, 170)
    v275.CellPadding = UDim2.new(0 + 0, 10, 0, 8 + 2)
    v275.SortOrder = Enum.SortOrder.LayoutOrder
    v275.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v275.Parent = v263
    local v283 = Instance.new("UIPadding")
    v283.PaddingTop = UDim.new(0 + 0, 690 - (561 + 124))
    v283.PaddingBottom = UDim.new(0 + 0, 5)
    v283.Parent = v263
    local v287 = Instance.new("TextLabel")
    v287.Size = UDim2.new(854 - (25 + 828), 0 - 0, 1 - 0, 0)
    v287.BackgroundTransparency = 591 - (99 + 491)
    v287.Text = ""
    v287.TextColor3 = Color3.fromRGB(303 - (18 + 30), 241 - 141, 100)
    v287.Font = Enum.Font.GothamBold
    v287.TextSize = 18
    v287.Visible = false
    v287.Parent = v257
    local v296 = Instance.new("BlurEffect")
    v296.Size = 0
    v296.Parent = game.Lighting
    local v299 = Instance.new("Frame")
    v299.Name = "FullscreenViewer"
    v299.Size = UDim2.new(1, 0 - 0, 1 - 0, 0 + 0)
    v299.Position = UDim2.new(0 - 0, 0, 0, 732 - (501 + 231))
    v299.BackgroundTransparency = 1
    v299.BorderSizePixel = 0 + 0
    v299.Visible = false
    v299.ZIndex = 1798 - (470 + 1228)
    v299.Active = true
    v299.Parent = v179
    local v309 = Instance.new("Frame")
    v309.Name = "ViewFrame"
    v309.AnchorPoint = Vector2.new(0.5 + 0, 0.5)
    v309.Position = UDim2.new(0.5, 0 + 0, 686.5 - (537 + 149), 0)
    v309.Size = (v190() and UDim2.new(0.88 - 0, 0, 0 + 0, 630 - 330)) or UDim2.new(0 - 0, 1129 - 749, 0 + 0, 107 + 203)
    v309.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    v309.BorderSizePixel = 0 + 0
    v309.ZIndex = 44 + 57
    v309.Active = true
    v309.Parent = v299
    local v319 = Instance.new("UICorner")
    v319.CornerRadius = UDim.new(0 + 0, 20)
    v319.Parent = v309
    local v322 = Instance.new("UIStroke")
    v322.Color = Color3.fromRGB(29 + 226, 107, 38 + 15)
    v322.Thickness = 2 - 0
    v322.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v322.Parent = v309
    local v327 = false
    local v328 = nil
    local v329 = nil
    local v330 = Instance.new("Frame")
    v330.Size = UDim2.new(1 + 0, 579 - (134 + 445), 0 - 0, 32)
    v330.BackgroundColor3 = Color3.fromRGB(236 + 19, 62 + 45, 205 - 152)
    v330.BorderSizePixel = 260 - (36 + 224)
    v330.ZIndex = 1961 - (1033 + 827)
    v330.Parent = v309
    v330.InputBegan:Connect(function(v788)
        if
            (v788.UserInputType == Enum.UserInputType.MouseButton1) or (v788.UserInputType == Enum.UserInputType.Touch)
        then
            local v920 = 1846 - (1002 + 844)
            local v921
            while true do
                if v920 == (1350 - (1126 + 224)) then
                    v921 = 0
                    while true do
                        if v921 == 0 then
                            v327 = true
                            v328 = v788.Position
                            v921 = 1 + 0
                        end
                        if v921 == (1 + 0) then
                            v329 = v309.Position
                            break
                        end
                    end
                    break
                end
            end
        end
    end)
    v173.InputChanged:Connect(function(v789)
        if
            v327
            and (
                (v789.UserInputType == Enum.UserInputType.MouseMovement)
                or (v789.UserInputType == Enum.UserInputType.Touch)
            )
        then
            local v922 = v789.Position - v328
            v309.Position = UDim2.new(v329.X.Scale, v329.X.Offset + v922.X, v329.Y.Scale, v329.Y.Offset + v922.Y)
        end
    end)
    v173.InputEnded:Connect(function(v790)
        if
            (v790.UserInputType == Enum.UserInputType.MouseButton1) or (v790.UserInputType == Enum.UserInputType.Touch)
        then
            v327 = false
        end
    end)
    local v336 = Instance.new("UICorner")
    v336.CornerRadius = UDim.new(0 - 0, 20)
    v336.Parent = v330
    local v339 = Instance.new("Frame")
    v339.Size = UDim2.new(65 - (48 + 16), 0 + 0, 0 - 0, 64 - 44)
    v339.Position = UDim2.new(0, 0 + 0, 1, -20)
    v339.BackgroundColor3 = Color3.fromRGB(255, 1196 - (910 + 179), 104 - 51)
    v339.BorderSizePixel = 0 - 0
    v339.ZIndex = 101
    v339.Parent = v330
    local v346 = Instance.new("TextLabel")
    v346.Size = UDim2.new(1380 - (933 + 446), -50, 1 + 0, 1524 - (248 + 1276))
    v346.Position = UDim2.new(0 + 0, 10, 0, 0 + 0)
    v346.BackgroundTransparency = 1
    v346.Text = "Item Preview"
    v346.TextColor3 = Color3.new(3 - 2, 1, 3 - 2)
    v346.Font = Enum.Font.GothamBold
    v346.TextSize = (v190() and 12) or (1559 - (151 + 1394))
    v346.TextXAlignment = Enum.TextXAlignment.Left
    v346.ZIndex = 1045 - (929 + 15)
    v346.Parent = v330
    local v357 = Instance.new("TextButton")
    v357.Size = UDim2.new(1996 - (1173 + 823), 38 - 14, 0, 1800 - (482 + 1294))
    v357.Position = UDim2.new(1, -(61 - 31), 0.5 + 0, -(1318 - (1125 + 181)))
    v357.BackgroundColor3 = Color3.fromRGB(641 - 421, 50, 31 + 19)
    v357.Text = "X"
    v357.TextColor3 = Color3.new(1 - 0, 1, 1190 - (626 + 563))
    v357.Font = Enum.Font.GothamBold
    v357.TextSize = 14
    v357.BorderSizePixel = 1250 - (153 + 1097)
    v357.ZIndex = 102
    v357.Parent = v330
    local v368 = Instance.new("UICorner")
    v368.CornerRadius = UDim.new(0 - 0, 8)
    v368.Parent = v357
    local v371 = Instance.new("ViewportFrame")
    v371.Size = UDim2.new(1, -(7 + 7), 2 - 1, -(25 + 21))
    v371.Position = UDim2.new(0, 6 + 1, 0 + 0, 28 + 10)
    v371.BackgroundColor3 = Color3.fromRGB(20, 18 + 2, 1192 - (199 + 958))
    v371.BorderSizePixel = 0 + 0
    v371.ZIndex = 238 - 137
    v371.Parent = v309
    local v378 = Instance.new("UICorner")
    v378.CornerRadius = UDim.new(0, 34 - 19)
    v378.Parent = v371
    local v381 = Instance.new("Camera")
    v381.Parent = v371
    v371.CurrentCamera = v381
    local function v384(v791, v792, v793)
        v346.Text = v792 .. " x" .. v793
        for v859, v860 in pairs(v371:GetChildren()) do
            if v860:IsA("Model") then
                v860:Destroy()
            end
        end
        local v795
        if v791:IsA("Model") then
            v795 = v791:Clone()
            v795.Parent = v371
        elseif v791:IsA("BasePart") then
            local v1158 = 1176 - (1169 + 7)
            local v1159
            while true do
                if v1158 == (1875 - (751 + 1122)) then
                    v795.Parent = v371
                    break
                end
                if v1158 == 1 then
                    v1159.Parent = v795
                    v795.PrimaryPart = v1159
                    v1158 = 2
                end
                if v1158 == 0 then
                    v795 = Instance.new("Model")
                    v1159 = v791:Clone()
                    v1158 = 1 + 0
                end
            end
        end
        if not v795 then
            return
        end
        local v796, v797 = v795:GetBoundingBox()
        local v798 = math.max(v797.X, v797.Y, v797.Z)
        local v799 = v798 * 2.5
        local v800, v801 = -(14 + 1), 0
        local v802 = false
        local v803 = false
        local v804 = Vector2.zero
        local function v805()
            local v861 = 0
            local v862
            local v863
            local v864
            local v865
            local v866
            while true do
                if v861 == (1 + 0) then
                    v864 = nil
                    v865 = nil
                    v861 = 2
                end
                if v861 == (0 + 0) then
                    v862 = 0 - 0
                    v863 = nil
                    v861 = 1182 - (589 + 592)
                end
                if v861 == (3 - 1) then
                    v866 = nil
                    while true do
                        if 1 == v862 then
                            v865 = CFrame.Angles(0 + 0, math.rad(v801), 24 - (13 + 11))
                                * CFrame.Angles(math.rad(v800), 0 + 0, 0 + 0)
                            v866 = CFrame.new(v863) * v865 * v864
                            v862 = 1262 - (684 + 576)
                        end
                        if v862 == (1 + 1) then
                            v381.CFrame = CFrame.lookAt(v866.Position, v863)
                            break
                        end
                        if v862 == (0 - 0) then
                            v863 = v796.Position
                            v864 = CFrame.new(0 + 0, 0 + 0, v799)
                            v862 = 1 - 0
                        end
                    end
                    break
                end
            end
        end
        local v806 = {}
        table.insert(
            v806,
            v371.InputBegan:Connect(function(v867)
                if
                    (v867.UserInputType == Enum.UserInputType.MouseButton1)
                    or (v867.UserInputType == Enum.UserInputType.Touch)
                then
                    v802 = true
                    v804 = v867.Position
                end
            end)
        )
        table.insert(
            v806,
            v371.InputEnded:Connect(function(v868)
                if
                    (v868.UserInputType == Enum.UserInputType.MouseButton1)
                    or (v868.UserInputType == Enum.UserInputType.Touch)
                then
                    v802 = false
                end
            end)
        )
        table.insert(
            v806,
            v371.InputChanged:Connect(function(v869)
                local v870 = 0 + 0
                while true do
                    if v870 == (0 + 0) then
                        if
                            v802
                            and (
                                (v869.UserInputType == Enum.UserInputType.MouseMovement)
                                or (v869.UserInputType == Enum.UserInputType.Touch)
                            )
                        then
                            local v1290 = 0 + 0
                            local v1291
                            while true do
                                if v1290 == (1 + 0) then
                                    v801 = v801 - (v1291.X * (0.5 + 0))
                                    v800 = math.clamp(v800 - (v1291.Y * (1848.5 - (230 + 1618))), -(64 + 16), 80)
                                    break
                                end
                                if v1290 == (0 + 0) then
                                    v1291 = v869.Position - v804
                                    v804 = v869.Position
                                    v1290 = 1 + 0
                                end
                            end
                        end
                        if (v869.UserInputType == Enum.UserInputType.MouseWheel) and v803 then
                            v799 = math.clamp(v799 - (v869.Position.Z * (205 - (131 + 72))), v798 * 0.5, v798 * 10)
                        end
                        break
                    end
                end
            end)
        )
        table.insert(
            v806,
            v371.MouseEnter:Connect(function()
                v803 = true
            end)
        )
        table.insert(
            v806,
            v371.MouseLeave:Connect(function()
                v803 = false
            end)
        )
        local v807
        v807 = v174.RenderStepped:Connect(function()
            if v795 and v381 and v299.Visible then
                local v1066 = 0 + 0
                while true do
                    if (204 - (144 + 60)) == v1066 then
                        if not v802 then
                            v801 = v801 + (0.008 * (244 - 184))
                        end
                        v805()
                        break
                    end
                end
            end
        end)
        table.insert(v806, v807)
        local function v808()
            local v871 = 0 - 0
            while true do
                if v871 == 1 then
                    v191.Visible = true
                    v299.Visible = false
                    break
                end
                if v871 == (0 + 0) then
                    for v1239, v1240 in pairs(v806) do
                        v1240:Disconnect()
                    end
                    v175:Create(v296, TweenInfo.new(0.2 - 0), { ["Size"] = 0 + 0 }):Play()
                    v871 = 1923 - (523 + 1399)
                end
            end
        end
        v357.MouseButton1Click:Connect(v808)
        v175:Create(v296, TweenInfo.new(0.2), { ["Size"] = 20 + 0 }):Play()
        v191.Visible = false
        v299.Visible = true
        v805()
    end
    local v385 = v171:FindFirstChild(v178)
    if not v385 then
        local v872 = 0
        while true do
            if v872 == (405 - (72 + 332)) then
                v263.Visible = false
                break
            end
            if v872 == (976 - (269 + 707)) then
                v287.Text = "User is not in game"
                v287.Visible = true
                v872 = 1 - 0
            end
        end
    else
        local v873 = v385:FindFirstChild("SkinsFolder")
        if not v873 then
            local v1067 = 0 - 0
            while true do
                if v1067 == (130 - (123 + 7)) then
                    v287.Text = "SkinsFolder not found"
                    v287.Visible = true
                    v1067 = 1
                end
                if v1067 == (1 + 0) then
                    v263.Visible = false
                    break
                end
            end
        else
            local v1068 = 0 + 0
            local v1069
            while true do
                if v1068 == (4 - 3) then
                    if #v1069 == (0 - 0) then
                        local v1425 = 1088 - (38 + 1050)
                        while true do
                            if v1425 == (1 + 0) then
                                v263.Visible = false
                                break
                            end
                            if v1425 == (0 + 0) then
                                v287.Text = "No items found"
                                v287.Visible = true
                                v1425 = 1 + 0
                            end
                        end
                    else
                        local function v1426(v1467, v1468)
                            local v1469 = v1467.item
                            local v1470 = v1467.count
                            local v1471 = Instance.new("Frame")
                            v1471.Name = "ItemFrame_" .. v1468
                            v1471.BackgroundColor3 = Color3.fromRGB(20, 843 - (426 + 397), 35)
                            v1471.BorderSizePixel = 1406 - (751 + 655)
                            v1471.LayoutOrder = v1468
                            v1471.Parent = v263
                            local v1477 = Instance.new("UICorner")
                            v1477.CornerRadius = UDim.new(0, 23 - 11)
                            v1477.Parent = v1471
                            local v1480 = Instance.new("UIStroke")
                            v1480.Color = Color3.fromRGB(11 + 69, 1325 - (39 + 1206), 307 - 207)
                            v1480.Thickness = 842 - (566 + 275)
                            v1480.Transparency = 935.5 - (167 + 768)
                            v1480.Parent = v1471
                            local v1485 = Instance.new("TextButton")
                            v1485.Size = UDim2.new(1 + 0, 0, 1, 0 - 0)
                            v1485.BackgroundTransparency = 1 + 0
                            v1485.Text = ""
                            v1485.Parent = v1471
                            local v1490 = Instance.new("TextLabel")
                            v1490.Size = UDim2.new(1 + 0, -(13 - 3), 0, 25)
                            v1490.Position = UDim2.new(15 - (8 + 7), 5, 1683 - (1510 + 173), 4 - 1)
                            v1490.BackgroundTransparency = 1 + 0
                            v1490.Text = v1469.Name .. " x" .. v1470
                            v1490.TextColor3 = Color3.fromRGB(508 - (30 + 223), 230, 1456 - (300 + 956))
                            v1490.Font = Enum.Font.GothamBold
                            v1490.TextSize = 132 - (22 + 100)
                            v1490.TextScaled = true
                            v1490.TextXAlignment = Enum.TextXAlignment.Center
                            v1490.ZIndex = 4 - 2
                            v1490.Parent = v1471
                            local v1504 = Instance.new("Frame")
                            v1504.Size = UDim2.new(283 - (47 + 235), -(33 - 23), 1 + 0, -(516 - (21 + 465)))
                            v1504.Position = UDim2.new(0 + 0, 4 + 1, 0 + 0, 30)
                            v1504.BackgroundColor3 = Color3.fromRGB(30 - 5, 1242 - (553 + 664), 17 + 23)
                            v1504.BorderSizePixel = 78 - (73 + 5)
                            v1504.Parent = v1471
                            local v1510 = Instance.new("UICorner")
                            v1510.CornerRadius = UDim.new(1715 - (1128 + 587), 38 - 28)
                            v1510.Parent = v1504
                            local v1513 = Instance.new("ViewportFrame")
                            v1513.Size = UDim2.new(1, -4, 1, -4)
                            v1513.Position = UDim2.new(690 - (558 + 132), 5 - 3, 0, 5 - 3)
                            v1513.BackgroundTransparency = 1 + 0
                            v1513.BorderSizePixel = 0 + 0
                            v1513.Parent = v1504
                            local v1519 = Instance.new("Camera")
                            v1519.Parent = v1513
                            v1513.CurrentCamera = v1519
                            local v1522
                            if v1469:IsA("Model") then
                                local v1612 = 0
                                local v1613
                                while true do
                                    if v1612 == 0 then
                                        v1613 = 0 + 0
                                        while true do
                                            if v1613 == (0 + 0) then
                                                v1522 = v1469:Clone()
                                                v1522.Parent = v1513
                                                break
                                            end
                                        end
                                        break
                                    end
                                end
                            elseif v1469:IsA("BasePart") then
                                local v1650 = 0 - 0
                                local v1651
                                while true do
                                    if v1650 == (1 + 0) then
                                        v1651.Parent = v1522
                                        v1522.PrimaryPart = v1651
                                        v1650 = 2 + 0
                                    end
                                    if (773 - (294 + 477)) == v1650 then
                                        v1522.Parent = v1513
                                        break
                                    end
                                    if v1650 == (0 + 0) then
                                        v1522 = Instance.new("Model")
                                        v1651 = v1469:Clone()
                                        v1650 = 2 - 1
                                    end
                                end
                            end
                            if not v1522 then
                                local v1614 = 0
                                local v1615
                                while true do
                                    if v1614 == (3 - 1) then
                                        v1615.Material = Enum.Material.Neon
                                        v1615.Parent = v1522
                                        v1614 = 1 + 2
                                    end
                                    if 0 == v1614 then
                                        v1522 = Instance.new("Model")
                                        v1615 = Instance.new("Part")
                                        v1614 = 1
                                    end
                                    if v1614 == (1 + 0) then
                                        v1615.Size = Vector3.new(0.5, 4 - 2, 982.2 - (97 + 885))
                                        v1615.Color = Color3.fromRGB(120 + 135, 107, 53)
                                        v1614 = 2
                                    end
                                    if v1614 == (4 - 1) then
                                        v1522.PrimaryPart = v1615
                                        v1522.Parent = v1513
                                        break
                                    end
                                end
                            end
                            local v1523, v1524 = v1522:GetBoundingBox()
                            local v1525 = math.max(v1524.X, v1524.Y, v1524.Z)
                            local v1526 = v1525 * (367.5 - (271 + 94))
                            local v1527 = 1603 - (777 + 826)
                            local function v1528()
                                local v1578 = 0
                                local v1579
                                local v1580
                                local v1581
                                local v1582
                                while true do
                                    if v1578 == (1 + 0) then
                                        local v1652 = 1355 - (117 + 1238)
                                        while true do
                                            if v1652 == (1716 - (686 + 1029)) then
                                                v1578 = 2
                                                break
                                            end
                                            if (1356 - (1074 + 282)) == v1652 then
                                                v1581 = CFrame.Angles(1617 - (1359 + 258), math.rad(v1527), 0 - 0)
                                                    * CFrame.Angles(math.rad(-15), 1935 - (1730 + 205), 0)
                                                v1582 = CFrame.new(v1579) * v1581 * v1580
                                                v1652 = 1
                                            end
                                        end
                                    end
                                    if v1578 == (528 - (67 + 461)) then
                                        local v1653 = 0 - 0
                                        while true do
                                            if v1653 == (1 - 0) then
                                                v1578 = 1
                                                break
                                            end
                                            if v1653 == (0 - 0) then
                                                v1579 = v1523.Position
                                                v1580 = CFrame.new(0 + 0, 629 - (129 + 500), v1526)
                                                v1653 = 1712 - (1157 + 554)
                                            end
                                        end
                                    end
                                    if v1578 == 2 then
                                        v1519.CFrame = CFrame.lookAt(v1582.Position, v1579)
                                        break
                                    end
                                end
                            end
                            v174.RenderStepped:Connect(function()
                                if v1522 and v1519 then
                                    local v1632 = 0 - 0
                                    while true do
                                        if v1632 == (607 - (82 + 525)) then
                                            v1527 = v1527 + 0.5
                                            v1528()
                                            break
                                        end
                                    end
                                end
                            end)
                            v1485.MouseButton1Click:Connect(function()
                                v384(v1469, v1469.Name, v1470)
                            end)
                            v1528()
                        end
                        for v1529, v1530 in ipairs(v1069) do
                            v1426(v1530, v1529)
                        end
                    end
                    break
                end
                if v1068 == (0 + 0) then
                    local v1295 = 0 - 0
                    while true do
                        if v1295 == (1623 - (948 + 675)) then
                            v1069 = {}
                            for v1583, v1584 in pairs(v873:GetChildren()) do
                                local v1585 = 0 + 0
                                local v1586
                                local v1587
                                local v1588
                                local v1589
                                local v1590
                                local v1591
                                while true do
                                    if v1585 == (2 + 0) then
                                        v1590 = v172.Skins:FindFirstChild("Guns")
                                        v1591 = nil
                                        v1585 = 7 - 4
                                    end
                                    if v1585 == (856 - (406 + 447)) then
                                        if v1589 then
                                            for v1704, v1705 in pairs(v1589:GetChildren()) do
                                                if
                                                    (v1705.Name == v1586)
                                                    or v1705.Name:find(v1586)
                                                    or v1586:find(v1705.Name)
                                                then
                                                    v1591 = v1705
                                                    break
                                                end
                                            end
                                        end
                                        if not v1591 and v1590 then
                                            for v1706, v1707 in pairs(v1590:GetChildren()) do
                                                if
                                                    (v1707.Name == v1586)
                                                    or v1707.Name:find(v1586)
                                                    or v1586:find(v1707.Name)
                                                then
                                                    v1591 = v1707
                                                    break
                                                end
                                            end
                                        end
                                        v1585 = 121 - (91 + 26)
                                    end
                                    if v1585 == (13 - 9) then
                                        if v1591 then
                                            table.insert(v1069, { ["item"] = v1591, ["count"] = v1588 })
                                        end
                                        break
                                    end
                                    if v1585 == (1 + 0) then
                                        v1588 = (v1587 and v1587.Value) or (986 - (968 + 18))
                                        v1589 = v172.Skins:FindFirstChild("Knives")
                                        v1585 = 2
                                    end
                                    if v1585 == (0 + 0) then
                                        v1586 = v1584.Name
                                        v1587 = v1584:FindFirstChild("Count")
                                        v1585 = 1 + 0
                                    end
                                end
                            end
                            v1295 = 1
                        end
                        if v1295 == (1 - 0) then
                            v1068 = 268 - (172 + 95)
                            break
                        end
                    end
                end
            end
        end
    end
    v241.MouseButton1Click:Connect(function()
        local v811 = 0 - 0
        local v812
        local v813
        while true do
            if v811 == (267 - (260 + 5)) then
                v813.Completed:Connect(function()
                    local v1165 = 0 - 0
                    while true do
                        if v1165 == (819 - (265 + 554)) then
                            v179:Destroy()
                            if v186 then
                                v186:Destroy()
                            end
                            break
                        end
                    end
                end)
                break
            end
            if v811 == (1571 - (1440 + 131)) then
                v812 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                v813 =
                    v175:Create(v191, v812, { ["Size"] = UDim2.new(0 - 0, 1395 - (253 + 1142), 0, 253 - (133 + 120)) })
                v811 = 1 - 0
            end
            if v811 == (1957 - (809 + 1147)) then
                v175:Create(v186, v812, { ["Size"] = 0 }):Play()
                v813:Play()
                v811 = 499 - (178 + 319)
            end
        end
    end)
    v191.Size = UDim2.new(0, 0 - 0, 0 + 0, 1270 - (1255 + 15))
    local v386 = v175:Create(
        v191,
        TweenInfo.new(1542.3 - (1221 + 321), Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { ["Size"] = (v190() and UDim2.new(0.95 - 0, 0, 0, 388 + 112)) or UDim2.new(0, 3191 - 2341, 0 - 0, 500) }
    )
    v386:Play()
end
local v40 = nil
local v41 = false
_G.BlockClick = false
local v42 = 200
local v43 = Enum.KeyCode.F
local v44 = false
local v45 = false
local v46 = false
local v47 = nil
local v48 = {}
local v49 = 0.25
local v50 = 0.08 + 0
local v51 = 0 + 0
local v52 = 3.15 - 1
local v53 = 0.05
local v54 = {}
local v55 = 0.5
local v56 = 407 - (204 + 203)
local v57 = 100
local v58 = {
    ["maxDetectionDistance"] = 200,
    ["minDetectionDistance"] = 83 - (48 + 30),
    ["baseRaycastCount"] = 5,
    ["maxRaycastCount"] = 5 + 5,
    ["raySpreadAngle"] = 1966 - (1472 + 492),
    ["aimAssistStrength"] = 0.7,
    ["allowBackwardsShooting"] = false,
    ["predictionStrength"] = 0.8,
    ["requireLineOfSight"] = true,
    ["validateAssets"] = true,
    ["checkTeam"] = true,
    ["cameraThreshold"] = 0.1 - 0,
    ["maxCameraAngle"] = 18 + 12,
    ["maxRaysPerFrame"] = 619 - (258 + 353),
    ["distanceBasedRayReduction"] = true,
    ["adaptiveRaycasting"] = true,
    ["screenCenterWeight"] = 1994.4 - (1382 + 612),
    ["distanceWeight"] = 0.3 + 0,
    ["visibilityWeight"] = 0.3 + 0,
}
local v59 = {
    "HumanoidRootPart",
    "Head",
    "UpperTorso",
    "LowerTorso",
    "LeftUpperArm",
    "RightUpperArm",
    "LeftUpperLeg",
    "RightUpperLeg",
}
local function v60()
    local v387 = 1799 - (923 + 876)
    local v388
    local v389
    while true do
        if v387 == 1 then
            if v389 then
                v58.aimAssistStrength = 0.9
                v58.maxRaycastCount = 21 - 13
                v53 = 812.07 - (284 + 528)
            else
                local v1168 = 1019 - (867 + 152)
                while true do
                    if v1168 == (1107 - (709 + 397)) then
                        v53 = 0.05
                        break
                    end
                    if v1168 == (0 - 0) then
                        v58.aimAssistStrength = 0.7
                        v58.maxRaycastCount = 46 - (21 + 15)
                        v1168 = 1 - 0
                    end
                end
            end
            break
        end
        if v387 == (0 - 0) then
            v388 = game:GetService("UserInputService")
            v389 = v388.TouchEnabled and not v388.KeyboardEnabled
            v387 = 1 + 0
        end
    end
end
local function v61(v390)
    local v391 = 0 - 0
    local v392
    while true do
        if 0 == v391 then
            v392 = 0 - 0
            while true do
                if v392 == (1 + 0) then
                    v48[v390] = true
                    v390.AncestryChanged:Connect(function()
                        local v1296 = 135 - (97 + 38)
                        while true do
                            if v1296 == 0 then
                                task.wait()
                                if v41 and (v40 == v390) and v40 and v40.Parent then
                                    pcall(updateWeaponScripts)
                                end
                                break
                            end
                        end
                    end)
                    v392 = 82 - (52 + 28)
                end
                if v392 == (1 + 1) then
                    v390:GetPropertyChangedSignal("Parent"):Connect(function()
                        task.wait()
                        if v41 and (v40 == v390) and v40 and v40.Parent then
                            pcall(updateWeaponScripts)
                        end
                    end)
                    break
                end
                if v392 == (849 - (59 + 790)) then
                    if not v390 then
                        return
                    end
                    if v48[v390] then
                        return
                    end
                    v392 = 1
                end
            end
            break
        end
    end
end
function updateWeaponScripts()
    local v393 = 0 + 0
    local v394
    local v395
    local v396
    while true do
        if v393 == (1 + 0) then
            if not v40 or not v40.Parent then
                v41 = false
                v40 = nil
                return
            end
            v394, v395 = pcall(function()
                return v40:GetDescendants()
            end)
            v393 = 942 - (467 + 473)
        end
        if (19 - 15) == v393 then
            for v1070, v1071 in ipairs(v396) do
                pcall(function()
                    if not v40 then
                        return
                    end
                    local v1169 = v40:FindFirstChild(v1071)
                    if v1169 and (v1169:IsA("Script") or v1169:IsA("LocalScript")) then
                        if v1169.Disabled ~= _G.BlockClick then
                            v1169.Disabled = _G.BlockClick
                        end
                    end
                end)
            end
            break
        end
        if 0 == v393 then
            if not v41 then
                return
            end
            if not v40 or not v40.Parent or (v40:IsDescendantOf(game) == false) then
                local v1170 = 0 - 0
                local v1171
                while true do
                    if v1170 == 1 then
                        if not v40 then
                            v41 = false
                            return
                        end
                        break
                    end
                    if v1170 == 0 then
                        local v1371 = 0 - 0
                        while true do
                            if v1371 == (2 - 1) then
                                v1170 = 1
                                break
                            end
                            if v1371 == 0 then
                                v1171 = v11.Character
                                if v1171 and v1171:IsDescendantOf(workspace) then
                                    for v1656, v1657 in ipairs(v1171:GetChildren()) do
                                        if v1657:IsA("Tool") and v1657:FindFirstChild("fire") then
                                            v40 = v1657
                                            v41 = true
                                            v61(v40)
                                            break
                                        end
                                    end
                                end
                                v1371 = 1 + 0
                            end
                        end
                    end
                end
            end
            v393 = 1
        end
        if v393 == 3 then
            for v1072, v1073 in ipairs(v395) do
                if
                    v1073
                    and (v1073:IsA("Script") or v1073:IsA("LocalScript"))
                    and (v1073.Disabled ~= _G.BlockClick)
                then
                    pcall(function()
                        if v40 and v1073:IsDescendantOf(v40) then
                            v1073.Disabled = _G.BlockClick
                        end
                    end)
                end
            end
            v396 = { "Script", "LocalScript", "Client", "GunScript" }
            v393 = 4
        end
        if v393 == (7 - 5) then
            if not v394 or not v395 then
                local v1172 = 0 - 0
                while true do
                    local v1242 = 0
                    while true do
                        if (0 + 0) == v1242 then
                            if 0 == v1172 then
                                v40 = nil
                                v41 = false
                                v1172 = 1 + 0
                            end
                            if (1 + 0) == v1172 then
                                return
                            end
                            break
                        end
                    end
                end
            end
            table.insert(v395, v40)
            v393 = 240 - (58 + 179)
        end
    end
end
function initializeWeaponScript()
    local v397 = 0
    local v398
    local v399
    while true do
        local v814 = 0 - 0
        while true do
            if v814 == (1253 - (677 + 576)) then
                if v397 == (2 + 1) then
                    v41 = false
                    return false
                end
                if v397 == (3 - 1) then
                    if v399 then
                        for v1429, v1430 in ipairs(v399:GetChildren()) do
                            if v1430:IsA("Tool") and v1430:FindFirstChild("fire") then
                                local v1593 = 220 - (88 + 132)
                                while true do
                                    local v1616 = 0
                                    while true do
                                        if v1616 == 1 then
                                            if v1593 == (0 + 0) then
                                                v40 = v1430
                                                v41 = false
                                                v1593 = 1
                                            end
                                            break
                                        end
                                        if v1616 == 0 then
                                            if v1593 == (9 - 7) then
                                                return true
                                            end
                                            if v1593 == 1 then
                                                v61(v40)
                                                if v40 and v40.Parent then
                                                    pcall(updateWeaponScripts)
                                                end
                                                v1593 = 6 - 4
                                            end
                                            v1616 = 292 - (12 + 279)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    v40 = nil
                    v397 = 3
                end
                v814 = 1
            end
            if v814 == (1 - 0) then
                if (0 + 0) == v397 then
                    v398 = v11.Character
                    if not v398 then
                        return false
                    end
                    v397 = 948 - (652 + 295)
                end
                if v397 == 1 then
                    for v1297, v1298 in ipairs(v398:GetChildren()) do
                        if v1298:IsA("Tool") and v1298:FindFirstChild("fire") then
                            local v1431 = 0 + 0
                            local v1432
                            while true do
                                if (0 + 0) == v1431 then
                                    v1432 = 989 - (848 + 141)
                                    while true do
                                        if v1432 == (742 - (372 + 368)) then
                                            return true
                                        end
                                        if v1432 == 0 then
                                            v40 = v1298
                                            v41 = true
                                            v1432 = 1
                                        end
                                        if v1432 == (1 + 0) then
                                            v61(v40)
                                            if v40 and v40.Parent then
                                                pcall(updateWeaponScripts)
                                            end
                                            v1432 = 2
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                    v399 = v11:FindFirstChild("Backpack")
                    v397 = 1132 - (542 + 588)
                end
                break
            end
        end
    end
end
local function v62(v400, v401)
    local v402 = tostring(v400) .. "_" .. v401
    local v403 = v54[v402]
    if v403 and (v403.time > (tick() - v55)) then
        return v403.component
    end
    local v404 = v400:FindFirstChild(v401)
    v54[v402] = { ["component"] = v404, ["time"] = tick() }
    return v404
end
local function v63(v406)
    local v407 = workspace.CurrentCamera
    if not v407 then
        return false
    end
    local v408 = v407.CFrame
    local v409 = v408.LookVector
    local v410 = v408.Position
    local v411 = (v406 - v410).Unit
    local v412 = v409:Dot(v411)
    return v412 > v58.cameraThreshold
end
local function v64(v413)
    local v414 = workspace.CurrentCamera
    if not v414 then
        return 998 - (6 + 812)
    end
    local v415, v416 = v414:WorldToViewportPoint(v413)
    if not v416 then
        return 1885 - (1599 + 106)
    end
    local v417 = v414.ViewportSize.X / (5 - 3)
    local v418 = v414.ViewportSize.Y / 2
    local v419 = v415.X
    local v420 = v415.Y
    local v421 = v419 - v417
    local v422 = v420 - v418
    local v423 = math.deg(math.atan2(v422, v421))
    local v424 = math.abs(v423)
    if v424 > 180 then
        v424 = (174 + 186) - v424
    end
    return v424
end
local function v65(v425)
    local v426 = workspace.CurrentCamera
    if not v426 then
        return false, Vector2.new(0 + 0, 0 - 0), 313 - 133
    end
    local v427, v428 = v426:WorldToViewportPoint(v425)
    if not v428 then
        return false, Vector2.new(0 + 0, 0 + 0), 141 + 39
    end
    local v429 = Vector2.new(v427.X, v427.Y)
    local v430 = v64(v425)
    return true, v429, v430
end
local function v66(v431, v432, v433)
    if not v432 or not v433 then
        return Vector3.new(0, 0 + 0, 0 + 0)
    end
    local v434 = v432.AssemblyLinearVelocity
    local v435 = v432.Position
    if v434.Magnitude > (1 + 0) then
        v435 = v435 + (v434 * v50 * v58.predictionStrength)
    end
    local v436 = v433.HipHeight + (1931 - (1690 + 239))
    local v437 = 3.2 - 2
    local v438 = (math.random() - (0.5 + 0)) * v437 * v49
    local v439 = (math.random() - (0.5 - 0)) * v436 * v49 * 0.5
    local v440 = (math.random() - (0.5 - 0)) * v437 * v49
    return (v435 - v432.Position) + Vector3.new(v438, v439, v440)
end
local function v67(v441)
    local v442 = 0
    local v443
    local v444
    while true do
        local v815 = 0 + 0
        while true do
            if v815 == 1 then
                if v442 == (0 - 0) then
                    if not v58.validateAssets then
                        return { ["hitboxScale"] = 1869 - (1736 + 132) }
                    end
                    v443 = { ["hitboxScale"] = 1 + 0 }
                    v442 = 3 - 2
                end
                break
            end
            if v815 == (0 - 0) then
                if v442 == (1 + 0) then
                    v444 = 0
                    for v1299, v1300 in ipairs(v441:GetChildren()) do
                        if v1300:IsA("Accessory") then
                            local v1433 = 0
                            local v1434
                            while true do
                                if v1433 == 0 then
                                    v1434 = v1300:FindFirstChild("Handle")
                                    if v1434 then
                                        local v1658 = 32 - (27 + 5)
                                        local v1659
                                        local v1660
                                        local v1661
                                        while true do
                                            if (1 + 0) == v1658 then
                                                v1661 = nil
                                                while true do
                                                    if v1659 == (0 + 0) then
                                                        v1660 = v1434.Size
                                                        v1661 = v1660.X * v1660.Y * v1660.Z
                                                        v1659 = 1
                                                    end
                                                    if v1659 == 1 then
                                                        if v1661 > (2 + 3) then
                                                            v444 = v444 + 1
                                                        end
                                                        break
                                                    end
                                                end
                                                break
                                            end
                                            if v1658 == (0 + 0) then
                                                v1659 = 0 + 0
                                                v1660 = nil
                                                v1658 = 1
                                            end
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                    v442 = 2
                end
                if v442 == (1119 - (771 + 346)) then
                    local v1244 = 0
                    while true do
                        if (1634 - (1577 + 57)) == v1244 then
                            if v444 > (0 - 0) then
                                v443.hitboxScale = 1 + (v444 * (1080.2 - (684 + 396)))
                            end
                            return v443
                        end
                    end
                end
                v815 = 2 - 1
            end
        end
    end
end
local function v68(v445)
    local v446 = 0
    while true do
        if v446 == (1196 - (700 + 496)) then
            if not v58.distanceBasedRayReduction then
                return math.min(v58.baseRaycastCount, v58.maxRaycastCount)
            end
            if v445 > 150 then
                return 3 + 0
            elseif v445 > (352 - (65 + 187)) then
                return 943 - (827 + 112)
            elseif v445 > (35 + 15) then
                return 12 - 7
            else
                return math.min(v58.baseRaycastCount, v58.maxRaycastCount)
            end
            break
        end
    end
end
local function v69()
    if v56 >= v57 then
        return false
    end
end
