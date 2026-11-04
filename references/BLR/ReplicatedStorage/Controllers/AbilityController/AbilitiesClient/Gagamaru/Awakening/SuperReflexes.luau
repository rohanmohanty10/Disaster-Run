  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function findFarthestAheadTeammate(p1) -- Line: 23
    -- upvalues: LocalPlayer (copy), Players (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and LocalPlayer.Team) then
        return nil;
    end;

    local v2 = LocalPlayer.Team.Name == "Away" and 1 or -1;
    local v3 = 0;
    local v4 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and v.Team == LocalPlayer.Team then
            local Character2 = v.Character;
            local v5;

            if Character2 then
                v5 = Character2:FindFirstChild("HumanoidRootPart");
            else
                v5 = Character2;
            end;

            local v6;

            if Character2 then
                v6 = Character2:FindFirstChildOfClass("Humanoid");
            else
                v6 = Character2;
            end;

            local v7;

            if Character2 then
                v7 = Character2:FindFirstChild("Values");
            else
                v7 = Character2;
            end;

            if v7 then
                v7 = v7:FindFirstChild("InCutscene");
            end;

            if v5 and (v6 and (v6.Health > 0 and not (v7 and v7.Value))) then
                local v8 = v5.Position - Character.Position;
                local v9 = v8.X * v2;

                if v3 < v9 and v8.Magnitude <= p1 then
                    v4 = Character2;
                    v3 = v9;
                end;
            end;
        end;
    end;

    return v4;
end;

return function() -- Line: 57
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), findFarthestAheadTeammate (copy), interface (copy), StatesController (copy), BallController (copy), RunService (copy)
    local SuperReflexes = AbilityBalancing.SuperReflexes;
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if not (Character.Values.Goalie.Value and (Character.Values.IsInPenalty.Value and (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.airBall(LocalPlayer, 70) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3)))))) then
        return;
    end;

    local v10 = findFarthestAheadTeammate(SuperReflexes.PassRange);

    if not v10 then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v10);
    AbilityUtils.clientCutsceneSkill(interface, SuperReflexes, 17, 3, false, nil, true);
    local ABC = interface.ABC;
    ABC:Connect(interface.AbilityService.Ability, function(u11, u12) -- Line: 85
        -- upvalues: StatesController (ref), BallController (ref), ABC (copy), RunService (ref)
        if u12 then
            u12 = u12:FindFirstChild("HumanoidRootPart");
        end;

        if not (u11 and u12) then
            return;
        end;

        StatesController.States.Ability = false;
        local u13 = (u12.Position - u11.Position).Unit + Vector3.new(0, 0.35, 0);
        local math_clamp_ret = math.clamp((u12.Position - u11.Position).Magnitude * 1.5, 0, 150);
        u11.AssemblyLinearVelocity = u13 * math_clamp_ret;
        BallController:DragBall(u11);
        local u14 = tick();
        ABC:Connect(RunService.Heartbeat, function(p15) -- Line: 98
            -- upvalues: u14 (copy), u11 (copy), ABC (ref), u12 (copy), u13 (ref), math_clamp_ret (ref)
            if tick() > u14 + 2 or (not u11.Parent or u11.OnPlayer.Value) then
                ABC:Clean();

                return;
            end;

            local Magnitude = (u12.Position - u11.Position).Magnitude;

            if Magnitude <= 7 then
                ABC:Clean();

                return;
            end;

            local v16 = tick() > u14 + 0.55 and 0.15 or 0.35;
            u13 = u13:Lerp((u12.Position - u11.Position).Unit + Vector3.new(0, v16, 0), 6.5 * p15);
            math_clamp_ret = math.clamp(Magnitude * 2.75, 0, 150);
            u11.AssemblyLinearVelocity = u11.AssemblyLinearVelocity:Lerp(u13 * math_clamp_ret, 6.5 * p15);
        end);
    end);
end;