  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("ContentProvider");
local _ = Players.LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.Types);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = Random.new();
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;

local function _(p2, p3) -- Line: 27
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

return function(p4) -- Line: 36
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy)
    if not p4.Reference then
        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(p4.Reference);
    local u6 = AssetHandler.CloneAsset("Universal/Interaction/Lab/Wormhole");

    if not u6 then
        v5:Destroy();

        return;
    end;

    u6.Position = ParticleHandler.TranslateToPosition(p4.Origin);
    ParticleHandler.ScaleParticle(u6, 1.25);
    u6.Parent = workspace.Effects;
    v5:Add(function() -- Line: 55
        -- upvalues: ParticleHandler (ref), u6 (ref)
        ParticleHandler.EnableAllParticles(u6, false);
        ParticleHandler.DestroyByMaxLifetime(u6);
        u6 = nil;
    end);
end;