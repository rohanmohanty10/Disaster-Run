  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 10
    -- upvalues: EffectsHandler (copy)
    EffectsHandler.CallEffect("Impact Frame", {
        Time = 0.05,
        StartBrightness = 0.75,
        EndBrightness = -0.75,
        Models = p1.Characters or {},
        StartFillColor = Color3.fromRGB(0, 0, 0),
        EndFillColor = Color3.fromRGB(255, 0, 0),
        BackgroundColor = Color3.fromRGB(255, 0, 0)
    });
    EffectsHandler.CallEffect("BoxCameraShake", "LongerExplosion");
end;