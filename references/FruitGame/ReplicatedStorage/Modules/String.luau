 

local v1 = {}
local u2 = nil
function v1.encode(p3) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not u2 then
        u2 = {}
        for v4 = 0, 127 do
            local v5 = -1
            repeat
                v5 = v5 + 2
            until v5 * (v4 * 2 + 1) % 256 == 1
            u2[v4] = v5
        end
    end
    local u6 = 666666
    return p3:gsub(".", function(p7) --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
        --]]
        local v8 = u6 % 274877906944
        local v9 = (u6 - v8) / 274877906944
        local v10 = v9 % 128
        local v11 = p7:byte()
        local v12 = (v11 * u2[v10] - (v9 - v10) / 128) % 256
        u6 = v8 * 460828 + v9 + v12 + v11
        return ("%02x"):format(v12)
    end)
end
function v1.decode(p13) --[[ Line: 34 ]]
    local u14 = 666666
    return p13 == nil and "" or p13:gsub("%x%x", function(p15) --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        local v16 = u14 % 274877906944
        local v17 = (u14 - v16) / 274877906944
        local v18 = v17 % 128
        local v19 = tonumber(p15, 16)
        local v20 = (v19 + (v17 - v18) / 128) * (v18 * 2 + 1) % 256
        u14 = v16 * 460828 + v17 + v19 + v20
        return string.char(v20)
    end)
end
return v1