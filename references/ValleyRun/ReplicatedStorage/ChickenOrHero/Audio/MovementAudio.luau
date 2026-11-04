 

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage.ChickenOrHero;
local AudioPolicy = require(script.Parent.AudioPolicy);
local AnimationConfig = require(ChickenOrHero.Animation.AnimationConfig);
local MovementProfiles = require(ChickenOrHero.Movement.MovementProfiles);
local LocalLocomotion = require(ChickenOrHero.Animation.LocalLocomotion);
local u1 = {};
u1.__index = u1;
local CollectionService = game:GetService("CollectionService");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.RespectCanCollide = false;
local u2 = 0;

local function refreshPuddles() -- Line: 16
    -- upvalues: CollectionService (copy), u2 (ref), RaycastParams_new_ret (copy)
    local Tagged = CollectionService:GetTagged("FootstepPuddle");
    u2 = #Tagged;
    RaycastParams_new_ret.FilterDescendantsInstances = Tagged;
end;

CollectionService:GetInstanceAddedSignal("FootstepPuddle"):Connect(refreshPuddles);
CollectionService:GetInstanceRemovedSignal("FootstepPuddle"):Connect(refreshPuddles);
local Tagged = CollectionService:GetTagged("FootstepPuddle");
u2 = #Tagged;
RaycastParams_new_ret.FilterDescendantsInstances = Tagged;

local function inPuddle(p3) -- Line: 23
    -- upvalues: u2 (ref), RaycastParams_new_ret (copy)
    local v4;

    if u2 > 0 then
        v4 = workspace:Raycast(p3.Position, Vector3.new(0, -6, 0), RaycastParams_new_ret) ~= nil;
    else
        v4 = false;
    end;

    return v4;
end;

local u5 = {};

for _, v in { "Walk", "Run", "Left", "Right", "Back" } do
    u5["CoH_" .. v] = true;
    u5[AnimationConfig.PublishedIds[v]] = true;
end;

function u1.new(p6, p7) -- Line: 28
    -- upvalues: u1 (copy)
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.RespectCanCollide = true;

    return setmetatable({
        playback = p6,
        cfg = p7,
        records = {},
        params = RaycastParams_new_ret2
    }, u1);
end;

function u1.remove(p8, p9) -- Line: 32
    local v10 = p8.records[p9];

    if not v10 then
        return;
    end;

    local CoHAudioEmitter = v10.root:FindFirstChild("CoHAudioEmitter");

    if CoHAudioEmitter then
        CoHAudioEmitter:Destroy();
    end;

    p8.records[p9] = nil;
end;

function u1.newRecord(p11, p12, p13, p14, p15) -- Line: 37
    -- upvalues: LocalPlayer (copy)
    p11:remove(p12);
    local v16 = {
        wasMoving = false,
        wasGrounded = true,
        airTime = 0,
        fallSpeed = 0,
        stepDistance = 0,
        lastStep = (-1 / 0),
        lastJump = false,
        character = p13,
        root = p14,
        h = p15,
        lastPosition = p14.Position,
        reset = p13:GetAttribute("MovementReset"),
        lastMode = p13:GetAttribute("MovementState"),
        lastAction = p13:GetAttribute("AnimationAction"),
        dashCount = p13:GetAttribute("DashCount") or 0,
        tackleStarted = p13:GetAttribute("TackleStartedAt"),
        lastReady = p13:GetAttribute("DashReady"),
        health = p15.Health
    };
    p11.records[p12] = v16;

    if p12 == LocalPlayer then
        p11.playback:one("Respawn");
    end;

    return v16;
end;

