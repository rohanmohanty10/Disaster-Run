 
 

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

return function(u6) -- Line: 20, Name: Clutch
    -- upvalues: LocalPlayer (copy), Effects (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Magnitude = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude;

    if Magnitude >= 110 then
        u6:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    if Magnitude <= 40 then
        u6:ResetCD(3);
        Effects:Popup("Too close to hoop!", 1);

        return;
    end;

    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil then
            u6:ResetCD(3);
            Effects:Popup("Need a close team-mate with the ball!", 1);

            return;
        end;

        if PlayerPossessingBall.Team ~= LocalPlayer.Team then
            u6:ResetCD(3);
            Effects:Popup("Need a close team-mate with the ball!", 1);

            return;
        end;

        local Character = PlayerPossessingBall.Character;

        if Character == nil then
            u6:ResetCD(3);
            Effects:Popup("Need a close team-mate with the ball!", 1);

            return;
        end;

        local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart2 == nil then
            u6:ResetCD(3);
            Effects:Popup("Need a close team-mate with the ball!", 1);

            return;
        end;

        local v7 = HumanoidRootPart2.Position - HumanoidRootPart.Position;

        if v7:Dot(v7) > 4900 then
            u6:ResetCD(3);
            Effects:Popup("Need a close team-mate with the ball!", 1);

            return;
        end;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(5.21, function() -- Line: 105
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u6:StillHasBall();
    u3:StopAll();
    u1.Ability:Fire("Clutch", {
        TimeSent = workspace:GetServerTimeNow(),
        HasBall = u5.CharValues.HasBall
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 120
        -- upvalues: u6 (copy), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
        u6.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
        local v8 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
        local math_log_ret = math.log(2.5 + v8.Magnitude * 0.06);
        Value.AssemblyLinearVelocity = v8 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;