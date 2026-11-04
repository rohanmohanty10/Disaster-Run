 

local _, _, _, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get(true)
local v1 = require(game.ReplicatedStorage.Util.Area.Area)
_G.currentisland = ""
_G.currentweather = ""
_G.weatherfolder = nil
if _G.areaParent == nil then
    _G.areaParent = workspace.Effects.Areas
end
local u2 = game.ReplicatedStorage:FindFirstChild("2ndSea") and "Second Sea" or "First Sea"
workspace:WaitForChild("Env"):WaitForChild("WaterStuff")
local v3 = game.ReplicatedStorage.Util.Area.Fog:Clone()
v3.Parent = workspace.CurrentCamera
v3:WaitForChild("Mesh")
if _G.themeSong then
    _G.themeSong:Stop()
end
local function v13() --[[ Line: 33 ]]
    local v4 = workspace.Islands:GetChildren()
    for v5 = 1, #v4 do
        if v4[v5]:FindFirstChild("Settings") and v4[v5].Settings:GetAttribute("ThemeID") then
            local v6 = script.Folder.CalmNightCricketsAmb:Clone()
            v6.Name = v4[v5].Name
            local v7 = v4[v5].Settings:GetAttribute("ThemeID")
            if tonumber(v7) ~= nil then
                v7 = "rbxassetid://" .. v7
            end
            v6.SoundId = v7
            v6.Volume = 0.25
            v6.Parent = game.ReplicatedStorage.Assets.IslandMusic
        end
    end
    local v8 = game.ReplicatedStorage.Assets.IslandMusic:GetChildren()
    local v9 = game.ReplicatedStorage.Util.SeaSounds:GetChildren()
    for v10 = 1, #v9 do
        local v11 = v9[v10]
        table.insert(v8, v11)
    end
    for v12 = 1, #v8 do
        if v8[v12]:IsA("Sound") and _G.allThemeIDs[v8[v12].Name] == nil then
            _G.allThemeIDs[v8[v12].Name] = {
                ["id"] = v8[v12].SoundId,
                ["volume"] = v8[v12].Volume
            }
            v8[v12]:Destroy()
        end
    end
end
local function v18() --[[ Line: 74 ]]
    local v14 = _G.areaParent:GetChildren()
    for v15 = 1, #v14 do
        local v16 = v14[v15]
        if v16:FindFirstChild("Settings") and v16.Settings:GetAttribute("ThemeID") then
            local v17 = v16.Settings:GetAttribute("ThemeID")
            if tonumber(v17) ~= nil then
                v17 = "rbxassetid://" .. v17
            end
            if _G.allThemeIDs[v16.Name] == nil then
                _G.allThemeIDs[v16.Name] = {
                    ["id"] = v17,
                    ["volume"] = 0.5
                }
            end
        end
    end
end
if _G.allThemeIDs == nil then
    _G.allThemeIDs = {}
    v13()
end
v18()
_G.themeSong = nil
workspace:WaitForChild("Islands")
repeat
    task.wait()
