 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local GameAction = ChickenOrHero.Game.GameAction;
local Tackle = require(ChickenOrHero.Game.GameConfig).Tackle;
local TacklePredictionConfig = require(ChickenOrHero.Game.TacklePredictionConfig);
local TackleProfile = require(ChickenOrHero.Game.TackleProfile);
local TackleMotion = require(ChickenOrHero.Game.TackleMotion);
local TackleCollision = require(ChickenOrHero.Game:WaitForChild("TackleCollision"));
local MovementProfiles = require(ChickenOrHero.Movement.MovementProfiles);
local TackleAnimation = require(ChickenOrHero.Animation.TackleAnimation);
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local CombatPrediction = require(ChickenOrHero.Game:WaitForChild("CombatPrediction"));
local HitReplayMath = require(ChickenOrHero.Game.HitReplayMath);
local BossCombat = require(ChickenOrHero.Game.BossCombat);
CombatPrediction.start();
local u1 = {};
local u2 = nil;
local u3 = 0;

local function finish(p4) -- Line: 26
    -- upvalues: u2 (ref), CombatPrediction (copy), TackleAnimation (copy)
    local v5 = u2;

    if not v5 then
        return;
    end;

    u2 = nil;
    CombatPrediction.cancel(v5.id);

    for _, v in { v5.orientation, v5.velocity, v5.attachment } do
        if v then
            v:Destroy();
        end;
    end;

    if v5.character.Parent then
        v5.character:SetAttribute("TackleActive", false);
        v5.character:SetAttribute("TacklePredictionId", nil);
    end;

    if not p4 then
        TackleAnimation.stop(v5.character);
    end;

    if v5.h.Parent then
        v5.h.AutoRotate = v5.autoRotate;
    end;
end;

function u1.remaining() -- Line: 49
    -- upvalues: u3 (ref), LocalPlayer (copy)
    local v6 = u3 - workspace:GetServerTimeNow();
    local v7 = (LocalPlayer:GetAttribute("TackleReadyAt") or 0) - workspace:GetServerTimeNow();

    return math.max(0, v6, v7);
end;

local function startMotion(p8) -- Line: 56
    -- upvalues: TackleCollision (copy), TackleMotion (copy), TackleAnimation (copy)
    local character = p8.character;
    local h = p8.h;
    local root = p8.root;
    local cfg = p8.cfg;
    local direction = p8.direction;
    local started = p8.started;
    local id = p8.id;
    p8.attachment = Instance.new("Attachment");
    p8.attachment.Name = "LocalTackleMotion";
    p8.attachment.Parent = root;
    p8.velocity = Instance.new("LinearVelocity");
    p8.velocity.Name = "LocalTackleVelocity";
    p8.velocity.Attachment0 = p8.attachment;
    p8.velocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    p8.velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    p8.velocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    p8.velocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    p8.collision = TackleCollision.new(character);
    p8.velocity.PlaneVelocity = Vector2.new(direction.X, direction.Z) * TackleCollision.limit(p8.collision, root, direction, TackleMotion.speed(cfg, 0, 0.016666666666666666), 0.016666666666666666);
    p8.velocity.ForceLimitsEnabled = true;
    p8.velocity.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    p8.velocity.MaxForce = math.max(1, root.AssemblyMass) * 4000;
    p8.velocity.Parent = root;
    p8.orientation = Instance.new("AlignOrientation");
    p8.orientation.Name = "LocalTackleFacing";
    p8.orientation.Attachment0 = p8.attachment;
    p8.orientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    p8.orientation.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), direction);
    p8.orientation.MaxTorque = 1000000;
    p8.orientation.MaxAngularVelocity = 25;
    p8.orientation.Responsiveness = 35;
    p8.orientation.Parent = root;
    character:SetAttribute("TacklePredictionId", id);
    character:SetAttribute("TackleActive", true);
    character:SetAttribute("TackleVariant", cfg.Name);
    character:SetAttribute("TackleStartedAt", started);
    character:SetAttribute("TackleDirection", direction);
    character:SetAttribute("TackleDuration", cfg.Duration);
    character:SetAttribute("TackleRecovery", cfg.Recovery);
    h.AutoRotate = false;
    h.WalkSpeed = 0;
    h:Move(Vector3.new(0, 0, 0), false);
    TackleAnimation.play(character, cfg.Animation, cfg.Duration + cfg.Recovery);
