 

return function(p1, p2) --[[ Name: SafeAnim, Line 14 ]]
    if p1:IsA("Humanoid") then
        p1 = p1:FindFirstChildOfClass("Animator")
        if not p1 then
            return nil
        end
    elseif not (p1:IsA("Animator") or p1:IsA("AnimationController")) then
        return nil
    end
    local u3 = p1:LoadAnimation(p2)
    u3.Stopped:Once(function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3:Destroy()
    end)
    return u3
end