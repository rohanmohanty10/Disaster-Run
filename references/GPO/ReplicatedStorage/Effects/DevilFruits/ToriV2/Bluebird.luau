 

game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
local u1 = require(script.Full)
local u2 = require(script.Hybrid)
return {
    ["start"] = function(_, u3, p4, u5, u6, u7) --[[ Name: start, Line 13 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if _G.checkRenderDistance(u3.PrimaryPart.Position) == false then
            return
        else
            Random.new()
            u3:FindFirstChild("Humanoid")
            local u8 = u3.PrimaryPart
            local v9 = { -15, 15 }
            local v10 = u3:FindFirstChild("PhoenixFullForm").Body.Transparency == 0
            if p4 == nil then
                _G.PlaySound(u8, script.Parent.Sound.Bluebird.BlueBirdStart, {}, true)
                _G.PlaySound(u8, script.Parent.Sound.Bluebird.BlueBirdLoop, {}).Parent = u8
                u3:GetAttributeChangedSignal("HoldingR"):Once(function() --[[ Line: 44 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    for _, v11 in u8:GetChildren() do
                        if v11:IsA("Sound") and v11.Name:match("BlueBirdLoop") then
                            v11:Stop()
                            v11:Destroy()
                        end
                    end
                end)
                if v10 then
                    u1:start(u3, 0.38)
                else
                    u2:start(u3, 0.38, CFrame.new(), false)
                end
            else
                u2:start(u3, 0.38, CFrame.Angles(0, 0, 0), false, true, u5, u6, u7)
                if v10 == true then
                    for _, u12 in v9 do
                        task.spawn(function() --[[ Line: 33 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u3
                                [3] = u12
                                [4] = u5
                                [5] = u6
                                [6] = u7
                            --]]
                            local v13 = u12
                            u2:start(u3, 0.38, CFrame.Angles(0, math.rad(v13), 0), true, true, u5, u6, u7)
                        end)
                    end
                end
            end
        end
    end
}