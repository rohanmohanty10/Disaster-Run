 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 22
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), ReplicatedStorage (copy), LocalPlayer (copy), CalculateBallTrajectory (copy)
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.Network;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    u3:StopAll();
    u3:PlayChar("Cyber", "Projectile", Enum.AnimationPriority.Action3);
    u3:PlayBall("Cyber", "ProjectileBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("OGImplant", {
        State = "Projectile",
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Add(task.delay(5, function() -- Line: 40
        -- upvalues: u6 (copy), u2 (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.AimAssist = false;
        u2.States.NoWalk = false;
    end));
    u6.AC:Connect(u1.Ability, function(p7) -- Line: 47
        -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), CalculateBallTrajectory (ref)
        u6.AC:Clean();

        if p7.State == "Shoot" then
            u2.States.Ability = false;
            u2.States.AimAssist = false;
            u2.States.NoWalk = false;
            local Value = ReplicatedStorage.Basketball.Value;
            local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Hoop.Position, 90, 1 * workspace.Gravity);
        end;
    end);
end;