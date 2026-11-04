 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = require(v1.Modules.BezierFormula)
require(v1.Modules.CraterHandler)
local u5 = v3.LocalPlayer
local u6 = workspace.Effects
local u7 = {}
function Flipbook(p8, u9, u10, u11)
    local u12 = p8:FindFirstChildOfClass("SpecialMesh")
    if u12 and u9 then
        task.spawn(function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u12
                [3] = u10
                [4] = u11
            --]]
            for v13 = 1, #u9 do
                u12.TextureId = u9[v13]
                task.wait(1 / u10)
            end
            if u11 == true then
                u12.Parent:Destroy()
            end
        end)
    end
end
local function u24(p14, p15, p16) --[[ Line: 35 ]]
    local function v22(u17, p18, p19) --[[ Line: 36 ]]
        for _, v20 in ipairs(u17:GetDescendants()) do
            if v20:IsA("ParticleEmitter") or v20:IsA("Trail") then
                v20.Enabled = p18
            end
        end
        if p19 then
            task.delay(p19, function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                for _, v21 in ipairs(u17:GetDescendants()) do
                    if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
                        v21.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p14) == "table" then
        for _, v23 in p14 do
            v22(v23, p15, p16)
        end
    else
        v22(p14, p15, p16)
    end
end
local v25 = {}
local u26 = Random.new()
local u27 = RaycastParams.new()
u27.FilterType = Enum.RaycastFilterType.Include
u27.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
function v25.start(_, p28, u29, _, p30) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u24
        [4] = u2
        [5] = u4
        [6] = u27
        [7] = u5
        [8] = u26
    --]]
    if _G.checkRenderDistance(u29.PrimaryPart.Position) == false then
        return
    elseif p28 == "Startup" then
        local u31 = u29.HumanoidRootPart
        local v32 = u29.Humanoid:LoadAnimation(script.hold)
        v32:Play()
        u7[u29] = {
            ["anim"] = v32
        }
        local v33 = script.Startup:Clone()
        v33.CFrame = u31.CFrame
        v33.Parent = u6
        u24(v33, true)
        local v34 = u7[u29]
        table.insert(v34, v33)
        local v35 = script.StartEmit:Clone()
        v35.CFrame = u31.CFrame
        v35.Parent = u6
        _G.customEmit(v35)
        _G.destroy(v35, 3)
        local u36 = Instance.new("Highlight")
        u36.FillColor = Color3.fromRGB(235, 249, 255)
        u36.FillTransparency = 1
        u36.OutlineTransparency = 1
        u36.DepthMode = Enum.HighlightDepthMode.Occluded
        u36.Parent = u29
        _G.tween(u36, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
            ["FillTransparency"] = 0.1
        })
        local u37 = script.SLRoarChargeLoop:Clone()
        u37.Parent = u29.PrimaryPart
        u37:Play()
        local u38 = _G.PlaySound(u29.PrimaryPart, script["Audio/SLRoarStart"])
        local u39 = script.PointLight:Clone()
        u39.Parent = u29.PrimaryPart
        task.spawn(function() --[[ Line: 115 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u29
                [3] = u31
                [4] = u6
                [5] = u2
                [6] = u4
                [7] = u38
                [8] = u37
                [9] = u39
                [10] = u36
            --]]
            u7[u29].Active = true
            while u7[u29].Active do
                local u40 = u31.CFrame
                local v41 = CFrame.Angles
                local v42 = math.random(-360, 360)
                local v43 = math.rad(v42)
                local v44 = math.random(-360, 360)
                local v45 = math.rad(v44)
                local v46 = math.random(-360, 360)
                local u47 = u40 * v41(v43, v45, (math.rad(v46))) * CFrame.new(0, 0, -math.random(30, 60))
                local u48 = (CFrame.lookAt(u47.Position:Lerp(u40.Position, 0.25), u40.Position) * CFrame.new(math.random(-70, 70), math.random(-70, 70), math.random(-70, 70))).Position
                local u49 = 0
                local u50 = math.random(2, 4)
                local u51 = script.Trails["WindTrail" .. math.random(1, 2)]:Clone()
                u51.CFrame = u47
                u51.Parent = u6
                local u52 = nil
                u52 = u2.Heartbeat:Connect(function(p53) --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u49
                        [2] = u50
                        [3] = u4
                        [4] = u47
                        [5] = u48
                        [6] = u40
                        [7] = u51
                        [8] = u52
                    --]]
                    u49 = u49 + p53 * u50
                    local v54 = u4.QuadBezier(u49, u47.Position, u48, u40.Position)
                    if u49 >= 1 then
                        _G.destroy(u51, 2)
                        u52:Disconnect()
                    else
                        u51.Position = v54
                    end
                end)
                task.wait(0.01)
            end
            _G.tween(u38, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                ["Volume"] = 0
            })
            _G.tween(u37, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                ["Volume"] = 0
            })
            _G.destroy(u37, 0.25)
            u7[u29] = nil
            task.delay(0.5, function() --[[ Line: 150 ]]
                --[[
                Upvalues:
                    [1] = u39
                --]]
                _G.tween(u39, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                    ["Brightness"] = 0,
                    ["Range"] = 35
                })
                _G.destroy(u39, 0.25)
            end)
            task.wait(0.9)
            _G.tween(u36, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                ["FillTransparency"] = 1
            })
            _G.destroy(u36, 0.25)
        end)
    elseif p28 == "Roar" then
        local u55 = u29.HumanoidRootPart
        u7[u29].Active = nil
        u7[u29].anim:Stop()
        local v56 = u7[u29]
        local v57 = table.unpack(v56)
        u24(v57, false)
        _G.destroy(v57, 3)
        u29.Humanoid:LoadAnimation(script.release):Play()
        local v58 = script.Roar:Clone()
        v58.CFrame = u55.CFrame
        v58.Parent = u6
        _G.customEmit(v58.Emit)
        u24({ v58.Attachment, v58.Impact }, true, p30)
        _G.destroy(v58, p30 + 1.4)
        _G.PlaySound(u29.PrimaryPart, script.SLRoar)
        if (workspace.CurrentCamera.CFrame.Position - u29.PrimaryPart.Position).Magnitude <= 150 or u29 == game.Players.LocalPlayer.Character then
            local u59 = game.Lighting.ColorCorrection:Clone()
            game.Lighting.ColorCorrection.Enabled = false
            u59.Parent = workspace.CurrentCamera
            local u60 = u59.Saturation
            local u61 = u59.Contrast
            u59.Contrast = -10
            u59.Saturation = -1
            task.delay(0.1, function() --[[ Line: 191 ]]
                --[[
                Upvalues:
                    [1] = u59
                    [2] = u60
                    [3] = u61
                --]]
                u59.Contrast = 0
                u59.Saturation = -1
                task.wait(0.1)
                local v62 = {
                    ["Saturation"] = u60,
                    ["Contrast"] = u61
                }
                _G.tween(u59, {
                    0.05,
                    "Linear",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, v62)
                _G.destroy(u59, 0.05)
                task.wait(0.05)
                game.Lighting.ColorCorrection.Enabled = true
            end)
        end
        local v63 = workspace:Raycast(u55.Position, Vector3.new(0, -10, 0), u27)
        if v63 then
            local v64 = script.GroundScratch:Clone()
            v64.CFrame = CFrame.new(v63.Position, v63.Position + u55.CFrame.LookVector)
            v64.Parent = u6
            u24(v64, true, p30)
            _G.destroy(v64, 4)
        end
        if u5.Character == u29 then
            _G.camShake:ShakeOnce(6, 20, 0.5, 1)
        end
        local v65 = u29.PrimaryPart
        task.spawn(function() --[[ Line: 218 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u26
            --]]
            for _ = 1, 10 do
                _G.PlayEffect("DeadLightning", nil, {
                    ["StartPosition"] = u55.Position,
                    ["EndPosition"] = u55.Position + u26:NextUnitVector() * u26:NextNumber(45, 55),
                    ["Points"] = 8,
                    ["Size"] = 1,
                    ["Branches"] = true,
                    ["RandomSize"] = NumberRange.new(0.15, 1),
                    ["Offset"] = NumberRange.new(-25, 25),
                    ["MainColor"] = Color3.fromRGB(230, 255, 255),
                    ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                    ["NoHighlight"] = true,
                    ["LightningDuration"] = math.random(100, 200) / 1000,
                    ["WaitFunction"] = function(p66, _) --[[ Name: WaitFunction, Line 235 ]]
                        if p66 % 2 == 0 then
                            task.wait(0.05)
                        end
                    end
                })
                task.wait(0.05)
            end
        end)
        for v67 = 1, 5 do
            local v68 = v67 * 2 + 5
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = v67 * 3 + 5,
                ["Position"] = v65.Position + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.4, 1),
                ["Duration"] = 1,
                ["TweenDuration"] = 1,
                ["Radius"] = v67 * 6,
                ["Direction"] = Vector3.new(0, -10, 0)
            })
            local v69 = _G.PlayEffect
            local v70 = {
                ["PartCount"] = 2,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * v67 / 1.3
            }
            local v71 = v65.Position
            local v72 = math.random(-v68, v68)
            local v73 = math.random
            local v74 = -v68
            v70.Position = v71 + Vector3.new(v72, 0, v73(v74, v68))
            v70.Direction = Vector3.new(0, 45, 0)
            v70.RaycastDirection = Vector3.new(0, -10, 0)
            v70.Size = Vector3.new(1, 1, 1)
            v70.TrailEnabled = true
            v69("RockDebris", nil, v70, true)
            local v75 = script.Light:Clone()
            v75.CFrame = u55.CFrame
            v75.Parent = workspace.Effects
            _G.tween(v75.PointLight, {
                0.15,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 60,
                ["Brightness"] = 0
            })
            _G.destroy(v75, 0.15)
            task.wait(0.1)
        end
    end
end
return v25