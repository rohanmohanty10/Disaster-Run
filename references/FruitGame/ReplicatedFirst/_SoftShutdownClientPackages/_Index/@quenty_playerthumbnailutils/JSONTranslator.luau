 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("Players")
local u3 = game:GetService("RunService")
local u4 = v1("JsonToLocalizationTable")
local u5 = v1("PseudoLocalize")
local u6 = v1("LocalizationServiceUtils")
local u7 = v1("Promise")
local u8 = v1("Observable")
local u9 = v1("Maid")
local u10 = v1("Blend")
local u11 = v1("Rx")
local u12 = {
    ["ClassName"] = "JSONTranslator"
}
u12.__index = u12
function u12.new(...) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u4
        [3] = u3
        [4] = u6
        [5] = u2
        [6] = u7
        [7] = u5
    --]]
    local v13 = u12
    local v14 = setmetatable({}, v13)
    v14._localizationTable = u4.toLocalizationTable(...)
    v14._englishTranslator = v14._localizationTable:GetTranslator("en")
    v14._fallbacks = {}
    if u3:IsRunning() then
        v14._promiseTranslator = u6.promiseTranslator(u2.LocalPlayer)
    else
        v14._promiseTranslator = u7.resolved(v14._englishTranslator)
    end
    if u3:IsStudio() then
        u5.addToLocalizationTable(v14._localizationTable, nil, "en")
    end
    return v14
end
function u12.GetLocalizationTable(p15) --[[ Line: 66 ]]
    return p15._localizationTable
end
function u12.PromiseLoaded(p16) --[[ Line: 74 ]]
    return p16._promiseTranslator
end
function u12.FallbackTo(p17, p18) --[[ Line: 85 ]]
    assert(p18, "Bad translator")
    local v19 = p18.FormatByKey
    assert(v19, "Bad translator")
    local v20 = p17._fallbacks
    table.insert(v20, p18)
end
function u12.PromiseFormatByKey(u21, u22, u23) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v24 = u21 ~= u12
    assert(v24, "Construct a new version of this class to use it")
    local v25 = type(u22) == "string"
    assert(v25, "Key must be a string")
    return u21._promiseTranslator:Then(function() --[[ Line: 102 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
            [3] = u23
        --]]
        return u21:FormatByKey(u22, u23)
    end)
end
function u12.ObserveFormatByKey(u26, u27, p28) --[[ Line: 113 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u10
        [3] = u11
        [4] = u8
        [5] = u9
    --]]
    local v29 = u26 ~= u12
    assert(v29, "Construct a new version of this class to use it")
    local v30 = type(u27) == "string"
    assert(v30, "Key must be a string")
    local u31
    if p28 then
        local v32 = {}
        for v33, v34 in pairs(p28) do
            v32[v33] = u10.toPropertyObservable(v34) or u11.of(v34)
        end
        u31 = u11.combineLatest(v32)
    else
        u31 = nil
    end
    return u8.new(function(u35) --[[ Line: 129 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u26
            [3] = u31
            [4] = u27
        --]]
        local u36 = u9.new()
        u36:GivePromise(u26._promiseTranslator:Then(function() --[[ Line: 132 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u36
                [3] = u35
                [4] = u26
                [5] = u27
            --]]
            if u31 then
                u36:GiveTask(u31:Subscribe(function(p37) --[[ Line: 134 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u26
                        [3] = u27
                    --]]
                    u35:Fire(u26:FormatByKey(u27, p37))
                end))
            else
                u35:Fire(u26:FormatByKey(u27, nil))
            end
        end))
        return u36
    end)
end
function u12.FormatByKey(u38, u39, u40) --[[ Line: 152 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u3
    --]]
    local v41 = u38 ~= u12
    assert(v41, "Construct a new version of this class to use it")
    local v42 = type(u39) == "string"
    assert(v42, "Key must be a string")
    if not u3:IsRunning() then
        return u38:_formatByKeyTestMode(u39, u40)
    end
    local u43 = u38:_getClientTranslatorOrError()
    local u44 = nil
    local v45, v46 = pcall(function() --[[ Line: 163 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u43
            [3] = u39
            [4] = u40
        --]]
        u44 = u43:FormatByKey(u39, u40)
    end)
    if v45 and not v46 then
        return u44
    end
    if v46 then
        warn(v46)
    else
        warn("Failed to localize \'" .. u39 .. "\'")
    end
    if u43.LocaleId ~= u38._englishTranslator.LocaleId then
        local v47, v48 = pcall(function() --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u38
                [3] = u39
                [4] = u40
            --]]
            u44 = u38._englishTranslator:FormatByKey(u39, u40)
        end)
        if v47 and not v48 then
            return u44
        end
    end
    return u39
end
function u12._getClientTranslatorOrError(p49) --[[ Line: 192 ]]
    local v50 = p49._promiseTranslator
    assert(v50, "ClientTranslator is not initialized")
    if p49._promiseTranslator:IsFulfilled() then
        local v51 = p49._promiseTranslator:Wait()
        return assert(v51, "Failed to get translator")
    else
        error("Translator is not yet acquired yet")
        return nil
    end
end
function u12._formatByKeyTestMode(p52, u53, u54) --[[ Line: 203 ]]
    local u55 = p52._localizationTable:GetTranslator("en")
    local u56 = nil
    local v57, v58 = pcall(function() --[[ Line: 207 ]]
        --[[
        Upvalues:
            [1] = u56
            [2] = u55
            [3] = u53
            [4] = u54
        --]]
        u56 = u55:FormatByKey(u53, u54)
    end)
    if v57 and not v58 then
        return u56
    end
    for _, v59 in pairs(p52._fallbacks) do
        local v60 = v59:FormatByKey(u53, u54)
        if v60 then
            return v60
        end
    end
    if v58 then
        warn(v58)
    else
        warn("Failed to localize \'" .. u53 .. "\'")
    end
    return u53
end
function u12.Destroy(p61) --[[ Line: 234 ]]
    p61._localizationTable:Destroy()
    p61._localizationTable = nil
    p61._englishTranslator = nil
    p61._promiseTranslator = nil
    setmetatable(p61, nil)
end
return u12