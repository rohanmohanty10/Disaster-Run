 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, p3, _) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
        local v4 = {
            14399492802,
            14399492596,
            14399492365,
            14399492055,
            14399491725,
            14399491447,
            14399491149,
            14399490913,
            14399490678,
            14399490439,
            14399490165,
            14399489881,
            14399489682,
            14399489443,
            14399489049
        }
        local v5 = script.AxeSlam:Clone()
        local u6 = v5.Slash
        v5.Parent = workspace.Effects
        task.wait(0.716)
        u6.CFrame = p3.RootPart.CFrame * CFrame.new(3.47000122, 13.4960032, -23.3840027, 0, 1, 0, 0.258818984, 0, 0.965925813, 0.965925813, 0, -0.258818984)
        u6.SlashDecal.Transparency = 0
        u2:Create(u6, TweenInfo.new(0.225, Enum.EasingStyle.Quart), {
            ["CFrame"] = u6.CFrame * CFrame.Angles(0, -2.6179938779914944, 0)
        }):Play()
        task.delay(0.1, function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            _G.customEmit(u6)
            _G.PlaySound(u6, script.Slam)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 23,
                ["Position"] = u6.Ground.WorldPosition + Vector3.new(0, 15, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 1,
                ["TweenDuration"] = 1,
                ["Radius"] = 20,
                ["Direction"] = Vector3.new(0, -35, 0)
            })
        end)
        for v7 = 1, #v4 do
            u6.SlashDecal.Texture = "rbxassetid://" .. v4[v7]
            task.wait(0.225 / #v4)
        end
        _G.destroy(v5, 1)
    end
end
return v1