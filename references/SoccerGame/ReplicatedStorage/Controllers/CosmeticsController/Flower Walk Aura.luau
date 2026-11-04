  

local v1 = {};
local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(p2, p3) -- Line: 11
    -- upvalues: CollectionService (copy), RunService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local u4 = p2:FindFirstChildWhichIsA("Humanoid");

    if not (HumanoidRootPart and u4) then
        return;
    end;

    local u5 = script.FlowerPop:Clone();
    u5.CanCollide = false;
    u5.Massless = true;
    u5.Anchored = false;
    u5.Transparency = 1;
    u5.Parent = p2;
    u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -HumanoidRootPart.Size.Y - 1, 0);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = u5;
    WeldConstraint.Parent = u5;

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    local u6 = 0;
    local u8 = RunService.Heartbeat:Connect(function() -- Line: 40
        -- upvalues: HumanoidRootPart (copy), u4 (copy), u6 (ref), u5 (copy)
        if not (HumanoidRootPart and HumanoidRootPart.Parent) then
            stepConnection:Disconnect();

            return;
        end;

        if u4.MoveDirection.Magnitude < 0.1 then
            return;
        end;

        local Magnitude = (HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;

        if Magnitude < 1 then
            return;
        end;

        local v7 = tick();

        if (Magnitude > 20 and 0.25 or 0.45) <= v7 - u6 then
            u6 = v7;

            for _, descendant in u5:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 3);
                end;
            end;
        end;
    end);
    CollectionService:GetInstanceRemovedSignal((`Cosmetic{p3}`)):Once(function() -- Line: 66
        -- upvalues: u8 (copy)
        u8:Disconnect();
    end);
end;

return v1;