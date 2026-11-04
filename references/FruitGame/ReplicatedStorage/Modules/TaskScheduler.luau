 

local u1 = nil
local u2 = nil
local u3 = {}
local v14 = {
    ["CreateScheduler"] = function(_, u4) --[[ Name: CreateScheduler, Line 52 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local u5 = {}
        local u6 = {}
        local u7 = true
        local u8 = nil
        local function u9() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u4
                [3] = u3
                [4] = u6
            --]]
            while not u7 do
                if u4 <= _G.FPS and tick() - u3[1] < 1 / u4 then
                    if #u6 <= 0 then
                        u7 = true
                        return
                    end
                    u6[1]()
                    table.remove(u6, 1)
                else
                    game:GetService("RunService").Heartbeat:Wait()
                end
            end
        end
        function u5.Pause(_) --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
            --]]
            u8 = true
            u7 = true
        end
        function u5.Resume(_) --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
                [3] = u9
            --]]
            if u8 then
                u8 = false
                u7 = false
                u9()
            end
        end
        function u5.Destroy(_) --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5:Pause()
            for v10 in next, u5 do
                u5[v10] = nil
            end
            local v11 = u5
            setmetatable(v11, {
                ["__index"] = function() --[[ Name: __index, Line 95 ]]
                    error("Attempt to use destroyed scheduler")
                end,
                ["__newindex"] = function() --[[ Name: __newindex, Line 98 ]]
                    error("Attempt to use destroyed scheduler")
                end
            })
        end
        function u5.QueueTask(_, p12) --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u7
                [3] = u8
                [4] = u9
            --]]
            u6[#u6 + 1] = p12
            if u7 and not u8 then
                u7 = false
                u9()
            end
        end
        function u5.GetQueueSize(_) --[[ Line: 112 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            return #u6
        end
        return u5
    end,
    ["GetCurrentFPS"] = function(_) --[[ Name: GetCurrentFPS, Line 120 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        return tick() - u2 >= 1 and #u3 or #u3 / (tick() - u2)
    end,
    ["wait"] = function(p13) --[[ Name: wait, Line 124 ]]
        task.wait(p13)
    end
}
u2 = tick()
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    u1 = tick()
    for v15 = #u3, 1, -1 do
        local v16 = u3
        local v17 = v15 + 1
        local v18
        if u3[v15] >= u1 - 1 then
            v18 = u3[v15] or nil
        else
            v18 = nil
        end
        v16[v17] = v18
    end
    u3[1] = u1
end)
game:GetService("RunService").Heartbeat:Wait()
return v14