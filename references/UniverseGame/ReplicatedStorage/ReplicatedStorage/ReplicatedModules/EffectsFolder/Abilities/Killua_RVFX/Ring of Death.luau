  

 

local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3, p4) -- Line: 9
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    if not p1 then
        return;
    end;

    local v5 = p3 or {};
    local v6 = v5.Duration or 3;
    local u7 = nil;
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local u8 = AssetHandler.CloneAsset("Particles/Ring of Death/RingOfDeathFX", {
        AbilityName = "Killua",
        SkinName = p2
    });

    if v5.HSVData then
        ParticleHandler.Unusualify(u8, {
            IncludeParts = true,
            HSVData = v5.HSVData
        });
    end;

    u8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    u8.Parent = Model;
    Model:ScaleTo(0.05);
    ParticleHandler.EnableAllParticles(u8, true);

    local function Cleanup() -- Line: 32
        -- upvalues: u7 (ref), ParticleHandler (ref), u8 (copy), TweenService (ref), Model (copy)
        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;

        ParticleHandler.EnableParticle(u8, false);
        local v9 = {};

        for _, descendant in u8:GetDescendants() do
            if descendant:IsA("Attachment") then
                table.insert(v9, descendant);
            end;
        end;

        local v10 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local v11 = {};

        for _, v in v9 do
            local v12 = TweenService:Create(v, v10, {
                Position = v.Position + Vector3.new(0, -10, 0)
            });
            table.insert(v11, v12);
            v12:Play();
        end;

        if #v11 > 0 then
            v11[#v11].Completed:Wait();
        end;

        Model:Destroy();
    end;

    while Model:GetScale() < 1 * (v5.Scale or 1) do
        Model:ScaleTo(Model:GetScale() + 0.05);
        task.wait(0.001);
    end;

    local u13 = task.delay(v6, Cleanup);

    if p4 then
        u7 = p4.AncestryChanged:Connect(function() -- Line: 76
            -- upvalues: Cleanup (copy), u13 (copy)
            Cleanup();
            task.cancel(u13);
        end);

        if not p4.Parent then
            Cleanup();
            task.cancel(u13);
        end;
    end;
end;