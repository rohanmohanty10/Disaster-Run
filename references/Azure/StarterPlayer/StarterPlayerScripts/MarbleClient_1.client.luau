 
 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local LocalPlayer = Players.LocalPlayer;
local Marble = ReplicatedStorage:WaitForChild("Marble");
local Config = require(Marble:WaitForChild("Config"));
local ClashMath = require(Marble:WaitForChild("ClashMath"));
local Remotes = Marble:WaitForChild("Remotes");
local Toggle = Remotes:WaitForChild("Toggle");
local Clash = Remotes:WaitForChild("Clash");
local Impact = Remotes:WaitForChild("Impact");
local Knock = Remotes:WaitForChild("Knock");
local Fx = Remotes:WaitForChild("Fx");
local Dash = Remotes:WaitForChild("Dash");
local Contact = Remotes:WaitForChild("Contact");
local workspace2 = ReplicatedStorage:WaitForChild("workspace", 10);
local packets = require(ReplicatedStorage:WaitForChild("packets"));
local MarbleFx = require(script:WaitForChild("MarbleFx"));
local IsInZone = require(ReplicatedStorage:WaitForChild("util"):WaitForChild("Util")).IsInZone;
local u1 = nil;
task.spawn(function() -- Line: 35
    -- upvalues: LocalPlayer (copy), u1 (ref)
    local success, result = pcall(function() -- Line: 36
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 10)):GetControls();
    end);

    if success then
        u1 = result;
    end;
end);
local Color3_fromRGB_ret = Color3.fromRGB(150, 225, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 120, 230);
local ColorSequence_new_ret = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret2);
local ColorSequence_new_ret2 = ColorSequence.new(Config.DashColor);

local function flat(p2: vector) -- Line: 49
    return Vector3.new(p2.X, 0, p2.Z);
end;

local function isFinite(p3: vector) -- Line: 53
    local v4;

    if p3.X == p3.X and (p3.Y == p3.Y and (p3.Z == p3.Z and (math.abs(p3.X) < 10000000 and math.abs(p3.Y) < 10000000))) then
        v4 = math.abs(p3.Z) < 10000000;
    else
        v4 = false;
    end;

    return v4;
end;

local function targetSpeed(p5: number) -- Line: 58
    -- upvalues: Config (copy)
    return Config.BaseSpeed + (Config.MaxSpeed - Config.BaseSpeed) * (1 - (1 - p5) ^ 2);
end;

local function chargeForSpeed(p6: number) -- Line: 63
    -- upvalues: Config (copy)
    local v7 = 1 - math.clamp((p6 - Config.BaseSpeed) / (Config.MaxSpeed - Config.BaseSpeed), 0, 1);

    return 1 - math.sqrt(v7);
end;

local function rollingSpin(p8: vector, p9: number, p10: vector?) -- Line: 69
    return (p10 or Vector3.new(0, 1, 0)):Cross(p8) / p9;
end;

local function getMoveDirection(p11: userdata) -- Line: 96
    -- upvalues: u1 (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (u1 and workspace_CurrentCamera) then
        local MoveDirection = p11.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z);
    end;

    local MoveVector = u1:GetMoveVector();

    if MoveVector.Magnitude <= 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local RightVector = workspace_CurrentCamera.CFrame.RightVector;
    local Vector3_new_ret = Vector3.new(RightVector.X, 0, RightVector.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local Unit = Vector3_new_ret.Unit;
    local v12 = (Vector3.new(0, 1, 0)):Cross(Unit);
    local v13 = Unit * MoveVector.X - v12 * MoveVector.Z;

    if v13.Magnitude > 1 then
        return v13.Unit;
    end;

    return v13;
end;

local u14 = {};

local function untrack(p15: userdata) -- Line: 132
    -- upvalues: u14 (copy), Players (copy)
    local v16 = u14[p15];

    if not v16 then
        return;
    end;

    u14[p15] = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and workspace_CurrentCamera.CameraSubject == p15 then
        local PlayerByUserId = Players:GetPlayerByUserId(p15:GetAttribute("OwnerUserId") or 0);
        local v17 = PlayerByUserId and PlayerByUserId.Character and PlayerByUserId.Character:FindFirstChildOfClass("Humanoid");

        if v17 then
            workspace_CurrentCamera.CameraSubject = v17;
        end;
    end;

    v16.trail:Destroy();
    v16.top:Destroy();
    v16.bottom:Destroy();
    v16.rollSound:Destroy();

    if v16.stuckBall then
        v16.stuckBall:Destroy();
    end;
end;

local function makeStuckBall() -- Line: 157
    -- upvalues: Config (copy)
    local v18 = Config.BallTemplate and Config.BallTemplate();
    local v19;

    if v18 then
        v19 = v18:Clone();

        for _, descendant in v19:GetDescendants() do
            if descendant:IsA("JointInstance") or (descendant:IsA("Constraint") or (descendant:IsA("Sound") or descendant:IsA("LuaSourceContainer"))) then
                descendant:Destroy();
            end;
        end;
    else
        v19 = Instance.new("Part");
        v19.Shape = Enum.PartType.Ball;
        v19.Size = Vector3.new(1.95, 1.95, 1.95);
        v19.Color = Color3.new(1, 1, 1);
    end;

    v19.Name = "MarbleStuckBall";
    v19.Anchored = true;
    v19.CanCollide = false;
    v19.CanQuery = false;
    v19.CanTouch = false;
    v19.CastShadow = false;
    v19.Parent = workspace.Terrain;

    return v19;
end;

RunService:BindToRenderStep("MarblePresentation", Enum.RenderPriority.Camera.Value + 1, function(p20: number) -- Line: 230, Name: updateMarbles
    -- upvalues: Players (copy), u14 (copy), untrack (copy), Config (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), makeStuckBall (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v21;

    if workspace_CurrentCamera then
        v21 = workspace_CurrentCamera.CameraSubject;
    else
        v21 = workspace_CurrentCamera;
    end;

    local v22;

    if v21 and (v21:IsA("Humanoid") and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom) then
        v22 = Players:GetPlayerFromCharacter(v21.Parent);
    else
        v22 = nil;
    end;

    for i, v in u14 do
        if i.Parent then
            if v22 and v22.UserId == i:GetAttribute("OwnerUserId") then
                workspace_CurrentCamera.CameraSubject = i;
            end;

            local v23 = i.Size.X / 2;
            local AssemblyLinearVelocity = i.AssemblyLinearVelocity;
            local Magnitude = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude;
            local math_clamp_ret = math.clamp(Magnitude / Config.MaxSpeed, 0, 1);
            v.top.WorldPosition = i.Position + Vector3.new(0, v23 * 0.45, 0);
            v.bottom.WorldPosition = i.Position - Vector3.new(0, v23 * 0.45, 0);
            v.trail.Enabled = Config.TrailMinSpeed <= Magnitude;
            v.trail.Color = ColorSequence.new(Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, math_clamp_ret));
            local Attribute = i:GetAttribute("StuckBall");

            if typeof(Attribute) == "Vector3" then
                local stuckBall = v.stuckBall;

                if not (stuckBall and stuckBall.Parent) then
                    stuckBall = makeStuckBall();
                    v.stuckBall = stuckBall;
                end;

                stuckBall.CFrame = i.CFrame * CFrame.new(Attribute);
            elseif v.stuckBall then
                v.stuckBall:Destroy();
                v.stuckBall = nil;
            end;

            local v24 = workspace:Raycast(i.Position, Vector3.new(0, -(v23 + 0.6), 0), v.groundParams) == nil and 0 or math.clamp(Magnitude / 60, 0, 1) * 0.6;
            local rollSound = v.rollSound;
            rollSound.Volume = rollSound.Volume + (v24 - v.rollSound.Volume) * math.min(1, p20 * 8);
            v.rollSound.PlaybackSpeed = math_clamp_ret * 0.9 + 0.7;
        else
            untrack(i);
        end;
    end;
end);

local function track(p25: userdata) -- Line: 183
    -- upvalues: u14 (copy), Config (copy)
    if not p25:IsA("BasePart") or u14[p25] then
        return;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p25 };
    RaycastParams_new_ret.CollisionGroup = Config.MarbleGroup;
    RaycastParams_new_ret.RespectCanCollide = true;
    local Sound = Instance.new("Sound");
    Sound.Name = "MarbleRoll";
    Sound.SoundId = Config.Sounds.Roll;
    Sound.Looped = true;
    Sound.Volume = 0;
    Sound.RollOffMinDistance = 8;
    Sound.RollOffMaxDistance = 150;
    Sound.Parent = p25;
    Sound:Play();
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "MarbleTrailTop";
    Attachment.Parent = workspace.Terrain;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "MarbleTrailBottom";
    Attachment2.Parent = workspace.Terrain;
    local Trail = Instance.new("Trail");
    Trail.Name = "MarbleTrail";
    Trail.Attachment0 = Attachment;
    Trail.Attachment1 = Attachment2;
    Trail.Lifetime = 0.2;
    Trail.LightEmission = 0.6;
    Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.65), NumberSequenceKeypoint.new(1, 1) });
    Trail.Enabled = false;
    Trail.Parent = workspace.Terrain;
    u14[p25] = {
        trail = Trail,
        top = Attachment,
        bottom = Attachment2,
        rollSound = Sound,
        groundParams = RaycastParams_new_ret,
        history = {}
    };
