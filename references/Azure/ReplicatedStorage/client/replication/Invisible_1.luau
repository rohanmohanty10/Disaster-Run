 
 

game:GetService("ReplicatedStorage");

return function(p1) -- Line: 5
    local Character = p1.Character;
    local v2 = p1.Transparent or 1;
    local u3 = p1.Time or "Invisible";

    for _, descendant in pairs(Character:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            if v2 > descendant.Transparency and not descendant:GetAttribute("NoTransparencyChange") then
                local u4 = tonumber(descendant.Transparency);
                descendant.Transparency = v2;

                if typeof(u3) == "number" then
                    task.delay(u3, function() -- Line: 19
                        -- upvalues: descendant (copy), u4 (copy)
                        descendant.Transparency = u4;
                    end);
                elseif typeof(u3) == "string" then
                    task.spawn(function() -- Line: 23
                        -- upvalues: Character (copy), u3 (copy), descendant (copy), u4 (copy)
                        Character:GetAttributeChangedSignal(u3):Wait();
                        descendant.Transparency = u4;
                    end);
                elseif typeof(u3) == "Instance" then
                    task.spawn(function() -- Line: 28
                        -- upvalues: u3 (copy), descendant (copy), u4 (copy)
                        u3:GetPropertyChangedSignal("Parent"):Wait();
                        descendant.Transparency = u4;
                    end);
                end;
            end;
        elseif descendant:IsA("ParticleEmitter") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(v2);

            if typeof(u3) == "number" then
                task.delay(u3, function() -- Line: 40
                    -- upvalues: descendant (copy), Transparency (copy)
                    descendant.Transparency = Transparency;
                end);
            elseif typeof(u3) == "string" then
                task.spawn(function() -- Line: 44
                    -- upvalues: Character (copy), u3 (copy), descendant (copy), Transparency (copy)
                    Character:GetAttributeChangedSignal(u3):Wait();
                    descendant.Transparency = Transparency;
                end);
            elseif typeof(u3) == "Instance" then
                task.spawn(function() -- Line: 49
                    -- upvalues: u3 (copy), descendant (copy), Transparency (copy)
                    u3:GetPropertyChangedSignal("Parent"):Wait();
                    descendant.Transparency = Transparency;
                end);
            end;
        elseif descendant:IsA("SurfaceGui") then
            local Enabled = descendant.Enabled;
            descendant.Enabled = false;

            if typeof(u3) == "number" then
                task.delay(u3, function() -- Line: 61
                    -- upvalues: descendant (copy), Enabled (copy)
                    descendant.Enabled = Enabled;
                end);
            elseif typeof(u3) == "string" then
                task.spawn(function() -- Line: 65
                    -- upvalues: Character (copy), u3 (copy), descendant (copy), Enabled (copy)
                    Character:GetAttributeChangedSignal(u3):Wait();
                    descendant.Enabled = Enabled;
                end);
            elseif typeof(u3) == "Instance" then
                task.spawn(function() -- Line: 70
                    -- upvalues: u3 (copy), descendant (copy), Enabled (copy)
                    u3:GetPropertyChangedSignal("Parent"):Wait();
                    descendant.Enabled = Enabled;
                end);
            end;
        end;
    end;
end;