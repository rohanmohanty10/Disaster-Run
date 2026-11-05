  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();
local _ = game.Players.LocalPlayer;

return function(p1) -- Line: 17
    -- upvalues: EffectsHandler (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local Start = v2.Start;
    local End = v2.End;
    local v3 = math.ceil((Start - End).Magnitude / 5);

    for i = 1, v3 do
        local v4 = Start:Lerp(End, i / v3);
        EffectsHandler.CallEffect("Kars_Afterimage", {
            Character = Character,
            Origin = CFrame.new(v4, v4 + Character.HumanoidRootPart.CFrame.LookVector) * CFrame.new(0, -0.4, 0)
        });
    end;
end;