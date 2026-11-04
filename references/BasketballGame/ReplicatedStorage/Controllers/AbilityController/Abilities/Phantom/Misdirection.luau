 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 20
    -- upvalues: LocalPlayer (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), u6 (ref), u7 (ref), u5 (ref), Effects (copy), CameraShaker (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u4 = u8.BallController;
    u1 = u8.AbilityService;
    u3 = u8.Animations;
    u2 = u8.MovementController;
    u6 = u8.CameraController;
    u7 = u8.Pass;
    u5 = u8.Network;

    if not u5.CharValues.HasBall then
        u2.States.Ability = true;
        u8.AC:Add(function() -- Line: 77
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u8.AC:Add(task.delay(5, function() -- Line: 81
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));
        u8.AbilityService.Ability:Fire("Misdirection");
        u8.AC:Connect(u8.AbilityService.Ability, function(p9) -- Line: 87
            -- upvalues: u8 (copy), u7 (ref), LocalPlayer (ref), HumanoidRootPart (copy), u3 (ref), ReplicatedStorage (ref), u4 (ref), RunService (ref)
            if p9 and p9.IsChemicalReaction == true then
                u8.AC:Clean();

                return;
            end;

            local LookingAt = u7.LookingAt;

            if LookingAt == nil then
                for _, v in LocalPlayer.Team:GetPlayers() do
                    if v.Character ~= nil and (v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer ~= v) then
                        LookingAt = v.Character;
                        break;
                    end;
                end;
            end;

            if LookingAt == nil then
                u8.AC:Clean();

                return;
            end;

            local v10 = HumanoidRootPart.CFrame.LookVector:Dot((HumanoidRootPart.Position - LookingAt.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v10);
            u3:StopAll();

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                local v11;

                if v10 < 0 then
                    v11 = u3:PlayChar("Phantom", "MisdirectionL", Enum.AnimationPriority.Action4, true);
                else
                    v11 = u3:PlayChar("Phantom", "MisdirectionR", Enum.AnimationPriority.Action4, true);
                end;

                v11:AdjustSpeed(2);
            else
                u3:PlayChar("Phantom", "MisdirectionUp", Enum.AnimationPriority.Action4, true):AdjustSpeed(2);
            end;

            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Unit = (LookingAt.HumanoidRootPart.Position - Value.Position).Unit;
            local _ = (LookingAt.HumanoidRootPart.Position - Value.Position).Magnitude;
            local Position = Value.Position;
            local Position2 = LookingAt.HumanoidRootPart.Position;
            local Magnitude = (Position2 - Position).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u8.AC:Add(LinearVelocity);
            task.delay(0.05, function() -- Line: 163
                -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u8 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), HumanoidRootPart (ref)
                LinearVelocity.Parent = Value;
                local u12 = tick();
                local math_clamp_ret = math.clamp(Magnitude, 65, 120);
                u8.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 168
                    -- upvalues: Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), u12 (copy), HumanoidRootPart (ref), u8 (ref), Value (ref), LinearVelocity (ref), math_clamp_ret (ref)
                    Position = u4:GetServerBallPosition();
                    Position2 = LookingAt.HumanoidRootPart.Position;
                    Magnitude = (Position2 - Position).Magnitude;

                    if not (u12 + 1.5 < tick() or Magnitude <= 16 and LookingAt.HumanoidRootPart == HumanoidRootPart or u4:GetPlayerPossessingBall()) then
                        LinearVelocity.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, Magnitude / math_clamp_ret / 3.52 - 0.05, 0)) * (math_clamp_ret * 1.25);

                        return;
                    end;

                    u8.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;
                end);
            end);
        end);

        return;
    end;

    local v14 = u8:CheckInfront(25);

    if v14 == nil then
        u8:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u1 = u8.AbilityService;
    u3 = u8.Animations;
    u2 = u8.MovementController;
    u4 = u8.BallController;
    u6 = u8.CameraController;
    u2.States.Ability = true;
    task.delay(0.6, function() -- Line: 43
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    task.delay(0.3, function() -- Line: 45
        -- upvalues: u6 (ref), CameraShaker (ref)
        u6.CamShake:Shake(CameraShaker.Presets.Vanish);
    end);
    task.defer(function() -- Line: 50
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v15 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            FieldOfView = 35
        });
        local v16 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            FieldOfView = 90
        });
        v15:Play();
        task.wait(0.6);
        v16:Play();
    end);
    u3:StopAll();
    u3:PlayChar("Phantom", "Ability2", Enum.AnimationPriority.Action4);
    u3:PlayBall("Phantom", "Ability2Ball", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("Misdirection", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v14
    });
end;