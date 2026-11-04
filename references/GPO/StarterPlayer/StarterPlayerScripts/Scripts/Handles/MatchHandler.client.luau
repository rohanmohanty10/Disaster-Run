 

repeat
    task.wait()
until game.Players.LocalPlayer
local u1 = game.Players.LocalPlayer
local u2 = nil
game.ReplicatedStorage:WaitForChild("matchEvents")
local u3 = workspace.CurrentCamera
local u4 = {}
local u5 = nil
function Lerp(p6, p7, p8)
    return p6 + (p7 - p6) * p8
end
local u9 = nil
local u10 = {}
function _G.matchEvent(p11, p12, u13, u14, p15, p16) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u10
        [4] = u4
        [5] = u9
        [6] = u5
        [7] = u3
    --]]
    if p11 ~= "loadingmapPercent" then
        print("NEW ENV " .. p11)
    end
    if u2 == p11 and p11 ~= "unspec" then
        warn("is current env " .. p11)
        return
    end
    if p11 == "camera" then
        local u17 = workspace.CurrentCamera
        task.spawn(function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u17
            --]]
            if u14 then
                u14 = _G.awaitObject(u14)
                while true do
                    workspace.CurrentCamera.CameraSubject = u14
                    game.Players.LocalPlayer.ReplicationFocus = u14.Parent.PrimaryPart
                    task.wait()
                end
            else
                local v18 = workspace.Env:WaitForChild("Winner"):WaitForChild("Cam").CFrame
                if u14 then
                    v18 = u14
                end
                while true do
                    game["Run Service"].Heartbeat:Wait()
                    u17.CameraType = Enum.CameraType.Scriptable
                    u17.CFrame = v18
                end
            end
        end)
        if u14 == nil or u14 and (game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and u14 ~= game.Players.LocalPlayer.Character.Humanoid)) then
            _G.hideUI(true)
        end
        local v19 = script.winner:Clone()
        v19:SetAttribute("unhideable", true)
        v19.Frame.TextLabel.Text = p12
        v19.Parent = u1.PlayerGui
        if u13 then
            v19.Frame.TextLabel.UIGradient.Color = u13
        end
        return
    end
    if p11 == "waveInfo" then
        local v20 = script.waveInfo:Clone()
        v20.Frame.TextLabel.Text = p12
        v20.Frame.Size = UDim2.new(1.25, 0, 0, 0)
        v20.Frame.TextLabel.TextTransparency = 1
        if u13 then
            v20.Frame.TextLabel.TextColor3 = u13
        end
        if p16 then
            v20.Frame.Position = p16
        end
        v20.Parent = game.Players.LocalPlayer.PlayerGui
        _G.tween(v20.Frame, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = UDim2.new(1.25, 0, script.waveInfo.Frame.Size.Y.Scale, 0)
        })
        if u14 and script.ObjectiveSFX:FindFirstChild(u14) then
            if u10[u14] == nil then
                u10[u14] = 0
            end
            local v21 = u10
            v21[u14] = v21[u14] + 1
            script.ObjectiveSFX:FindFirstChild(u14):GetChildren()[math.random(1, #script.ObjectiveSFX:FindFirstChild(u14):GetChildren())]:Play()
            if u10[u14] >= #script.ObjectiveSFX:FindFirstChild(u14):GetChildren() then
                u10[u14] = 0
            end
        end
        task.wait(0.25)
        _G.tween(v20.Frame.TextLabel, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextTransparency"] = 0
        })
        if p15 == nil then
            task.wait(3)
        else
            task.wait(p15)
        end
        _G.tween(v20.Frame.TextLabel, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TextTransparency"] = 1
        })
        task.wait(0.25)
        _G.tween(v20.Frame, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = UDim2.new(1.25, 0, 0, 0)
        })
        _G.destroy(v20, 1)
        return
    end
    if p11 == "displayMinimap" then
        require(script.DisplayMinimap):Display(p12)
        return
    end
    if p11 == "hideUI" then
        game.StarterGui:SetCoreGuiEnabled("Health", false)
        game.Players.LocalPlayer.PlayerGui.HealthBars:ClearAllChildren()
        _G.hideUI(true)
        return
    end
    if p11 == "spec" and game.Players.LocalPlayer.PlayerGui:FindFirstChild("Spec") == nil then
        local u22 = u1.PlayerGui:GetChildren()
        for u23 = 1, #u22 do
            local v24 = u22[u23]
            if v24:IsA("ScreenGui") and (v24.Enabled and (string.lower(v24.Name):match("topbar") == nil and v24:GetAttribute("unhideable") == nil)) then
                pcall(function() --[[ Line: 122 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u23
                        [3] = u4
                    --]]
                    u22[u23].Enabled = false
                    local v25 = u4
                    local v26 = u22[u23]
                    table.insert(v25, v26)
                end)
            end
        end
        local v27 = game.ReplicatedStorage.Assets:GetDescendants()
        for v28 = 1, #v27 do
            if v27[v28]:IsA("Sound") then
                v27[v28]:Stop()
            end
        end
        local v29 = script.Spec:Clone()
        v29.Parent = u1.PlayerGui
        v29.LocalScript.Disabled = false
    else
        if p11 == "unspec" then
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Spec") then
                game.Players.LocalPlayer.PlayerGui:FindFirstChild("Spec"):Destroy()
            end
            pcall(function() --[[ Line: 142 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
                u1.PlayerGui.Matchmake.Enabled = true
            end)
            for u30 = 1, #u4 do
                pcall(function() --[[ Line: 148 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u30
                    --]]
                    u4[u30].Enabled = true
                end)
            end
            u4 = {}
            return
        end
        if p11 == "removeTeamMarker" then
            local v31 = tick()
            local v32 = false
            while true do
                task.wait()
                if tick() - v31 >= 5 then
                    v32 = true
                    break
                end
                if p12.Party.Value == game.Players.LocalPlayer.Party.Value then
                    break
                end
            end
            if v32 == true then
                warn("timed out for " .. p12.Name)
            elseif p12.Party.Value == game.Players.LocalPlayer.Party.Value then
                warn(p12.Name .. " vs " .. game.Players.LocalPlayer.Party.Value.Name)
                repeat
                    task.wait()
                until u13 ~= nil or p12.Character and (p12.Character:FindFirstChild("Head") and p12.Character.Head:FindFirstChild("TeamID") ~= nil)
                if u13 == nil then
                    u13 = p12.Character.Head:FindFirstChild("TeamID")
                    warn("replacing arg3")
                end
                u13.Size = UDim2.new(0, 0, 0, 0)
            end
        end
        if p11 == "startStorm" then
            local u33 = _G.awaitObject(p16).PrimaryPart
            _G.stormPart = u33
            game:GetService("CollectionService"):AddTag(u33, "stormCenter")
            warn("starting storm!")
            u9 = p15
            _G.tween(u33.Mesh, {
                u14 - workspace:GetServerTimeNow(),
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = p15
            })
            u5 = u33
            warn("storm end time is " .. u14 - workspace:GetServerTimeNow())
            local u34 = Instance.new("Attachment", workspace.Terrain)
            local u35 = script.BrStormLoop1:Clone()
            u35.Parent = u34
            u35.RollOffMaxDistance = 0
            local u36 = false
            game["Run Service"].Heartbeat:Connect(function() --[[ Line: 205 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u33
                    [3] = u34
                    [4] = u35
                    [5] = u36
                --]]
                if u5:FindFirstChild("Mesh") == nil then
                    return
                else
                    local v37 = workspace.CurrentCamera
                    local v38 = (v37.CFrame.Position - u33.Position).magnitude
                    u34.WorldCFrame = u33.CFrame:Lerp(v37.CFrame, 1.01)
                    local v39 = u35
                    local v40 = u5.Mesh.Scale.X / 2 * 0.75
                    v39.RollOffMaxDistance = math.clamp(v40, 1000, 100000000000) + 50
                    if v38 + 500 >= u5.Mesh.Scale.X / 2 * 0.75 and v38 <= u5.Mesh.Scale.X / 2 then
                        u36 = true
                        if u35.IsPlaying == false then
                            u35:Play()
                        end
                        u35.Volume = Lerp(0, 0.5, v38 / (u5.Mesh.Scale.X / 2))
                    elseif u36 == true then
                        u36 = false
                        _G.tween(u35, {
                            0.25,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        }, nil, true)
                        task.delay(0.25, function() --[[ Line: 225 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                            --]]
                            u35:Stop()
                        end)
                    end
                end
            end)
        elseif p11 == "spawnfs" then
            warn("spawning fs")
            local v41 = script.medalPiller:Clone()
            v41:PivotTo(CFrame.new(p12.Position) * CFrame.Angles(0, 0, 1.5707963267948966))
            v41.Parent = workspace.Effects
            local v42 = v41:GetChildren()
            for v43 = 1, #v42 do
                v42[v43].Mesh.Scale = Vector3.new(3000, 0, 0)
                _G.tween(v42[v43].Mesh, {
                    10,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(3000, 35, 35)
                }, nil, true)
                _G.tween(v42[v43], {
                    10,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Transparency"] = 1
                }, nil, true)
                v42[v43].Color = u13
            end
            _G.PlaySound(p12, script.FightstyleTokenSpawn)
            _G.destroy(v41, 21)
        elseif p11 == "spawnMedal" then
            local v44 = script.invertedSphere:Clone()
            v44:PivotTo(CFrame.new(p12.Position))
            v44.Color = u13
            v44.Size = Vector3.new(0, 0, 0)
            v44.Parent = workspace.Effects
            _G.tween(v44, {
                10,
                "Exponential",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Size"] = Vector3.new(15, 15, 15),
                ["Transparency"] = 1
            }, nil, true)
            _G.destroy(v44, 21)
        elseif p11 == "screenFlash" then
            local u45 = script.ScreenGui:Clone()
            u45.Parent = game.Players.LocalPlayer.PlayerGui
            u45.Frame.BackgroundTransparency = 1
            _G.destroy(u45, p12 + 1)
            _G.tween(u45.Frame, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["BackgroundTransparency"] = 0
            }, nil, true)
            if p12 ~= nil then
                task.spawn(function() --[[ Line: 266 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                    --]]
                    local v46 = { u13 }
                    game:GetService("ContentProvider"):PreloadAsync(v46)
                end)
            end
            task.wait(p12)
            pcall(function() --[[ Line: 271 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                _G.tween(u45.Frame, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["BackgroundTransparency"] = 1
                }, nil, true)
                _G.destroy(u45, 0.25)
            end)
            if script:FindFirstChild("royaleMusic") then
                script.royaleMusic:Play()
                script.royaleMusic.Name = "played"
            end
        elseif p11 == "disablePlayerList" then
            game.StarterGui:SetCoreGuiEnabled("PlayerList", false)
            _G.PlayerListVisible(false)
        else
            if p11 == "globalFeed" then
                local v47 = script.TextLabel:Clone()
                v47.Text = p12
                v47.Parent = u1.PlayerGui.globalFeed.globalFeed
                task.wait(60)
                _G.tween(v47, {
                    2,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["TextTransparency"] = 1,
                    ["TextStrokeTransparency"] = 1
                }, nil, true)
                _G.destroy(v47, 2)
                return
            end
            if p11 == "adjustStorm" then
                if u5 then
                    local v48 = {
                        ["Scale"] = u9
                    }
                    _G.tween(u5.Mesh, {
                        p12 - workspace:GetServerTimeNow(),
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, v48, nil, true)
                end
                return
            end
            if p11 == "returningToLobby" then
                _G.hideUI(true)
                script.screenInfo:Clone().Parent = u1.PlayerGui
            else
                if p11 == "addHotZone" then
                    repeat
                        task.wait()
                    until _G.addBlip ~= nil
                    warn("found hotzone global")
                    local v49 = script.storm:Clone()
                    v49.Transparency = 1
                    v49.CFrame = p12
                    v49.Mesh.Scale = Vector3.new(u13, 1, u13)
                    v49.Parent = workspace.Effects
                    _G.destroy(v49, 600)
                    _G.addBlip("hotZone", v49)
                    return
                end
                if p11 == "addCampfire" then
                    repeat
                        task.wait()
                    until _G.addBlip ~= nil
                    local v50 = script.storm:Clone()
                    v50.Transparency = 1
                    v50.CFrame = p12
                    v50.Parent = workspace.Effects
                    _G.addBlip("campfire", v50)
                    return
                end
                if p11 == "busRoute" then
                    local v51 = p12:Lerp(u13, 0.5)
                    local v52 = (p12.p - u13.p).Magnitude
                    repeat
                        task.wait()
                    until _G.addBusRoute ~= nil
                    local v53 = script.storm:Clone()
                    v53.Transparency = 1
                    v53.CFrame = v51
                    v53.Parent = workspace.Effects
                    _G.destroy(v53, 60)
                    _G.addBusRoute(p12, v51, v52, v53)
                else
                    if p11 == "loadingmapPercent" then
                        u1.PlayerGui:WaitForChild("Matchmake", 600).TextLabel.Text = "Loading map... (" .. p12 .. "%)"
                        return
                    end
                    if p11 == "areaLabel" then
                        repeat
                            task.wait()
                        until _G.addBlip ~= nil
                        local v54 = script.storm:Clone()
                        v54.Transparency = 1
                        v54.Name = u13
                        v54.CFrame = p12
                        v54.Parent = workspace.Effects
                        _G.addBlip("areaLabel", v54)
                        return
                    end
                    if p11 == "phoLabel" then
                        repeat
                            task.wait()
                        until _G.addBlip ~= nil
                        local v55 = script.storm:Clone()
                        v55.Transparency = 1
                        v55.CFrame = p12
                        v55.Parent = workspace.Effects
                        _G.addBlip("phoLabel", v55)
                        return
                    end
                    if p11 == "customBlip" then
                        repeat
                            task.wait()
                        until _G.addBlip ~= nil
                        warn(p12, u13)
                        _G.addBlip("customBlip", p12, nil, u13)
                        return
                    end
                    if p11 == "startBarriers" then
                        if p12:FindFirstChild("Walls") ~= nil then
                            local u56 = require(game.ReplicatedStorage.Modules.DistanceFade).new()
                            local v57 = p12.Walls:GetChildren()
                            local v58 = Vector3.new(0, 0, 0)
                            local v59 = 0
                            for _, v60 in ipairs(v57) do
                                if v60:IsA("BasePart") then
                                    v58 = v58 + v60.Position
                                    v59 = v59 + 1
                                end
                            end
                            local u61 = v58 / v59
                            local function v69(p62) --[[ Line: 395 ]]
                                --[[
                                Upvalues:
                                    [1] = u61
                                --]]
                                local v63 = (1 / 0)
                                local v64 = nil
                                for _, v65 in ipairs(Enum.NormalId:GetEnumItems()) do
                                    local v66 = (u61 - (p62.CFrame * CFrame.new(p62.Size / 2 * Vector3.FromNormalId(v65))).Position).Unit
                                    local v67 = p62.CFrame:VectorToWorldSpace(Vector3.FromNormalId(v65)).Unit:Dot(v66)
                                    local v68 = math.acos(v67)
                                    if v68 < v63 then
                                        v64 = v65
                                        v63 = v68
                                    end
                                end
                                return v64
                            end
                            for _, v70 in ipairs(v57) do
                                if v70:IsA("BasePart") then
                                    local v71 = v69(v70)
                                    if v71 then
                                        u56:AddFace(v70, v71)
                                        print(v70.Name .. "\'s inward-facing NormalId is: " .. v71.Name)
                                    end
                                end
                            end
                            u56:UpdateSettings({
                                ["DistanceOuter"] = 16,
                                ["DistanceInner"] = 4,
                                ["EffectRadius"] = 16,
                                ["EffectRadiusMin"] = 0,
                                ["EdgeDistanceCalculations"] = false,
                                ["Texture"] = "rbxassetid://18838056070",
                                ["TextureTransparency"] = 0,
                                ["TextureTransparencyMin"] = 1,
                                ["BackgroundTransparency"] = 1,
                                ["BackgroundTransparencyMin"] = 1,
                                ["TextureColor"] = Color3.fromRGB(170, 255, 255),
                                ["BackgroundColor"] = Color3.fromRGB(170, 255, 255),
                                ["TextureSize"] = Vector2.new(8, 8),
                                ["TextureOffset"] = Vector2.new(0, 0),
                                ["ZOffset"] = 0,
                                ["AlwaysOnTop"] = false,
                                ["Brightness"] = 3,
                                ["LightInfluence"] = 0,
                                ["MaxDistance"] = 1000,
                                ["PixelsPerStud"] = 100,
                                ["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud
                            })
                            game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 453 ]]
                                --[[
                                Upvalues:
                                    [1] = u56
                                --]]
                                u56:Step()
                            end)
                        end
                    end
                end
            end
        end
    end
    if p11 ~= "spawnfs" and (p11 ~= "spawnMedal" and (p11 ~= "startStorm" and (p11 ~= "globalFeed" and (p11 ~= "screenFlash" and (p11 ~= "addHotZone" and p11 ~= "customText"))))) then
        u2 = p11
    end
    local v72 = u1.PlayerGui:WaitForChild("Matchmake", 600)
    if p11 == "waitingPlayers" then
        while true do
            task.wait(1)
            v72.TextLabel.Text = "Waiting for players to fully load. (" .. game.ReplicatedStorage.Matchinfo.waittime.Value .. ")"
            if game.ReplicatedStorage.Matchinfo.waittime:GetAttribute("done") then
                break
            end
            warn("cotuning down")
            if u2 == "waitingPlayers" then
                break
            end
        end
        warn("copunt edned new env " .. u2)
    elseif p11 == "inter" then
        repeat
            v72.TextLabel.Text = "Intermission " .. game.ReplicatedStorage.Matchinfo.int.Value
            game["Run Service"].Heartbeat:Wait()
        until u2 ~= p11 and u2 ~= ""
        warn("eneded inter new state " .. u2)
    else
        if p11 ~= "loadingmap" then
            if p11 ~= "matchStart" then
                if p11 == "returning" then
                    v72.TextLabel.Text = "Returning..."
                elseif p11 == "gameOver" then
                    u1.PlayerGui.Matchmake.Enabled = true
                    v72.TextLabel.Text = "GAME OVER"
                    v72.Frame.Visible = true
                elseif p11 == "customText" then
                    v72.Enabled = true
                    v72.TextLabel.Visible = true
                    v72.TextLabel.Text = p12
                end
                goto l152
            end
            _G.arenaMatchStarted = true
            if v72 == nil then
                return
            end
            v72.TextLabel.Visible = false
            if p12 then
                warn(p12:GetFullName())
            end
            if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") == nil and (p12 and p12:FindFirstChild("Scene")) then
                pcall(function() --[[ Line: 500 ]]
                    _G.disableMovement(true)
                end)
                v72.TextLabel.Visible = false
                u3.CameraType = Enum.CameraType.Scriptable
                local u73 = script.ScreenGui:Clone()
                u73.Parent = game.Players.LocalPlayer.PlayerGui
                local function v76(p74) --[[ Line: 507 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    local v75 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                    game:GetService("TweenService"):Create(u3, v75, {
                        ["CFrame"] = p74
                    }):Play()
                end
                p12:WaitForChild("Scene"):WaitForChild("1")
                local v77 = p12.Scene:GetChildren()
                local v78 = 0
                local u79 = {}
                local function v81() --[[ Line: 516 ]]
                    --[[
                    Upvalues:
                        [1] = u73
                    --]]
                    local v80 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                    game:GetService("TweenService"):Create(u73.Frame, v80, {
                        ["BackgroundTransparency"] = 1
                    }):Play()
                end
                while true do
                    for v82 = 1, #v77 do
                        if v77[v82] then
                            local v83 = v77[v82].Name
                            if tonumber(v83) == v78 + 1 then
                                v78 = v78 + 1
                                local v84 = v77[v82]
                                table.insert(u79, v84)
                            end
                        end
                    end
                    task.wait()
                    warn("match start")
                    if #u79 == #v77 then
                        local v85 = CFrame.Angles(0, 0, 0)
                        local v86 = false
                        for u87 = 1, #u79 do
                            if u87 > 1 and v86 == false then
                                v81()
                                task.spawn(function() --[[ Line: 547 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u79
                                        [2] = u87
                                    --]]
                                    _G.requestStream(u79[u87].Value.Position)
                                end)
                                v76(u79[u87].Value * v85)
                                task.wait(1.5)
                                v86 = true
                            else
                                u73.Frame.BackgroundTransparency = 0
                                u3.CFrame = u79[u87].Value * v85
                                v86 = false
                            end
                        end
                        u73.Frame.BackgroundTransparency = 0
                        v81()
                        u3.CameraType = Enum.CameraType.Custom
                        task.wait(0.5)
                        goto l167
                    end
                end
            else
                ::l167::
                if v72:FindFirstChild("Wave") == nil then
                    v72.Enabled = false
                end
                _G.disableMovement(false)
                goto l152
            end
        end
        v72.TextLabel.Text = "Loading map..."
    end
    ::l152::
end
game.ReplicatedStorage.matchEvents.OnClientEvent:Connect(function(...) --[[ Line: 585 ]]
    _G.matchEvent(...)
end)
u1.CharacterAdded:Connect(function() --[[ Line: 589 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2 = ""
end)