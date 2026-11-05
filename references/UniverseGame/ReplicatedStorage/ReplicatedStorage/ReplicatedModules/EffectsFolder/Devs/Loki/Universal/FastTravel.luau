  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);

return function(p1, p2, p3) -- Line: 15
    -- upvalues: AssetHandler (copy), Players (copy), EffectsHandler (copy)
    local v4 = {};

    for _, v in { p2, p3 } do
        local v5 = {
            Name = "Emit Particle V3"
        };
        local v6 = {};
        local v7 = {
            RawPath = true,
            Path = "Universal/Interaction/FastTravel/Teleport",
            AutoSerialize = true
        };
        local v8;

        if typeof(v) == "Vector3" then
            v8 = CFrame.new(v) or v;
        else
            v8 = v;
        end;

        v7.Origin = v8;
        v6[1] = v7;
        v5.Data = v6;
        table.insert(v4, v5);
        local v9 = {
            Name = "Play Sound At"
        };
        local v10 = {};
        local v11 = {
            Object = AssetHandler.GetAsset("Universal/Interaction/FastTravel/Sounds/Teleport")
        };

        if typeof(v) == "Vector3" then
            local v = CFrame.new(v) or v;
        end;

        v11.Origin = v;
        v10[1] = v11;
        v9.Data = v10;
        table.insert(v4, v9);
    end;

    if Players.LocalPlayer == p1 then
        EffectsHandler.CallEffects({ {
                Name = "TedBlur",
                Data = { 20, 0.2 }
            }, {
                Name = "InvertedLighting",
                Data = { 0.2, 0.5 }
            } });
    end;

    EffectsHandler.CallEffects(v4);
end;