 

game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
local _ = workspace.CurrentCamera
local u1 = Random.new()
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 14 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = {}
        local v4 = {}
        local v5 = {}
        for _, v6 in p2:GetDescendants() do
            if v6:IsA("BasePart") ~= false then
                if v6.Name == "Leaf" then
                    table.insert(v5, v6)
                elseif v6.Parent.Name:match("^Branch_") then
                    table.insert(u3, v6)
                elseif v6.Parent == p2 then
                    table.insert(v4, v6)
                end
            end
        end
        for _, u7 in v5 do
            task.spawn(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u1
                --]]
                local v8 = u7.Size
                local v9 = u7.CFrame
                _G.tween(u7, {
                    0.3076923076923077,
                    "Quad",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = v8 * 0.3,
                    ["CFrame"] = v9 * CFrame.Angles(u1:NextNumber(-0.5, 0.5), 0, u1:NextNumber(-1, 1)) * CFrame.new(0, -0.5, 0)
                })
                _G.destroy(u7, 0.3076923076923077)
            end)
        end
        task.wait(0.23076923076923075)
        task.spawn(function() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            for v10 = #u3, 1, -1 do
                local u11 = u3[v10]
                task.spawn(function() --[[ Line: 58 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                    --]]
                    _G.tween(u11, {
                        0.3076923076923077,
                        "Quad",
                        Enum.EasingDirection.In,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = u11.Size * Vector3.new(1, 0.1, 0.1)
                    })
                    _G.destroy(u11, 0.3076923076923077)
                end)
                task.wait(0.03)
            end
        end)
        task.wait(0.3076923076923077)
        for v12 = #v4, 1, -1 do
            local u13 = v4[v12]
            task.spawn(function() --[[ Line: 76 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                _G.tween(u13, {
                    0.3076923076923077,
                    "Quad",
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = u13.Size * Vector3.new(1, 0.1, 0.1)
                })
                _G.destroy(u13, 0.3076923076923077)
            end)
            task.wait(0.03)
        end
    end
}