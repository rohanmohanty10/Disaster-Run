 

local u1 = {}
u1.__index = u1
u1.__type = "Cuboid"
function u1.__newindex(_, p2) --[[ Line: 4 ]]
    error(tostring(p2) .. " cannot be assigned to")
end
function u1.__tostring(p3) --[[ Line: 7 ]]
    local v4 = p3.Min
    local v5 = tostring(v4)
    local v6 = p3.Max
    return v5 .. ", " .. tostring(v6)
end
function u1.new(...) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7, v8 = ...
    if select("#", ...) == 1 then
        error("Invalid number of arguments: 1")
    else
        local v9 = typeof(v7)
        local v10 = typeof(v8)
        if v9 ~= "nil" and v10 ~= "nil" then
            if v9 == "Vector3" then
                if v10 ~= "Vector3" then
                    error("invalid argument #2 to \'new\' (Vector3 expected, got " .. v10 .. ")")
                end
            else
                error("invalid argument #1 to \'new\' (Vector3 expected, got " .. v9 .. ")")
            end
        end
    end
    local v11 = v7 or Vector3.new(0, 0, 0)
    local v12 = v8 or Vector3.new(0, 0, 0)
    local v13 = v11.X
    local v14 = v11.Y
    local v15 = v11.Z
    local v16 = v12.X
    local v17 = v12.Y
    local v18 = v12.Z
    local v19 = {}
    local v20 = v13 < v16 and v13 and v13 or v16
    local v21 = v14 < v17 and v14 and v14 or v17
    local v22 = v15 < v18 and v15 and v15 or v18
    v19.Min = Vector3.new(v20, v21, v22)
    if v16 < v13 then
        v16 = v13 or v16
    end
    if v17 < v14 then
        v17 = v14 or v17
    end
    if v18 < v15 then
        v18 = v15 or v18
    end
    v19.Max = Vector3.new(v16, v17, v18)
    local v23 = u1
    return setmetatable(v19, v23)
end
return u1