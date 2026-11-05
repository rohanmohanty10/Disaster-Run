  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(p1, p2) -- Line: 4
    -- upvalues: TweenService (copy), Debris (copy)
    local v3 = game:GetService("ReplicatedStorage")["Client Assets"].Omnitrix.Shock:Clone();
    v3.Parent = workspace.Effects;
    v3.CFrame = p1.HumanoidRootPart.CFrame;
    local v4 = math.random(0, 360);
    local v5 = math.random(0, 360);
    v3.Orientation = Vector3.new(v4, v5, math.random(0, 360));
    local v6 = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
    local v7 = {
        Transparency = 1,
        Size = Vector3.new(20, 20, 20)
    };
    local Orientation = v3.Orientation;
    local v8 = math.random(-20, 20);
    local v9 = math.rad(v8);
    local v10 = math.random(-20, 20);
    local v11 = math.rad(v10);
    local v12 = math.random(-20, 20);
    local v13 = math.rad(v12);
    v7.Orientation = Orientation + Vector3.new(v9, v11, v13);
    TweenService:Create(v3, v6, v7):Play();
    Debris:AddItem(v3, 1.1);
end;