  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    local v3 = p2 or {};
    local v4 = v3.Attach or true;
    local v5 = v3.Amount or 10;
    local u6 = v3.Duration or 0.5;
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v7 = ({
        Dust = ReplicatedStorage["Client Assets"].Universal.DustyKur,
        Land = ReplicatedStorage["Client Assets"].Universal.Land,
        LightningDash = ReplicatedStorage["Client Assets"].Universal.LightningDash
    })[v3.Particle]:Clone();

    if not v4 then
        v7.Anchored = true;
        v7.Parent = workspace.Effects;
        v7.CFrame = HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(0, -2.5, 0));

        for _, descendant in pairs(v7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(v5);
            end;
        end;

        game.Debris:AddItem(v7, 5);

        return;
    end;

    local Weld = Instance.new("Weld");
    Weld.C0 = CFrame.new(0, -2.5, 0);
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v7;
    Weld.Parent = v7;
    v7.Anchored = false;
    v7.Parent = workspace.Effects;

    for _, descendant in pairs(v7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 28
                -- upvalues: descendant (copy), u6 (copy)
                descendant.Enabled = true;
                wait(u6);
                descendant.Enabled = false;
            end)();
        end;
    end;

    game.Debris:AddItem(v7, u6 * 2);
end;