end;

local u26 = nil;

local function pushCharacter(p27: userdata, p28: vector, p29: number, p30: number) -- Line: 75
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "MarblePush";
    Attachment.Parent = p27;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "MarblePush";
    LinearVelocity.Attachment0 = Attachment;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    LinearVelocity.PlaneVelocity = Vector2.new(p28.X, p28.Z);
    LinearVelocity.MaxForce = p27.AssemblyMass * p30;
    LinearVelocity.Parent = p27;
    task.delay(p29, function() -- Line: 89
        -- upvalues: LinearVelocity (copy), Attachment (copy)
        LinearVelocity:Destroy();
        Attachment:Destroy();
    end);
end;

for _, v in CollectionService:GetTagged(Config.Tag) do
    track(v);
end;

CollectionService:GetInstanceAddedSignal(Config.Tag):Connect(track);
CollectionService:GetInstanceRemovedSignal(Config.Tag):Connect(function(p31) -- Line: 282
    -- upvalues: untrack (copy)
    if p31:IsA("BasePart") then
        untrack(p31);
    end;
end);

local function createSpeedTag(p32: userdata) -- Line: 292
    -- upvalues: ColorSequence_new_ret (copy), LocalPlayer (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "MarbleSpeedTag";
    BillboardGui.Adornee = p32;
    BillboardGui.Size = UDim2.fromOffset(56, 24);
    BillboardGui.StudsOffset = Vector3.new(0, p32.Size.Y / 2 + 1.4, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.ResetOnSpawn = false;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.new(1, 0, 0, 18);
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextSize = 16;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextStrokeTransparency = 0.7;
    TextLabel.Text = "0";
    TextLabel.Parent = BillboardGui;
    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.fromScale(0.5, 1);
    Frame.Size = UDim2.new(1, 0, 0, 3);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.BackgroundTransparency = 0.75;
    Frame.BorderSizePixel = 0;
    Frame.Parent = BillboardGui;
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0);
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromScale(0, 1);
    Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    Instance.new("UICorner", Frame2).CornerRadius = UDim.new(1, 0);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence_new_ret;
    UIGradient.Parent = Frame2;
    BillboardGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

    return BillboardGui, TextLabel, Frame2, UIGradient;
end;

local u33 = {};

local function openPassParts(u34) -- Line: 345
    -- upvalues: Config (copy), u33 (copy)
    if not (Config.PassParts and Config.PassGroup) then
        return;
    end;

    local function pass(u35: userdata) -- Line: 349
        -- upvalues: u34 (copy), u33 (ref), Config (ref)
        if not u35:IsA("BasePart") then
            return;
        end;

        if u34.passSaved[u35] == nil then
            u34.passSaved[u35] = u33[u35] or u35.CollisionGroup;
            u33[u35] = nil;
        end;

        pcall(function() -- Line: 357
            -- upvalues: u35 (copy), Config (ref)
            u35.CollisionGroup = Config.PassGroup;
        end);
        local conns = u34.conns;
        local PropertyChangedSignal = u35:GetPropertyChangedSignal("CollisionGroup");
        table.insert(conns, PropertyChangedSignal:Connect(function() -- Line: 360
            -- upvalues: u35 (copy), Config (ref), u34 (ref)
            if u35.CollisionGroup ~= Config.PassGroup then
                u34.passSaved[u35] = u35.CollisionGroup;
                u35.CollisionGroup = Config.PassGroup;
            end;
        end));
    end;

    for _, v in Config.PassParts() do
        pass(v);

        for _, descendant in v:GetDescendants() do
            pass(descendant);
        end;

        table.insert(u34.conns, v.DescendantAdded:Connect(pass));
    end;
end;

local function setGroup(u36: userdata, u37: string) -- Line: 376
    pcall(function() -- Line: 377
        -- upvalues: u36 (copy), u37 (copy)
        u36.CollisionGroup = u37;
    end);
end;

local function closePassParts(p38) -- Line: 382
    -- upvalues: IsInZone (copy), u33 (copy), Config (copy), RunService (copy)
    local root = p38.root;
    local v39 = false;

    for i, v in p38.passSaved do
        if i.Parent then
            if root.Parent and IsInZone(i, root.Position) then
                u33[i] = v;
                local RiderGroup = Config.RiderGroup;
                pcall(function() -- Line: 377
                    -- upvalues: i (copy), RiderGroup (copy)
                    i.CollisionGroup = RiderGroup;
                end);
                v39 = true;
            else
                pcall(function() -- Line: 377
                    -- upvalues: i (copy), v (copy)
                    i.CollisionGroup = v;
                end);
            end;
        end;
    end;

    table.clear(p38.passSaved);

    if v39 then
        local u40 = nil;
        u40 = RunService.Heartbeat:Connect(function() -- Line: 401
            -- upvalues: u33 (ref), root (copy), IsInZone (ref), u40 (ref)
            for i, v in u33 do
                if i.Parent then
                    if not (root.Parent and IsInZone(i, root.Position)) then
                        u33[i] = nil;
                        pcall(function() -- Line: 377
                            -- upvalues: i (copy), v (copy)
                            i.CollisionGroup = v;
                        end);
                    end;
                else
                    u33[i] = nil;
                end;
            end;

            if next(u33) == nil then
                u40:Disconnect();
            end;
        end);
    end;
end;

local function holdingBall(p41) -- Line: 419
    return p41.marble:GetAttribute("StuckBall") ~= nil;
end;

local function dashWindUp(p42: any, p43: number) -- Line: 423
    -- upvalues: Config (copy)
    return math.clamp((p43 - p42.dashStartedAt) / Config.DashChargeTime, 0, 1);
end;

local function cancelDash(p44) -- Line: 427
    -- upvalues: ColorSequence_new_ret (copy)
    p44.dashCharging = false;
    p44.dashRelease = false;

    if p44.dashEmitter then
        p44.dashEmitter:Destroy();
        p44.dashEmitter = nil;
    end;

    p44.gradient.Color = ColorSequence_new_ret;
end;

local function launchDash(p45: any, p46: vector, p47: number) -- Line: 437
    -- upvalues: Config (copy), ColorSequence_new_ret (copy), MarbleFx (copy), Dash (copy)
    local marble = p45.marble;
    local math_clamp_ret = math.clamp((p47 - p45.dashStartedAt) / Config.DashChargeTime, 0, 1);
    p45.dashCharging = false;
    p45.dashRelease = false;

    if p45.dashEmitter then
        p45.dashEmitter:Destroy();
        p45.dashEmitter = nil;
    end;

    p45.gradient.Color = ColorSequence_new_ret;

    if p46.Magnitude < 0.1 then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local LookVector = workspace_CurrentCamera.CFrame.LookVector;
            p46 = Vector3.new(LookVector.X, 0, LookVector.Z);
        else
            p46 = Vector3.new(0, 0, 0);
        end;
    end;

    if p46.Magnitude < 0.1 then
        local AssemblyLinearVelocity = marble.AssemblyLinearVelocity;
        p46 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
    end;

    if p46.Magnitude < 0.1 then
        return;
    end;

    local Unit = p46.Unit;
    local v48 = Config.DashMinSpeed + (Config.DashMaxSpeed - Config.DashMinSpeed) * math_clamp_ret;
    local v49 = Unit * v48 + Vector3.new(0, marble.AssemblyLinearVelocity.Y, 0);
    local v50;

    if v49.X == v49.X and (v49.Y == v49.Y and (v49.Z == v49.Z and (math.abs(v49.X) < 10000000 and math.abs(v49.Y) < 10000000))) then
        v50 = math.abs(v49.Z) < 10000000;
    else
        v50 = false;
    end;

    if not v50 then
        return;
    end;

    marble.AssemblyLinearVelocity = v49;
    local radius = p45.radius;
    marble.AssemblyAngularVelocity = (p45.groundNormal or Vector3.new(0, 1, 0)):Cross(v49) / radius;
    local charge = p45.charge;
    local v51 = (math.min(v48, Config.MaxSpeed) * 0.85 - Config.BaseSpeed) / (Config.MaxSpeed - Config.BaseSpeed);
    local v52 = 1 - math.clamp(v51, 0, 1);
    local v53 = 1 - math.sqrt(v52);
    p45.charge = math.max(charge, v53);
    p45.dashReadyAt = p47 + Config.DashCooldown;
    MarbleFx.dash(marble.Position, Unit, math_clamp_ret, marble);
    MarbleFx.shake(math_clamp_ret * 0.3 + 0.15, 0.3);
    Dash:FireServer(Unit, math_clamp_ret);
end;

local function onDashAction(p54, p55) -- Line: 468
    -- upvalues: u26 (ref), Config (copy), MarbleFx (copy), ColorSequence_new_ret2 (copy), ColorSequence_new_ret (copy)
    local v56 = u26;

    if not v56 then
        return Enum.ContextActionResult.Pass;
    end;

    local os_clock_ret = os.clock();

    if p55 == Enum.UserInputState.Begin then
        local v57;

        if Config.IsFrozen == nil then
            v57 = false;
        else
            v57 = Config.IsFrozen(v56.character);
        end;

        if not (v56.dashCharging or (v56.dashReadyAt > os_clock_ret or (v56.staggerUntil > os_clock_ret or v57))) and v56.marble:GetAttribute("StuckBall") == nil then
            v56.dashCharging = true;
            v56.dashRelease = false;
            v56.dashStartedAt = os_clock_ret;
            v56.dashEmitter = MarbleFx.dashCharge(v56.marble);
            v56.gradient.Color = ColorSequence_new_ret2;
        end;
    elseif p55 == Enum.UserInputState.End then
        if v56.dashCharging then
            v56.dashRelease = true;
        end;
    elseif p55 == Enum.UserInputState.Cancel then
        v56.dashCharging = false;
        v56.dashRelease = false;

        if v56.dashEmitter then
            v56.dashEmitter:Destroy();
            v56.dashEmitter = nil;
        end;

        v56.gradient.Color = ColorSequence_new_ret;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function stopRiding() -- Line: 493
    -- upvalues: u26 (ref), ContextActionService (copy), ColorSequence_new_ret (copy), closePassParts (copy), LocalPlayer (copy), StarterGui (copy), Config (copy), pushCharacter (copy)
    local v58 = u26;

    if not v58 then
        return;
    end;

    u26 = nil;

    if v58.humanoid.Parent then
        v58.humanoid.PlatformStand = false;
    end;

    ContextActionService:UnbindAction("MarbleDash");
    v58.dashCharging = false;
    v58.dashRelease = false;

    if v58.dashEmitter then
        v58.dashEmitter:Destroy();
        v58.dashEmitter = nil;
    end;

    v58.gradient.Color = ColorSequence_new_ret;

    for _, v in v58.conns do
        v:Disconnect();
    end;

    closePassParts(v58);

    if v58.force.Parent then
        v58.force:Destroy();
    end;

    if v58.attachment.Parent then
        v58.attachment:Destroy();
    end;

    v58.tag:Destroy();
    v58.wind:Destroy();
    LocalPlayer.CameraMinZoomDistance = v58.minZoomBefore;

    if v58.backpackBefore then
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack, true);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        if workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
            workspace_CurrentCamera.FieldOfView = Config.BaseFov;
        end;

        if v58.humanoid.Parent then
            workspace_CurrentCamera.CameraSubject = v58.humanoid;
        end;
    end;

    local root = v58.root;

    if root.Parent and (v58.humanoid.Health > 0 and not v58.humanoid.SeatPart) then
        local lastVelocity = v58.lastVelocity;
        local v59 = Vector3.new(lastVelocity.X, 0, lastVelocity.Z) * 0.6;
        local v60;

        if v59.Magnitude > 0.6 then
            v60 = math.atan2(-v59.X, -v59.Z);
        else
            v60 = select(2, root.CFrame:ToEulerAnglesYXZ());
        end;

        root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, v60, 0);
        root.AssemblyLinearVelocity = v59 + Vector3.new(0, 20, 0);
        root.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        v58.humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);

        if v59.Magnitude > 5 then
            pushCharacter(root, v59, 0.25, 1500);
        end;
    end;
