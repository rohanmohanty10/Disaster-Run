  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 17
    -- upvalues: Popup (copy), Players (copy), AbilityBalancing (copy), RunService (copy)
    if u2.Character.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if ((u2.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away).Position - u3.HumanoidRootPart.Position).Magnitude > 100 then
        Popup.Popup(u2, "Must be near the goal");

        return;
    end;

    local v4 = true;

    for _, v in Players:GetPlayers() do
        if v.Team == u2.Team and u2 ~= v then
            local Character = v.Character;

            if Character then
                local Values = Character:FindFirstChild("Values");

                if Values and Values.IsInPenalty.Value then
                    v4 = false;
                end;
            end;
        end;
    end;

    if v4 then
        local PassRig = workspace:FindFirstChild("PassRig");

        if PassRig and PassRig:GetAttribute("IsTrainingDummy") then
            v4 = false;
        end;
    end;

    if v4 then
        Popup.Popup(u2, "Need a teammate!");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 66
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 75
        -- upvalues: u1 (copy), AbilityBalancing (ref)
        u1:AbilityCooldown("1", AbilityBalancing.RabonaCross.Cooldown);
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(u5, u6, p7) -- Line: 80
        -- upvalues: u1 (copy), AbilityBalancing (ref), u2 (copy), RunService (ref)
        u1:AbilityCooldown("1", AbilityBalancing.RabonaCross.Cooldown);
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        u5.AssemblyLinearVelocity = ((p7.CFrame * CFrame.Angles(0, 0.6108652381980153, 0)).LookVector + Vector3.new(0, 0.2, 0) + u6 / 2) * AbilityBalancing.RabonaCross.ShotPower;
        task.delay(0.1, function() -- Line: 94
            -- upvalues: u1 (ref), RunService (ref), u5 (copy), u6 (copy)
            local u8 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 97
                -- upvalues: u8 (ref), u1 (ref), u5 (ref), u6 (ref)
                u8 = u8 + 50 * p9;

                if u8 >= -25 then
                    u1.ABC:Clean();
                end;

                u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u5.AssemblyLinearVelocity + u6 * u8, 8 * p9);
            end);
        end);
        u1.BallController:DragBall(u5);
        task.wait(1);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("RabonaCross");
end;