  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p1) -- Line: 27, Name: MagicalTurn
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), Trove (copy), BallController (copy), RunService (copy)
    local UndeadStepPass = AbilityBalancing.UndeadStepPass;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u2, _, _ = AbilityUtils.getCharacter();
    getPlayerTarget(false);
    local u5 = getPlayerTarget(false, function(p3, p4) -- Line: 40
        -- upvalues: Players (ref), LocalPlayer (ref), u2 (copy), UndeadStepPass (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

        if p3:GetAttribute("IsTrainingDummy") then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p3.Values.InCutscene.Value then
            return false;
        end;

        if (p3.HumanoidRootPart.Position - u2.Position).Magnitude < UndeadStepPass.ActivationRangePlayer then
            return true;
        end;
    end);

    if not u5 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    local ABC = interface.ABC;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, 45);
    local Track = AnimationController:GetTrack("Abilities", "UndeadStepPass");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("UndeadStepPassBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    local v6, v7 = AbilityUtils.FastDashTo(Character, u2.Position + (u2.CFrame.RightVector + u2.CFrame.LookVector).Unit * 35, 2, 0.5);
    ABC:Add(v6);
    ABC:Add(v7);
    ABC:Add(task.delay(0.5, function() -- Line: 82
        -- upvalues: u2 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v8, v9 = AbilityUtils.FastDashTo(Character, u2.Position + (-u2.CFrame.RightVector + u2.CFrame.LookVector).Unit * 35, 2, 0.5);
        ABC:Add(v8);
        ABC:Add(v9);
    end));
    ABC:Add(task.delay(1, function() -- Line: 90
        -- upvalues: u2 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v10, v11 = AbilityUtils.FastDashTo(Character, u2.Position + u2.CFrame.LookVector.Unit * 35, 2, 0.5);
        ABC:Add(v10);
        ABC:Add(v11);
    end));
    interface.AbilityService.Ability:Fire("UndeadStepPass", u5);
    ABC:Add(function() -- Line: 100
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local u12 = Trove.new();
    ABC:Add(u12);
    local u13 = false;
    u12:Connect(interface.AbilityService.Ability, function(u14) -- Line: 107
        -- upvalues: StatesController (ref), u13 (ref), LocalPlayer (ref), Character (copy), u5 (copy), u12 (copy), interface (ref), BallController (ref), RunService (ref)
        StatesController.States.Ability = false;

        if u13 then
            return;
        end;

        u13 = true;
        print(u14);

        if not (u14 and (u14:IsA("BasePart") and (u14.Parent == workspace and not (u14.OnPlayer.Value or (LocalPlayer.Character ~= Character or not (Character.Parent and u5.Parent)))))) then
            u12:Destroy();

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u5.HumanoidRootPart;
        local u15 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, interface.DaisyCutter and 0.2 or 0.65, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u14.AssemblyLinearVelocity = u15 * math_clamp_ret;
        BallController:DragBall(u14);
        local u16 = tick();
        task.wait(0.2);
        u12:Connect(RunService.Heartbeat, function(p17) -- Line: 136
            -- upvalues: u16 (copy), u14 (copy), HumanoidRootPart2 (copy), LocalPlayer (ref), Character (ref), u12 (ref), u15 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u16 + 1.25 or (not u14.Parent or (u14.OnPlayer.Value or (not HumanoidRootPart2.Parent or LocalPlayer.Character ~= Character))) then
                return u12:Destroy();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v18 = tick() > u16 + 0.55;
            u15 = u15:Lerp((HumanoidRootPart2.Position - u14.Position).Unit + Vector3.new(0, v18 and 0.15 or 0.35, 0), 6.5 * p17);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 150, 150);

            if u14.Position.Y < 5 or (HumanoidRootPart2.Position - u14.Position).Magnitude <= 7 then
                return u12:Destroy();
            end;

            u14.AssemblyLinearVelocity = u14.AssemblyLinearVelocity:Lerp(u15 * math_clamp_ret, 6.5 * p17);
        end);
    end);
    ABC:Add(task.delay(3, function() -- Line: 165
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;