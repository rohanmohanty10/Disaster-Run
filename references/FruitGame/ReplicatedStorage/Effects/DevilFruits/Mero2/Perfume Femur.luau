 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.Bezier)
local u3 = v2.LocalPlayer
local u4 = workspace.Effects
local function u15(p5, p6, p7) --[[ Line: 18 ]]
    local function v13(u8, p9, p10) --[[ Line: 19 ]]
        for _, v11 in ipairs(u8:GetDescendants()) do
            if v11:IsA("ParticleEmitter") or v11:IsA("Trail") then
                v11.Enabled = p9
            end
        end
        if p10 then
            task.delay(p10, function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                for _, v12 in ipairs(u8:GetDescendants()) do
                    if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                        v12.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p5) == "table" then
        for _, v14 in p5 do
            v13(v14, p6, p7)
        end
    else
        v13(p5, p6, p7)
    end
end
local u16 = RaycastParams.new()
u16.FilterType = Enum.RaycastFilterType.Include
u16.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p17, u18, u19) --[[ Name: start, Line 63 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u15
            [4] = u16
        --]]
        if _G.checkRenderDistance(u18.PrimaryPart.Position) ~= false then
            if p17 == "Kick" then
                local v20 = u18.RightFoot
                local v21 = script.StartupKick:Clone()
                v21.CFrame = v20.CFrame
                v21.Parent = u4
                _G.customEmit(v21)
                _G.destroy(v21, 2)
                if u3.Character == u18 then
                    workspace.CurrentCamera.CameraSubject = u18.UpperTorso
                    return
                end
            elseif p17 == "Cutscene" then
                local u22 = u19.HumanoidRootPart
                local _ = u18.RightFoot
                local _ = u18.LeftFoot
                local u23 = script.HitEffect:Clone()
                u23.Parent = u4
                local u24 = u18.PrimaryPart
                _G.PlaySound(u24, script.Mero2UltHit).Parent = u18.UpperTorso
                task.delay(0.46, function() --[[ Line: 93 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u22
                        [3] = u4
                    --]]
                    u23.CFrame = u22.CFrame
                    _G.customEmit(u23)
                    task.wait(0.43)
                    u23.CFrame = u22.CFrame
                    _G.customEmit(u23)
                    task.wait(0.166)
                    u23.CFrame = u22.CFrame
                    _G.customEmit(u23)
                    task.wait(0.51)
                    local v25 = script.Kick:Clone()
                    v25.CFrame = u22.CFrame * CFrame.new(0, 0, 2)
                    v25.Parent = u4
                    _G.customEmit(v25)
                    _G.destroy(v25, 2)
                end)
                task.delay(2, function() --[[ Line: 117 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                        [2] = u4
                        [3] = u15
                        [4] = u23
                        [5] = u22
                    --]]
                    local v26 = script.Combo:Clone()
                    v26.CFrame = u24.CFrame * CFrame.new(0, -2, -1)
                    v26.Parent = u4
                    u15(v26, true)
                    task.spawn(function() --[[ Line: 123 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                            [2] = u22
                        --]]
                        for _ = 1, 4 do
                            u23.CFrame = u22.CFrame
                            _G.customEmit(u23)
                            task.wait(0.2)
                        end
                    end)
                    task.wait(0.7)
                    u15(v26, false)
                    _G.destroy(v26, 2)
                    _G.destroy(u23, 2)
                end)
                task.delay(3, function() --[[ Line: 138 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                        [2] = u19
                    --]]
                    local u27 = script.Combo2:Clone()
                    u27.CFrame = u18.PrimaryPart.CFrame
                    u27.Parent = workspace.Effects
                    tick()
                    local v28 = u19.PrimaryPart.Position
                    local v29 = CFrame.new
                    local v30 = u18.UpperTorso.Position
                    local v31 = v28.X
                    local v32 = u18.UpperTorso.Position.Y
                    local v33 = v28.Z
                    u27.CFrame = v29(v30, (Vector3.new(v31, v32, v33))) * CFrame.Angles(0, 0, 1.5707963267948966)
                    local u39 = game["Run Service"].RenderStepped:Connect(function(p34) --[[ Line: 147 ]]
                        --[[
                        Upvalues:
                            [1] = u27
                            [2] = u18
                        --]]
                        u27.Position = u18.UpperTorso.Position
                        local v35 = u27
                        local v36 = v35.CFrame
                        local v37 = CFrame.Angles
                        local v38 = 1000 * p34
                        v35.CFrame = v36 * v37(0, math.rad(v38), 0)
                    end)
                    task.delay(0.5, function() --[[ Line: 153 ]]
                        --[[
                        Upvalues:
                            [1] = u27
                            [2] = u39
                        --]]
                        _G.particleEnabled(u27, false, true)
                        task.wait(1)
                        u39:Disconnect()
                        u39 = nil
                    end)
                    _G.destroy(u27, 1)
                end)
                task.wait(3.96)
                local v40 = script.KickSlam:Clone()
                v40.CFrame = u24.CFrame * CFrame.new(0, -8.3, -4)
                v40.Parent = u4
                u15(v40, true)
                if u3.Character == u18 then
                    workspace.CurrentCamera.CameraSubject = u18.Humanoid
                end
                if u19.PrimaryPart then
                    local v41 = workspace:Raycast(u19.PrimaryPart.Position, Vector3.new(0, -5, 0), u16)
                    if v41 then
                        _G.recolorParticles(v40.GroundEffects, v41.Instance.Color)
                    else
                        u15(v40.GroundEffects, false)
                    end
                end
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 10,
                    ["Position"] = v40.Position + Vector3.new(0, 5, 0),
                    ["DistanceRandomness"] = Vector2.new(0.5, 1),
                    ["Duration"] = 3,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 13,
                    ["Direction"] = Vector3.new(0, -35, 0)
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 8,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                    ["Position"] = v40.Position + Vector3.new(0, 5, 0),
                    ["Direction"] = Vector3.new(0, 125, 0),
                    ["RaycastDirection"] = Vector3.new(0, -30, 0),
                    ["Size"] = Vector3.new(0.5, 0.5, 0.5),
                    ["TrailEnabled"] = true
                })
                task.wait(0.5)
                u15(v40, false)
                _G.destroy(v40, 3)
            end
        end
    end
}