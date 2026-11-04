  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), Players (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    local v2 = {
        Icon = "rbxassetid://127063235272835",
        Name = Char.Name
    };
    local v3 = require(script.Subtitles)(v2);
    Char:PivotTo(Char:GetPivot() * CFrame.new(0, 7.5, 0));
    CutsceneUtils.PlayCutscene(Char, {
        R6 = Char
    }, "Easter YukimiyaCarrotGrab", script.CodeEvents, nil, v3, script.SoundEvents);
end;