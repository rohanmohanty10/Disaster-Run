  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local StylePassiveController = require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
local Observers = require(ReplicatedStorage.Packages.Observers);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = 1;

local function rotateXZ(p2, p3) -- Line: 29
    local X = p2.X;
    local Z = p2.Z;
    local math_cos_ret = math.cos(p3);
    local math_sin_ret = math.sin(p3);

    return Vector3.new(X * math_cos_ret - Z * math_sin_ret, 0, X * math_sin_ret + Z * math_cos_ret);
end;

local function checkInput(p4, p5) -- Line: 44
    -- upvalues: u1 (ref)
    if p5 then
        return;
    end;

    if p4.KeyCode == Enum.KeyCode.Thumbstick1 then
        local X = p4.Position.X;

        if X < -0.1 then
            u1 = -1;
        elseif X > 0.1 then
            u1 = 1;
        end;
    end;

    if p4.KeyCode == Enum.KeyCode.A then
        u1 = -1;

        return;
    end;

    if p4.KeyCode == Enum.KeyCode.D then
        u1 = 1;
    end;
end;

return function(u6) -- Line: 64
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy), StylePassiveController (copy), LocalPlayer (copy), UserInputService (copy), checkInput (copy), Observers (copy), u1 (ref), workspace_CurrentCamera (copy), TweenService (copy)
    local VelocityDash = AbilityBalancing.VelocityDash;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u7, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "VelocityDash");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetBallTrack("LokiVelocityDash"):Play();
    local ABC = u6.ABC;
    StatesController.States.Ability = true;
    u6.AbilityService.Ability:Fire("VelocityDash", workspace:GetServerTimeNow());
    u6:AbilityCooldown(2, VelocityDash.Cooldown);
    local u8 = false;
    Character:SetAttribute("VelocityShot", true);
    local u9 = StylePassiveController:Read("Velocity", "VelocityPercent");
    Character:SetAttribute("VelocityShotPower", u9);
    StatesController.CharacterEvents.CustomEvent:Fire("ResetVelocity");
    AbilityUtils.clearMovers(Character);
    ABC:Add(task.delay(2, function() -- Line: 102
        -- upvalues: LocalPlayer (ref), u6 (copy), AbilityBalancing (ref), Character (copy), u8 (ref), ABC (copy)
        if not LocalPlayer.PlayerStats.InAwakening.Value then
            u6:AbilityCooldown(2, AbilityBalancing.VelocityShot.Cooldown);
        end;

        Character:SetAttribute("VelocityShotPower", nil);
        Character:SetAttribute("VelocityShot", nil);

        if u8 then
            return;
        end;

        ABC:Destroy();
    end));
    ABC:Add(UserInputService.InputBegan:Connect(checkInput));
    ABC:Add(UserInputService.InputChanged:Connect(checkInput));
    ABC:Add(Observers.observeCharacter(LocalPlayer, function(p10, p11) -- Line: 118
        -- upvalues: UserInputService (ref), u1 (ref)
        local Humanoid = p11:WaitForChild("Humanoid", 60);
        local HumanoidRootPart = p11:WaitForChild("HumanoidRootPart", 60);

        if Humanoid and UserInputService.PreferredInput == Enum.PreferredInput.Touch then
            Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line: 124
                -- upvalues: HumanoidRootPart (copy), Humanoid (copy), u1 (ref)
                local v12 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);

                if v12.X > 0.05 then
                    u1 = 1;

                    return;
                end;

                if v12.X < -0.05 then
                    u1 = -1;
                end;
            end);
        end;
    end));
    ABC:Add(function() -- Line: 136
        -- upvalues: u8 (ref), StatesController (ref)
        u8 = true;
        StatesController.States.Ability = false;
    end);
    local v18 = AbilityUtils.execute.dash(30, 0.7999999999999999, {
        direction = function() -- Line: 142, Name: direction
            -- upvalues: workspace_CurrentCamera (ref), u1 (ref)
            local Unit = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
            local math_rad_ret = math.rad(u1 * 15);
            local X = Unit.X;
            local Z = Unit.Z;
            local math_cos_ret = math.cos(math_rad_ret);
            local math_sin_ret = math.sin(math_rad_ret);

            return Vector3.new(X * math_cos_ret - Z * math_sin_ret, 0, X * math_sin_ret + Z * math_cos_ret);
        end,

        speed = function(p13) -- Line: 148, Name: speed
            -- upvalues: TweenService (ref), VelocityDash (copy), u9 (copy)
            if p13 <= 0.1 then
                return nil;
            end;

            local Value = TweenService:GetValue(math.clamp((p13 - 0.1) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v14 = VelocityDash.MoveSpeedValue * (u9 + 1);

            return math.lerp(v14, v14 * 0.7, Value);
        end,

        stepped = function(p15, p16) -- Line: 160, Name: stepped
            -- upvalues: AbilityUtils (ref), u7 (copy)
            return AbilityUtils.wallCheck(u7.CFrame.Position, p16 * 1 / 30) and Vector3.new(0, 0, 0) or p16;
        end,

        fov = function(p17) -- Line: 167, Name: fov
            return p17 > 0.1 and 25 or 8;
        end
    });
    v18:Add(function() -- Line: 175
        -- upvalues: StatesController (ref), Track (copy)
        StatesController.States.Ability = false;
        Track:Stop();
    end);
    ABC:Add(v18);
end;