end;

local function startRiding(u61: userdata) -- Line: 551
    -- upvalues: LocalPlayer (copy), u26 (ref), Config (copy), createSpeedTag (copy), StarterGui (copy), openPassParts (copy), ContextActionService (copy), onDashAction (copy), stopRiding (copy)
    local Character = LocalPlayer.Character;
    local v62;

    if Character then
        v62 = Character:FindFirstChildOfClass("Humanoid");
    else
        v62 = Character;
    end;

    local v63;

    if Character then
        v63 = Character:FindFirstChild("HumanoidRootPart");
    else
        v63 = Character;
    end;

    if u26 or not (Character and (v62 and v63)) then
        return;
    end;

    for _, child in v63:GetChildren() do
        if child.Name == "MarblePush" then
            child:Destroy();
        end;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "MarbleDriveAttachment";
    Attachment.Parent = u61;
    local VectorForce = Instance.new("VectorForce");
    VectorForce.Name = "MarbleDrive";
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World;
    VectorForce.ApplyAtCenterOfMass = true;
    VectorForce.Attachment0 = Attachment;
    VectorForce.Force = Vector3.new(0, 0, 0);
    VectorForce.Parent = u61;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u61, Character };
    RaycastParams_new_ret.CollisionGroup = Config.MarbleGroup;
    RaycastParams_new_ret.RespectCanCollide = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v64, v65, v66, v67 = createSpeedTag(u61);
    local Sound = Instance.new("Sound");
    Sound.SoundId = Config.Sounds.Wind;
    Sound.Looped = true;
    Sound.Volume = 0;
    Sound.Parent = workspace_CurrentCamera or u61;
    Sound:Play();
    local success, result = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack);

    if success and result then
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack, false);
    end;

    local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance;
    local math_max_ret = math.max(CameraMinZoomDistance, Config.CameraMinZoom);
    LocalPlayer.CameraMinZoomDistance = math.min(math_max_ret, LocalPlayer.CameraMaxZoomDistance);
    local os_clock_ret = os.clock();
    u26 = {
        marble = u61,
        weld = u61:FindFirstChild("RiderWeld"),
        character = Character,
        humanoid = v62,
        root = v63,
        radius = u61.Size.X / 2,
        attachment = Attachment,
        force = VectorForce,
        groundParams = RaycastParams_new_ret,
        charge = 0,
        staggerUntil = 0,
        lastGrounded = 0,
        groundNormal = Vector3.new(0, 1, 0),
        jumpRequestedAt = (-1 / 0),
        lastJump = 0,
        vBefore = nil,
        measuring = false,
        suppressImpactUntil = os_clock_ret + 0.3,
        impactReadyAt = 0,
        predicted = {},
        knockedAt = 0,
        passSaved = {},
        lastPosition = nil,
        lastStreamRequest = 0,
        lastVelocity = u61.AssemblyLinearVelocity,
        minZoomBefore = CameraMinZoomDistance,
        backpackBefore = success and result,
        tag = v64,
        speedLabel = v65,
        fill = v66,
        gradient = v67,
        wind = Sound,
        dashCharging = false,
        dashRelease = false,
        dashStartedAt = 0,
        dashReadyAt = 0,
        dashEmitter = nil,
        contactWith = nil,
        lastHolderId = nil,
        lastContactReport = 0,
        conns = {}
    };

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CameraSubject = u61;
    end;

    openPassParts(u26);
    ContextActionService:BindActionAtPriority("MarbleDash", onDashAction, true, Enum.ContextActionPriority.High.Value, Config.DashKey, Config.GamepadDashKey);
    ContextActionService:SetTitle("MarbleDash", "Dash");
    table.insert(u26.conns, u61.AncestryChanged:Connect(function() -- Line: 651
        -- upvalues: u61 (copy), stopRiding (ref)
        if not u61:IsDescendantOf(workspace) then
            stopRiding();
        end;
    end));
