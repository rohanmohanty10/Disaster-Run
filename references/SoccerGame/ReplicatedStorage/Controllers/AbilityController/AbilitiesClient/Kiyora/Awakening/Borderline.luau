  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 24
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), BallController (copy)
    local Borderline = AbilityBalancing.Borderline;

    if (LocalPlayer:GetAttribute("BorderlineLockUntil") or 0) > workspace:GetServerTimeNow() then
        return;
    end;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.looseBall(LocalPlayer, Borderline.BallRange) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    if not RunService:IsStudio() and AbilityUtils.countTeammates(LocalPlayer) < 1 then
        Popup.Popup(LocalPlayer, "Need a teammate on your team!");

        return;
    end;

    local Character, v1 = AbilityUtils.getCharacter();

    if not (Character and v1) then
        return;
    end;

    local PassRange = Borderline.PassRange;
    local v2 = {};

    for _, v in AbilityUtils.findTopTeammates(LocalPlayer, 999) do
        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart and (HumanoidRootPart.Position - v1.Position).Magnitude <= PassRange then
            table.insert(v2, v);
        end;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v3 = (workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector or v1.CFrame.LookVector) * Vector3.new(1, 0, 1);

    if v3.Magnitude < 0.001 then
        v3 = v1.CFrame.LookVector * Vector3.new(1, 0, 1);
    end;

    if v3.Magnitude < 0.001 then
        return;
    end;

    local Unit = v3.Unit;
    local v4 = (1 / 0);
    local v5 = 0.5000000000000001;
    local v6 = nil;

    for _, v in v2 do
        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart = (HumanoidRootPart.Position - v1.Position) * Vector3.new(1, 0, 1);
        end;

        local v7 = HumanoidRootPart and (HumanoidRootPart.Magnitude or 0) or 0;

        if v7 > 0.001 then
            local v8 = Unit:Dot(HumanoidRootPart.Unit);
            local math_clamp_ret = math.clamp(v8, -1, 1);

            if math_clamp_ret >= 0.5000000000000001 and (v5 + 0.0001 < math_clamp_ret or math.abs(math_clamp_ret - v5) <= 0.0001 and v7 < v4) then
                v6 = v;
                v5 = math_clamp_ret;
                v4 = v7;
            end;
        end;
    end;

    if not v6 then
        Popup.Popup(LocalPlayer, "Aim at a teammate in range!");

        return;
    end;

    local v9 = nil;

    for _, v in v2 do
        if v ~= v6 then
            v9 = v;
            break;
        end;
    end;

    interface.AbilityService.Ability:Fire(script.Name, {
        Teammate1 = v6,
        Teammate2 = v9
    });
    interface:AbilityCooldown(3, Borderline.Cooldown);
    AbilityUtils.clientCutsceneSkill(interface, Borderline, 20, nil, false, nil, true);
    local ABC = interface.ABC;
    ABC:Connect(interface.AbilityService.Ability, function(u10, p11) -- Line: 129
        -- upvalues: StatesController (ref), Character (copy), BallController (ref), ABC (copy), RunService (ref)
        if not (u10 and p11) then
            return;
        end;

        StatesController.States.Ability = false;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local HumanoidRootPart2 = p11:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and HumanoidRootPart2) then
            return;
        end;

        local u12 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u10.AssemblyLinearVelocity = u12 * math_clamp_ret;
        BallController:DragBall(u10);
        local u13 = tick();
        ABC:Connect(RunService.Heartbeat, function(p14) -- Line: 149
            -- upvalues: u13 (copy), u10 (copy), ABC (ref), u12 (ref), HumanoidRootPart2 (copy), math_clamp_ret (ref)
            if tick() > u13 + 2 or (not u10 or u10.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local v15 = tick() > u13 + 0.55;
            u12 = u12:Lerp((HumanoidRootPart2.Position - u10.Position).Unit + Vector3.new(0, v15 and 0.15 or 0.35, 0), 6.5 * p14);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - u10.Position).Magnitude * 2.75, 0, 150);

            if u10.Position.Y < 5 or (HumanoidRootPart2.Position - u10.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u10.AssemblyLinearVelocity = u10.AssemblyLinearVelocity:Lerp(u12 * math_clamp_ret, 6.5 * p14);
        end);
    end);
end;