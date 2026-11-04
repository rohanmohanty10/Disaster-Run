  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local RunService2 = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 18
    -- upvalues: ReplicatedStorage (copy), Players (copy), RunService (copy), AbilityBalancing (copy), Popup (copy), AbilityUtils (copy), RunService2 (copy)
    if u2.Character.Values.HasBall.Value == true then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.OnPlayer.Value;
    local Value3 = Value.Char.Value;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value3);
    local v4;

    if Value3 then
        v4 = Value3:GetAttribute("IsTrainingDummy");
    else
        v4 = Value3;
    end;

    if RunService:IsStudio() then
        Value3 = workspace.PassRig;
    else
        if not (Value2 and (Value3 and (PlayerFromCharacter and (PlayerFromCharacter.Team ~= u2.Team and Value3.Values.Goalie.Value == false))) or Value2 and v4) then
            Popup.Popup(u2, "Must be near player with ball!");

            return;
        end;

        if (Value3.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude >= AbilityBalancing.DeathOfStriker.ActivationRangePlayer then
            Popup.Popup(u2, "Must be near player with ball!");

            return;
        end;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 54
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1:AbilityCooldown("1", AbilityBalancing.DeathOfStriker.Cooldown);
    u1.AbilityService.Ability:Fire("DeathOfStriker", Value3);
    local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
    u1.ABC:Add(task.delay(15, function() -- Line: 67
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(u5) -- Line: 71
        -- upvalues: AbilityBalancing (ref), u2 (copy), Players (ref), LookVector (copy), RunService (ref), AbilityUtils (ref), RunService2 (ref), u1 (copy), ReplicatedStorage (ref)
        local ShotPower = AbilityBalancing.DeathOfStriker.ShotPower;
        local Character = u2.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        local v6 = 0;
        local u7 = nil;

        for _, v in pairs(Players:GetPlayers()) do
            if v.Team == u2.Team and v.Character then
                local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v8 = HumanoidRootPart.Position - Character.Position;
                    local Magnitude = v8.Magnitude;
                    print(v, Magnitude);
                    local v9 = LookVector:Dot(v8.Unit);
                    print(v9);

                    if v9 > 0 and (Magnitude < 230 and v6 < Magnitude) then
                        u7 = HumanoidRootPart;
                        v6 = Magnitude;
                    end;
                end;
            end;
        end;

        if not u7 then
            if RunService:IsStudio() then
                u7 = workspace.PassRig.HumanoidRootPart;
            else
                u7 = AbilityUtils.findNearestPlayer({
                    distance = 999,
                    team = "Ally",
                    includeGK = false
                });

                if u7 then
                    u7 = u7.HumanoidRootPart;
                end;
            end;
        end;

        local v10 = LookVector + AbilityBalancing.DeathOfStriker.ShotTiltVector;

        if u7 then
            print("Locking on to:", u7.Parent.Name);
            v10 = (u7.Position - Character.Position).Unit;
        end;

        u5.AssemblyLinearVelocity = v10 * ShotPower;

        if u7 then
            local os_clock_ret = os.clock();
            local u11 = nil;
            u11 = RunService2.Heartbeat:Connect(function() -- Line: 125
                -- upvalues: u5 (copy), u7 (ref), u11 (ref), os_clock_ret (copy)
                if not (u5.Parent and u7.Parent) then
                    u11:Disconnect();

                    return;
                end;

                local v12 = u7.Position - u5.Position;

                if v12.Magnitude > 2 and os.clock() - os_clock_ret < 3 then
                    u5.AssemblyLinearVelocity = v12.Unit * 110;

                    return;
                end;

                u11:Disconnect();
                u5.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end);
        end;

        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
        u1.Camera.Cutscene = false;
        print();
    end);
end;