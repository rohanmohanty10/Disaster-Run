 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p6.AbilityService;
    u2 = p6.MovementController;
    u3 = p6.BallController;
    u4 = p6.Animations;
    u5 = p6.Network;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(2.816666666666667, function() -- Line: 35
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u1.Ability:Fire("Thunder Call", {
        State = "Thunder Call",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Judgement", "ThunderCall", Enum.AnimationPriority.Action3);
    task.wait(1.3333333333333333);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 10, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    p6.AC:Add(LinearVelocity);
    TweenService:Create(LinearVelocity, TweenInfo.new(1.4833333333333334, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 20, 0)
    }):Play();
    task.wait(1.4833333333333334);
    LinearVelocity:Destroy();
end;