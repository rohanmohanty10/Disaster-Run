 

local v1 = {}
local u2 = require(script.Parent.Lightning)
local u3 = require(script.Parent.Outline)
function v1.start(_, u4, u5) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if _G.checkRenderDistance(u4.Position) ~= false then
        task.spawn(function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u5
            --]]
            for _ = 1, 6 do
                task.wait(0.1)
                local v6 = script.elec1:Clone()
                v6.Parent = u4
                v6.Pitch = math.random(100, 140) / 100
                v6:Play()
                _G.destroy(v6, 2)
                u3:start(u5, BrickColor.new("Toothpaste").Color, 0.05, 0.5)
            end
        end)
        for _ = 1, 15 do
            game["Run Service"].Heartbeat:Wait()
            local v7 = {
                ["color"] = BrickColor.new("Gold").Color,
                ["color2"] = BrickColor.new("Toothpaste").Color,
                ["decay"] = 3,
                ["bends"] = 2,
                ["fork_bends"] = 5,
                ["fork_chance"] = 0,
                ["transparency"] = 0.1,
                ["thickness"] = math.random(200, 1000) / 10000,
                ["max_depth"] = 5,
                ["depth"] = 0.2,
                ["ti"] = math.random(200, 1000) / 5000
            }
            local v8 = u2
            local v9 = u4.Position
            local v10 = u4.Position
            local v11 = math.random(-15, 15)
            local v12 = math.random(-15, 15)
            local v13 = math.random
            v8:start(v9, v10 + Vector3.new(v11, v12, v13(-15, 15)), v7)
        end
    end
end
return v1