  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1) -- Line: 12
    -- upvalues: Trove (copy), TweenService (copy)
    if not p1 then
        return;
    end;

    local u2 = Trove.new();
    u2:AttachToInstance(p1);
    local v3 = u2:Construct(Instance, "ColorCorrectionEffect");
    v3.Parent = game:GetService("Lighting");
    local u4 = TweenService:Create(v3, TweenInfo.new(0.675, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Brightness = -0.5,
        Saturation = -0.15
    });
    local u5 = TweenService:Create(v3, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Brightness = 0.825,
        Saturation = 1,
        Contrast = 0.275
    });
    local u6 = TweenService:Create(v3, TweenInfo.new(0.325, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0
    });
    u4:Play();
    u2:Connect(p1:GetAttributeChangedSignal("Awakening"), function() -- Line: 36
        -- upvalues: u4 (copy), u5 (copy), u6 (copy), u2 (copy)
        u4:Cancel();
        u5:Play();
        u5.Completed:Once(function() -- Line: 39
            -- upvalues: u6 (ref), u2 (ref)
            u6:Play();
            u6.Completed:Once(function() -- Line: 41
                -- upvalues: u2 (ref)
                u2:Destroy();
            end);
        end);
    end);
end;