 

local u1 = game:GetService("TweenService")
local function u16(p2, p3, p4, p5) --[[ Line: 10 ]]
    local v6 = p2:GetAttribute(p4 .. "_TweenParams")
    local v7 = {
        { "TweenStyle", p5 },
        { "TweenDirection", Enum.EasingDirection.Out }
    }
    local u8 = {}
    if typeof(v6) == "string" then
        local v9 = { v6:match("(%a+),(%a+)") }
        for v10 = 1, 2 do
            local u11 = v9[v10]
            local v12 = v7[v10]
            local u13 = v12[1]
            local v14 = v12[2]
            if u11 then
                if not pcall(function() --[[ Line: 36 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u13
                        [3] = u11
                    --]]
                    u8[u13] = Enum[u13][u11]
                end) then
                    u8[u13] = v14
                end
            else
                u8[u13] = v14
            end
        end
    else
        for _, v15 in v7 do
            u8[v15[1]] = v15[2]
        end
    end
    return TweenInfo.new(p3, u8.TweenStyle, u8.TweenDirection)
end
return function(p17) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u16
    --]]
    local v18 = p17.Parent:FindFirstChild("End")
    if v18 then
        local v19 = p17:Clone()
        local v20 = p17.Parent
        local v21 = tonumber(v20:GetAttribute("StartTransparency")) or 0
        if v19:IsA("MeshPart") then
            v19.Transparency = v21
        elseif v19:IsA("BasePart") and v19:FindFirstChildOfClass("Decal") then
            v19.Transparency = 1
        end
        v19.Parent = workspace.CurrentCamera
        local v22 = p17.Parent
        local v23 = tonumber(v22:GetAttribute("Duration")) or 0.1
        if v19:FindFirstChildOfClass("Decal") then
            u1:Create(v19, u16(p17.Parent, v23, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = v18.Size,
                ["CFrame"] = v18.CFrame
            }):Play()
        else
            u1:Create(v19, u16(p17.Parent, v23, "Part", Enum.EasingStyle.Cubic), {
                ["Size"] = v18.Size,
                ["CFrame"] = v18.CFrame,
                ["Transparency"] = 1
            }):Play()
        end
        local v24 = v19:FindFirstChildOfClass("SpecialMesh")
        local v25 = v18:FindFirstChildOfClass("SpecialMesh")
        if v24 and v25 then
            u1:Create(v24, u16(p17.Parent, v23, "Mesh", Enum.EasingStyle.Sine), {
                ["Scale"] = v25.Scale
            }):Play()
        end
        local v26 = v19:FindFirstChildOfClass("Decal")
        local v27 = v18:FindFirstChildOfClass("Decal")
        if v26 and v27 then
            v26.Transparency = v21
            u1:Create(v26, u16(p17.Parent, v23, "Decal", Enum.EasingStyle.Cubic), {
                ["Transparency"] = v27.Transparency,
                ["Color3"] = v27.Color3
            }):Play()
        end
        task.delay(v23, v19.Destroy, v19)
    else
        warn("Goal is not defined.")
    end
end