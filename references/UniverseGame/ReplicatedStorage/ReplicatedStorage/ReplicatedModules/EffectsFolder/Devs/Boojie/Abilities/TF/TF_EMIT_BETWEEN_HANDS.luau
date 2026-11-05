  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = Players.LocalPlayer;
game:GetService("TweenService");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2) -- Line: 21
    -- upvalues: u1 (copy), TableUtil (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local v4 = Character:FindFirstChild("Left Arm");

    if v4 then
        v4 = v4.CFrame * CFrame.new(0, -1, 0);
    end;

    local v5 = Character:FindFirstChild("Right Arm");

    if v5 then
        v5 = v5.CFrame * CFrame.new(0, -1, 0);
    end;

    if v4 and v5 then
        u1(TableUtil.Reconcile({
            Origin = v4:Lerp(v5, 0.5),
            Offset = CFrame.identity
        }, v3));
    end;
end;