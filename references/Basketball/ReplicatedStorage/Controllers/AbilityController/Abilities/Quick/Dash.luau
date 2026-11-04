 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;

return function(u1) -- Line: 14
    -- upvalues: LocalPlayer (copy), RunService (copy)
    u1.AbilityService.Ability:Fire("Dash", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local _ = LocalPlayer.Character.HumanoidRootPart;
    local _ = LocalPlayer.Character.Humanoid;
    u1.Animations:StopAll();
    u1.Animations:PlayChar("Quick", "Ability1", Enum.AnimationPriority.Action3);
    u1.MovementController.States.Ability = true;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
    LinearVelocity.Attachment0 = LocalPlayer.Character.HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = LocalPlayer.Character.HumanoidRootPart;
    u1.AC:Add(LinearVelocity);
    local u2 = 72;
    u1.AC:Add(function() -- Line: 36
        -- upvalues: LinearVelocity (copy), u1 (copy)
        LinearVelocity:Destroy();
        u1.MovementController.States.Ability = false;
        u1.Animations:StopAll();
    end);
    u1.AC:Add(RunService.Heartbeat:Connect(function(p3) -- Line: 44
        -- upvalues: u2 (ref), LinearVelocity (copy), LocalPlayer (ref), u1 (copy)
        u2 = u2 - p3 * 12;
        LinearVelocity.VectorVelocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * u2;

        if u1.Network.CharValues.HasBall then
            u1.AC:Clean();
        end;
    end));
    u1.AC:Add(task.delay(1.25, function() -- Line: 53
        -- upvalues: u1 (copy)
        u1.AC:Clean();
    end));
end;