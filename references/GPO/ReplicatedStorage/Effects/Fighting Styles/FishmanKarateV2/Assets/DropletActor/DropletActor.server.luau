 

local u1 = script.Parent
local u2 = require(u1.Droplet)
local u3 = nil
u1:BindToMessage("Initialize", function(p4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    p4.Main = true
    u3 = u2.new(p4)
end)
u1:BindToMessage("Destroyed", function(p5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u2
    --]]
    if p5.CanSplatter then
        local u6 = math.random(3)
        for _ = 1, u6 do
            local u7 = u2.new({
                ["Position"] = p5.Detect.Position,
                ["Velocity"] = (p5.Detect.Normal + Random.new():NextUnitVector()) * p5.Size * 5,
                ["Size"] = p5.Size * 0.25,
                ["CanSplatter"] = false
            })
            u7.Destroyed:Connect(function() --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                    [3] = u1
                --]]
                u6 = u6 - 1
                if u6 == 0 then
                    task.wait(u7.PuddleDuration + 1)
                    u1:Destroy()
                end
            end)
        end
    else
        task.wait(u3.PuddleDuration + 1)
        u1:Destroy()
    end
end)