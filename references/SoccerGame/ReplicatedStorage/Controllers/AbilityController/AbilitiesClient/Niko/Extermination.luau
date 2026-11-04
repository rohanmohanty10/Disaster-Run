  

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
local Extermination = require(ReplicatedStorage2.AbilityBalancing).Extermination;
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

return function() -- Line: 47, Name: Extermination
    -- upvalues: AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage (copy), Extermination (copy), Players (copy), RunService (copy), LocalPlayer (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface.Extermination = false;
    local ABC = interface.ABC;
    local Character, v7, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 63
        -- upvalues: StatesController (ref)
        print("Ended");
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "Extermination");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface:AbilityCooldown(1, 40);
    interface.AbilityService.Ability:Fire("Extermination", {
        Type = "Effect"
    });
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 78
        -- upvalues: BallController (ref), ReplicatedStorage (ref)
        BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    local LookVector = v7.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local u8, u9 = AbilityUtils.FastDashTo(Character, v7.Position + Unit * Extermination.TravelDistance, -2, 0.7);
    ABC:Add(u8);
    ABC:Add(u9);
    local Players2 = Players:GetPlayers();
    local u10 = nil;
    local u11 = nil;
    tick();

    local function Clearance() -- Line: 95
        -- upvalues: u11 (ref), Track (copy), u8 (copy), u9 (copy), AnimationController (ref), interface (ref), u10 (ref)
        print("Hit");
        u11 = true;
        Track:Stop();
        u8:Destroy();
        u9:Destroy();
        local Track2 = AnimationController:GetTrack("Abilities", "ExterminationHit");
        Track2.Looped = false;
        Track2.TimePosition = 0.43;
        Track2.Priority = Enum.AnimationPriority.Action3;
        Track2:Play();
        interface.AbilityService.Ability:Fire("BodyCore", {
            target = u10
        });
    end;

    ABC:Connect(RunService.Heartbeat, function() -- Line: 112
        -- upvalues: u11 (ref), Character (copy), Clearance (copy), Players2 (copy), LocalPlayer (ref), Extermination (ref), u10 (ref), ReplicatedStorage (ref)
        if u11 then
            print("Stopped");

            return;
        end;

        if Character.Values.HasBall.Value then
            Clearance();
        end;

        for _, v in Players2 do
            if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Team ~= LocalPlayer.Team) then
                local CFrame = Character.HumanoidRootPart.CFrame;
                local v12 = v.Character.HumanoidRootPart.Position - CFrame.Position;
                local v13;

                if Extermination.ActivationRangePlayer < v12.Magnitude then
                    v13 = false;
                else
                    local v14 = CFrame.LookVector:Dot(v12.Unit);
                    local math_acos_ret = math.acos(v14);
                    v13 = math.deg(math_acos_ret) <= 45;
                end;

                if v13 and not v.Character:GetAttribute("IFrames") then
                    if LocalPlayer.Team ~= v.Team and not (v.Character.Values.Dribbling.Value or v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value) then
                        u10 = v.Character;

                        if u10.Name == ReplicatedStorage.Football.Value.Char.Value.Name then
                            break;
                        end;
                    end;
                end;
            end;
        end;

        if workspace:FindFirstChild("PassRig") then
            local CFrame = Character.HumanoidRootPart.CFrame;
            local v15 = workspace.PassRig.HumanoidRootPart.Position - CFrame.Position;
            local v16;

            if Extermination.ActivationRangePlayer < v15.Magnitude then
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
            Clearance();
        end;
    end);
    ABC:Add(task.delay(1, function() -- Line: 150
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Connect(interface.AbilityService.Ability, function(p18, p19) -- Line: 154
        -- upvalues: BallController (ref), ABC (copy)
        print("Here");
        p18.AssemblyLinearVelocity = p19;
        BallController:DragBall(p18);
        ABC:Clean();
    end);
end;