  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local OffBalance = require(ReplicatedStorage.AbilityBalancing).OffBalance;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

local function isInRightCone(p1, p2, p3, p4) -- Line: 13
    local v5 = p2 - p1.Position;

    if p4 < v5.Magnitude then
        return false;
    end;

    local v6 = p1.LookVector:Dot(v5.Unit);
    local math_acos_ret = math.acos(v6);

    return math.deg(math_acos_ret) <= p3 / 2;
end;

return function(u7, u8, u9) -- Line: 32, Name: OffBalance
    -- upvalues: AbilityUtils (copy), ReplicatedStorage (copy), OffBalance (copy), Players (copy), RunService (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    if u7.ABC then
        u7.ABC:Clean();
    end;

    local HumanoidRootPart = u9.HumanoidRootPart;
    u7.StatesController.States.Ability = true;
    u7.StatesController.OwnWalkState = true;
    u7.ABC:Add(function() -- Line: 47
        -- upvalues: u7 (copy)
        u7.StatesController.States.Ability = false;
        u7.StatesController.OwnWalkState = false;
    end);
    u7.Animations.Abilities.OffBalanceNew.Priority = Enum.AnimationPriority.Action4;
    u7.Animations.Abilities.OffBalanceNew:Play();
    u7.ABC:Connect(u7.AbilityService.Ability, function() -- Line: 55
        -- upvalues: u7 (copy)
        u7.ABC:Clean();
    end);
    u7:AbilityCooldown("1", 40);
    u7.AbilityService.Ability:Fire("OffBalance", {
        Type = "Effect"
    });
    task.wait(0.2);
    u7.ABC:Connect(u7.AbilityService.Ability, function() -- Line: 65
        -- upvalues: u7 (copy), ReplicatedStorage (ref)
        u7.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u9, HumanoidRootPart.Position + Unit * OffBalance.TravelDistance, -2, 0.2);
    local Players2 = Players:GetPlayers();
    local u10 = nil;
    local u11 = tick();
    u7.ABC:Connect(RunService.Heartbeat, function() -- Line: 77
        -- upvalues: Players2 (copy), u8 (copy), u9 (copy), OffBalance (ref), u10 (ref), ReplicatedStorage (ref), u7 (copy), u11 (copy)
        for _, v in Players2 do
            if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= u8.Team) then
                local CFrame = u9.HumanoidRootPart.CFrame;
                local v12 = v.Character.HumanoidRootPart.Position - CFrame.Position;
                local v13;

                if OffBalance.ActivationRangePlayer < v12.Magnitude then
                    v13 = false;
                else
                    local v14 = CFrame.LookVector:Dot(v12.Unit);
                    local math_acos_ret = math.acos(v14);
                    v13 = math.deg(math_acos_ret) <= 45;
                end;

                if v13 and not v.Character:GetAttribute("IFrames") then
                    if not (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value) then
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

            if OffBalance.ActivationRangePlayer < v15.Magnitude then
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
            u7.AbilityService.Ability:Fire("OffBalance", {
                target = u10
            });
            u7.ABC:Clean();
        end;

        if tick() - u11 >= 0.2 then
            u7.ABC:Clean();
        end;
    end);
end;