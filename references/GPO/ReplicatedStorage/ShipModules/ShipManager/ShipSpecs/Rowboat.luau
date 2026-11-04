 

local u1 = {}
u1.__index = u1
local function u6(p2, p3) --[[ Line: 3 ]]
    local v4 = script.paddle:Clone()
    v4.Parent = p2
    v4.Name = p3 .. "Paddle"
    local v5 = Instance.new("Motor6D", p2[p3 .. "Hand"])
    v5.Part0 = v5.Parent
    v5.Part1 = v4
    v5.C0 = CFrame.new(0, -v4.Size.Y / 2, 0)
    v5.Name = p3 .. "Pad"
    return v4
end
function u1.Start(_, p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u6
    --]]
    local v8 = {}
    local v9 = u1
    setmetatable(v8, v9)
    v8.pads = { u6(p7, "Right"), (u6(p7, "Left")) }
    return v8
end
function u1.End(p10) --[[ Line: 21 ]]
    for v11 = 1, #p10.pads do
        p10.pads[v11]:Destroy()
    end
end
return u1