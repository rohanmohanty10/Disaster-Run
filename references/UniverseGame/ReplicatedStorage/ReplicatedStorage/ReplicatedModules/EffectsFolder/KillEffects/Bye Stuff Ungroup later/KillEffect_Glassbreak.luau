  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
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
    local v2 = AssetHandler.CloneAsset("Shatter/Cracking", {
        AbilityName = "KillEffects"
    });
    v2.CFrame = CFrame2;
    v2.Parent = workspace.Effects;
    TargetCharacter.Archivable = true;
    local v3 = TargetCharacter:Clone();
    v3.Name = TargetCharacter.Name .. "\'s Afterimage";
    v3.Parent = workspace.Effects;
    task.delay(1, v3.Destroy, v3);
    local v4 = { "Model", "LocalScript", "Script", "ModuleScript", "Sound", "HumanoidRootPart", "Folder", "BillboardGui", "SurfaceGui", "ScreenGui", "ParticleEmitter", "Beam", "Trail", "Shirt", "Pants" };

    for _, descendant in v3:GetDescendants() do
        for _, v in v4 do
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

            local function SetProperties(p5) -- Line: 69
                -- upvalues: TweenService (ref)
                if not p5:IsA("BasePart") then
                    return;
                end;

                p5.CanCollide = false;
                p5.CanQuery = false;
                p5.Anchored = true;
                p5.CastShadow = false;
                p5.Size = p5.Size * 1.04;
                p5.Color = Color3.fromRGB(116, 135, 255);
                p5.Material = Enum.Material.Neon;

                if p5:IsA("MeshPart") then
                    p5.TextureID = "";
                end;

                if p5.Transparency < 0.5 then
                    p5.Transparency = 1;
                end;

                local v6 = p5:FindFirstChildOfClass("Decal");

                if v6 then
                    v6:Destroy();
                end;

                TweenService:Create(p5, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Transparency = 0
                }):Play();
            end;

            for _, descendant2 in descendant:GetDescendants() do
                SetProperties(descendant2);
            end;

            SetProperties(descendant);
        end;
    end;

    TargetCharacter.Archivable = false;
    EffectsHandler.Wait(1);
    v2:Destroy();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Shatter/Crack",
        AbilityName = "KillEffects",
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;