until _G.tween and game.ReplicatedStorage.reservedCode.Value ~= "checking"
local v19 = require(game.ReplicatedStorage.Modules.Weather)
tick()
local u20 = require(game.ReplicatedStorage.Modules.Rain)
local function u21() --[[ Line: 141 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    u20:SetIntensityRatio(1)
    u20:SetTransparency(0)
    u20:SetDirection(Vector3.new(0, -1, 0))
    u20:SetColor(Color3.fromRGB(255, 255, 255))
    u20:SetVolume(0)
end
local function u23(p22) --[[ Line: 150 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u20
    --]]
    u21()
    u20:SetStraightTexture("rbxassetid://1822883048")
    u20:SetTopDownTexture("rbxassetid://1822856633")
    u20:SetSplashTexture("rbxassetid://1822856633")
    u20:SetSoundId("rbxassetid://11157690509")
    u20:SetVolume(0.5)
    if p22 and p22:FindFirstChild("Settings") then
        u20:SetIntensityRatio(p22.Settings.WeatherIntensity.Value)
    end
    u20:Enable()
end
local function u24(_) --[[ Line: 165 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u20
    --]]
    u21()
    if _G.fastmode == false then
        u20:SetStraightTexture("rbxassetid://1822883048")
        u20:SetTopDownTexture("rbxassetid://1822856633")
        u20:SetSplashTexture("rbxassetid://1822856633")
        u20:SetSoundId("rbxassetid://9941973365")
        u20:SetVolume(0.2)
        u20:Enable()
    end
end
local function v29(u25, u26) --[[ Line: 220 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u21
        [3] = u24
        [4] = u20
    --]]
    local v27, u28 = pcall(function() --[[ Line: 221 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u23
            [3] = u26
            [4] = u21
            [5] = u24
            [6] = u20
        --]]
        if u25 == "Rain" then
            u23(u26)
            return
        elseif u25 == "Snow" then
            u21()
            return
        elseif u25 == "Dust" then
            u21()
            return
        elseif u25 == "ThunderStorm" then
            u24(u26)
            return
        elseif u25 == "Snowy" then
            u21()
            u20:Disable()
        else
            u21()
            u20:Disable()
        end
    end)
    if not v27 then
        task.spawn(function() --[[ Line: 239 ]]
            --[[
            Upvalues:
                [1] = u28
            --]]
            error(u28)
        end)
    end
end
local u30 = workspace.Islands:GetChildren()
workspace.Islands.ChildAdded:Connect(function(p31) --[[ Line: 255 ]]
    --[[
    Upvalues:
        [1] = u30
    --]]
    local v32 = p31:WaitForChild("Settings", 60)
    if v32 then
        v32 = p31.Settings:GetAttribute("ThemeID")
    end
    if v32 and not _G.allThemeIDs[p31.Name] then
        local v33 = p31.Settings:GetAttribute("ThemeID")
        if tonumber(v33) ~= nil then
            v33 = "rbxassetid://" .. v33
        end
        _G.allThemeIDs[p31.Name] = {
            ["id"] = v33,
            ["volume"] = 0.5
        }
    end
    u30 = workspace.Islands:GetChildren()
    local v34 = _G.areaParent:GetChildren()
    for v35 = 1, #v34 do
        local v36 = u30
        local v37 = v34[v35]
        table.insert(v36, v37)
    end
end)
workspace.Effects.Areas.ChildAdded:Connect(function(p38) --[[ Line: 267 ]]
    local v39 = p38:WaitForChild("Settings", 60)
    if v39 then
        local v40 = v39:GetAttribute("ThemeID")
        if v40 and not _G.allThemeIDs[p38.Name] then
            if tonumber(v40) ~= nil then
                v40 = "rbxassetid://" .. v40
            end
            _G.allThemeIDs[p38.Name] = {
                ["id"] = v40,
                ["volume"] = 0.5
            }
        end
    end
end)
workspace.Islands.ChildRemoved:Connect(function() --[[ Line: 280 ]]
    --[[
    Upvalues:
        [1] = u30
    --]]
    u30 = workspace.Islands:GetChildren()
    local v41 = _G.areaParent:GetChildren()
    for v42 = 1, #v41 do
        local v43 = u30
        local v44 = v41[v42]
        table.insert(v43, v44)
    end
end)
u30 = workspace.Islands:GetChildren()
local v45 = _G.areaParent:GetChildren()
local u46 = u30
for v47 = 1, #v45 do
    local v48 = v45[v47]
    table.insert(u46, v48)
end
local function u52(p49) --[[ Line: 293 ]]
    --[[
    Upvalues:
        [1] = u46
    --]]
    for v50 = 1, #u46 do
        if u46[v50] ~= p49 and u46[v50]:FindFirstChild("ThemeSong") then
            u46[v50].ThemeSong:Stop()
        end
    end
    local v51 = workspace:FindFirstChild("islandMusic")
    if v51 and (p49 == nil or _G.allThemeIDs[p49.Name] and v51.SoundId ~= _G.allThemeIDs[p49.Name].id) then
        v51:Stop()
        v51.Name = "gone"
        _G.destroy(v51, 1)
    end
end
local function u67() --[[ Line: 317 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u52
    --]]
    if _G.currentisland ~= u2 then
        u52(nil)
        _G.currentisland = u2
        if u2 == "First Sea" then
            if game.ReplicatedStorage.reservedCode.Value ~= "arena" then
                local u53 = "First Sea"
                local u54 = nil
                local u55 = "Vast waters of the blue ocean"
                task.spawn(function() --[[ Line: 105 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                        [2] = u54
                        [3] = u55
                    --]]
                    repeat
                        task.wait()
                    until game.Players.LocalPlayer.PlayerGui:FindFirstChild("IslandNote") == nil
                    if _G.currentisland == u53 then
                        local v56 = game.ReplicatedStorage.Util.Area.IslandNote:Clone()
                        v56.Parent = game.Players.LocalPlayer.PlayerGui
                        v56.Frame.NameFrame.TextLabel.Text = u53
                        if u54 then
                            v56.Frame.DescFrame.TextLabel.TextColor3 = u54
                        end
                        v56.Frame.DescFrame.TextLabel.Text = u55
                        v56.Frame.LocalScript.Disabled = false
                        game.ReplicatedStorage.Util.Area.notification:Play()
                    end
                end)
            end
        elseif game.ReplicatedStorage.reservedCode.Value ~= "arena" then
            local u57 = "Second Sea"
            local u58 = nil
            local u59 = "Waters of the new world"
            task.spawn(function() --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u58
                    [3] = u59
                --]]
                repeat
                    task.wait()
                until game.Players.LocalPlayer.PlayerGui:FindFirstChild("IslandNote") == nil
                if _G.currentisland == u57 then
                    local v60 = game.ReplicatedStorage.Util.Area.IslandNote:Clone()
                    v60.Parent = game.Players.LocalPlayer.PlayerGui
                    v60.Frame.NameFrame.TextLabel.Text = u57
                    if u58 then
                        v60.Frame.DescFrame.TextLabel.TextColor3 = u58
                    end
                    v60.Frame.DescFrame.TextLabel.Text = u59
                    v60.Frame.LocalScript.Disabled = false
                    game.ReplicatedStorage.Util.Area.notification:Play()
                end
            end)
        end
        local v61 = math.random(1, 13)
        local v62 = game.ReplicatedStorage.Util.SeaSounds:GetChildren()
        for v63 = 1, #v62 do
            v62[v63]:Stop()
        end
        if _G.themeSong then
            _G.themeSong:Stop()
            _G.themeSong = nil
        end
        local v64 = _G
        local v65 = "SeaSFX" .. v61
        local v66 = Instance.new("Sound")
        v66.Name = "islandMusic"
        v66.SoundId = _G.allThemeIDs[v65].id
        v66.Volume = _G.allThemeIDs[v65].volume
        v66.SoundGroup = game.SoundService.Music
        v66.Parent = workspace
        v64.themeSong = v66
        _G.themeSong:Play()
    end