function u1.step(p17, p18, p19, p20, p21, p22) -- Line: 48
    -- upvalues: u2 (ref), RaycastParams_new_ret (copy), LocalPlayer (copy)
    if p22 - p18.lastStep < p17.cfg.MinStepInterval then
        return;
    end;

    local root = p18.root;
    local v23;

    if u2 > 0 then
        v23 = workspace:Raycast(root.Position, Vector3.new(0, -6, 0), RaycastParams_new_ret) ~= nil;
    else
        v23 = false;
    end;

    local v24;

    if v23 then
        v24 = "FootstepPuddle" .. math.random(1, 4);
    else
        v24 = "Footstep" .. p20;
    end;

    if not p17.playback:template(v24) then
        v24 = "Footstep" .. p17.cfg.DefaultSurface;
    end;

    local v25;

    if p19 == LocalPlayer then
        v25 = nil;
    else
        v25 = p18.root or nil;
    end;

    p17.playback:one(v24, v25, p21, 1 + (math.random() - 0.5) * 0.08);
    p18.lastStep = p22;
end;

function u1.update(p26, p27) -- Line: 55
    -- upvalues: Players (copy), LocalPlayer (copy), MovementProfiles (copy), LocalLocomotion (copy), AnimationConfig (copy), u5 (copy), AudioPolicy (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local cfg = p26.cfg;
    local playback = p26.playback;
    local v28 = {};
    local v29 = {};

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v30;

        if Character then
            v30 = Character:FindFirstChild("HumanoidRootPart");
        else
            v30 = Character;
        end;

        local v31;

        if Character then
            v31 = Character:FindFirstChildOfClass("Humanoid");
        else
            v31 = Character;
        end;

        if Character then
            table.insert(v28, Character);
        end;

        if v30 and v31 then
            local Magnitude = (v30.Position - workspace_CurrentCamera.CFrame.Position).Magnitude;

            if v == LocalPlayer or Magnitude <= cfg.RemoteActionDistance then
                table.insert(v29, {
                    p = v,
                    c = Character,
                    root = v30,
                    h = v31,
                    distance = v == LocalPlayer and -1 or Magnitude
                });
            end;
        end;
    end;

    table.sort(v29, function(p32, p33) -- Line: 67
        return p32.distance < p33.distance;
    end);
    p26.params.FilterDescendantsInstances = v28;
    local v34 = {};
    local v35 = false;
    local v36 = 0;

    for i, v in v29 do
        if cfg.MaxNearbyCharacters < i then
            break;
        end;

        local p = v.p;
        local c = v.c;
        local root = v.root;
        local h = v.h;
        v34[p] = true;
        local v37 = p == LocalPlayer;
        local v38 = p26.records[p];

        if not (v38 and (v38.character == c and v38.root == root)) then
            v38 = p26:newRecord(p, c, root, h);
        end;

        local os_clock_ret = os.clock();
        local ServerTimeNow = workspace:GetServerTimeNow();
        local MaxSpeed = MovementProfiles.get(p:GetAttribute("GameRole"), p).MaxSpeed;
        local AssemblyLinearVelocity = root.AssemblyLinearVelocity;
        local Magnitude = (AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;
        local Attribute = c:GetAttribute("MovementReset");
        local v39 = (root.Position - v38.lastPosition).Magnitude > math.max(8, MaxSpeed * p27 * 3);
        v38.lastPosition = root.Position;

        if Attribute ~= v38.reset or v39 then
            v38.reset = Attribute;
            v38.stepDistance = 0;
            v38.track = nil;
            v38.phase = nil;
            v38.airTime = 0;
            v38.fallSpeed = 0;
            v38.wasMoving = false;
            v38.usedBoost = false;
            v38.usedCatch = false;
            v38.silentUntil = os_clock_ret + 0.2;
        end;

        local v40 = os_clock_ret < (v38.silentUntil or 0);
        local v41 = c:GetAttribute("TackleActive") == true;
        local Attribute2 = c:GetAttribute("TackleStartedAt");

        if Attribute2 and Attribute2 ~= v38.tackleStarted then
            v38.tackleStarted = Attribute2;
            v38.diveLanded = false;
            v38.usedCatch = v37;

            if not c:GetAttribute("DaggerEquipped") then
                local v42;

                if v37 or not root then
                    v42 = nil;
                else
                    v42 = root;
                end;

                playback:one("DiveStart", v42, v37 and 1 or cfg.RemoteMovementGain);
            end;
        end;

        if v41 and (Attribute2 and (not v38.diveLanded and ServerTimeNow - Attribute2 >= (c:GetAttribute("TackleDuration") or 0.4))) then
            v38.diveLanded = true;
            local v43;

            if v37 or not root then
                v43 = nil;
            else
                v43 = root;
            end;

            playback:one("DiveLand", v43, v37 and 1 or cfg.RemoteMovementGain);
            local v44;

            if v37 or not root then
                v44 = nil;
            else
                v44 = root;
            end;

            playback:one("DiveRecover", v44, v37 and 1 or cfg.RemoteMovementGain);
        end;

        if v37 and (v38.usedCatch and not (v41 or (p:GetAttribute("RunState") ~= "Active" or (p:GetAttribute("TackleReadyAt") or (1 / 0)) > ServerTimeNow))) then
            playback:one("CatchReady");
            v38.usedCatch = false;
        end;

        local Attribute3 = c:GetAttribute("MovementState");
        local Attribute4 = c:GetAttribute("AnimationAction");
        local State = h:GetState();
        local v45;

        if State == Enum.HumanoidStateType.Swimming or State == Enum.HumanoidStateType.Climbing then
            v45 = false;
        else
            v45 = State ~= Enum.HumanoidStateType.Physics;
        end;

        if v45 then
            if h.Health > 0 then
                v45 = not (root.Anchored or h.Sit or (h.PlatformStand or c:GetAttribute("MovementLocked"))) and (not v41 and not v40);
            else
                v45 = false;
            end;
        end;

        p26.params.CollisionGroup = root.CollisionGroup;
        local v46;

        if v45 then
            v46 = workspace:Raycast(root.Position, Vector3.new(0, -4.5, 0), p26.params);
        else
            v46 = v45;
        end;

        local v47 = (h.FloorMaterial ~= Enum.Material.Air or not (v37 or (not v46 or root.Position.Y - v46.Position.Y > 3.65))) and true or false;

        if v37 then
            local v48 = c:GetAttribute("DashCount") or 0;

            if v38.dashCount < v48 and v45 then
                playback:one("BoostStart");
                v38.usedBoost = true;
            end;

            v38.dashCount = v48;

            if Attribute3 == "Recovering" and (v38.lastMode ~= "Recovering" and v45) then
                playback:one("BoostRecovery");
            end;

            local v49 = c:GetAttribute("DashReady") == true;

            if v49 and (not v38.lastReady and (v38.usedBoost and v45)) then
                playback:one("BoostReady");
                v38.usedBoost = false;
            end;

            v38.lastReady = v49;

            if Attribute4 == "Stop" and (v38.lastAction ~= "Stop" and v45) then
                playback:one("RunStop");
            end;

            if h.Health <= 0 and v38.health > 0 then
                playback:one("Death");
            end;

            local v50 = h:GetState() == Enum.HumanoidStateType.Jumping;

            if v50 and (not v38.lastJump and v45) then
                playback:one("Jump");
            end;

            v38.lastJump = v50;

            if v45 and not v47 then
                v38.airTime = v38.airTime + p27;
                v38.fallSpeed = math.max(v38.fallSpeed, -AssemblyLinearVelocity.Y);
            elseif v47 and not v38.wasGrounded then
                if v45 and v38.airTime >= cfg.MinFallTime then
                    playback:one(v38.fallSpeed >= cfg.HardLandingSpeed and playback:template("LandHard") and "LandHard" or "LandSoft");
                end;

                v38.airTime = 0;
                v38.fallSpeed = 0;
            elseif not v45 then
                v38.airTime = 0;
                v38.fallSpeed = 0;
            end;
        end;

        if v45 then
            if v47 then
                if cfg.MinStepSpeed <= Magnitude then
                    v45 = Attribute4 ~= "Stop";
                else
                    v45 = false;
                end;
            else
                v45 = v47;
            end;
        end;

        local v51 = nil;
        local v52 = 0;
        local v53 = false;
        local v54;

        if v45 then
            local v55 = LocalLocomotion.animatorFor(c) or h:FindFirstChildOfClass("Animator");

            if v55 then
                v54 = v;

                for _, v2 in v55:GetPlayingAnimationTracks() do
                    local v56 = v2.Animation and v2.Animation.AnimationId;

                    if v2.Name == "CoH_Stop" or v56 == AnimationConfig.PublishedIds.Stop then
                        v53 = v2.WeightCurrent > 0.2 and true or v53;
                    end;

                    if (u5[v2.Name] or u5[v56]) and (v2.Length > 0 and v52 < v2.WeightCurrent) then
                        v52 = v2.WeightCurrent;
                        v51 = v2;
                    end;
                end;
            else
                v54 = v;
            end;
        else
            v54 = v;
        end;

        if v45 then
            v45 = not v53;
        end;

        if v37 then
            if v45 and not (v38.wasMoving or ((v38.lastSpeed or 0) >= cfg.MinStepSpeed or v40)) then
                playback:one("MovementStart");
            end;

            if v45 and (MaxSpeed * 0.5 <= Magnitude and (Attribute3 ~= "Boosting" and Attribute3 ~= "Dashing")) then
                local Unit = (AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Unit;

                if v38.direction and (Unit:Dot(v38.direction) < 0.25881904510252074 and os_clock_ret - (v38.turnAt or 0) > 0.6) then
                    playback:one("SharpTurn");
                    v38.turnAt = os_clock_ret;
                end;

                v38.direction = Unit;
            else
                v38.direction = nil;
            end;

            v36 = math.clamp(Magnitude / MaxSpeed, 0, 1.3);
            v35 = v45;
        end;

        if v45 and (v37 or v54.distance <= cfg.RemoteFootstepDistance) then
            local v57 = v46 and v46.Material or h.FloorMaterial;

            if v46 then
                v46 = v46.Instance;
            end;

            local v58 = AudioPolicy.surface(v57, v46, cfg);
            local v59 = (v37 and 1 or cfg.RemoteFootstepGain) * math.clamp(0.6 + Magnitude / MaxSpeed * 0.4, 0.6, 1);

            if v51 and v52 > 0.1 then
                local v60 = v51.TimePosition / v51.Length % 1;

                if v38.track == v51 and AudioPolicy.crossed(v38.phase, v60, cfg.FootstepPhases) then
                    p26:step(v38, p, v58, v59, os_clock_ret);
                end;

                v38.track = v51;
                v38.phase = v60;
                v38.stepDistance = 0;
            else
                v38.track = nil;
                v38.phase = nil;
                v38.stepDistance = v38.stepDistance + Magnitude * p27;

                if v38.stepDistance >= cfg.FallbackStepDistance then
                    v38.stepDistance = v38.stepDistance % cfg.FallbackStepDistance;
                    p26:step(v38, p, v58, v59, os_clock_ret);
                end;
            end;
        else
            v38.track = nil;
            v38.phase = nil;
            v38.stepDistance = 0;
        end;

        v38.lastMode = Attribute3;
        v38.lastAction = Attribute4;
        v38.health = h.Health;
        v38.wasMoving = v45;
        v38.wasGrounded = v47;
        v38.lastSpeed = Magnitude;
    end;

    playback:loop("Clothes", v35 and "ClothesRustle" or nil, nil, v36 * 0.5 + 0.5, (math.clamp(v36, 0.7, 1.2)));
    playback:loop("Wind", v35 and "SprintWind" or nil, nil, math.clamp((v36 - 0.7) / 0.3, 0, 1), 1);

    for i in p26.records do
        if not v34[i] then
            p26:remove(i);
        end;
    end;
end;

function u1.destroy(p61) -- Line: 167
    for i in p61.records do
        p61:remove(i);
    end;

    p61.playback:loop("Clothes", nil);
    p61.playback:loop("Wind", nil);
end;

return u1;