 

local v1 = {}
local u2 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local u3 = require(game.ReplicatedStorage.ClientImpacts.RockDebs)
function v1.start(_, p4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local _ = p4.obj
    local v5 = p4.cf
    local v6 = p4.hit
    local v7 = p4.normal
    if _G.checkRenderDistance(v5.p) ~= false then
        local v8 = script.explosion:Clone()
        v8.Parent = workspace.Effects
        v8.CFrame = v5
        v8.Smoke:Emit(5)
        v8.Spark:Emit(5)
        v8.Spark2:Emit(5)
        v8.Explosion:Play()
        _G.destroy(v8, 4)
        local v9 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0)
        game:GetService("TweenService"):Create(v8.PointLight, v9, {
            ["Range"] = 25,
            ["Brightness"] = 3
        }):Play()
        _G.destroy(v8.PointLight, 0.4)
        u2:start({
            ["rep"] = 2,
            ["cf"] = v5,
            ["vel"] = { 100, math.random(50, 150), 100 }
        })
        if v6 then
            u3:start({
                ["rep"] = 2,
                ["cf"] = v5,
                ["vel"] = { 55, 100, 55 },
                ["min"] = 1,
                ["max"] = 2,
                ["color"] = v6.Color,
                ["material"] = v6.Material,
                ["normal"] = v7
            })
        end
    end
end
return v1