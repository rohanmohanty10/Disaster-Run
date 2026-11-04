  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local WanoDashUtil = require(ReplicatedStorage.Modules.WanoDashUtil);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 17
    -- upvalues: Popup (copy), AbilityBalancing (copy), AbilityUtils (copy), RunService (copy), WanoDashUtil (copy)
    if u3.Values.HasBall.Value then
        Popup.Popup(p2, "Only usable without ball");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local HumanoidRootPart = u3.HumanoidRootPart;
    local Humanoid = u3.Humanoid;
    u1:AbilityCooldown("3", 30);
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = AbilityBalancing.Bloodlust.MoveSpeedValue;
    u1.AbilityService.Ability:Fire("Bloodlust");

    if Humanoid.MoveDirection.Magnitude > 0.2 then
        u1.Animations.Abilities.Bloodlust.Priority = Enum.AnimationPriority.Action3;
        u1.Animations.Abilities.Bloodlust:Play();
    end;

    u1.ABC:Connect(Humanoid.Running, function(p4) -- Line: 44
        -- upvalues: u1 (copy)
        if p4 > 0.1 then
            if not u1.Animations.Abilities.Bloodlust.IsPlaying then
                u1.Animations.Abilities.Bloodlust:Play();
            end;
        elseif u1.Animations.Abilities.Bloodlust.IsPlaying then
            u1.Animations.Abilities.Bloodlust:Stop();
        end;
    end);
    local u5 = false;
    local u6 = false;
    task.spawn(function() -- Line: 61
        -- upvalues: u5 (ref), u3 (copy), u1 (copy), u6 (ref), AbilityUtils (ref), RunService (ref), HumanoidRootPart (copy), WanoDashUtil (ref)
        while not u5 do
            task.wait();

            if u3.Values.HasBall.Value then
                u1.ABC:Clean();
            end;

            if not u6 then
                local v7 = AbilityUtils.findNearestPlayer({
                    distance = 13,
                    includeGK = false,
                    team = "Enemy"
                });

                if RunService:IsStudio() then
                    v7 = workspace.PassRig;

                    if (v7.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude > 13 then
                        v7 = nil;
                    end;
                end;

                if v7 and HumanoidRootPart.CFrame.LookVector:Dot((v7.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit) >= 0 then
                    u6 = true;
                    local _ = v7.HumanoidRootPart;
                    local RightVector = HumanoidRootPart.CFrame.RightVector;
                    local v8;

                    if math.random(1, 2) == 1 then
                        v8 = { RightVector * 0.3, RightVector * -0.3 + HumanoidRootPart.CFrame.LookVector * 1 };
                        u1.Animations.Abilities.BloodlustRightDash.Priority = Enum.AnimationPriority.Action4;
                        u1.Animations.Abilities.BloodlustRightDash:Play();
                    else
                        v8 = { RightVector * -0.15 + HumanoidRootPart.CFrame.LookVector * 0.2, RightVector * 0.15 + HumanoidRootPart.CFrame.LookVector * 1 };
                        u1.Animations.Abilities.BloodlustLeftDash.Priority = Enum.AnimationPriority.Action4;
                        u1.Animations.Abilities.BloodlustLeftDash:Play();
                    end;

                    WanoDashUtil.DashAdvancedLinear({
                        Duration = 0.3,
                        Power = 150,
                        ResidualFrac = 0.3,
                        BlendStart = 0.75,
                        DelayBetween = 0.15,
                        MaxAxesForce = Vector3.new(100000, 0, 100000),
                        LvName = "StealLV",
                        Character = u3,
                        Directions = v8
                    });
                    task.wait(1);
                    u6 = false;
                end;
            end;
        end;
    end);
    u1.ABC:Add(function() -- Line: 137
        -- upvalues: u1 (copy), AbilityBalancing (ref), u5 (ref)
        u1:AbilityCooldown("3", AbilityBalancing.Bloodlust.Cooldown);
        u1.Animations.Abilities.Bloodlust:Stop();
        u5 = true;
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 148
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
    task.delay(AbilityBalancing.Bloodlust.Duration, function() -- Line: 152
        -- upvalues: u5 (ref), u1 (copy)
        if u5 == false then
            u1.ABC:Clean();
        end;
    end);
end;