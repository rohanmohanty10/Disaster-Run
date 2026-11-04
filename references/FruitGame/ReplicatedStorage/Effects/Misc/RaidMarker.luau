 

local v1 = {}
local u2 = {}
function v1.start(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = Instance.new("Color3Value")
    v4.Value = Color3.fromRGB(255, 255, 255)
    v4.Parent = p3
    _G.tween(v4, {
        0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        -1,
        true,
        0
    }, {
        ["Value"] = Color3.fromRGB(255, 0, 0)
    })
    u2[p3] = v4
end
game["Run Service"].Heartbeat:Connect(function() --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for v5, v6 in u2 do
        if v5:IsDescendantOf(game) == true then
            v5.Color = ColorSequence.new(v6.Value)
        else
            u2[v5] = nil
        end
    end
end)
return v1