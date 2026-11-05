  

 

local Debris = game:GetService("Debris");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), Debris (copy)
    local HumanoidRootPart = p2.HumanoidRootPart;
    local v3 = u1.SMGBloodParticle.MoreBlood:Clone();
    v3.Parent = HumanoidRootPart;
    Debris:AddItem(v3, 1.5);
    v3.Bloodbits:Emit(12);
    v3.Mainblood:Emit(24);
end;