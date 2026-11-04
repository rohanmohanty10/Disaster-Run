  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), Players (copy), Popup (copy), AbilityBalancing (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.Char.Value;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

    if not (Value.OnPlayer.Value and (PlayerFromCharacter and (PlayerFromCharacter.Team == p2.Team and PlayerFromCharacter ~= p2))) then
        Popup.Popup(p2, "Ball must be on teammate");

        return;
    end;

    if ((p2.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away).Position - p3.HumanoidRootPart.Position).Magnitude < 150 then
        Popup.Popup(p2, "Must be further from the goal");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 43
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(18, function() -- Line: 49
        -- upvalues: u1 (copy), AbilityBalancing (ref)
        u1:AbilityCooldown("1", AbilityBalancing.EnterStriker.Cooldown);
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5) -- Line: 55
        -- upvalues: u1 (copy), AbilityBalancing (ref), u4 (copy), ReplicatedStorage (ref)
        u1:AbilityCooldown("1", AbilityBalancing.EnterStriker.Cooldown);
        p5.AssemblyLinearVelocity = u4 * AbilityBalancing.EnterStriker.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("EnterStriker", Value2);
end;