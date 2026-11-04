 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);

return {
    [0] = function(p1) -- Line: 6
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p1.Character.name, {
            {
                Text = "Those ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.15,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 0.2
                }
            },
            {
                Text = "stripped ",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.15,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "of the grace of gold...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.2
                }
            }
        }, 4, "rbxassetid://91298641140914", Color3.new(0.666667, 0, 0));
    end,

    [3.17] = function(p2) -- Line: 46
        (function(p3) -- Line: 51, Name: triggerEffects
            if p3 then
                for _, descendant in ipairs(p3:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Sound")) then
                        task.spawn(function() -- Line: 61
                            -- upvalues: descendant (copy)
                            if not descendant.Parent then
                                return;
                            end;

                            local v4 = descendant:GetAttribute("EmitDelay") or 0;
                            local Attribute = descendant:GetAttribute("EmitDuration");

                            if v4 > 0 then
                                task.wait(v4);
                            end;

                            if not descendant.Parent then
                                return;
                            end;

                            if descendant:IsA("Sound") then
                                descendant:Play();

                                return;
                            end;

                            if descendant:IsA("ParticleEmitter") then
                                local Attribute2 = descendant:GetAttribute("EmitCount");

                                if not Attribute or Attribute <= 0 then
                                    if Attribute2 and Attribute2 > 0 then
                                        descendant:Emit(Attribute2);

                                        return;
                                    end;

                                    descendant:Emit(1);

                                    return;
                                end;

                                descendant.Enabled = true;
                                task.wait(Attribute);

                                if descendant.Parent then
                                    descendant.Enabled = false;
                                end;
                            elseif descendant:IsA("Beam") then
                                local v5 = descendant:Clone();
                                v5.Parent = descendant.Parent;
                                v5.Enabled = true;
                                task.wait((not Attribute or Attribute <= 0) and 0.03 or Attribute);

                                if v5 and v5.Parent then
                                    v5:Destroy();
                                end;
                            end;
                        end);
                    end;
                end;

                return;
            end;

            warn("VFX trigger target not found!");
        end)((p2.Effects:WaitForChild("Right Arm"):WaitForChild("Flames")));
    end,

    [3.73] = function(p6) -- Line: 106
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p6.Character.name, {
            {
                Text = "Shall all meet ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.075,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 0.2
                }
            },
            {
                Text = "death.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.15,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3, "rbxassetid://91298641140914", Color3.new(0.666667, 0, 0));
    end,

    [1.63] = function(p7) -- Line: 134
        (function(p8) -- Line: 139, Name: triggerEffects
            if p8 then
                for _, descendant in ipairs(p8:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Sound")) then
                        task.spawn(function() -- Line: 149
                            -- upvalues: descendant (copy)
                            if not descendant.Parent then
                                return;
                            end;

                            local v9 = descendant:GetAttribute("EmitDelay") or 0;
                            local Attribute = descendant:GetAttribute("EmitDuration");

                            if v9 > 0 then
                                task.wait(v9);
                            end;

                            if not descendant.Parent then
                                return;
                            end;

                            if descendant:IsA("Sound") then
                                descendant:Play();

                                return;
                            end;

                            if descendant:IsA("ParticleEmitter") then
                                local Attribute2 = descendant:GetAttribute("EmitCount");

                                if not Attribute or Attribute <= 0 then
                                    if Attribute2 and Attribute2 > 0 then
                                        descendant:Emit(Attribute2);

                                        return;
                                    end;

                                    descendant:Emit(1);

                                    return;
                                end;

                                descendant.Enabled = true;
                                task.wait(Attribute);

                                if descendant.Parent then
                                    descendant.Enabled = false;
                                end;
                            elseif descendant:IsA("Beam") then
                                local v10 = descendant:Clone();
                                v10.Parent = descendant.Parent;
                                v10.Enabled = true;
                                task.wait((not Attribute or Attribute <= 0) and 0.03 or Attribute);

                                if v10 and v10.Parent then
                                    v10:Destroy();
                                end;
                            end;
                        end);
                    end;
                end;

                return;
            end;

            warn("VFX trigger target not found!");
        end)((p7.Effects:WaitForChild("Right Arm"):WaitForChild("FlamesBlack")));
    end,

    [9.68] = function(p11) -- Line: 194
        (function(p12) -- Line: 199, Name: triggerEffects
            if p12 then
                for _, descendant in ipairs(p12:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Sound")) then
                        task.spawn(function() -- Line: 209
                            -- upvalues: descendant (copy)
                            if not descendant.Parent then
                                return;
                            end;

                            local v13 = descendant:GetAttribute("EmitDelay") or 0;
                            local Attribute = descendant:GetAttribute("EmitDuration");

                            if v13 > 0 then
                                task.wait(v13);
                            end;

                            if not descendant.Parent then
                                return;
                            end;

                            if descendant:IsA("Sound") then
                                descendant:Play();

                                return;
                            end;

                            if descendant:IsA("ParticleEmitter") then
                                local Attribute2 = descendant:GetAttribute("EmitCount");

                                if not Attribute or Attribute <= 0 then
                                    if Attribute2 and Attribute2 > 0 then
                                        descendant:Emit(Attribute2);

                                        return;
                                    end;

                                    descendant:Emit(1);

                                    return;
                                end;

                                descendant.Enabled = true;
                                task.wait(Attribute);

                                if descendant.Parent then
                                    descendant.Enabled = false;
                                end;
                            elseif descendant:IsA("Beam") then
                                local v14 = descendant:Clone();
                                v14.Parent = descendant.Parent;
                                v14.Enabled = true;
                                task.wait((not Attribute or Attribute <= 0) and 0.03 or Attribute);

                                if v14 and v14.Parent then
                                    v14:Destroy();
                                end;
                            end;
                        end);
                    end;
                end;

                return;
            end;

            warn("VFX trigger target not found!");
        end)((p11.Effects:WaitForChild("Right Arm"):WaitForChild("Flames2")));
    end,

    [4.68] = function(p15) -- Line: 254
        (function(p16) -- Line: 259, Name: triggerEffects
            if p16 then
                for _, descendant in ipairs(p16:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Sound")) then
                        task.spawn(function() -- Line: 269
                            -- upvalues: descendant (copy)
                            if not descendant.Parent then
                                return;
                            end;

                            local v17 = descendant:GetAttribute("EmitDelay") or 0;
                            local Attribute = descendant:GetAttribute("EmitDuration");

                            if v17 > 0 then
                                task.wait(v17);
                            end;

                            if not descendant.Parent then
                                return;
                            end;

                            if descendant:IsA("Sound") then
                                descendant:Play();

                                return;
                            end;

                            if descendant:IsA("ParticleEmitter") then
                                local Attribute2 = descendant:GetAttribute("EmitCount");

                                if not Attribute or Attribute <= 0 then
                                    if Attribute2 and Attribute2 > 0 then
                                        descendant:Emit(Attribute2);

                                        return;
                                    end;

                                    descendant:Emit(1);

                                    return;
                                end;

                                descendant.Enabled = true;
                                task.wait(Attribute);

                                if descendant.Parent then
                                    descendant.Enabled = false;
                                end;
                            elseif descendant:IsA("Beam") then
                                local v18 = descendant:Clone();
                                v18.Parent = descendant.Parent;
                                v18.Enabled = true;
                                task.wait((not Attribute or Attribute <= 0) and 0.03 or Attribute);

                                if v18 and v18.Parent then
                                    v18:Destroy();
                                end;
                            end;
                        end);
                    end;
                end;

                return;
            end;

            warn("VFX trigger target not found!");
        end)((p15.Effects:WaitForChild("HumanoidRootPart"):WaitForChild("FlameBig")));
    end,

    [11.467] = function(p19) -- Line: 314
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p19.Character.name, {
            {
                Text = "In the embrace... ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.075,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 0.2
                }
            }
        }, 3, "rbxassetid://91298641140914", Color3.new(0.666667, 0, 0));
    end,

    [12.817] = function(p20) -- Line: 330
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p20.Character.name, {
            {
                Text = "... of ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 0.2
                }
            },
            {
                Text = "my flame.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.1,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.666667, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3, "rbxassetid://91298641140914", Color3.new(0.666667, 0, 0));
    end
};