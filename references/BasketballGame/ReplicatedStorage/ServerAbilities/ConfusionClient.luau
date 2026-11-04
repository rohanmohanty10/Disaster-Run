 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 21, Name: ConfusionClient
    -- upvalues: LocalPlayer (copy), u5 (ref), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), RunService (copy)
    print("arrives");
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u5 = u6.Network;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = 1000000000;
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u2.States.NoAbility = true;
    u6.Confusion = true;
    Effects:Popup("CONTROLS INVERTED! maybe try to move a bit slow");
    local u13 = RunService.Heartbeat:Connect(function(p7) -- Line: 43
        -- upvalues: u2 (ref), LinearVelocity (copy), HumanoidRootPart (copy), Character (copy)
        if u2.States.Dribbling then
            LinearVelocity.Attachment0 = nil;

            return;
        end;

        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        local v8 = HumanoidRootPart.CFrame:VectorToObjectSpace(Character.Humanoid.MoveDirection);
        local v9 = {};
        local math_clamp_ret = math.clamp(v8.X / Character.Humanoid.WalkSpeed, 0.01, 1);
        v9.Right = math.abs(math_clamp_ret);
        local math_clamp_ret2 = math.clamp(v8.X / Character.Humanoid.WalkSpeed, -1, -0.01);
        v9.Left = math.abs(math_clamp_ret2);
        local math_clamp_ret3 = math.clamp(v8.Z / Character.Humanoid.WalkSpeed, -1, -0.01);
        v9.Front = math.abs(math_clamp_ret3);
        local math_clamp_ret4 = math.clamp(v8.Z / Character.Humanoid.WalkSpeed, 0.01, 1);
        v9.Back = math.abs(math_clamp_ret4);
        local v10 = 0.012;
        local v11 = "Nil";

        for i, v in v9 do
            if v10 < v then
                v11 = i;
                v10 = v;
            end;
        end;

        local v12;

        if v11 == "Back" then
            v12 = HumanoidRootPart.CFrame.LookVector * -1;
        elseif v11 == "Right" then
            v12 = HumanoidRootPart.CFrame.RightVector;
        elseif v11 == "Left" then
            v12 = -HumanoidRootPart.CFrame.RightVector;
        else
            if v11 ~= "Front" then
                LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector;

                return;
            end;

            v12 = HumanoidRootPart.CFrame.LookVector;
        end;

        LinearVelocity.VectorVelocity = -Vector3.new(v12.X, 0, v12.Z) * 35;
    end);
    task.delay(3, function() -- Line: 85
        -- upvalues: u2 (ref), u13 (ref), LinearVelocity (copy), u6 (copy), u3 (ref)
        u2.States.NoAbility = false;
        u13:Disconnect();
        LinearVelocity:Destroy();
        u6.Confusion = nil;
        u3:StopChar("Psychic", "HeadacheEnemy");
    end);

    if not u6.Network.CharValues.HasBall then
        u3:StopAll();
        u3:PlayChar("Psychic", "HeadacheEnemy", Enum.AnimationPriority.Action3);
    end;
end;