  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local FrostCounter = require(ReplicatedStorage.AbilityBalancing).FrostCounter;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 31
    -- upvalues: AbilityUtils (copy), interface (copy), FrostCounter (copy), StatesController (copy), ReplicatedStorage (copy), Essentials (copy), AnimationController (copy), LocalPlayer (copy), Players (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local Character, v1, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(3, FrostCounter.Cooldown);
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    StatesController.SpeedBoost = -10;
    interface.AbilityService.Ability:Fire("FrostCounter");
    local u2 = ReplicatedStorage.Assets.Misc.DiveHitbox:Clone();
    u2.Transparency = 1;
    u2.Parent = v1.Parent;
    u2.CFrame = v1.CFrame;
    Essentials:Weld(u2, v1);
    game.Debris:AddItem(u2, FrostCounter.Duration);

    local function Dash(p3) -- Line: 58
        -- upvalues: AnimationController (ref), interface (ref), Character (copy), FrostCounter (ref), AbilityUtils (ref), ABC (copy)
        AnimationController:GetTrack("Abilities", "FrostCounter"):Play();
        interface.AbilityService.Ability:Fire("FrostCounter", p3);
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, Character.HumanoidRootPart.Position + Unit * FrostCounter.DashDistance, 2, 0.5);

        if ABC then
            ABC:Clean();
        end;
    end;

    ABC:Connect(u2.Touched, function(p4) -- Line: 72
        -- upvalues: LocalPlayer (ref), Players (ref), Dash (copy), u2 (copy)
        if p4.Parent:FindFirstChild("Humanoid") and p4.Parent ~= LocalPlayer.Character then
            local v5 = Players:FindFirstChild(p4.Parent.Name);

            if v5 and v5.Team == LocalPlayer.Team then
                return;
            end;

            if p4.Parent.Values.Goalie.Value == true and p4.Parent.Values.IsInPenalty.Value == true then
                return;
            end;

            if p4.Parent.Values.Sliding.Value ~= true then
                return;
            end;

            Dash(p4.Parent);
            u2:Destroy();
        end;
    end);
    ABC:Add(function() -- Line: 94
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    task.delay(2.2, function() -- Line: 101
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;