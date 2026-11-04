 
 

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
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 21, Name: IgnitePass
    -- upvalues: LocalPlayer (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u5 = u7.CameraController;
    u6 = u7.Pass;
    local LookingAt = u6.LookingAt;

    if LookingAt == nil then
        u7:ResetCD(2);
        Effects:Popup("Must look at team-mate!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(1.4, function() -- Line: 38
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    task.defer(function() -- Line: 41
        -- upvalues: TweenService (ref), u5 (ref), CameraShaker (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v8 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            FieldOfView = 85
        });
        local v9 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 35
        });
        local v10 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 100
        });
        task.wait(0.1);
        v8:Play();
        task.wait(0.3);
        u5.CamShake:Shake(CameraShaker.Presets.IgnitePass);
        v9:Play();
        task.wait(0.75);
        v10:Play();
    end);
    u3:StopAll();
    u3:PlayChar("Phantom", "Ability1", Enum.AnimationPriority.Action4);
    u3:PlayBall("Phantom", "Ability1Ball", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("IgnitePass", {
        TimeSent = workspace:GetServerTimeNow(),
        passingTo = LookingAt
    });
    u7.AC:Connect(u1.Ability, function(p11, p12) -- Line: 71
        -- upvalues: u7 (copy), u3 (ref), u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), LookingAt (copy), RunService (ref), HumanoidRootPart (copy), Character (copy)
        if p12 and p12.IsChemicalReaction == true then
            u7.AC:Clean();
            u3:StopAll();

            return;
        end;

        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
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
        u7.AC:Add(LinearVelocity);
        u7.AC:Add(task.delay(0.15, function() -- Line: 105
            -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u7 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), HumanoidRootPart (ref), Character (ref)
            LinearVelocity.Parent = Value;
            local u13 = tick();
            local u14 = false;
            local u15 = 200;
            u7.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 111
                -- upvalues: Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u14 (ref), u7 (ref), Value (ref), LinearVelocity (ref), u13 (copy), Character (ref), u15 (ref)
                Position = u4:GetServerBallPosition();
                Position2 = LookingAt.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;
                local Magnitude2 = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude2 >= 20 then
                    u14 = true;
                end;

                if Magnitude2 <= 12 and u14 then
                    u7.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                if not u4:LocalPlayerIsBallNetworkOwner() then
                    u7.AC:Clean();

                    return;
                end;

                if u13 + 1.5 < tick() or Magnitude <= 10 and LookingAt.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or u4:GetPlayerPossessingBall()) then
                    u7.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                if u4:CharacterPossessesBall(Character) then
                    LinearVelocity.Parent = nil;
                end;

                LinearVelocity.Parent = Value;
                LinearVelocity.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u15 * 1.8);
            end);
        end));
    end);
end;