  

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
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function isInRightCone(p1, p2, p3, p4) -- Line: 31
    local v5 = p2 - p1.Position;

    if p4 < v5.Magnitude then
        return false;
    end;

    local v6 = p1.LookVector:Dot(v5.Unit);
    local math_acos_ret = math.acos(v6);

    return math.deg(math_acos_ret) <= p3 / 2;
end;

return function() -- Line: 50
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), AnimationController (copy), StatesController (copy), BallController (copy), ReplicatedStorage2 (copy), Players (copy), RunService (copy), LocalPlayer (copy), ReplicatedStorage (copy)
    local WeaponDisabler = AbilityBalancing.WeaponDisabler;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u7, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(2, WeaponDisabler.Cooldown);
    local ABC = interface.ABC;
    local Track = AnimationController:GetTrack("Abilities", "WeaponDisabler");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 73
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 78
        -- upvalues: BallController (ref), ReplicatedStorage2 (ref)
        BallController:DragBall(ReplicatedStorage2.Football.Value);
    end);
    interface.AbilityService.Ability:Fire("WeaponDisabler", {
        Type = "Effect"
    });
    ABC:Connect(Character.IsRagdoll:GetAttributeChangedSignal("Value"), function() -- Line: 84
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
    ABC:Add(task.delay(0.3, function() -- Line: 88
        -- upvalues: u7 (copy), WeaponDisabler (copy), AbilityUtils (ref), Character (copy), ABC (copy), Players (ref), RunService (ref), LocalPlayer (ref), ReplicatedStorage (ref), interface (ref)
        local LookVector = u7.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v8, v9 = AbilityUtils.FastDashTo(Character, u7.Position + Unit * WeaponDisabler.TravelDistance, -2, 0.2);
        ABC:Add(v8);
        ABC:Add(v9);
        local Players2 = Players:GetPlayers();
        local u10 = nil;
        local u11 = tick();
        ABC:Connect(RunService.Heartbeat, function() -- Line: 100
            -- upvalues: Players2 (copy), LocalPlayer (ref), u7 (ref), WeaponDisabler (ref), u10 (ref), ReplicatedStorage (ref), interface (ref), ABC (ref), u11 (copy)
            for _, v in Players2 do
                if v ~= LocalPlayer and (v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= LocalPlayer.Team)) then
                    local CFrame = u7.CFrame;
                    local v12 = v.Character.HumanoidRootPart.Position - CFrame.Position;
                    local v13;

                    if WeaponDisabler.ActivationRangePlayer < v12.Magnitude then
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
                local CFrame = u7.CFrame;
                local v15 = workspace.PassRig.HumanoidRootPart.Position - CFrame.Position;
                local v16;

                if WeaponDisabler.ActivationRangePlayer < v15.Magnitude then
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
                interface.AbilityService.Ability:Fire("WeaponDisabler", {
                    target = u10
                });
                ABC:Clean();
            end;

            if tick() - u11 >= 0.2 then
                ABC:Clean();
            end;
        end);
    end));
end;