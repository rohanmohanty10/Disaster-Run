 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Teams = game:GetService("Teams");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local ShotReduce = require(ReplicatedStorage.Shared.Utility.ShotReduce);
local Knit = require(ReplicatedStorage.Packages.Knit);
local script_BallStateClient = require(script.BallStateClient);
local script_BallPhysicsClient = require(script.BallPhysicsClient);
local ZoneDribbles = Zones.ZoneDribbles;
local ZonePumpFakes = Zones.ZonePumpFakes;
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Humanoid = u1:WaitForChild("Humanoid");
local Basketball = ReplicatedStorage.Basketball;
local workspace_BARRIER = workspace.BARRIER;
local Away = Teams.Away;
local Home = Teams.Home;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = Trove.new();
local u13 = Trove.new();
local u14 = Trove.new();
local u15 = Trove.new();
local u16 = "";
local u17 = tick();
local u18 = false;
local u19 = tick();
local u20 = tick();
local u21 = 0;
local u22 = nil;
local u23 = false;
local u24 = nil;
local u25 = nil;
local u26 = Knit.CreateController({
    Name = "BallController",
    Dribbles = 0,
    MaxDribbles = 3,
    LastDribble = 0,
    DribbleDB = tick()
});
local u27 = {
    ["true"] = "R",
    ["false"] = "L"
};

local function getDefenseRigMockPlayerInstance(p28) -- Line: 79
    return {
        Name = "DefenseRigMockPlayer",
        Character = p28
    };
end;

local u29 = getfenv(u26.GetMaxDribbles);

function u26.GetMaxDribbles(p30) -- Line: 87
    -- upvalues: LocalPlayer (copy), u11 (ref), ZoneDribbles (copy)
    if LocalPlayer:GetAttribute("InfiniteDribbles") then
        return math.huge;
    end;

    if not u11.CharValues.InZone then
        return 3;
    end;

    local Value = LocalPlayer.Zone.Value;

    return Value == "777" and u11.CharValues.ZoneRNG ~= 3 and 3 or (ZoneDribbles[Value] or 3);
end;

function u26.GetMaxPumpFakes(p31) -- Line: 127
    -- upvalues: LocalPlayer (copy), u11 (ref), ZonePumpFakes (copy)
    return LocalPlayer:GetAttribute("NoPumpFake") and 0 or (u11.CharValues.InZone and (ZonePumpFakes[LocalPlayer.Zone.Value] or 1) or 1);
end;

local function u32() -- Line: 141
    for i = 1, 2 do
        local _, result = pcall(getfenv, i);

        if debug.info(i, "s") == "[C]" then
            return error();
        end;

        if result.getrenv or (result.syn or result.checkcaller) then
            return error();
        end;

        if not (result.script.Parent and (typeof(result.script.Parent) == "Instance" and typeof(result.script) == "Instance")) then
            return error();
        end;

        local _ = i;
    end;

    return true;
end;

function u26.NoActionFORABILITYCONTROLLER(p33, p34) -- Line: 158
    -- upvalues: u19 (ref), u11 (ref), ReplicatedStorage (copy), Humanoid (ref), u7 (ref), u1 (ref), workspace_BARRIER (copy)
    return (u19 > tick() or not (p34.Jump and not (u11.CharValues.HasBall and (p34.Jump ~= "Ball" and p34.Jump ~= "Both")) or (ReplicatedStorage.GameTweaks:GetAttribute("JumpAbilities") or Humanoid.FloorMaterial ~= Enum.Material.Air)) or (not p34.Shooting and (u7.States.Dunking or (u7.States.Stunned or (u7.States.Shooting or u7.States.AimAssist))) or (workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable or (ReplicatedStorage.GameValues.State.Value ~= "Playing" or (u1.IsRagdoll.Value or workspace_BARRIER.CanCollide))))) and true or false;
end;

function u26.NoAction(p35: table, p36: number?, p37: boolean?) -- Line: 177
    -- upvalues: u19 (ref), u7 (ref), u8 (ref), ReplicatedStorage (copy), u1 (ref), workspace_BARRIER (copy)
    return (u19 > tick() or not p37 and (u7.States.Dunking or (u7.States.Stunned or (u7.States.Shooting or u7.States.AimAssist))) or (u7.States.Ability and (p36 ~= 1 or not u8.InPostForm) or (workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable or (ReplicatedStorage.GameValues.State.Value ~= "Playing" or (u1.IsRagdoll.Value or workspace_BARRIER.CanCollide))))) and true or false;
end;

