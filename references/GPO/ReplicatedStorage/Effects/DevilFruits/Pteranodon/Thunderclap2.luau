 

game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("Debris")
local u1 = require(script.Parent.LightningStyled)
local function u6(p2, p3) --[[ Line: 8 ]]
    local v4 = typeof(p2) == "table" and p2 and p2 or p2:GetChildren()
    for _, v5 in pairs(v4) do
        if v5:IsA("BasePart") then
            v5.Transparency = p3
        end
    end
end
return function(u7) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u6
    --]]
    local u8 = u7.Duration or 1
    tick()
    Random.new()
    local v9 = u7.Times or 2
    local u10 = u7.BeginPoint
    local u11 = u7.EndPoint
    for u12 = 1, v9 do
        task.spawn(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u10
                [3] = u11
                [4] = u8
                [5] = u7
                [6] = u12
                [7] = u6
            --]]
            u1({
                ["Start"] = u10,
                ["End"] = u11,
                ["Duration"] = u8,
                ["Offset"] = NumberRange.new(-3, 3),
                ["Width"] = 1,
                ["Delay"] = u7.Delay,
                ["CanShrink"] = true,
                ["Colour"] = Color3.new(1, 1, 1),
                ["OutlineColour"] = u12 == 1 and Color3.new(0.937255, 0.752941, 1) or Color3.new(0.415686, 0.364706, 1)
            }).PartsLoaded:Connect(function(u13) --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                wait()
                for _ = 1, 5 do
                    u13[math.random(#u13)]:Destroy()
                end
                task.wait(0.1)
                task.spawn(function() --[[ Line: 51 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u13
                    --]]
                    u6(u13, 1)
                    task.wait(0.05)
                    u6(u13, 0)
                end)
                task.wait(0.1)
                task.spawn(function() --[[ Line: 51 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u13
                    --]]
                    u6(u13, 1)
                    task.wait(0.05)
                    u6(u13, 0)
                end)
            end)
        end)
        task.wait(0.1)
    end
end