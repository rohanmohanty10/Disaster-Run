  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local setCFrame = p1.setCFrame;
    local v2 = p1.Speed or 0.2;
    local v3 = p1.Size or 15;
    local v4 = p1.Lifetime or 1;
    local _ = p1.Punch or false;
    local v5 = p1.Aura or false;
    local v6 = ReplicatedStorage["Client Assets"].Tusk.Wormhole:Clone();
    game.Debris:AddItem(v6, v2 * 2 + v4);
    v6.CFrame = setCFrame * CFrame.Angles(1.5707963267948966, 0, 0);
    v6.Size = Vector3.new(0.05, 0.05, 0.05);
    v6.Parent = workspace.Effects;

    if v5 then
        for _, child in pairs(v6:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child:Emit(11);
            end;
        end;
    end;

    TweenService:Create(v6, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = Vector3.new(1, 0.05, 1) * v3
    }):Play();
    TweenService:Create(v6, TweenInfo.new(v2 * 2 + v4, Enum.EasingStyle.Linear), {
        CFrame = v6.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
    }):Play();
    wait(v2);
    wait(v4);
    TweenService:Create(v6, TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = Vector3.new(0.05, 0.05, 0.05)
    }):Play();
end;