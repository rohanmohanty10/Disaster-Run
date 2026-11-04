 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p8) -- Line: 21, Name: Catch
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), Essentials (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = p8.Network;
    u2 = p8.AbilityService;
    u4 = p8.Animations;
    u3 = p8.MovementController;
    u5 = p8.BallController;
    u6 = p8.CameraController;
    u7 = Knit.GetService("CustomServerService");
    local v9 = workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position - HumanoidRootPart.Position;

    if v9:Dot(v9) > 22500 then
        Effects:Popup("Too far away from hoop!", 1);
        p8:ResetCD(3);

        return;
    end;

    local CharacterPossessingBall = u5:GetCharacterPossessingBall();
    local LastPlayerToPossessBall = u5:GetLastPlayerToPossessBall();

    if not LastPlayerToPossessBall or LastPlayerToPossessBall.Team == LocalPlayer.Team then
        Effects:Popup("Ball must have been shot by an enemy player!");

        return p8:ResetCD(3);
    end;

    if CharacterPossessingBall then
        Effects:Popup("The ball must not be on a player!");

        return p8:ResetCD(3);
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u4:StopAll();
    u2.Ability:Fire("SpiderCatch", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.delay(17.833333333333332, function() -- Line: 63
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
end;