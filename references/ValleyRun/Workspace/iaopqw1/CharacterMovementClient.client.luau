 

 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Movement = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Movement");
local MovementProfiles = require(Movement:WaitForChild("MovementProfiles"));
local LocalPlayer = game.Players.LocalPlayer;
local u1 = MovementProfiles.get(LocalPlayer:GetAttribute("GameRole"), LocalPlayer);
local BoostRequest = Movement.Parent:WaitForChild("Presentation"):WaitForChild("BoostRequest");
local MovementModel = require(Movement:WaitForChild("MovementModel"));
local BodyFacingModel = require(Movement:WaitForChild("BodyFacingModel"));
local BodyFacingConfig = require(Movement:WaitForChild("BodyFacingConfig"));
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
local BoostInput = require(Movement:WaitForChild("BoostInput"));
local ControlGate = require(Movement:WaitForChild("ControlGate"));
local TacklePrediction = require(Movement.Parent.Game:WaitForChild("TacklePrediction"));
local GearPredictionClient = require(Movement.Parent:WaitForChild("Gear"):WaitForChild("GearPredictionClient"));
local StepOverMotion = require(Movement:WaitForChild("StepOverMotion"));
local CannonMotion = require(Movement:WaitForChild("CannonMotion"));
local GearCatalog = require(Movement.Parent.Gear:WaitForChild("GearCatalog"));

if LocalPlayer.Character ~= script_Parent then
    return;
end;

BoostInput.clear();
local u2 = MovementModel.new();

local function turning() -- Line: 29
    -- upvalues: Humanoid (copy), u1 (ref), MovementModel (copy), u2 (copy), UserInputService (copy)
    local v3 = Humanoid.MoveDirection * Vector3.new(1, 0, 1);

    if v3.Magnitude <= u1.InputDeadzone then
        return false;
    end;

    return MovementModel.redirects(u2, v3.Unit, u1, UserInputService.PreferredInput == Enum.PreferredInput.Touch);
end;

BoostInput.turning = turning;
local u4 = "ChickenOrHeroMovement_" .. game:GetService("HttpService"):GenerateGUID(false);
local u5 = {};
local u6 = false;
local WalkSpeed = Humanoid.WalkSpeed;
local StateEnabled = Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping);
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, u1.JumpEnabled);

local function cleanup() -- Line: 43
    -- upvalues: u6 (ref), LocalPlayer (copy), script_Parent (copy), BoostInput (copy), turning (copy), StepOverMotion (copy), CannonMotion (copy), RunService (copy), u4 (copy), u5 (copy), Humanoid (copy), WalkSpeed (copy), StateEnabled (copy)
    if u6 then
        return;
    end;

    u6 = true;

    if LocalPlayer.Character == script_Parent then
        BoostInput.clear();
    end;

    if BoostInput.turning == turning then
        BoostInput.turning = nil;
    end;

    if StepOverMotion.active(script_Parent) then
        StepOverMotion.cancel();
    end;

    if CannonMotion.active(script_Parent) then
        CannonMotion.cancel();
    end;

    RunService:UnbindFromRenderStep(u4);

    for _, v in u5 do
        v:Disconnect();
    end;

    if Humanoid.Parent then
        Humanoid.WalkSpeed = WalkSpeed;
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, StateEnabled);
    end;
end;

local u7 = nil;
local u8 = (-1 / 0);

local function adrenaline() -- Line: 72
    -- upvalues: u8 (ref), u7 (ref)
    if os.clock() - u8 > 2 then
        u8 = os.clock();
        u7 = os.clock();
    end;
end;

