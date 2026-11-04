 
 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Shared/Utility/Effects");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/Essentials");
local LocalPlayer = Players.LocalPlayer;

return function(p3) -- Line: 9
    -- upvalues: LocalPlayer (copy), u1 (copy), RunService (copy), u2 (copy)
    local Animations = p3.Animations;
    local AbilityService = p3.AbilityService;
    local MovementController = p3.MovementController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local PlayerPossessingBall = p3.BallController:GetPlayerPossessingBall();

    if PlayerPossessingBall == nil then
        p3:ResetCD(4);
        u1:Popup("An enemy must be holding the ball!");

        return;
    end;

    if not RunService:IsStudio() and PlayerPossessingBall.Team == LocalPlayer.Team then
        p3:ResetCD(4);
        u1:Popup("An enemy must be holding the ball!");

        return;
    end;

    local Character = PlayerPossessingBall.Character;

    if Character == nil then
        p3:ResetCD(4);
        u1:Popup("An enemy must be holding the ball!");

        return;
    end;

    local HumanoidRootPart2 = Character.HumanoidRootPart;
    local v4 = HumanoidRootPart2.Position - workspace.Hoops[u2:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position;

    if v4:Dot(v4) > 14400 then
        p3:ResetCD(4);
        u1:Popup("The enemy must be closer to the hoop!");

        return;
    end;

    local Vector3_new_ret = Vector3.new(HumanoidRootPart2.Position.X - HumanoidRootPart.Position.X, 0, HumanoidRootPart2.Position.Z - HumanoidRootPart.Position.Z);

    if Vector3_new_ret:Dot(Vector3_new_ret) > 10000 then
        p3:ResetCD(4);
        u1:Popup("The enemy is too far away!");

        return;
    end;

    MovementController.States.Ability = true;
    MovementController.States.NoWalk = true;
    task.delay(14.166666666666666, function() -- Line: 62
        -- upvalues: MovementController (copy)
        MovementController.States.Ability = false;
        MovementController.States.NoWalk = false;
    end);
    Animations:StopAll();
    AbilityService.Ability:Fire("NinjaAbility4", {
        StealCutscene = true,
        TimeSent = workspace:GetServerTimeNow()
    });
end;