 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: FullCourt
    -- upvalues: LocalPlayer (copy), Effects (copy), u2 (ref), u5 (ref), u4 (ref), u1 (ref), u3 (ref)
    local _ = u6.Network.Gamemode == "Match-2v2";

    if math.abs(LocalPlayer.Character.HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) < 145 then
        u6:ResetCD(3);
        Effects:Popup("Only usable from other side of the court.");

        return;
    end;

    u2 = u6.MovementController;
    u5 = u6.CameraController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5:SetShiftlock(false);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9.5, function() -- Line: 36
        -- upvalues: u2 (ref), u5 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u5:SetShiftlock(true);
    end);
    u3:StopAll();
    u1.Ability:Fire("FullCourt", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6:StillHasBall();
    u6.AC:Connect(u1.Ability, function(p7) -- Line: 46
        -- upvalues: u6 (copy), u4 (ref), LocalPlayer (ref)
        u6.AC:Clean();
        p7.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position = p7.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
        local v8 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
        local math_log_ret = math.log(3.5 + v8.Magnitude * 0.055);
        p7.AssemblyLinearVelocity = v8 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;