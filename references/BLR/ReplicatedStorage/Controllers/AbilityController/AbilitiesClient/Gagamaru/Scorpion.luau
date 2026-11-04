  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Scorpion = require(ReplicatedStorage.AbilityBalancing).Scorpion;
local InstinctsReaction = require(script.Parent.InstinctsReaction);

return function(u1, p2, u3) -- Line: 16, Name: Scorpion
    -- upvalues: InstinctsReaction (copy), Scorpion (copy), ReplicatedStorage (copy), RunService (copy)
    print(p2.Character:GetAttribute("JumpCatch"));

    if u3.Values.Diving.Value and (u3.Values.Goalie.Value == true and not p2.Character:GetAttribute("JumpCatch")) then
        print("Passed");
        InstinctsReaction(u1, p2, u3);

        return;
    end;

    if u3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("1", Scorpion.Cooldown);

    if u3.Values.IsInPenalty.Value ~= false and u3.Values.Goalie.Value ~= false then
        if u3.Values.IsInPenalty.Value == true and u3.Values.Goalie.Value == true then
            u1.StatesController.States.Ability = true;
            u1.StatesController.OwnWalkState = true;
            task.delay(0.5, function() -- Line: 86
                -- upvalues: u1 (copy)
                u1.StatesController.States.Ability = false;
                u1.StatesController.OwnWalkState = false;
            end);
            u1.Animations:StopAnims();
            u1.Animations.Abilities.ScorpionKick.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.ScorpionKick:Play();
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.Parent = u3.HumanoidRootPart;
            BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = u3.HumanoidRootPart;
            BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
            local Unit = (ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Unit;
            local v4 = (1 - math.clamp((ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Magnitude / 150, 0.1, 1)) * 150;
            BodyVelocity.Velocity = Vector3.new(Unit.X, 0, Unit.Z) * v4 + Vector3.new(0, (Unit.Y + 0.35) * v4, 0);
            task.delay(0.1, function() -- Line: 118
                -- upvalues: BodyVelocity (copy), BodyGyro (copy)
                BodyVelocity:Destroy();
                BodyGyro:Destroy();
            end);
            u1.AbilityService.Ability:Fire("ScorpionKick", "Goal");
            local u5 = false;
            u1.ABC:Connect(RunService.RenderStepped, function(p6) -- Line: 126
                -- upvalues: u3 (copy), u5 (ref), u1 (copy), Scorpion (ref)
                if u3:FindFirstChild("Ring") then
                    u3.Ring:Destroy();
                end;

                if u5 then
                    return;
                end;

                if u3.Values.HasBall.Value then
                    u1.ABC:Clean();
                    u5 = true;
                    u1.BallService.Shoot:Fire(Scorpion.ShotPower, nil, nil, workspace.CurrentCamera.CFrame.LookVector);
                end;
            end);
            task.delay(1, function() -- Line: 139
                -- upvalues: u1 (copy)
                u1.ABC:Clean();
            end);
        end;

        return;
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    task.delay(0.85, function() -- Line: 34
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ScorpionKick.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ScorpionKick:Play();
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = u3.HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u3.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local v7 = (ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Unit / 1.5 * Vector3.new(1, 0.1, 1);
    local math_clamp_ret = math.clamp((ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Magnitude * 2, 75, 90);
    BodyVelocity.Velocity = (Vector3.new(workspace.CurrentCamera.CFrame.LookVector.X, 0.8, workspace.CurrentCamera.CFrame.LookVector.Z) + v7).Unit * math_clamp_ret;
    task.delay(0.1, function() -- Line: 59
        -- upvalues: BodyVelocity (copy), BodyGyro (copy)
        BodyVelocity:Destroy();
        BodyGyro:Destroy();
    end);
    u1.AbilityService.Ability:Fire("ScorpionKick");
    local u8 = false;
    u1.ABC:Connect(RunService.RenderStepped, function(p9) -- Line: 67
        -- upvalues: u3 (copy), u8 (ref), u1 (copy), Scorpion (ref)
        if u3:FindFirstChild("Ring") then
            u3.Ring:Destroy();
        end;

        if u8 then
            return;
        end;

        if u3.Values.HasBall.Value then
            u1.ABC:Clean();
            u8 = true;
            u1.BallService.Shoot:Fire(Scorpion.ShotPower, nil, nil, workspace.CurrentCamera.CFrame.LookVector);
        end;
    end);
    task.delay(1, function() -- Line: 80
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
end;