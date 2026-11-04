 

local u1 = game:GetService("HttpService")
local u2 = game:GetService("RunService")
local u22 = {
    ["bindToRenderStep"] = function(p3) --[[ Name: bindToRenderStep, Line 38 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u2
        --]]
        return u22.bindToSignal(u2.RenderStepped, p3)
    end,
    ["bindToSignal"] = function(u4, u5) --[[ Name: bindToSignal, Line 51 ]]
        if typeof(u4) ~= "RBXScriptSignal" then
            error("signal must be of type RBXScriptSignal")
        end
        if type(u5) ~= "function" then
            error(("update must be of type function, got %q"):format((type(u5))))
        end
        local u6 = nil
        return function(...) --[[ Name: connect, Line 67 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u5
                [3] = u4
            --]]
            if u6 and u6.Connected then
                return
            elseif u5(...) then
                if not (u6 and u6.Connected) then
                    local u7 = { ... }
                    u6 = u4:Connect(function() --[[ Line: 87 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u7
                            [3] = u6
                        --]]
                        local v8 = u7
                        if not u5(unpack(v8)) and u6 then
                            u6:Disconnect()
                            u6 = nil
                        end
                    end)
                end
            else
                return
            end
        end, function() --[[ Name: disconnect, Line 60 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            if u6 then
                u6:Disconnect()
                u6 = nil
            end
        end
    end,
    ["onceAtRenderPriority"] = function(p9, u10) --[[ Name: onceAtRenderPriority, Line 105 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v11 = type(p9) == "number"
        assert(v11, "Bad priority")
        local v12 = type(u10) == "function"
        assert(v12, "Bad func")
        local u13 = ("StepUtils.onceAtPriority_%s"):format(u1:GenerateGUID(false))
        local function v14() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u13
            --]]
            u2:UnbindFromRenderStep(u13)
        end
        u2:BindToRenderStep(u13, p9, function() --[[ Line: 115 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u13
                [3] = u10
            --]]
            u2:UnbindFromRenderStep(u13)
            u10()
        end)
        return v14
    end,
    ["onceAtStepped"] = function(p15) --[[ Name: onceAtStepped, Line 135 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u2
        --]]
        return u22.onceAtEvent(u2.Stepped, p15)
    end,
    ["onceAtRenderStepped"] = function(p16) --[[ Name: onceAtRenderStepped, Line 145 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u2
        --]]
        return u22.onceAtEvent(u2.RenderStepped, p16)
    end,
    ["onceAtEvent"] = function(p17, u18) --[[ Name: onceAtEvent, Line 156 ]]
        local v19 = type(u18) == "function"
        assert(v19, "Bad func")
        local u20 = nil
        local function v21() --[[ Line: 160 ]]
            --[[
            Upvalues:
                [1] = u20
            --]]
            if u20 then
                u20:Disconnect()
                u20 = nil
            end
        end
        u20 = p17:Connect(function(...) --[[ Line: 167 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u18
            --]]
            if u20 then
                u20:Disconnect()
                u20 = nil
            end
            u18(...)
        end)
        return v21
    end
}
return u22