end;

function u1.request() -- Line: 97
    -- upvalues: LocalPlayer (copy), u2 (ref), u1 (copy), BossCombat (copy), ControlGate (copy), TackleProfile (copy), Tackle (copy), MovementProfiles (copy), u3 (ref), GameAction (copy), startMotion (copy), CombatPrediction (copy), HitReplayMath (copy)
    local Character = LocalPlayer.Character;
    local v9;

    if Character then
        v9 = Character:FindFirstChildOfClass("Humanoid");
    else
        v9 = Character;
    end;

    local v10;

    if Character then
        v10 = Character:FindFirstChild("HumanoidRootPart");
    else
        v10 = Character;
    end;

    if u2 or (u1.remaining() > 0.02 or not (v10 and (v9 and (v9.Health > 0 and not (v10.Anchored or (v9.Sit or (v9.PlatformStand or (v9.FloorMaterial == Enum.Material.Air or (Character:GetAttribute("MovementLocked") or (Character:GetAttribute("TackleActive") or (Character:GetAttribute("GearMotion") or (v10:FindFirstChild("PredictedRocketVelocity") or Character:GetAttribute("DaggerEquipped") and Character:GetAttribute("DaggerState") ~= "Held")))))))))))) or not (BossCombat.attacker(LocalPlayer) and (LocalPlayer:GetAttribute("RunState") == "Active" and not ControlGate.reason(LocalPlayer))) then
        return false;
    end;

    local v11 = v10.CFrame.LookVector * Vector3.new(1, 0, 1);

    if v11.Magnitude < 0.01 then
        return false;
    end;

    local Unit = v11.Unit;
    local Magnitude = (v10.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;
    local v12 = TackleProfile.select(Tackle, Magnitude, MovementProfiles.get("Catcher", LocalPlayer).MaxSpeed);
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v13 = game.HttpService:GenerateGUID(false);
    local v14 = {
        elapsed = 0,
        confirmed = false,
        character = Character,
        h = v9,
        root = v10,
        cfg = v12,
        direction = Unit,
        started = ServerTimeNow,
        requestedAt = ServerTimeNow,
        id = v13,
        version = Character:GetAttribute("MovementReset"),
        autoRotate = v9.AutoRotate
    };
    u2 = v14;
    u3 = ServerTimeNow + v12.Cooldown;
    GameAction:FireServer("Tackle", {
        id = v13,
        at = ServerTimeNow,
        speed = Magnitude,
        direction = Unit,
        position = v10.Position
    });
    startMotion(v14);
    CombatPrediction.begin({
        kind = "Tackle",
        predicted = true,
        id = v13,
        character = Character,
        startedAt = ServerTimeNow,
        starts = ServerTimeNow,
        ends = ServerTimeNow + v12.Duration,
        direction = Unit,
        box = HitReplayMath.bounds("Tackle", v12)
    });

    return true;
end;

function u1.isActive(p15) -- Line: 164
    -- upvalues: u2 (ref)
    local v16;

    if u2 == nil then
        v16 = false;
    else
        v16 = u2.character == p15;
    end;

    return v16;
end;

GameAction.OnClientEvent:Connect(function(p17, p18, p19, p20) -- Line: 167
    -- upvalues: u2 (ref), u3 (ref), finish (copy), TackleProfile (copy), Tackle (copy), MovementProfiles (copy), LocalPlayer (copy), CombatPrediction (copy), HitReplayMath (copy)
    local v21 = u2;

    if not v21 or v21.id ~= p18 then
        return;
    end;

    if p17 ~= "TackleResult" then
        if p17 == "TackleEnded" then
            finish(p19 == true);
        end;

        return;
    end;

    if p19 then
        v21.confirmed = true;

        if type(p20) == "table" then
            u3 = p20.readyAt or u3;

            if type(p20.speed) == "number" then
                v21.cfg = TackleProfile.select(Tackle, p20.speed, MovementProfiles.get("Catcher", LocalPlayer).MaxSpeed);
            end;

            v21.started = type(p20.startedAt) == "number" and p20.startedAt or workspace:GetServerTimeNow();
        else
            v21.started = workspace:GetServerTimeNow();
        end;

        CombatPrediction.reconcile(p18, true, {
            startedAt = v21.started,
            starts = v21.started,
            ends = v21.started + v21.cfg.Duration,
            direction = v21.direction,
            box = HitReplayMath.bounds("Tackle", v21.cfg)
        });

        return;
    end;

    local v22 = type(p20) == "table" and p20.readyAt or 0;
    local v23 = workspace:GetServerTimeNow() + 0.5;
    u3 = math.max(v22, v23);
    finish(false);
end);
RunService.PreSimulation:Connect(function(p24) -- Line: 200
    -- upvalues: u2 (ref), LocalPlayer (copy), BossCombat (copy), finish (copy), TacklePredictionConfig (copy), u3 (ref), TackleCollision (copy), TackleMotion (copy)
    local v25 = u2;

    if not v25 then
        return;
    end;

    local character = v25.character;
    local h = v25.h;
    local root = v25.root;

    if LocalPlayer.Character ~= character or not (character.Parent and (root.Parent and (h.Health > 0 and not (root.Anchored or (h.Sit or (h.PlatformStand or (character:GetAttribute("MovementLocked") or (character:GetAttribute("MovementReset") ~= v25.version or (not BossCombat.attacker(LocalPlayer) or LocalPlayer:GetAttribute("RunState") ~= "Active"))))))))) then
        finish(false);

        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if not v25.confirmed and ServerTimeNow - v25.requestedAt > TacklePredictionConfig.ConfirmTimeout then
        u3 = ServerTimeNow + 0.5;
        finish(false);

        return;
    end;

    if ServerTimeNow - v25.started >= v25.cfg.Duration + v25.cfg.Recovery then
        finish(true);

        return;
    end;

    character:SetAttribute("TackleActive", true);
    local v26 = TackleCollision.limit(v25.collision, root, v25.direction, TackleMotion.speed(v25.cfg, v25.elapsed, p24), p24);
    v25.elapsed = v25.elapsed + p24;
    v25.velocity.PlaneVelocity = Vector2.new(v25.direction.X, v25.direction.Z) * v26;
    h.WalkSpeed = 0;
    h:Move(Vector3.new(0, 0, 0), false);
end);

local function prepare(p27) -- Line: 243
    -- upvalues: TackleAnimation (copy)
    local Humanoid = p27:WaitForChild("Humanoid", 10);

    if not Humanoid then
        return;
    end;

    if Humanoid:WaitForChild("Animator", 10) and p27.Parent then
        TackleAnimation.prepare(p27);
    end;
end;

LocalPlayer.CharacterAdded:Connect(function(p28) -- Line: 253
    -- upvalues: u2 (ref), finish (copy), prepare (copy)
    if u2 then
        finish(false);
    end;

    task.spawn(prepare, p28);
end);
LocalPlayer.CharacterRemoving:Connect(function(p29) -- Line: 259
    -- upvalues: u2 (ref), finish (copy)
    if u2 and u2.character == p29 then
        finish(false);
    end;
end);

if LocalPlayer.Character then
    task.spawn(prepare, LocalPlayer.Character);
end;

return u1;