 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
require(v1.Modules.CraterHandler)
require(v1.Modules.BezierFormula)
require(v1.Modules.LightningBolt)
local u4 = v3.LocalPlayer
local u5 = workspace.Effects
local u6 = {}
function Flipbook(p7, u8, u9, u10)
    local u11 = p7:FindFirstChildOfClass("SpecialMesh")
    if u11 and u8 then
        task.spawn(function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u11
                [3] = u9
                [4] = u10
            --]]
            for v12 = 1, #u8 do
                u11.TextureId = u8[v12]
                task.wait(1 / u9)
            end
            if u10 == true then
                u11.Parent:Destroy()
            end
        end)
    end
end
local function u23(p13, p14, p15) --[[ Line: 36 ]]
    local function v21(u16, p17, p18) --[[ Line: 37 ]]
        for _, v19 in ipairs(u16:GetDescendants()) do
            if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                v19.Enabled = p17
            end
        end
        if p18 then
            task.delay(p18, function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                for _, v20 in ipairs(u16:GetDescendants()) do
                    if v20:IsA("ParticleEmitter") or v20:IsA("Trail") then
                        v20.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p13) == "table" then
        for _, v22 in p13 do
            v21(v22, p14, p15)
        end
    else
        v21(p13, p14, p15)
    end
