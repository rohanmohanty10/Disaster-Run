  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local Debris = game:GetService("Debris");

return function(p2) -- Line: 3
    -- upvalues: u1 (copy), Debris (copy)
    local HumanoidRootPart = p2.HumanoidRootPart;
    local _ = p2.Humanoid;
    local v3 = u1.Universal.DashVFX_1:Clone();
    v3.CFrame = HumanoidRootPart.CFrame;
    v3.Parent = workspace.Effects;
    Debris:AddItem(v3, 1.5);
    local v4 = {
        front = HumanoidRootPart.CFrame * CFrame.Angles(0, 0, 0),
        left = HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0),
        back = HumanoidRootPart.CFrame * CFrame.Angles(0, 0, 0),
        right = HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0)
    };
    local v5 = p2:GetAttribute("Direction");

    if v5 and v4[v5] then
        v3.CFrame = v4[v5];
    end;

    for _, child in pairs(v3:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child:Emit(child:GetAttribute("EmitCount"));
        end;
    end;
end;