 

local u1 = {
    ["nil"] = 0,
    ["EnumItem"] = 4,
    ["boolean"] = 1,
    ["number"] = 8,
    ["UDim"] = 8,
    ["UDim2"] = 16,
    ["Ray"] = 24,
    ["Faces"] = 6,
    ["Axes"] = 6,
    ["BrickColor"] = 4,
    ["Color3"] = 12,
    ["Vector2"] = 8,
    ["Vector3"] = 12,
    ["Instance"] = 4,
    ["Vector2int16"] = 4,
    ["Vector3int16"] = 6,
    ["NumberSequenceKeypoint"] = 12,
    ["ColorSequenceKeypoint"] = 16,
    ["NumberRange"] = 8,
    ["Rect"] = 16,
    ["PhysicalProperties"] = 20,
    ["Color3uint8"] = 3
}
local u2 = {
    [CFrame.Angles(0, 0, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 0, 0)] = true,
    [CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 3.141592653589793)] = true,
    [CFrame.Angles(0, 0, 3.141592653589793)] = true,
    [CFrame.Angles(-1.5707963267948966, 0, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 1.5707963267948966)] = true,
    [CFrame.Angles(0, 0, -1.5707963267948966)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)] = true,
    [CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966)] = true,
    [CFrame.Angles(0, 0, 1.5707963267948966)] = true,
    [CFrame.Angles(0, -3.141592653589793, -1.5707963267948966)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)] = true,
    [CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966)] = true,
    [CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 3.141592653589793)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 3.141592653589793)] = true
}
local function u26(p3, p4) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u26
        [3] = u2
    --]]
    local v5 = typeof(p3)
    if u1[v5] then
        return u1[v5]
    end
    if v5 == "string" or v5 == "buffer" then
        local v6 = v5 == "string" and #p3 or buffer.len(p3)
        local v7 = v6 + 1
        local v8 = math.log(v7, 128)
        local v9 = math.ceil(v8)
        return math.max(v9, 1) + v6
    end
    if v5 == "table" then
        if p4[p3] then
            return 0
        else
            p4[p3] = true
            local v10 = p3[1] ~= nil
            local v11 = 1
            local v12 = 0
            local v13 = 0
            for v14, v15 in next, p3 do
                v11 = v11 + 1
                if not v10 then
                    v13 = v13 + (u26(v14, p4) + 1)
                end
                v12 = v12 + (u26(v15, p4) + 1)
            end
            if v10 then
                local v16 = v11 + 1
                local v17 = math.log(v16, 128)
                local v18 = math.ceil(v17)
                return math.max(v18, 1) + v12
            else
                local v19 = v11 + 1
                local v20 = math.log(v19, 128)
                local v21 = math.ceil(v20)
                return math.max(v21, 1) + v13 + v12
            end
        end
    end
    if v5 ~= "CFrame" then
        if v5 ~= "NumberSequence" and v5 ~= "ColorSequence" then
            warn("[PacketSizeCounter]: Unsupported data type: " .. v5)
            return 0
        end
        local v22 = 4
        for _, v23 in next, p3.Keypoints do
            v22 = v22 + u26(v23, p4)
        end
        return v22
    end
    local v24 = false
    for v25 in next, u2 do
        if v25 == p3.Rotation then
            v24 = true
            break
        end
    end
    return v24 and 13 or 19
end
local v32 = {
    ["BaseRemoteOverhead"] = 9,
    ["RemoteFunctionOverhead"] = 2,
    ["ClientToServerOverhead"] = 5,
    ["TypeOverhead"] = 1,
    ["GetPacketSize"] = function(p27) --[[ Name: GetPacketSize, Line 173 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        local v28 = 9
        if p27.RemoteType == "RemoteFunction" then
            v28 = v28 + 2
        end
        if p27.RunContext == "Client" then
            v28 = v28 + 5
        end
        local v29 = {}
        for _, v30 in ipairs(p27.PacketData) do
            v28 = v28 + (u26(v30, v29) + 1)
        end
        return v28
    end,
    ["GetDataByteSize"] = function(p31) --[[ Name: GetDataByteSize, Line 195 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        return u26(p31, {}) + 1
    end
}
table.freeze(v32)
return v32