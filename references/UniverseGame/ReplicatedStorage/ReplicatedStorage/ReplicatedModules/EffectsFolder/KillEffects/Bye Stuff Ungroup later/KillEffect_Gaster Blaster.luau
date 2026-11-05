  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local u2 = AssetHandler.CloneAsset("Gaster Blaster/Blaster", {
        AbilityName = "KillEffects"
    });
    u2.RootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 15, -20);
    u2.RootPart.CFrame = CFrame.new(u2.RootPart.Position, HumanoidRootPart.Position) * CFrame.Angles(0, 3.141592653589793, 0);
    u2.Parent = workspace.Effects;
    task.delay(1.9, u2.Destroy, u2);
    u2.AnimationController:LoadAnimation(u2.Animation):Play();
    u2.Cend.blaster:Play();
    TweenService:Create(u2.Cend.at.pl, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Brightness = 4
    }):Play();
    u2.Head.Transparency = 0;
    u2.Jaw.Transparency = 0;
    u2.Head.at1.pe.Enabled = true;
    u2.Head.at2.pe.Enabled = true;
    u2.Cend.at.Core.Enabled = true;
    u2.Cend.at.Absorb.Enabled = true;
    task.delay(0.75, function() -- Line: 41
        -- upvalues: TweenService (ref), u2 (copy), EffectsHandler (ref), AssetHandler (ref), TargetCharacter (copy)
        TweenService:Create(u2.Cend.at.pl, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Brightness = 32
        }):Play();
        EffectsHandler.Wait();
        TweenService:Create(u2.Cend.at.pl, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Brightness = 0
        }):Play();
        local v3 = AssetHandler.CloneAsset("Gaster Blaster/Laser", {
            AbilityName = "KillEffects"
        });
        v3.CFrame = u2.RootPart.CFrame * CFrame.new(0, -2, v3.Size.X / 2) * CFrame.Angles(0, 1.5707963267948966, 0);
        v3.Parent = workspace.Effects;
        u2.Cend.at.Core.Enabled = false;
        u2.Cend.at.Absorb.Enabled = false;
        u2.Cend.at.exp:Emit(10);
        task.delay(0.5, v3.Destroy, v3);
        EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
        TweenService:Create(v3, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = Vector3.new(2048, 0, 0)
        }):Play();
        TweenService:Create(v3.at1.b1, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Width0 = 0,
            Width1 = 0
        }):Play();
        TweenService:Create(v3.at1.b2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Width0 = 0,
            Width1 = 0
        }):Play();
    end);
end;