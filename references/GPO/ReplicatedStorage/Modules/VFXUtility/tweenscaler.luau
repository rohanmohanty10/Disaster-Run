 

local u1 = game:GetService("Debris")
local u2 = game:GetService("TweenService")
return function(p3, p4, p5) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local u6 = Instance.new("Model", workspace.Effects)
    p3.Parent = u6
    u1:AddItem(u6, 5)
    local u7 = Instance.new("NumberValue", u6)
    u7:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
        --]]
        u6:ScaleTo(u7.Value)
    end)
    u2:Create(u7, p4, {
        ["Value"] = p5
    }):Play()
end