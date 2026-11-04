 

local u1 = script.Parent.BounceTemplate
local u16 = {
    ["isBounceTemplate"] = function(p2) --[[ Name: isBounceTemplate, Line 12 ]]
        return p2:GetAttribute("IsBounceTemplate", true) == true
    end,
    ["getTarget"] = function(p3) --[[ Name: getTarget, Line 16 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        if not u16.isBounceTemplate(p3) then
            return nil
        end
        if p3:IsA("ObjectValue") then
            return p3.Value
        end
        local v4 = p3:FindFirstChild("BounceTarget")
        if v4 then
            return v4.Value
        end
        warn("[BounceTemplateUtils.getTarget] - Bounce template without BounceTarget")
        return nil
    end,
    ["create"] = function(p5, p6) --[[ Name: create, Line 34 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v7 = typeof(p5) == "Instance"
        assert(v7, "Bad target")
        local v8 = type(p6) == "string"
        assert(v8, "Bad linkName")
        local v9 = u1:Clone()
        v9:SetAttribute("IsBounceTemplate", true)
        v9.Name = p6
        local v10 = Instance.new("ObjectValue")
        v10.Name = "BounceTarget"
        v10.Value = p5
        v10.Parent = v9
        return v9
    end,
    ["createLink"] = function(p11, p12) --[[ Name: createLink, Line 54 ]]
        local v13 = typeof(p11) == "Instance"
        assert(v13, "Bad target")
        local v14 = type(p12) == "string"
        assert(v14, "Bad linkName")
        local v15 = Instance.new("ObjectValue")
        v15.Name = p12
        v15.Value = p11
        v15:SetAttribute("IsBounceTemplate", true)
        return v15
    end
}
return u16