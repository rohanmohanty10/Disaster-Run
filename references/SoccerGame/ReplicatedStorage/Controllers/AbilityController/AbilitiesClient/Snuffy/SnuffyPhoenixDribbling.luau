  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 28
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 32
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 40
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), Players (copy), LocalPlayer (copy)
    local NELChopFeint = AbilityBalancing.NELChopFeint;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u9, v10, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(2, 40);
    local ABC = interface.ABC;
    local _ = v10.MoveDirection.Unit;
    StatesController.States.Ability = true;
    local Track = AnimationController:GetTrack("Abilities", "PhoenixDribbling");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local v11 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= LocalPlayer.Team) then
            if #v11 == 2 then
                break;
            end;

            if (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude > 15 and not v.Character:GetAttribute("IFrames") then
                if not (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value) then
                    v11[#v11 + 1] = v.Character;
                end;
            end;
        end;
    end;

    interface.AbilityService.Ability:Fire("PhoenixDribbling", { v11 });
    local v12, v13 = AbilityUtils.FastDashTo(Character, u9.Position + (u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * NELChopFeint.FeintDistance, 2, 0.3);
    ABC:Add(v12);
    ABC:Add(v13);
    ABC:Add(task.delay(0.4, function() -- Line: 100
        -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v14, v15 = AbilityUtils.FastDashTo(Character, u9.Position + (-u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * 50, 2, 0.4);
        ABC:Add(v14);
        ABC:Add(v15);
    end));
    ABC:Add(task.delay(1, function() -- Line: 108
        -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v16, v17 = AbilityUtils.FastDashTo(Character, u9.Position + (u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * 50, 2, 0.5);
        ABC:Add(v16);
        ABC:Add(v17);
    end));
    ABC:Add(task.delay(1.6, function() -- Line: 116
        -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v18, v19 = AbilityUtils.FastDashTo(Character, u9.Position + (-u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * 50, 2, 0.5);
        ABC:Add(v18);
        ABC:Add(v19);
    end));
    ABC:Add(function() -- Line: 126
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2.1, function() -- Line: 130
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));

    return true;
end;