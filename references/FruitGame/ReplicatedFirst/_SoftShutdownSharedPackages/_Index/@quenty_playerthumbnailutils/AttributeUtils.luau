 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("RunService")
local u3 = v1("Maid")
return {
    ["bindToBinder"] = function(u4, u5, u6) --[[ Name: bindToBinder, Line 23 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        assert(u6, "Bad binder")
        local v7 = typeof(u4) == "Instance"
        assert(v7, "Bad instance")
        local v8 = type(u5) == "string"
        assert(v8, "Bad attributeName")
        local u9 = u3.new()
        local function v10() --[[ Line: 30 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
                [3] = u2
                [4] = u6
            --]]
            if u4:GetAttribute(u5) then
                if u2:IsClient() then
                    u6:BindClient(u4)
                else
                    u6:Bind(u4)
                end
            elseif u2:IsClient() then
                u6:UnbindClient(u4)
            else
                u6:Unbind(u4)
            end
        end
        u9:GiveTask(u4:GetAttributeChangedSignal(u5):Connect(v10))
        u9:GiveTask(u6:ObserveInstance(u4, function() --[[ Name: syncBoundClass, Line 47 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u4
                [3] = u5
            --]]
            if u6:Get(u4) then
                u4:SetAttribute(u5, true)
            else
                u4:SetAttribute(u5, false)
            end
        end))
        if u6:Get(u4) or u4:GetAttribute(u5) then
            u4:SetAttribute(u5, true)
            if u2:IsClient() then
                u6:BindClient(u4)
            else
                u6:Bind(u4)
            end
        else
            u4:SetAttribute(u5, false)
        end
        u9:GiveTask(function() --[[ Line: 69 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u4
                [3] = u5
            --]]
            u9:DoCleaning()
            u4:SetAttribute(u5, nil)
        end)
        return u9
    end,
    ["initAttribute"] = function(p11, p12, p13) --[[ Name: initAttribute, Line 88 ]]
        local v14 = typeof(p11) == "Instance"
        assert(v14, "Bad instance")
        local v15 = typeof(p12) == "string"
        assert(v15, "Bad attributeName")
        local v16 = p11:GetAttribute(p12)
        if v16 == nil then
            p11:SetAttribute(p12, p13)
        else
            p13 = v16
        end
        return p13
    end,
    ["getAttribute"] = function(p17, p18, p19) --[[ Name: getAttribute, Line 108 ]]
        local v20 = p17:GetAttribute(p18)
        if v20 == nil then
            return p19
        else
            return v20
        end
    end
}