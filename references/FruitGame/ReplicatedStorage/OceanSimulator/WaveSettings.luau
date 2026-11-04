 

local u1 = require(script.IntervalTree)
local u2 = require(script.GlobalSettings)
local u3 = u1.new()
local u4 = u3:Serialize()
local u5 = 0
local function v6() --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3
end
local function v7() --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5
end
local function v8() --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4
end
local function v11(p9, p10) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3:Search(p9, p10)
end
local function v17(p12, p13, p14, p15) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local v16 = u3:Insert(p13.X, p14.X, p13.Z, p14.Z, p12, p15)
    u4 = u3:Serialize()
    u5 = u5 + 1
    return v16
end
local function v24(p18, p19, p20, p21, p22) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local v23 = u3:Update(p18, p20.X, p21.X, p20.Z, p21.Z, p19, p22)
    if v23 then
        u4 = u3:Serialize()
        u5 = u5 + 1
    end
    return v23
end
local function v27(p25) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    local v26 = u3:Remove(p25)
    if v26 then
        u4 = u3:Serialize()
        u5 = u5 + 1
    end
    return v26
end
local function v29(p28) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    u3 = u1.Deserialize(p28)
end
(function() --[[ Name: _AddGlobalSettings, Line 59 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u5
    --]]
    for _, v30 in u2 do
        u3:Insert(-99999999, 99999999, -99999999, 99999999, v30, v30.Priority)
    end
    u4 = u3:Serialize()
    u5 = u5 + 1
end)()
return {
    ["GetTree"] = v6,
    ["GetSerializedTree"] = v8,
    ["GetVersion"] = v7,
    ["_UpdateTree"] = v29,
    ["GetWaveSettings"] = v11,
    ["AddSetting"] = v17,
    ["EditSetting"] = v24,
    ["RemoveSetting"] = v27
}