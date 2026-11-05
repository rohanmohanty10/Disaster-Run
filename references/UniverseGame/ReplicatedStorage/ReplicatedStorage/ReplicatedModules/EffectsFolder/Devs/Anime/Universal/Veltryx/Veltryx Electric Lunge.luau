  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 16
    -- upvalues: EffectsHandler (copy), ParticleHandler (copy), u1 (copy)
    local u3 = p2 or {};
    local Origin = u3.Origin;
    local End = u3.End;
    local Player = u3.Player;
    local Character = u3.Character;
    local Magnitude = (Origin.Position - End.Position).Magnitude;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/IncalculableSpeed/Lunge",
        AutoSerialize = true,
        AbilityName = "Veltryx",
        Offset = CFrame.new(0, 0, -Magnitude / 2),
        Origin = Origin,
        Player = Player,
        HSVShift = u3.HSVData
    });
    EffectsHandler.CallEffect("Mesh Emit", {
        Effect = "Lunge Shockwave",
        Origin = Origin * CFrame.new(0, 0, -8)
    });
    EffectsHandler.CallEffect("Mesh Emit", {
        Effect = "Forward Lunge",
        Origin = End * CFrame.new(0, 0, 22)
    });
    local Model = Instance.new("Model");
    Model.Name = "Lightning Container";
    Model.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 0.5;
    Highlight.OutlineColor = ParticleHandler.TryHSVShift(Color3.fromRGB(148, 194, 255), u3.HSVData or ParticleHandler.GetUnusualHSVData({
        Character = Player.Character
    }));
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = Model;
    task.delay(5, Model.Destroy, Model);
    EffectsHandler.CallEffect("Generate Quasiduck Lightning", Character or Player.Character, {
        Speed = 8,
        Size = 2,
        AnimationSpeed = 12,
        PartCount = 18,
        Color = ParticleHandler.TryHSVShift(Color3.fromRGB(105, 141, 192), u3.HSVData or ParticleHandler.GetUnusualHSVData({
            Character = Player.Character
        })),
        CFrames = { Origin, End },
        Length = u1:NextNumber(0.95, 1.4),
        Parent = Model
    });

    for _ = 1, 6 do
        task.delay(u1:NextNumber(0, 0.15), function() -- Line: 72
            -- upvalues: u1 (ref), Magnitude (copy), Origin (copy), EffectsHandler (ref), Character (copy), Player (copy), ParticleHandler (ref), u3 (ref), Model (copy)
            local v4 = Origin * CFrame.new(u1:NextNumber(-9, 9), u1:NextNumber(-3, 5), u1:NextNumber(-Magnitude * 0.85, -Magnitude * 0.37));
            EffectsHandler.CallEffect("Generate Quasiduck Lightning", Character or Player.Character, {
                AnimationSpeed = 14,
                PartCount = 12,
                Color = ParticleHandler.TryHSVShift(Color3.fromRGB(105, 141, 192), u3.HSVData or ParticleHandler.GetUnusualHSVData({
                    Character = Player.Character
                })),
                CFrames = { v4, v4 * CFrame.new(0, 0, u1:NextNumber(-15, -11)) },
                Speed = 1 / (math.random(5, 20) / 75),
                Length = u1:NextNumber(0.55, 0.85),
                Size = u1:NextNumber(0.25, 0.45),
                Parent = Model
            });
        end);
    end;
end;