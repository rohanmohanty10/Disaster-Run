  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3, p4, u5) -- Line: 17, Name: DragonHeader
    -- upvalues: ReplicatedStorage (copy), AbilityBalancing (copy), RunService (copy), Debris (copy)
    if ReplicatedStorage.Football.Value.IFrame.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if u3.Values.HasBall.Value == false then
        return;
    end;

    if game.Players.LocalPlayer.PlayerStats.Stamina.Value <= 20 then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("3", AbilityBalancing.DemonHeader.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.DemonHeader.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.DemonHeader:Play();
    u1.Animations.Ball.DemonHeaderBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.DemonHeaderBall:Play();
    u1.AbilityService.Ability:Fire("DemonHeader");

    if u3.Values.HasBall.Value then
        u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 38
            -- upvalues: u1 (copy), AbilityBalancing (ref), u3 (copy), RunService (ref), u2 (copy), Debris (ref)
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            local u7 = workspace.CurrentCamera.CFrame.LookVector + AbilityBalancing.DemonHeader.ShotTiltVector;
            local PlrFootball = u3:FindFirstChild("PlrFootball");
            local v8 = PlrFootball and PlrFootball:FindFirstChild("BallAnims") and PlrFootball.BallAnims:FindFirstChild("BALL");

            if v8 and (u6.Position - v8.Position).Magnitude <= 20 then
                u6.CFrame = v8.CFrame;
            end;

            u6.AssemblyLinearVelocity = u7 * AbilityBalancing.DemonHeader.ShotPower;
            u1.BallController:DragBall(u6);
            local ShotDuration = AbilityBalancing.DemonHeader.ShotDuration;
            local ShotPower = AbilityBalancing.DemonHeader.ShotPower;
            local u9 = tick();
            local Position = u6.Position;
            local u10 = nil;
            u10 = RunService.Stepped:Connect(function(p11, p12) -- Line: 61
                -- upvalues: ShotPower (ref), u6 (copy), u10 (ref), u7 (copy), u9 (copy), ShotDuration (copy), Position (copy)
                ShotPower = math.max(ShotPower - 130 * p12, 40);

                if u6.AssemblyLinearVelocity.Magnitude <= 100 then
                    print("discon");
                    u10:Disconnect();
                end;

                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret.FilterDescendantsInstances = { u6 };
                RaycastParams_new_ret.CollisionGroup = "Trajectory";
                local v13 = workspace:Raycast(u6.Position, u7 * 10, RaycastParams_new_ret);

                if ShotDuration <= tick() - u9 or v13 and v13.Instance or (u6.OnPlayer.Value or (u6.Position - Position).Magnitude >= 200) then
                    u10:Disconnect();

                    return;
                end;

                u6.AssemblyLinearVelocity = u7 * ShotPower;
            end);
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.Parent = u2.Character.HumanoidRootPart;
            BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
            Debris:AddItem(BodyGyro, 0.15);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = u2.Character.HumanoidRootPart;
            BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
            BodyVelocity.Velocity = (u2.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * 60;
            Debris:AddItem(BodyVelocity, 0.15);
            u1.ABC:Clean();
        end);
    end;

    task.delay(1, function() -- Line: 98
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    task.delay(3, function() -- Line: 103
        -- upvalues: u1 (copy), u5 (copy)
        if u1.RunId == u5 then
            u1.ABC:Clean();
        end;
    end);
end;