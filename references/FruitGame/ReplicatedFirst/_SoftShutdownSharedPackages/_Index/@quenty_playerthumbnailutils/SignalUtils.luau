 

return {
    ["onNext"] = function(p1, u2) --[[ Name: onNext, Line 14 ]]
        local v3 = typeof(p1) == "RBXScriptSignal"
        assert(v3, "Bad event")
        local v4 = type(u2) == "function"
        assert(v4, "Bad _function")
        local u5 = nil
        u5 = p1:Connect(function(...) --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u2
            --]]
            if not u5.Connected then
                u5:Disconnect()
                u2(...)
            end
        end)
        return u5
    end
}