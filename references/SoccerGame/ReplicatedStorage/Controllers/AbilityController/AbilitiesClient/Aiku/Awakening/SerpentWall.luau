  

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
require(ReplicatedStorage.Controllers.AnimationController);

return function(u1, u2, p3) -- Line: 28
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), Popup (copy), ReplicatedStorage (copy), RunService (copy), Players (copy), RunService2 (copy)
    local SerpentWall = AbilityBalancing.SerpentWall;
    local Character, v4, v5, v6 = AbilityUtils.getCharacter(u2);

    if not (Character and (v4 and (v5 and v6))) then
        return;
    end;

    if v6.Stunned.Value or (v6.Sliding.Value or Character.IsRagdoll.Value) then
        return;
    end;

    local State = v5:GetState();

    if State ~= Enum.HumanoidStateType.Jumping and State ~= Enum.HumanoidStateType.Freefall then
        Popup.Popup(u2, "Must be in the air!");

        return;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not Value or (Value.Anchored or Value.OnPlayer.Value) then
        return;
    end;

    if not (AbilityUtils.rules.offball(u2) and (AbilityUtils.rules.airBall(u2, 50) and (AbilityUtils.rules.slotReady(1) and AbilityUtils.rules.isAwakened(u2)))) then
        return;
    end;

    local v7 = AbilityUtils.rules.enemyTarget((1 / 0), false);

    if RunService:IsStudio() then
        v7 = nil;
    end;

    u1.AbilityService.Ability:Fire("SerpentWall", v7);
    AbilityUtils.clientCutsceneSkill(u1, SerpentWall, 16, 1, false);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u8) -- Line: 66
        -- upvalues: SerpentWall (copy), u2 (copy), Players (ref), RunService2 (ref), u1 (copy), ReplicatedStorage (ref)
        local ShotPower = SerpentWall.ShotPower;
        local ActivationRangePlayer = SerpentWall.ActivationRangePlayer;
        local Character2 = u2.Character;

        if Character2 then
            Character2 = Character2:FindFirstChild("HumanoidRootPart");
        end;

        if not Character2 then
            return;
        end;

        local LookVector = Character2.CFrame.LookVector;
        local v9 = 0;
        local u10 = nil;

        for _, v in pairs(Players:GetPlayers()) do
            if v.Team == u2.Team and v.Character then
                local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v11 = HumanoidRootPart.Position - Character2.Position;
                    local Magnitude = v11.Magnitude;

                    if LookVector:Dot(v11.Unit) > 0 and (Magnitude < ActivationRangePlayer and v9 < Magnitude) then
                        u10 = HumanoidRootPart;
                        v9 = Magnitude;
                    end;
                end;
            end;
        end;

        local v12 = LookVector + SerpentWall.ShotTiltVector;

        if u10 then
            print("Locking on to:", u10.Parent.Name);
            v12 = (u10.Position - Character2.Position).Unit;
        end;

        u8.AssemblyLinearVelocity = v12 * ShotPower;

        if u10 then
            local os_clock_ret = os.clock();
            local u13 = nil;
            u13 = RunService2.Heartbeat:Connect(function() -- Line: 110
                -- upvalues: u8 (copy), u10 (ref), u13 (ref), os_clock_ret (copy), SerpentWall (ref)
                if not (u8.Parent and u10.Parent) then
                    u13:Disconnect();

                    return;
                end;

                local v14 = u10.Position - u8.Position;

                if v14.Magnitude > 2 and os.clock() - os_clock_ret < SerpentWall.ShotDuration then
                    u8.AssemblyLinearVelocity = v14.Unit * 110;

                    return;
                end;

                u13:Disconnect();
                u8.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end);
        end;

        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        u1.ABC:Clean();
    end);
end;