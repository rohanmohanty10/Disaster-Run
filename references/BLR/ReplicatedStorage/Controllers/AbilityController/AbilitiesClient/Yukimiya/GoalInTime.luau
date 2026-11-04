  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3) -- Line: 17
    -- upvalues: Popup (copy), RunService (copy), ReplicatedStorage (copy)
    if p2.Character.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if p3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if ((p2.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away).Position - p3.HumanoidRootPart.Position).Magnitude < 150 then
        Popup.Popup(p2, "Must be further from the goal");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 38
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(12, function() -- Line: 44
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("2", 80);
        u1.ABC:Clean();
    end));
    local u4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u5, p6) -- Line: 50
        -- upvalues: u1 (copy), u4 (copy), RunService (ref), ReplicatedStorage (ref)
        local u7 = -p6;
        u1:AbilityCooldown("2", 80);
        u5.AssemblyLinearVelocity = (u4 + u7 / 2) * 220;
        task.delay(0.1, function() -- Line: 59
            -- upvalues: u1 (ref), RunService (ref), u5 (copy), u7 (ref)
            local u8 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 62
                -- upvalues: u8 (ref), u1 (ref), u5 (ref), u7 (ref)
                u8 = u8 + 35 * p9;

                if u8 >= -25 then
                    print("Ended");
                    u1.ABC:Clean();
                end;

                u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u5.AssemblyLinearVelocity + u7 * u8, 8 * p9);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("GoalInTime");
end;