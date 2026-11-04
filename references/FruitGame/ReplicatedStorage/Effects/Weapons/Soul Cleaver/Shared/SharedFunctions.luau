 

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
function v1.PlayTween(p4) --[[ Line: 14 ]]
    p4:Play()
    p4:Destroy()
end
function v1.Emit(p5) --[[ Line: 19 ]]
    for _, u6 in p5:GetDescendants() do
        if u6:IsA("ParticleEmitter") then
            if u6:GetAttribute("EmitDelay") then
                task.delay(u6:GetAttribute("EmitDelay"), function() --[[ Line: 23 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    u6:Emit(u6:GetAttribute("EmitCount") or 3)
                end)
            else
                u6:Emit(u6:GetAttribute("EmitCount") or 3)
            end
        end
    end
end
return v1