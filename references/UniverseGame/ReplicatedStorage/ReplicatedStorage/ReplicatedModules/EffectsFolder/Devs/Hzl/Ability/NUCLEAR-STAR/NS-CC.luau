  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2, p3) -- Line: 19
    -- upvalues: Trove (copy), LocalPlayer (copy), TweenService (copy), ParticleHandler (copy)
    if not (u1 and p2) then
        return;
    end;

    local v4 = Trove.new();
    v4:AttachToInstance(p2);
    local Clients = p3.Clients;
    local v5 = p3.Color or Color3.fromRGB(101, 155, 255);
    local v6 = p3.Brightness or 0;
    local v7 = p3.Contrast or 1;
    local v8 = p3.Saturation or 0;

    if table.find(Clients, LocalPlayer) then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = `{LocalPlayer.UserId}'s NS-CC`;
        ColorCorrectionEffect.Parent = game.Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Brightness = v6,
            Contrast = v7,
            Saturation = v8,
            TintColor = ParticleHandler.TryHSVShift(v5, ParticleHandler.GetUnusualHSVData({
                Character = u1
            }))
        }):Play();

        local function CleanupColorCorrection() -- Line: 43
            -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
            if ColorCorrectionEffect and ColorCorrectionEffect.Parent then
                local v9 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                });
                v9:Play();
                v9.Completed:Connect(function() -- Line: 54
                    -- upvalues: ColorCorrectionEffect (ref)
                    if ColorCorrectionEffect then
                        ColorCorrectionEffect:Destroy();
                    end;
                end);
            end;
        end;

        local function InstaKill() -- Line: 62
            -- upvalues: ColorCorrectionEffect (copy)
            if ColorCorrectionEffect and ColorCorrectionEffect.Parent then
                ColorCorrectionEffect:Destroy();
            end;
        end;

        if u1.Parent then
            v4:Connect(u1.AncestryChanged, function() -- Line: 69
                -- upvalues: u1 (copy), ColorCorrectionEffect (copy)
                if not u1.Parent and (ColorCorrectionEffect and ColorCorrectionEffect.Parent) then
                    ColorCorrectionEffect:Destroy();
                end;
            end);
        end;

        v4:Add(CleanupColorCorrection);
    end;
end;