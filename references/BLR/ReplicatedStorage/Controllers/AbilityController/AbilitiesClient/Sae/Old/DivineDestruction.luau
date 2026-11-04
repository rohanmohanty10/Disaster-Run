  

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
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
OverlapParams_new_ret.FilterDescendantsInstances = { workspace.Debris, workspace.Debris };

return function(u1, u2, p3) -- Line: 21
    -- upvalues: Popup (copy), ReplicatedStorage (copy), OverlapParams_new_ret (copy), RunService (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local v4 = u2.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away;

    if (v4.Position - p3.HumanoidRootPart.Position).Magnitude > 100 then
        Popup.Popup(u2, "Must be near the goal");

        return;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if Value.OnPlayer.Value then
        Popup.Popup(u2, "Ball must be loose!");

        return;
    end;

    print(Value.OnPlayer.Value);
    local v5 = false;

    for _, v in workspace:GetPartsInPart(v4, OverlapParams_new_ret) do
        if v == Value then
            v5 = true;
            break;
        end;
    end;

    if not v5 then
        Popup.Popup(u2, "ball must be in penalty box");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u1.ABC:Add(function() -- Line: 64
        -- upvalues: u1 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 70
        -- upvalues: u1 (copy)
        u1:AbilityCooldown("1", 80);
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6, u7) -- Line: 75
        -- upvalues: u1 (copy), u2 (copy), RunService (ref), ReplicatedStorage (ref)
        u1:AbilityCooldown("1", 80);
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        u6.AssemblyLinearVelocity = ((Character.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)).LookVector + Vector3.new(0, 0.2, 0) + u7 / 2) * 180;
        task.delay(0.1, function() -- Line: 89
            -- upvalues: u1 (ref), RunService (ref), u6 (copy), u7 (copy)
            local u8 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 92
                -- upvalues: u8 (ref), u1 (ref), u6 (ref), u7 (ref)
                u8 = u8 + 50 * p9;

                if u8 >= -25 then
                    u1.ABC:Clean();
                end;

                u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u6.AssemblyLinearVelocity + u7 * u8, 8 * p9);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        task.wait(1);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("DivineDestruction");
end;