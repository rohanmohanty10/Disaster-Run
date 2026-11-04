 
 

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

return function(u6) -- Line: 19, Name: LetMeCook
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (ref), u1 (ref), u4 (ref), u3 (ref), Effects (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u5 = u6.CameraController;
    u1 = u6.AbilityService;
    u4 = u6.BallController;
    u3 = u6.Animations;
    local v7 = u6:CheckInfront(25);
    local Magnitude = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude;

    if not v7 then
        u6:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if Magnitude > 110 then
        u6:ResetCD(3);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    u5:SetShiftlock(false);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(14, function() -- Line: 39
        -- upvalues: u2 (ref), u5 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u5:SetShiftlock(true);
    end);
    u3:StopAll();
    u1.Ability:Fire("LetMeCook", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
    u6.AC:Connect(u1.Ability, function(p8) -- Line: 52
        -- upvalues: u6 (copy), ReplicatedStorage (ref), u4 (ref)
        u6.AC:Clean();

        if p8 == 1 then
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = Vector3.new(-0, -25, -0);

            return;
        end;

        local Value = ReplicatedStorage.Basketball.Value;
        local Random_new_ret = Random.new();
        local v9 = Random_new_ret:NextNumber(-1, 1);
        local v10 = Random_new_ret:NextNumber(-2, 1);
        Value.AssemblyLinearVelocity = Vector3.new(v9, v10, Random_new_ret:NextNumber(-1, 1)) * Random_new_ret:NextNumber(40, 70);
    end);
end;