function u26.Dunk(p38, p39, p40, p41) -- Line: 196
    -- upvalues: u17 (ref), u7 (ref), u8 (ref), u11 (ref), script_BallStateClient (copy), Effects (copy), LocalPlayer (copy), u26 (ref), u22 (ref), HumanoidRootPart (ref), Zones (copy), u32 (copy), TweenService (copy), u18 (ref), u6 (ref), u12 (copy), u13 (copy), u14 (copy), Essentials (copy), RunService (copy), Humanoid (ref), SfxManager (copy), u2 (ref), u1 (ref)
    if u17 > tick() then
        return;
    end;

    if p38:NoAction() then
        return;
    end;

    if u7.States.PumpFake then
        return;
    end;

    if u8.InPostForm then
        return;
    end;

    if u11.CharValues.HasBall == false then
        return;
    end;

    if script_BallStateClient.cantShootBallUntilOutOfThreePointLine(p38) then
        Effects:Popup("Get the ball out of the 3 pointer line to score!", 2);

        return;
    end;

    if LocalPlayer:GetAttribute("DesyncPlr") then
        return;
    end;

    if not u26 then
        return;
    end;

    local Vector3_new_ret = Vector3.new(u22.Position.X, HumanoidRootPart.Position.Y, u22.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if u11.CharValues.InAwakening and u8.ChaosMode then
        if Magnitude >= 50 then
            return;
        end;

        p41 = true;
        p39 = "TwohandHanging";
        p40 = "TwohandHanging";
    else
        local v42 = 1;

        if LocalPlayer.Style.Value == "Symbiote" and u11.CharValues.InAwakening then
            v42 = v42 + 0.3;
        end;

        if u11.CharValues.InZone and Zones.DunkDistBuffZones[LocalPlayer.Zone.Value] then
            v42 = v42 + Zones.DunkDistBuffZones[LocalPlayer.Zone.Value];
        end;

        if u11.CharValues.DunkTick < workspace:GetServerTimeNow() and not p41 then
            local v43 = HumanoidRootPart.AssemblyLinearVelocity.Magnitude < 5 and 17 or ((u7.States.Running or p39) and 36 or 25);

            if v43 and v43 * v42 < Magnitude then
                if u11.ServerType == "Tutorial" then
                    Effects:Popup("Get closer to the hoop to dunk!");
                end;

                return;
            end;
        end;
    end;

    task.spawn(function() -- Line: 250
        -- upvalues: u32 (ref), u26 (ref), LocalPlayer (ref)
        local success = pcall(function() -- Line: 251
            -- upvalues: u32 (ref)
            return u32();
        end);
        local success2 = pcall(function() -- Line: 254
            local script2 = getfenv(1).script;

            return (typeof(script2) ~= "Instance" or (getfenv(1).script ~= getfenv(2).script or getfenv(1).script ~= getfenv(0).script)) and true or error();
        end);
        local success3 = pcall(function() -- Line: 260
            local v44 = debug.traceback("s", 1):split(":");
            local v45 = v44[4] and tonumber(v44[4]) or v44[3] and tonumber(v44[3]);

            return tonumber(v45) and tonumber(v45) > 12 and true or error();
        end);
        local success4 = pcall(function() -- Line: 269
            return #game:GetService("CoreGui"):GetChildren();
        end);

        for i = 1, 10 do
            local _, result = pcall(getfenv, i);

            if result.getrenv or (result.syn or result.checkcaller) then
                u26 = {};

                return error("Script kiddie");
            end;

            if result and (result.script and not (result.script.Parent and (typeof(result.script.Parent) == "Instance" and typeof(result.script) == "Instance"))) then
                u26 = {};

                return error("Script kiddie");
            end;

            local _ = i;
        end;

        if not success3 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if not success then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if not success2 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if success4 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;
    end);
    u7.States.Dunking = true;
    u7.States.Ability = true;
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = 105
    }):Play();
    task.delay(0.5, function() -- Line: 301
        -- upvalues: u7 (ref)
        u7.States.Ability = false;
    end);
    u17 = tick() + 5;
    u18 = true;
    u6:StopAll();
    u12:Clean();
    u13:Clean();
    u14:Clean();
    local u46 = 8;
    local u47 = false;

    if Magnitude <= 17 and not p41 then
        u46 = 3;
        local v48 = HumanoidRootPart.CFrame.LookVector:Dot((u22.Position - HumanoidRootPart.Position).Unit);
        local math_acos_ret = math.acos(v48);
        local v49, v50;

        if math_acos_ret < math.pi / 2 or math_acos_ret < math.pi / 1.65 then
            if u22.Position.Z < HumanoidRootPart.Position.Z then
                v49 = u6:PlayChar("Dunks", "LayupL", Enum.AnimationPriority.Action3, true);
                v50 = u6:PlayBall("Dunks", "LayupL", Enum.AnimationPriority.Action3, true);
            else
                v49 = u6:PlayChar("Dunks", "LayupR", Enum.AnimationPriority.Action3, true);
                v50 = u6:PlayBall("Dunks", "LayupR", Enum.AnimationPriority.Action3, true);
            end;
        else
            v49 = u6:PlayChar("Dunks", `Layup{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);
            v50 = u6:PlayBall("Dunks", `Layup{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);
        end;

        local v51 = 1;

        if u11.CharValues.InZone and Zones.ZoneIncreasedLayupSpeed[LocalPlayer.Zone.Value] then
            v51 = v51 + Zones.ZoneIncreasedLayupSpeed[LocalPlayer.Zone.Value];
        end;

        v49:AdjustSpeed(v51 * 1.35);
        v50:AdjustSpeed(v51 * 1.35);
        RunService.Heartbeat:Wait();
        workspace.Gravity = 60;
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        SfxManager:playSound({
            Sound = "Layup",
            Parent = LocalPlayer.Character.PrimaryPart
        });
        task.delay(0.15 / v51, function() -- Line: 358
            -- upvalues: HumanoidRootPart (ref), Vector3_new_ret (copy)
            if math.abs(HumanoidRootPart.Position.Z - Vector3_new_ret.Z) <= 4 then
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.Parent = HumanoidRootPart;

                if HumanoidRootPart.Position.Z > Vector3_new_ret.Z then
                    LinearVelocity.VectorVelocity = (HumanoidRootPart.Position + Vector3.new(0, 5, 4) + HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.Position).Unit * 30;
                else
                    LinearVelocity.VectorVelocity = (HumanoidRootPart.Position + Vector3.new(0, 5, -4) + HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.Position).Unit * 30;
                end;

                task.delay(0.1, function() -- Line: 370
                    -- upvalues: LinearVelocity (copy)
                    LinearVelocity:Destroy();
                end);
            end;
        end);
        task.delay(0.4 / v51, function() -- Line: 376
            -- upvalues: u22 (ref), HumanoidRootPart (ref), u2 (ref)
            workspace.Gravity = 100;
            local Unit = (u22.Position - HumanoidRootPart.Position).Unit;
            u2.Throw:Fire(Vector2.new(Unit.X, Unit.Z), nil, {
                Layup = true
            });
        end);
    elseif u7.States.Running or p39 then
        local v52 = { "Windmill", "Windmill360", "BehindLeg", "BetweenLeg", "ReverseDunk", "MichaelDunk", "TwohandReverseWindmill", "TwohandHanging" };
        local v53 = v52[math.random(1, #v52)];
        u47 = string.match(v53, "Hanging") and true or u47;
        local u54 = u6:PlayChar("Dunks", `{v53}{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);
        local u55 = u6:PlayBall("Dunks", `{v53}{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);

        if p39 then
            u47 = string.match(p39, "Hanging") and true or u47;
            u6:StopAll();
            u54 = u6:PlayChar("Dunks", `{p39}{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);
        end;

        if p40 then
            u55 = u6:PlayBall("Dunks", `{p39}{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true);
        end;

        u54:Play();
        u55:Play();
        u54:AdjustSpeed(1.2);
        u55:AdjustSpeed(1.2);
        task.delay(0.5, function() -- Line: 412
            -- upvalues: u18 (ref), u54 (ref), u55 (ref)
            if u18 then
                u54:AdjustSpeed(1);
                u55:AdjustSpeed(1);

                return;
            end;

            u54:AdjustSpeed(1);
            u55:AdjustSpeed(1);
        end);
        u2.Dunk:Fire("Windmill", u47);
    else
        local u56 = u6:PlayChar("Dunks", "Tomahawk", Enum.AnimationPriority.Action3, true);
        local u57 = u6:PlayBall("Dunks", "Tomahawk", Enum.AnimationPriority.Action3, true);
        u56:AdjustSpeed(1.1);
        u57:AdjustSpeed(1.1);
        task.delay(0.5, function() -- Line: 430
            -- upvalues: u18 (ref), u56 (copy), u57 (copy)
            if u18 then
                u56:AdjustSpeed(1);
                u57:AdjustSpeed(1);

                return;
            end;

            u56:AdjustSpeed(1);
            u57:AdjustSpeed(1);
        end);
        u2.Dunk:Fire("Tomahawk");
    end;

    local u58 = true;
    task.delay(3.5, function() -- Line: 445
        -- upvalues: u58 (ref)
        u58 = false;
    end);
    u14:Connect(RunService.Heartbeat, function(p59) -- Line: 449
        -- upvalues: u58 (ref), u1 (ref), u7 (ref), u14 (ref), u17 (ref), HumanoidRootPart (ref), u22 (ref), u46 (ref), u11 (ref), u47 (ref)
        if u58 ~= false and not (u1.IsRagdoll.Value or u7.States.Stunned) then
            if (HumanoidRootPart.Position - u22.Position).Magnitude < u46 or u11.CharValues.HasBall == false then
                if u11.CharValues.HasBall == false then
                    u7.States.Dunking = false;
                end;

                if not u47 then
                    u58 = false;
                end;

                u17 = tick() + 2;
            end;

            return;
        end;

        u14:Clean();
        u17 = tick() + 2;
        u7.States.Dunking = false;
    end);
end;

local u60 = 0;

function u26.Dribble(u61) -- Line: 477
    -- upvalues: u7 (ref), u11 (ref), Humanoid (ref), u8 (ref), u12 (copy), u26 (ref), LocalPlayer (copy), TweenService (copy), u16 (ref), u29 (copy), u60 (ref), HumanoidRootPart (ref), Zones (copy), ReplicatedStorage (copy), u27 (copy), u6 (ref), u2 (ref), u1 (ref), RunService (copy)
    if u61:NoAction() then
        return;
    end;

    if u7.States.PumpFake then
        return;
    end;

    if u11.CharValues.HasBall == false then
        return;
    end;

    if u61.DribbleDB > tick() then
        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if u8.InPostForm then
        return;
    end;

    if u12 then
        u12:Clean();
    end;

    if not u26 then
        return;
    end;

    if u61.DribbleTweens then
        for _, v in u61.DribbleTweens do
            v:Cancel();
        end;

        table.clear(u61.DribbleTweens);
    else
        u61.DribbleTweens = {};
    end;

    local BG = LocalPlayer.PlayerGui.DribbleBar.BG;
    TweenService:Create(BG, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();

    if u61.DribbleDB + 3.5 < tick() then
        u16 = "";
        u61.Dribbles = 0;
    end;

    u61.Dribbles = u61.Dribbles + 1;
    task.spawn(function() -- Line: 505
        -- upvalues: u29 (ref), u61 (copy), u26 (ref)
        if u29 ~= getfenv(u61.GetMaxDribbles) then
            u26 = nil;
        end;
    end);
    local v62 = u11.CharValues.InZone and LocalPlayer.Zone.Value == "Shadow";
    local MaxDribbles = u61:GetMaxDribbles();

    if MaxDribbles > 15 and not LocalPlayer:GetAttribute("InfiniteDribbles") then
        u26 = nil;
    end;

    if u61.Dribbles == u61.LastDribble and tick() - u61.DribbleDB <= 0.8 then
        if u60 >= 2 then
            u26 = nil;
        end;

        u60 = u60 + 1;
    end;

    u61.LastDribble = u61.Dribbles;
    local u63 = nil;
    local u64 = TweenService:Create(BG.Bar.UIGradient, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Offset = Vector2.new(0, u61.Dribbles / MaxDribbles)
    });
    u64:Play();
    BG.Load.UIGradient.Offset = Vector2.new(0, u61.Dribbles / MaxDribbles);
    TweenService:Create(BG.Load.UIGradient, TweenInfo.new(4.25), {
        Offset = Vector2.new(0, 0)
    }):Play();
    table.insert(u61.DribbleTweens, u64);
    task.delay(4, function() -- Line: 536
        -- upvalues: u61 (copy), u63 (ref), TweenService (ref), BG (copy), u64 (copy)
        if u61.DribbleDB == u63 then
            TweenService:Create(BG.Bar.UIGradient, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0, 0)
            }):Play();
            table.insert(u61.DribbleTweens, u64);
            task.delay(0.75, function() -- Line: 542
                -- upvalues: u61 (ref), u63 (ref), TweenService (ref), BG (ref)
                if u61.DribbleDB == u63 then
                    TweenService:Create(BG, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        GroupTransparency = 1
                    }):Play();
                end;
            end);
        end;
    end);

    if MaxDribbles <= u61.Dribbles then
        u61.Dribbles = 0;
        u61.DribbleDB = tick() + 4;
        task.delay(0.1, function() -- Line: 554
            -- upvalues: u16 (ref)
            u16 = "";
        end);
    else
        u61.DribbleDB = tick() + (v62 and 0.2 or 0.5);
    end;

    u63 = u61.DribbleDB;
    local v65 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v66 = {};
    local math_clamp_ret = math.clamp(v65.X / Humanoid.WalkSpeed, 0.01, 1);
    v66.Right = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v65.X / Humanoid.WalkSpeed, -1, -0.01);
    v66.Left = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v65.Z / Humanoid.WalkSpeed, -1, -0.01);
    v66.Front = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v65.Z / Humanoid.WalkSpeed, 0.01, 1);
    v66.Back = math.abs(math_clamp_ret4);
    local v67 = 0.1;
    local v68 = "Front";

    for i, v in v66 do
        if v67 < v then
            v68 = i;
            v67 = v;
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "DribbleVelocityBasketball";
    BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * math.huge;
    BodyVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "BodyGyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * math.huge;
    BodyGyro.Parent = HumanoidRootPart;
    u12:Add(BodyGyro);
    u12:Add(BodyVelocity);
    local Vector3_zero = Vector3.zero;
    local u69 = 0;
    local v70;

    if v68 == "Back" then
        Vector3_zero = HumanoidRootPart.CFrame.LookVector * -1;
        v70 = not u11.CharValues.OnRight;
        u69 = 40;
    elseif v68 == "Right" then
        Vector3_zero = HumanoidRootPart.CFrame.RightVector;
        u69 = 35;
        v70 = true;
    elseif v68 == "Left" then
        Vector3_zero = -HumanoidRootPart.CFrame.RightVector;
        u69 = 35;
        v70 = false;
    else
        v70 = not u11.CharValues.OnRight;

        if v67 < 0.2 then
            BodyVelocity:Destroy();
        else
            Vector3_zero = HumanoidRootPart.CFrame.LookVector;
            u69 = 30;
        end;
    end;

    local Unit = (Vector3_zero * Vector3.new(1, 0, 1)).Unit;

    if u11.CharValues.InZone and Zones.ZoneDribblingSpeed[LocalPlayer.Zone.Value] then
        u69 = u69 * (1 + Zones.ZoneDribblingSpeed[LocalPlayer.Zone.Value]);
    end;

    if ReplicatedStorage.GameValues[`{LocalPlayer.Team.Name}DribbleIncrease`].Value then
        u69 = u69 * 1.15;
    end;

    if u11.CharValues.InfinityVisionMode >= workspace:GetServerTimeNow() then
        u69 = u69 * 1.25;
    end;

    if u8.TailMode then
        u69 = u69 * 1.25;
    end;

    if u8.InMoon then
        u69 = u69 * 1.25;
    end;

    if u8.InEvolution then
        u69 = u69 * 1.35;
    end;

    if u8.InDisable then
        u69 = u69 * 1.35;
    end;

    if u8.InNewWorld then
        u69 = u69 * 1.35;
    end;

    if u8.InLibertyCrown then
        u69 = u69 * 1.35;
    end;

    if u8.InDuplication then
        u69 = u69 * math.sqrt(2);
    end;

    if u8.OneTimeBoost then
        u69 = u69 * u8.OneTimeBoost;
        u8.OneTimeBoost = nil;
    end;

    if u11.CharValues.DribblingSpeedBoost and (u11.CharValues.DribblingSpeedBoost > workspace:GetServerTimeNow() and (Zones.ZoneDribblingSpeedOnSteal[LocalPlayer.Zone.Value] or Zones.ZoneDribblingSpeedOnPickupLooseBall[LocalPlayer.Zone.Value])) then
        u69 = u69 * (1 + (Zones.ZoneDribblingSpeedOnSteal[LocalPlayer.Zone.Value] or Zones.ZoneDribblingSpeedOnPickupLooseBall[LocalPlayer.Zone.Value]));
    end;

    if u11.CharValues.PopstarStreak and u11.CharValues.PopstarStreak > 0 then
        u69 = u69 * (1 + u11.CharValues.PopstarStreak);
    end;

    if LocalPlayer:GetAttribute("Tri-SlashSpeedBoost") then
        u69 = u69 * (1 + LocalPlayer:GetAttribute("Tri-SlashSpeedBoost") / 16);
    end;

    if LocalPlayer:GetAttribute("SlightBuff") then
        u69 = u69 * 1.07;
    end;

    local v71 = "";
    local v72 = "BDCombo";
    local v73;

    if u16 == "" then
        u16 = `{string.sub(v68, 1, 1)}{u27[tostring(u11.CharValues.OnRight)]}`;
        v73 = false;
    else
        v73 = true;
    end;

    if v73 then
        u16 = `{u16}{string.sub(v68, 1, 1)}`;

        for _, child in ReplicatedStorage.Assets.Animations:GetChildren() do
            if child.Name:match("Combo") ~= nil then
                local v74 = child;

                for _, child2 in child:GetChildren() do
                    if child2.Name == u16 then
                        v72 = v74.Name;
                        v71 = child2.Name;
                        break;
                    end;
                end;
            end;
        end;
    end;

    u6:StopAll();
    local v75, v76;

    if v71 == "" then
        v75 = u6:PlayChar("Dribbles", `{v68}{u27[tostring(u11.CharValues.OnRight)]}`, Enum.AnimationPriority.Action2, v62);
        v76 = u6:PlayBall("Dribbles", `{v68}{u27[tostring(u11.CharValues.OnRight)]}`, Enum.AnimationPriority.Action2, v62);
    else
        v75 = u6:PlayChar(v72, u16, Enum.AnimationPriority.Action2, v62);
        v76 = u6:PlayBall(v72, u16, Enum.AnimationPriority.Action2, v62);
    end;

    local v77 = u11.CharValues.InZone and Zones.ZoneDribblingDuration[LocalPlayer.Zone.Value] or 0.55;
    u11.CharValues.OnRight = v70;
    u11.CharValues.Dribbling = true;
    u11.CharValues.DribblingTick = tick() + v77;
    task.delay(v77, function() -- Line: 703
        -- upvalues: u11 (ref)
        if u11.CharValues.DribblingTick <= tick() then
            u11.CharValues.Dribbling = false;
        end;
    end);
    u2.Dribble:Fire(v70, Unit);

    if v62 then
        if v75 then
            v75:AdjustSpeed(2);
        end;

        if v76 then
            v76:AdjustSpeed(2);
        end;

        u69 = u69 * 2.25;
        task.delay(0.1, function() -- Line: 721
            -- upvalues: u12 (ref)
            u12:Clean();
        end);
    else
        task.delay(0.45, function() -- Line: 725
            -- upvalues: u12 (ref)
            u12:Clean();
        end);
    end;

    if BodyVelocity then
        local u78 = u69;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { u1 };
        u12:Connect(RunService.Heartbeat, function(p79) -- Line: 737
            -- upvalues: u11 (ref), u12 (ref), u7 (ref), HumanoidRootPart (ref), u8 (ref), Unit (ref), RaycastParams_new_ret (copy), u69 (ref), u78 (copy), BodyVelocity (copy)
            if game.Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                return;
            end;

            if u11.CharValues.HasBall == false then
                u12:Clean();

                return;
            end;

            if u7.States.Ability then
                u12:Clean();

                return;
            end;

            local v80 = workspace:Raycast(HumanoidRootPart.Position, u8.Confusion and -Unit * 4 or Unit * 4, RaycastParams_new_ret);

            if v80 and v80.Instance.Parent:FindFirstChild("Humanoid") == nil then
                u12:Clean();
            end;

            if u69 >= u78 / 2.75 then
                if u8.Confusion then
                    BodyVelocity.Velocity = -Unit * u69;
                else
                    BodyVelocity.Velocity = Unit * u69;
                end;

                u69 = u69 - p79 * 16;
            end;
        end);
    end;
