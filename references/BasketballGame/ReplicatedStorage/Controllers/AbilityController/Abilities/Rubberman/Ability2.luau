 
 

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
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if not u6.RubberGear then
        u6.RubberGear = "Defensive";
    end;

    local v7 = u6.RubberGear == "Offensive";

    if u5.CharValues.InAwakening then
        v7 = u5.CharValues.HasBall;
    end;

    if v7 then
        if not u6.Network.CharValues.HasBall then
            u6:ResetCD(2);
            Effects:Popup("Not usable without ball!");

            return;
        end;

        u4.Dribbles = 0;
        Effects:Popup("Auto dribble activated for 4 seconds");
        u1.Ability:Fire("Ability2", {
            Ability = "Observe",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    local ServerBallPosition = u4:GetServerBallPosition();
    local CharacterPossessingBall = u4:GetCharacterPossessingBall();
    local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();

    if not LastPlayerToPossessBall or LastPlayerToPossessBall.Team == LocalPlayer.Team then
        Effects:Popup("Ball must have been shot by an enemy player!");

        return u6:ResetCD(2);
    end;

    if CharacterPossessingBall then
        Effects:Popup("The ball must not be on a player!");

        return u6:ResetCD(2);
    end;

    if (Character.HumanoidRootPart.Position - ServerBallPosition).Magnitude >= 45 then
        Effects:Popup("The ball is too far away!");

        return u6:ResetCD(2);
    end;

    local LastPlayerToPossessBall2 = u4:GetLastPlayerToPossessBall();

    if LastPlayerToPossessBall2 then
        LastPlayerToPossessBall2 = LastPlayerToPossessBall2.Character;
    end;

    if LastPlayerToPossessBall2 and (LastPlayerToPossessBall2:GetAttribute("Unblockable") and LastPlayerToPossessBall2:GetAttribute("Unblockable") > workspace:GetServerTimeNow()) then
        Effects:Popup("Can\'t block shot!");
        u6:ResetCD(2);

        return;
    end;

    if ServerBallPosition.Y > 25 then
        Effects:Popup("The ball is too high!");

        return u6:ResetCD(2);
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("Rubberman", "GumBlock", Enum.AnimationPriority.Action3);
    u3:PlayBall("Rubberman", "GumBlockBall", Enum.AnimationPriority.Action3);
    u6.AC:Connect(RunService.Heartbeat, function(p8) -- Line: 90
        -- upvalues: u5 (ref), ServerBallPosition (ref), u4 (ref), HumanoidRootPart (copy)
        if not u5.CharValues.HasBall then
            ServerBallPosition = u4:GetServerBallPosition();
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z)));
        end;
    end);
    task.delay(1.5833333333333333, function() -- Line: 97
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u6.AC:Clean();
    end);
    u1.Ability:Fire("Ability2", {
        Ability = "GumBlock",
        TimeSent = workspace:GetServerTimeNow()
    });
end;