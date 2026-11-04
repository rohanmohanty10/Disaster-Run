 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
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
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 19, Name: Vanish
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (ref), u4 (ref), u1 (ref), u3 (ref), u6 (ref), ReplicatedStorage (copy), Effects (copy), Essentials (copy), Knit (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = u7.MovementController;
    u5 = u7.CameraController;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u6 = u7.Network;
    local _ = ReplicatedStorage.Basketball.Value;
    local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();
    local v8;

    if LastPlayerToPossessBall then
        v8 = LastPlayerToPossessBall.Character;
    else
        v8 = LastPlayerToPossessBall;
    end;

    if not u6.CharValues.HasBall then
        if v8 then
            if LastPlayerToPossessBall.Team == LocalPlayer.Team then
                u7:ResetCD(2);
                Effects:Popup("Ball must be on opponent or just have been shot!");

                return;
            end;

            if v8:GetAttribute("Unblockable") and v8:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
                u7:ResetCD(2);
                Effects:Popup("ABILITY NOT BLOCKABLE");

                return;
            end;

            local v9 = v8.HumanoidRootPart.Position - HumanoidRootPart.Position;

            if v9:Dot(v9) > 2025 then
                u7:ResetCD(2);
                Effects:Popup("Opponent must be close to you!");

                return;
            end;
        else
            if ReplicatedStorage.Cooldowns.BlinkCD.Value > workspace:GetServerTimeNow() then
                local v10 = ReplicatedStorage.Cooldowns.BlinkCD.Value - workspace:GetServerTimeNow();
                local math_abs_ret = math.abs(v10);
                Effects:Popup(`Ability on global cooldown! use in {math.ceil(math_abs_ret)}`, 2);
                u7:ResetCD(2);

                return;
            end;

            if u7.Network.CharValues.Blocked + 2 > tick() then
                u7:ResetCD(2);
                Effects:Popup("Can\'t use after block!");

                return;
            end;

            local ServerBallPosition = u4:GetServerBallPosition();

            if ServerBallPosition.Y > 30 then
                u7:ResetCD(2);
                Effects:Popup("Ball is too far away!");

                return;
            end;

            local v11 = ServerBallPosition - HumanoidRootPart.Position;

            if v11:Dot(v11) > 1600 then
                u7:ResetCD(2);
                Effects:Popup("Ball is too far away!");

                return;
            end;

            local v12 = ServerBallPosition - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position;

            if v12:Dot(v12) <= 2500 then
                u7:ResetCD(2);
                Effects:Popup("Ball is too close to hoop!");

                return;
            end;
        end;

        u1.Ability:Fire("Blink", {
            Task = "Blink",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u7.AC:Add(task.delay(0.25, function() -- Line: 137
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end));

        if u2.States.Stealing then
            u2.States.Stealing = false;
        else
            Knit.GetController("DefenseController"):StealDb();
        end;

        u7.AC:Connect(u1.Ability, function(p13) -- Line: 148
            -- upvalues: u7 (copy), Effects (ref), u2 (ref)
            u7.AC:Clean();

            if p13.Task == "Blink" then
                Effects:Popup("Ball must be on opponent or just have been shot!");
                u2.States.Ability = false;
                u7:ResetCD(2);
            end;
        end);

        return;
    end;

    if ReplicatedStorage.GameValues.Scoring.Value then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use after a goal!");

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude <= 30 then
        u7:ResetCD(2);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 100 then
        u7:ResetCD(2);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if u7.MovementController.States.PumpFake then
        u7:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.Dunking = true;
    u2.States.NoWalk = true;
    task.delay(1.5, function() -- Line: 51
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.Dunking = false;
    end);
    u3:StopAll();
    u3:PlayChar("BasketballGod", "ReverseDunk", Enum.AnimationPriority.Action3);
    u3:PlayBall("BasketballGod", "ReverseDunkBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Blink", {
        Task = "Perfect Dunk",
        TimeSent = workspace:GetServerTimeNow()
    });
    u7.AC:Connect(u7.AbilityService.Ability, function(p14) -- Line: 59
        -- upvalues: u7 (copy), u3 (ref)
        u7.AC:Clean();

        if p14.Task == "Dunk" then
            u3:StopAll();
            u3:PlayChar("Perfection", "PerfectDunk", Enum.AnimationPriority.Action3);
            u3:PlayBall("Perfection", "PerfectDunkBall", Enum.AnimationPriority.Action3);
        end;
    end);
end;