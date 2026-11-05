  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1) -- Line: 11
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local Player = p1.Player;
    local Character = p1.Character;
    local v2 = p1.Offset or CFrame.new(0, 1.4, -1.8) * CFrame.Angles(0, 3.141592653589793, 3.141592653589793);

    if not (Character and Character:GetAttribute("FireBeamActive")) then
        return;
    end;

    local v3 = Trove.new();
    local v4 = v3:Clone(AssetHandler.GetAsset("Particles/InfernoBeam/Beam", {
        AbilityName = "Dragon Knight",
        SkinName = p1.SkinName
    }));
    v4.Parent = workspace.Effects;
    local v5 = 0;

    if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
        v5 = v5 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v5 > 0 then
        ParticleHandler.HSVShiftParticles(v4, {
            HueShift = v5
        });
    end;

    local v6 = v3:Construct(Instance, "Weld");
    v6.Parent = Character.HumanoidRootPart;
    v6.Part0 = Character.HumanoidRootPart;
    v6.Part1 = v4;
    v6.C0 = v2;
    ParticleHandler.EnableAllParticles(v4, true);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/InfernoBeam/Shoot",
        AutoSerialize = true,
        AbilityName = "Dragon Knight",
        AttachTo = {
            Part = v4,
            Offset = CFrame.Angles(0, -3.141592653589793, 0)
        },
        SkinName = p1.SkinName,
        Player = Player
    });

    repeat
        task.wait();
    until not (Character:GetAttribute("FireBeamActive") and Character.Parent);

    local v7 = next;
    local v8, v9 = v4:GetChildren();

    for _, v in v7, v8, v9 do
        if v:IsA("BasePart") then
            v.Anchored = true;
        end;
    end;

    v6.Part1 = nil;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/InfernoBeam/Disappear",
        AutoSerialize = true,
        PlaySounds = true,
        Origin = v4.CFrame * CFrame.new(0.606, -0.062, 12.699),
        Player = Player
    });
    local v10 = ParticleHandler.EnableAllParticles(v4, false);
    task.wait(v10);
    v3:Destroy();
end;