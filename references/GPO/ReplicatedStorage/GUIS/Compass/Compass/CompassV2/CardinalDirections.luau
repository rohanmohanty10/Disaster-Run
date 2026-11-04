 

local v1 = script.Parent.Objects
local u2 = require(v1.Default)
local v3 = {}
v3.__index = v3
function v3.SetUp(p4, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    p4.Cardinals = {
        ["N"] = -3.141592653589793,
        ["NE"] = -2.356194490192345,
        ["E"] = -1.5707963267948966,
        ["SE"] = -0.7853981633974483,
        ["S"] = 0,
        ["SW"] = 0.7853981633974483,
        ["W"] = 1.5707963267948966,
        ["NW"] = 2.356194490192345
    }
    for v6, v7 in pairs(p4.Cardinals) do
        local v8 = script.Marker:Clone()
        v8.Name = "Cardinal Direction " .. v6
        v8.Text = v6
        v8.Parent = p5.CompassUI
        p5.Cardinals[v8.Name] = u2.new({
            ["Icon"] = v8,
            ["Handler"] = p5,
            ["Guider"] = v7,
            ["DefaultTransparency"] = 0
        })
    end
end
return v3