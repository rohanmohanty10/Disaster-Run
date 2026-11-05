  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Trove = require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
game:GetService("Players");
game:GetService("RunService");

local function Lerp(p1, p2, p3) -- Line: 15
    return p1 + (p2 - p1) * p3;
end;

local _ = CFrame.Angles;
local _ = math.rad;
local Petal = _G.Petal;
Petal("New");
local u4 = Petal("Util");
Petal("Extensions");

return function(p5, u6) -- Line: 32
    -- upvalues: Trove (copy), ParticleHandler (copy), u4 (copy)
    if not p5.Parent then
        warn("No character");

        return;
    end;

    local v7 = Trove.new();
    v7:AttachToInstance(p5);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    local v8 = Color3.fromRGB(218, 35, 35);
    local v9 = ParticleHandler.GetUnusualHSVData({
        Character = p5
    });

    if v9 then
        v8 = ParticleHandler.HSVShift(v8, v9);
    end;

    ColorCorrectionEffect.Parent = game:GetService("Lighting");
    v7:Add(function() -- Line: 48, Name: Cleanup
        -- upvalues: u4 (ref), ColorCorrectionEffect (copy), u6 (copy)
        u4.Tween(ColorCorrectionEffect, u6.TransitionOut, "Sine", "InOut", {
            Brightness = 0,
            Saturation = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        task.delay(u6.TransitionOut, function() -- Line: 55
            -- upvalues: ColorCorrectionEffect (ref)
            ColorCorrectionEffect:Destroy();
        end);
    end);
    u4.Tween(ColorCorrectionEffect, u6.TransitionIn, "Sine", "InOut", {
        Brightness = -0.3,
        Saturation = 0.6,
        Contrast = 0.2,
        TintColor = v8
    });
    task.wait(u6.TransitionIn);
    task.wait(u6.Duration);
    v7:Destroy();
end;