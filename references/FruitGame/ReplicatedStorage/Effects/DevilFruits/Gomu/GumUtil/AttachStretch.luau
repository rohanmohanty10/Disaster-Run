 

local u1 = script:WaitForChild("GumRight")
local u2 = script:WaitForChild("GumLeft")
local u23 = {
    ["RightArm"] = function(p3) --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = p3.Humanoid
        local v5 = p3.RightUpperArm
        local v6 = p3.RightLowerArm
        local v7 = v6.RightElbow
        local v8 = u1:Clone()
        v8.Color = v6.Color
        local v9 = v4.BodyWidthScale.Value
        local v10 = v4.BodyHeightScale.Value
        local v11 = v4.BodyDepthScale.Value
        v8.Size = Vector3.new(v9, v10, v11)
        local v12 = v7:Clone()
        v12.Name = v8.Name
        v12.Part0 = v5
        v12.Part1 = v8
        v12.Parent = v5
        v8.Parent = p3
        v8.Transparency = 0
    end,
    ["LeftArm"] = function(p13) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v14 = p13.Humanoid
        local v15 = p13.LeftUpperArm
        local v16 = p13.LeftLowerArm
        local v17 = v16.LeftElbow
        local v18 = u2:Clone()
        v18.Color = v16.Color
        local v19 = v14.BodyWidthScale.Value
        local v20 = v14.BodyHeightScale.Value * 1.302
        local v21 = v14.BodyDepthScale.Value
        v18.Size = Vector3.new(v19, v20, v21)
        local v22 = v17:Clone()
        v22.Name = v18.Name
        v22.C0 = v17.C0
        v22.C1 = v17.C1
        v22.Part0 = v15
        v22.Part1 = v18
        v22.Parent = v15
        v18.Parent = p13
        v18.Transparency = 0
    end
}
return function(p24, p25) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    u23[p25](p24)
end