end;

local function applyOutcome(p68: any, p69: vector?, p70: any, p71: number) -- Line: 658
    -- upvalues: ClashMath (copy), MarbleFx (copy)
    local os_clock_ret = os.clock();
    p68.charge = p68.charge * p70.keep;
    p68.staggerUntil = math.max(p68.staggerUntil, os_clock_ret + p70.stagger);

    if p70.mag > 0 and p69 then
        p68.knockedAt = os_clock_ret;
        local marble = p68.marble;
        local v72 = ClashMath.applyKnock(marble.AssemblyLinearVelocity, p69, p70);
        local v73;

        if v72.X == v72.X and (v72.Y == v72.Y and (v72.Z == v72.Z and (math.abs(v72.X) < 10000000 and math.abs(v72.Y) < 10000000))) then
            v73 = math.abs(v72.Z) < 10000000;
        else
            v73 = false;
        end;

        if v73 then
            marble.AssemblyLinearVelocity = v72;
            local radius = p68.radius;
            marble.AssemblyAngularVelocity = (Vector3.new(0, 1, 0)):Cross(v72) / radius;
        end;

        p68.suppressImpactUntil = os_clock_ret + 0.3;
        MarbleFx.shake(p71 * 0.6 + 0.35, 0.4);
    end;
end;

