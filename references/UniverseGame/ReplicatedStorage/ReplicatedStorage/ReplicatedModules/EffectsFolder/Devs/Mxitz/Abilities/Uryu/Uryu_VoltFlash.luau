  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function() -- Line: 5
    -- upvalues: EffectsHandler (copy)
    EffectsHandler.CallEffects({
        {
            Name = "Yuki_Vignette",
            Data = {
                {
                    LifeTime = 0.25,
                    Transparency = 0.75,
                    TweenIn = { 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                    TweenOut = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                    Size = UDim2.fromScale(1.25, 1.25),
                    Color = Color3.new(0.333333, 0.678431, 1)
                }
            }
        },
        {
            Name = "Yuki_DepthOfField",
            Data = {
                {
                    LifeTime = 0,
                    FarIntensity = 0.1,
                    FocusDistance = 0,
                    InFocusRadius = 10,
                    NearIntensity = 0,
                    TweenIn = { 0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                    TweenOut = { 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out }
                }
            }
        },
        {
            Name = "BoxCameraShake",
            Data = { "OldBump" }
        },
        {
            Name = "FOV Modifier",
            Data = {
                {
                    View = 75,
                    TweenInformation = {
                        Speed = 0.15,
                        EasingStyle = Enum.EasingStyle.Sine,
                        EasingDirection = Enum.EasingDirection.Out
                    }
                }
            }
        }
    });
    task.delay(0.35, EffectsHandler.CallEffect, "FOV Modifier", {
        TweenInformation = {
            Speed = 0.25,
            EasingStyle = Enum.EasingStyle.Sine,
            EasingDirection = Enum.EasingDirection.Out
        }
    });
end;