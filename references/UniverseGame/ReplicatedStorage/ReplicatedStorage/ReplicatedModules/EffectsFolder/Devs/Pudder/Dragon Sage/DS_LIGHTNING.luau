  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local TeleportLightning = game.ReplicatedStorage["Client Assets"].Assets.Abilities["Dragon Sage"].Particles.General.TeleportLightning;
local u1 = Random.new();

return function(p2) -- Line: 13
    -- upvalues: TeleportLightning (copy), EffectsHandler (copy), u1 (copy), ParticleHandler (copy)
    local v3 = p2.PartCount or {};
    local v4 = p2.Thickness or {};
    local v5 = p2.Radius or {};
    local v6 = p2.Size or {};
    local Player = p2.Player;
    local Character = p2.Character;
    local v7 = p2.Particle or TeleportLightning;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.Position = p2.Attach;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = workspace.Terrain;
    Attachment2.Position = p2.Attach2;
    local v8 = CFrame.lookAt(p2.Attach, p2.Attach2);
    local Magnitude = (p2.Attach - p2.Attach2).Magnitude;

    if not p2.DisableParticles then
        EffectsHandler.CallEffect("Emit Particle V3", {
            MaxRenderDistance = 500,
            Player = Player,
            Character = Character,
            Size = Vector3.new(TeleportLightning.Size.X, TeleportLightning.Size.Y, Magnitude),
            Origin = v8 * CFrame.new(0, 0, -(Magnitude / 2)),
            Particle = v7
        });
    end;

    local v9 = v4.Minimum or 0.85;
    local v10 = v4.Maximum or 1;
    local v11 = v5.Maximum or 1.3;
    local v12 = v5.Minimum or 0.8;
    local v13 = (p2.AnimationSpeed or u1:NextNumber(0, 12)) * 1;
    local v14 = (p2.PulseSpeed or u1:NextNumber(7.5, 8.85)) * 1;
    local v15 = (p2.Lifetime or u1:NextNumber(0.95, 1.4)) / 1;
    local v16 = p2.Curves or { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
    local v17 = p2.Color or ColorSequence.new(Color3.fromRGB(105, 141, 192));
    local v18 = (typeof(v3) == "table" or not v3) and 18 or v3;

    if typeof(v6) == "table" or not v6 then
        v6 = u1:NextNumber(0.15, 0.2);
    end;

    local v19 = Player or Character;
    local v20 = 0;

    if v19 and v19.Data.Skin:GetAttribute("UnusualHueId") then
        v20 = v20 + v19.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if ParticleHandler.IsUnusualValue(v20) == true and not p2.IgnoreUnusuals then
        v17 = ParticleHandler.HSVShift(v17, {
            HueShift = v20
        });
    end;

    local v21 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
        Color = v17,
        Curves = v16,
        Speed = v14,
        Length = v15,
        A1 = Attachment,
        A2 = Attachment2,
        Size = v6,
        PartCount = v18
    });
    v21.MinRadius = v12;
    v21.MaxRadius = v11;
    v21.AnimationSpeed = v13;
    v21.MinThicknessMultiplier = v9;
    v21.MaxThicknessMultiplier = v10;
end;