  

 

return function(u1, u2) -- Line: 1
    local u3 = u2[3] and { "FHand1", "FrozenBits", "FrozenSnow1" } or { "Hand1", "TrailBits", "TrailAura" };
    local v7 = {
        Left = function() -- Line: 13
            -- upvalues: u2 (copy), u1 (copy), u3 (ref)
            local v4 = u2[2];

            for _, descendant in pairs(u1["Left Arm"]:GetDescendants()) do
                if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and table.find(u3, descendant.Name) then
                    descendant.Enabled = v4;
                end;
            end;
        end,

        Right = function() -- Line: 22
            -- upvalues: u2 (copy), u1 (copy), u3 (ref)
            local v5 = u2[2];

            for _, descendant in pairs(u1["Right Arm"]:GetDescendants()) do
                if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and table.find(u3, descendant.Name) then
                    descendant.Enabled = v5;
                end;
            end;
        end,

        Both = function() -- Line: 31
            -- upvalues: u2 (copy), u1 (copy), u3 (ref)
            local v6 = u2[2];

            for _, descendant in pairs(u1["Left Arm"]:GetDescendants()) do
                if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and table.find(u3, descendant.Name) then
                    descendant.Enabled = v6;
                end;
            end;

            for _, descendant in pairs(u1["Right Arm"]:GetDescendants()) do
                if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and table.find(u3, descendant.Name) then
                    descendant.Enabled = v6;
                end;
            end;
        end
    };

    if v7[u2[1]] then
        v7[u2[1]]();
    end;
end;