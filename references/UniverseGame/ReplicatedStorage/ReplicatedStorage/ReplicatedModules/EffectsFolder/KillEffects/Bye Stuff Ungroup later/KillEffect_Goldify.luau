  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local CFrame2 = TargetCharacter.HumanoidRootPart.CFrame;
    Random.new();
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(CFrame2.Position)
    });
    TargetCharacter.Archivable = true;
    local u2 = TargetCharacter:Clone();
    u2.Name = TargetCharacter.Name .. "\'s Afterimage";
    u2.Parent = workspace.Effects;
    TargetCharacter.AncestryChanged:Connect(function() -- Line: 32
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    local v3 = { "Model", "LocalScript", "Script", "ModuleScript", "Sound", "HumanoidRootPart", "Folder", "BillboardGui", "SurfaceGui", "ScreenGui", "ParticleEmitter", "Beam", "Trail", "Shirt", "Pants" };

    for _, descendant in u2:GetDescendants() do
        for _, v in v3 do
            if descendant.Name == v or descendant.ClassName == v then
                descendant:Destroy();
                break;
            end;
        end;

        if descendant and descendant:IsDescendantOf(game) then
            if descendant:IsA("Humanoid") then
                descendant.DisplayDistanceType = "None";
                descendant.HealthDisplayType = "AlwaysOff";
                descendant.BreakJointsOnDeath = false;
                descendant.EvaluateStateMachine = false;
                descendant.RequiresNeck = false;
                descendant.AutomaticScalingEnabled = false;
            end;

            for _, descendant2 in pairs(descendant:GetDescendants()) do
                if descendant2:IsA("Motor6D") or (descendant2:IsA("Weld") or (descendant2:IsA("ManualWeld") or descendant2:IsA("WeldConstraint"))) then
                    descendant2:Destroy();
                end;
            end;

            if descendant:IsA("Accessory") then
                local descendant = descendant:FindFirstChild("handle") or descendant:FindFirstChild("Handle");
            end;

            local function SetProperties(p4) -- Line: 65
                if not p4:IsA("BasePart") then
                    return;
                end;

                p4.CanCollide = false;
                p4.CanQuery = false;
                p4.Anchored = true;
                p4.CastShadow = false;
                p4.Size = p4.Size * 1.04;
                p4.Color = Color3.fromRGB(229, 187, 76);
                p4.Material = Enum.Material.Metal;

                if p4:IsA("MeshPart") then
                    p4.TextureID = "";
                end;

                local v5 = p4:FindFirstChildOfClass("Decal");

                if v5 then
                    v5:Destroy();
                end;
            end;

            for _, descendant2 in descendant:GetDescendants() do
                SetProperties(descendant2);
            end;

            SetProperties(descendant);
        end;
    end;

    TargetCharacter.Archivable = false;
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter, 0.25);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Goldify/Transform",
        AbilityName = "KillEffects",
        Origin = CFrame2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966)
    });
end;