  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), Trove (copy), BallController (copy), RunService (copy)
    local RationalDefense = AbilityBalancing.RationalDefense;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local u5 = getPlayerTarget(false, function(p2, p3) -- Line: 44
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (copy), RationalDefense (copy)
        if not (p2 and p2.Parent) then
            return false;
        end;

        local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
        local v4 = p2:FindFirstChildOfClass("Humanoid");
        local Values = p2:FindFirstChild("Values");

        if not (HumanoidRootPart and (v4 and (v4.Health > 0 and (Values and not (Values.HasBall.Value or Values.InCutscene.Value))))) then
            return false;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if PlayerFromCharacter then
            if PlayerFromCharacter.Team ~= LocalPlayer.Team or PlayerFromCharacter.Team == game.Teams.Visitor then
                return false;
            end;
        elseif not p2:GetAttribute("IsTrainingDummy") then
            return false;
        end;

        if p2.Values.InCutscene.Value then
            return false;
        end;

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < RationalDefense.ActivationRangePlayer then
            return true;
        end;
    end);

    if not u5 then
        Popup.Popup(LocalPlayer, "No teammate in range!");

        return;
    end;

    local ABC = interface.ABC;
    StatesController.States.Ability = true;
    local Track = AnimationController:GetTrack("Abilities", "RationalDefenseOnBall");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface:AbilityCooldown(1, RationalDefense.Cooldown);
    task.delay(1.3, function() -- Line: 80
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local u6 = Trove.new();
    ABC:Add(u6);
    local u7 = false;
    u6:Connect(interface.AbilityService.Ability, function(u8) -- Line: 87
        -- upvalues: u7 (ref), LocalPlayer (ref), Character (copy), u5 (copy), u6 (copy), interface (ref), BallController (ref), RunService (ref)
        if u7 then
            return;
        end;

        u7 = true;

        if not (u8 and (u8:IsA("BasePart") and (u8.Parent == workspace and not (u8.OnPlayer.Value or (LocalPlayer.Character ~= Character or not (Character.Parent and u5.Parent)))))) then
            u6:Destroy();

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u5.HumanoidRootPart;
        local u9 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, interface.DaisyCutter and 0.2 or 0.65, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u8.AssemblyLinearVelocity = u9 * math_clamp_ret;
        BallController:DragBall(u8);
        local u10 = tick();
        task.wait(0.2);
        u6:Connect(RunService.Heartbeat, function(p11) -- Line: 113
            -- upvalues: u10 (copy), u8 (copy), HumanoidRootPart2 (copy), LocalPlayer (ref), Character (ref), u6 (ref), u9 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u10 + 1.25 or (not u8.Parent or (u8.OnPlayer.Value or (not HumanoidRootPart2.Parent or LocalPlayer.Character ~= Character))) then
                return u6:Destroy();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v12 = tick() > u10 + 0.55;
            u9 = u9:Lerp((HumanoidRootPart2.Position - u8.Position).Unit + Vector3.new(0, v12 and 0.15 or 0.35, 0), 6.5 * p11);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 150, 150);

            if u8.Position.Y < 5 or (HumanoidRootPart2.Position - u8.Position).Magnitude <= 7 then
                return u6:Destroy();
            end;

            u8.AssemblyLinearVelocity = u8.AssemblyLinearVelocity:Lerp(u9 * math_clamp_ret, 6.5 * p11);
        end);
    end);
    interface.AbilityService.Ability:Fire("RationalDefenseOnBall", { u5 });
    task.delay(6, function() -- Line: 143
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;