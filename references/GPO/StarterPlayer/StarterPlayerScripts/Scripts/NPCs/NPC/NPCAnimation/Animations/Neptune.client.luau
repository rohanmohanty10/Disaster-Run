 

local v1 = script.Character.Value:WaitForChild("Humanoid", 5)
if v1 then
    local u2 = v1:LoadAnimation(script.walk)
    local u3 = v1:LoadAnimation(script.idle)
    if not u3.IsPlaying then
        u3:Play()
    end
    v1.Running:Connect(function(p4) --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        if p4 > 0.5 then
            if not u2.IsPlaying then
                u2:Play()
            end
            if u3.IsPlaying then
                u3:Stop()
                return
            end
        else
            if u2.IsPlaying then
                u2:Stop()
            end
            if not u3.IsPlaying then
                u3:Play()
            end
        end
    end)
else
    script:Destroy()
end