local function drive(p74: number) -- Line: 675
    -- upvalues: u26 (ref), Config (copy), getMoveDirection (copy), ColorSequence_new_ret (copy), launchDash (copy), MarbleFx (copy), LocalPlayer (copy)
    local v75 = u26;
    local marble = v75.marble;

    if not marble.Parent or marble.Anchored then
        return;
    end;

    if v75.weld and v75.weld.Parent == nil then
        return;
    end;

    local os_clock_ret = os.clock();
    local AssemblyMass = marble.AssemblyMass;
    local AssemblyLinearVelocity = marble.AssemblyLinearVelocity;
    local Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
    local Magnitude = Vector3_new_ret.Magnitude;

    if not v75.humanoid.PlatformStand then
        v75.humanoid.PlatformStand = true;
    end;

    if v75.lastPosition and (marble.Position - v75.lastPosition).Magnitude > 40 then
        marble.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        marble.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        v75.charge = 0;
        v75.suppressImpactUntil = os_clock_ret + 0.3;
        AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        Magnitude = 0;
        Vector3_new_ret = Vector3.new(0, 0, 0);
    end;

    v75.lastPosition = marble.Position;
    local v76 = workspace:Spherecast(marble.Position, v75.radius * 0.9, Vector3.new(0, -(v75.radius * 0.1 + 0.45), 0), v75.groundParams);

    if v76 then
        v75.lastGrounded = os_clock_ret;
        v75.groundNormal = v76.Normal;
    end;

    local v77 = os_clock_ret - v75.lastGrounded <= Config.CoyoteTime;
    local v78;

    if Config.IsFrozen == nil then
        v78 = false;
    else
        v78 = Config.IsFrozen(v75.character);
    end;

    local v79 = getMoveDirection(v75.humanoid);
    local math_min_ret = math.min(v79.Magnitude, 1);
    local v80 = os_clock_ret < v75.staggerUntil and true or v78;
    local dashCharging = v75.dashCharging;

    if dashCharging and (v80 or v75.marble:GetAttribute("StuckBall") ~= nil) then
        v75.dashCharging = false;
        v75.dashRelease = false;

        if v75.dashEmitter then
            v75.dashEmitter:Destroy();
            v75.dashEmitter = nil;
        end;

        v75.gradient.Color = ColorSequence_new_ret;
        dashCharging = false;
    elseif dashCharging and v75.dashRelease then
        launchDash(v75, v79, os_clock_ret);
        AssemblyLinearVelocity = marble.AssemblyLinearVelocity;
        Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
        Magnitude = Vector3_new_ret.Magnitude;
        dashCharging = false;
    end;

    if v76 and not v78 then
        local radius = v75.radius;
        marble.AssemblyAngularVelocity = (v75.groundNormal or Vector3.new(0, 1, 0)):Cross(AssemblyLinearVelocity) / radius;
    end;

    local v81 = marble:GetAttribute("SpeedScale") or 1;
    local v82 = (Config.BaseSpeed + (Config.MaxSpeed - Config.BaseSpeed) * (1 - (1 - v75.charge) ^ 2)) * v81;

    if not (v80 or dashCharging) then
        if math_min_ret > 0.1 then
            local v83 = Magnitude <= 2 and 1 or Vector3_new_ret.Unit:Dot(v79.Unit);

            if v83 < -0.3 or v77 and Magnitude < v82 * 0.5 then
                v75.charge = v75.charge - Config.ChargeDecayBrake * p74;
            elseif v77 and (v83 > 0.5 and (Config.ChargeMinInput <= math_min_ret and v82 * 0.8 <= Magnitude)) then
                v75.charge = v75.charge + p74 / Config.ChargeTime;
            end;

            local v84;

            if v76 == nil or v75.groundNormal.Y >= 0.985 then
                v84 = false;
            else
                local groundNormal = v75.groundNormal;
                v84 = Vector3_new_ret:Dot((Vector3.new(groundNormal.X, 0, groundNormal.Z))) > 0;
            end;

            if v84 and (v83 > 0.5 and (v82 < Magnitude and os_clock_ret - v75.knockedAt > 1)) then
                local charge = v75.charge;
                local v85 = 1 - math.clamp((Magnitude * 0.95 / v81 - Config.BaseSpeed) / (Config.MaxSpeed - Config.BaseSpeed), 0, 1);
                local v86 = 1 - math.sqrt(v85);
                v75.charge = math.max(charge, v86);
            end;
        else
            v75.charge = v75.charge - Config.ChargeDecayIdle * p74;
        end;

        v75.charge = math.clamp(v75.charge, 0, 1);
    end;

    local v87 = (Config.BaseSpeed + (Config.MaxSpeed - Config.BaseSpeed) * (1 - (1 - v75.charge) ^ 2)) * v81;
    local v88 = Vector3.new(0, 0, 0);

    if dashCharging then
        if v77 and Magnitude > 0.05 then
            v88 = -Vector3_new_ret * math.min(Config.DashChargeBrake, 1 / p74);
        end;
    elseif not v80 then
        if math_min_ret > 0.1 then
            local Unit = v79.Unit;
            local v89 = v87 * math_min_ret;
            local v90 = Vector3_new_ret:Dot(Unit);
            local v91 = Vector3_new_ret - Unit * v90;
            local v92;

            if v90 < v89 then
                local v93;

                if v90 < 0 then
                    v93 = Config.BrakeAccel;
                else
                    v93 = Config.GroundAccel;
                end;

                v92 = math.min((v89 - v90) * Config.Responsiveness, v93);
            else
                v92 = -math.min((v90 - v89) * Config.Responsiveness, Config.OverspeedDecel);
            end;

            v88 = Unit * v92;

            if v91.Magnitude > 0.05 then
                v88 = v88 - v91.Unit * math.min(v91.Magnitude * Config.Responsiveness, Config.TurnAccel);
            end;

            if not v77 then
                v88 = v88 * Config.AirControl;
            end;
        elseif v77 and Magnitude > 0.05 then
            v88 = -Vector3_new_ret * math.min(Config.CoastDrag, 1 / p74);
        end;
    end;

    if v78 and (v77 and Magnitude > 0.05) then
        v88 = -Vector3_new_ret * math.min(Config.FrozenBrake, 1 / p74);
    end;

    if Config.HardCap < Magnitude then
        v88 = v88 - Vector3_new_ret.Unit * (Magnitude - Config.HardCap) * 4;
    end;

    local v94 = v88 * AssemblyMass;
    local force = v75.force;
    local v95;

    if v94.X == v94.X and (v94.Y == v94.Y and (v94.Z == v94.Z and (math.abs(v94.X) < 10000000 and math.abs(v94.Y) < 10000000))) then
        v95 = math.abs(v94.Z) < 10000000;
    else
        v95 = false;
    end;

    force.Force = not v95 and Vector3.new(0, 0, 0) or v94;

    if v78 and (v76 and Magnitude < 4) then
        local LookVector = marble.CFrame.LookVector;
        local Vector3_new_ret2 = Vector3.new(LookVector.X, 0, LookVector.Z);

        if Vector3_new_ret2.Magnitude < 0.1 then
            local UpVector = marble.CFrame.UpVector;
            Vector3_new_ret2 = Vector3.new(UpVector.X, 0, UpVector.Z);
        end;

        if Vector3_new_ret2.Magnitude > 0.001 then
            local CFrame_lookAt_ret = CFrame.lookAt(marble.Position, marble.Position + Vector3_new_ret2);
            marble.CFrame = marble.CFrame:Lerp(CFrame_lookAt_ret, (math.min(1, p74 * 6)));
            marble.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        end;
    end;

    if not (v78 or (os_clock_ret - v75.jumpRequestedAt > Config.JumpBuffer or (not v77 or os_clock_ret - v75.lastJump < Config.JumpCooldown))) then
        v75.lastJump = os_clock_ret;
        v75.lastGrounded = 0;
        v75.jumpRequestedAt = (-1 / 0);
        local X = AssemblyLinearVelocity.X;
        local math_max_ret = math.max(AssemblyLinearVelocity.Y, Config.JumpVelocity);
        marble.AssemblyLinearVelocity = Vector3.new(X, math_max_ret, AssemblyLinearVelocity.Z);
        MarbleFx.playSound(Config.Sounds.Jump, marble, 0.5, 1.2);
    end;

    if Config.StreamAheadSpeed < Magnitude and (workspace.StreamingEnabled and os_clock_ret - v75.lastStreamRequest > 0.4) then
        v75.lastStreamRequest = os_clock_ret;
        task.spawn(pcall, LocalPlayer.RequestStreamAroundAsync, LocalPlayer, marble.Position + Vector3_new_ret * 0.75, 1);
    end;

    v75.vBefore = marble.AssemblyLinearVelocity;
    v75.measuring = p74 < 0.05;
    v75.lastVelocity = AssemblyLinearVelocity;
