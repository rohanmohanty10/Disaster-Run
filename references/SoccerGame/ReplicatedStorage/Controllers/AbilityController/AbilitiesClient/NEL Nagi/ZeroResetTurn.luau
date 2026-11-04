  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

local function AnkleBreak(u1, u2, p3, p4) -- Line: 16
    -- upvalues: RunService (copy), Players (copy)
    local HumanoidRootPart = p3.HumanoidRootPart;
    local u6 = RunService.Heartbeat:Connect(function() -- Line: 18
        -- upvalues: Players (ref), u2 (copy), HumanoidRootPart (copy), u1 (copy)
        for _, v in Players:GetPlayers() do
            if v ~= u2 and (v.Character and (u2.Team ~= v.Team and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 10)) then
                local Character = v.Character;
                local v5;

                if v then
                    v5 = v.PlayerStats.InAwakening.Value or false;
                else
                    v5 = false;
                end;

                if not (v5 or (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value or v.Character.IsRagdoll.Value)) then
                    u1.AbilityService.Ability:Fire("Reverse2Stage", {
                        State = "ZeroAnkleBreak",
                        enemy = Character
                    });
                end;
            end;
        end;
    end);
    task.delay(p4, function() -- Line: 37
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
end;

return function(u7, p8, p9) -- Line: 42
    -- upvalues: Popup (copy), AbilityBalancing (copy), AbilityUtils (copy), AnkleBreak (copy)
    if u7.AbilityTwo > tick() then
        return;
    end;

    if u7.AbilityUsed > tick() then
        return;
    end;

    if not p9.Values.HasBall.Value then
        Popup.Popup(p8, "Must have ball");

        return;
    end;

    if p8.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        print("Air");

        return;
    end;

    if p8.Character.IsRagdoll.Value then
        return;
    end;

    local HumanoidRootPart = p9.HumanoidRootPart;
    u7:AbilityCooldown("2", AbilityBalancing.ZeroResetTurn.Cooldown);
    u7.StatesController.States.Ability = true;
    print("Called");
    u7.Animations.Abilities.ZRT.Priority = Enum.AnimationPriority.Action4;
    u7.Animations.Abilities.ZRT:Play();
    u7.Animations.Ball.ZeroResetTurnBall.Priority = Enum.AnimationPriority.Action4;
    u7.Animations.Ball.ZeroResetTurnBall:Play();
    u7.ABC:Add(function() -- Line: 63
        -- upvalues: u7 (copy)
        u7.StatesController.States.Ability = false;
    end);
    task.delay(2.2, function() -- Line: 67
        -- upvalues: u7 (copy)
        u7.ABC:Clean();
    end);
    u7.AbilityService.Ability:Fire("Reverse2Stage", {
        State = "ZeroReset"
    });
    task.wait(0.1);
    local CFrame = HumanoidRootPart.CFrame;
    AbilityUtils.FastDashTo(p9, CFrame.Position + CFrame.LookVector * 40, 2, 0.9);
    AnkleBreak(u7, p8, p9, 0.8);
    task.wait(1.1);
    AbilityUtils.FastDashTo(p9, CFrame.Position + CFrame.LookVector * -40, 2, 0.6);
    AnkleBreak(u7, p8, p9, 0.5);
    task.wait(0.6);
    local CFrame2 = HumanoidRootPart.CFrame;
    AbilityUtils.FastDashTo(p9, CFrame2.Position + CFrame2.LookVector * 80, 2, 0.4);
    AnkleBreak(u7, p8, p9, 0.4);
    task.wait(0.4);
end;