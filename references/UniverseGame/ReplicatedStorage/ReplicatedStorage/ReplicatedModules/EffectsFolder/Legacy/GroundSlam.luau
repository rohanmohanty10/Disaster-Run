  

 

local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), Debris (copy)
    local v5 = type(p3) == "number" and (p3 or 0.5) or nil;
    local v6 = ReplicatedStorage["Client Assets"].Kur.ground:Clone();
    local v7 = (typeof(p1) == "CFrame" and p1 and p1 or (typeof(p1) == "Vector3" and CFrame.new(p1) or p1.CFrame)) * (p2 or CFrame.new());
    v6.Parent = workspace.Effects;
    v6.CFrame = v7;
    v6.Attachment.vroom:Emit(1);
    Debris:AddItem(v6, 1);

    if not v5 then
        local v8 = p4 or 500;
        v6.Particle1:Emit(v8);
        v6.Particle2:Emit(v8);

        return;
    end;

    v6.Particle1.Enabled = true;
    v6.Particle2.Enabled = true;
    wait(v5);
    v6.Particle1.Enabled = false;
    v6.Particle2.Enabled = false;
end;