 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local WaitUntilCutsceneEnds = require(ReplicatedStorage.Shared.Functions.WaitUntilCutsceneEnds);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

function CreatorsDribble(u6)
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), TweenService (copy), WaitUntilCutsceneEnds (copy), RunService (copy), Essentials (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;

    if HumanoidRootPart.Position.Y > 5 then
        u6:ResetCD(1);
        Effects:Popup("Can\'t use Creator\'s Dribble while in the air");

        return;
    end;

    local function creatorDribble2IsReady() -- Line: 37
        -- upvalues: u6 (copy), u2 (ref), LocalPlayer (ref), TweenService (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
        u6.CreatorDribble2 = true;
        u6:ResetCD(1);
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 0;
        TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1
        }):Play();
        task.delay(2, function() -- Line: 46
            -- upvalues: u6 (ref)
            if u6.CreatorDribble2 then
                u6.CDS[1] = tick() + 55;
            end;

            u6.CreatorDribble2 = nil;
            u6:ResetCopy();
        end);
    end;

    u6.AC:Connect(u1.Ability, function(p7) -- Line: 56
        -- upvalues: u6 (copy), LocalPlayer (ref), WaitUntilCutsceneEnds (ref), creatorDribble2IsReady (copy), u2 (ref)
        if not p7 then
            return;
        end;

        if u6.UsingCreatorDribble2 then
            if LocalPlayer.Style.Value == "Copycat" then
                return;
            end;

            WaitUntilCutsceneEnds();
            creatorDribble2IsReady();

            return;
        end;

        u6.AC:Clean();
        u2.States.Ability = false;
        u6:ResetCD(1);
    end);

    if not u6.CreatorDribble2 then
        u2.States.Ability = true;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
        BodyGyro.CFrame = CFrame.new(HumanoidRootPart.CFrame.LookVector);
        u6.AC:Add(BodyGyro);
        u6.AC:Add(LinearVelocity);
        u3:StopAll();
        u3:PlayChar("Chrollo", "CreatorsDribble", Enum.AnimationPriority.Action3);
        u3:PlayBall("Chrollo", "CreatorsDribbleBall", Enum.AnimationPriority.Action3);
        u6.AC:Add(task.delay(1, creatorDribble2IsReady));
        u6.AC:Connect(u1.Ability, function(p8) -- Line: 171
            -- upvalues: u6 (copy), u1 (ref), u3 (ref), Essentials (ref), u2 (ref), RunService (ref), Humanoid (copy), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref), HumanoidRootPart (copy)
            if p8 then
                return;
            end;

            u6.AC:Clean();
            u6.CDS[1] = tick() + 55;
            u6:ResetCopy();
            u1.Ability:Fire("CreatorsDribble", {
                State = "Layup",
                TimeSent = workspace:GetServerTimeNow()
            });
            u3:StopAll();
            u3:PlayChar("Chrollo", `CreatorsDribbleShoot{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
            u3:PlayBall("Chrollo", `CreatorsDribbleShoot{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
            u2.States.Dunking = true;
            task.delay(0.5, function() -- Line: 187
                -- upvalues: RunService (ref), Humanoid (ref)
                RunService.Heartbeat:Wait();
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end);
            task.wait(0.8333333333333334);
            local Value = ReplicatedStorage.Basketball.Value;
            u2.Boost = 0;
            u2.States.Ability = false;
            u2.States.Dunking = false;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
            local v9 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
            local math_log_ret = math.log(1 + v9.Magnitude * 0.045);
            local v10 = v9 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
            local _ = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;
            Value.AssemblyLinearVelocity = 1 * v10;
        end);
        u1.Ability:Fire("CreatorsDribble", {
            State = "First",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.18333333333333332);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 135;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.8166666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();

        return;
    end;

    u6:ResetCopy();
    u6.CreatorDribble2 = nil;
    u6.UsingCreatorDribble2 = true;
    u6.AC:Add(function() -- Line: 82
        -- upvalues: u6 (copy)
        u6.UsingCreatorDribble2 = nil;
    end);
    u1.Ability:Fire("CreatorsDribble", {
        State = "Second",
        TimeSent = workspace:GetServerTimeNow()
    });
    TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash, TweenInfo.new(0, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    }):Play();
    u2.States.Ability = true;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = CFrame.new(HumanoidRootPart.CFrame.LookVector);
    u6.AC:Add(BodyGyro);
    u6.AC:Add(LinearVelocity);
    u3:StopAll();
    u3:PlayChar("Chrollo", "CreatorsDribbleFast", Enum.AnimationPriority.Action3);
    u3:PlayBall("Chrollo", "CreatorsDribbleFastBall", Enum.AnimationPriority.Action3);
    u6.AC:Add(task.delay(1.4333333333333333, function() -- Line: 112
        -- upvalues: u6 (copy), u2 (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
    end));
    local u11 = false;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 80;
    u6.AC:Add(NumberValue);
    u6.AC:Connect(RunService.Heartbeat, function(p12) -- Line: 124
        -- upvalues: u11 (ref), LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy), BodyGyro (copy)
        if u11 then
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.RightVector * Vector3.new(1, 0, 1) * -NumberValue.Value + HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * (NumberValue.Value / 2);
        else
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * NumberValue.Value;
        end;

        BodyGyro.CFrame = CFrame.new(HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1));
    end);
    TweenService:Create(NumberValue, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 5
    }):Play();
    task.wait(0.6666666666666666);
    u11 = true;
    NumberValue.Value = 56.25;
    TweenService:Create(NumberValue, TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Value = 5
    }):Play();
    task.wait(0.23333333333333334);
    u11 = false;
    NumberValue.Value = 68.75;
    TweenService:Create(NumberValue, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 25
    }):Play();
end;

return CreatorsDribble;