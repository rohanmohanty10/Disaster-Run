  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local Character = p1.Character;

    if Character == nil then
        return;
    end;

    local u2 = AssetHandler.CloneAsset("Particles/IceStampede/Cloud", {
        AbilityName = "Candy Cutlass",
        SkinName = p1.SkinName
    });
    ParticleHandler.Unusualify(u2, {
        HSVData = p1.HSVData
    });

    if p1.HSVData and p1.HSVData.Chroma then
        ParticleHandler.Chromaify(u2, {
            Character = Character
        });
    end;

    u2.Parent = workspace.Effects;
    u2:MoveTo(Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.9, 0).Position);
    u2.CloudVFX.Size = Vector3.new();

    if not p1.IgnoreSFX then
        u2.CloudVFX.SFX:Play();
    end;

    TweenService:Create(u2.CloudVFX, TweenInfo.new(0.25, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = Vector3.new(64.249, 33.737, 54.325)
    }):Play();
    task.delay(0.02, function() -- Line: 32
        -- upvalues: u2 (copy), ParticleHandler (ref)
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "GroundSlam" then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        ParticleHandler.Emit(u2.CloudVFX.Emit, ParticleHandler.GenerateEmitInfo(u2.CloudVFX.Emit));
    end);
    task.delay(0.25, function() -- Line: 42
        -- upvalues: u2 (copy)
        for _, descendant in u2:GetDescendants() do
            if descendant.Parent.Name ~= "Desummon" and (descendant.Parent.Name ~= "GroundSlam" and (descendant.Parent.Name ~= "Emit" and descendant:IsA("ParticleEmitter"))) then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.25, function() -- Line: 52
        -- upvalues: u2 (copy), ParticleHandler (ref), TweenService (ref)
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        ParticleHandler.Emit(u2.CloudVFX.Desummon, ParticleHandler.GenerateEmitInfo(u2.CloudVFX.Desummon));
        TweenService:Create(u2.CloudVFX, TweenInfo.new(0.25, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {
            Size = Vector3.new()
        }):Play();
        task.delay(3.5, u2.Destroy, u2);
    end);
end;