end
local function v80(p68) --[[ Line: 345 ]]
    --[[
    Upvalues:
        [1] = u52
        [2] = u67
    --]]
    if p68 == nil then
        if game.ReplicatedStorage.reservedCode.Value == "arena" then
            u52(nil)
        else
            u67()
        end
    else
        if _G.currentisland ~= p68.Name then
            warn("DZRL", p68.Name)
            _G.currentisland = p68.Name
            p68:WaitForChild("Settings", 2)
            if p68.Settings:GetAttribute("HideNotification") == nil then
                local u69 = p68.Name
                local u70 = p68.Settings.Desc.Value
                local u71 = p68.Settings.TextColor.Value
                if game.ReplicatedStorage.reservedCode.Value ~= "arena" then
                    task.spawn(function() --[[ Line: 105 ]]
                        --[[
                        Upvalues:
                            [1] = u69
                            [2] = u71
                            [3] = u70
                        --]]
                        repeat
                            task.wait()
                        until game.Players.LocalPlayer.PlayerGui:FindFirstChild("IslandNote") == nil
                        if _G.currentisland == u69 then
                            local v72 = game.ReplicatedStorage.Util.Area.IslandNote:Clone()
                            v72.Parent = game.Players.LocalPlayer.PlayerGui
                            v72.Frame.NameFrame.TextLabel.Text = u69
                            if u71 then
                                v72.Frame.DescFrame.TextLabel.TextColor3 = u71
                            end
                            v72.Frame.DescFrame.TextLabel.Text = u70
                            v72.Frame.LocalScript.Disabled = false
                            game.ReplicatedStorage.Util.Area.notification:Play()
                        end
                    end)
                end
            end
            local v73 = game.ReplicatedStorage.Util.SeaSounds:GetChildren()
            for v74 = 1, #v73 do
                v73[v74]:Stop()
            end
            local v75 = p68:FindFirstChild("ThemeSong")
            if v75 == nil then
                v75 = p68.Settings:FindFirstChild("ThemeSong")
            end
            if v75 == nil and _G.allThemeIDs[p68.Name] then
                local v76 = p68.Name
                v75 = Instance.new("Sound")
                v75.Name = "islandMusic"
                v75.SoundId = _G.allThemeIDs[v76].id
                v75.Volume = _G.allThemeIDs[v76].volume
                v75.SoundGroup = game.SoundService.Music
                v75.Parent = workspace
                warn("using cache sound")
            end
            if _G.themeSong and _G.themeSong ~= v75 then
                local u77 = _G.themeSong
                _G.tween(u77, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                if u77.Name == "islandMusic" then
                    _G.destroy(u77, 1)
                end
                _G.themeSong = nil
                task.spawn(function() --[[ Line: 387 ]]
                    --[[
                    Upvalues:
                        [1] = u77
                    --]]
                    task.wait(1)
                    u77:Stop()
                end)
            end
            if v75 ~= nil and v75.IsPlaying == false then
                v75.Looped = true
                v75:Play()
                local _ = v75.Volume
                v75.Volume = 0
                _G.tween(v75, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 1
                })
                _G.themeSong = v75
            end
            if v75 then
                v75.SoundGroup = game.SoundService.Music
            end
        end
        u52(p68)
        local v78 = game.ReplicatedStorage.Util.SeaSounds:GetChildren()
        for v79 = 1, #v78 do
            v78[v79]:Stop()
        end
        return
    end
