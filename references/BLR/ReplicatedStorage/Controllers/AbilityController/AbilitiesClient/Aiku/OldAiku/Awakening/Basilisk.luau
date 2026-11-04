  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Basilisk = require(ReplicatedStorage.AbilityBalancing).Basilisk;

return function(u1, u2, u3) -- Line: 16
    -- upvalues: Popup (copy), ReplicatedStorage (copy), Basilisk (copy), Players (copy), RunService (copy)
    if u2.Character.Values.HasBall.Value == true then
        Popup.Popup(u2, "Must not have ball!)");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;

    if Value.OnPlayer.Value then
        Popup.Popup(u2, "Ball must be loose!");

        return;
    end;

    if (Value.Position - u3.HumanoidRootPart.Position).Magnitude >= Basilisk.ActivationRangeBall then
        Popup.Popup(u2, "Ball too far!");

        return;
    end;

    if Value.Position.Y < 14 then
        Popup.Popup(u2, "Ball not in the air!");

        return;
    end;

    local _ = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 49
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(12, function() -- Line: 58
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 63
        -- upvalues: u1 (copy), Basilisk (ref), u2 (copy), Players (ref), Value (copy), RunService (ref), ReplicatedStorage (ref)
        if p4 == false then
            u1.ABC:Clean();

            return;
        end;

        u1:AbilityCooldown("2", Basilisk.Cooldown);
        local ShotPower = Basilisk.ShotPower;
        local ActivationRangePlayer = Basilisk.ActivationRangePlayer;
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        local LookVector = Character.CFrame.LookVector;
        local v5 = 0;
        local u6 = nil;

        for _, v in pairs(Players:GetPlayers()) do
            if v.Team == u2.Team and v.Character then
                local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v7 = HumanoidRootPart.Position - Character.Position;
                    local Magnitude = v7.Magnitude;

                    if LookVector:Dot(v7.Unit) > 0 and (Magnitude < ActivationRangePlayer and v5 < Magnitude) then
                        u6 = HumanoidRootPart;
                        v5 = Magnitude;
                    end;
                end;
            end;
        end;

        local v8 = LookVector + Basilisk.ShotTiltVector;

        if u6 then
            print("Locking on to:", u6.Parent.Name);
            v8 = (u6.Position - Character.Position).Unit;
        end;

        Value.AssemblyLinearVelocity = v8 * ShotPower;

        if u6 then
            local os_clock_ret = os.clock();
            local u9 = nil;
            u9 = RunService.Heartbeat:Connect(function() -- Line: 112
                -- upvalues: Value (ref), u6 (ref), u9 (ref), os_clock_ret (copy), Basilisk (ref)
                if not (Value.Parent and u6.Parent) then
                    u9:Disconnect();

                    return;
                end;

                local v10 = u6.Position - Value.Position;

                if v10.Magnitude > 2 and os.clock() - os_clock_ret < Basilisk.ShotDuration then
                    Value.AssemblyLinearVelocity = v10.Unit * 110;

                    return;
                end;

                u9:Disconnect();
                Value.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end);
        end;

        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
    u1.AbilityService.Ability:Fire("Basilisk");
end;