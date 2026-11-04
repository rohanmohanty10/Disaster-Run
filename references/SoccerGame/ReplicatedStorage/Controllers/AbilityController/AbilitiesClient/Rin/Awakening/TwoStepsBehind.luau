  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local Popup = require(ReplicatedStorage.Shared.Popup);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 25
    -- upvalues: interface (copy), AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), RunService (copy), Popup (copy), Players (copy), StatesController (copy), BallController (copy), ReplicatedStorage (copy)
    if interface.RinTwoStepsBehindUsed or interface.RinTwoStepsBehindPending then
        return;
    end;

    local TwoStepsBehind = AbilityBalancing.TwoStepsBehind;
    local v1 = AbilityUtils.rules.enemyTarget(TwoStepsBehind.EnemyRange);

    if not (v1 and (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(2)))) then
        return;
    end;

    if not RunService:IsStudio() and AbilityUtils.countTeammates(LocalPlayer) < 1 then
        Popup.Popup(LocalPlayer, "Need a teammate on your team!");

        return;
    end;

    local Character, u2 = AbilityUtils.getCharacter();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (Character and (u2 and workspace_CurrentCamera)) then
        return;
    end;

    local Team = LocalPlayer.Team;
    local v3 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v3.Magnitude < 0.001 then
        v3 = u2.CFrame.LookVector * Vector3.new(1, 0, 1);
    end;

    if v3.Magnitude < 0.001 then
        return;
    end;

    local Unit = v3.Unit;
    local v4 = 0.5000000000000001;
    local v5 = (1 / 0);
    local u6 = nil;

    for _, v in AbilityUtils.findTopTeammates(LocalPlayer, 999) do
        if Players:GetPlayerFromCharacter(v) or RunService:IsStudio() then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                HumanoidRootPart = (HumanoidRootPart.Position - u2.Position) * Vector3.new(1, 0, 1);
            end;

            local v7 = HumanoidRootPart and (HumanoidRootPart.Magnitude or 0) or 0;

            if v7 > 0.001 and v7 <= TwoStepsBehind.TeammateRange then
                local v8 = Unit:Dot(HumanoidRootPart.Unit);
                local math_clamp_ret = math.clamp(v8, -1, 1);

                if math_clamp_ret >= 0.5000000000000001 and (v4 + 0.0001 < math_clamp_ret or math.abs(math_clamp_ret - v4) <= 0.0001 and v7 < v5) then
                    u6 = v;
                    v5 = v7;
                    v4 = math_clamp_ret;
                end;
            end;
        end;
    end;

    if not u6 then
        Popup.Popup(LocalPlayer, "Aim at a teammate in range!");

        return;
    end;

    interface.RinTwoStepsBehindPending = true;
    AbilityUtils.clientCutsceneSkill(interface, TwoStepsBehind, 18, nil, false, nil, true);
    local ABC = interface.ABC;
    ABC:Add(function() -- Line: 95
        -- upvalues: interface (ref)
        if interface.RinTwoStepsBehindPending then
            interface.RinTwoStepsBehindPending = nil;
            interface.RinTwoStepsBehindUsed = nil;
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(u9, u10, p11) -- Line: 102
        -- upvalues: interface (ref), StatesController (ref), ABC (copy), u6 (ref), Players (ref), BallController (ref), RunService (ref), Team (copy), LocalPlayer (ref), Character (copy), u2 (copy), ReplicatedStorage (ref)
        if p11 == "accepted" then
            interface.RinTwoStepsBehindPending = nil;
            interface.RinTwoStepsBehindUsed = true;

            return;
        end;

        if p11 == "consumed_abort" then
            interface.RinTwoStepsBehindPending = nil;
            interface.RinTwoStepsBehindUsed = true;
            StatesController.States.Ability = false;
            ABC:Clean();

            return;
        end;

        if not (u9 and u10) then
            interface.RinTwoStepsBehindPending = nil;
            interface.RinTwoStepsBehindUsed = nil;
            ABC:Clean();

            return;
        end;

        if u10 ~= u6 then
            return;
        end;

        interface.RinTwoStepsBehindPending = nil;
        interface.RinTwoStepsBehindUsed = true;
        StatesController.States.Ability = false;
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u10);
        local HumanoidRootPart = u10:FindFirstChild("HumanoidRootPart");
        local u12 = u10:FindFirstChildOfClass("Humanoid");

        if not (HumanoidRootPart and u12) then
            ABC:Clean();

            return;
        end;

        local v13 = HumanoidRootPart.Position + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - u9.Position;

        if v13.Magnitude < 0.001 then
            ABC:Clean();

            return;
        end;

        local u14 = v13.Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart.Position - u9.Position).Magnitude * 1.5, 80, 150);
        u9.AssemblyLinearVelocity = u14 * math_clamp_ret;
        BallController:DragBall(u9);
        local ServerTimeNow = workspace:GetServerTimeNow();
        ABC:Connect(RunService.Heartbeat, function(p15) -- Line: 149
            -- upvalues: HumanoidRootPart (copy), u10 (copy), u12 (copy), PlayerFromCharacter (copy), Players (ref), Team (ref), LocalPlayer (ref), Character (ref), u2 (ref), u9 (copy), ReplicatedStorage (ref), ServerTimeNow (copy), ABC (ref), u14 (ref), math_clamp_ret (ref)
            local v16;

            if HumanoidRootPart.Parent == u10 and (u12.Parent == u10 and u12.Health > 0) then
                v16 = u10.Parent;

                if v16 then
                    if PlayerFromCharacter == nil then
                        v16 = true;
                    elseif PlayerFromCharacter.Parent == Players and PlayerFromCharacter.Character == u10 then
                        v16 = PlayerFromCharacter.Team == Team;
                    else
                        v16 = false;
                    end;
                end;
            else
                v16 = false;
            end;

            local v17;

            if LocalPlayer.Parent == Players and (LocalPlayer.Character == Character and LocalPlayer.Team == Team) then
                v17 = u2.Parent == Character;
            else
                v17 = false;
            end;

            local v18;

            if u9 == ReplicatedStorage.Football.Value and u9.Parent == workspace then
                v18 = not u9.OnPlayer.Value and u9.Char.Value == Character;
            else
                v18 = false;
            end;

            if workspace:GetServerTimeNow() > ServerTimeNow + 2 or not (v16 and (v17 and v18)) then
                ABC:Clean();

                return;
            end;

            local v19 = HumanoidRootPart.Position - u9.Position;

            if v19.Magnitude < 0.001 then
                ABC:Clean();

                return;
            end;

            u14 = u14:Lerp(v19.Unit + Vector3.new(0, 0.15, 0), 6.5 * p15);
            math_clamp_ret = math.clamp(v19.Magnitude * 2.75, 80, 150);
            u9.AssemblyLinearVelocity = u9.AssemblyLinearVelocity:Lerp(u14 * math_clamp_ret, 6.5 * p15);
        end);
    end);
    interface.AbilityService.Ability:Fire(script.Name, {
        EnemyChar = v1,
        TeammateChar = u6
    });
end;