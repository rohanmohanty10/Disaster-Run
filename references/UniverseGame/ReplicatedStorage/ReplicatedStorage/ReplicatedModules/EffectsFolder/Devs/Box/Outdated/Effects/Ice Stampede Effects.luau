  

 

local Debris = game:GetService("Debris");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy)
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart;
        p2:FindFirstChild("Humanoid");
    else
        v3 = nil;
    end;

    local v4 = u1["Candy Cutlass"]["Ice Stampede"].SlamEffect.Beam:Clone();
    v4.CFrame = v3.CFrame * CFrame.new(0, -80, 0);
    v4.Parent = workspace.Effects;
    Debris:AddItem(v4, 1);
    TweenService:Create(v4, TweenInfo.new(0.2), {
        Size = Vector3.new(0, 400, 0)
    }):Play();
    local v5 = u1["Candy Cutlass"]["Ice Stampede"].SlamEffect.Orb:Clone();
    v5.CFrame = v3.CFrame * CFrame.new(0, -3, 0);
    v5.Parent = workspace.Effects;
    Debris:AddItem(v5, 1);
    TweenService:Create(v5, TweenInfo.new(0.375), {
        Transparency = 1
    }):Play();
    TweenService:Create(v5, TweenInfo.new(1), {
        Size = v5.Size + Vector3.new(100, 100, 100)
    }):Play();
    local v6 = u1["Candy Cutlass"]["Ice Stampede"].SlamEffect.Smoke:Clone();
    v6.CFrame = v3.CFrame * CFrame.new(0, -2, 0);
    v6.Parent = workspace.Effects;
    Debris:AddItem(v6, 1.5);

    for _, descendant in pairs(v6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Lines" then
            descendant:Emit(600);
        end;
    end;

    for i = 1, 8 do
        local v7 = 0.7853981633974483 * i;
        local v8 = math.cos(v7) * 18;
        local v9 = math.sin(v7) * 18;
        local v10 = u1["Candy Cutlass"]["Ice Stampede"].SlamEffect.ExtraOrb:Clone();
        v10.CFrame = v3.CFrame * CFrame.new(v8, -1, v9);
        v10.Name = "DebrisPart" .. i;
        v10.Parent = workspace.Effects;
        Debris:AddItem(v10, 1);
        TweenService:Create(v10, TweenInfo.new(0.2), {
            Transparency = 1
        }):Play();
        TweenService:Create(v10, TweenInfo.new(0.5), {
            Size = v10.Size + Vector3.new(20, 20, 20)
        }):Play();
    end;
end;