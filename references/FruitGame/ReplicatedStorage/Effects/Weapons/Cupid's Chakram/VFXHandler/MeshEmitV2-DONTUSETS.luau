 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = {
    "Position",
    "Size",
    "Transparency",
    "Reflectance",
    "Color"
}
local u5 = { "Offset", "Scale", "VertexColor" }
local u6 = { "Color3", "ZIndex", "Transparency" }
local function u23(u7, u8, p9, p10) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u2
        [4] = u4
    --]]
    local u11 = u7:FindFirstChildOfClass("SpecialMesh")
    local u12 = u7:FindFirstChildOfClass("Decal")
    if u11 or u12 then
        u12.Transparency = u7.Transparency
        local u13 = {}
        local u14 = {}
        for _, v15 in pairs(u5) do
            u13[v15] = u7[v15]
        end
        for _, v16 in pairs(u6) do
            u14[v16] = u7[v16]
        end
        local v17 = {}
        local v18 = {}
        for v19, v20 in pairs(p9) do
            if table.find(u5, v19) then
                v17[v19] = v20
            end
            if table.find(u6, v19) then
                v18[v19] = v20
            end
        end
        v17.Scale = p10.End:FindFirstChildOfClass("SpecialMesh").Scale
        u2:Create(u11, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), v17):Play()
        u2:Create(u12, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), v18):Play()
        if u8.StayDuration then
            task.delay(u8.StayDuration, function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u11
                    [3] = u8
                    [4] = u13
                    [5] = u12
                    [6] = u14
                --]]
                u2:Create(u11, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), u13):Play()
                u2:Create(u12, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), u14):Play()
            end)
            return
        end
    else
        p9.Size = p10.End.Size
        local u21 = {}
        for _, v22 in pairs(u4) do
            u21[v22] = u7[v22]
        end
        u2:Create(u7, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), p9):Play()
        if u8.StayDuration then
            task.delay(u8.StayDuration, function() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u7
                    [3] = u8
                    [4] = u21
                --]]
                u2:Create(u7, TweenInfo.new(u8.Duration, u8.EasingStyle, u8.EasingDirection), u21):Play()
            end)
        end
    end
end
function v1.PlayMesh(u24, p25) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u23
    --]]
    print(u24:GetAttributes())
    local v26 = {
        ["Duration"] = u24:GetAttribute("TweenDuration_TweenParam"),
        ["EasingStyle"] = u24:GetAttribute("EasingStyle_TweenParam") and Enum.EasingStyle[u24:GetAttribute("EasingStyle_TweenParam")] or Enum.EasingStyle.Linear,
        ["EasingDirection"] = u24:GetAttribute("EasingDirection_TweenParam") and Enum.EasingDirection[u24:GetAttribute("EasingDirection_TweenParam")] or Enum.EasingDirection.Out,
        ["StayDuration"] = u24:GetAttribute("StayDuration_TweenParam")
    }
    local u27 = {
        ["SpinDuration"] = u24:GetAttribute("SpinDuration_SpinParam"),
        ["SpinSpeed"] = u24:GetAttribute("SpinSpeed_SpinParam") or 5
    }
    if p25 then
        for _, v28 in pairs(u24:GetDescendants()) do
            if v28:IsA("BasePart") then
                local v29 = v28.CFrame
                local v30 = CFrame.Angles
                local v31 = math.random(p25[1], p25[2])
                v28.CFrame = v29 * v30(0, (math.rad(v31)))
            end
        end
    end
    local u32 = nil
    if u27.SpinDuration then
        local u42 = u3.Stepped:Connect(function(p33) --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u32
                [3] = u27
            --]]
            if u24 then
                if u24:IsA("Model") then
                    for _, v34 in pairs(u24:GetChildren()) do
                        local v35 = v34.CFrame
                        local v36 = CFrame.Angles
                        local v37 = u27.SpinSpeed
                        v34.CFrame = v35 * v36(0, math.rad(v37), 0)
                        print(u27.SpinSpeed * p33)
                    end
                    return
                elseif u24:IsA("BasePart") then
                    local v38 = u24
                    local v39 = v38.CFrame
                    local v40 = CFrame.Angles
                    local v41 = u27.SpinSpeed
                    v38.CFrame = v39 * v40(0, math.rad(v41), 0)
                else
                    error("Mesh Type not supported")
                end
            else
                u32:Disconnect()
                return
            end
        end)
        task.delay(u27.SpinDuration, function() --[[ Line: 159 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            u42:Disconnect()
        end)
    end
    local v43 = u24:GetAttributes()
    local v44 = {}
    for v45, v46 in pairs(v43) do
        if string.find(v45, "_TweenProperty") then
            v44[string.split(v45, "_")[1]] = v46
        end
    end
    print(v44)
    if u24:IsA("Model") then
        for _, v47 in pairs(u24:GetChildren()) do
            if v47.Name ~= "End" then
                u23(v47, v26, v44, u24)
            end
        end
    elseif u24:IsA("BasePart") then
        u23(u24, v26, v44)
    else
        error("Mesh Type not supported")
    end
end
return v1