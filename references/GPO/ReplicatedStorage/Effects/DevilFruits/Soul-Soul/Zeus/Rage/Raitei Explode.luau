 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local u2 = Random.new()
require(script.Parent.Shared)
local u3 = script.VFX
local v4 = RaycastParams.new()
v4.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v4.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p5) --[[ Name: start, Line 20 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local v6 = p5.Detect
        local v7 = p5.Character.HumanoidRootPart
        local u8 = u3.Strike:Clone()
        u8.CFrame = v6 and CFrame.new(v6.Position, v6.Position + v6.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.01, 0) or CFrame.new(v7.Position)
        u8.CFrame = u8.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
        if v6 and v6.HitPart ~= nil then
            _G.recolorParticles(u8, v6.Color)
        else
            u8.Attachment.Rocks:Destroy()
            u8.Attachment.Realistic:Destroy()
            u8.Attachment.Realistic2:Destroy()
        end
        u8.Parent = workspace.Effects
        _G.PlaySound(u8.CFrame, script.SoulZeusLeapSlamBoom)
        if v6.HitPart ~= nil then
            local v9 = CFrame.new(v6.Position, v6.Position + v6.Normal) * CFrame.new(0, 0, -1.1) * CFrame.Angles(-1.5690509975429023, 0, 0)
            local v10 = v9.Position
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v10 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 25,
                ["Direction"] = -v6.Normal * 45,
                ["Angle"] = -0.6108652381980153
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 10,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
                ["Position"] = v10,
                ["Direction"] = Vector3.new(0, 15, 0),
                ["RaycastDirection"] = -v6.Normal * 15,
                ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                ["TrailEnabled"] = true
            })
            _G.shakenear(v9.Position, 175, 100, 75, -1)
        end
        task.spawn(function() --[[ Line: 71 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u2
            --]]
            local v11 = u8.CFrame
            local v12 = 25
            for _ = 1, 6 do
                local v13 = _G.PlayEffect
                local v14 = {
                    ["StartPosition"] = v11.Position
                }
                local v15 = v11.Position
                local v16 = u2:NextNumber(-v12, v12)
                local v17 = u2:NextNumber(v12 / 4, v12 / 2)
                local v18 = u2
                local v19 = -v12
                v14.EndPosition = v15 + Vector3.new(v16, v17, v18:NextNumber(v19, v12))
                v14.Points = 5
                v14.Size = u2:NextNumber(1.5, 3)
                v14.Branches = true
                v14.RandomSize = NumberRange.new(0.15, 1)
                v14.Offset = NumberRange.new(15, 25)
                v14.MainColor = Color3.fromRGB(255, 255, 255)
                v14.GlowColor = Color3.fromRGB(151, 65, 255)
                v14.LightningDuration = math.random(100, 200) / 2000
                function v14.WaitFunction(p20, _) --[[ Line: 89 ]]
                    if p20 % 2 == 0 then
                        task.wait(math.random(100, 300) / 10000)
                    end
                end
                v13("DeadLightning", nil, v14)
                v12 = v12 + 3
                task.wait(0.05)
            end
        end)
        u1:Create(u8.PointLight, TweenInfo.new(1), {
            ["Range"] = 100,
            ["Brightness"] = 0
        }):Play()
        _G.customEmit(u8)
        _G.destroy(u8, 5)
    end
}