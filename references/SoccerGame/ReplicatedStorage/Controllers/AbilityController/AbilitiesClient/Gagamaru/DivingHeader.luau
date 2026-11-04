  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local DivingHeader = require(ReplicatedStorage.AbilityBalancing).DivingHeader;

return function(u1, u2, u3) -- Line: 14, Name: DivingHeader
    -- upvalues: ReplicatedStorage (copy), DivingHeader (copy), Popup (copy), RunService (copy)
    if u3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Values.IsInPenalty.Value ~= false and u3.Values.Goalie.Value ~= false then
        if u3.Values.IsInPenalty.Value == true and u3.Values.Goalie.Value == true then
            if u2.PlayerStats.InAwakening.Value == false then
                u1:AbilityCooldown("2", DivingHeader.Cooldown - 5);
                u1.StatesController.SpeedBoost = DivingHeader.MoveSpeedValue;
                u1.InSuper = true;
                ReplicatedStorage.VfxSpawn:FireServer("SuperReaction");
                local u4 = nil;
                u4 = u2.Character.Values.IsInPenalty:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 76
                    -- upvalues: u2 (copy), u1 (copy), u4 (ref)
                    if not u2.Character.Values.IsInPenalty.Value then
                        u1.StatesController.SpeedBoost = 0;
                        u1.InSuper = false;

                        if u4 then
                            u4:Disconnect();
                        end;
                    end;
                end);
                task.delay(7, function() -- Line: 84
                    -- upvalues: u4 (ref), u1 (copy)
                    if u4 then
                        u4:Disconnect();
                    end;

                    u1.StatesController.SpeedBoost = 0;
                    u1.InSuper = false;
                end);

                return;
            end;

            u1:AbilityCooldown("2", DivingHeader.Cooldown);
            local HumanoidRootPart = u3.HumanoidRootPart;
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            u1.AbilityService.Ability:Fire("GagamaruHeader", "Handstand");
            local u5 = false;
            u1.ABC:Connect(RunService.RenderStepped, function(p6) -- Line: 99
                -- upvalues: u3 (copy), u1 (copy), u5 (ref)
                if u3:FindFirstChild("Ring") then
                    u3.Ring:Destroy();
                    u1.ABC:Clean();

                    if u5 then
                        return;
                    end;

                    u1.StatesController.States.Ability = true;
                    task.delay(0.9, function() -- Line: 110
                        -- upvalues: u1 (ref)
                        u1.StatesController.States.Ability = false;
                    end);
                    u1.Animations:StopAnims();
                    u1.Animations.Abilities.HandstandActive.Priority = Enum.AnimationPriority.Action4;
                    u1.Animations.Abilities.HandstandActive:Play();
                    u1.BallService.Shoot:Fire(170, nil, nil, workspace.CurrentCamera.CFrame.LookVector);
                end;
            end);
            local u7 = nil;
            u7 = u2.Character.Values.IsInPenalty:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 124
                -- upvalues: u2 (copy), u1 (copy), u5 (ref), u7 (ref)
                if not u2.Character.Values.IsInPenalty.Value then
                    u1.ABC:Clean();
                    u5 = true;

                    if u7 then
                        u7:Disconnect();
                    end;

                    u1.StatesController.States.Ability = false;
                end;
            end);
            task.delay(2.3, function() -- Line: 133
                -- upvalues: u1 (copy), u7 (ref)
                if u1.ABC then
                    u1.ABC:Clean();

                    if u7 then
                        u7:Disconnect();
                    end;

                    u1.StatesController.States.Ability = false;
                end;
            end);
        end;

        return;
    end;

    if u3.Values.IsInPenalty.Value == false and u3.Values.Goalie.Value == false then
        local v8 = ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position;

        if v8.Magnitude > DivingHeader.ActivationRangePlayer or v8.Y > 37 then
            return;
        end;

        if ReplicatedStorage.Football.Value.OnPlayer.Value then
            return Popup.Popup(u2, "Ball must not be on a player");
        end;

        if ReplicatedStorage.Football.Value.Position.Y > 45 then
            return Popup.Popup(u2, "Ball is too high");
        end;

        if ReplicatedStorage.Football.Value.Position.Y < 18 then
            return Popup.Popup(u2, "Ball must be above you");
        end;
    end;

    u1:AbilityCooldown("2", DivingHeader.Cooldown);
    u1.StatesController.States.Ability = true;
    task.delay(1.05, function() -- Line: 36
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.AbilityService.Ability:Fire("GagamaruHeader");
    u1.Animations:StopAnims();
    u1.Animations.Abilities.GagamaruHeader.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.GagamaruHeader:Play();
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = u3.HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u3.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
    local Magnitude = (Vector3.new(ReplicatedStorage.Football.Value.Position.X, u3.HumanoidRootPart.Position.Y + 2, ReplicatedStorage.Football.Value.Position.Z) - u3.HumanoidRootPart.Position).Magnitude;
    BodyVelocity.Velocity = LookVector * math.clamp(Magnitude, 100, 110) + Vector3.new(0, 25, 0);
    task.delay(0.15, function() -- Line: 62
        -- upvalues: BodyGyro (copy), BodyVelocity (copy)
        BodyGyro:Destroy();
        BodyVelocity:Destroy();
    end);
end;