end;

local u81 = 1;

function u26.Shoot(u82, u83) -- Line: 762
    -- upvalues: u11 (ref), Humanoid (ref), u5 (ref), LocalPlayer (copy), u26 (ref), script_BallStateClient (copy), Effects (copy), ReplicatedStorage (copy), u32 (copy), u81 (ref), u23 (ref), u13 (copy), u12 (copy), u9 (ref), u7 (ref), u6 (ref), u2 (ref), HumanoidRootPart (ref), Zones (copy), Essentials (copy), ShotReduce (copy), u8 (ref), u1 (ref), RunService (copy), u20 (ref), u21 (ref), u25 (ref), u19 (ref)
    if u82:NoAction() then
        return;
    end;

    if u11.CharValues.HasBall == false then
        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if workspace:FindFirstChild("CamRig") then
        return;
    end;

    if u5:JustBeganCutscene() then
        return;
    end;

    if LocalPlayer:GetAttribute("DesyncPlr") then
        return;
    end;

    if not u26 then
        return;
    end;

    if script_BallStateClient.cantShootBallUntilOutOfThreePointLine(u82) then
        Effects:Popup("Get the ball out of the 3 pointer line to shoot!", 2);

        return;
    end;

    if ReplicatedStorage.GameValues.Away.Value ~= ReplicatedStorage.GameValues.Home.Value and ReplicatedStorage.GameValues.Buzz.Value then
        return;
    end;

    task.spawn(function() -- Line: 779
        -- upvalues: u32 (ref), u26 (ref), LocalPlayer (ref)
        local success = pcall(function() -- Line: 780
            -- upvalues: u32 (ref)
            return u32();
        end);
        local success2 = pcall(function() -- Line: 783
            local script2 = getfenv(1).script;

            return (typeof(script2) ~= "Instance" or (getfenv(1).script ~= getfenv(2).script or getfenv(1).script ~= getfenv(0).script)) and true or error();
        end);
        local success3 = pcall(function() -- Line: 789
            local v84 = debug.traceback("s", 1):split(":");
            local v85 = v84[4] and tonumber(v84[4]) or v84[3] and tonumber(v84[3]);

            return tonumber(v85) and tonumber(v85) > 12 and true or error();
        end);
        local success4 = pcall(function() -- Line: 798
            return #game:GetService("CoreGui"):GetChildren();
        end);

        for i = 1, 10 do
            local _, result = pcall(getfenv, i);

            if result.getrenv or (result.syn or result.checkcaller) then
                u26 = {};

                return error("Script kiddie");
            end;

            if result and (result.script and not (result.script.Parent and (typeof(result.script.Parent) == "Instance" and typeof(result.script) == "Instance"))) then
                u26 = {};
                LocalPlayer:Remove();

                return error("Script kiddie");
            end;

            local _ = i;
        end;

        if not success3 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if not success then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if not success2 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;

        if success4 then
            u26 = nil;
            LocalPlayer:Remove();
            LocalPlayer:Kick("not so sigma bud");

            return error("Scripting while im a kitty");
        end;
    end);
    u81 = u81 + 1;

    if u81 >= 10 then
        u81 = 0;
    end;

    local u86 = u81;
    u23 = true;
    u13:Clean();
    u12:Clean();
    local Shiftlock = u9.Shiftlock;

    if not Shiftlock then
        u9:SetShiftlock(true);
    end;

    u7.States.AimAssist = true;
    u82.ShootStarted = nil;

    if ReplicatedStorage.GameValues.Timer.Value <= 2 and (ReplicatedStorage.GameValues.Timer.Value > 0 and not ReplicatedStorage.GameTweaks:GetAttribute("DisableBuzzerBeaters")) then
        u6:StopAll();
        u6:PlayChar("Shots", "BuzzBeat", Enum.AnimationPriority.Action2);
        u6:PlayBall("Shots", "BuzzBeat", Enum.AnimationPriority.Action2);
        u7.States.Ability = true;
        u7.States.NoWalk = true;
        task.delay(8, function() -- Line: 850
            -- upvalues: u7 (ref)
            u7.States.Ability = false;
            u7.States.NoWalk = false;
        end);
        u2.BuzzBeat:Fire(workspace:GetServerTimeNow());

        return;
    end;

    u2.Throw:Fire(nil, true);
    local v87 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v88 = {};
    local math_clamp_ret = math.clamp(v87.X / Humanoid.WalkSpeed, 0.01, 1);
    v88.R = math.abs(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(v87.X / Humanoid.WalkSpeed, -1, -0.01);
    v88.L = math.abs(math_clamp_ret2);
    local math_clamp_ret3 = math.clamp(v87.Z / Humanoid.WalkSpeed, -1, -0.01);
    v88.F = math.abs(math_clamp_ret3);
    local math_clamp_ret4 = math.clamp(v87.Z / Humanoid.WalkSpeed, 0.01, 1);
    v88.B = math.abs(math_clamp_ret4);
    local v89 = 0.1;
    local u90 = "F";
    local v91 = nil;

    for i, v in v88 do
        if v89 < v then
            u90 = i;
            v89 = v;
            v91 = true;
        end;
    end;

    if u83 then
        task.spawn(function() -- Line: 879
            -- upvalues: u90 (ref), u83 (copy)
            u90 = u83;
        end);
    end;

    local Value = LocalPlayer.Zone.Value;
    local InZone = u11.CharValues.InZone;

    if InZone then
        if Value ~= "Scary" then
            v91 = false;
        end;
    else
        v91 = InZone;
    end;

    local u92 = u11.CharValues.InZone and Value == "CRIMSON";
    local InZone2 = u11.CharValues.InZone;

    if InZone2 then
        if Value == "Liberty" then
            InZone2 = u11.CharValues.Inside;
        else
            InZone2 = false;
        end;
    end;

    local u93 = u11.CharValues.InZone and Value == "Formless" and true or u11.CharValues.FormlessMode > tick();
    local u94 = false;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    task.spawn(function() -- Line: 893
        -- upvalues: BodyVelocity (copy), HumanoidRootPart (ref)
        BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * math.huge;
        BodyVelocity.Parent = HumanoidRootPart;
    end);
    u13:Add(BodyVelocity);

    if u90 == "F" and not v91 or (u93 or InZone2) then
        BodyVelocity:Destroy();
    end;

    if u7.States.PumpFake then
        BodyVelocity:Destroy();
        u90 = "F";
        u82.ShootStarted = nil;
    end;

    u7.States.PumpFake = false;
    local Vector3_zero = Vector3.zero;
    local u95 = 0;
    local u96 = 0;
    Vector3.new(2, 1, 0);

    if not u93 then
        if InZone2 then
            Humanoid.JumpHeight = 7.2;
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        elseif u90 == "B" then
            Vector3_zero = -HumanoidRootPart.CFrame.LookVector;
            u95 = 30;
            u96 = 0.75;

            if u11.CharValues.InZone and Value == "Flight" then
                u95 = u95 * 1.3;
                u94 = true;
            end;

            Vector3.new(0, 1, 0);
        elseif u90 == "R" then
            Vector3_zero = HumanoidRootPart.CFrame.RightVector;
            Vector3.new(1, 1, 0);
            u96 = 0.65;
            u95 = 33;
        elseif u90 == "L" then
            Vector3_zero = -HumanoidRootPart.CFrame.RightVector;
            Vector3.new(-1, 1, 0);
            u96 = 0.65;
            u95 = 33;
        elseif v91 then
            Vector3_zero = HumanoidRootPart.CFrame.LookVector;
            Vector3.new(0, 1, 0);
            u96 = 0.75;
            u95 = 30;
        else
            u82.ShootStarted = workspace:GetServerTimeNow();
            u13:Add(task.delay(u92 and 0 or 0.25, function() -- Line: 946
                -- upvalues: u7 (ref), Humanoid (ref)
                if u7.States.PumpFake then
                    return;
                end;

                u7.States.Shooting = true;
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end));
        end;
    end;

    if u11.CharValues.InZone and Zones.ZoneIncreasedFadingSpeed[Value] then
        u95 = u95 * (1 + Zones.ZoneIncreasedFadingSpeed[Value]);
    end;

    local Vector2_new_ret = Vector2.new(HumanoidRootPart.CFrame.LookVector.X, HumanoidRootPart.CFrame.LookVector.Z);
    u6:StopAll();
    local u97 = u93 and u6:PlayChar("Passes", `Pass1{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true) or (InZone2 and u6:PlayChar("Shots", `Floater{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true) or u6:PlayChar("Shots", `Shoot{u90}`, Enum.AnimationPriority.Action2, true));
    local u98 = u93 and u6:PlayBall("Passes", `Pass1{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true) or (InZone2 and u6:PlayBall("Shots", `Floater{Essentials:ReturnRorL(u11.CharValues)}`, Enum.AnimationPriority.Action3, true) or u6:PlayBall("Shots", `Shoot{u90}`, Enum.AnimationPriority.Action2, true));
    local u99 = u92 and ShotReduce.TimeSkip or u93 and ShotReduce.Formless or (InZone2 and ShotReduce.Floater or 0);

    local function GetShotReduce() -- Line: 972
        -- upvalues: ShotReduce (ref), LocalPlayer (ref), u11 (ref), u94 (ref), u8 (ref), u92 (copy), u93 (copy), InZone2 (copy)
        local v100 = {};
        v100.Zone = u11.CharValues.InZone and LocalPlayer.Zone.Value;
        v100.Fadeaway = u94;
        v100.Chaos = u11.CharValues.InAwakening and u8.ChaosMode;
        v100.ScaryJump = u11.CharValues.ScaryJump > workspace:GetServerTimeNow();
        v100.TimeSkip = u92;
        v100.Formless = u93;
        v100.Floater = InZone2;
        v100.Moon = u8.InMoon;
        v100.ArmImplant = u8.ArmImplant;
        v100.Stacks = u11.CharValues.ZoneStackable;

        return ShotReduce:Get(LocalPlayer, v100);
    end;

    local function GetAnimSpeed(p101) -- Line: 987
        -- upvalues: u99 (copy), ShotReduce (ref)
        if p101 > 0 then
            return 1 + p101 - u99;
        end;

        return ShotReduce.Windup / (ShotReduce.Windup - (p101 - u99));
    end;

    local v102, v103 = GetShotReduce();

    if u92 then
        u97.TimePosition = 0.2;
        u98.TimePosition = 0.2;
    end;

    local u104 = GetAnimSpeed(v102);
    u97:AdjustSpeed(u104);
    u98:AdjustSpeed(u104);
    local v105 = v102 + v103;
    local u106 = tick();

    if BodyVelocity then
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { u1 };
        RaycastParams_new_ret.CollisionGroup = "Player";

        if u92 then
            local v107 = Vector3_zero * u95 * v105 + Vector3.new(0, u96 * u95 * 0.125, 0);
            local v108 = workspace:Raycast(HumanoidRootPart.Position, v107, RaycastParams_new_ret);

            if v108 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v108.Position - HumanoidRootPart.Position).Unit * (v108.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            else
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v107) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            end;

            u106 = u106 - 0.2;
            u95 = u95 - 0.2;
            u96 = u96 - 0.35000000000000003;
        end;

        u13:Connect(RunService.Heartbeat, function(p109) -- Line: 1032
            -- upvalues: HumanoidRootPart (ref), Vector3_zero (ref), RaycastParams_new_ret (copy), u13 (ref), u95 (ref), u106 (ref), u7 (ref), BodyVelocity (copy), u96 (ref), Vector2_new_ret (ref)
            local v110 = workspace:Raycast(HumanoidRootPart.Position, Vector3_zero * 4, RaycastParams_new_ret);

            if v110 and (v110.Instance.Parent:FindFirstChild("Humanoid") == nil and v110.Instance.CanCollide) then
                u13:Clean();
            end;

            if u95 >= 10 then
                if u106 + 0.125 < tick() and not u7.States.PumpFake then
                    BodyVelocity.Velocity = (Vector3_zero + Vector3.new(0, u96, 0)) * u95;
                    u96 = u96 - p109 * 1.75;
                else
                    BodyVelocity.Velocity = Vector3_zero * u95;
                end;

                u95 = u95 - p109;
            end;

            Vector2_new_ret = Vector2.new(HumanoidRootPart.CFrame.LookVector.X, HumanoidRootPart.CFrame.LookVector.Z);
        end);
    end;

    local u111 = false;
    task.delay(0.115, function() -- Line: 1061
        -- upvalues: u111 (ref), u86 (copy), u81 (ref), u92 (copy), InZone2 (copy), u20 (ref), u21 (ref), u82 (copy), u23 (ref), u13 (ref), u6 (ref), u97 (copy), u98 (copy), u7 (ref)
        if u111 or u86 ~= u81 then
            return;
        end;

        if u92 or InZone2 then
            return;
        end;

        if u20 <= tick() then
            u21 = 0;
        end;

        if u82:GetMaxPumpFakes() == 0 then
            return;
        end;

        if u20 - 10 * (u82:GetMaxPumpFakes() - u21) > tick() then
            return;
        end;

        if u23 then
            return;
        end;

        u82.ShootStarted = nil;
        u13:Clean();
        local v112 = u6:PlayChar("Shots", "PumpFake", Enum.AnimationPriority.Action2, true);
        local v113 = u6:PlayBall("Shots", "PumpFake", Enum.AnimationPriority.Action2, true);
        u6:PlayChar("Movement", "PumpFakeIdle", Enum.AnimationPriority.Action);
        u6:PlayBall("Movement", "PumpFakeIdle", Enum.AnimationPriority.Action);
        v112.TimePosition = u97.TimePosition;
        v113.TimePosition = u98.TimePosition;
        u97:Stop();
        u98:Stop();

        if u23 == false then
            u7.States.PumpFake = true;
            u7.States.Shooting = false;
            u7.States.AimAssist = false;
        end;

        u20 = tick() + 10;
        u21 = u21 + 1;
    end);

    if u25 then
        u25:Disconnect();
    end;

    local os_clock_ret = os.clock();
    local u114 = os_clock_ret;
    local u115 = 0;
    local u116 = v105;
    local u117 = false;
    local u118 = nil;

    local function ReleaseTimer() -- Line: 1114
        -- upvalues: u86 (copy), u81 (ref), u117 (ref), u19 (ref), u7 (ref), u23 (ref), u111 (ref), Vector2_new_ret (ref), HumanoidRootPart (ref), u2 (ref), LocalPlayer (ref), u90 (ref), InZone2 (copy)
        if u86 ~= u81 then
            return;
        end;

        u117 = true;

        if u19 > tick() then
            return;
        end;

        if u7.States.PumpFake then
            return;
        end;

        u23 = false;
        u111 = true;
        Vector2_new_ret = Vector2.new(HumanoidRootPart.CFrame.LookVector.X, HumanoidRootPart.CFrame.LookVector.Z);
        local Throw = u2.Throw;
        local v119 = {};
        local v120;

        if LocalPlayer.Zone.Value == "Flight" then
            v120 = u90 == "B";
        else
            v120 = false;
        end;

        v119.Fadeaway = v120;
        v119.Floater = InZone2;
        Throw:Fire(Vector2_new_ret, nil, v119);
    end;

    local function FinishTimer() -- Line: 1131
        -- upvalues: u86 (copy), u81 (ref), u118 (ref), u13 (ref), u23 (ref), u9 (ref), Shiftlock (copy), u111 (ref), u7 (ref), ReplicatedStorage (ref), u11 (ref)
        if u86 ~= u81 then
            return;
        end;

        u118:Disconnect();
        u13:Clean();
        u23 = false;
        u9:SetShiftlock(Shiftlock);

        if u111 then
            u7.States.PumpFake = false;

            return;
        end;

        local u121 = nil;
        u121 = ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1146
            -- upvalues: u7 (ref), u121 (ref), u11 (ref)
            if u7.States.Shooting then
                u121:Disconnect();

                return;
            end;

            if u11.CharValues.HasBall == false then
                u7.States.PumpFake = false;
                u121:Disconnect();
            end;
        end);
    end;

    local task_delay_ret = task.delay(ShotReduce.Windup - v105, ReleaseTimer);
    local task_delay_ret2 = task.delay(ShotReduce.Windup + ShotReduce.FollowThrough - v105, FinishTimer);
    u118 = RunService.Heartbeat:Connect(function() -- Line: 1158
        -- upvalues: u86 (copy), u81 (ref), u118 (ref), GetShotReduce (copy), GetAnimSpeed (copy), u104 (ref), u97 (copy), u98 (copy), u117 (ref), u116 (ref), ShotReduce (ref), u115 (ref), u114 (ref), os_clock_ret (copy), u92 (copy), task_delay_ret (ref), task_delay_ret2 (ref), ReleaseTimer (copy), FinishTimer (copy)
        if u86 ~= u81 then
            u118:Disconnect();

            return;
        end;

        local v122, v123 = GetShotReduce();
        local v124 = GetAnimSpeed(v122);

        if v124 ~= u104 then
            u104 = v124;
            u97:AdjustSpeed(u104);
            u98:AdjustSpeed(u104);
        end;

        if u117 then
            return;
        end;

        local v125 = v122 + v123;

        if v125 == u116 then
            return;
        end;

        local os_clock_ret2 = os.clock();
        local v126 = ShotReduce.Windup - u116;
        local v127 = ShotReduce.Windup - v125;
        u115 = v126 > 0 and (math.min(u115 + (os_clock_ret2 - u114) / v126, 1) or 1) or 1;

        if u116 < v125 then
            local v128 = os_clock_ret2 - os_clock_ret;
            local v129;

            if v127 > 0 then
                local math_min_ret = math.min(v128 / v127, 1);
                v129 = math.max(u115, math_min_ret) or 1;
            else
                v129 = 1;
            end;

            u115 = v129;

            for _, v in { u97, u98 } do
                if v.IsPlaying then
                    local TimePosition = v.TimePosition;
                    local math_min_ret = math.min((u92 and 0.2 or 0) + v128 * u104, v.Length);
                    v.TimePosition = math.max(TimePosition, math_min_ret);
                end;
            end;
        end;

        u114 = os_clock_ret2;
        u116 = v125;
        local math_max_ret = math.max((1 - u115) * v127, 0);

        if coroutine.status(task_delay_ret) == "suspended" then
            task.cancel(task_delay_ret);
        end;

        if coroutine.status(task_delay_ret2) == "suspended" then
            task.cancel(task_delay_ret2);
        end;

        task_delay_ret = task.delay(math_max_ret, ReleaseTimer);
        task_delay_ret2 = task.delay(math_max_ret + ShotReduce.FollowThrough, FinishTimer);
    end);
    u25 = u118;
end;

function u26.Resets(u130) -- Line: 1215
    -- upvalues: u15 (copy), Knit (copy), UserInputService (copy), LocalPlayer (copy), script_BallStateClient (copy), u11 (ref)
    u15:Clean();
    local Controller = Knit.GetController("OnboardingController");
    task.spawn(function() -- Line: 1220
        -- upvalues: UserInputService (ref), LocalPlayer (ref), u15 (ref), u130 (copy)
        if UserInputService.TouchEnabled then
            u15:Connect(LocalPlayer.PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").MouseButton1Click, function() -- Line: 1225
                -- upvalues: u130 (ref)
                u130:Dunk();
            end);
        end;
    end);
    u15:Add(script_BallStateClient.onPlayerPossessingBallChangedConnect(u130, function(p131) -- Line: 1254
        -- upvalues: LocalPlayer (ref), Controller (copy), u11 (ref)
        if p131 == LocalPlayer then
            Controller:Progress();
        end;

        u11.CharValues.HasBall = p131 == LocalPlayer;
    end, false));
end;

function u26.Control(u132) -- Line: 1263
    -- upvalues: RunService (copy), u11 (ref), u8 (ref), workspace_BARRIER (copy), ReplicatedStorage (copy), u7 (ref), Basketball (copy), script_BallStateClient (copy)
    local u133 = tick();
    local u134 = 0.999;
    RunService.Heartbeat:Connect(function(p135) -- Line: 1267
        -- upvalues: u11 (ref), u8 (ref), workspace_BARRIER (ref), ReplicatedStorage (ref), u7 (ref), u132 (copy), Basketball (ref), u133 (ref), u134 (ref), script_BallStateClient (ref)
        if not u11.CharValues.HasBall then
            u8.InPostForm = false;
        end;

        if u11.CharValues.HasBall and not (workspace_BARRIER.CanCollide or (ReplicatedStorage.GameValues.Timer.Value > 2 or (ReplicatedStorage.GameValues.Buzz.Value or (ReplicatedStorage.GameValues.Timer.Value <= 0 or (u7.States.Shooting or ReplicatedStorage.GameTweaks:GetAttribute("DisableBuzzerBeaters")))))) then
            u132:Shoot();
        end;

        local Value = Basketball.Value;
        local ServerBallPosition = u132:GetServerBallPosition();

        if Value == nil or Value.Parent == nil then
            return;
        end;

        if u133 > tick() then
            return;
        end;

        if u132:GetPlayerPossessingBall() then
            u133 = tick() + 0.5;
            u134 = 0.999;

            return;
        end;

        if not script_BallStateClient.localPlayerIsBallNetworkOwner(u132) then
            u133 = tick() + 0.5;
            u134 = 0.999;

            return;
        end;

        if ServerBallPosition.Y > 15 then
            u133 = tick() + 0.5;
            u134 = 0.999;

            return;
        end;

        u134 = u134 - p135 * 0.01;
        local AssemblyLinearVelocity = Value.AssemblyLinearVelocity;
        Value.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X * u134, AssemblyLinearVelocity.Y, AssemblyLinearVelocity.Z * u134);
    end);
end;

function u26.Signals(u136) -- Line: 1302
    -- upvalues: u2 (ref), LocalPlayer (copy), u7 (ref), Basketball (copy), script_BallStateClient (copy), HumanoidRootPart (ref), u11 (ref), Zones (copy), u8 (ref), u24 (ref), RunService (copy), u1 (ref), u19 (ref), u18 (ref), u14 (copy), u9 (ref), CameraShaker (copy), TweenService (copy), u22 (ref), SfxManager (copy), u6 (ref), u10 (ref), ReplicatedStorage (copy)
    u2.AutoDribble:Connect(function() -- Line: 1303
        -- upvalues: u136 (copy)
        u136.DribbleDB = tick() - 0.1;
        u136:Dribble();
    end);
    u2.Throw:Connect(function(p137) -- Line: 1308
        -- upvalues: LocalPlayer (ref), u7 (ref), Basketball (ref), script_BallStateClient (ref), u136 (copy), HumanoidRootPart (ref), u11 (ref), Zones (ref), u8 (ref), u24 (ref), RunService (ref), u1 (ref), u19 (ref), u2 (ref)
        if LocalPlayer:GetAttribute("DesyncPlr") then
            return;
        end;

        u7.States.Dunking = false;
        u7.States.Shooting = false;
        u7.States.AimAssist = false;

        if not p137 then
            return;
        end;

        local Value = Basketball.Value;
        Value.CFrame = script_BallStateClient.getLastCharacterToPossessBall(u136).PlrBall.Anims.BALL.CFrame;
        local v138 = 0.75;
        local v139 = p137 - Value.Position;
        local v140;

        if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude <= 30 then
            v140 = v139.Magnitude * 0.0455;
            v138 = 1.35;
        elseif u11.CharValues.InZone and Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] then
            v140 = v139.Magnitude * 0.04;
            v138 = 0.5;
        else
            v140 = v139.Magnitude * 0.045;
        end;

        if u11.CharValues.InAwakening and u8.ChaosMode then
            v140 = v139.Magnitude * 0.04;
            v138 = 0.5;
        end;

        local math_log_ret = math.log(v138 + v140);
        Value.AssemblyLinearVelocity = v139 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);

        if u24 then
            u24:Disconnect();
        end;

        local u141 = nil;
        u141 = RunService.Heartbeat:Connect(function(p142) -- Line: 1382
            -- upvalues: Value (ref), Basketball (ref), u141 (ref), u136 (ref), u1 (ref), u19 (ref), u2 (ref)
            Value = Basketball.Value;

            if Value == nil then
                u141:Disconnect();

                return;
            end;

            if u136:GetLastCharacterToPossessBall() ~= u1 then
                u141:Disconnect();

                return;
            end;

            if u19 > tick() then
                u141:Disconnect();

                return;
            end;

            local v143 = Value:FindFirstChildWhichIsA("BodyVelocity") or (Value:FindFirstAncestorWhichIsA("LinearVelocity") or Value:FindFirstAncestorWhichIsA("AlignPosition"));

            if not v143 then
                return;
            end;

            u141:Disconnect();
            u2.Remove:Fire();
            v143:Destroy();
        end);
        u24 = u141;
    end);
    u2.Dunk:Connect(function(p144) -- Line: 1402
        -- upvalues: LocalPlayer (ref), script_BallStateClient (ref), u136 (copy), u18 (ref), u14 (ref), u7 (ref), u9 (ref), CameraShaker (ref), TweenService (ref), Basketball (ref), u22 (ref), SfxManager (ref), u6 (ref)
        if LocalPlayer:GetAttribute("DesyncPlr") then
            return;
        end;

        local LastCharacterToPossessBall = script_BallStateClient.getLastCharacterToPossessBall(u136);

        if LastCharacterToPossessBall == nil then
            warn("Attempt to dunk when there is no LastCharacterToPossessBall; player:", LocalPlayer);

            return;
        end;

        if p144 == "Force" then
            u136:Dunk(nil, nil, true);

            return;
        end;

        u18 = false;
        u14:Clean();
        u7.States.Dunking = false;
        u9.CamShake:Shake(CameraShaker.Presets.Dunk);
        u7.States.Ability = true;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = 25
        }):Play();
        task.delay(0.3, function() -- Line: 1426
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy), u7 (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
            task.wait(1);
            u7.States.Ability = false;
        end);
        local Value = Basketball.Value;
        time();
        Value.CFrame = LastCharacterToPossessBall.PlrBall.Anims.BALL.CFrame;

        if p144 == "Layup" then
            local v145 = u22.Position - Value.Position;
            local math_log_ret = math.log(1.2 + v145.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v145 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
            SfxManager:playSound({
                Sound = "Layup",
                Parent = LastCharacterToPossessBall.HumanoidRootPart
            });
        end;

        for _, v in u6.Anims.Dunks do
            v:AdjustSpeed(1);
        end;

        for _, v in u6.Anims.Ace do
            v:AdjustSpeed(1);
        end;

        for _, v in u6.Ball.Dunks do
            v:AdjustSpeed(1);
        end;
    end);
    u2.Pass:Connect(function(p146, p147) -- Line: 1480
        -- upvalues: u10 (ref)
        u10:Pass(p146, p147);
    end);
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1484
        -- upvalues: LocalPlayer (ref), u11 (ref), u7 (ref), u136 (copy), TweenService (ref)
        local BG = LocalPlayer.PlayerGui.DribbleBar.BG;

        if u11.CharValues.HasBall ~= false then
            if u136.DribbleDB > tick() then
                TweenService:Create(BG, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    GroupTransparency = 0
                }):Play();
            end;

            return;
        end;

        if u7.States.Stunned then
            if u136.DribbleTweens then
                for _, v in u136.DribbleTweens do
                    v:Cancel();
                end;

                table.clear(u136.DribbleTweens);
            else
                u136.DribbleTweens = {};
            end;

            u136.Dribbles = 0;
            u136.DribbleDB = tick();
            local MaxDribbles = u136:GetMaxDribbles();
            local v148 = TweenService:Create(BG.Bar.UIGradient, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0, u136.Dribbles / MaxDribbles)
            });
            v148:Play();
            BG.Load.UIGradient.Offset = Vector2.new(0, u136.Dribbles / MaxDribbles);
            TweenService:Create(BG.Load.UIGradient, TweenInfo.new(4), {
                Offset = Vector2.new(0, 0)
            }):Play();
            table.insert(u136.DribbleTweens, v148);
        end;

        TweenService:Create(BG, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 1
        }):Play();
    end);
end;

function u26.CanPass(p149) -- Line: 1522
    -- upvalues: u19 (ref), u11 (ref), u7 (ref)
    if u19 > tick() then
        return false;
    end;

    if u11.CharValues.Stunned then
        return false;
    end;

    if u11.CharValues.HasBall == false then
        return false;
    end;

    if u7.States.Dunking then
        return false;
    end;

    if u7.States.Shooting and not p149.ShootStarted then
        return false;
    end;

    if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        return false;
    end;

    return not u7.States.Ability;
end;

function u26.Input(u150) -- Line: 1534
    -- upvalues: Knit (copy), LocalPlayer (copy), u23 (ref), u10 (ref), u13 (copy), u12 (copy), u7 (ref), u19 (ref), u2 (ref), UserInputService (copy), u11 (ref), Players (copy), Essentials (copy), ReplicatedStorage (copy)
    local Controller = Knit.GetController("KeybindsController");

    for _, descendant in LocalPlayer.PlayerGui.Mobile:GetDescendants() do
        if descendant:IsA("ImageButton") ~= false then
            descendant.MouseButton1Down:Connect(function() -- Line: 1541
                -- upvalues: descendant (copy), u150 (copy)
                if descendant.Name == "Throw" then
                    u150:Shoot();
                end;
            end);
            descendant.MouseButton1Click:Connect(function() -- Line: 1547
                -- upvalues: descendant (copy), u150 (copy), u23 (ref), u10 (ref), u13 (ref), u12 (ref), u7 (ref), u19 (ref), u2 (ref)
                if descendant.Name == "Dribble" then
                    u150:Dribble();

                    return;
                end;

                if descendant.Name ~= "Throw" then
                    if descendant.Name == "Pass" and u150:CanPass() then
                        local LookingAt = u10.LookingAt;

                        if LookingAt == nil then
                            return;
                        end;

                        u13:Clean();
                        u12:Clean();
                        u7.States.Shooting = false;
                        u7.States.AimAssist = false;
                        u19 = tick() + 1;
                        u10:Anim();
                        task.delay(0.15, function() -- Line: 1570
                            -- upvalues: u2 (ref), LookingAt (copy)
                            u2.Pass:Fire(LookingAt);
                        end);
                    end;

                    return;
                end;

                if workspace.BARRIER.CanCollide then
                    return;
                end;

                u150:Shoot();
                u23 = false;
            end);
            descendant.MouseButton1Up:Connect(function() -- Line: 1577
                -- upvalues: descendant (copy), u23 (ref)
                if descendant.Name == "Throw" then
                    u23 = false;
                end;
            end);
        end;
    end;

    UserInputService.InputBegan:Connect(function(p151, p152) -- Line: 1584
        -- upvalues: LocalPlayer (ref), Controller (copy), u150 (copy), u11 (ref), u10 (ref), u19 (ref), u2 (ref), Players (ref), Essentials (ref), ReplicatedStorage (ref)
        if p152 then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if Controller.IsInputValid(p151, "Dribble") then
            u150:Dribble();
        end;

        if Controller.IsInputValid(p151, "Shoot") then
            if workspace.BARRIER.CanCollide then
                return;
            end;

            u150:Shoot();
        end;

        if Controller.IsInputValid(p151, "Dunk") then
            u150:Dunk();
        end;

        if u150:CanPass() then
            if u11.Player.Customization.Settings.KeybindPassing and Controller.GetPlatform() == "Keyboard" then
                for i = 1, 4 do
                    local TeammateFromKeybind = u10:GetTeammateFromKeybind(i);

                    if not ((LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and (TeammateFromKeybind and (TeammateFromKeybind.Team ~= LocalPlayer.Team and not workspace.BARRIER.CanCollide)) or (TeammateFromKeybind == nil or ((LocalPlayer.Character:GetPivot().Position - TeammateFromKeybind.Character:GetPivot().Position).Magnitude > 180 or not Controller.IsInputValid(p151, (`Pass Teammate {i}`))))) then
                        u19 = tick() + 1;
                        u10:Anim();
                        u2.Pass:Fire(TeammateFromKeybind.Character);
                        break;
                    end;

                    local _ = i;
                end;
            else
                local v153 = Players:GetPlayerFromCharacter(u10.LookingAt) or Essentials:GetBotFromRig(u10.LookingAt);

                if v153 then
                    v153 = v153.Team;
                end;

                if u10.LookingAt and ((LocalPlayer.Style.Value ~= "Copycat" and LocalPlayer.Style.Value ~= "Thief" or workspace.BARRIER.CanCollide or v153 == LocalPlayer.Team) and Controller.IsInputValid(p151, "Pass")) then
                    u19 = tick() + 1;
                    u10:Anim();
                    u2.Pass:Fire(u10.LookingAt);
                end;
            end;
        end;

        if p151.KeyCode == Enum.KeyCode.Y then
            if LocalPlayer:GetRankInGroup(34852864) < 235 and LocalPlayer:GetRankInGroup(34852864) ~= 200 then
                return;
            end;

            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if u11.CharValues.HasBall then
                return;
            end;

            ReplicatedStorage.Remotes.GetBall:FireServer();

            return;
        end;

        if p151.KeyCode ~= Enum.KeyCode.H then
            if p151.UserInputType == Enum.UserInputType.MouseButton3 then
                if LocalPlayer:GetRankInGroup(34852864) < 235 and LocalPlayer:GetRankInGroup(34852864) ~= 200 then
                    return;
                end;

                if LocalPlayer.Team == game.Teams.Visitor then
                    return;
                end;

                ReplicatedStorage.Remotes.SuperBlock:FireServer(true);
            end;

            return;
        end;

        if LocalPlayer:GetRankInGroup(34852864) < 235 then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        ReplicatedStorage.Remotes.BallTest:FireServer();
    end);
    UserInputService.InputEnded:Connect(function(p154, p155) -- Line: 1654
        -- upvalues: Controller (copy), u23 (ref), LocalPlayer (ref), ReplicatedStorage (ref)
        if p155 then
            return;
        end;

        if Controller.IsInputValid(p154, "Shoot") then
            u23 = false;
        end;

        if p154.UserInputType == Enum.UserInputType.MouseButton3 then
            if LocalPlayer:GetRankInGroup(34852864) < 235 and LocalPlayer:GetRankInGroup(34852864) ~= 200 then
                return;
            end;

            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            ReplicatedStorage.Remotes.SuperBlock:FireServer(nil);
        end;
    end);
end;

function u26.GetServerBallPosition(p156) -- Line: 1670
    -- upvalues: Basketball (copy)
    local Value = Basketball.Value;

    if Value == nil or Value.Parent == nil then
        return Vector3.new();
    end;

    local CharacterPossessingBall = p156:GetCharacterPossessingBall();

    if CharacterPossessingBall == nil then
        return Value.Position;
    end;

    local v157 = CharacterPossessingBall:FindFirstChild("HumanoidRootPart") or CharacterPossessingBall:FindFirstChild("Torso");

    if v157 == nil then
        return CharacterPossessingBall:GetPivot().Position;
    end;

    return v157.Position;
end;

function u26.GetVectorOffsetBetweenLocalPlayerAndBall(p158, p159) -- Line: 1696
    -- upvalues: HumanoidRootPart (ref)
    if HumanoidRootPart == nil then
        return Vector3.new(1, 0, 0);
    end;

    local ServerBallPosition = p158:GetServerBallPosition();

    if p159 then
        return ServerBallPosition - HumanoidRootPart.Position;
    end;

    return Vector3.new(ServerBallPosition.X - HumanoidRootPart.Position.X, 0, ServerBallPosition.Z - HumanoidRootPart.Position.Z);
end;

function u26.LocalPlayerIsWithinDistanceOfBall(p160, p161, p162) -- Line: 1710
    -- upvalues: HumanoidRootPart (ref)
    if HumanoidRootPart == nil then
        return false;
    end;

    local VectorOffsetBetweenLocalPlayerAndBall = p160:GetVectorOffsetBetweenLocalPlayerAndBall(p162);

    return VectorOffsetBetweenLocalPlayerAndBall:Dot(VectorOffsetBetweenLocalPlayerAndBall) <= p161 ^ 2;
end;

function u26.GetEnemyWithBallWithinDistance(p163, p164) -- Line: 1720
    -- upvalues: script_BallStateClient (copy), RunService (copy), LocalPlayer (copy), u26 (ref), HumanoidRootPart (ref), getDefenseRigMockPlayerInstance (copy)
    if typeof(p164) ~= "number" then
        error((`{p164} is not a number!`));
    end;

    local LastPlayerToPossessBall = script_BallStateClient.getLastPlayerToPossessBall(p163);

    if not (RunService:IsStudio() or LastPlayerToPossessBall ~= nil and LastPlayerToPossessBall.Team ~= LocalPlayer.Team) then
        return;
    end;

    local v165;

    if RunService:IsStudio() then
        v165 = workspace:FindFirstChild("DefenseRig");
    else
        v165 = u26:GetLastCharacterToPossessBall();
    end;

    if v165 == nil then
        return;
    end;

    local HumanoidRootPart2 = v165:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart2 == nil then
        return;
    end;

    local v166 = HumanoidRootPart2.Position - HumanoidRootPart.Position;
    local v167 = v166:Dot(v166);

    if p164 ^ 2 >= v167 then
        if LastPlayerToPossessBall == nil and RunService:IsStudio() then
            LastPlayerToPossessBall = getDefenseRigMockPlayerInstance(v165);
        end;

        return LastPlayerToPossessBall, v165, HumanoidRootPart2, v167;
    end;
end;

function u26.GetEnemyWithinDistance(p168, p169, p170) -- Line: 1763
    -- upvalues: LocalPlayer (copy), Home (copy), Away (copy), RunService (copy), HumanoidRootPart (ref), getDefenseRigMockPlayerInstance (copy)
    if typeof(p169) ~= "number" then
        error((`{p169} is not a number!`));
    end;

    if p170 then
        return p168:GetEnemyWithBallWithinDistance(p169);
    end;

    local v171;

    if LocalPlayer.Team == Home then
        v171 = Away;
    else
        v171 = Home;
    end;

    local v172 = p169 ^ 2;
    local v173 = nil;
    local v174 = nil;
    local v175 = nil;
    local v176, v177, v178;

    if RunService:IsStudio() and workspace:FindFirstChild("DefenseRig") then
        v176 = workspace.DefenseRig;
        v177 = v176.HumanoidRootPart;
        local v179 = HumanoidRootPart.Position - v177.Position;
        v178 = v179:Dot(v179);

        if v178 <= v172 then
            v173 = getDefenseRigMockPlayerInstance(v176);
        else
            v177 = v175;
            v176 = v174;
            v178 = v172;
        end;
    else
        v177 = v175;
        v176 = v174;
        v178 = v172;
    end;

    for _, v in v171:GetPlayers() do
        local Character = v.Character;

        if Character ~= nil then
            local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 ~= nil then
                local v180 = HumanoidRootPart.Position - HumanoidRootPart2.Position;
                local v181 = v180:Dot(v180);

                if v178 >= v181 then
                    v177 = HumanoidRootPart2;
                    v176 = Character;
                    v173 = v;
                    v178 = v181;
                end;
            end;
        end;
    end;

    return v173, v176, v177, v178;
end;

function u26.KnitStart(u182) -- Line: 1823
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), script_BallStateClient (copy), script_BallPhysicsClient (copy), LocalPlayer (copy), u22 (ref), u1 (ref), Humanoid (ref), HumanoidRootPart (ref), TweenService (copy)
    u2 = Knit.GetService("BallService");
    u3 = Knit.GetService("CustomServerService");
    u4 = Knit.GetController("FeatureFlagController");
    u5 = Knit.GetController("AwakeningController");
    u6 = Knit.GetController("AnimationController");
    u7 = Knit.GetController("MovementController");
    u8 = Knit.GetController("AbilityController");
    u9 = Knit.GetController("CameraController");
    u10 = Knit.GetController("PassController");
    u11 = Knit.GetController("Network");
    script_BallStateClient.initialize(u182);
    script_BallPhysicsClient.initialize(u182);
    task.spawn(function() -- Line: 1839
    end);

    if LocalPlayer.Team ~= game.Teams.Visitor then
        u22 = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 1871
        -- upvalues: LocalPlayer (ref), u22 (ref)
        if LocalPlayer.Team == game.Teams.Visitor or LocalPlayer.Team == nil then
            return;
        end;

        u22 = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    end);
    u182:Input();
    u182:Signals();
    u182:Control();
    u182:Resets();
    LocalPlayer.CharacterAdded:Connect(function(p183) -- Line: 1881
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), u182 (copy)
        u1 = p183;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        u182:Resets();
    end);
    u2.Effect:Connect(function(p184, p185) -- Line: 1907
        -- upvalues: u7 (ref), TweenService (ref)
        if p184 == "StunEffect" then
            u7.States.Ability = true;
            local workspace_CurrentCamera = workspace.CurrentCamera;
            workspace_CurrentCamera.FieldOfView = 40;
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
            task.delay(1, function() -- Line: 1915
                -- upvalues: u7 (ref)
                u7.States.Ability = false;
            end);
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "BallServiceColorCorrection";
            ColorCorrectionEffect.Parent = game.Lighting;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 80, 80);
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Parent = game.Lighting;
            BlurEffect.Size = 10;
            TweenService:Create(BlurEffect, TweenInfo.new(1), {
                Size = 0
            }):Play();
            task.delay(1.5, function() -- Line: 1930
                -- upvalues: ColorCorrectionEffect (copy), BlurEffect (copy)
                ColorCorrectionEffect:Destroy();
                BlurEffect:Destroy();
            end);
        end;
    end);
end;

function u26.KnitInit(p186) -- Line: 1940
    p186.Shiftlock = false;
end;

u26.OnPlayerPossessingBallChangedConnect = script_BallStateClient.onPlayerPossessingBallChangedConnect;
u26.LocalPlayerIsBallNetworkOwner = script_BallStateClient.localPlayerIsBallNetworkOwner;
u26.LocalPlayerPossessesBall = script_BallStateClient.localPlayerPossessesBall;
u26.CharacterPossessesBall = script_BallStateClient.characterPossessesBall;
u26.PlayerPossessesBall = script_BallStateClient.playerPossessesBall;
u26.BallPlayerZoneIsActive = script_BallStateClient.ballPlayerZoneIsActive;
u26.BallTeamIFrameIsActive = script_BallStateClient.ballTeamIFrameIsActive;
u26.BallIFrameIsActive = script_BallStateClient.ballIFrameIsActive;
u26.GetLastCharacterToPossessBall = script_BallStateClient.getLastCharacterToPossessBall;
u26.GetLastPlayerToPossessBall = script_BallStateClient.getLastPlayerToPossessBall;
u26.GetCharacterPossessingBall = script_BallStateClient.getCharacterPossessingBall;
u26.GetPlayerPossessingBall = script_BallStateClient.getPlayerPossessingBall;
u26.GetPreviousBallPlayer = script_BallStateClient.getPreviousBallPlayer;
u26.GetBallNetworkOwner = script_BallStateClient.getBallNetworkOwner;
u26.TeleportServerBallToPlayerAnimationBall = script_BallPhysicsClient.teleportServerBallToPlayerAnimationBall;
u26.BallSpeedIsLessThan = script_BallPhysicsClient.ballSpeedIsLessThan;

return u26;