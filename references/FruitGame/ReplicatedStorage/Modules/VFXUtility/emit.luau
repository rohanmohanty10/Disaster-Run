 

return function(p1) --[[ Line: 1 ]]
    for _, u2 in p1:GetDescendants() do
        if u2:IsA("ParticleEmitter") then
            local v3 = u2:GetAttribute("EmitDelay")
            if v3 then
                task.delay(v3, function() --[[ Line: 8 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    u2:Emit(u2:GetAttribute("EmitCount"))
                end)
            else
                u2:Emit(u2:GetAttribute("EmitCount"))
            end
        end
    end
end