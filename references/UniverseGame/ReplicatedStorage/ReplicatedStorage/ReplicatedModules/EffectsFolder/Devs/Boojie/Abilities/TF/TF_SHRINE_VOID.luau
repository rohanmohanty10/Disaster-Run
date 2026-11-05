  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 12
    -- upvalues: TweenService (copy)
    TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Density = 1,
        Offset = 0.2,
        Glare = 0,
        Haze = 5,
        Color = Color3.new(0, 0, 0),
        Decay = Color3.new(0, 0, 0)
    }):Play();
end;