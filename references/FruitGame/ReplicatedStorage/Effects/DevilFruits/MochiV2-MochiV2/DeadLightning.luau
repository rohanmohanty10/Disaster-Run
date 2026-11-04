 

local u1 = Random.new()
local u2 = game:GetService("TweenService")
local u3 = script.Part
local function u16(u4, p5) --[[ Line: 9 ]]
    local u6 = not p5.sizeMult and 1.15 or p5.sizeMult
    local u7 = script.inverted:Clone()
    u7.Color = p5.GlowColor
    local function v12() --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u6
        --]]
        u7.CFrame = u4.CFrame
        local v8 = u7
        local v9 = u4.Size.X * u6
        local v10 = u4.Size.Y * u6
        local v11 = u4.Size.Z
        v8.Size = Vector3.new(v9, v10, v11)
    end
    u7.CFrame = u4.CFrame
    local v13 = u4.Size.X * u6
    local v14 = u4.Size.Y * u6
    local v15 = u4.Size.Z
    u7.Size = Vector3.new(v13, v14, v15)
    u7.Parent = u4
    u4.Color = p5.MainColor
    u4:GetPropertyChangedSignal("Size"):Connect(v12)
    u4:GetPropertyChangedSignal("CFrame"):Connect(v12)
end
local function u39(u17) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u16
        [4] = u2
    --]]
    local v18 = u17.StartPosition
    local v19 = u17.EndPosition
    local v20 = u17.Points or 5
    u17.Offset = u17.Offset or NumberRange.new(-2, 2)
    local v21 = {}
    for v22 = 1, v20 do
        v21[v22] = CFrame.new(v18, v19) * CFrame.new(u1:NextNumber(u17.Offset.Min, u17.Offset.Max), u1:NextNumber(u17.Offset.Min, u17.Offset.Max), -(v18 - v19).Magnitude * v22 / v20).Position
    end
    v21[1] = v18
    v21[#v21] = v19
    local u23 = {}
    for v24 = 1, v20 - 1 do
        local v25 = v21[v24]
        local v26 = v21[v24 + 1]
        local v27 = CFrame.new(v25, v26) * CFrame.new(u1:NextNumber(u17.Offset.Min, u17.Offset.Max) * 0.5, u1:NextNumber(u17.Offset.Min, u17.Offset.Max) * 0.5, -(v25 - v26).Magnitude / 2).Position
        for v28 = 0, 3 do
            local v29 = v28 / 3
            local v30 = v25 + (v27 - v25) * v29
            local v31 = v30 + (v27 + (v26 - v27) * v29 - v30) * v29
            u23[#u23 + 1] = v31
        end
    end
    local _ = #u23
    task.spawn(function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u23
            [3] = u1
            [4] = u3
            [5] = u16
            [6] = u2
        --]]
        local v32 = TweenInfo.new(u17.LightningDuration * 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true)
        for v33 = 1, #u23 - 1 do
            local v34 = (u23[v33] - u23[v33 + 1]).Magnitude
            local v35 = v33 / #u23
            local v36 = u1:NextNumber(u17.RandomSize.Min, u17.RandomSize.Max)
            local v37 = u3:Clone()
            v37.CFrame = CFrame.new(u23[v33], u23[v33 + 1]) * CFrame.new(0, 0, -v34 / 2)
            v37.Size = Vector3.new(0, 0, v34)
            v37.Color = u17.GlowColor
            if u17.Inverted ~= nil then
                u16(v37, u17)
            end
            v37.Parent = u17.Model
            _G.destroy(v37, u17.LightningDuration)
            local v38 = u17.Size * (1 - v35) * v36
            u2:Create(v37, v32, {
                ["Size"] = Vector3.new(v38, v38, v34)
            }):Play()
            u17.WaitFunction(v33, #u23)
        end
    end)
end
local function u73(u40) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u16
        [4] = u2
        [5] = u39
    --]]
    local u41 = u40.StartPosition
    local u42 = u40.EndPosition
    local v43 = u40.Points
    local v44 = {}
    for v45 = 1, v43 do
        v44[v45] = CFrame.new(u40.StartPosition, u40.EndPosition) * CFrame.new(u1:NextNumber(u40.Offset.Min, u40.Offset.Max), u1:NextNumber(u40.Offset.Min, u40.Offset.Max), -(u41 - u42).Magnitude * v45 / v43).Position
    end
    v44[1] = u40.StartPosition
    v44[#v44] = u40.EndPosition
    local u46 = {}
    for v47 = 1, v43 - 1 do
        local v48 = v44[v47]
        local v49 = v44[v47 + 1]
        local v50 = CFrame.new(v48, v49) * CFrame.new(u1:NextNumber(u40.Offset.Min, u40.Offset.Max) * 0.5, u1:NextNumber(u40.Offset.Min, u40.Offset.Max) * 0.5, -(v48 - v49).Magnitude / 2).Position
        for v51 = 0, 3 do
            local v52 = v51 / 3
            local v53 = v48 + (v50 - v48) * v52
            local v54 = v53 + (v50 + (v49 - v50) * v52 - v53) * v52
            u46[#u46 + 1] = v54
        end
    end
    local u55 = Instance.new("Model")
    u55.Name = "LightningFX"
    if u40.NoHighlight == nil and u40.Inverted == nil then
        local v56 = Instance.new("Highlight")
        v56.OutlineTransparency = 1
        v56.FillColor = u40.MainColor
        v56.FillTransparency = u40.FillTransparency or 0
        v56.DepthMode = Enum.HighlightDepthMode.Occluded
        v56.Parent = u55
    end
    u55.Parent = workspace.Effects
    local _ = #u46
    task.spawn(function() --[[ Line: 153 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u46
            [3] = u1
            [4] = u3
            [5] = u55
            [6] = u16
            [7] = u2
            [8] = u41
            [9] = u42
            [10] = u39
        --]]
        local v57 = TweenInfo.new(u40.LightningDuration * 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true)
        for v58 = 1, #u46 - 1 do
            local v59 = (u46[v58] - u46[v58 + 1]).Magnitude
            local v60 = v58 / #u46
            local v61 = u1:NextNumber(u40.RandomSize.Min, u40.RandomSize.Max)
            local v62 = u3:Clone()
            v62.CFrame = CFrame.new(u46[v58], u46[v58 + 1]) * CFrame.new(0, 0, -v59 / 2)
            v62.Size = Vector3.new(0, 0, v59)
            v62.Color = u40.GlowColor
            v62.Parent = u55
            _G.destroy(v62, u40.LightningDuration)
            if u40.Inverted ~= nil then
                u16(v62, u40)
            end
            local v63 = u40.Size * (1 - v60) * v61
            u2:Create(v62, v57, {
                ["Size"] = Vector3.new(v63, v63, v59)
            }):Play()
            if u40.Branches and math.random(5) == 1 then
                local v64 = (v62.CFrame * CFrame.new(0, 0, -v62.Size.Z / 2)).Position
                local v65 = CFrame.new(u41, u42) - CFrame.new(u41, u42).Position
                local v66 = u39
                local v67 = {
                    ["StartPosition"] = v64
                }
                local v68 = CFrame.new(v64) * v65
                local v69 = CFrame.Angles
                local v70 = u1:NextNumber(-35, 35)
                local v71 = math.rad(v70)
                local v72 = u1:NextNumber(-35, 35)
                v67.EndPosition = (v68 * v69(v71, math.rad(v72), 0) * CFrame.new(0, 0, -u1:NextNumber(5, 10))).Position
                v67.Size = v63
                v67.Model = u55
                v67.MainColor = u40.MainColor
                v67.GlowColor = u40.GlowColor
                v67.Inverted = u40.Inverted
                v67.WaitFunction = u40.WaitFunction
                v67.LightningDuration = u40.LightningDuration
                v67.RandomSize = u40.RandomSize
                v66(v67)
            end
            u40.WaitFunction(v58, #u46)
        end
        _G.destroy(u55, u40.LightningDuration * 2)
    end)
end
return {
    ["start"] = function(_, p74) --[[ Name: start, Line 210 ]]
        --[[
        Upvalues:
            [1] = u73
        --]]
        if _G.checkRenderDistance(p74.StartPosition) ~= false then
            local _ = p74.Character
            u73(p74)
        end
    end
}