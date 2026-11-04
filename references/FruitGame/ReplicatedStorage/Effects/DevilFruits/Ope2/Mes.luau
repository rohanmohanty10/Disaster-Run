 

local v1 = {}
local u2 = require(script.Parent.Lightning)
function v1.start(_, u3, u4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u4.Position) ~= false then
        task.spawn(function() --[[ Line: 8 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            for _ = 1, 10 do
                local v5 = {
                    ["color"] = BrickColor.new("Bright red").Color,
                    ["decay"] = 3,
                    ["bends"] = 2,
                    ["fork_bends"] = 5,
                    ["fork_chance"] = 0,
                    ["transparency"] = 0.1,
                    ["thickness"] = math.random(100, 1000) / 10000,
                    ["max_depth"] = 5,
                    ["depth"] = 0.2,
                    ["ti"] = math.random(200, 600) / 10000
                }
                local v6 = u2
                local v7 = u3.Position
                local v8 = u3.Position
                local v9 = math.random(-15, 15)
                local v10 = math.random(-15, 15)
                local v11 = math.random
                v6:start(v7, v8 + Vector3.new(v9, v10, v11(-15, 15)), v5)
            end
        end)
        task.spawn(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u3
            --]]
            local v12 = (u4 * CFrame.new(0, 0, -35)).Position
            for _ = 1, 10 do
                local v13 = {
                    ["color"] = BrickColor.new("Bright red").Color,
                    ["decay"] = 3,
                    ["bends"] = 2,
                    ["fork_bends"] = 0,
                    ["fork_chance"] = 0,
                    ["transparency"] = 0.1,
                    ["thickness"] = math.random(100, 1000) / 10000,
                    ["max_depth"] = 0,
                    ["depth"] = 0.2,
                    ["ti"] = math.random(200, 600) / 10000
                }
                local v14 = u2
                local v15 = u3.Position
                local v16 = math.random(-5, 5)
                local v17 = math.random(-5, 5)
                local v18 = math.random
                v14:start(v15, v12 + Vector3.new(v16, v17, v18(-5, 5)), v13)
            end
        end)
    end
end
return v1