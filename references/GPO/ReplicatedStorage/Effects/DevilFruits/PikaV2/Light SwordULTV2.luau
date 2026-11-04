 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u3 = require(v1.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u4 = workspace.Effects
local u5 = {}
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 37 ]]
    local function v20(u15, p16, p17) --[[ Line: 38 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local v23 = RaycastParams.new()
v23.FilterType = Enum.RaycastFilterType.Include
v23.FilterDescendantsInstances = { workspace.Ships, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p24, u25, u26, p27) --[[ Name: start, Line 82 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u3
            [3] = u4
            [4] = u22
        --]]
        if p24 == "Start" then
            u25:FindFirstChild("HumanoidRootPart")
            local v28 = u25:FindFirstChild("RightHand")
            u5[u25] = {}
            local v29 = p27.PrimaryPart
            local v30 = Instance.new("Motor6D")
            v30.Name = "Handle"
            v30.Part0 = v28
            v30.Part1 = v29
            v30.C0 = CFrame.new(0.000102996826, -0.0343222618, -0.000329971313, 1, -1.2403233e-11, 0, -1.2403233e-11, 1, 0, 0, 0, 1)
            v30.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            v30.Parent = v28
            _G.PlaySound(u25.PrimaryPart, script.GiantLightSwordStart)
            task.wait(0.8)
            local _, v31, _ = _G.getRayFloor(u26, 0.5 * u25.PrimaryPart.Size.Y + u25.Humanoid.HipHeight)
            local v32 = v31 + Vector3.new(0, 0.1, 0)
            local v33 = CFrame.new(v32)
            local v34 = script.Activation:Clone()
            u3.apply(v34, u25)
            v34.CFrame = v33
            v34.Parent = u4
            u22(v34, true)
            local v35 = script.ActivationFloor:Clone()
            u3.apply(v35, u25)
            v35.CFrame = v33
            v35.Parent = u4
            u22(v35, true)
            local v36 = script.Small_Sword_Aura:Clone()
            u3.apply(v36, u25)
            v36.CFrame = v29.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            v36.Parent = u4
            u22(v36, true)
            local v37 = Instance.new("WeldConstraint")
            v37.Part0 = v36
            v37.Part1 = v29
            v37.Parent = v36
            local v38 = script.GiantLightSwordHold:Clone()
            v38.Parent = u25.PrimaryPart
            v38:Play()
            repeat
                game["Run Service"].RenderStepped:Wait()
            until u25:GetAttribute("PikaV2Ult") == nil
            _G.tween(v38, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v38, 1)
            local _ = u25.PrimaryPart.CFrame
            local v39 = script.Big_Sword_Pulse:Clone()
            u3.apply(v39, u25)
            v39.CFrame = v29.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            v39.Parent = u4
            _G.customEmit(v39)
            _G.destroy(v39, 2)
            local v40 = Instance.new("WeldConstraint")
            v40.Part0 = v39
            v40.Part1 = v29
            v40.Parent = v39
            u22(v36, false)
            _G.destroy(v36, 2)
            local v41 = script.Big_Sword_Aura:Clone()
            u3.apply(v41, u25)
            v41.CFrame = v29.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            v41.Parent = u4
            u22(v41, true)
            local v42 = Instance.new("WeldConstraint")
            v42.Part0 = v41
            v42.Part1 = v29
            v42.Parent = v41
            _G.PlaySound(u25.PrimaryPart, script.GiantLightSwordSlash)
            task.wait(1.8)
            _G.tween(v35.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0
            })
            u22(v34, false)
            u22(v35, false)
            _G.destroy(v34, 2)
            _G.destroy(v35, 2)
            task.wait(0.2)
            u22(v41, false)
            _G.destroy(v41, 2)
            task.wait(1.17)
            v30:Destroy()
        elseif p24 == "Explosion" then
            local u43 = script.Sword_Explosion:Clone()
            u3.apply(u43, u25)
            local _ = u43:GetExtentsSize().Z
            local u44 = u43:GetScale() + 0.2
            u43:PivotTo(u26 * CFrame.new(0, -9 * u44, -15 * u44))
            task.delay(0.3, function() --[[ Line: 187 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                _G.PlaySound(u43:GetPivot(), script["Audio/GiantLightSwordBoom"])
            end)
            task.delay(0.5, function() --[[ Line: 191 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                _G.shakenear(u43:GetPivot().Position, 300, 150, 250, -1.5)
            end)
            local v45 = u43.Explosion:GetChildren()
            for v46 = 1, #v45 do
                local u47 = v45[v46]
                local v48 = CFrame.new(v45[v46].WorldCFrame.Position + Vector3.new(0, 75, 0))
                local v49, v50, v51 = _G.getRayFloor(v48, 300)
                if v49 then
                    local v52 = v50 + Vector3.new(0, 0.3, 0)
                    u47.WorldCFrame = CFrame.new(v52, v52 + v51) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    _G.recolorParticles(u47, v49.Color)
                    local u53 = u47:GetAttribute("Radius") * u44 or 25
                    task.delay(0.5, function() --[[ Line: 206 ]]
                        --[[
                        Upvalues:
                            [1] = u47
                            [2] = u53
                            [3] = u3
                            [4] = u25
                        --]]
                        local v54 = u47.WorldPosition
                        local v55 = u47.WorldCFrame
                        local v56 = u53
                        u53 = u53 * 0.8
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 25,
                            ["Position"] = v54 + Vector3.new(0, 1, 0),
                            ["DistanceRandomness"] = Vector2.new(0.25, 1),
                            ["Duration"] = 5,
                            ["TweenDuration"] = 3,
                            ["Radius"] = u53,
                            ["Direction"] = v55.UpVector * -30,
                            ["Angle"] = -0.4363323129985824
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 10,
                            ["RandomVelocityMagnitude"] = Vector2.new(-60, 60),
                            ["Position"] = v54,
                            ["Direction"] = v55.UpVector * math.random(90, 125),
                            ["RaycastDirection"] = v55.UpVector * -30,
                            ["Size"] = Vector3.new(1.4, 2.4, 1.4),
                            ["TrailEnabled"] = true
                        })
                        local v57 = script.light:Clone()
                        u3.apply(v57, u25)
                        v57.CFrame = CFrame.new(v54)
                        v57.Size = Vector3.new(v56, 1, v56) * 2
                        v57.PointLight.Range = v56 * 2 + 10
                        v57.Parent = workspace.Effects
                        _G.tween(v57.PointLight, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Range"] = v56 * 3,
                            ["Brightness"] = 0
                        })
                        _G.destroy(v57, 0.25)
                    end)
                else
                    u47:Destroy()
                end
            end
            local v58 = u43.Strike:GetChildren()
            for v59 = 1, #v58 do
                local v60 = v58[v59]
                local v61 = CFrame.new(v60.Position + Vector3.new(0, 10, 0))
                local v62, v63, _ = _G.getRayFloor(v61, 150)
                if v62 then
                    local v64 = v60.Size.Y / 2
                    v60.Position = v63 + Vector3.new(0, v64, 0)
                    _G.recolorParticles(v60, v62.Color)
                end
            end
            u43.Parent = u4
            _G.customEmit(u43)
            task.delay(0.05, function() --[[ Line: 261 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                _G.PlaySound(u43:GetPivot(), script.GLswordPreExplosionFlash)
            end)
            task.delay(0.1, function() --[[ Line: 265 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u25
                    [3] = u26
                    [4] = u44
                --]]
                local v65 = Color3.fromRGB(255, 235, 124)
                if script:FindFirstChild("NeonRocks") then
                    local v66 = script.NeonRocks:Clone()
                    u3.apply(v66, u25)
                    v65 = v66.Color
                    v66:Destroy()
                end
                _G.PlayEffect("RockAngle", nil, {
                    ["CFrame"] = u26,
                    ["Width"] = 0,
                    ["Angle"] = 0,
                    ["StartSize"] = Vector3.new(0.25, 0.25, 0.25),
                    ["EndSize"] = Vector3.new(0.5, 0.5, 0.5),
                    ["Length"] = 125 * u44,
                    ["PartDuration"] = 0.25,
                    ["HeightCheck"] = 50,
                    ["CustomMaterial"] = Enum.Material.Neon,
                    ["CustomColor"] = v65
                })
            end)
            _G.destroy(u43, 10)
        end
    end
}