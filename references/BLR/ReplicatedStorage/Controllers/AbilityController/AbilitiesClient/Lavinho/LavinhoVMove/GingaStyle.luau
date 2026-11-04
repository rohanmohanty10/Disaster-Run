  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Modules.getPlayerTarget);
local GingaShot = require(script.Parent.GingaShot);

local function StunPlayers(p1, p2, p3) -- Line: 17
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

    return v6;
end;

return function(u8, p9, u10) -- Line: 55, Name: GingaStyle
    -- upvalues: GingaShot (copy), StunPlayers (copy), AbilityBalancing (copy), AbilityUtils (copy)
    if u8.ABC then
        u8.ABC:Clean();
    end;

    if u10:GetAttribute("GingaStyle") == 3 then
        warn("HIHIHIHIHIHIH");
        u8.Dribbled = true;
        u10:SetAttribute("GingaStyle", nil);
        GingaShot(u8, p9, u10);

        return;
    end;

    local v11 = StunPlayers(u8, p9, u10);
    local PassRig = workspace:FindFirstChild("PassRig");

    if v11 or not (PassRig and (PassRig:GetAttribute("IsTrainingDummy") and PassRig:FindFirstChild("HumanoidRootPart"))) then
        PassRig = v11;
    elseif (PassRig.HumanoidRootPart.Position - u10.HumanoidRootPart.Position).Magnitude >= 25 then
        PassRig = v11;
    end;

    if not PassRig then
        return;
    end;

    local _ = u10.HumanoidRootPart;
    local v12 = u10:GetAttribute("GingaStyle") and (u10:GetAttribute("GingaStyle") + 1 or 1) or 1;
    u10:SetAttribute("GingaStyle", v12);
    u8.AbilityService.Ability:Fire("GingaStyle", {
        stunplayer = v12 and PassRig and PassRig or nil
    });
    u8.Animations:StopAnims();
    local MoveSpeedValue = AbilityBalancing.GingaStyle.MoveSpeedValue;
    u8.StatesController.States.Ability = true;
    u8.Animations.Abilities.GingaStyle.Priority = Enum.AnimationPriority.Action4;
    u8.Animations.Abilities.GingaStyle:Play();
    u8.Animations.Ball.GingaStyleBall.Priority = Enum.AnimationPriority.Action4;
    u8.Animations.Ball.GingaStyleBall:Play();
    task.wait(0.17);
    local LookVector = u10.HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    AbilityUtils.FastDashTo(u10, u10.HumanoidRootPart.Position + Unit * MoveSpeedValue, 2, 0.65);
    u8.ABC:Add(function() -- Line: 122
        -- upvalues: u8 (copy)
        u8.StatesController.States.Ability = false;
    end);
    task.delay(0.65, function() -- Line: 126
        -- upvalues: u8 (copy)
        if u8.ABC then
            u8.ABC:Clean();
        end;
    end);

    if u10:GetAttribute("GingaStyle") == 1 then
        task.delay(10, function() -- Line: 130
            -- upvalues: u10 (copy), u8 (copy)
            if typeof(u10:GetAttribute("GingaStyle")) == "number" and u10:GetAttribute("GingaStyle") ~= 3 then
                u10:SetAttribute("GingaStyle", nil);
                u8:AbilityCooldown("2", 40);
            end;
        end);
    end;
end;