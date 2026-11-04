 

local u41 = {
    ["isValueBase"] = function(p1) --[[ Name: isValueBase, Line 8 ]]
        local v2
        if typeof(p1) == "Instance" then
            v2 = p1.ClassName:sub(-5) == "Value"
        else
            v2 = false
        end
        return v2
    end,
    ["getOrCreateValue"] = function(p3, p4, p5, p6) --[[ Name: getOrCreateValue, Line 12 ]]
        local v7 = typeof(p3) == "Instance"
        assert(v7, "Bad argument \'parent\'")
        local v8 = type(p4) == "string"
        assert(v8, "Bad argument \'instanceType\'")
        local v9 = type(p5) == "string"
        assert(v9, "Bad argument \'name\'")
        local v10 = p3:FindFirstChild(p5)
        if v10 then
            if not v10:IsA(p4) then
                warn(("[ValueBaseUtils.getOrCreateValue] - Value of type %q of name %q is of type %q in %s instead"):format(p4, p5, v10.ClassName, v10:GetFullName()))
            end
            return v10
        end
        local v11 = Instance.new(p4)
        v11.Name = p5
        v11.Value = p6
        v11.Parent = p3
        return v11
    end,
    ["setValue"] = function(p12, p13, p14, p15) --[[ Name: setValue, Line 35 ]]
        local v16 = typeof(p12) == "Instance"
        assert(v16, "Bad argument \'parent\'")
        local v17 = type(p13) == "string"
        assert(v17, "Bad argument \'instanceType\'")
        local v18 = type(p14) == "string"
        assert(v18, "Bad argument \'name\'")
        local v19 = p12:FindFirstChild(p14)
        if v19 then
            if not v19:IsA(p13) then
                warn(("[ValueBaseUtils.setValue] - Value of type %q of name %q is of type %q in %s instead"):format(p13, p14, v19.ClassName, v19:GetFullName()))
            end
            v19.Value = p15
        else
            local v20 = Instance.new(p13)
            v20.Name = p14
            v20.Value = p15
            v20.Parent = p12
        end
    end,
    ["getValue"] = function(p21, p22, p23, p24) --[[ Name: getValue, Line 56 ]]
        local v25 = typeof(p21) == "Instance"
        assert(v25, "Bad argument \'parent\'")
        local v26 = type(p22) == "string"
        assert(v26, "Bad argument \'instanceType\'")
        local v27 = type(p23) == "string"
        assert(v27, "Bad argument \'name\'")
        local v28 = p21:FindFirstChild(p23)
        if not v28 then
            return p24
        end
        if v28:IsA(p22) then
            return v28.Value
        end
        warn(("[ValueBaseUtils.getValue] - Value of type %q of name %q is of type %q in %s instead"):format(p22, p23, v28.ClassName, v28:GetFullName()))
        return nil
    end,
    ["createGetSet"] = function(u29, u30) --[[ Name: createGetSet, Line 75 ]]
        --[[
        Upvalues:
            [1] = u41
        --]]
        local v31 = type(u29) == "string"
        assert(v31, "Bad argument \'instanceType\'")
        local v32 = type(u30) == "string"
        assert(v32, "Bad argument \'name\'")
        return function(p33, p34) --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u29
                [3] = u30
            --]]
            local v35 = typeof(p33) == "Instance"
            assert(v35, "Bad argument \'parent\'")
            return u41.getValue(p33, u29, u30, p34)
        end, function(p36, p37) --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u29
                [3] = u30
            --]]
            local v38 = typeof(p36) == "Instance"
            assert(v38, "Bad argument \'parent\'")
            return u41.setValue(p36, u29, u30, p37)
        end, function(p39, p40) --[[ Line: 87 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u29
                [3] = u30
            --]]
            return u41.getOrCreateValue(p39, u29, u30, p40)
        end
    end
}
return u41