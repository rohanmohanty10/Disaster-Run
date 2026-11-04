 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
local u4 = require(v1.Modules.BezierFormula)
local _ = v3.LocalPlayer
local u5 = workspace.Effects
local u6 = {}
local function u17(p7, p8, p9) --[[ Line: 17 ]]
    local function v15(u10, p11, p12) --[[ Line: 18 ]]
        for _, v13 in ipairs(u10:GetDescendants()) do
            if v13:IsA("ParticleEmitter") or v13:IsA("Trail") then
                v13.Enabled = p11
            end
        end
        if p12 then
            task.delay(p12, function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                for _, v14 in ipairs(u10:GetDescendants()) do
                    if v14:IsA("ParticleEmitter") or v14:IsA("Trail") then
                        v14.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p7) == "table" then
        for _, v16 in p7 do
            v15(v16, p8, p9)
        end
    else
        v15(p7, p8, p9)
    end
end
local v18 = RaycastParams.new()
v18.FilterType = Enum.RaycastFilterType.Include
v18.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p19, p20, u21, u22) --[[ Name: start, Line 62 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u17
            [4] = u2
            [5] = u4
        --]]
        if _G.checkRenderDistance(p20.PrimaryPart.Position) == false then
            return
        else
            local v23 = p20.PrimaryPart
            if p19 == "Hold" then
                u6[p20] = {}
                local v24 = CFrame.new(0, -0.1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local u25 = script.Heart:Clone()
                u25.PrimaryPart.CFrame = p20.RightHand.CFrame * v24
                u25.Parent = u5
                _G.customWeld(u25.PrimaryPart, p20.RightHand, v24, u25)
                u25:ScaleTo(0.2)
                local v26 = u6[p20]
                table.insert(v26, u25)
                local v27 = script.StartUp:Clone()
                v27.CFrame = u25.PrimaryPart.CFrame
                v27.Parent = u5
                u17(v27.EnableVFX, true)
                _G.customWeld(v27, p20.RightHand, CFrame.new(), v27)
                task.delay(0.075, function() --[[ Line: 87 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    local v28 = script.HeartP:Clone()
                    v28.CFrame = u25.PrimaryPart.CFrame
                    v28.Parent = workspace.Effects
                    _G.customEmit(v28, 3)
                    _G.destroy(v28, 3)
                end)
                _G.PlaySound(v23, script.Mero2MeroBombStart)
                local v29 = u6[p20]
                table.insert(v29, v27)
            elseif p19 == "Shoot" then
                local v30 = u6[p20]
                local v31, v32 = table.unpack(v30)
                local v33 = v31
                local u34 = v31:Clone()
                u34.Parent = workspace.Effects
                v33:Destroy()
                u17(v32.EnableVFX, false)
                _G.customEmit(v32.EmitVFX, true)
                _G.destroy(v32, 3)
                u34.PrimaryPart.CFrame = CFrame.new(u34.PrimaryPart.Position)
                task.spawn(function() --[[ Line: 114 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                    --]]
                    for v35 = 0.2, 1, 0.1 do
                        u34:ScaleTo(v35)
                        task.wait()
                    end
                end)
                u34.PrimaryPart.Mero2MeroBombThrow:Play()
                local v36 = script.Shoot:Clone()
                v36.CFrame = u21
                v36.Parent = u5
                _G.customEmit(v36)
                _G.destroy(v36, 2)
                local u37 = (CFrame.lookAt(u21.Position:Lerp(u22.Position, 0.25), u22.Position) * CFrame.new(0, 30, 0)).Position
                local u38 = 0
                local _ = v23.CFrame.LookVector
                local u39 = nil
                u39 = u2.Heartbeat:Connect(function(p40) --[[ Line: 134 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u4
                        [3] = u21
                        [4] = u37
                        [5] = u22
                        [6] = u39
                        [7] = u17
                        [8] = u34
                        [9] = u5
                    --]]
                    u38 = u38 + p40 * 1.5
                    local v41 = u4.QuadBezier(u38, u21.Position, u37, u22.Position)
                    if u38 >= 1 then
                        u39:Disconnect()
                        u17(u34, false)
                        u34.PrimaryPart.Transparency = 1
                        _G.destroy(u34, 2)
                        local v42 = script.LoveBomb:Clone()
                        v42.Position = u34.PrimaryPart.Position
                        v42.Parent = u5
                        _G.customEmit(v42)
                        _G.destroy(v42, 2)
                        _G.tween(v42.PointLight, {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Range"] = 40,
                            ["Brightness"] = 0
                        })
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 16,
                            ["Position"] = v42.Position + Vector3.new(0, 5, 0),
                            ["DistanceRandomness"] = Vector2.new(0.5, 1),
                            ["Duration"] = 1,
                            ["TweenDuration"] = 1,
                            ["Radius"] = 18,
                            ["Direction"] = Vector3.new(0, -35, 0)
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 8,
                            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                            ["Position"] = v42.Position + Vector3.new(0, 5, 0),
                            ["Direction"] = Vector3.new(0, 65, 0),
                            ["RaycastDirection"] = Vector3.new(0, -30, 0),
                            ["Size"] = Vector3.new(0.5, 0.5, 0.5),
                            ["TrailEnabled"] = true
                        })
                        _G.PlaySound(v42, script.Mero2MeroBombBoom)
                    else
                        u34.PrimaryPart.Position = v41
                        local v43 = u34.PrimaryPart
                        local v44 = v43.CFrame
                        local v45 = CFrame.Angles
                        local v46 = 500 * p40
                        v43.CFrame = v44 * v45(0, math.rad(v46), 0)
                    end
                end)
            end
        end
    end
}