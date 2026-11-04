 

return {
    ["CreateNewSignal"] = function(_) --[[ Name: CreateNewSignal, Line 32 ]]
        local v1 = {}
        local u2 = Instance.new("BindableEvent")
        local u3 = {}
        function v1.Connect(_, p4) --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            if typeof(p4) ~= "function" then
                error("Argument #1 of Connect must be a function, got a " .. typeof(p4), 2)
            end
            local u5 = u2.Event:Connect(p4)
            u3[u5] = true
            local v6 = {
                ["disconnect"] = function(_) --[[ Name: disconnect, Line 45 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u3
                    --]]
                    u5:Disconnect()
                    u3[u5] = nil
                end
            }
            v6.Disconnect = v6.disconnect
            return v6
        end
        function v1.disconnectAll(_) --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            for v7, _ in u3 do
                v7:Disconnect()
                u3[v7] = nil
            end
        end
        function v1.Wait(_) --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return u2.Event:Wait()
        end
        function v1.fire(_, ...) --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            u2:Fire(...)
        end
        v1.Connect = v1.Connect
        v1.DisconnectAll = v1.disconnectAll
        v1.Wait = v1.wait
        v1.Fire = v1.fire
        return v1
    end
}