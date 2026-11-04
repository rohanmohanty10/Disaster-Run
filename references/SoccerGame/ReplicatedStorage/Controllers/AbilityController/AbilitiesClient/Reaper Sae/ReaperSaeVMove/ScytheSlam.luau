  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Popup);
local ScytheSlam = require(ReplicatedStorage.AbilityBalancing).ScytheSlam;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

local function IsInCone(p1, p2, p3, p4) -- Line: 8
    local v5 = p2 - p1.Position;

    if p4 < v5.Magnitude then
        return false;
    end;

    local v6 = p1.LookVector:Dot(v5.Unit);
    local math_acos_ret = math.acos(v6);

    return math.deg(math_acos_ret) <= p3 / 2;
end;

return function(u7, u8, u9) -- Line: 27
    -- upvalues: ScytheSlam (copy), AbilityUtils (copy), Players (copy), RunService (copy), ReplicatedStorage (copy)
    if u7.ABC then
        u7.ABC:Clean();
    end;

    local HumanoidRootPart = u9:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u7:AbilityCooldown("2", 40);
    u7.Animations:StopAnims();
    u7.Animations.Abilities.ScytheSlam.Priority = Enum.AnimationPriority.Action4;
    u7.Animations.Abilities.ScytheSlam:Play();
    u7.AbilityService.Ability:Fire("ScytheSlam", {
        Type = "Start"
    });
    u7.StatesController.States.Ability = true;
    task.delay(1, function() -- Line: 44
        -- upvalues: u7 (copy)
        u7.StatesController.States.Ability = false;
    end);
    task.wait(0.4);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u9, HumanoidRootPart.Position + Unit * ScytheSlam.TravelDistance, -2, 0.5);
    local Players2 = Players:GetPlayers();
    local u10 = nil;
    local u11 = tick();
    u7.ABC:Connect(RunService.Heartbeat, function() -- Line: 58
        -- upvalues: Players2 (copy), u8 (copy), u9 (copy), ScytheSlam (ref), u10 (ref), ReplicatedStorage (ref), u7 (copy), u11 (copy)
        for _, v in Players2 do
            if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= u8.Team) then
                local CFrame = u9.HumanoidRootPart.CFrame;
                local v12 = v.Character.HumanoidRootPart.Position - CFrame.Position;
                local v13;

                if ScytheSlam.ActivationRangePlayer < v12.Magnitude then
                    v13 = false;
                else
                    local v14 = CFrame.LookVector:Dot(v12.Unit);
                    local math_acos_ret = math.acos(v14);
                    v13 = math.deg(math_acos_ret) <= 45;
                end;

                if v13 and not v.Character:GetAttribute("IFrames") then
                    if not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value or v.Character.Values.Dribbling.Value) then
                        u10 = v.Character;

                        if u10.Name == ReplicatedStorage.Football.Value.Char.Value.Name then
                            break;
                        end;
                    end;
                end;
            end;
        end;

        if workspace:FindFirstChild("PassRig") then
            local CFrame = u9.HumanoidRootPart.CFrame;
            local v15 = workspace.PassRig.HumanoidRootPart.Position - CFrame.Position;
            local v16;

            if ScytheSlam.ActivationRangePlayer < v15.Magnitude then
                v16 = false;
            else
                local v17 = CFrame.LookVector:Dot(v15.Unit);
                local math_acos_ret = math.acos(v17);
                v16 = math.deg(math_acos_ret) <= 45;
            end;

            if v16 then
                u10 = workspace.PassRig;
            end;
        end;

        if u10 then
            u7.AbilityService.Ability:Fire("ScytheSlam", {
                target = u10
            });
            u7.ABC:Clean();
        end;

        if tick() - u11 >= 0.75 then
            u7.ABC:Clean();
        end;
    end);
end;