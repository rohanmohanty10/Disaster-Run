 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8) -- Line: 22
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), RunService (copy), Zones (copy), Essentials (copy), ReplicatedStorage (copy), TweenService (copy)
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

    if u4.States.PumpFake then
        u8:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if u1.CharValues.InAwakening and LocalPlayer.Style.Value ~= "Thief" then
        if not u1.CharValues.HasBall then
            Effects:Popup("Must have ball to use ability!");
            u8:ResetCD(2);

            return;
        end;

        local v9 = u8:CheckInfront(27);

        if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude >= 80 then
            u8:ResetCD(2);
            Effects:Popup("Too far away from hoop!", 1);

            return;
        end;

        if v9 == nil then
            u8:ResetCD(2);
            Effects:Popup("Someone must be infront of you!", 1);

            return;
        end;

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
            u8.CDS[2] = tick() + 100;
        end;

        u3 = u8.AbilityService;
        u5 = u8.Animations;
        u4 = u8.MovementController;
        u4.States.Ability = true;
        u4.States.NoWalk = true;
        task.delay(10, function() -- Line: 55
            -- upvalues: u4 (ref)
            u4.States.Ability = false;
            u4.States.NoWalk = false;
        end);
        u5:StopAll();
        u3.Ability:Fire("FormlessFade", {
            TimeSent = workspace:GetServerTimeNow(),
            OtherChar = v9
        });
        u8:StillHasBall();

        return;
    end;

    u4.States.Ability = true;
    u4.States.AimAssist = true;
    u3.Ability:Fire("FormlessFade", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(0.1);
    RunService.Heartbeat:Wait();
    u8.AC:Clean();
    local Shiftlock = u7.Shiftlock;
    u7:SetShiftlock(true);
    local u10 = 1.15;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u1.CharValues.InZone then
        u10 = u10 + 0.15;
    end;

    tick();
    tick();
    local u11 = "Fake";
    u5:StopAll();
    local u12 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X < 0;
    local v13, v14;

    if u12 then
        v13 = u5:PlayChar("Ace", "Ability2R", Enum.AnimationPriority.Action3, true);
        v14 = u5:PlayBall("Ace", "Ability2RBall", Enum.AnimationPriority.Action3, true);
    else
        v13 = u5:PlayChar("Ace", "Ability2L", Enum.AnimationPriority.Action3, true);
        v14 = u5:PlayBall("Ace", "Ability2LBall", Enum.AnimationPriority.Action3, true);
    end;

    v13:AdjustSpeed(u10);
    v14:AdjustSpeed(u10);
    local u15 = 45;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u8.AC:Add(LinearVelocity);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    u8.AC:Connect(RunService.PreSimulation, function(p16) -- Line: 133
        -- upvalues: u11 (ref), u15 (ref), Essentials (ref), HumanoidRootPart (copy), LinearVelocity (ref), u12 (ref)
        if u11 == "Fake" then
            u15 = Essentials:Lerp(u15, 30, (math.clamp(p16 * 4, 0, 1)));
        elseif u11 == "Boost" then
            u15 = Essentials:Lerp(u15, 110, (math.clamp(p16 * 43.5, 0, 1)));
        elseif u11 == "Roll" then
            u15 = Essentials:Lerp(u15, 30, (math.clamp(p16 * 5, 0, 1)));
        elseif u11 == "End" then
            u15 = Essentials:Lerp(u15, 45, (math.clamp(p16 * 10, 0, 1)));
        end;

        local Unit = (HumanoidRootPart.CFrame.RightVector * Vector3.new(1, 0, 1)).Unit;
        LinearVelocity.VectorVelocity = (Unit ~= Unit and Vector3.new(0, 0, 0) or Unit) * (u12 and 1 or -1) * (u15 / 1.15);
    end);
    u8.AC:Connect(u3.Ability, function(p17) -- Line: 153
        -- upvalues: ReplicatedStorage (ref), Character (copy), HumanoidRootPart (copy), LocalPlayer (ref)
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;

        if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude <= 115 then
            p17 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        end;

        local v18 = p17 - Value.Position;
        local math_log_ret = math.log(v18.Magnitude * 0.045 + 0.5);
        Value.AssemblyLinearVelocity = v18 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
    u8.AC:Add(function() -- Line: 177
        -- upvalues: u4 (ref), u7 (ref), Shiftlock (copy)
        u4.States.AimAssist = false;
        u4.States.Ability = false;
        u7:SetShiftlock(Shiftlock);
    end);
    task.spawn(function() -- Line: 184
        -- upvalues: u10 (ref), TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        task.delay(0.1 / u10, function() -- Line: 186
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
                FieldOfView = 30
            }):Play();
        end);
        task.delay(0.83 / u10, function() -- Line: 190
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
                FieldOfView = 100
            }):Play();
        end);
        task.delay(1.3 / u10, function() -- Line: 194
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
        end);
    end);
    u8.AC:Add(task.delay(0.5 / u10, function() -- Line: 199
        -- upvalues: u12 (ref), u11 (ref)
        u12 = not u12;
        u11 = "Boost";
    end));
    u8.AC:Add(task.delay(0.82 / u10, function() -- Line: 204
        -- upvalues: u11 (ref)
        u11 = "Roll";
    end));
    u8.AC:Add(task.delay(1.2 / u10, function() -- Line: 208
        -- upvalues: u11 (ref)
        u11 = "End";
    end));
    u8.AC:Add(task.delay(1.75 / u10, function() -- Line: 212
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
end;