  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
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
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 30
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy), getPlayerTarget (copy), workspace_CurrentCamera (copy), GuiService (copy), BallController (copy), RunService (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    print("Fired Here");
    local SkyLeap = AbilityBalancing.SkyLeap;
    interface.FlashyShot = false;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, SkyLeap.Cooldown);
    local ABC = interface.ABC;
    local Character, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "SkyLeap");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("SkyLeapOnBall", {
        Type = "Start"
    });
    ABC:Add(task.delay(0.9, function() -- Line: 68
        -- upvalues: Character (copy), getPlayerTarget (ref), workspace_CurrentCamera (ref), GuiService (ref), interface (ref), ABC (copy), SkyLeap (copy), BallController (ref), StatesController (ref), RunService (ref)
        if Character.Values.HasBall.Value then
            local u6 = getPlayerTarget(false, function(p2, p3) -- Line: 70
                -- upvalues: workspace_CurrentCamera (ref), GuiService (ref)
                local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

                if not HumanoidRootPart then
                    return;
                end;

                if not p2:FindFirstChild("Values") then
                    return;
                end;

                local v4, v5 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);

                if not v5 then
                    return;
                end;

                local ViewportSize = workspace_CurrentCamera.ViewportSize;
                local Magnitude = (Vector2.new(v4.X, v4.Y) - (ViewportSize / 2 - GuiService:GetGuiInset())).Magnitude;
                print(Magnitude);

                if Magnitude < 50 then
                    return true;
                end;
            end);
            interface.AbilityService.Ability:Fire("SkyLeapOnBall", {
                Target = u6
            });
            print(u6);
            ABC:Connect(interface.AbilityService.Ability, function(u7) -- Line: 93
                -- upvalues: u6 (copy), SkyLeap (ref), BallController (ref), ABC (ref), StatesController (ref), Character (ref), RunService (ref)
                if not u6 then
                    u7.AssemblyLinearVelocity = workspace.CurrentCamera.CFrame.LookVector * SkyLeap.ShotPower;
                    BallController:DragBall(u7);
                    ABC:Clean();

                    return;
                end;

                StatesController.States.Ability = false;
                local HumanoidRootPart = Character.HumanoidRootPart;
                local HumanoidRootPart2 = u6.HumanoidRootPart;
                local u8 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
                local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
                u7.AssemblyLinearVelocity = u8 * math_clamp_ret;
                BallController:DragBall(u7);
                local u9 = tick();
                ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 119
                    -- upvalues: u9 (copy), u7 (copy), ABC (ref), HumanoidRootPart2 (copy), u8 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
                    if tick() > u9 + 3 or (not u7 or u7.OnPlayer.Value) then
                        return ABC:Clean();
                    end;

                    local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                    local v11 = tick() > u9 + 0.55;
                    u8 = u8:Lerp((HumanoidRootPart2.Position - u7.Position).Unit + Vector3.new(0, v11 and 0.15 or 0.35, 0), 6.5 * p10);
                    math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

                    if u7.Position.Y < 5 or (HumanoidRootPart2.Position - u7.Position).Magnitude <= 7 then
                        return ABC:Clean();
                    end;

                    u7.AssemblyLinearVelocity = u7.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p10);
                end);
            end);
        end;
    end));
    ABC:Add(function() -- Line: 152
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 156
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;