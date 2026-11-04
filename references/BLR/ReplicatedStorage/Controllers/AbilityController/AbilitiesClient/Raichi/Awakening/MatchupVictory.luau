  

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
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), RunService (copy), LocalPlayer (copy), Popup (copy), interface (copy), ReplicatedStorage2 (copy), StatesController (copy), BallController (copy)
    local MatchupVictory = AbilityBalancing.MatchupVictory;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    getPlayerTarget(false);
    local u4 = getPlayerTarget(false, function(p2, p3) -- Line: 46
        -- upvalues: u1 (copy), MatchupVictory (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p2:GetAttribute("IsTrainingDummy") then
            return (p2.HumanoidRootPart.Position - u1.Position).Magnitude < MatchupVictory.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if RunService:IsStudio() then
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

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < MatchupVictory.ActivationRangePlayer then
            return true;
        end;
    end);

    if not u4 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    interface:AbilityCooldown(1, MatchupVictory.Cooldown);
    local ABC = interface.ABC;
    interface.AbilityService.Ability:Fire("MatchupVictory", u4);
    AbilityUtils.clientCutsceneSkill(interface, MatchupVictory, 30, 1, false, workspace.CurrentCamera.CFrame.LookVector);
    ABC:Connect(interface.AbilityService.Ability, function(p5) -- Line: 77
        -- upvalues: ReplicatedStorage2 (ref), StatesController (ref), Character (copy), u4 (copy), BallController (ref), ABC (copy), RunService (ref)
        local u6 = p5 or ReplicatedStorage2.Football.Value;
        StatesController.States.Ability = false;
        print("Received", u6);
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u7 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u7 * math_clamp_ret;
        BallController:DragBall(u6);
        local u8 = tick();
        ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 97
            -- upvalues: u8 (copy), u6 (ref), ABC (ref), HumanoidRootPart2 (copy), u7 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u8 + 2 or (not u6 or u6.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v10 = tick() > u8 + 0.55;
            u7 = u7:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v10 and 0.15 or 0.35, 0), 6.5 * p9);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u7 * math_clamp_ret, 6.5 * p9);
        end);
    end);
end;