table.insert(u5, GearPredictionClient.FX.Event:Connect(function(p9) -- Line: 78
    -- upvalues: LocalPlayer (copy), u8 (ref), u7 (ref)
    if type(p9) == "table" and (p9.kind == "Adrenaline" and (p9.ownerId == LocalPlayer.UserId and os.clock() - u8 > 2)) then
        u8 = os.clock();
        u7 = os.clock();
    end;
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("GearBoost");
table.insert(u5, AttributeChangedSignal:Connect(function() -- Line: 83
    -- upvalues: LocalPlayer (copy), u8 (ref), u7 (ref)
    if LocalPlayer:GetAttribute("GearBoost") == true and os.clock() - u8 > 2 then
        u8 = os.clock();
        u7 = os.clock();
    end;
end));
table.insert(u5, Humanoid.Died:Connect(cleanup));
table.insert(u5, script.Destroying:Connect(cleanup));
table.insert(u5, script_Parent.AncestryChanged:Connect(function(p10, p11) -- Line: 92
    -- upvalues: cleanup (copy)
    if not p11 then
        cleanup();
    end;
end));

local function blockReason(p12) -- Line: 98
    -- upvalues: script_Parent (copy)
    if script_Parent:GetAttribute("MovementBlockReason") ~= p12 then
        script_Parent:SetAttribute("MovementBlockReason", p12);
        script_Parent:SetAttribute("MovementBlockSince", p12 and workspace:GetServerTimeNow() or nil);
    end;
end;

local Attribute = script_Parent:GetAttribute("MovementReset");
local Attribute2 = script_Parent:GetAttribute("SpeedCut");
local u13 = nil;
local u14 = 0;
local u15 = 0;
local u16 = nil;
RunService:BindToRenderStep(u4, Enum.RenderPriority.Input.Value + 1, function(p17) -- Line: 113
    -- upvalues: u6 (ref), LocalPlayer (copy), script_Parent (copy), cleanup (copy), BoostInput (copy), UserInputService (copy), MovementProfiles (copy), u1 (ref), u2 (copy), Attribute2 (ref), Attribute (ref), MovementModel (copy), StepOverMotion (copy), CannonMotion (copy), Humanoid (copy), GearPredictionClient (copy), TacklePrediction (copy), ControlGate (copy), HumanoidRootPart (copy), u13 (ref), BodyFacingModel (copy), BodyFacingConfig (copy), u7 (ref), GearCatalog (copy), u16 (ref), BoostRequest (copy), u14 (ref), u15 (ref)
    if u6 then
        return;
    end;

    if LocalPlayer.Character ~= script_Parent then
        cleanup();

        return;
    end;

    local v18, v19 = BoostInput.consume();
    local v20 = v19 or UserInputService.PreferredInput == Enum.PreferredInput.Touch;
    local v21 = MovementProfiles.get(LocalPlayer:GetAttribute("GameRole"), LocalPlayer);

    if v21 ~= u1 then
        u1 = v21;
        u2.dashRemaining = 0;
        u2.recoveryRemaining = 0;
        u2.armed = false;
        v18 = false;

        if u2.carryRemaining <= 0 then
            u2.speed = math.min(u2.speed, u1.MaxSpeed);
        end;

        script_Parent:SetAttribute("DashReady", false);
    end;

    local Attribute3 = script_Parent:GetAttribute("SpeedCut");

    if Attribute3 ~= Attribute2 then
        Attribute2 = Attribute3;
        local v22 = tonumber(script_Parent:GetAttribute("SpeedCutFactor")) or 1;
        local math_clamp_ret = math.clamp(v22, 0, 1);
        local v23 = u2;
        v23.speed = v23.speed * math_clamp_ret;
        local v24 = u2;
        v24.outputSpeed = v24.outputSpeed * math_clamp_ret;
    end;

    local Attribute4 = script_Parent:GetAttribute("MovementReset");

    if Attribute4 ~= Attribute then
        Attribute = Attribute4;
        MovementModel.suspend(u2, 0);
        v18 = false;

        if StepOverMotion.active(script_Parent) then
            StepOverMotion.cancel();
        end;

        if CannonMotion.active(script_Parent) then
            CannonMotion.cancel();
        end;
    end;

    local v25, v26, v27, v28 = StepOverMotion.step(script_Parent);

    if v25 then
        MovementModel.suspend(u2, p17);
        Humanoid.WalkSpeed = 0;
        Humanoid:Move(Vector3.new(0, 0, 0), false);

        return;
    end;

    if v25 == false then
        MovementModel.carry(u2, v26, v27, v28);
    end;

    local v29, v30, v31, v32 = CannonMotion.step(script_Parent);

    if v29 then
        MovementModel.suspend(u2, p17);
        Humanoid.WalkSpeed = 0;
        Humanoid:Move(Vector3.new(0, 0, 0), false);

        return;
    end;

    if v29 == false then
        MovementModel.carry(u2, v30, v31, v32);
    end;

    local v33, v34, v35, v36 = GearPredictionClient.rocket(script_Parent);
    local v37 = GearPredictionClient.rocketActive(script_Parent);

    if v37 then
        v18 = false;
    end;

    if v33 == "Carry" then
        MovementModel.carry(u2, v34, v35, v36);
    end;

    if v33 == "Boost" or not v33 and script_Parent:GetAttribute("GearMotion") then
        if script_Parent:GetAttribute("MovementBlockReason") ~= "GearMotion" then
            script_Parent:SetAttribute("MovementBlockReason", "GearMotion");
            script_Parent:SetAttribute("MovementBlockSince", workspace:GetServerTimeNow() or nil);
        end;

        MovementModel.suspend(u2, p17);
        Humanoid.WalkSpeed = 0;
        Humanoid:Move(Vector3.new(0, 0, 0), false);

        return;
    end;

    if TacklePrediction.isActive(script_Parent) or script_Parent:GetAttribute("TackleActive") then
        if script_Parent:GetAttribute("MovementBlockReason") ~= "Tackle" then
            script_Parent:SetAttribute("MovementBlockReason", "Tackle");
            script_Parent:SetAttribute("MovementBlockSince", workspace:GetServerTimeNow() or nil);
        end;

        MovementModel.suspend(u2, p17);

        return;
    end;

    local State = Humanoid:GetState();
    local v38;

    if script_Parent:GetAttribute("MovementLocked") == true then
        v38 = script_Parent:GetAttribute("MovementLockReason") or "Match";
    else
        v38 = ControlGate.movementReason(LocalPlayer);
    end;

    local v39 = v38 ~= nil;

    if Humanoid.Health <= 0 then
        cleanup();

        return;
    end;

    if Humanoid.Sit or (Humanoid.PlatformStand or (HumanoidRootPart.Anchored or (State == Enum.HumanoidStateType.Swimming or (State == Enum.HumanoidStateType.Climbing or State == Enum.HumanoidStateType.Physics)))) then
        if HumanoidRootPart.Anchored and (script_Parent:GetAttribute("Burrowing") and not u13) then
            u13 = u2.speed;
        end;

        local v40 = v38 or (HumanoidRootPart.Anchored and "Anchored" or (Humanoid.Sit and "Seated" or (Humanoid.PlatformStand and "PlatformStand" or State.Name)));

        if script_Parent:GetAttribute("MovementBlockReason") ~= v40 then
            script_Parent:SetAttribute("MovementBlockReason", v40);
            script_Parent:SetAttribute("MovementBlockSince", v40 and workspace:GetServerTimeNow() or nil);
        end;

        MovementModel.suspend(u2, p17);

        return;
    end;

    if script_Parent:GetAttribute("MovementBlockReason") ~= v38 then
        script_Parent:SetAttribute("MovementBlockReason", v38);
        script_Parent:SetAttribute("MovementBlockSince", v38 and workspace:GetServerTimeNow() or nil);
    end;

    if u13 and not script_Parent:GetAttribute("Burrowing") then
        local v41 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);

        if v41.Magnitude > 0.01 and u13 > 0 then
            MovementModel.carry(u2, u13, v41, 0.3);
            local v42 = v41.Unit * u13;
            local X = v42.X;
            local math_min_ret = math.min(HumanoidRootPart.AssemblyLinearVelocity.Y, 0);
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(X, math_min_ret, v42.Z);
        end;

        u13 = nil;

        if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.FallingDown then
            Humanoid:ChangeState(Enum.HumanoidStateType.Running);
        end;
    end;

    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
    local Magnitude = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude;

    if v39 then
        MovementModel.suspend(u2, p17);
        Humanoid.WalkSpeed = 0;
        Humanoid:Move(Vector3.new(0, 0, 0), false);
    else
        local MoveDirection = Humanoid.MoveDirection;
        local v43 = Vector3.new(0, 0, 0);
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            local LookVector = workspace_CurrentCamera.CFrame.LookVector;
            local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

            if Vector3_new_ret.Magnitude > 0.001 then
                local Unit = Vector3_new_ret.Unit;
                local v44 = MoveDirection:Dot((Unit:Cross(Vector3.new(0, 1, 0))));
                local v45 = -MoveDirection:Dot(Unit);
                v43 = Vector3.new(v44, 0, v45);
            end;
        end;

        local v46 = (not workspace_CurrentCamera or Humanoid.RigType ~= Enum.HumanoidRigType.R6) and 1 or BodyFacingModel.speedMultiplier(MoveDirection.Magnitude > u1.InputDeadzone and MoveDirection and MoveDirection or u2.direction, workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1), BodyFacingConfig);

        if u7 then
            local v47 = GearCatalog.get("Adrenaline");

            if v47 and (v47.Burst and os.clock() - u7 < 0.5) then
                local v48;

                if MoveDirection.Magnitude > u1.InputDeadzone then
                    v48 = MoveDirection;
                else
                    v48 = u2.direction;
                end;

                if v48.Magnitude < 0.01 then
                    v48 = HumanoidRootPart.CFrame.LookVector;
                end;

                MovementModel.carry(u2, math.max(u2.speed, Magnitude) + v47.Burst, v48, v47.BurstSeconds);
            end;

            u7 = nil;
        end;

        local mode = u2.mode;
        local math_min_ret = math.min(u2.speed, Magnitude);
        MovementModel.step(u2, MoveDirection, Magnitude, p17, u1, Humanoid.FloorMaterial ~= Enum.Material.Air, v43, v46, v18, AssemblyLinearVelocity, v20);

        if u2.mode == "Braking" and mode ~= "Braking" then
            script_Parent:SetAttribute("MovementStopEntrySpeed", math_min_ret);
        end;

        script_Parent:SetAttribute("FacingPaceMultiplier", v46);
        Humanoid.WalkSpeed = u2.outputSpeed;
        Humanoid:Move(u2.outputDirection, false);

        if u2.mode == "Dashing" or u2.mode == "Boosting" then
            local v49 = u2.outputDirection * u2.outputSpeed;
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v49.X, HumanoidRootPart.AssemblyLinearVelocity.Y, v49.Z);
        end;
    end;

    local v50 = v39 and "Locked" or u2.mode;

    if v50 ~= u16 then
        if v50 == "Boosting" or v50 == "Dashing" then
            script_Parent:SetAttribute("DashFromDirection", u2.dashFromDirection);
            script_Parent:SetAttribute("DashToDirection", u2.dashDirection);
            script_Parent:SetAttribute("DashAnimationSequence", u2.dashCount);
            BoostRequest:FireServer(u2.dashFromDirection, u2.dashDirection);
        end;

        u16 = v50;
        script_Parent:SetAttribute("BoostRecoveryUntil", os.clock() + u2.recoveryRemaining);
        script_Parent:SetAttribute("MovementState", v50);
    end;

    u14 = u14 + p17;

    if u14 >= 0.1 or u2.dashCount ~= u15 then
        u15 = u2.dashCount;
        u14 = 0;
        script_Parent:SetAttribute("MovementSpeed", u2.outputSpeed);
        script_Parent:SetAttribute("DashCount", u2.dashCount);
        local v51 = not (v39 or v37) and MovementModel.canBoost(u2, u1, Humanoid.FloorMaterial ~= Enum.Material.Air);
        script_Parent:SetAttribute("DashReady", v51);
        script_Parent:SetAttribute("BoostRecoveryUntil", os.clock() + u2.recoveryRemaining);
        script_Parent:SetAttribute("DashCooldown", u2.cooldown);
        script_Parent:SetAttribute("DashCooldownUntil", os.clock() + u2.cooldown);
        script_Parent:SetAttribute("LastDashDistance", u2.lastDashDistance);
        script_Parent:SetAttribute("LastDashEntrySpeed", u2.lastDashEntrySpeed);
    end;
end);