end;

local function nearOtherMarble(p96: any, p97: number) -- Line: 829
    -- upvalues: u14 (copy)
    for i in u14 do
        if i ~= p96.marble and (i.Position - p96.marble.Position).Magnitude < p96.radius + i.Size.X / 2 + p97 then
            return true;
        end;
    end;

    return false;
end;

local function measureImpact(p98: any, p99: number) -- Line: 839
    -- upvalues: Config (copy), u14 (copy), nearOtherMarble (copy), MarbleFx (copy), Impact (copy)
    if not (p98.measuring and p98.vBefore) then
        return;
    end;

    p98.measuring = false;
    local vBefore = p98.vBefore;
    local Vector3_new_ret = Vector3.new(vBefore.X, 0, vBefore.Z);
    local Magnitude = Vector3_new_ret.Magnitude;

    if Magnitude < 1 then
        return;
    end;

    local AssemblyLinearVelocity = p98.marble.AssemblyLinearVelocity;
    local v100 = -(Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z) - Vector3_new_ret):Dot(Vector3_new_ret / Magnitude);

    if v100 < Config.ImpactLoss or (p99 < p98.suppressImpactUntil or p99 < p98.impactReadyAt) then
        return;
    end;

    local v101 = Vector3_new_ret / Magnitude;
    local v102 = workspace:Spherecast(p98.marble.Position, p98.radius * 0.9, v101 * (p98.radius * 0.1 + 2), p98.groundParams);

    if v102 and (v102.Instance:IsA("BasePart") and u14[v102.Instance]) then
        return;
    end;

    if not v102 and nearOtherMarble(p98, 1) then
        return;
    end;

    p98.impactReadyAt = p99 + 0.25;
    p98.charge = p98.charge * Config.ImpactChargeKeep;
    local v103 = -v101;

    if v102 and math.abs(v102.Normal.Y) < 0.7 then
        v103 = v102.Normal;
    end;

    local v104 = p98.marble.Position - v103 * p98.radius;
    local math_clamp_ret = math.clamp(v100 / (Config.MaxSpeed * 1.5), 0, 1);
    MarbleFx.impact(v104, v103, math_clamp_ret);
    MarbleFx.shake(math_clamp_ret * 0.5 + 0.3, 0.35);
    Impact:FireServer(v104, v103, math_clamp_ret, Vector3_new_ret);
end;

local function currentHolder() -- Line: 878
    -- upvalues: workspace2 (copy), LocalPlayer (copy)
    local v105 = workspace2 and workspace2:FindFirstChild("ballHolder");
    local v106 = v105 and v105:IsA("ObjectValue") and v105.Value;

    if v106 and v106:IsA("Player") then
        v106 = v106.Character;
    end;

    if v106 and (v106:IsA("Model") and v106 ~= LocalPlayer.Character) then
        return v106;
    end;

    return nil;
