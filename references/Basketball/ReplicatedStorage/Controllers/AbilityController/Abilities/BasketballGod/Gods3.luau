 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local u4 = RunService:IsStudio();

return function(p5) -- Line: 21, Name: Gods3
    -- upvalues: LocalPlayer (copy), u4 (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v6 = p5:CheckInfront(25);

    if v6 == nil and u4 then
        v6 = workspace.DefenseRig;
    end;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude >= 120 then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    if v6 == nil then
        p5:ResetCD(3);
        Effects:Popup("Someone must be infront of you!", 1);

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(16.5, function() -- Line: 39
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Gods3", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v6
    });
    p5:StillHasBall();
end;