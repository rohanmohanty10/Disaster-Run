 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
Random.new()
local v2 = {}
local u3 = script
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u4.FilterType = Enum.RaycastFilterType.Include
local u5 = script.SFX
function v2.start(_, p6) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u1
    --]]
    local _ = p6.Character
    local v7 = p6.Summon
    local v8 = p6.ActionType
    if v8 == "SecondTrigger" then
        local v9 = p6.TargetPosition
        local v10 = v7.PrimaryPart.Position
        local v11 = (v10 - v9).Magnitude
        local v12 = p6.Speed
        local v13 = CFrame.new(v10, v9).Position
        local v14 = 25 + v11 / 2
        local v15 = v13 + Vector3.new(0, v14, 0)
        local v16 = workspace:GetServerTimeNow() - p6.serverStartTime
        local v17 = CFrame.new()
        local v18 = script.Jump:Clone()
        v18.CFrame = v7:GetPivot()
        v18.Parent = workspace.Effects
        _G.customEmit(v18)
        _G.destroy(v18, 3)
        v7:SetPrimaryPartCFrame(CFrame.new(v7.PrimaryPart.Position, v9) * v17)
        tick()
        _G.particleEnabled(v7, true, true)
        _G.PlaySound(v7.PrimaryPart, u5.SoulMiniHomiesCakeJump).Parent = v7.PrimaryPart
        while v16 < 1 do
            local v19 = v16 + task.wait() * v12
            v16 = math.clamp(v19, 0, 1)
            local v20 = (1 - v16) * (1 - v16) * v10 + 2 * (1 - v16) * v16 * v15 + v16 * v16 * v9
            local v21 = v16 + 0.01
            local v22 = (1 - v21) * (1 - v21) * v10 + 2 * (1 - v21) * v21 * v15 + v21 * v21 * v9
            v7:SetPrimaryPartCFrame(CFrame.new(v20, v22))
        end
        local v23 = workspace:Raycast(v7:GetPivot().Position, Vector3.new(0, -10, 0), u4)
        local v24 = u3.Slam:Clone()
        v24.CFrame = v23 and CFrame.new(v23.Position, v23.Position + v23.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0) or v7.PrimaryPart.CFrame
        v24.CFrame = v24.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
        if v23 and v23.Instance then
            _G.recolorParticles(v24, v23.Instance.Color)
        end
        v24.Parent = workspace.Effects
        _G.destroy(v24, 5)
        _G.particleEnabled(v24, false)
        _G.customEmit(v24)
        _G.PlaySound(v7.PrimaryPart, u5.SoulMiniHomiesCakeBoom, {
            ["RandomPitch"] = true
        })
        if v23 then
            local v25 = (CFrame.new(v23.Position, v23.Position + v23.Normal) * CFrame.new(0, 0, -1.1) * CFrame.Angles(-1.5690509975429023, 0, 0)).Position
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v25 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.25, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 20,
                ["Direction"] = -v23.Normal * 45,
                ["Angle"] = -0.7853981633974483
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 5,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
                ["Position"] = v25,
                ["Direction"] = Vector3.new(0, 15, 0),
                ["RaycastDirection"] = -v23.Normal * 15,
                ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                ["TrailEnabled"] = true
            })
        end
        _G.shakenear(v24.Position, 50, 75, 75, -1)
        if v7 then
            v7:Destroy()
            return
        end
    elseif v8 == "Attack" then
        local v26 = p6.StartCFrame
        local u27 = p6.EndCFrame
        local v28 = p6.Duration
        local v29 = script.Fire_Mouth:Clone()
        v29.CFrame = CFrame.new(v26.Position, u27.Position)
        v29.Parent = workspace.Effects
        _G.customEmit(v29)
        _G.destroy(v29, 4)
        local u30 = script.Projectile:Clone()
        u30.CFrame = v29.CFrame
        u30.Parent = workspace.Effects
        _G.destroy(u30, 10)
        local v31 = (v26.Position - u27.Position).Magnitude
        u1:Create(u30, TweenInfo.new(v28, Enum.EasingStyle.Linear), {
            ["CFrame"] = v29.CFrame * CFrame.new(0, 0, -v31)
        }):Play()
        _G.PlaySound(v7.PrimaryPart, u5.SoulMiniHomiesCakeBulletShoot, {
            ["RandomPitch"] = true
        }).Parent = u30
        task.delay(v28, function() --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u30
                [2] = u27
                [3] = u5
            --]]
            _G.particleEnabled(u30, false, true)
            _G.destroy(u30, 4)
            local v32 = script.Explode:Clone()
            v32.CFrame = u27
            v32.Parent = workspace.Effects
            _G.customEmit(v32)
            _G.destroy(v32, 4)
            _G.PlaySound(u27, u5.SoulMiniHomiesCakeBulletHit)
        end)
    end
end
return v2