end;

local function reportContacts(p107: any, p108: number) -- Line: 890
    -- upvalues: currentHolder (copy), Players (copy), u14 (copy), Config (copy), Contact (copy)
    local v109 = currentHolder();
    local v110;

    if v109 then
        v110 = Players:GetPlayerFromCharacter(v109);
    else
        v110 = v109;
    end;

    local v111 = nil;
    local v112 = 0;

    if v110 then
        if v109:GetAttribute("InMarble") then
            for i in u14 do
                if i:GetAttribute("OwnerUserId") == v110.UserId then
                    v111 = i.Position;
                    v112 = p107.radius + i.Size.X / 2 + Config.PredictMargin;
                    break;
                end;
            end;
        else
            local HumanoidRootPart = v109:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                v111 = HumanoidRootPart.Position;
                v112 = p107.radius + Config.KnockReach;
            end;
        end;
    end;

    local v113;

    if v111 == nil then
        v113 = false;
    else
        v113 = (v111 - p107.marble.Position).Magnitude <= v112;
    end;

    local v114;

    if v113 and v110 then
        v114 = v110.UserId;
    else
        v114 = nil;
    end;

    if v110 then
        v110 = v110.UserId;
    end;

    if v110 == p107.lastHolderId then
        if v114 ~= p107.contactWith then
            if v114 == nil then
                p107.contactWith = nil;

                return;
            end;

            if p108 - p107.lastContactReport >= Config.ContactReportCooldown then
                p107.lastContactReport = p108;
                p107.contactWith = v114;
                Contact:FireServer(v114, p107.marble.Position, v111);
            end;
        end;

        return;
    end;

    p107.lastHolderId = v110;
    p107.contactWith = v114;
end;

local function predictClashes(p115: any, p116: number) -- Line: 930
    -- upvalues: u14 (copy), Config (copy), ClashMath (copy), MarbleFx (copy), applyOutcome (copy)
    local marble = p115.marble;
    local v117 = u14[marble];

    if not v117 then
        return;
    end;

    for i, v in u14 do
        local Attribute = i:GetAttribute("OwnerUserId");

        if i ~= marble and (Attribute and ((i.Position - marble.Position).Magnitude <= p115.radius + i.Size.X / 2 + Config.PredictMargin and p116 - (p115.predicted[Attribute] or (-1 / 0)) >= Config.ClashCooldown)) then
            local v118 = ClashMath.normal(marble.Position, i.Position);

            if v118 then
                local v119, v120, v121 = ClashMath.closing(v117.history, v.history, v118);

                if v119 >= Config.ClashMinClosing then
                    p115.predicted[Attribute] = p116;
                    local v122, v123 = ClashMath.resolve(v118, v119, v120, v121);
                    local math_clamp_ret = math.clamp(v119 / (Config.MaxSpeed * 2), 0, 1);
                    MarbleFx.clash((marble.Position + v118 * p115.radius + i.Position - v118 * (i.Size.X / 2)) / 2, v118, math_clamp_ret, v122);
                    applyOutcome(p115, v118, v123, math_clamp_ret);
                end;
            end;
        end;
    end;
end;

local function updateFeel(p124: number) -- Line: 964
    -- upvalues: u26 (ref), Config (copy)
    local v125 = u26;

    if not v125 then
        return;
    end;

    local AssemblyLinearVelocity = v125.marble.AssemblyLinearVelocity;
    local Magnitude = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude;
    local math_clamp_ret = math.clamp(Magnitude / Config.MaxSpeed, 0, 1);
    local v126;

    if v125.dashCharging then
        local v127 = (os.clock() - v125.dashStartedAt) / Config.DashChargeTime;
        v126 = math.clamp(v127, 0, 1);
    else
        v126 = 0;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
        workspace_CurrentCamera.FieldOfView = workspace_CurrentCamera.FieldOfView + (Config.BaseFov + (Config.MaxFov - Config.BaseFov) * math_clamp_ret - v126 * 6 - workspace_CurrentCamera.FieldOfView) * math.min(1, p124 * 6);
    end;

    local speedLabel = v125.speedLabel;
    local math_floor_ret = math.floor(Magnitude + 0.5);
    speedLabel.Text = tostring(math_floor_ret);
    local v128;

    if v125.dashCharging then
        v128 = v126;
    else
        v128 = v125.charge;
    end;

    v125.fill.Size = UDim2.fromScale(v128, 1);

    if v125.dashEmitter then
        v125.dashEmitter.Rate = v126 * 60 + 20;
    end;

    local v129 = math.clamp((Magnitude - 30) / 90, 0, 1) * 0.5;
    local math_max_ret = math.max(v129, v126 * 0.45);
    local wind = v125.wind;
    wind.Volume = wind.Volume + (math_max_ret - v125.wind.Volume) * math.min(1, p124 * 5);
    v125.wind.PlaybackSpeed = v126 * 0.7 + 1;
end;

RunService.PreSimulation:Connect(function(p130) -- Line: 988
    -- upvalues: u26 (ref), drive (copy)
    if u26 then
        drive(p130);
    end;
end);
RunService.PostSimulation:Connect(function() -- Line: 993
    -- upvalues: u14 (copy), ClashMath (copy), u26 (ref), measureImpact (copy), predictClashes (copy), reportContacts (copy)
    for i, v in u14 do
        ClashMath.push(v.history, i.AssemblyLinearVelocity);
    end;

    local v131 = u26;

    if v131 and v131.marble.Parent then
        local os_clock_ret = os.clock();
        measureImpact(v131, os_clock_ret);
        predictClashes(v131, os_clock_ret);
        reportContacts(v131, os_clock_ret);
    end;
end);
RunService:BindToRenderStep("MarbleFeel", Enum.RenderPriority.Camera.Value + 3, updateFeel);
local u132 = 0;
UserInputService.JumpRequest:Connect(function() -- Line: 1010
    -- upvalues: u26 (ref), u132 (ref), UserInputService (copy), packets (copy)
    local v133 = u26;

    if not v133 then
        return;
    end;

    if not v133.character:GetAttribute("Emoting") then
        v133.jumpRequestedAt = os.clock();

        return;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - u132 >= 0.2 and not UserInputService:GetFocusedTextBox() then
        u132 = os_clock_ret;
        packets.bytenet_useEmote.send({
            emoteName = "",
            method = "Stop"
        });
    end;
end);

