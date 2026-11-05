  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local _ = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local Folder = Instance.new("Folder");
    Folder.Name = "_ref";
    Folder.Parent = workspace.Effects;
    task.delay(1.25, Folder.Destroy, Folder);
    EffectsHandler.CallEffect("Tusk_Wormhole", {
        Segments = 30,
        Radius = 2.25,
        TransitionIn = 0.1,
        TransitionOut = 0.3,
        Reference = Folder,
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.6, 0),
        Character = TargetCharacter,
        SpawnSound = AssetHandler.GetAsset("Wormhole/Spawn", {
            AbilityName = "KillEffects"
        }),
        DespawnSound = AssetHandler.GetAsset("Wormhole/Despawn", {
            AbilityName = "KillEffects"
        }),
        LoopSound = AssetHandler.GetAsset("Wormhole/Despawn", {
            AbilityName = "KillEffects"
        })
    });
    task.delay(0.5, function() -- Line: 50
        -- upvalues: TweenService (ref), HumanoidRootPart (copy)
        TweenService:Create(HumanoidRootPart, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -6.5, 0)
        }):Play();
    end);
end;