end
math.random(1, 1000)
local v81 = 0
if _G.themeSong then
    _G.themeSong:Stop()
    _G.themeSong = nil
end
if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") ~= nil then
    game.ReplicatedStorage.Assets.IslandMusic:ClearAllChildren()
end
local v82 = Vector3.new()
local v83 = {}
while true do
    local v84 = workspace.CurrentCamera
    if tick() - v81 >= 1 or (v84.CFrame.Position - v82).Magnitude >= 300 then
        v82 = v84.CFrame.Position
        local v85 = _G.areaParent:GetChildren()
        local v86 = workspace.Islands:GetChildren()
        local v87 = nil
        local v88 = nil
        for v89 = 1, #v85 do
            local v90 = v85[v89]
            if v83[v90.Name] == nil then
                local v91
                if v90:IsA("Model") then
                    v91 = v90:GetAttribute("islandCFrame")
                    if v90:GetAttribute("islandSize") then
                        size = v90:GetAttribute("islandSize") + Vector3.new(50, 500, 50)
                    else
                        size = v90:GetModelSize() + Vector3.new(50, 500, 50)
                    end
                else
                    v91 = v90.CFrame
                    size = v90.Size
                end
                local v92 = Vector2.new(size.X, size.Z)
                v83[v90.Name] = {
                    ["cf"] = v91,
                    ["size"] = size,
                    ["size2D"] = v92
                }
            end
            local v93, v94
            if v90:IsA("Model") then
                v93 = v83[v90.Name].cf
                v94 = v83[v90.Name].size
            else
                v93 = v90.CFrame
                v94 = v90.Size
            end
            if v1:setup(v90, v93, v94) == true then
                local v95 = v94.Magnitude
                if v87 == nil or v95 < v83[v87.Name].size.Magnitude then
                    v87 = v90
                end
            end
        end
        if v87 then
            v88 = v87
        else
            for v96 = 1, #v86 do
                if v83[v86[v96].Name] == nil then
                    local v97
                    if v86[v96]:IsA("Model") then
                        v97 = v86[v96]:GetAttribute("islandCFrame")
                        if v86[v96]:GetAttribute("islandSize") then
                            size = v86[v96]:GetAttribute("islandSize") + Vector3.new(50, 500, 50)
                        else
                            size = v86[v96]:GetModelSize() + Vector3.new(50, 500, 50)
                        end
                    else
                        v97 = v86[v96].CFrame
                        size = v86[v96].Size
                    end
                    local v98 = Vector2.new(size.X, size.Z)
                    v83[v86[v96].Name] = {
                        ["cf"] = v97,
                        ["size"] = size,
                        ["size2D"] = v98
                    }
                end
                local v99, v100
                if v86[v96]:IsA("Model") then
                    v99 = v83[v86[v96].Name].cf
                    v100 = v83[v86[v96].Name].size
                else
                    v99 = v86[v96].CFrame
                    v100 = v86[v96].Size
                end
                if v1:setup(v86[v96], v99, v100) == true and (not v86[v96]:IsA("Part") or (not v88 or v88.Name ~= "???? Shrine" and not v88:FindFirstChild("Pro")) or ((not v86[v96]:IsA("Part") or (v86[v96].Size.Magnitude >= v100.Magnitude or (not v86[v96]:FindFirstChild("Pro") or v86[v96]:FindFirstChild("Pro2") ~= nil))) and true or false) ~= true) then
                    v88 = v86[v96]
                end
            end
        end
        if v88 == nil then
            if script.Folder.DistantWavesAmb.Volume ~= 0 then
                _G.tween(script.Folder.DistantWavesAmb, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                task.delay(1, function() --[[ Line: 620 ]]
                    script.Folder.DistantWavesAmb:stop()
                end)
            end
            if script.Folder.OceanWavesAmb.Volume ~= 0.2 then
                _G.tween(script.Folder.OceanWavesAmb, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0.2
                })
            end
            if script.Folder.OceanWavesAmb.IsPlaying == false then
                script.Folder.OceanWavesAmb:Play()
            end
            if script.Folder.SunnyDayAmb.IsPlaying == true then
                script.Folder.SunnyDayAmb:Stop()
            end
            if script.Folder.CalmNightCricketsAmb.IsPlaying == true then
                script.Folder.CalmNightCricketsAmb:Stop()
            end
        else
            local v101 = v83[v88.Name].cf.Position
            local _ = v83[v88.Name].size
            local v102 = v83[v88.Name].size2D
            local v103
            if v88:IsA("Part") and v88:GetAttribute("ParentIsland") ~= nil then
                v103 = workspace.Islands:FindFirstChild(v88:GetAttribute("ParentIsland"))
            else
                v103 = v88
            end
            local v104 = v101.X
            local v105 = workspace.Env.WaterStuff.Falls.Position.Y
            local v106 = v101.Z
            local v107 = Vector3.new(v104, v105, v106)
            local v108 = v84.CFrame.Position
            local v109 = v108.X
            local v110 = v107.Y
            local v111 = v108.Z
            local _ = (v107 - Vector3.new(v109, v110, v111)).Magnitude
            local _ = v102.magnitude / 20
            if script.Folder.OceanWavesAmb.Volume ~= 0 then
                _G.tween(script.Folder.OceanWavesAmb, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
            end
            local v112 = game.Lighting.ClockTime
            local v113 = script.Folder.CustomAmbs:FindFirstChild(v103.Name)
            if v113 == nil then
                if v112 >= 18 then
                    if script.Folder.CalmNightCricketsAmb.IsPlaying == false then
                        script.Folder.CalmNightCricketsAmb:Play()
                        script.Folder.CalmNightCricketsAmb.Volume = 0
                        _G.tween(script.Folder.CalmNightCricketsAmb, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0.6
                        })
                    end
                    if script.Folder.SunnyDayAmb.Volume ~= 0 then
                        _G.tween(script.Folder.SunnyDayAmb, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                        task.delay(1, function() --[[ Line: 569 ]]
                            script.Folder.SunnyDayAmb:Stop()
                        end)
                    end
                elseif v112 >= 6 and v112 < 17 then
                    if script.Folder.CalmNightCricketsAmb.Volume ~= 0 then
                        _G.tween(script.Folder.CalmNightCricketsAmb, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                        task.delay(1, function() --[[ Line: 576 ]]
                            script.Folder.CalmNightCricketsAmb:Stop()
                        end)
                    end
                    if script.Folder.SunnyDayAmb.IsPlaying == false and _G.currentweather == "Normal" then
                        script.Folder.SunnyDayAmb.Volume = 0
                        script.Folder.SunnyDayAmb:Play()
                        _G.tween(script.Folder.SunnyDayAmb, {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0.6
                        })
                    elseif _G.currentweather ~= "Normal" then
                        script.Folder.SunnyDayAmb:Stop()
                    end
                end
                local u114 = script.Folder.CustomAmbs:GetChildren()
                for u115 = 1, #u114 do
                    if u114[u115].Volume ~= 0 and u114[u115]:GetAttribute("settingVolume") == nil then
                        u114[u115]:SetAttribute("settingVolume", true)
                        _G.tween(u114[u115], {
                            1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                        task.delay(1, function() --[[ Line: 594 ]]
                            --[[
                            Upvalues:
                                [1] = u114
                                [2] = u115
                            --]]
                            u114[u115]:SetAttribute("settingVolume", nil)
                            u114[u115]:Stop()
                        end)
                    end
                end
            else
                script.Folder.SunnyDayAmb:Stop()
                script.Folder.CalmNightCricketsAmb:Play()
                local v116 = script.Folder.CustomAmbs:GetChildren()
                for v117 = 1, #v116 do
                    if v116[v117] ~= v113 then
                        v116[v117]:Stop()
                    end
                end
                if v113.IsPlaying == false then
                    v113:Play()
                    v113.Volume = 0
                    _G.tween(v113, {
                        1,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Volume"] = 0.2
                    })
                end
            end
        end
        if v88 == nil and _G.currentweather ~= workspace.Env.Settings.Weather.Value then
            v19:set(workspace.Env.Settings.Weather.Value, v3)
        end
        if v88 and (v88:FindFirstChild("Settings") and _G.currentweather ~= v88.Settings.Weather.Value) then
            v19:set(v88.Settings.Weather.Value, v3)
        end
        v80(v88)
        if v88 == nil then
            v88 = workspace.Env
        end
        v29(v88.Settings.Weather.Value, v88)
        v81 = tick()
    end
    task.wait()
end