 
 

game:GetService("ReplicatedStorage");
local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

local function GetReturnTransparency(p2, p3, p4) -- Line: 10
    -- upvalues: u1 (copy)
    return p3.Parent == p2 and table.find(u1, p3.Name) and 0 or (p3.Name == "Handle" and p3.Parent:IsA("Accessory") and 0 or (p3.Name == "face" and p3.Parent.Name == "Head" and 0 or p4));
end;

return function(p5: table) -- Line: 22
    -- upvalues: GetReturnTransparency (copy)
    local v6 = p5.Mode or "Default";
    local Character = p5.Character;
    local v7 = p5.Transparent or 1;
    local u8 = p5.Time or "Invisible";

    for _, descendant in pairs(Character:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            if v6 ~= "Particles" and (v7 > descendant.Transparency and not descendant:GetAttribute("NoTransparencyChange")) then
                local u9 = GetReturnTransparency(Character, descendant, descendant.Transparency);
                descendant.Transparency = v7;

                if typeof(u8) == "number" then
                    task.delay(u8, function() -- Line: 41
                        -- upvalues: descendant (copy), u9 (copy)
                        descendant.Transparency = u9;
                    end);
                elseif typeof(u8) == "string" then
                    task.spawn(function() -- Line: 45
                        -- upvalues: Character (copy), u8 (copy), descendant (copy), u9 (copy)
                        Character:GetAttributeChangedSignal(u8):Wait();
                        descendant.Transparency = u9;
                    end);
                elseif typeof(u8) == "Instance" then
                    task.spawn(function() -- Line: 50
                        -- upvalues: u8 (copy), descendant (copy), u9 (copy)
                        u8:GetPropertyChangedSignal("Parent"):Wait();
                        descendant.Transparency = u9;
                    end);
                end;
            end;
        elseif descendant:IsA("ParticleEmitter") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(v7);

            if typeof(u8) == "number" then
                task.delay(u8, function() -- Line: 62
                    -- upvalues: descendant (copy), Transparency (copy)
                    descendant.Transparency = Transparency;
                end);
            elseif typeof(u8) == "string" then
                task.spawn(function() -- Line: 66
                    -- upvalues: Character (copy), u8 (copy), descendant (copy), Transparency (copy)
                    Character:GetAttributeChangedSignal(u8):Wait();
                    descendant.Transparency = Transparency;
                end);
            elseif typeof(u8) == "Instance" then
                task.spawn(function() -- Line: 71
                    -- upvalues: u8 (copy), descendant (copy), Transparency (copy)
                    u8:GetPropertyChangedSignal("Parent"):Wait();
                    descendant.Transparency = Transparency;
                end);
            end;
        elseif descendant:IsA("SurfaceGui") and v6 ~= "Particles" then
            local Enabled = descendant.Enabled;
            descendant.Enabled = false;

            if typeof(u8) == "number" then
                task.delay(u8, function() -- Line: 86
                    -- upvalues: descendant (copy), Enabled (copy)
                    descendant.Enabled = Enabled;
                end);
            elseif typeof(u8) == "string" then
                task.spawn(function() -- Line: 90
                    -- upvalues: Character (copy), u8 (copy), descendant (copy), Enabled (copy)
                    Character:GetAttributeChangedSignal(u8):Wait();
                    descendant.Enabled = Enabled;
                end);
            elseif typeof(u8) == "Instance" then
                task.spawn(function() -- Line: 95
                    -- upvalues: u8 (copy), descendant (copy), Enabled (copy)
                    u8:GetPropertyChangedSignal("Parent"):Wait();
                    descendant.Enabled = Enabled;
                end);
            end;
        end;
    end;
end;