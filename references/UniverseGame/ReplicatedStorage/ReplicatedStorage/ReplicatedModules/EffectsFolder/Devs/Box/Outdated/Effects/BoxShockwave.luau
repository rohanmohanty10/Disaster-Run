  

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2, p3) -- Line: 4
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy)
    local v4 = p2:IsA("Model") and p2 and p2 or p2.Character;
    local HumanoidRootPart = v4.HumanoidRootPart;
    local _ = v4.Humanoid;
    local v5 = p3.Lifetime or 2;
    local PositionData = p3.PositionData;

    if PositionData and not p3.CFrameData then
        PositionData = PositionData or HumanoidRootPart.Position + Vector3.new(0, 0, 0);
    end;

    local CFrameData = p3.CFrameData;

    if not (CFrameData or p3.PositionData) then
        CFrameData = CFrameData or HumanoidRootPart.CFrame * CFrame.new(0, -2, -15) * CFrame.Angles(0, 0, 0);
    end;

    local v6 = p3.Growth or Vector3.new(60, 0, 60);
    local v7 = p3.GrowthTime or 1;
    local TransparencySpeed = p3.TransparencySpeed;
    local v8 = u1.zaihop.GroundSlamHamma:Clone();
    v8.Parent = workspace.Effects;
    Debris:AddItem(v8, v5);

    if PositionData then
        v8.Position = PositionData;
    end;

    if CFrameData then
        v8.CFrame = CFrameData;
    end;

    TweenService:Create(v8, TweenInfo.new(v7), {
        Size = v6
    }):Play();
    TweenService:Create(v8, TweenInfo.new(TransparencySpeed), {
        Transparency = 1
    }):Play();
end;