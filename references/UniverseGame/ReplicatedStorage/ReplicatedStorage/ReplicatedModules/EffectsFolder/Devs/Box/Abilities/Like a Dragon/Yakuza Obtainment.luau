  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.KnitPath.Trove);
local _ = game:GetService("Players").LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: TweenService (copy), Sequence_V2 (copy)
    local v2 = p1.AbilityName or "Dragon";
    local Room = p1.CutsceneRoom.Room;
    local v3 = nil;
    game.Lighting.DefaultColorCorrection.Enabled = false;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "RevelationCCE";
    ColorCorrectionEffect.TintColor = Color3.fromRGB(208, 241, 255);
    ColorCorrectionEffect.Saturation = -1;
    ColorCorrectionEffect.Contrast = 0;
    ColorCorrectionEffect.Parent = game.Lighting;

    local function SetRoomColor(p4) -- Line: 34
        -- upvalues: Room (copy)
        for _, child in Room:GetChildren() do
            if child:IsA("BasePart") then
                child.Color = p4 or Color3.fromRGB();
            end;
        end;
    end;

    local function SetLighting(p5) -- Line: 42
        -- upvalues: ColorCorrectionEffect (copy), SetRoomColor (copy)
        if not p5 then
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255);
            game.Lighting.EnvironmentDiffuseScale = 0;
            game.Lighting.EnvironmentSpecularScale = 0;
            game.Lighting.Atmosphere.Density = 0;

            return;
        end;

        ColorCorrectionEffect:Destroy();
        SetRoomColor();
        game.Lighting.Ambient = Color3.fromRGB(85, 81, 70);
        game.Lighting.EnvironmentDiffuseScale = 1;
        game.Lighting.EnvironmentSpecularScale = 1;
        game.Lighting.Atmosphere.Density = 0.255;
    end;

    local v6;

    if v2 == "Dragon" then
        v6 = {
            { 0, function(p7, p8, p9) -- Line: 61
                    -- upvalues: SetLighting (copy), TweenService (ref), ColorCorrectionEffect (copy)
                    SetLighting();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35), {
                        Brightness = 2
                    }):Play();
                    task.delay(0.35, function() -- Line: 65
                        -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35), {
                            Brightness = 0
                        }):Play();
                    end);
                end },
            { 690, function(p10, p11, p12) -- Line: 70
                    -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), SetRoomColor (copy)
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Contrast = 1
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Brightness = 2
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    task.delay(0.2, function() -- Line: 75
                        -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
                            Brightness = 0
                        }):Play();
                    end);
                    SetRoomColor(Color3.fromRGB(255, 255, 255));
                end },
            { 937, function(p13, p14, p15) -- Line: 82
                    -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), SetRoomColor (copy)
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Contrast = 0
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Brightness = 0
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        TintColor = Color3.fromRGB(208, 241, 255)
                    }):Play();
                    SetRoomColor();
                end },
            { 1389, function(p16, p17, p18) -- Line: 90
                    -- upvalues: ColorCorrectionEffect (copy), SetRoomColor (copy)
                    ColorCorrectionEffect:Destroy();
                    SetRoomColor();
                    game.Lighting.Ambient = Color3.fromRGB(85, 81, 70);
                    game.Lighting.EnvironmentDiffuseScale = 1;
                    game.Lighting.EnvironmentSpecularScale = 1;
                    game.Lighting.Atmosphere.Density = 0.255;
                end }
        };
    else
        v6 = v2 == "Mad Dog" and {
            { 0, function(p19, p20) -- Line: 96
                    -- upvalues: SetLighting (copy), TweenService (ref), ColorCorrectionEffect (copy)
                    SetLighting();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35), {
                        Brightness = 2
                    }):Play();
                    task.delay(0.35, function() -- Line: 100
                        -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35), {
                            Brightness = 0
                        }):Play();
                    end);
                end },
            { 950, function(p21, p22) -- Line: 105
                    -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), SetRoomColor (copy)
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Contrast = 1
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        Brightness = 2
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    task.delay(0.2, function() -- Line: 110
                        -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
                            Brightness = 0
                        }):Play();
                    end);
                    SetRoomColor(Color3.fromRGB(255, 255, 255));
                end },
            { 1194, function(p23, p24, p25) -- Line: 117
                    -- upvalues: ColorCorrectionEffect (copy), SetRoomColor (copy)
                    ColorCorrectionEffect:Destroy();
                    SetRoomColor();
                    game.Lighting.Ambient = Color3.fromRGB(85, 81, 70);
                    game.Lighting.EnvironmentDiffuseScale = 1;
                    game.Lighting.EnvironmentSpecularScale = 1;
                    game.Lighting.Atmosphere.Density = 0.255;
                end }
        } or v3;
    end;

    Sequence_V2.CreateFromOldSequence({
        Frames = v6
    }):Play();
end;