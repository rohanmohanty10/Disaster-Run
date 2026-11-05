  

 

local u1 = game:GetService("ReplicatedStorage"):FindFirstChild("Client Assets", true);

return function(p2) -- Line: 4
    -- upvalues: u1 (copy)
    for _, child in pairs(u1.Ruined.Equip:GetChildren()) do
        local u3 = child:Clone();
        u3.Parent = p2.PrimaryPart;

        if u3:IsA("ParticleEmitter") then
            u3.Enabled = true;
            task.delay(0.25, function() -- Line: 11
                -- upvalues: u3 (copy)
                u3.Enabled = false;
            end);
        end;

        if #u3:GetChildren() >= 1 then
            coroutine.wrap(function() -- Line: 17
                -- upvalues: u3 (copy)
                for _, descendant in pairs(u3:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                        task.delay(0.25, function() -- Line: 22
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                end;
            end)();
        end;
    end;
end;