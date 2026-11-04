 
 

local u1 = {};
game:GetService("SoundService");
local Debris = game:GetService("Debris");
local workspace_Effects = workspace.Effects;

function u1.PlaySound(p2: table, p3: userdata, p4: userdata, p5: table) -- Line: 19
    if p3:IsA("Sound") then
        local v6 = p5 or {};
        local u7 = p3:Clone();
        u7.Volume = v6.Volume or u7.Volume;
        u7.RollOffMode = v6.RollOffMode or u7.RollOffMode;
        u7.RollOffMinDistance = v6.MinDistance or u7.RollOffMinDistance;
        u7.RollOffMaxDistance = v6.MaxDistance or u7.RollOffMaxDistance;
        u7.Parent = p4;
        u7:Play();
        u7.Ended:Connect(function() -- Line: 31
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);

        return u7;
    end;
end;

function u1.PlaySoundAtPosition(p8: table, p9: userdata, p10: vector, p11: table) -- Line: 38
    -- upvalues: workspace_Effects (copy), u1 (copy), Debris (copy)
    if p9:IsA("Sound") then
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.Transparency = 1;
        Part.Size = Vector3.new(0.1, 0.1, 1);
        Part.Position = p10;
        Part.Parent = workspace_Effects;
        local v12 = u1:PlaySound(p9, Part, p11);
        Debris:AddItem(Part, 5);

        return v12;
    end;
end;

return u1;