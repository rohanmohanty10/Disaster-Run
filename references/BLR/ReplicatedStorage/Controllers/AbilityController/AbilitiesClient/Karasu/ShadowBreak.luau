  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local ShadowBreak = require(ReplicatedStorage2.AbilityBalancing).ShadowBreak;

return function() -- Line: 30
    -- upvalues: AbilityUtils (copy), interface (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), ShadowBreak (copy), StatesController (copy), AnimationController (copy), RunService (copy), Popup (copy), BallController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local u4 = getPlayerTarget(false, function(p2, p3) -- Line: 42
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (copy), ShadowBreak (ref)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if p2:GetAttribute("IsTrainingDummy") then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p2.Values.InCutscene.Value then
            return false;
        end;

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < ShadowBreak.ActivationRangePlayer then
            return true;
        end;
    end);
    StatesController.States.Ability = true;
    AbilityUtils.clearMovers(Character);
    interface:AbilityCooldown(2, ShadowBreak.Cooldown);
    local Track = AnimationController:GetTrack("Abilities", "ShadowBreak");
    Track:Play();
    interface.AbilityService.Ability:Fire("ShadowBreak");
    ABC:Add(task.delay(1.5, function() -- Line: 70
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(task.delay(0.2, function() -- Line: 74
        -- upvalues: AbilityUtils (ref), Character (copy), u1 (copy), ShadowBreak (ref), ABC (copy)
        local v5, v6 = AbilityUtils.FastDashTo(Character, (u1.CFrame * CFrame.new(0, 0, -ShadowBreak.Distance)).Position, 2, 0.5);
        ABC:Add(v5);
        ABC:Add(v6);
    end));
    ABC:Add(task.delay(0.75, function() -- Line: 81
        -- upvalues: u4 (ref), getPlayerTarget (ref), Players (ref), RunService (ref), LocalPlayer (ref), u1 (copy), ShadowBreak (ref), Track (copy), Popup (ref), ABC (copy), interface (ref)
        u4 = getPlayerTarget(false, function(p7, p8) -- Line: 82
            -- upvalues: Players (ref), RunService (ref), LocalPlayer (ref), u1 (ref), ShadowBreak (ref)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p7);

            if RunService:IsStudio() then
                return true;
            end;

            if not PlayerFromCharacter then
                return false;
            end;

            if PlayerFromCharacter.Team ~= LocalPlayer.Team then
                return false;
            end;

            if p7.Values.InCutscene.Value then
                return false;
            end;

            if (p7.HumanoidRootPart.Position - u1.Position).Magnitude < ShadowBreak.ActivationRangePlayer then
                return true;
            end;
        end) or u4;

        if u4 then
            task.wait(0.15);
            interface.AbilityService.Ability:Fire("ShadowBreak", u4);

            return;
        end;

        Track:Stop();
        Popup.Popup(LocalPlayer, "No teammate in range to pass to!");
        ABC:Clean();
    end));
    ABC:Connect(interface.AbilityService.Ability, function(u9) -- Line: 110
        -- upvalues: StatesController (ref), Character (copy), u4 (ref), BallController (ref), ABC (copy), RunService (ref)
        StatesController.States.Ability = false;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u10 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.25, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u9.AssemblyLinearVelocity = u10 * math_clamp_ret;
        BallController:DragBall(u9);
        local u11 = tick();
        ABC:Connect(RunService.Heartbeat, function(p12) -- Line: 129
            -- upvalues: u11 (copy), u9 (copy), ABC (ref), HumanoidRootPart2 (copy), u10 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u11 + 2 or (not u9 or u9.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v13 = tick() > u11 + 0.55;
            u10 = u10:Lerp((HumanoidRootPart2.Position - u9.Position).Unit + Vector3.new(0, v13 and 0.15 or 0.35, 0), 6.5 * p12);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u9.Position.Y < 5 or (HumanoidRootPart2.Position - u9.Position).Magnitude <= 7 then
                ABC:Clean();

                return;
            end;

            u9.AssemblyLinearVelocity = u9.AssemblyLinearVelocity:Lerp(u10 * math_clamp_ret, 6.5 * p12);
        end);
    end);
    ABC:Add(function() -- Line: 159
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
end;