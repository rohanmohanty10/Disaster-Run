 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u28 = {
    ["serialize"] = function(p3) --[[ Name: serialize, Line 6 ]]
        local v4 = buffer.create(#p3 * 8)
        for v5, v6 in p3 do
            local v7 = (v5 - 1) * 8
            buffer.writef64(v4, v7, v6)
        end
        return v4
    end,
    ["deserialize"] = function(p8) --[[ Name: deserialize, Line 16 ]]
        if typeof(p8) == "string" then
            p8 = buffer.fromstring(p8) or p8
        end
        local v9 = {}
        for v10 = 0, buffer.len(p8) / 8 - 1 do
            local v11 = v10 * 8
            local v12 = buffer.readf64(p8, v11)
            table.insert(v9, v12)
        end
        return v9
    end,
    ["isLocalFlipbook"] = function(p13) --[[ Name: isLocalFlipbook, Line 29 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if not u1:IsStudio() then
            return false
        end
        for _, v14 in u2:GetTags(p13) do
            if v14:match("^_local_flipbook_") then
                return true
            end
        end
        return false
    end,
    ["getTexturePrefix"] = function(p15) --[[ Name: getTexturePrefix, Line 43 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        return u28.isLocalFlipbook(p15) and "rbxtemp://" or "rbxassetid://"
    end,
    ["getFlipbookData"] = function(p16) --[[ Name: getFlipbookData, Line 47 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        if p16:GetAttribute("FlipbookEnabled") then
            local v17 = p16:GetAttribute("FlipbookTextures")
            if v17 then
                local v18 = u28.deserialize(v17)
                if #v18 == 0 then
                    return nil
                else
                    return v18
                end
            else
                return nil
            end
        else
            return nil
        end
    end,
    ["getChangeDuration"] = function(p19) --[[ Name: getChangeDuration, Line 81 ]]
        local v20 = p19.duration
        if p19.ref:GetAttribute("SyncDuration") then
            v20 = p19.effectDuration
        end
        return v20
    end,
    ["createUpdateCallback"] = function(u21) --[[ Name: createUpdateCallback, Line 91 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        local u22 = u28.getTexturePrefix(u21.ref)
        return function(p23, p24) --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u22
            --]]
            local v25 = #u21.frames * p23
            local v26 = math.round(v25)
            local v27 = math.max(v26, 1)
            u21.setTexture((("%*%*"):format(u22, u21.frames[v27])))
            return p24 * u21.getSpeed()
        end
    end
}
return u28