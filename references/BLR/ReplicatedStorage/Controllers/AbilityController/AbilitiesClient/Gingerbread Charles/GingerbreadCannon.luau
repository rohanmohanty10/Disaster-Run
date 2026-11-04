  

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
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local GetPlayersByDistanceAndAngle = require(ReplicatedStorage2.Shared.GetPlayersByDistanceAndAngle);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), GetPlayersByDistanceAndAngle (copy), LocalPlayer (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), RunService (copy)
    local CookieCross = AbilityBalancing.CookieCross;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local Character, v1, _, _ = AbilityUtils.getCharacter();
    local v3 = GetPlayersByDistanceAndAngle(45, 500, LocalPlayer, nil, function(p2) -- Line: 40
        -- upvalues: LocalPlayer (ref)
        if not p2 then
            return false;
        end;

        if p2.Team == LocalPlayer.Team then
            return not p2.Character.Values.InCutscene.Value;
        end;

        return false;
    end);
    local u4 = v3 and v3[1];

    if not u4 then
        for _, child in workspace:GetChildren() do
            if child:GetAttribute("IsTrainingDummy") and (child:FindFirstChild("HumanoidRootPart") and (child.HumanoidRootPart.Position - v1.Position).Magnitude <= 500) then
                u4 = child;
                break;
            end;
        end;
    end;

    if not u4 then
        Popup.Popup(LocalPlayer, "No teammate in line of site");

        return;
    end;

    local u5 = false;
    print(u4);
    interface:AbilityCooldown(3, CookieCross.Cooldown);
    local ABC = interface.ABC;
    StatesController.States.Ability = true;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "GingerbreadCannon");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("GingerbreadCannonBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("GingerbreadCannon", u4);
    ABC:Add(function() -- Line: 94
        -- upvalues: StatesController (ref), u5 (ref)
        StatesController.States.Ability = false;
        u5 = true;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(u6, p7, p8) -- Line: 99
        -- upvalues: StatesController (ref), Character (copy), u4 (ref), BallController (ref), ABC (copy), RunService (ref)
        StatesController.States.Ability = false;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u9 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.05, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 250);
        u6.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position) * CFrame.new(3, 5.5, 0);
        u6.AssemblyLinearVelocity = u9 * math_clamp_ret;
        BallController:DragBall(u6);
        local u10 = tick();
        ABC:Connect(RunService.Heartbeat, function(p11) -- Line: 118
            -- upvalues: u10 (copy), u4 (ref), u6 (copy), ABC (ref), HumanoidRootPart2 (copy), u9 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u10 + 3.5 or not (u4 and (workspace:FindFirstChild("Football") and not u6.OnPlayer.Value)) then
                print(tick() > u10 + 3.5, not u4, not workspace:FindFirstChild("Football"), u6.OnPlayer.Value);

                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v12 = tick() > u10 + 0.55;
            u9 = u9:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v12 and 0.15 or 0.35, 0), 6.5 * p11);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 200);
            print(math_clamp_ret, " Magnitude");

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                print("Ended Here");

                return ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u9 * math_clamp_ret, 6.5 * p11);
        end);
    end);
    task.delay(2, function() -- Line: 150
        -- upvalues: u5 (ref), ABC (copy), StatesController (ref)
        if u5 then
            return;
        end;

        ABC:Clean();
        StatesController.States.Ability = false;
    end);
end;