end
local v24 = RaycastParams.new()
v24.FilterType = Enum.RaycastFilterType.Include
v24.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
local v25 = {}
local u26 = script.ImpactFrames
function v25.start(_, p27, u28, u29, p30) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u2
        [4] = u26
        [5] = u4
        [6] = u23
    --]]
    if _G.checkRenderDistance(u28.PrimaryPart.Position) ~= false then
        if p27 == "Ultimate" then
            local v31 = u28.HumanoidRootPart
            u28:FindFirstChild("Humanoid")
            u6[u28] = {}
            Color3.fromRGB(142, 161, 255)
            if u28 == game.Players.LocalPlayer.Character or u29 == game.Players.LocalPlayer.Character then
                _G.PlayEffect("CameraHideUI", nil, true)
                local u32 = script.CameraRig:Clone()
                u32:SetPrimaryPartCFrame(p30)
                u32.Parent = u5
                u32:FindFirstChild("Humanoid"):LoadAnimation(script.Animations.Camera):Play()
                local u33 = workspace.CurrentCamera
                u33.CameraType = Enum.CameraType.Scriptable
                u33.FieldOfView = 70
                local u34 = u2.Heartbeat:Connect(function() --[[ Line: 100 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u32
                    --]]
                    u33.CFrame = u32.Camera.CFrame
                end)
                task.delay(10.3, function() --[[ Line: 104 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u33
                        [3] = u32
                    --]]
                    u34:Disconnect()
                    u33.CameraType = Enum.CameraType.Custom
                    u32:Destroy()
                    u33.FieldOfView = 70
                end)
                local u35 = Instance.new("ScreenGui")
                u35.Name = "impactFrame"
                u35.IgnoreGuiInset = true
                for v36 = 1, 10 do
                    local v37 = Instance.new("ImageLabel")
                    v37.BackgroundTransparency = 1
                    v37.Position = UDim2.new(0.99, 0, 0.99, 0)
                    v37.AnchorPoint = Vector2.new(0.5, 0.5)
                    v37.Size = UDim2.new(0, 1, 0, 1)
                    v37.Selectable = false
                    v37.ScaleType = Enum.ScaleType.Crop
                    v37.Visible = true
                    v37.Image = u26["" .. v36].Texture
                    v37.Name = tostring(v36)
                    v37.Parent = u35
                end
                u35.Parent = u4.PlayerGui
                task.delay(8.4, function() --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                    --]]
                    for v38 = 1, 10 do
                        local v39 = u35:FindFirstChild((tostring(v38)))
                        v39.Position = UDim2.new(0.5, 0, 0.5, 0)
                        v39.Size = UDim2.new(1, 0, 1, 0)
                        v39.Visible = true
                        task.wait(0.03333333333333333)
                        v39.Visible = false
                    end
                    u35:Destroy()
                end)
            end
            local u40 = script.UltVFX:Clone()
            u40:PivotTo(v31.CFrame * CFrame.new(0, -3, 0))
            u40.Parent = u5
            _G.PlaySound(u28.PrimaryPart, script["Start (1)"]).Parent = u28.LowerTorso
            local function u44(p41, _) --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                local u42 = script.Teleport1:Clone()
                u42.CFrame = CFrame.new(p41.Position)
                u42.Parent = workspace.Effects
                local u43 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 169 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                        [2] = u28
                    --]]
                    u42.CFrame = CFrame.new(u28.UpperTorso.Position)
                end)
                task.delay(2, function() --[[ Line: 172 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                    --]]
                    u43:Disconnect()
                    u43 = nil
                end)
                _G.customEmit(u42)
                _G.destroy(u42, 3)
            end
            task.delay(0.264, function() --[[ Line: 188 ]]
                --[[
                Upvalues:
                    [1] = u40
                --]]
                _G.customEmit(u40["Hit 1"])
            end)
            task.delay(0.69, function() --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u40
                    [3] = u44
                    [4] = u28
                --]]
                u23(u40.VibrationVFX, true)
                task.wait(0.133)
                u44(CFrame.new(u28.UpperTorso.Position))
                u23(u40.VibrationVFX, false)
            end)
            task.delay(1.21, function() --[[ Line: 201 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u29
                --]]
                _G.customEmit(u40.Kick1)
                local v45, _, _ = _G.getRayFloor(u29.UpperTorso.CFrame, 5)
                if v45 then
                    local u46 = script.Smoke:Clone()
                    u46.CFrame = u29.UpperTorso.CFrame
                    u46.Parent = workspace.Effects
                    _G.recolorParticles(u46, v45.Color)
                    local v47 = Instance.new("WeldConstraint")
                    v47.Part0 = u46
                    v47.Part1 = u29.UpperTorso
                    v47.Parent = u46
                    task.delay(0.616666667, function() --[[ Line: 214 ]]
                        --[[
                        Upvalues:
                            [1] = u46
                        --]]
                        local v48 = next
                        local v49, v50 = u46:GetDescendants()
                        for _, v51 in v48, v49, v50 do
                            if v51:IsA("ParticleEmitter") then
                                v51.Enabled = false
                            end
                        end
                        task.wait(4.65)
                        u46:Destroy()
                    end)
                end
            end)
            task.delay(1.5, function() --[[ Line: 226 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u40
                --]]
                local v52, _, _ = _G.getRayFloor(u29.UpperTorso.CFrame, 5)
                if v52 then
                    _G.recolorParticles(u40.StopDust, v52.Color)
                    _G.customEmit(u40.StopDust)
                end
            end)
            task.delay(2, function() --[[ Line: 236 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u28
                --]]
                u44(u28.UpperTorso.CFrame)
            end)
            task.delay(2.7, function() --[[ Line: 241 ]]
                --[[
                Upvalues:
                    [1] = u40
                --]]
                _G.customEmit(u40.Grab)
            end)
            task.delay(5.68, function() --[[ Line: 246 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u5
                    [3] = u2
                --]]
                local u53 = script.slashswirl:Clone()
                u53.CFrame = u40.Throw.CFrame * CFrame.new(0, 10, 0)
                u53.Parent = u5
                _G.tween(u53, {
                    0.5,
                    "Quart",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = u53.Size * 2
                })
                _G.tween(u53, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                local u55 = u2.Heartbeat:Connect(function() --[[ Line: 256 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                    --]]
                    local v54 = u53
                    v54.CFrame = v54.CFrame * CFrame.Angles(0, 0.15707963267948966, 0)
                end)
                task.delay(1, function() --[[ Line: 259 ]]
                    --[[
                    Upvalues:
                        [1] = u55
                    --]]
                    u55:Disconnect()
                end)
                _G.customEmit(u40.Throw)
            end)
            local u56 = nil
            local u57 = nil
            task.delay(6.31, function() --[[ Line: 267 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u28
                    [3] = u57
                    [4] = u44
                --]]
                u56 = Instance.new("Highlight")
                u56.FillColor = Color3.fromRGB(235, 249, 255)
                u56.FillTransparency = 1
                u56.OutlineTransparency = 1
                u56.Parent = u28
                _G.tween(u56, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 0.05
                })
                u57 = script.Bite:Clone()
                u57.CFrame = u28.UpperTorso.CFrame
                u57.Parent = workspace.Effects
                _G.customWeld(u57, u28.UpperTorso, CFrame.new(), u57)
                _G.customEmit(u57)
                task.wait(0.04)
                u44(CFrame.new(u28.UpperTorso.Position))
            end)
            local function u61(p58, p59) --[[ Line: 284 ]]
                _G.PlayEffect("DeadLightning", nil, {
                    ["StartPosition"] = p58,
                    ["EndPosition"] = p59,
                    ["Points"] = 10,
                    ["Size"] = 1,
                    ["Branches"] = false,
                    ["NoHighlight"] = true,
                    ["RandomSize"] = NumberRange.new(0.15, 1),
                    ["Offset"] = NumberRange.new(-3, 3),
                    ["MainColor"] = Color3.fromRGB(230, 255, 255),
                    ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                    ["LightningDuration"] = 0.2,
                    ["WaitFunction"] = function(p60, _) --[[ Name: WaitFunction, Line 300 ]]
                        if p60 % 2 == 0 then
                            task.wait()
                        end
                    end
                })
            end
            task.delay(7.15, function() --[[ Line: 307 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u44
                    [3] = u61
                --]]
                local v62 = u40.Dash2.CFrame
                local v63 = script.Dash1:Clone()
                v63.CFrame = v62
                v63.Parent = workspace.Effects
                _G.customEmit(v63)
                _G.destroy(v63, 6)
                u44(CFrame.new(u40.Dash3.Position))
                local v64 = CFrame.new(u40.Dash2.Position)
                local v65 = {
                    ["WorldPosition"] = u40.Dash2.Position,
                    ["WorldAxis"] = Vector3.new(0, 1, 0)
                }
                for _ = 1, 1 do
                    local _ = {
                        ["WorldPosition"] = (CFrame.new(v64.Position, u40.Dash3.Position) * CFrame.new(math.random(-6, 6), math.random(-6, 6), -(v64.Position - u40.Dash3.Position).Magnitude)).Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    u61(v65.WorldPosition, u40.Dash3.Position)
                    task.wait()
                end
            end)
            task.delay(7.397, function() --[[ Line: 321 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u44
                    [3] = u61
                --]]
                local v66 = u40.Dash3.CFrame
                local v67 = script.Dash1:Clone()
                v67.CFrame = v66
                v67.Parent = workspace.Effects
                _G.customEmit(v67)
                _G.destroy(v67, 6)
                u44(CFrame.new(u40.Dash4.Position))
                task.spawn(function() --[[ Line: 326 ]]
                    --[[
                    Upvalues:
                        [1] = u40
                        [2] = u61
                    --]]
                    local v68 = CFrame.new(u40.Dash3.Position)
                    local v69 = {
                        ["WorldPosition"] = u40.Dash3.Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    for _ = 1, 1 do
                        local _ = {
                            ["WorldPosition"] = (CFrame.new(v68.Position, u40.Dash4.Position) * CFrame.new(math.random(-6, 6), math.random(-6, 6), -(v68.Position - u40.Dash4.Position).Magnitude)).Position,
                            ["WorldAxis"] = Vector3.new(0, 1, 0)
                        }
                        u61(v69.WorldPosition, u40.Dash4.Position)
                        task.wait()
                    end
                end)
            end)
            task.delay(7.65, function() --[[ Line: 338 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u44
                    [3] = u61
                --]]
                local v70 = u40.Dash4.CFrame
                local v71 = script.Dash1:Clone()
                v71.CFrame = v70
                v71.Parent = workspace.Effects
                _G.customEmit(v71)
                _G.destroy(v71, 6)
                u44(CFrame.new(u40.LastPoint.Position))
                task.spawn(function() --[[ Line: 343 ]]
                    --[[
                    Upvalues:
                        [1] = u40
                        [2] = u61
                    --]]
                    local v72 = CFrame.new(u40.Dash4.Position)
                    local v73 = {
                        ["WorldPosition"] = u40.Dash4.Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    for _ = 1, 1 do
                        local _ = {
                            ["WorldPosition"] = (CFrame.new(v72.Position, u40.LastPoint.Position) * CFrame.new(math.random(-6, 6), math.random(-6, 6), -(v72.Position - u40.LastPoint.Position).Magnitude)).Position,
                            ["WorldAxis"] = Vector3.new(0, 1, 0)
                        }
                        u61(v73.WorldPosition, u40.LastPoint.Position)
                        task.wait()
                    end
                end)
            end)
            task.delay(8.56, function() --[[ Line: 354 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u56
                    [3] = u57
                --]]
                _G.customEmit(u40.FinalKick)
                _G.tween(u56, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                    ["FillTransparency"] = 1
                })
                _G.destroy(u56, 0.1)
                _G.particleEnabled(u57, false)
                _G.destroy(u57, 5)
            end)
            task.delay(9, function() --[[ Line: 362 ]]
                --[[
                Upvalues:
                    [1] = u40
                --]]
                local v74, v75, _ = _G.getRayFloor(u40.FinalExplosion.CFrame, 25)
                if v74 then
                    u40.FinalExplosion.Attachment2["Dust 2"].Color = ColorSequence.new(v74.Color)
                    u40.FinalExplosion.CFrame = CFrame.new(v75)
                else
                    u40.FinalExplosion.Attachment2["Dust 2"]:Destroy()
                end
                _G.customEmit(u40.FinalExplosion)
                _G.PlaySound(u40.FinalExplosion, script.Impact)
                u40.FinalExplosion.PointLight.Enabled = true
                _G.tween(u40.FinalExplosion.PointLight, {
                    0.4,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 60,
                    ["Brightness"] = 0
                })
                local u76 = CFrame.new(u40.FinalExplosion.Position)
                local v77 = Random.new()
                task.spawn(function() --[[ Line: 381 ]]
                    --[[
                    Upvalues:
                        [1] = u76
                    --]]
                    for _ = 1, 7 do
                        local v78 = CFrame.new(u76.Position)
                        _G.PlayEffect("DeadLightning", nil, {
                            ["StartPosition"] = v78.Position,
                            ["EndPosition"] = (v78 * CFrame.new(math.random(-45, 45), math.random(35, 55), math.random(-45, 45))).Position,
                            ["Points"] = 5,
                            ["Size"] = 1,
                            ["Branches"] = true,
                            ["NoHighlight"] = true,
                            ["RandomSize"] = NumberRange.new(0.15, 1),
                            ["Offset"] = NumberRange.new(-2, 2),
                            ["MainColor"] = Color3.fromRGB(230, 255, 255),
                            ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                            ["LightningDuration"] = math.random(250, 400) / 1000,
                            ["WaitFunction"] = function(p79, _) --[[ Name: WaitFunction, Line 400 ]]
                                if p79 % 2 == 0 then
                                    task.wait(math.random(400, 700) / 10000)
                                end
                            end
                        })
                        task.wait()
                    end
                end)
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 35,
                    ["Position"] = u76.Position,
                    ["DistanceRandomness"] = Vector2.new(0.1, 1),
                    ["Duration"] = 5,
                    ["TweenDuration"] = 2,
                    ["Radius"] = 40,
                    ["Direction"] = u76.UpVector * -15,
                    ["Angle"] = -0.8726646259971648
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 35,
                    ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                    ["Position"] = u76.Position,
                    ["Direction"] = Vector3.new(0, 125, 0),
                    ["RaycastDirection"] = u76.UpVector * -15,
                    ["Size"] = Vector3.new(1, 1, 1),
                    ["TrailEnabled"] = true
                }, true)
                for _ = 1, 7 do
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = u76.Position,
                        ["EndPosition"] = u76.Position + v77:NextUnitVector() * v77:NextNumber(35, 55),
                        ["Points"] = 10,
                        ["Size"] = math.random(100, 200) / 100,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-50, 50),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = math.random(100, 250) / 1000,
                        ["WaitFunction"] = function(p80, _) --[[ Name: WaitFunction, Line 447 ]]
                            if p80 % 2 == 0 then
                                task.wait(math.random(100, 300) / 10000)
                            end
                        end
                    })
                    task.wait(0.025)
                end
            end)
            task.delay(1.33, function() --[[ Line: 457 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u28
                    [3] = u23
                --]]
                local v81, _, _ = _G.getRayFloor(u29.UpperTorso.CFrame, 5)
                if v81 then
                    local u82 = script.AttachmentFolder.VictimDust:Clone()
                    u82.Parent = u28.UpperTorso
                    _G.recolorParticles(u82, v81.Color)
                    u23(u82, true)
                    task.delay(0.618, function() --[[ Line: 465 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u82
                        --]]
                        u23(u82, false)
                        _G.destroy(u82, 2)
                    end)
                end
            end)
            task.delay(3.696, function() --[[ Line: 473 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u23
                --]]
                local u83 = script.AttachmentFolder.Spin:Clone()
                u83.Parent = u28.Head
                u23(u83, true)
                task.delay(1.899, function() --[[ Line: 478 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u83
                    --]]
                    u23(u83, false)
                    _G.destroy(u83, 2)
                end)
            end)
            task.delay(9.5, function() --[[ Line: 484 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u28
                --]]
                u44(CFrame.new(u28.UpperTorso.Position), true)
            end)
            task.wait(10.3)
            _G.PlayEffect("CameraHideUI", nil, false)
            _G.destroy(u40, 7)
        end
    end
end
return v25