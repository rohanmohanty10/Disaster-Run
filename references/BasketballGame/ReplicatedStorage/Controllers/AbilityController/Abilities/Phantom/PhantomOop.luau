 
 

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

return function(p5) -- Line: 21, Name: PhantomShot
    -- upvalues: LocalPlayer (copy), u4 (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v6 = p5:CheckInfront(15);

    if v6 == nil and u4 then
        v6 = workspace.DefenseRig;
    end;

    if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 90 then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if v6 == nil then
        p5:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if (LocalPlayer.Character.HumanoidRootPart.Position - v6.HumanoidRootPart.Position).Magnitude > 15 then
        p5:ResetCD(3);
        Effects:Popup("Other player is too far away!");

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9.5, function() -- Line: 41
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("PhantomOop", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v6
    });
    p5:StillHasBall();
end;