 

local v1 = {}
game:GetService("TweenService")
local u2 = require(script.Parent.BodyTransparency)
function v1.start(_, p3, _, p4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = script.Bomb:Clone()
    v5:SetPrimaryPartCFrame(CFrame.new(p3.PrimaryPart.Position))
    if p4 then
        v5:ScaleTo(p4)
    end
    v5.Parent = workspace.Effects
    _G.PlaySound(v5.PrimaryPart, script.EasterHammerEggSmashEggShoot)
    u2:start(p3)
    task.wait(0.25)
    v5.Egg:BreakJoints()
    _G.customEmit(v5)
    if p4 == nil then
        _G.PlaySound(v5.PrimaryPart, script["EggBoom" .. math.random(1, 4)], {
            ["RandomPitch"] = true
        })
    else
        _G.PlaySound(v5.PrimaryPart, script["EggBoom" .. math.random(1, 4)], {
            ["Pitch"] = 0.8,
            ["RollOffMaxDistance"] = 180,
            ["RollOffMinDistance"] = 50
        })
    end
    local v6 = p4 or 1
    local u7 = v5.Cracks:GetChildren()
    local v8 = 55 * v6
    local _ = 5 * v6
    for u9 = 1, #u7 do
        local v10 = u7[u9]
        local v11 = math.random(-v8, v8)
        local v12 = math.random(25, 45) * v6
        local v13 = math.random
        local v14 = -v8
        v10.Velocity = Vector3.new(v11, v12, v13(v14, v8))
        local v15 = u7[u9]
        local v16 = math.random(-5, 5)
        local v17 = math.random(-5, 5)
        local v18 = math.random
        v15.RotVelocity = Vector3.new(v16, v17, v18(-5, 5))
        task.delay(1, function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u9
            --]]
            game.TweenService:Create(u7[u9], TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
                ["Size"] = Vector3.new()
            }):Play()
        end)
    end
    _G.destroy(v5, 3)
end
return v1