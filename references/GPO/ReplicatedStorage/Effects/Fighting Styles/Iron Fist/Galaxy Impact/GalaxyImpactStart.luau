 

local u1 = game:GetService("Lighting")
local v2 = {}
local function u13(p3, p4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u5 = script.Flash.ColorCorrectionIMPACT:Clone()
    u5.Parent = u1
    local u6 = Instance.new("Highlight")
    u6.DepthMode = Enum.HighlightDepthMode.Occluded
    u6.FillColor = Color3.fromRGB(255, 30, 10)
    u6.FillTransparency = 0
    u6.Enabled = true
    u6.OutlineTransparency = 1
    if p4 then
        local v7, v8, v9 = p4:ToHSV()
        local v10 = v8 * 255 + 15
        local v11 = Color3.fromHSV
        local v12 = v10 / 255
        u6.FillColor = v11(v7, math.clamp(v12, 0, 1), v9)
    end
    u6.Parent = workspace
    game:GetService("TweenService"):Create(u6, TweenInfo.new(p3 or 0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        ["FillTransparency"] = -2
    }):Play()
    task.delay(p3 or 0.05, function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
        --]]
        u6:Destroy()
        u5:Destroy()
    end)
end
function v2.start(_, p14, p15) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v16 = p15 or Color3.new(1, 0, 0)
    require(script.InitialPhase):Initialize(p14, v16)
    u13(nil, v16)
    require(script.BallPhase):Initialize(p14, v16)
    u13(nil, v16)
    require(script.PillarPhase):Initialize(p14, v16)
end
return v2