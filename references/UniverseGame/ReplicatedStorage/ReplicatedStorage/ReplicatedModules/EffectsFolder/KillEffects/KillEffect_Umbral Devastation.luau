  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v6 = AssetHandler.CloneAsset("Umbral Devastation/Sword", {
        AbilityName = "KillEffects"
    }):Clone();
    local SwordHandle = v6.SwordHandle;
    SwordHandle.Anchored = true;
    v6:ScaleTo(5);
    local v7 = CFrame2 + Vector3.new(0, 57.5, 0);
    SwordHandle.CFrame = v7;
    v6.Parent = workspace.Effects;
    local v8 = AssetHandler.CloneAsset("Umbral Devastation/Devastation_SwordSummon", {
        AbilityName = "KillEffects"
    });
    v8.Anchored = true;
    v8.CFrame = v7 + Vector3.new(0, -25, 0);
    v8.Parent = workspace.Effects;
    ParticleHandler.EmitFromAttribute(v8);
    ParticleHandler.DestroyByMaxLifetime(v8);
    EffectsHandler.Wait(0.95);

    local function GroundImpactVFX() -- Line: 58
        -- upvalues: AssetHandler (ref), CFrame2 (copy), ParticleHandler (ref)
        local v9 = AssetHandler.CloneAsset("Umbral Devastation/Devastation_SwordImpact", {
            AbilityName = "KillEffects"
        });
        v9.Anchored = true;
        v9.CFrame = CFrame2 + Vector3.new(0, -2.5, 0);
        v9.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v9);
        ParticleHandler.DestroyByMaxLifetime(v9);
    end;

    local function TweenAndClean(p10, p11) -- Line: 69
        p10:Play();
        p10.Completed:Wait();

        if p11 then
            p11:Destroy();
        end;
    end;

    local v12 = TweenService:Create(SwordHandle, TweenInfo.new(0.1), {
        CFrame = CFrame2 + Vector3.new(0, 26, 0)
    });
    v12:Play();
    v12.Completed:Wait();
    GroundImpactVFX();
    local v13 = TweenService:Create(SwordHandle, TweenInfo.new(2), {
        CFrame = CFrame2 + Vector3.new(0, 12.5, 0)
    });
    v13:Play();
    v13.Completed:Wait();
    local v14 = TweenService:Create(SwordHandle, TweenInfo.new(0.25), {
        CFrame = CFrame2 + Vector3.new(0, -7.5, 0)
    });
    GroundImpactVFX();
    v14:Play();
    v14.Completed:Wait();

    if v6 then
        v6:Destroy();
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;