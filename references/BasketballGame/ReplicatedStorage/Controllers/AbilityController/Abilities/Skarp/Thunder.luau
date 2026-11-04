 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Tables.Cooldowns);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Essentials (copy), RunService (copy), ReplicatedStorage (copy), Effects (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        local _, v7 = u3:GetEnemyWithinDistance(50, true);

        if not (v7 and (u3:GetCharacterPossessingBall() and u3:GetCharacterPossessingBall() == v7)) then
            u6:ResetCD(2);
            Effects:Popup("An enemy player with the ball must be close to you!", 4);

            return;
        end;

        local HumanoidRootPart2 = v7.HumanoidRootPart;
        local LookVector = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector;
        u1.Ability:Fire("Thunder", {
            State = "Thunderclap and Flash",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v7,
            Direction = LookVector
        });
        u4:StopAll();
        u4:PlayChar("Eclipse", "BladeDash", Enum.AnimationPriority.Action3);
        u4:PlayBall("Eclipse", "BladeDashBall", Enum.AnimationPriority.Action3);
        local NumberValue = Instance.new("NumberValue");
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Parent = HumanoidRootPart;
        u6.AC:Add(NumberValue);
        u6.AC:Add(LinearVelocity);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(0.5, function() -- Line: 182
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u6.AC:Add(task.delay(0.5, function() -- Line: 186
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        TweenService:Create(NumberValue, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = 200
        }):Play();
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        local u8 = nil;
        tick();
        local u9 = nil;
        u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 199
            -- upvalues: HumanoidRootPart (copy), HumanoidRootPart2 (copy), u8 (ref), LookVector (ref), LinearVelocity (copy), NumberValue (copy), RaycastParams_new_ret (copy), u9 (ref)
            if (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude > 5 and not u8 then
                LookVector = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector;
                LinearVelocity.VectorVelocity = LookVector * NumberValue.Value;
            else
                LinearVelocity.VectorVelocity = LookVector * NumberValue.Value;
                u8 = true;
            end;

            local v11 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 4, RaycastParams_new_ret);

            if v11 and not v11.Instance.Parent:FindFirstChild("Humanoid") then
                u9:Disconnect();
                LinearVelocity:Destroy();
            end;
        end);
        task.delay(0.3333333333333333, function() -- Line: 215
            -- upvalues: NumberValue (copy), LinearVelocity (copy), RunService (ref), u9 (ref)
            NumberValue.Value = 0;
            LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
            RunService.Heartbeat:Wait();
            u9:Disconnect();
            LinearVelocity:Destroy();
        end);

        return;
    end;

    local u12 = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
    local v13 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v14 = {};
    local math_clamp_ret = math.clamp(v13.X / Humanoid.WalkSpeed, 0.01, 1);
    v14.R = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v13.X / Humanoid.WalkSpeed, -1, -0.01);
    v14.L = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v13.Z / Humanoid.WalkSpeed, -1, -0.01);
    v14.F = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v13.Z / Humanoid.WalkSpeed, 0.01, 1);
    v14.B = math.abs(math_clamp_ret4);

    if u12.Magnitude < 5 then
        u12 = HumanoidRootPart.CFrame.LookVector;
    end;

    if u12.Y > 3 and (u12.X < 5 and u12.Z < 5) then
        u12 = HumanoidRootPart.CFrame.LookVector;
    end;

    local Position = HumanoidRootPart.Position;
    u2.States.Ability = true;
    task.delay(0.3333333333333333, function() -- Line: 48
        -- upvalues: u2 (ref), u6 (copy), u1 (ref), u4 (ref), Essentials (ref), RunService (ref), Humanoid (copy), LocalPlayer (ref), Character (copy), HumanoidRootPart (copy), Position (copy), ReplicatedStorage (ref), u3 (ref)
        u2.States.Ability = false;
        u6.AC:Clean();
        u6.AC:Connect(u1.Ability, function() -- Line: 52
            -- upvalues: u6 (ref), u4 (ref), Essentials (ref), u2 (ref), RunService (ref), Humanoid (ref), LocalPlayer (ref), Character (ref), HumanoidRootPart (ref), Position (ref), ReplicatedStorage (ref), u3 (ref)
            u6.AC:Clean();
            u4:StopAll();
            local v15 = u4:PlayChar("Flash", `Ability2Layup{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3, true);
            local v16 = u4:PlayBall("Flash", `Ability2Layup{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
            v15.TimePosition = 0.5;
            v16.TimePosition = 0.5;
            u2.States.Dunking = true;
            task.spawn(function() -- Line: 63
                -- upvalues: RunService (ref), Humanoid (ref), LocalPlayer (ref), Character (ref), HumanoidRootPart (ref), Position (ref)
                RunService.Heartbeat:Wait();
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                local Position2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret.FilterDescendantsInstances = { Character };
                local v17 = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).Magnitude > 0;

                if (HumanoidRootPart.Position - Position2).Magnitude + 15 < (Position - Position2).Magnitude then
                    HumanoidRootPart.CFrame = CFrame.new(Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

                    if v17 then
                        v17 = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).Unit;
                    end;
                else
                    v17 = (v17 and Humanoid.MoveDirection * Vector3.new(1, 0, 1) or HumanoidRootPart.Position - Vector3.new(Position2.X, HumanoidRootPart.Position.Y, Position2.Z)).Unit;
                end;

                if v17 then
                    local v18 = v17 * 15 + Vector3.new(0, 2.5, 0);
                    local v19 = workspace:Raycast(HumanoidRootPart.Position, v18, RaycastParams_new_ret);

                    if not v19 then
                        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v18) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

                        return;
                    end;

                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v19.Position - HumanoidRootPart.Position) * (v19.Distance / 2)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                end;
            end);
            task.wait(0.35);
            u2.States.Dunking = false;
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position2 = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
            local v20 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
            local math_log_ret = math.log(1 + v20.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v20 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);
    end);
    u1.Ability:Fire("Thunder", {
        State = "Dash",
        TimeSent = workspace:GetServerTimeNow(),
        Direction = u12.Unit
    });
    local v21 = 0.1;
    local v22 = "F";

    for i, v in v14 do
        if v21 < v then
            v22 = i;
            v21 = v;
        end;
    end;

    local v23 = u6.Network.CharValues.HasBall and "B" or "";
    u4:StopAll();
    u4:PlayChar("Flash", `Dash{v22}{v23}`, Enum.AnimationPriority.Action3);
    u4:PlayBall("Flash", `Dash{v22}Ball`, Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local u24 = 150;
    u6.AC:Connect(RunService.Heartbeat, function(p25) -- Line: 148
        -- upvalues: u24 (ref), LinearVelocity (copy), u12 (ref)
        u24 = u24 - p25 * 150;
        LinearVelocity.VectorVelocity = u12.Unit * u24;
    end);
end;