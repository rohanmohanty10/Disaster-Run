 

game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
BoatTween = _G.tween
return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 23 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) == false then
            return
        else
            Random.new()
            local v3 = p1:GetAttribute("Blocking")
            if not p2 or game.Players.LocalPlayer ~= p2 then
                local v4 = p1.PrimaryPart
                local v5 = p1:FindFirstChild("PhoenixFullForm")
                local v6 = p1:FindFirstChild("Humanoid")
                p1:FindFirstChild("UpperTorso")
                local v7 = p1:FindFirstChild("CharacterEffects")
                v7:FindFirstChild("Transformation")
                local u8
                if v5.Body.Transparency == 0 then
                    u8 = v5.AnimationController.Animator:LoadAnimation(script.Parent.Anims.Full.Thistle)
                else
                    u8 = v6.Animator:LoadAnimation(script.Parent.Anims.Hybrid.Thistle)
                end
                if v3 then
                    if v3 then
                        local u9 = v7:FindFirstChild("Immortal Thistle")
                        u9.Parent = workspace.Effects
                        task.delay(0.15, function() --[[ Line: 129 ]]
                            --[[
                            Upvalues:
                                [1] = u9
                            --]]
                            Emit(u9:GetDescendants(), false)
                        end)
                        for _, v10 in u9:GetDescendants() do
                            if v10:IsA("ParticleEmitter") then
                                BoatTween(v10, { 0.45, "EntranceExpressive", "InOut" }, {
                                    ["Transparency"] = NumberSequence.new(1),
                                    ["Speed"] = NumberRange.new(0)
                                })
                            end
                        end
                        Ess.Destroy(u9, 0.45)
                    end
                else
                    u8:Play()
                    local v11 = script["Immortal Thistle"]:Clone()
                    v11.Parent = v7
                    Emit(v11:GetDescendants(), false)
                    v11.Hold.RigidConstraint.Attachment1 = v4.RootRigAttachment
                    tick()
                    tick()
                    v11.AncestryChanged:Once(function() --[[ Line: 116 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                        --]]
                        u8:Stop()
                    end)
                end
            end
        end
    end
}