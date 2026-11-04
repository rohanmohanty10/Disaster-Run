 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: Declaration
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;
    local LookingAt = u6.Pass.LookingAt;

    if game:GetService("RunService"):IsStudio() and not LookingAt then
        LookingAt = workspace.DefenseRig;
    end;

    if not LookingAt then
        u6:ResetCD(2);
        Effects:Popup("You must have a teammate available to pass to!", 4);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("UncleSam", "CannonPass", Enum.AnimationPriority.Action3);
    u3:PlayBall("UncleSam", "CannonPassBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("CannonPass", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = LookingAt
    });
    u6.AC:Add(task.delay(1.5, function() -- Line: 53
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end));
    u6.AC:Connect(u1.Ability, function(p7) -- Line: 58
        -- upvalues: LookingAt (ref), u6 (copy), u2 (ref), u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), Character (copy), LocalPlayer (ref), RunService (ref), u4 (ref), HumanoidRootPart (copy)
        local u8 = LookingAt;
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -4);
        local Unit = (u8.HumanoidRootPart.Position - Value.Position).Unit;
        local _ = (u8.HumanoidRootPart.Position - Value.Position).Magnitude;
        local Position = Value.Position;
        local Position2 = u8.HumanoidRootPart.Position;
        local Magnitude = (Position2 - Position).Magnitude;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u6.AC:Add(LinearVelocity);
        u6.AC:Add(task.delay(0.15, function() -- Line: 87
            -- upvalues: LocalPlayer (ref), LinearVelocity (copy), Value (copy), Magnitude (ref), u6 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), u8 (ref), HumanoidRootPart (ref), Character (ref)
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lucky Bounce";
            LinearVelocity.Parent = Value;
            local u9 = tick();
            local u10 = false;
            local u11 = 110;
            u6.AC:Connect(RunService.Heartbeat, function(p12) -- Line: 95
                -- upvalues: Position (ref), u4 (ref), Position2 (ref), u8 (ref), Magnitude (ref), HumanoidRootPart (ref), u10 (ref), u6 (ref), Value (ref), LinearVelocity (ref), u9 (copy), Character (ref), u11 (ref)
                Position = u4:GetServerBallPosition();
                Position2 = u8.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;
                local Magnitude2 = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude2 >= 20 then
                    u10 = true;
                end;

                if Magnitude2 <= 12 and u10 then
                    u6.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                if not u4:LocalPlayerIsBallNetworkOwner() then
                    u6.AC:Clean();

                    return;
                end;

                local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                if not (u8 and (u9 + 1.5 >= tick() and (Magnitude > 10 or u8.HumanoidRootPart ~= HumanoidRootPart)) and (Value.Parent ~= nil and (workspace:FindFirstChild(u8.Name) and not CharacterPossessingBall))) then
                    u6.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                if CharacterPossessingBall == Character then
                    LinearVelocity.Parent = nil;
                end;

                LinearVelocity.Parent = Value;
                LinearVelocity.VectorVelocity = ((u8.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u11 * 1.8);
            end);
        end));
    end);
end;