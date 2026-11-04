 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = Random.new()
local u4 = require(v2.Modules.LightningBolt)
local v5 = {}
local u6 = RaycastParams.new()
local v7 = { workspace.Islands, workspace.Env, workspace.Ships }
local v8 = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = v7
u6.FilterType = v8
local u9 = script.Parent:FindFirstChild("DragonLightningStrikes")
function v5.start(_, p10, _, p11) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
        [3] = u9
        [4] = u4
        [5] = u1
    --]]
    local v12 = p11 or 2.15
    local v13 = script.Parent:WaitForChild("LightningModel"):Clone()
    v13:PivotTo(p10)
    v13:ScaleTo(v12)
    local v14 = {}
    local v15 = {}
    local v16 = (v13:GetPivot() * CFrame.new(0, u3:NextNumber(65, 70), 0)).Position
    local v17 = u3:NextUnitVector()
    v14.WorldPosition = v16
    v14.WorldAxis = v17
    local v18 = (v13:GetPivot() * CFrame.new(0, -3, 0)).Position
    local v19 = u3:NextUnitVector()
    v15.WorldPosition = v18
    v15.WorldAxis = v19
    v13.Rocks:Destroy()
    local v20 = workspace:Raycast(p10.Position + Vector3.new(0, 5, 0), Vector3.new(0, -400, 0), u6)
    if v20 and v20.Instance then
        local v21 = v20.Position
        local v22 = v21 + v20.Normal * 6.25 * v13:GetScale()
        v13:PivotTo(CFrame.new(v22, v22 + v20.Normal) * CFrame.Angles(-1.5707963267948966, u3:NextNumber(-3.141592653589793, 3.141592653589793), 0))
        _G.recolorParticles(v13, v20.Instance.Color)
        v15.WorldPosition = v20.Position
        _G.PlaySound(CFrame.new(v21), u9["DragonLightningStrike" .. math.random(1, 4)], {
            ["RandomPitch"] = true
        })
        local v23 = v20.Position
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 20,
            ["Position"] = v23 + Vector3.new(0, 2, 0),
            ["DistanceRandomness"] = Vector2.new(0.3, 1),
            ["Duration"] = 4,
            ["TweenDuration"] = 1,
            ["Radius"] = 13 * v12,
            ["Direction"] = -v20.Normal * 15,
            ["Angle"] = -0.7853981633974483
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 5,
            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * v12,
            ["Position"] = v23,
            ["Direction"] = CFrame.new(v23, v14.WorldPosition).LookVector * 55 + Vector3.new(0, 25, 0),
            ["RaycastDirection"] = -v20.Normal * 15,
            ["Size"] = Vector3.new(0.6, 0.6, 0.6) * v12,
            ["TrailEnabled"] = true
        })
        _G.shakenear(v21, 125, 65, 50, -0.5)
        for _ = 1, u3:NextInteger(2, 3) do
            local v24 = {
                ["WorldAxis"] = u3:NextUnitVector(),
                ["WorldPosition"] = v15.WorldPosition + u3:NextUnitVector() * Vector3.new(1, 0, 1) * 4
            }
            local v25 = u4.new(v14, v24, 6)
            local v26 = u3:NextNumber(-22, 22)
            local v27 = u3:NextNumber(-22, 2)
            v25.CurveSize0 = v26
            v25.CurveSize1 = v27
            v25.PulseSpeed = 9
            v25.PulseLength = 1
            v25.FadeLength = 0.2
            v25.Thickness = u3:NextNumber(1.25, 2.25)
            v25.AnimationSpeed = 2
            v25.ContractFrom = 0.5
            v25.MinThicknessMultiplier = 0.5
            v25.MaxThicknessMultiplier = 1.25
            v25.MaxRadius = u3:NextInteger(1, 4)
            v25.Color = Color3.fromRGB(99, 99, 255)
        end
        v13.Parent = workspace.Effects
        _G.customEmit(v13)
        for _, v28 in v13.Part.Beams:GetChildren() do
            u1:Create(v28, TweenInfo.new(0.175), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
        end
        local _ = (game.Players.LocalPlayer.Character:GetPivot().Position - v13:GetPivot().Position).Magnitude
        for _, u29 in v13.Images:QueryDescendants("Decal") do
            u1:Create(u29, TweenInfo.new(0.65, Enum.EasingStyle.Cubic), {
                ["Color3"] = Color3.new()
            }):Play()
            task.delay(2, function() --[[ Line: 120 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u29
                    [3] = u3
                --]]
                u1:Create(u29, TweenInfo.new(u3:NextNumber(0.45, 0.75)), {
                    ["Transparency"] = 1
                }):Play()
            end)
        end
        u1:Create(v13.Primary.PointLight, TweenInfo.new(0.175), {
            ["Range"] = v13.Primary.PointLight.Range * 4,
            ["Brightness"] = 0
        }):Play()
        _G.destroy(v13, 3)
    else
        v13:Destroy()
    end
end
return v5