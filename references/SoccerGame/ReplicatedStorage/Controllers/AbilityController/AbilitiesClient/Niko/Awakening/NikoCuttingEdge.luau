  

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

return function() -- Line: 17
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), RunService (copy), Popup (copy), Players (copy), interface (copy), StatesController (copy), BallController (copy), ReplicatedStorage (copy)
    local NikoCuttingEdge = AbilityBalancing.NikoCuttingEdge;

    if not (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.slotReady(2) and AbilityUtils.rules.isAwakened(LocalPlayer)))) then
        return;
    end;

    if not RunService:IsStudio() and AbilityUtils.countTeammates(LocalPlayer) < 1 then
        Popup.Popup(LocalPlayer, "Need a teammate on your team!");

        return;
    end;

    local Character, u1 = AbilityUtils.getCharacter(LocalPlayer);
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (Character and (u1 and workspace_CurrentCamera)) then
        return;
    end;

    local Team = LocalPlayer.Team;
    local v2 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v2.Magnitude < 0.001 then
        v2 = u1.CFrame.LookVector * Vector3.new(1, 0, 1);
    end;

    if v2.Magnitude < 0.001 then
        return;
    end;

    local Unit = v2.Unit;
    local v3 = 0.5000000000000001;
    local v4 = (1 / 0);
    local u5 = nil;

    for _, v in AbilityUtils.findTopTeammates(LocalPlayer, 999) do
        if Players:GetPlayerFromCharacter(v) or RunService:IsStudio() then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                HumanoidRootPart = (HumanoidRootPart.Position - u1.Position) * Vector3.new(1, 0, 1);
            end;

            local v6 = HumanoidRootPart and (HumanoidRootPart.Magnitude or 0) or 0;

            if v6 > 0.001 and v6 <= NikoCuttingEdge.PassRange then
                local v7 = Unit:Dot(HumanoidRootPart.Unit);
                local math_clamp_ret = math.clamp(v7, -1, 1);

                if math_clamp_ret >= 0.5000000000000001 and (v3 + 0.0001 < math_clamp_ret or math.abs(math_clamp_ret - v3) <= 0.0001 and v6 < v4) then
                    u5 = v;
                    v4 = v6;
                    v3 = math_clamp_ret;
                end;
            end;
        end;
    end;

    if u5 then
        interface:AbilityCooldown(2, NikoCuttingEdge.Cooldown);
        AbilityUtils.clientCutsceneSkill(interface, NikoCuttingEdge, 10, nil, false, nil, true);
        local ABC = interface.ABC;
        ABC:Connect(interface.AbilityService.Ability, function(u8, u9) -- Line: 81
            -- upvalues: interface (ref), ABC (copy), u5 (ref), StatesController (ref), Players (ref), BallController (ref), RunService (ref), Team (copy), LocalPlayer (ref), Character (copy), u1 (copy), ReplicatedStorage (ref)
            if not (u8 and u9) then
                interface:AbilityCooldown(2, 0);
                interface.AbilityTwo = 0;
                ABC:Clean();

                return;
            end;

            if u9 ~= u5 then
                return;
            end;

            StatesController.States.Ability = false;
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u9);
            local HumanoidRootPart = u9:FindFirstChild("HumanoidRootPart");
            local u10 = u9:FindFirstChildOfClass("Humanoid");

            if not (HumanoidRootPart and u10) then
                ABC:Clean();

                return;
            end;

            local v11 = HumanoidRootPart.Position + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - u8.Position;

            if v11.Magnitude < 0.001 then
                ABC:Clean();

                return;
            end;

            local u12 = v11.Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret = math.clamp((HumanoidRootPart.Position - u8.Position).Magnitude * 1.5, 80, 150);
            u8.AssemblyLinearVelocity = u12 * math_clamp_ret;
            BallController:DragBall(u8);
            local ServerTimeNow = workspace:GetServerTimeNow();
            ABC:Connect(RunService.Heartbeat, function(p13) -- Line: 114
                -- upvalues: HumanoidRootPart (copy), u9 (copy), u10 (copy), PlayerFromCharacter (copy), Players (ref), Team (ref), LocalPlayer (ref), Character (ref), u1 (ref), u8 (copy), ReplicatedStorage (ref), ServerTimeNow (copy), ABC (ref), u12 (ref), math_clamp_ret (ref)
                local v14;

                if HumanoidRootPart.Parent == u9 and (u10.Parent == u9 and u10.Health > 0) then
                    v14 = u9.Parent;

                    if v14 then
                        v14 = not PlayerFromCharacter;

                        if not v14 then
                            if PlayerFromCharacter.Parent == Players and PlayerFromCharacter.Character == u9 then
                                v14 = PlayerFromCharacter.Team == Team;
                            else
                                v14 = false;
                            end;
                        end;
                    end;
                else
                    v14 = false;
                end;

                local v15;

                if LocalPlayer.Parent == Players and (LocalPlayer.Character == Character and LocalPlayer.Team == Team) then
                    v15 = u1.Parent == Character;
                else
                    v15 = false;
                end;

                local v16;

                if u8 == ReplicatedStorage.Football.Value and u8.Parent == workspace then
                    v16 = not u8.OnPlayer.Value and u8.Char.Value == Character;
                else
                    v16 = false;
                end;

                if workspace:GetServerTimeNow() > ServerTimeNow + 2 or not (v14 and (v15 and v16)) then
                    ABC:Clean();

                    return;
                end;

                local v17 = HumanoidRootPart.Position - u8.Position;

                if v17.Magnitude < 0.001 then
                    ABC:Clean();

                    return;
                end;

                u12 = u12:Lerp(v17.Unit + Vector3.new(0, 0.15, 0), 6.5 * p13);
                math_clamp_ret = math.clamp(v17.Magnitude * 2.75, 80, 150);
                u8.AssemblyLinearVelocity = u8.AssemblyLinearVelocity:Lerp(u12 * math_clamp_ret, 6.5 * p13);
            end);
        end);
        interface.AbilityService.Ability:Fire(script.Name, {
            Target = u5
        });

        return true;
    end;

    Popup.Popup(LocalPlayer, "Aim at a teammate in range!");
end;