  

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
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local AbilityUtils2 = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Modules.WanoDashUtil);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 29
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 33
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 41
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), AbilityUtils2 (copy), RunService (copy)
    local HatSteal = AbilityBalancing.HatSteal;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u9, v10, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(2, HatSteal.Cooldown);
    local ABC = interface.ABC;
    local _ = v10.MoveDirection.Unit;
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    StatesController.SpeedBoost = AbilityBalancing.HatSteal.MoveSpeedValue;
    interface.AbilityService.Ability:Fire("HatSteal", {});
    local Track = AnimationController:GetTrack("Abilities", "EggShuffle");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local _ = v10.MoveDirection.Magnitude > 0.2;
    local u11 = false;
    local u12 = false;
    task.spawn(function() -- Line: 94
        -- upvalues: u11 (ref), Character (copy), ABC (copy), u12 (ref), AbilityUtils2 (ref), RunService (ref), u9 (copy), interface (ref), AbilityUtils (ref), HatSteal (copy), AnimationController (ref)
        while not u11 do
            task.wait();

            if Character.Values.HasBall.Value then
                ABC:Clean();
            end;

            if not u12 then
                local v13 = AbilityUtils2.findNearestPlayer({
                    distance = 13,
                    includeGK = false,
                    team = "Enemy",
                    onBall = true
                });

                if RunService:IsStudio() then
                    v13 = workspace.PassRig;

                    if (v13.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude > 13 then
                        v13 = nil;
                    end;
                end;

                if v13 and u9.CFrame.LookVector:Dot((v13.HumanoidRootPart.Position - u9.Position).Unit) >= 0 then
                    u12 = true;
                    local HumanoidRootPart = v13.HumanoidRootPart;
                    local _ = u9.CFrame.RightVector;
                    math.random(1, 2);
                    interface.AbilityService.Ability:Fire("HatSteal", {
                        Type = "Steal",
                        Target = v13
                    });
                    local LookVector = CFrame.lookAt(u9.Position, (Vector3.new(HumanoidRootPart.Position.X, u9.Position.Y, HumanoidRootPart.Position.Z))).LookVector;
                    local v14, v15 = AbilityUtils.FastDashTo(Character, u9.Position + LookVector * HatSteal.Distance, 2, 0.4, Enum.EasingStyle.Linear);
                    ABC:Add(v14);
                    ABC:Add(v15);
                    local Track2 = AnimationController:GetTrack("Abilities", "HatSteal");
                    Track2.Looped = false;
                    Track2.Priority = Enum.AnimationPriority.Action3;
                    Track2:Play();
                    task.wait(1);
                    u12 = false;
                end;
            end;
        end;
    end);
    ABC:Add(function() -- Line: 147
        -- upvalues: u11 (ref), StatesController (ref)
        u11 = true;
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 156
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
    task.delay(AbilityBalancing.HatSteal.Duration, function() -- Line: 160
        -- upvalues: u11 (ref), ABC (copy)
        if u11 == false then
            ABC:Clean();
        end;
    end);
end;