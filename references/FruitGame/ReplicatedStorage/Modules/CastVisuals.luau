 

local v1 = {}
local u22 = {
    ["__index"] = {
        ["Hide"] = function(p2) --[[ Name: Hide, Line 13 ]]
            p2.CastOriginPart.Parent = nil
        end,
        ["Raycast"] = function(p3, p4, p5, p6) --[[ Name: Raycast, Line 17 ]]
            local v7 = p3.WorldRoot:Raycast(p4, p5, p6)
            if v7 then
                p3.CastOriginPart.CFrame = CFrame.lookAt(p4, v7.Position)
                p3.LineVisual.Length = v7.Distance - 0.25
                p3.ConeVisual.CFrame = CFrame.new(0, 0, -v7.Distance)
                p3.BoxVisual.Visible = false
                p3.SphereVisual.Visible = false
                p3.CastOriginPart.Parent = p3.WorldRoot:FindFirstChild("Terrain") or p3.WorldRoot
            else
                p3:Hide()
            end
        end,
        ["Blockcast"] = function(p8, p9, p10, p11, p12) --[[ Name: Blockcast, Line 38 ]]
            local v13 = p8.WorldRoot:Blockcast(p9, p10, p11, p12)
            if v13 then
                local v14 = p9.Position + p11.Unit * v13.Distance
                p8.CastOriginPart.CFrame = CFrame.lookAt(p9.Position, v14)
                p8.LineVisual.Length = v13.Distance - 0.25
                p8.ConeVisual.CFrame = CFrame.new(0, 0, -v13.Distance)
                p8.BoxVisual.CFrame = CFrame.new(0, 0, -v13.Distance)
                p8.BoxVisual.Size = p10
                p8.BoxVisual.Visible = true
                p8.SphereVisual.Visible = false
                p8.CastOriginPart.Parent = p8.WorldRoot:FindFirstChild("Terrain") or p8.WorldRoot
            else
                p8:Hide()
            end
        end,
        ["SphereCast"] = function(p15, p16, p17, p18, p19) --[[ Name: SphereCast, Line 64 ]]
            local v20 = p15.WorldRoot:Spherecast(p16, p17, p18, p19)
            if v20 then
                local v21 = p16 + p18.Unit * v20.Distance
                p15.CastOriginPart.CFrame = CFrame.lookAt(p16, v21)
                p15.LineVisual.Length = v20.Distance - 0.25
                p15.ConeVisual.CFrame = CFrame.new(0, 0, -v20.Distance)
                p15.SphereVisual.CFrame = CFrame.new(0, 0, -v20.Distance)
                p15.SphereVisual.Radius = p17
                p15.SphereVisual.Visible = true
                p15.BoxVisual.Visible = false
                p15.CastOriginPart.Parent = p15.WorldRoot:FindFirstChild("Terrain") or p15.WorldRoot
            else
                p15:Hide()
            end
        end
    }
}
function v1.new(p23, p24) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u22
    --]]
    local v25 = {
        ["Color"] = p23 or Color3.new(0, 0, 1),
        ["WorldRoot"] = p24 or workspace
    }
    local v26 = u22
    local v27 = setmetatable(v25, v26)
    local v28 = Instance.new("Part")
    v28.Transparency = 1
    v28.CanCollide = false
    v28.CanQuery = false
    v28.CanTouch = false
    v28.Anchored = true
    v28.Size = Vector3.new(0.01, 0.01, 0.01)
    v27.CastOriginPart = v28
    local v29 = Instance.new("LineHandleAdornment")
    v29.Color3 = v27.Color
    v29.AlwaysOnTop = true
    v29.Transparency = 0.5
    v29.Thickness = 2.5
    v29.ZIndex = 1
    v29.Adornee = v28
    v29.Parent = v28
    v27.LineVisual = v29
    local v30 = Instance.new("ConeHandleAdornment")
    v30.Color3 = v27.Color
    v30.AlwaysOnTop = true
    v30.Transparency = 0.5
    v30.Radius = 0.05
    v30.Height = 0.25
    v30.SizeRelativeOffset = Vector3.new(0, 0, 0.5)
    v30.ZIndex = 1
    v30.Adornee = v28
    v30.Parent = v28
    v27.ConeVisual = v30
    local v31 = Instance.new("BoxHandleAdornment")
    v31.Color3 = v27.Color
    v31.AlwaysOnTop = true
    v31.Transparency = 0.5
    v31.ZIndex = 0
    v31.Adornee = v28
    v31.Parent = v28
    v27.BoxVisual = v31
    local v32 = Instance.new("SphereHandleAdornment")
    v32.Color3 = v27.Color
    v32.AlwaysOnTop = true
    v32.Transparency = 0.5
    v32.ZIndex = 0
    v32.Adornee = v28
    v32.Parent = v28
    v27.SphereVisual = v32
    return v27
end
return v1