 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 22
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), RunService (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u3 = u8.AbilityService;
    u5 = u8.Animations;
    u4 = u8.MovementController;
    u6 = u8.BallController;
    u7 = u8.CameraController;
    u1 = u8.Network;
    u2 = u8.BallService;
    local v9 = u8:HoopDist();
    local Attribute = LocalPlayer:GetAttribute("TrueAce");

    if not (Attribute or u8:LookingAtNet()) then
        u8:ResetCD(3);
        Effects:Popup("Must look towards the hoop to use ability!");

        return;
    end;

    if u4.States.PumpFake then
        u8:ResetCD(3);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if not Attribute and v9 > 120 then
        Effects:Popup("Too far away from hoop!");
        u8:ResetCD(3);

        return;
    end;

    u3.Ability:Fire("Missile", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u4.States.Ability = true;
    u4.States.AimAssist = true;
    local v10 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X < 0;
    u5:PlayChar("Ace", `Missile{v10 and "Right" or "Left"}`, Enum.AnimationPriority.Action3);
    u5:PlayBall("Ace", `MissileBall{v10 and "Right" or "Left"}`, Enum.AnimationPriority.Action3);
    local u11 = HumanoidRootPart.CFrame.RightVector * (v10 and -45 or 45) + HumanoidRootPart.CFrame.LookVector * 45;
    local u12 = u11;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    local v13 = tick();
    local u14 = tick() + 1.3166666666666667;
    local u15 = v13 + 0.8;
    local u16 = v13 + 0.26666666666666666;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };
    u8.AC:Add(LinearVelocity);
    local u17 = false;
    local u18 = false;
    local u19 = 0;
    local u20 = Vector3.new(0, 0, 0);

    local function EndVelocity() -- Line: 87
        -- upvalues: u11 (ref), u12 (copy)
        u11 = u11 - u12;
    end;

    local function ReleasePlayer() -- Line: 91
        -- upvalues: u8 (copy), u4 (ref)
        u8.AC:Clean();
        u4.States.Ability = false;
        u4.States.AimAssist = false;
    end;

    local function Jump() -- Line: 97
        -- upvalues: u11 (ref), u19 (ref)
        u11 = u11 + Vector3.new(0, 15.5, 0);
        task.wait(0.07);

        for i = 1, 10 do
            u19 = 1 - math.clamp(i / 15, 0.1, 0.9);
            task.wait(0.01);
            local _ = i;
        end;
    end;

    local function BoostAgain() -- Line: 106
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u11 (ref)
        LinearVelocity:Destroy();
        HumanoidRootPart.AssemblyLinearVelocity = u11 * 1.37 * Vector3.new(1, 0, 1);
    end;

    u8.AC:Connect(RunService.Heartbeat, function(p21) -- Line: 111
        -- upvalues: HumanoidRootPart (copy), u11 (ref), RaycastParams_new_ret (copy), u12 (copy), TweenService (ref), u14 (copy), u19 (ref), LinearVelocity (copy), u20 (ref), u16 (copy), u17 (ref), Jump (copy), u15 (copy), u18 (ref), BoostAgain (copy)
        local v22 = workspace:Raycast(HumanoidRootPart.Position, u11 * (p21 * 15), RaycastParams_new_ret);

        if v22 and v22.Instance then
            u11 = u11 - u12;
        end;

        local v23 = u14 - tick();
        local Value = TweenService:GetValue(math.clamp(v23, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

        if u19 > 0 then
            Value = Value * u19;
        end;

        local Vector3_new_ret = Vector3.new(Value, 0, Value);

        if u11.Y > 0 then
            Vector3_new_ret = Vector3.new(Value, Value, Value);
        elseif u11.Y < 0 then
            Vector3_new_ret = Vector3.new(Value, 1, Value);
        end;

        if LinearVelocity then
            LinearVelocity.VectorVelocity = u11 * Vector3_new_ret;

            if u19 == 0 then
                u20 = LinearVelocity.VectorVelocity;
            end;
        end;

        if u16 <= tick() and not u17 then
            u17 = true;
            task.spawn(Jump);
        end;

        if u15 <= tick() and not u18 then
            u18 = true;
            task.spawn(BoostAgain);
        end;
    end);
    u8.AC:Add(task.delay(1.31, function() -- Line: 149
        -- upvalues: u8 (copy), u4 (ref)
        u8.AC:Clean();
        u4.States.Ability = false;
        u4.States.AimAssist = false;
    end));
    u8.AC:Connect(u3.Ability, function() -- Line: 153
        -- upvalues: u8 (copy), u4 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u6 (ref), CalculateBallTrajectory (ref)
        u8.AC:Clean();
        u4.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        Value.CFrame = u6:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local BodyForce = Instance.new("BodyForce");
        BodyForce.Name = "ExtraGravity";
        BodyForce.Force = Vector3.new(0, -2 * workspace.Gravity * Value.AssemblyMass, 0);
        BodyForce.Parent = Value;
        game.Debris:AddItem(BodyForce, 1.5);
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Hoop.Position, 110, 3 * workspace.Gravity);
        local v24 = 0;

        while v24 < 1.5 do
            local v25 = Value.Position - Hoop.Position;

            if v25:Dot(v25) <= 4 then
                break;
            end;

            v24 = v24 + task.wait();
        end;

        BodyForce:Destroy();
    end);
end;