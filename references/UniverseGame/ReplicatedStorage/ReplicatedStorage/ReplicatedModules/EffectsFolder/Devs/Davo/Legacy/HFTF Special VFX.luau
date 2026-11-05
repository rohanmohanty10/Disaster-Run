  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local Debris = game:GetService("Debris");

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy), Debris (copy)
    if p2 and (p2:IsA("BasePart") and p2:IsDescendantOf(workspace)) then
        local v4 = u1["The World"].OVA.Star.Attachment:Clone();
        v4.Parent = p2;
        v4.Position = p3 or v4.Position;
        local v5 = v4:GetChildren();

        for i = 1, #v5 do
            if v5[i]:IsA("ParticleEmitter") then
                v5[i]:Emit(v5[i].Rate);
            end;
        end;

        Debris:AddItem(v4, 1.25);
    end;
end;