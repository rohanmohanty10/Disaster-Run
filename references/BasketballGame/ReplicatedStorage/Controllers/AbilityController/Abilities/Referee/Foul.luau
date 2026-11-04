 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u5) -- Line: 14
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), Effects (copy), ReplicatedStorage (copy), RunService (copy)
    u1 = u5.MovementController;
    u2 = u5.AbilityService;
    u3 = u5.Animations;
    u4 = u5.Network;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

    if not u4.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.FoulCD.Value > workspace:GetServerTimeNow() then
            u5:ResetCD(1);
            local v6 = ReplicatedStorage.Cooldowns.FoulCD.Value - workspace:GetServerTimeNow();
            Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v6)} seconds`, 2);

            return;
        end;

        u2.Ability:Fire("Foul", {
            State = "Foul",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Stop a nearby shot.");
        u5.AC:Connect(u5.AbilityService.Ability, function() -- Line: 69
            -- upvalues: u5 (copy), u3 (ref)
            u5.AC:Clean();
            u3:StopAll();
            u3:PlayChar("Referee", "Foul", Enum.AnimationPriority.Action3);
        end);
        u5.AC:Connect(RunService.Heartbeat, function() -- Line: 76
            -- upvalues: u4 (ref), u5 (copy)
            if u4.CharValues.HasBall then
                u5.AC:Clean();
            end;
        end);
        u5.AC:Add(function() -- Line: 82
            -- upvalues: Effects (ref)
            Effects:Popup("Ability ended.");
        end);
        u5.AC:Add(task.delay(5, function() -- Line: 86
            -- upvalues: u5 (copy)
            u5.AC:Clean();
        end));

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude <= 50 then
        u5:ResetCD(1);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 100 then
        u5:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if u5.MovementController.States.PumpFake then
        u5:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u1.States.Ability = true;
    u1.States.Dunking = true;
    u1.States.NoWalk = true;
    task.delay(2.283, function() -- Line: 47
        -- upvalues: u1 (ref)
        u1.States.Ability = false;
        u1.States.NoWalk = false;
        u1.States.Dunking = false;
    end);
    u3:StopAll();
    u3:PlayChar("Referee", "BookDunk", Enum.AnimationPriority.Action3);
    u3:PlayBall("Referee", "BookDunkBall", Enum.AnimationPriority.Action3);
    u2.Ability:Fire("Foul", {
        State = "BookDunk",
        TimeSent = workspace:GetServerTimeNow()
    });
end;