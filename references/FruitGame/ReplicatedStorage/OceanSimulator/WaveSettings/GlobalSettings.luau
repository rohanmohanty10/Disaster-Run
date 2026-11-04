 

local u1 = {}
local function v10() --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = {
        ["Direction"] = Vector3.new(1, -1, 0),
        ["WaveLength"] = 180,
        ["Steepness"] = 0.12,
        ["Gravity"] = 0.2,
        ["Priority"] = 0,
        ["Cancel"] = false
    }
    local v3 = math.random() * 2 - 1
    local v4 = math.random() * 2 - 1
    local v5 = v3 ^ 2 + v4 ^ 2
    local v6 = math.sqrt(v5)
    local v7 = v3 / v6
    local v8 = v4 / v6
    v2.Direction = Vector3.new(v7, v8)
    v2.WaveLength = math.random(25, 100)
    v2.Steepness = math.random(20, 40) / 1000
    local v9 = u1
    table.insert(v9, v2)
end
for _ = 1, 12 do
    v10()
end
return u1