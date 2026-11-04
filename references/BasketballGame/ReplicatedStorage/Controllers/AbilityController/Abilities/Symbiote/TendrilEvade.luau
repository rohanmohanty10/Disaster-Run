 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 21, Name: TendrilSnatch
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), Effects (copy), TweenService (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u8.Network;
    u2 = u8.AbilityService;
    u4 = u8.Animations;
    u3 = u8.MovementController;
    u5 = u8.BallController;
    u6 = u8.CameraController;
    u7 = Knit.GetService("CustomServerService");

    if u5:LocalPlayerPossessesBall() then
        Effects:Popup("EVADE STEAL FOR 4 SECONDS. (one time)");
        u8.AC:Connect(u2.Ability, function() -- Line: 38
            -- upvalues: u8 (copy), HumanoidRootPart (copy), Humanoid (copy), u4 (ref), u3 (ref), TweenService (ref), u2 (ref)
            u8.AC:Clean();
            local v9 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
            local v10 = {};
            local math_clamp_ret = math.clamp(v9.X / Humanoid.WalkSpeed, 0.01, 1);
            v10.Right = math.abs(math_clamp_ret);
            local math_clamp_ret2 = math.clamp(v9.X / Humanoid.WalkSpeed, -1, -0.01);
            v10.Left = math.abs(math_clamp_ret2);
            local math_clamp_ret3 = math.clamp(v9.Z / Humanoid.WalkSpeed, -1, -0.01);
            v10.Front = math.abs(math_clamp_ret3);
            local math_clamp_ret4 = math.clamp(v9.Z / Humanoid.WalkSpeed, 0.01, 1);
            v10.Back = math.abs(math_clamp_ret4);
            local v11 = 0.1;
            local u12 = "Front";

            for i, v in v10 do
                if v11 < v then
                    u12 = i;
                    v11 = v;
                end;
            end;

            u4:StopAll();
            local v13 = u4:PlayChar("Symbiote", `TendrilEvade{u12}`, Enum.AnimationPriority.Action3, true);
            local v14 = u4:PlayBall("Symbiote", `TendrilEvade{u12}Ball`, Enum.AnimationPriority.Action3, true);
            v13:AdjustSpeed(1.2);
            v14:AdjustSpeed(1.2);
            u3.States.Ability = true;
            u3.States.NoWalk = true;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            u8.AC:Add(LinearVelocity);
            u8.AC:Add(task.delay(0.6944444444444445, function() -- Line: 73
                -- upvalues: u8 (ref), u3 (ref)
                u8.AC:Clean();
                u3.States.Ability = false;
                u3.States.NoWalk = false;
            end));
            u8.AC:Add(task.delay(0.33333333333333337, function() -- Line: 79
                -- upvalues: HumanoidRootPart (ref), u12 (ref), LinearVelocity (copy), TweenService (ref), u8 (ref), u3 (ref)
                local LookVector = HumanoidRootPart.CFrame.LookVector;

                if u12 == "Back" then
                    LookVector = LookVector * -1;
                elseif u12 == "Right" then
                    LookVector = HumanoidRootPart.CFrame.RightVector;
                elseif u12 == "Left" then
                    LookVector = HumanoidRootPart.CFrame.RightVector * -1;
                end;

                LinearVelocity.VectorVelocity = LookVector * Vector3.new(1, 0, 1) * 150;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.2777777777777778, Enum.EasingStyle.Quad), {
                    VectorVelocity = LookVector * Vector3.new(1, 0, 1) * 30
                }):Play();
                u8.AC:Add(task.delay(0.2777777777777778, function() -- Line: 94
                    -- upvalues: u3 (ref)
                    u3.States.NoWalk = false;
                end));
            end));
            u2.Ability:Fire("TendrilPull", {
                Ability = "On-Ball",
                TimeSent = workspace:GetServerTimeNow()
            });
        end);
        u2.Ability:Fire("TendrilPull", {
            Ability = "Evade",
            TimeSent = workspace:GetServerTimeNow()
        });
        u8.AC:Add(task.delay(4, function() -- Line: 103
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));

        return;
    end;

    u4:StopAll();
    u4:PlayChar("Symbiote", "TendrilEvadeFront", Enum.AnimationPriority.Action3);
    u3.States.Ability = true;
    u3.States.NoWalk = true;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(task.delay(0.8333333333333334, function() -- Line: 119
        -- upvalues: u8 (copy), u3 (ref)
        u8.AC:Clean();
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end));
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };
    local u15 = false;
    u8.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 131
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), RaycastParams_new_ret (copy), u15 (ref)
        if LinearVelocity then
            local v17 = workspace:Raycast(HumanoidRootPart.Position, LinearVelocity.VectorVelocity.Unit * 5, RaycastParams_new_ret);

            if v17 and (v17.Instance and not u15) then
                u15 = true;

                if LinearVelocity then
                    LinearVelocity:Destroy();
                end;
            end;
        end;
    end);
    u8.AC:Add(task.delay(0.4, function() -- Line: 141
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), TweenService (ref), u8 (copy), u3 (ref)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 360;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Quad), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 80
        }):Play();
        u8.AC:Add(task.delay(0.3333333333333333, function() -- Line: 146
            -- upvalues: u3 (ref)
            u3.States.NoWalk = false;
        end));
    end));
    u2.Ability:Fire("TendrilPull", {
        Ability = "Off-Ball",
        TimeSent = workspace:GetServerTimeNow()
    });
end;