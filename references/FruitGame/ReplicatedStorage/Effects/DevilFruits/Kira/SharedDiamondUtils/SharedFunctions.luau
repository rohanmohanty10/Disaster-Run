 

local v1 = {}
game:GetService("RunService")
local _ = game.Players.LocalPlayer
function v1.AddObject(u2, p3) --[[ Line: 6 ]]
    task.delay(p3, function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u2 and u2.Parent then
            u2:Destroy()
        end
    end)
end
function v1.EmitAllParticles(p4) --[[ Line: 14 ]]
    for _, u5 in pairs(p4:GetDescendants()) do
        if u5:IsA("ParticleEmitter") then
            if u5:GetAttribute("EmitDelay") then
                task.delay(u5:GetAttribute("EmitDelay"), function() --[[ Line: 18 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                    --]]
                    u5:Emit(u5:GetAttribute("EmitCount"))
                end)
            else
                u5:Emit(u5:GetAttribute("EmitCount"))
            end
        end
    end
end
return v1