local function isMyMarble(p134: userdata) -- Line: 1030
    -- upvalues: LocalPlayer (copy)
    local v135 = p134:IsA("BasePart") and p134:GetAttribute("OwnerUserId") == LocalPlayer.UserId;

    return v135;
end;

local function onCharacter(u136: userdata) -- Line: 1034
    -- upvalues: stopRiding (copy), CollectionService (copy), Config (copy), LocalPlayer (copy), startRiding (copy)
    stopRiding();
    u136:GetAttributeChangedSignal("InMarble"):Connect(function() -- Line: 1036
        -- upvalues: u136 (copy), stopRiding (ref), CollectionService (ref), Config (ref), LocalPlayer (ref), startRiding (ref)
        if u136:GetAttribute("InMarble") then
            for _, v in CollectionService:GetTagged(Config.Tag) do
                local v137 = v:IsA("BasePart") and v:GetAttribute("OwnerUserId") == LocalPlayer.UserId;

                if v137 then
                    startRiding(v);
                end;
            end;

            return;
        end;

        stopRiding();
    end);
end;

CollectionService:GetInstanceAddedSignal(Config.Tag):Connect(function(p138) -- Line: 1049
    -- upvalues: LocalPlayer (copy), startRiding (copy)
    local Character = LocalPlayer.Character;
    local v139 = p138:IsA("BasePart") and p138:GetAttribute("OwnerUserId") == LocalPlayer.UserId;

    if v139 and (Character and Character:GetAttribute("InMarble")) then
        startRiding(p138);
    end;
end);

if LocalPlayer.Character then
    local Character = LocalPlayer.Character;
    stopRiding();
    Character:GetAttributeChangedSignal("InMarble"):Connect(function() -- Line: 1036
        -- upvalues: Character (copy), stopRiding (copy), CollectionService (copy), Config (copy), LocalPlayer (copy), startRiding (copy)
        if Character:GetAttribute("InMarble") then
            for _, v in CollectionService:GetTagged(Config.Tag) do
                local v140 = v:IsA("BasePart") and v:GetAttribute("OwnerUserId") == LocalPlayer.UserId;

                if v140 then
                    startRiding(v);
                end;
            end;

            return;
        end;

        stopRiding();
    end);
end;

LocalPlayer.CharacterAdded:Connect(onCharacter);
local u141 = 0;

local function onToggleAction(p142, p143) -- Line: 1066
    -- upvalues: u141 (ref), Config (copy), LocalPlayer (copy), u26 (ref), Toggle (copy)
    if p143 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - u141 < Config.ToggleCooldown then
        return Enum.ContextActionResult.Sink;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return Enum.ContextActionResult.Sink;
    end;

    if not u26 and (Character.Anchored or Character:FindFirstChildWhichIsA("BodyMover")) then
        return Enum.ContextActionResult.Sink;
    end;

    u141 = os_clock_ret;
    Toggle:FireServer(Character.Position, Character.AssemblyLinearVelocity);

    return Enum.ContextActionResult.Sink;
end;

if Config.AllowSelfToggle then
    ContextActionService:BindAction("ToggleMarble", onToggleAction, true, Config.ToggleKey, Config.GamepadToggleKey);
    ContextActionService:SetTitle("ToggleMarble", "Ball");
end;

Clash.OnClientEvent:Connect(function(p144) -- Line: 1093
    -- upvalues: LocalPlayer (copy), u26 (ref), Config (copy), MarbleFx (copy), applyOutcome (copy)
    local v145 = nil;

    for _, v in p144.results do
        if v.uid == LocalPlayer.UserId then
            v145 = v;
            break;
        end;
    end;

    local v146 = u26;
    local success, result = pcall(LocalPlayer.GetNetworkPing, LocalPlayer);
    local v147 = Config.PredictWindow + 2 * ((not success or typeof(result) ~= "number") and 0.1 or result);
    local v148;

    if v145 == nil or (v145.other == nil or v146 == nil) then
        v148 = false;
    else
        v148 = os.clock() - (v146.predicted[v145.other] or (-1 / 0)) <= v147;
    end;

    if v148 then
        return;
    end;

    MarbleFx.clash(p144.contact, p144.normal, p144.intensity, p144.kind);

    if v145 and (v146 and v146.marble.Parent) then
        if v145.other then
            v146.predicted[v145.other] = os.clock();
        end;

        applyOutcome(v146, v145.n, v145, p144.intensity);
    end;
end);
Knock.OnClientEvent:Connect(function(p149: vector, p150: number, p151: boolean) -- Line: 1118
    -- upvalues: LocalPlayer (copy), u26 (ref), Config (copy), pushCharacter (copy), MarbleFx (copy)
    local Character = LocalPlayer.Character;
    local u152;

    if Character then
        u152 = Character:FindFirstChildOfClass("Humanoid");
    else
        u152 = Character;
    end;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if u26 or not (u152 and Character) then
        return;
    end;

    if p151 then
        if u152:GetStateEnabled(Enum.HumanoidStateType.FallingDown) then
            u152:ChangeState(Enum.HumanoidStateType.FallingDown);
        else
            u152:ChangeState(Enum.HumanoidStateType.Physics);
            task.delay(Config.KnockDownTime, function() -- Line: 1130
                -- upvalues: u152 (copy)
                if u152.Parent and u152:GetState() == Enum.HumanoidStateType.Physics then
                    u152:ChangeState(Enum.HumanoidStateType.GettingUp);
                end;
            end);
        end;
    end;

    Character.AssemblyLinearVelocity = p149 * p150;

    if not p151 then
        pushCharacter(Character, Vector3.new(p149.X, 0, p149.Z) * p150, 0.18, 2000);
    end;

    MarbleFx.shake(0.5, 0.4);
end);
Fx.OnClientEvent:Connect(function(p153: string, p154: vector, p155: any, p156: any) -- Line: 1144
    -- upvalues: MarbleFx (copy)
    if p153 == "enter" then
        MarbleFx.enter(p154, p155, p156);

        return;
    end;

    if p153 == "exit" then
        MarbleFx.exit(p154, p155, p156);

        return;
    end;

    if p153 == "impact" then
        MarbleFx.impact(p154, p155, p156);

        return;
    end;

    if p153 == "dash" then
        MarbleFx.dash(p154, p155, p156);
    end;
end);