 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.CameraController;
    u4 = u7.BallController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if u6.CharValues.HasBall then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u7:ResetCD(2);

            return;
        end;

        local v8 = u7:CheckInfront(25);

        if not v8 then
            u7:ResetCD(2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(4.15, function() -- Line: 47
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u5:StopAll();
        u1.Ability:Fire("Screen", {
            State = "Slow IQ",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });

        return;
    end;

    u1.Ability:Fire("Screen", {
        State = "Screen",
        TimeSent = workspace:GetServerTimeNow()
    });
    Effects:Popup("Collision with enemy pushes them and gives you a speed boost!");
    local u9 = u5:PlayChar("Genius", "Screen", Enum.AnimationPriority.Action3, true);
    u2.States.NoWalk = true;
    u2.States.Ability = true;
    u7.AC:Connect(RunService.Heartbeat, function() -- Line: 64
        -- upvalues: u6 (ref), u7 (copy)
        if u6.CharValues.HasBall then
            u7.AC:Clean();
        end;
    end);
    local u10 = nil;
    u7.AC:Add(function(p11) -- Line: 72
        -- upvalues: u10 (ref), Effects (ref), u6 (ref), u9 (copy), u2 (ref)
        if not u10 then
            Effects:Popup("Ability ended.");
        end;

        if not u6.CharValues.HasBall then
            task.wait(0.5);
        end;

        if u9 then
            u9:Stop();
        end;

        u2.States.NoWalk = false;
        u2.States.Ability = false;
    end);
    u7.AC:Connect(u1.Ability, function(p12) -- Line: 89
        -- upvalues: u10 (ref), u7 (copy), Effects (ref), u2 (ref)
        if not (p12 and p12.SpeedBoost) then
            return;
        end;

        u10 = true;
        u7.AC:Clean();
        Effects:Popup("SCREENED! SPEED BOOST! YEAH!", 6);
        local v13 = u2;
        v13.Boost = v13.Boost + 5;
        task.delay(15, function() -- Line: 98
            -- upvalues: Effects (ref), u2 (ref)
            Effects:Popup("SPEED BOOST ENDED!");
            local v14 = u2;
            v14.Boost = v14.Boost - 5;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
    end);
    u7.AC:Add(task.delay(2, function() -- Line: 107
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
end;