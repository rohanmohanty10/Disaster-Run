 

local u1 = {
    ["black"] = Color3.fromRGB(0, 0, 0),
    ["red"] = Color3.fromRGB(255, 0, 0),
    ["blue"] = Color3.fromRGB(0, 0, 255),
    ["green"] = Color3.fromRGB(0, 255, 0),
    ["white"] = Color3.fromRGB(255, 255, 255),
    ["rainbow"] = "rainbow"
}
local u2 = require(script.rainbow)
return {
    ["GetValue"] = function(_, p3) --[[ Name: GetValue, Line 15 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if u1[p3] then
            return u1[p3]
        end
        local v4 = {}
        for v5 in p3:gmatch("%d+") do
            table.insert(v4, v5)
        end
        return Color3.fromRGB(table.unpack(v4))
    end,
    ["Render"] = function(_, p6, p7) --[[ Name: Render, Line 28 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if p7 == "rainbow" then
            return u2:Render(p6)
        end
        p6.TextLabel.TextColor3 = p7
    end
}