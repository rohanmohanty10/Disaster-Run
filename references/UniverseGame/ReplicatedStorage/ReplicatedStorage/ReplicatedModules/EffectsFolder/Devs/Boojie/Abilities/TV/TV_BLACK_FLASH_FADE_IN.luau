  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 10
    -- upvalues: EffectsHandler (copy)
    EffectsHandler.CallEffect("LM_DOMAIN_END_CC", {
        In = 0.25,
        Out = 0.05,
        Time = 0.4,
        Brightness = 0,
        Contrast = 5,
        Saturation = -1,
        TintColor = Color3.fromRGB(5000, 255, 255),
        StartInfo = { Enum.EasingStyle.Sine, Enum.EasingDirection.In }
    });
end;