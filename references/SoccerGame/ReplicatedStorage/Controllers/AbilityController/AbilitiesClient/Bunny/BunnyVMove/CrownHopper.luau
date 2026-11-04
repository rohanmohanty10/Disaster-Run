  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

local function StunPlayers(p1, p2, p3) -- Line: 14
    -- upvalues: Players (copy)
    local Players2 = Players:GetPlayers();
    local v4 = {};
    local v5 = 25;
    local v6 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v7 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v7);

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                table.insert(v4, v.Character);
            end;
        end;
    end;

    for _, v in pairs(v4) do
        local Magnitude = (v.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v5 then
            v6 = v;
            v5 = Magnitude;
        end;
    end;

    table.clear(v4);
    table.clear(Players2);
    p1.AbilityService.Ability:Fire("CrownHopper", v6);
end;

return function(u8, p9, u10) -- Line: 56, Name: CrownHopper
    -- upvalues: AbilityBalancing (copy), StunPlayers (copy), TweenService (copy), AbilityUtils (copy)
    if u8.ABC then
        u8.ABC:Clean();
    end;

    local MoveSpeedValue = AbilityBalancing.CrownHopper.MoveSpeedValue;
    local HumanoidRootPart = u10.HumanoidRootPart;
    u8.AbilityService.Ability:Fire("CrownHopper", "Dash");
    u8.Animations:StopAnims();
    u8.StatesController.States.Ability = true;
    u8.Animations.Abilities.CrownHopper.Priority = Enum.AnimationPriority.Action4;
    u8.Animations.Abilities.CrownHopper:Play();
    u8.Animations.Ball.CrownHopperBall.Priority = Enum.AnimationPriority.Action4;
    u8.Animations.Ball.CrownHopperBall:Play();
    u8:AutoCharacterRotateToCamera(true);
    task.spawn(StunPlayers, u8, p9, u10);
    task.delay(2, function() -- Line: 83
        -- upvalues: u8 (copy)
        if u8.ABC then
            u8.ABC:Clean();
        end;
    end);
    task.wait(0.27);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(15000, 0, 15000);
    BodyVelocity.Velocity = -HumanoidRootPart.CFrame.LookVector * MoveSpeedValue;
    BodyVelocity.Parent = HumanoidRootPart;
    u8.ABC:Add(function() -- Line: 93
        -- upvalues: u8 (copy), BodyVelocity (copy), u10 (copy), AbilityBalancing (ref)
        u8:AutoCharacterRotateToCamera(false);
        u8.StatesController.States.Ability = false;

        if BodyVelocity then
            BodyVelocity:Destroy();
        end;

        u10:AddTag("CrownHopped");
        task.delay(2.5, function() -- Line: 99
            -- upvalues: u8 (ref), u10 (ref), AbilityBalancing (ref)
            if u8.AbilityTwo > tick() then
                return;
            end;

            u10:RemoveTag("CrownHopped");
            u8:AbilityCooldown("2", AbilityBalancing.CrownHopper.Cooldown);
        end);
    end);
    task.wait(0.9);
    TweenService:Create(BodyVelocity, TweenInfo.new(0.2), {
        Velocity = Vector3.new(0, 0, 0)
    }):Play();
    task.wait(0.1);
    BodyVelocity:Destroy();
    AbilityUtils.FastDashTo(u10, HumanoidRootPart.Position + (-HumanoidRootPart.CFrame.LookVector).Unit * 30, 2, 0.5);
    task.delay(0.6, function() -- Line: 115
        -- upvalues: u8 (copy)
        u8.ABC:Clean();
    end);
    task.spawn(StunPlayers, u8, p9, u10);
end;