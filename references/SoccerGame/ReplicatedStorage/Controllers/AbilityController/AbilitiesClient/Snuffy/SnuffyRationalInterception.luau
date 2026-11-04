  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local RationalDefense = require(ReplicatedStorage2.AbilityBalancing).RationalDefense;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28, Name: TrapTower
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), AnimationController (copy), RationalDefense (copy), TweenService (copy), StatesController (copy), getPlayerTarget (copy), Players (copy), BallController (copy), RunService (copy)
    if not (AbilityUtils.rules.offball() and (not AbilityUtils.rules.grounded(LocalPlayer, false) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    interface.StatesController.States.Ability = true;
    local Unit = (u1.CFrame.LookVector + Vector3.new(0, 0.1, 0)).Unit;

    if workspace:FindFirstChild("Football") then
        print("Here");
        Unit = CFrame.new(u1.Position, (Vector3.new(workspace.Football.Position.X, u1.Position.Y, workspace.Football.Position.Z))).LookVector;
    end;

    interface:AbilityCooldown(1, 40);
    local Track = AnimationController:GetTrack("Abilities", "TrapTower");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(20000, 20000, 20000);
    BodyVelocity.Velocity = Unit * RationalDefense.MoveSpeedValue + Vector3.new(0, 25, 0);
    BodyVelocity.Parent = Character.PrimaryPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(0.75), {
        Velocity = BodyVelocity.Velocity * 0.1
    }):Play();
    ABC:Add(BodyVelocity);
    task.delay(0.5, BodyVelocity.Destroy, BodyVelocity);
    local u2 = false;
    task.delay(0.8, function() -- Line: 71
        -- upvalues: u2 (ref), Track (copy), ABC (copy), StatesController (ref)
        if u2 then
            Track:Stop();
            ABC:Clean();
            StatesController.States.Ability = false;
        end;
    end);
    getPlayerTarget(false);
    local u5 = getPlayerTarget(false, function(p3, p4) -- Line: 77
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (copy)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

        if p3:GetAttribute("IsTrainingDummy") then
            return false;
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

        if (p3.HumanoidRootPart.Position - u1.Position).Magnitude < 100 then
            return true;
        end;
    end);
    interface.AbilityService.Ability:Fire("RationalInterception", u5);
    ABC:Connect(interface.AbilityService.Ability, function(u6, p7) -- Line: 96
        -- upvalues: Track (copy), u2 (ref), u5 (copy), Character (copy), interface (ref), BallController (ref), ABC (copy), RunService (ref)
        Track:Stop(0);
        u2 = true;

        if u5 then
            local HumanoidRootPart = Character.HumanoidRootPart;
            local HumanoidRootPart2 = u5.HumanoidRootPart;
            local u8 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, interface.DaisyCutter and 0.2 or 0.65, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
            local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
            u6.AssemblyLinearVelocity = u8 * math_clamp_ret;
            BallController:DragBall(u6);
            local u9 = tick();
            task.wait(0.2);
            ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 121
                -- upvalues: u9 (copy), u6 (copy), ABC (ref), HumanoidRootPart2 (copy), u8 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
                if tick() > u9 + 1.25 or (not u6 or u6.OnPlayer.Value) then
                    return ABC:Clean();
                end;

                local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                local v11 = tick() > u9 + 0.55;
                u8 = u8:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v11 and 0.15 or 0.35, 0), 6.5 * p10);
                math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 150, 150);

                if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                    return ABC:Clean();
                end;

                u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p10);
            end);
        end;
    end);
    task.delay(0.8, function() -- Line: 150
        -- upvalues: ABC (copy), interface (ref)
        if ABC then
            ABC:Clean();
            interface.StatesController.States.Ability = false;
        end;
    end);
end;