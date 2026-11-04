 

local v1 = game:GetService("RunService")
local u2 = require("./logger")
local u3 = v1:IsServer()
local u4 = {}
local u5 = {}
local u6 = {}
local u7 = 0
local u72 = {
    ["cache"] = function(p8) --[[ Name: cache, Line 34 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
        --]]
        local v9 = p8:GetAttributes()
        if next(v9) ~= nil then
            u7 = u7 + 1
            local v10 = u7
            local v11 = {}
            for v12, v13 in v9 do
                if v12 ~= "U" then
                    v11[v12] = v13
                    p8:SetAttribute(v12, nil)
                end
            end
            u4[v10] = v11
            p8:SetAttribute("U", v10)
        end
    end,
    ["restore"] = function(p14) --[[ Name: restore, Line 60 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
        --]]
        local v15 = p14:GetAttribute("U")
        local v16 = u4[v15]
        if not v16 then
            u2.error((("%* with cache id \'%*\' doesn\'t have any cached attributes"):format(p14, v15)))
        end
        for v17, v18 in v16 do
            p14:SetAttribute(v17, v18)
        end
        p14:SetAttribute("U", nil)
    end,
    ["get"] = function(p19, p20, p21, p22, p23) --[[ Name: get, Line 76 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local v24 = u4[p19:GetAttribute("U")]
        if v24 then
            v24 = v24[p20]
        end
        if v24 == nil then
            local v25 = p19:GetAttribute(p20)
            if p23 then
                p21 = p23(v25)
            elseif v25 ~= nil then
                p21 = v25
            end
            if not p22 and u3 then
                p19:SetAttribute(p20, p21)
            end
            return p21
        elseif p23 then
            return p23(v24)
        elseif v24 == nil then
            return p21
        else
            return v24
        end
    end,
    ["getRange"] = function(p26, p27, u28, u29, p30) --[[ Name: getRange, Line 101 ]]
        --[[
        Upvalues:
            [1] = u72
        --]]
        return u72.get(p26, p27, u28, p30, function(p31) --[[ Line: 102 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u29
            --]]
            if typeof(p31) ~= "NumberRange" then
                return u28
            end
            if not u29 then
                return p31
            end
            local v32 = NumberRange.new
            local v33 = p31.Min
            local v34 = u29.Min
            local v35 = u29.Max
            local v36 = math.clamp(v33, v34, v35)
            local v37 = p31.Max
            local v38 = u29.Min
            local v39 = u29.Max
            return v32(v36, (math.clamp(v37, v38, v39)))
        end)
    end,
    ["getEnum"] = function(p40, p41, u42, u43, p44) --[[ Name: getEnum, Line 119 ]]
        --[[
        Upvalues:
            [1] = u72
        --]]
        return u72.get(p40, p41, u42, p44, function(p45) --[[ Line: 120 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u42
            --]]
            if p45 == nil or not table.find(u43, p45) then
                return u42
            else
                return p45
            end
        end)
    end,
    ["set"] = function(p46, p47, p48) --[[ Name: set, Line 129 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        local v49 = u4[p46:GetAttribute("U")]
        if v49 then
            v49[p47] = p48
        else
            p46:SetAttribute(p47, p48)
        end
    end,
    ["isCached"] = function(p50) --[[ Name: isCached, Line 141 ]]
        return p50:GetAttribute("U") ~= nil
    end,
    ["getState"] = function(p51, p52, p53) --[[ Name: getState, Line 145 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        local v54 = u6[p51]
        if v54 then
            v54 = v54[p52]
        end
        if v54 == nil then
            return p53
        else
            return v54
        end
    end,
    ["setState"] = function(p55, p56, p57) --[[ Name: setState, Line 152 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        local v58 = u6[p55]
        if not v58 then
            v58 = {}
            u6[p55] = v58
        end
        v58[p56] = p57
    end,
    ["clearState"] = function(p59) --[[ Name: clearState, Line 163 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        u6[p59] = nil
    end,
    ["trigger"] = function(p60, p61, p62) --[[ Name: trigger, Line 167 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v63 = u5[p60]
        if v63 then
            v63 = v63[p61]
        end
        if v63 then
            for _, v64 in v63 do
                v64(p62)
            end
        end
    end,
    ["hook"] = function(u65, u66, u67) --[[ Name: hook, Line 180 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u72
        --]]
        local u68 = u5[u65]
        if not u68 then
            u68 = {}
            u5[u65] = u68
        end
        local u69 = u68[u66]
        if not u69 then
            u69 = {}
            u68[u66] = u69
        end
        table.insert(u69, u67)
        local u70
        if u72.isCached(u65) then
            u70 = nil
        else
            u70 = u65:GetAttributeChangedSignal(u66):Connect(function() --[[ Line: 200 ]]
                --[[
                Upvalues:
                    [1] = u65
                    [2] = u66
                    [3] = u67
                --]]
                u67((u65:GetAttribute(u66)))
            end)
        end
        return function() --[[ Line: 206 ]]
            --[[
            Upvalues:
                [1] = u70
                [2] = u69
                [3] = u67
                [4] = u68
                [5] = u66
                [6] = u5
                [7] = u65
            --]]
            if u70 then
                u70:Disconnect()
            end
            local v71 = table.find(u69, u67)
            if v71 then
                table.remove(u69, v71)
            end
            if #u69 == 0 then
                u68[u66] = nil
            end
            if next(u68) == nil then
                u5[u65] = nil
            end
        end
    end
}
return u72