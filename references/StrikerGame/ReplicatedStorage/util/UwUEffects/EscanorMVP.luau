 

 

local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);

return {
    [12.4] = function(p1: table) -- Line: 17
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p1.Character, {
            {
                Text = "Lion Sin.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.2
                }
            }
        });
    end,

    [12.366666666666667] = function(p2: table) -- Line: 34
        p2.DepthOfField.FarIntensity = 0.15;
        p2.DepthOfField.FocusDistance = 0;
        p2.DepthOfField.InFocusRadius = 50;
        p2.DepthOfField.NearIntensity = 0;

        for _, descendant in pairs(p2.VFX.StarExplosion2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                local Attribute = descendant:GetAttribute("EmitCount");

                if Attribute then
                    descendant:Emit(Attribute);
                end;
            end;
        end;
    end,

    [6.433333333333334] = function(p3: table) -- Line: 49
        -- upvalues: TweenService (copy)
        TweenService:Create(p3.Vignette, TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), {
            ImageColor3 = Color3.fromRGB(255, 193, 122)
        }):Play();
    end,

    [8.383333333333333] = function(p4: table) -- Line: 52
        p4.Vignette.ImageColor3 = Color3.new();
    end,

    [12.083333333333334] = function(p5: table) -- Line: 55
        -- upvalues: TweenService (copy)
        TweenService:Create(p5.ColorCorrection, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
            Brightness = 1.8,
            Contrast = 2,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 192, 90)
        }):Play();
    end,

    [12.116666666666667] = function(p6: table) -- Line: 58
        -- upvalues: TweenService (copy)
        p6.Vignette.ImageColor3 = Color3.fromRGB(255, 193, 122);
        TweenService:Create(p6.Vignette, TweenInfo.new(3.316666666666667, Enum.EasingStyle.Linear), {
            ImageColor3 = Color3.fromRGB(255, 192, 149)
        }):Play();
    end,

    [12.216666666666667] = function(p7: table) -- Line: 62
        -- upvalues: TweenService (copy)
        TweenService:Create(p7.ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
            Brightness = 2,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 200, 155)
        }):Play();
    end,

    [12.3] = function(p8: table) -- Line: 65
        for _, descendant in pairs(p8.VFX.Specs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [12.283333333333333] = function(p9: table) -- Line: 72
        for _, descendant in pairs(p9.VFX.Par2t:GetDescendants()) do
            if descendant:IsA("SurfaceLight") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [12.616666666666667] = function(p10: table) -- Line: 79
        -- upvalues: TweenService (copy)
        TweenService:Create(p10.ColorCorrection, TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), {
            Brightness = 0.05,
            TintColor = Color3.fromRGB(255, 238, 222)
        }):Play();
    end,

    [12.1] = function(p11: table) -- Line: 82
        for _, descendant in pairs(p11.VFX.Flare2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [10.8] = function(p12: table) -- Line: 89
        p12.ColorCorrection.TintColor = Color3.new();
        p12.ColorCorrection.Brightness = -1;
        p12.ColorCorrection.Contrast = 10;
        p12.ColorCorrection.Saturation = -15;
    end,

    [10.833333333333334] = function(p13: table) -- Line: 95
        p13.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        p13.ColorCorrection.Brightness = 10;
    end,

    [10.866666666666667] = function(p14: table) -- Line: 99
        p14.ColorCorrection.Brightness = 1;
        p14.ColorCorrection.Contrast = -5;
        p14.ColorCorrection.Saturation = 0;
    end,

    [10.9] = function(p15: table) -- Line: 104
        p15.ColorCorrection.Brightness = 0;
        p15.ColorCorrection.Contrast = 2;
        p15.ColorCorrection.Saturation = 0;
    end,

    [10.916666666666666] = function(p16: table) -- Line: 109
        p16.ColorCorrection.Contrast = 0;
    end,

    [10.933333333333334] = function(p17: table) -- Line: 112
        for _, descendant in pairs(p17.VFX.backExplosion:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                local Attribute = descendant:GetAttribute("EmitCount");

                if Attribute then
                    descendant:Emit(Attribute);
                end;
            end;
        end;
    end,

    [8.633333333333333] = function(p18: table) -- Line: 122
        for _, descendant in pairs(p18.VFX.handLight:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [8.416666666666666] = function(p19: table) -- Line: 129
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p19.Character, {
            {
                Text = "I\'m the Seven Deadly Sin\'s Sin of Pride. ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.2
                }
            }
        });
    end,

    [6.45] = function(p20: table) -- Line: 146
        for _, descendant in pairs(p20.VFX.handLight:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [5.35] = function(p21: table) -- Line: 153
        if not p21.Character:FindFirstChildWhichIsA("Shirt") then
            return;
        end;

        p21.Character:FindFirstChildOfClass("Shirt").ShirtTemplate = "rbxassetid://3563200976";
        pcall(game.Destroy, p21.Character.Torso:FindFirstChild("BackDecal"));
    end,

    [0.6166666666666667] = function(p22: table) -- Line: 159
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p22.Character, {
            {
                Text = "You two are not only foolish...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.5
                }
            }
        });
    end,

    [4.05] = function(p23: table) -- Line: 176
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p23.Character, {
            {
                Text = "I\'m the one who stands at the pinnacle of all races.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.2
                }
            }
        });
    end,

    [0.03333333333333333] = function(p24: table) -- Line: 194
        for _, descendant in pairs(p24.VFX.Flare2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2.466666666666667] = function(p25: table) -- Line: 201
        -- upvalues: TekrinnDialogue (copy)
        TekrinnDialogue.Speak(p25.Character, {
            {
                Text = "You\'re also unlucky...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                HigherUp = true,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new()), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 0.2
                }
            }
        });
    end,

    [0.016666666666666666] = function(p26: table) -- Line: 218
        for _, descendant in pairs(p26.VFX.Specs:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0] = function(p27: table) -- Line: 225
        for _, descendant in pairs(p27.VFX.handLight:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(p27.VFX.Par2t:GetDescendants()) do
            if descendant:IsA("SurfaceLight") then
                descendant.Enabled = false;
            end;
        end;
    end
};