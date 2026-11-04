 

local v1 = {}
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = require(v3.Modules.LightningBolt)
local u5 = _G.customEmit
local v6 = RaycastParams.new()
local v7 = Enum.RaycastFilterType.Include
local v8 = { workspace.Islands, workspace.Env, workspace.Ships }
v6.FilterType = v7
v6.FilterDescendantsInstances = v8
function v1.start(_, _, p9, _) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u4
    --]]
    local u10 = Random.new()
    local v11 = #p9 > 2 and 0.5 or 1
    for v12 = 1, #p9 do
        local v13 = u10:NextNumber(12, 25)
        local v14 = 1.0471975511965976 * v12 + u10:NextNumber(-0.5235987755982988, 0.5235987755982988)
        CFrame.new(math.cos(v14) * v13, 0, math.sin(v14) * v13)
        local v15 = CFrame.new(p9[v12].position)
        local u16 = script.Parent:WaitForChild("LightningModel"):Clone()
        u16.Rocks:Destroy()
        u16:PivotTo(v15 * CFrame.Angles(0, u10:NextNumber(-3.141592653589793, 3.141592653589793), 0))
        task.delay(0.03333333333333333, function() --[[ Line: 42 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u5
                [3] = u2
            --]]
            u16.Parent = workspace.Effects
            u5(u16)
            for _, v17 in u16.Part.Beams:GetChildren() do
                u2:Create(v17, TweenInfo.new(0.175), {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                }):Play()
            end
            local _ = (game.Players.LocalPlayer.Character:GetPivot().Position - u16:GetPivot().Position).Magnitude
        end)
        local v18 = {}
        local v19 = {}
        local v20 = u16.PrimaryPart.CFrame
        local v21 = (v20 * CFrame.new(0, 50, 0)).Position
        local v22 = u10:NextUnitVector()
        v18.WorldPosition = v21
        v18.WorldAxis = v22
        local v23 = (v20 * CFrame.new(0, -3, 0)).Position
        local v24 = u10:NextUnitVector()
        v19.WorldPosition = v23
        v19.WorldAxis = v24
        local v25 = p9[v12]
        if v25 then
            local v26 = v25.position
            local v27 = v26 + v25.normal * 6.25
            u16:PivotTo(CFrame.new(v27, v27 + v25.normal) * CFrame.Angles(-1.5707963267948966, u10:NextNumber(-3.141592653589793, 3.141592653589793), 0))
            v19.WorldPosition = v25.position
            _G.PlaySound(CFrame.new(v25.position), script["DragonLightningStrike" .. math.random(1, 4)], {
                ["RandomPitch"] = true,
                ["RollOffMaxDistance"] = script.DragonLightningStrike1.RollOffMaxDistance * v11,
                ["RollOffMinDistance"] = script.DragonLightningStrike1.RollOffMinDistance * v11
            })
            local v28, _, _ = _G.getRayFloor(CFrame.new(v26), 25)
            if v28 then
                _G.recolorParticles(u16, v28.Color)
            end
            local v29 = v25.position
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 14,
                ["Position"] = v29 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = u10:NextNumber(2, 4),
                ["TweenDuration"] = 1,
                ["Radius"] = 11,
                ["Direction"] = -v25.normal * 15,
                ["Angle"] = -0.7853981633974483
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 5,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                ["Position"] = v29,
                ["Direction"] = CFrame.new(v29, v18.WorldPosition).LookVector * 55 + Vector3.new(0, 25, 0),
                ["RaycastDirection"] = -v25.normal * 15,
                ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                ["TrailEnabled"] = true
            })
            _G.shakenear(v25.position, 125, 65, 50, -0.5)
        end
        for _ = 1, u10:NextInteger(2, 3) do
            local v30 = {
                ["WorldAxis"] = u10:NextUnitVector(),
                ["WorldPosition"] = v19.WorldPosition + u10:NextUnitVector() * Vector3.new(1, 0, 1) * 4
            }
            local v31 = u4.new(v18, v30, 6)
            local v32 = u10:NextNumber(-15, 15)
            local v33 = u10:NextNumber(-15, 15)
            v31.CurveSize0 = v32
            v31.CurveSize1 = v33
            v31.PulseSpeed = 9
            v31.PulseLength = 1
            v31.FadeLength = 0.125
            v31.Thickness = u10:NextNumber(0.75, 1.5)
            v31.AnimationSpeed = 2
            v31.ContractFrom = 0.5
            v31.MinThicknessMultiplier = 0.35
            v31.MaxThicknessMultiplier = 1.25
            v31.MaxRadius = u10:NextInteger(1, 3)
            v31.Color = Color3.fromRGB(99, 99, 255)
        end
        for _, u34 in u16.Images:GetDescendants() do
            if u34:IsA("Decal") then
                u2:Create(u34, TweenInfo.new(0.65, Enum.EasingStyle.Cubic), {
                    ["Color3"] = Color3.new()
                }):Play()
                task.delay(2, function() --[[ Line: 139 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u34
                        [3] = u10
                    --]]
                    u2:Create(u34, TweenInfo.new(u10:NextNumber(0.45, 0.75)), {
                        ["Transparency"] = 1
                    }):Play()
                end)
            end
        end
        u2:Create(u16.Primary.PointLight, TweenInfo.new(0.175), {
            ["Range"] = u16.Primary.PointLight.Range * 2,
            ["Brightness"] = 0
        }):Play()
        _G.destroy(u16, 3)
        task.wait(0.05)
    end
end
return v1