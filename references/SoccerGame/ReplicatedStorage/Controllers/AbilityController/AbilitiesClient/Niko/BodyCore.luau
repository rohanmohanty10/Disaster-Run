  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local BodyCore = require(ReplicatedStorage2.AbilityBalancing).BodyCore;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function isInRightCone(p1, p2, p3, p4) -- Line: 28
    local v5 = p2 - p1.Position;

    if p4 < v5.Magnitude then
        return false;
    end;

    local v6 = p1.LookVector:Dot(v5.Unit);
    local math_acos_ret = math.acos(v6);

    return math.deg(math_acos_ret) <= p3 / 2;
end;

return function() -- Line: 47, Name: BodyCore
    -- upvalues: AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage (copy), BodyCore (copy), Players (copy), RunService (copy), LocalPlayer (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u7, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 61
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "BodyCore");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 71
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
    interface:AbilityCooldown(2, 40);
    interface.AbilityService.Ability:Fire("BodyCore", {
        Type = "Effect"
    });
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 79
        -- upvalues: BallController (ref), ReplicatedStorage (ref)
        BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    ABC:Add(task.delay(0.2, function() -- Line: 83
        -- upvalues: u7 (copy), BodyCore (ref), AbilityUtils (ref), Character (copy), Players (ref), ABC (copy), RunService (ref), LocalPlayer (ref), ReplicatedStorage (ref), interface (ref)
        local LookVector = u7.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, u7.Position + Unit * BodyCore.TravelDistance, -2, 0.2);
        local Players2 = Players:GetPlayers();
        local u8 = nil;
        local u9 = tick();
        ABC:Connect(RunService.Heartbeat, function() -- Line: 92
            -- upvalues: Players2 (copy), LocalPlayer (ref), Character (ref), BodyCore (ref), u8 (ref), ReplicatedStorage (ref), interface (ref), ABC (ref), u9 (copy)
            for _, v in Players2 do
                if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= LocalPlayer.Team) then
                    local CFrame = Character.HumanoidRootPart.CFrame;
                    local v10 = v.Character.HumanoidRootPart.Position - CFrame.Position;
                    local v11;

                    if BodyCore.ActivationRangePlayer < v10.Magnitude then
                        v11 = false;
                    else
                        local v12 = CFrame.LookVector:Dot(v10.Unit);
                        local math_acos_ret = math.acos(v12);
                        v11 = math.deg(math_acos_ret) <= 45;
                    end;

                    if v11 and not v.Character:GetAttribute("IFrames") then
                        if not (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value) then
                            u8 = v.Character;

                            if u8.Name == ReplicatedStorage.Football.Value.Char.Value.Name then
                                break;
                            end;
                        end;
                    end;
                end;
            end;

            if workspace:FindFirstChild("PassRig") then
                local CFrame = Character.HumanoidRootPart.CFrame;
                local v13 = workspace.PassRig.HumanoidRootPart.Position - CFrame.Position;
                local v14;

                if BodyCore.ActivationRangePlayer < v13.Magnitude then
                    v14 = false;
                else
                    local v15 = CFrame.LookVector:Dot(v13.Unit);
                    local math_acos_ret = math.acos(v15);
                    v14 = math.deg(math_acos_ret) <= 45;
                end;

                if v14 then
                    u8 = workspace.PassRig;
                end;
            end;

            if u8 then
                interface.AbilityService.Ability:Fire("BodyCore", {
                    target = u8
                });
                ABC:Clean();
            end;

            if tick() - u9 >= 0.2 then
                ABC:Clean();
            end;
        end);
    end));
end;