 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local AbilityRule = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("AbilityRule"));
local Assets = ChickenOrHero.Gear:WaitForChild("Assets");
local GearEvent = ChickenOrHero.Gear:WaitForChild("GearEvent");
local AirhornCone = require(ChickenOrHero.Gear:WaitForChild("AirhornCone"));
local GearCatalog = require(ChickenOrHero.Gear:WaitForChild("GearCatalog"));
local ClientBots = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots;
local u1 = {
    FX = Instance.new("BindableEvent"),
    Cancel = Instance.new("BindableEvent")
};
local Folder = Instance.new("Folder");
Folder.Name = "PredictedGearPresentation";
Folder.Parent = workspace;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {
    BananaPeel = 15.75,
    PocketDoor = 6,
    BowlingBall = 2,
    RufusLeash = 0.45,
    BearTrap = 0.9 + GearCatalog.Items.BearTrap.TrapDuration,
    SpringBox = 0.9 + GearCatalog.Items.SpringBox.TrapDuration,
    PumpkinBomb = GearCatalog.Items.PumpkinBomb.FlightSeconds,
    PumpkinBombChaser = GearCatalog.Items.PumpkinBomb.FlightSeconds
};
local u8 = {
    BowlingBall = 42,
    RufusLeash = 65
};
local u9 = {
    BananaPeel = "BananaThrow",
    RescueKit = "Rescue",
    Adrenaline = "Adrenaline",
    EmergencyAirhorn = "Airhorn",
    RocketShoes = "Rocket",
    InflatableDecoy = "DecoyInflate",
    PocketDoor = "DoorSlam",
    RufusLeash = "LeashThrow",
    BowlingBall = "BowlingUse",
    BearTrap = "BearTrapThrow",
    SpringBox = "SpringBoxThrow",
    PumpkinBomb = "PumpkinBombThrow",
    PumpkinBombChaser = "PumpkinBombThrow"
};
local u10 = {
    BananaPeel = true,
    BearTrap = true,
    SpringBox = true,
    PumpkinBomb = true,
    PumpkinBombChaser = true
};

local function flat(p11) -- Line: 54
    local v12 = p11 * Vector3.new(1, 0, 1);

    return v12.Magnitude > 0.01 and v12.Unit or Vector3.new(0, 0, 1);
end;

local function count(p13) -- Line: 58
    local v14 = 0;

    for _ in p13 do
        v14 = v14 + 1;
    end;

    return v14;
end;

local function params() -- Line: 65
    -- upvalues: Folder (copy), Players (copy), CollectionService (copy), ClientBots (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    local v15 = { Folder };

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v15, v.Character);
        end;
    end;

    for _, v in CollectionService:GetTagged("PredictedGearVisual") do
        table.insert(v15, v);
    end;

    local v16 = ClientBots and workspace:FindFirstChild("ClientBots");

    if v16 then
        table.insert(v15, v16);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v15;

    return RaycastParams_new_ret;
end;

local function pivot(p17) -- Line: 85
    return p17:IsA("Model") and p17:GetPivot() or p17.CFrame;
end;

local function move(p18, p19) -- Line: 88
    if p18:IsA("Model") then
        p18:PivotTo(p19);

        return;
    end;

    p18.CFrame = p19;
end;

local function descendants(p20) -- Line: 95
    local Descendants = p20:GetDescendants();
    table.insert(Descendants, p20);

    return Descendants;
end;

local function cloneVisual(u21) -- Line: 100
    -- upvalues: CollectionService (copy), Folder (copy)
    if not u21 then
        return;
    end;

    local Archivable = u21.Archivable;
    u21.Archivable = true;
    local success, result = pcall(function() -- Line: 106
        -- upvalues: u21 (copy)
        return u21:Clone();
    end);
    u21.Archivable = Archivable;

    if success and result then
        local Descendants = result:GetDescendants();
        table.insert(Descendants, result);

        for _, v in Descendants do
            local v22 = v;

            for _, v2 in CollectionService:GetTags(v) do
                CollectionService:RemoveTag(v22, v2);
            end;

            if v22:IsA("LuaSourceContainer") or (v22:IsA("Sound") or (v22:IsA("ProximityPrompt") or v22:IsA("ForceField"))) then
                v22:Destroy();
            elseif v22:IsA("BasePart") then
                v22.Anchored = true;
                v22.CanCollide = false;
                v22.CanTouch = false;
                v22.CanQuery = false;
                v22.Massless = true;
                v22.LocalTransparencyModifier = 0;
            elseif v22:IsA("Humanoid") then
                v22.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                v22.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
            end;
        end;

        result.Name = "PredictedVisual";
        result.Parent = Folder;

        return result;
    end;
end;

local function restore(p23) -- Line: 135
    for i, v in p23.hidden or {} do
        if i.Parent then
            if i:IsA("BasePart") then
                i.LocalTransparencyModifier = v;
            elseif i:IsA("Decal") or i:IsA("Texture") then
                i.Transparency = v;
            else
                i.Enabled = v;
            end;
        end;
    end;

    if p23.added then
        p23.added:Disconnect();
    end;
end;

local function remove(p24) -- Line: 151
    -- upvalues: restore (copy), u2 (copy)
    if p24.proxy then
        p24.proxy:Destroy();
    end;

    restore(p24);

    if u2[p24.id] == p24 then
        u2[p24.id] = nil;
    end;
end;

local function removeSides(p25, p26) -- Line: 161
    -- upvalues: u2 (copy), restore (copy)
    for i, v in u2 do
        if string.sub(i, 1, #p25 + 1) == p25 .. "#" and not (p26 and v.server) then
            if v.proxy then
                v.proxy:Destroy();
            end;

            restore(v);

            if u2[v.id] == v then
                u2[v.id] = nil;
            end;
        end;
    end;
end;

local function hide(u27, p28) -- Line: 168
    u27.hidden = {};
    local Descendants = p28:GetDescendants();
    table.insert(Descendants, p28);

    local function one(p29) -- Line: 170
        -- upvalues: u27 (copy)
        if u27.hidden[p29] ~= nil then
            return;
        end;

        if p29:IsA("BasePart") then
            u27.hidden[p29] = p29.LocalTransparencyModifier;
            p29.LocalTransparencyModifier = 1;

            return;
        end;

        if not (p29:IsA("Decal") or p29:IsA("Texture")) then
            if p29:IsA("ParticleEmitter") or (p29:IsA("Trail") or (p29:IsA("Beam") or (p29:IsA("Light") or p29:IsA("BillboardGui")))) then
                u27.hidden[p29] = p29.Enabled;
                p29.Enabled = false;
            end;

            return;
        end;

        u27.hidden[p29] = p29.Transparency;
        p29.Transparency = 1;
    end;

    for _, v in Descendants do
        one(v);
    end;

    u27.added = p28.DescendantAdded:Connect(one);
end;

local function plan(p30, p31) -- Line: 196
    -- upvalues: LocalPlayer (copy), params (copy), u10 (copy), Assets (copy), GearCatalog (copy)
    local Character = LocalPlayer.Character;
    local v32;

    if Character then
        v32 = Character:FindFirstChild("HumanoidRootPart");
    else
        v32 = Character;
    end;

    if not v32 then
        return;
    end;

    local v33 = v32.CFrame.LookVector * Vector3.new(1, 0, 1);
    local v34 = v33.Magnitude > 0.01 and v33.Unit or Vector3.new(0, 0, 1);

    if p30 == "RocketShoes" and typeof(p31) == "Vector3" then
        local v35 = p31 * Vector3.new(1, 0, 1);
        v34 = v35.Magnitude > 0.01 and v35.Unit or Vector3.new(0, 0, 1);
    end;

    local v36 = {
        item = p30,
        origin = v32.Position,
        direction = v34
    };
    local v37 = params();

    if u10[p30] then
        local v38 = Assets:FindFirstChild(p30);

        if not (v38 and (v38:IsA("BasePart") or v38:IsA("Model"))) then
            return;
        end;

        local v39 = GearCatalog.Items[p30] and (GearCatalog.Items[p30].ThrowRange or 10) or 10;
        local v40 = nil;

        for _, v in GearCatalog.throwReaches(p30, v32.AssemblyLinearVelocity * Vector3.new(1, 0, 1), v34) do
            local v41 = v32.Position + v32.CFrame.LookVector * v;
            v40 = not workspace:Raycast(v32.Position, v41 - v32.Position, v37) and workspace:Raycast(v41, Vector3.new(0, -8, 0), v37);

            if v40 and v40.Normal.Y >= 0.65 then
                v39 = v;
                break;
            end;
        end;

        if not v40 or v40.Normal.Y < 0.65 then
            return;
        end;

        v36.hand = Character:FindFirstChild("RightHand") or (Character:FindFirstChild("Right Arm") or v32);
        v36.origin = v36.hand.Position - v36.hand.CFrame.UpVector * v36.hand.Size.Y * 0.35;
        local v42 = v38:IsA("Model") and v38:GetExtentsSize().Y or v38.Size.Y;
        local v43 = v40.Position + v40.Normal * (v42 * 0.5 + 0.06);
        local v44 = v32.CFrame.LookVector - v40.Normal * v32.CFrame.LookVector:Dot(v40.Normal);
        v36.landing = CFrame.lookAt(v43, v43 + (v44.Magnitude < 0.01 and Vector3.new(0, 0, 1) or v44), v40.Normal);
        local v45 = GearCatalog.Items[p30];

        if v45 and (v45.Count or 1) > 1 then
            v36.sides = {};

            for i = 2, v45.Count do
                local v46;

                if i % 2 == 0 then
                    v46 = i // 2;
                else
                    v46 = -(i // 2);
                end;

                local v47 = CFrame.Angles(0, v46 * math.rad(v45.SpreadDegrees or 0), 0):VectorToWorldSpace(v32.CFrame.LookVector);
                local v48 = v32.Position + v47 * v39;
                local v49 = not workspace:Raycast(v32.Position, v48 - v32.Position, v37) and workspace:Raycast(v48, Vector3.new(0, -8, 0), v37);
                local v50;

                if v49 and v49.Normal.Y >= 0.65 then
                    local v51 = v49.Position + v49.Normal * (v42 * 0.5 + 0.06);
                    local v52 = v47 - v49.Normal * v47:Dot(v49.Normal);
                    v36.sides[v46] = CFrame.lookAt(v51, v51 + (v52.Magnitude < 0.01 and Vector3.new(0, 0, 1) or v52), v49.Normal);
                    v50 = i;
                else
                    v50 = i;
                end;
            end;

            return v36;
        end;
    else
        if p30 == "PocketDoor" then
            local v53 = workspace:Raycast(v32.Position + v34 * 5, Vector3.new(0, -9, 0), v37);

            if v53 and v53.Normal.Y >= 0.85 then
                v36.origin = v53.Position + Vector3.new(0, 3.8, 0);
                v36.cf = CFrame.lookAt(v36.origin, v36.origin + v34);

                return v36;
            end;

            return;
        end;

        if p30 == "BowlingBall" then
            local v54 = workspace:Raycast(v32.Position + v34 * 3, Vector3.new(0, -9, 0), v37);

            if v54 then
                v36.origin = v54.Position + Vector3.new(0, 1.05, 0);

                return v36;
            end;

            return;
        end;

        if p30 == "InflatableDecoy" then
            local v55 = v32.Position + v32.CFrame.RightVector * 2.7;
            local v56 = workspace:Raycast(v55, Vector3.new(0, -9, 0), v37);

            if not v56 then
                return;
            end;

            local v57 = workspace:Raycast(v32.Position, Vector3.new(0, -9, 0), v37);
            local X = v55.X;
            local Y = v56.Position.Y;
            local v58 = v57 and math.clamp(v32.Position.Y - v57.Position.Y, 2, 5) or 3;
            v36.origin = Vector3.new(X, Y + v58, v55.Z);
        end;
    end;

    return v36;
end;

local function build(p59, p60) -- Line: 281
    -- upvalues: u7 (copy), u2 (copy), cloneVisual (copy), Assets (copy), u8 (copy), u10 (copy)
    if u7[p59.item] then
        local v61 = 0;

        for _ in u2 do
            v61 = v61 + 1;
        end;

        if v61 < 64 then
            p59.proxy = cloneVisual(p60 or Assets:FindFirstChild(p59.item));

            if p59.proxy then
                p59.started = p59.started or workspace:GetServerTimeNow();
                p59.duration = u7[p59.item];
                p59.speed = u8[p59.item] or 0;
                p59.distance = 0;
                local v62 = (u10[p59.item] or p59.item == "RufusLeash") and (p59.proxy:IsA("BasePart") and p59.proxy or p59.proxy:FindFirstChildWhichIsA("BasePart", true));

                if v62 then
                    local v63 = p59.proxy:FindFirstChildWhichIsA("Trail", true);

                    if v63 then
                        p59.trail = v63;
                    else
                        local Attachment = Instance.new("Attachment");
                        Attachment.Position = Vector3.new(-0.2, 0, 0);
                        Attachment.Parent = v62;
                        local Attachment2 = Instance.new("Attachment");
                        Attachment2.Position = Vector3.new(0.2, 0, 0);
                        Attachment2.Parent = v62;
                        local Trail = Instance.new("Trail");
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.25;
                        Trail.Color = ColorSequence.new(p59.item == "BananaPeel" and Color3.fromRGB(255, 214, 90) or (p59.item == "BearTrap" and Color3.fromRGB(186, 192, 204) or p59.item == "SpringBox" and Color3.fromRGB(255, 70, 90) or ((p59.item == "PumpkinBomb" or p59.item == "PumpkinBombChaser") and Color3.fromRGB(255, 140, 40) or Color3.fromRGB(119, 229, 255))));
                        Trail.Transparency = NumberSequence.new(0.1, 1);
                        Trail.FaceCamera = true;
                        Trail.LightEmission = 0.85;
                        Trail.Parent = v62;
                        p59.trail = Trail;
                    end;
                end;

                local v64 = p59.item == "BowlingBall" and (p59.proxy:IsA("BasePart") and p59.proxy or p59.proxy:FindFirstChildWhichIsA("BasePart", true));

                if v64 then
                    local Sound = Instance.new("Sound");
                    Sound.Name = "BowlingRoll";
                    Sound.SoundId = "rbxassetid://9125752846";
                    Sound.Volume = 0.35;
                    Sound.RollOffMaxDistance = 100;
                    Sound.RollOffMinDistance = 7;
                    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
                    Sound.PlaybackSpeed = 3;
                    Sound.Looped = true;
                    Sound.Parent = v64;
                    Sound:Play();
                end;

                p59.position = p59.origin;
                p59.display = p59.cf or CFrame.lookAt(p59.origin, p59.origin + p59.direction);

                if p59.item == "PocketDoor" and p59.proxy:IsA("BasePart") then
                    p59.proxy.Size = Vector3.new(5.2, 7.2, 0.7);
                end;

                local proxy = p59.proxy;
                local display = p59.display;

                if proxy:IsA("Model") then
                    proxy:PivotTo(display);
                else
                    proxy.CFrame = display;
                end;

                u2[p59.id] = p59;

                return p59;
            end;
        end;
    end;
end;

local u65 = nil;
local u66 = nil;

local function stopRocket(p67, p68) -- Line: 353
    -- upvalues: u65 (ref), LocalPlayer (copy), GearCatalog (copy), u66 (ref)
    local v69 = u65;

    if not (v69 and (not p67 or v69.id == p67)) then
        return;
    end;

    u65 = nil;
    v69.velocity:Destroy();
    v69.attachment:Destroy();
    v69.velocity = nil;
    v69.attachment = nil;

    if v69.root.Parent and v69.character == LocalPlayer.Character then
        if p68 then
            local v70 = v69.root.AssemblyLinearVelocity:Dot(v69.direction);
            v69.speed = math.clamp(v70, 0, 64);
            v69.carryEnds = v69.ends + GearCatalog.Items.RocketShoes.CarrySeconds;
            u66 = v69;

            return;
        end;

        v69.root.AssemblyLinearVelocity = Vector3.new(0, 1, 0) * v69.root.AssemblyLinearVelocity.Y;
    end;
end;

local function settleRocket(p71) -- Line: 373
    -- upvalues: u65 (ref), LocalPlayer (copy), stopRocket (copy)
    local v72 = u65;

    if not v72 then
        return;
    end;

    if v72.character == LocalPlayer.Character and (v72.root.Parent and not v72.character:GetAttribute("Ragdolled")) then
        if v72.ends <= p71 then
            stopRocket(v72.id, true);
        end;
    else
        local id = v72.id;
        local v73 = u65;

        if v73 then
            if id and v73.id ~= id then
                return;
            end;

            u65 = nil;
            v73.velocity:Destroy();
            v73.attachment:Destroy();
            v73.velocity = nil;
            v73.attachment = nil;

            if v73.root.Parent and v73.character == LocalPlayer.Character then
                v73.root.AssemblyLinearVelocity = Vector3.new(0, 1, 0) * v73.root.AssemblyLinearVelocity.Y;
            end;
        end;
    end;
end;

local function watchFlag(p74) -- Line: 390
    if p74.character:GetAttribute("GearMotion") == true then
        p74.flag = p74.flag or "Set";

        return;
    end;

    if p74.flag == "Set" then
        p74.flag = "Cleared";
    end;
end;

local function startRocket(p75, p76, p77) -- Line: 397
    -- upvalues: stopRocket (copy), u66 (ref), u65 (ref)
    local v78;

    if p76 then
        v78 = p76:FindFirstChild("HumanoidRootPart");
    else
        v78 = p76;
    end;

    if not (v78 and (not v78.Anchored and typeof(p77) == "Vector3")) then
        return;
    end;

    stopRocket();
    u66 = nil;
    local v79 = p77 * Vector3.new(1, 0, 1);
    local v80 = v79.Magnitude > 0.01 and v79.Unit or Vector3.new(0, 0, 1);
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "PredictedRocketAttachment";
    Attachment.Parent = v78;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "PredictedRocketVelocity";
    LinearVelocity.Attachment0 = Attachment;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane;
    LinearVelocity.PrimaryTangentAxis = Vector3.new(1, 0, 0);
    LinearVelocity.SecondaryTangentAxis = Vector3.new(0, 0, 1);
    LinearVelocity.PlaneVelocity = Vector2.new(v80.X, v80.Z) * 64;
    LinearVelocity.ForceLimitsEnabled = true;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.Magnitude;
    LinearVelocity.MaxForce = math.max(1, v78.AssemblyMass) * 2500;
    LinearVelocity.Parent = v78;
    v78.AssemblyLinearVelocity = v80 * 64 + Vector3.new(0, 1, 0) * v78.AssemblyLinearVelocity.Y;
    u65 = {
        id = p75,
        root = v78,
        character = p76,
        direction = v80,
        velocity = LinearVelocity,
        attachment = Attachment,
        ends = workspace:GetServerTimeNow() + 0.42
    };
end;

function u1.rocket(p81) -- Line: 434
    -- upvalues: settleRocket (copy), u65 (ref), u66 (ref), GearCatalog (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    settleRocket(ServerTimeNow);

    if u65 and u65.character == p81 then
        return "Boost";
    end;

    local v82 = u66;

    if not (v82 and (v82.character == p81 and v82.carryEnds > ServerTimeNow)) then
        return nil;
    end;

    if v82.handed then
        return v82.flag ~= "Cleared" and "Tail" or nil;
    end;

    v82.handed = true;

    return "Carry", v82.speed, v82.direction, GearCatalog.Items.RocketShoes.CarrySeconds;
end;

function u1.rocketActive(p83) -- Line: 452
    -- upvalues: settleRocket (copy), u65 (ref), u66 (ref)
    local ServerTimeNow = workspace:GetServerTimeNow();
    settleRocket(ServerTimeNow);

    if u65 and u65.character == p83 then
        return true;
    end;

    local v84 = u66;
    local v85;

    if v84 == nil or (v84.character ~= p83 or ServerTimeNow >= v84.carryEnds) then
        if p83 == nil then
            v85 = false;
        else
            v85 = ServerTimeNow < (p83:GetAttribute("RocketUntil") or 0);
        end;
    else
        v85 = true;
    end;

    return v85;
end;

local u86 = {
    Dashing = true,
    Boosting = true,
    Recovering = true
};

local function dashing(p87) -- Line: 463
    -- upvalues: u86 (copy)
    local v88;

    if p87 == nil then
        v88 = false;
    else
        v88 = u86[p87:GetAttribute("MovementState")] == true and true or workspace:GetServerTimeNow() < (p87:GetAttribute("DashUntil") or 0);
    end;

    return v88;
end;

local function airhornReport() -- Line: 470
    -- upvalues: LocalPlayer (copy), ChickenOrHero (copy), params (copy), Players (copy), AirhornCone (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return nil;
    end;

    local Position = Character.Position;
    local v89 = Character.CFrame.LookVector * Vector3.new(1, 0, 1);
    local v90 = v89.Magnitude > 0.01 and v89.Unit or Vector3.new(0, 0, 1);
    local v91 = {
        at = workspace:GetServerTimeNow(),
        origin = Position,
        direction = v90,
        targets = {}
    };
    local Attribute = ChickenOrHero.Game.Session:GetAttribute("AdminMatchMode");
    local v92 = (Attribute == "CrossyRoad" or Attribute == "DonkeyKong") and true or Attribute == "FFACatchers";
    local v93 = params();

    for _, v in Players:GetPlayers() do
        local Character2 = v.Character;

        if Character2 then
            Character2 = Character2:FindFirstChild("HumanoidRootPart");
        end;

        if not (v == LocalPlayer or not (Character2 and (v:GetAttribute("RunState") == "Active" and (v92 or v:GetAttribute("GameRole") == "Catcher"))) or (v:GetAttribute("FFAInvincible") == true or (not AirhornCone.contains(Position, v90, Character2.Position) or workspace:Raycast(Position, Character2.Position - Position, v93)))) then
            table.insert(v91.targets, {
                userId = v.UserId,
                position = Character2.Position
            });

            if #v91.targets >= 32 then
                break;
            end;
        end;
    end;

    return v91;
end;

local u94 = 0;

function u1.request(u95, u96, p97) -- Line: 502
    -- upvalues: AbilityRule (copy), LocalPlayer (copy), u94 (ref), u86 (copy), airhornReport (copy), HttpService (copy), u3 (copy), u6 (copy), plan (copy), GearCatalog (copy), build (copy), u9 (copy), u1 (copy), GearEvent (copy)
    if AbilityRule.blocked(LocalPlayer) then
        return nil;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow < u94 then
        return nil;
    end;

    if u95 == "RocketShoes" then
        local Character = LocalPlayer.Character;
        local v98;

        if Character == nil then
            v98 = false;
        else
            v98 = u86[Character:GetAttribute("MovementState")] == true and true or workspace:GetServerTimeNow() < (Character:GetAttribute("DashUntil") or 0);
        end;

        if v98 or LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TackleActive") == true then
            return nil;
        end;
    end;

    if p97 == "UseAbility" and ServerTimeNow < (LocalPlayer:GetAttribute("AbilityReadyAt") or 0) then
        return nil;
    end;

    if p97 == "Use" and ServerTimeNow < (LocalPlayer:GetAttribute("GearReadyAt") or 0) then
        return nil;
    end;

    u94 = ServerTimeNow + 0.6;
    local v99;

    if u95 == "EmergencyAirhorn" then
        v99 = airhornReport() or nil;
    else
        v99 = nil;
    end;

    local u100 = HttpService:GenerateGUID(false);
    local u101 = {
        item = u95,
        character = LocalPlayer.Character,
        started = workspace:GetServerTimeNow(),
        emitted = {}
    };
    local v102 = 0;

    for _ in u3 do
        v102 = v102 + 1;
    end;

    if v102 >= 24 then
        local v103 = nil;
        local v104 = nil;

        for i, v in u3 do
            if not v103 or v.started < v103 then
                v103 = v.started;
                v104 = i;
            end;
        end;

        if v104 then
            u3[v104] = nil;
        end;
    end;

    u3[u100] = u101;
    u6[u100] = u101;
    local v105 = 0;

    for _ in u6 do
        v105 = v105 + 1;
    end;

    if v105 > 128 then
        local v106 = nil;
        local v107 = nil;

        for i, v in u6 do
            if not v106 or v.started < v106 then
                v106 = v.started;
                v107 = i;
            end;
        end;

        if v107 then
            u6[v107] = nil;
        end;
    end;

    local success, result = pcall(function() -- Line: 554
        -- upvalues: plan (ref), u95 (copy), u96 (copy), GearCatalog (ref), u100 (copy), u101 (copy), build (ref), LocalPlayer (ref), u9 (ref), u1 (ref)
        local v108 = plan(u95, u96);

        if v108 and (u95 == "SpringBox" and v108.landing) then
            v108.landing = v108.landing * CFrame.Angles(0, GearCatalog.boxYaw(u100, 0), 0);

            for i, v in v108.sides or {} do
                v108.sides[i] = v * CFrame.Angles(0, GearCatalog.boxYaw(u100, i), 0);
            end;
        end;

        local v109 = u101.character and u101.character:FindFirstChild("HumanoidRootPart");

        if not v109 then
            return;
        end;

        if v108 then
            v108.id = u100;
            v108.predicted = true;
            v108.started = u101.started;
            build(v108);

            for i, v in v108.sides or {} do
                build({
                    predicted = true,
                    id = u100 .. "#" .. i,
                    item = u95,
                    origin = v108.origin,
                    direction = v108.direction,
                    landing = v,
                    hand = v108.hand,
                    started = u101.started
                });
            end;
        end;

        local v110 = v108 and v108.origin or v109.Position;
        local v111;

        if u95 == "RescueKit" and LocalPlayer:GetAttribute("BossHearts") ~= nil then
            v111 = {};
        elseif u95 == "BananaPeel" or (u95 == "RescueKit" or (u95 == "Adrenaline" or u95 == "Lifeline")) then
            v111 = { u9[u95] };
        else
            v111 = { "Use", u9[u95] };
        end;

        for _, v in v111 do
            if v then
                u101.emitted[v] = true;
                local FX = u1.FX;
                local v112 = {
                    kind = v,
                    item = u95,
                    position = v110
                };
                local v113 = v108 and v108.direction;

                if not v113 then
                    local v114 = v109.CFrame.LookVector * Vector3.new(1, 0, 1);
                    v113 = v114.Magnitude > 0.01 and v114.Unit or Vector3.new(0, 0, 1);
                end;

                v112.direction = v113;
                local v115;

                if v == "DecoyInflate" then
                    v115 = nil;
                else
                    v115 = u101.character;
                end;

                v112.character = v115;
                local v116;

                if v108 then
                    v116 = v108.cf;
                else
                    v116 = v108;
                end;

                v112.cf = v116;
                v112.requestId = u100;
                v112.ownerId = LocalPlayer.UserId;
                FX:Fire(v112);
            end;
        end;
    end);

    if not success then
        warn("Gear visual prediction skipped:", result);
    end;

    GearEvent:FireServer(p97, (p97 == "StudioUseItem" or p97 == "StudioUseAbility") and u95 and u95 or nil, u96, u100, nil, v99);

    return u100;
end;

local u117 = {
    Use = true
};

for _, v in u9 do
    u117[v] = true;
end;

function u1.consumeFX(p118) -- Line: 626
    -- upvalues: LocalPlayer (copy), u117 (copy)
    local v119;

    if type(p118) == "table" and (p118.ownerId == LocalPlayer.UserId and type(p118.requestId) == "string") then
        v119 = u117[p118.kind] == true;
    else
        v119 = false;
    end;

    return v119;
end;

CollectionService:GetInstanceAddedSignal("PredictedGearVisual"):Connect(function(u120) -- Line: 635, Name: bind
    -- upvalues: u4 (copy), CollectionService (copy), u7 (copy), LocalPlayer (copy), u6 (copy), u2 (copy), restore (copy), build (copy), Players (copy), u10 (copy), u5 (copy), hide (copy)
    if not u4[u120] then
        local v121 = 0;

        for _ in u4 do
            v121 = v121 + 1;
        end;

        if v121 < 128 then
            u4[u120] = true;
            task.spawn(function() -- Line: 640
                -- upvalues: CollectionService (ref), u120 (copy), u4 (ref), u7 (ref), LocalPlayer (ref), u6 (ref), u2 (ref), restore (ref), build (ref), Players (ref), u10 (ref), u5 (ref), hide (ref)
                for i = 1, 120 do
                    if not CollectionService:HasTag(u120, "PredictedGearVisual") then
                        u4[u120] = nil;

                        return;
                    end;

                    if u120:IsDescendantOf(workspace) and (u120:GetAttribute("GearRequestId") and u120:GetAttribute("GearOrigin")) then
                        break;
                    end;

                    task.wait(0.05);
                    local _ = i;
                end;

                u4[u120] = nil;

                if not u120:IsDescendantOf(workspace) then
                    return;
                end;

                local Attribute = u120:GetAttribute("GearRequestId");
                local Attribute2 = u120:GetAttribute("GearOrigin");
                local Attribute3 = u120:GetAttribute("GearVisualKind");

                if type(Attribute) ~= "string" or (typeof(Attribute2) ~= "Vector3" or not u7[Attribute3]) then
                    return;
                end;

                local v122;

                if u120:GetAttribute("GearOwnerId") == LocalPlayer.UserId then
                    v122 = u6[Attribute];
                else
                    v122 = false;
                end;

                local v123 = u2[Attribute];

                if v123 and v123.item ~= Attribute3 then
                    if v123.proxy then
                        v123.proxy:Destroy();
                    end;

                    restore(v123);

                    if u2[v123.id] == v123 then
                        u2[v123.id] = nil;
                        v123 = nil;
                    else
                        v123 = nil;
                    end;
                end;

                if v123 and v123.server then
                    return;
                end;

                if Attribute3 == "RufusLeash" and (v122 and (not v123 and workspace:GetServerTimeNow() - v122.started >= u7.RufusLeash)) then
                    u120:Destroy();

                    return;
                end;

                local v124 = v123 or build({
                    id = Attribute,
                    item = Attribute3,
                    origin = Attribute2,
                    direction = u120:GetAttribute("GearDirection") or Vector3.new(0, 0, 1),
                    started = v122 and v122.started or u120:GetAttribute("GearSpawnedAt"),
                    predicted = v122 ~= nil,
                    landing = u120:GetAttribute("GearLanding"),
                    cf = u120:GetAttribute("GearTargetCFrame")
                }, u120);

                if not v124 then
                    return;
                end;

                v124.server = u120;
                v124.origin = Attribute2;
                v124.direction = u120:GetAttribute("GearDirection") or v124.direction;
                v124.landing = u120:GetAttribute("GearLanding") or v124.landing;
                v124.cf = u120:GetAttribute("GearTargetCFrame") or v124.cf;
                v124.duration = u120:GetAttribute("GearDuration") or v124.duration;
                v124.speed = u120:GetAttribute("GearSpeed") or v124.speed;
                v124.serverStarted = u120:GetAttribute("GearSpawnedAt") or v124.started;

                if not v124.predicted then
                    v124.started = v124.serverStarted;
                end;

                local PlayerByUserId = Players:GetPlayerByUserId(u120:GetAttribute("GearOwnerId") or 0);

                if PlayerByUserId then
                    PlayerByUserId = PlayerByUserId.Character;
                end;

                if u10[v124.item] and PlayerByUserId then
                    v124.hand = PlayerByUserId:FindFirstChild("RightHand") or PlayerByUserId:FindFirstChild("Right Arm");
                end;

                local v125 = u120;
                v124.serverLast = v125:IsA("Model") and v125:GetPivot() or v125.CFrame;
                v124.serverChanged = workspace:GetServerTimeNow();

                if v124.item == "BowlingBall" and u5[Attribute] then
                    v124.authoritativeCF = u5[Attribute].cf;
                    v124.authoritativeAt = u5[Attribute].received;
                    v124.authoritativeTime = u5[Attribute].serverTime;
                end;

                hide(v124, u120);
            end);
        end;
    end;
end);

for _, v in CollectionService:GetTagged("PredictedGearVisual") do
    if not u4[v] then
        local u126 = v;
        local v127 = 0;

        for _ in u4 do
            v127 = v127 + 1;
        end;

        if v127 < 128 then
            u4[u126] = true;
            task.spawn(function() -- Line: 640
                -- upvalues: CollectionService (copy), u126 (copy), u4 (copy), u7 (copy), LocalPlayer (copy), u6 (copy), u2 (copy), restore (copy), build (copy), Players (copy), u10 (copy), u5 (copy), hide (copy)
                for i = 1, 120 do
                    if not CollectionService:HasTag(u126, "PredictedGearVisual") then
                        u4[u126] = nil;

                        return;
                    end;

                    if u126:IsDescendantOf(workspace) and (u126:GetAttribute("GearRequestId") and u126:GetAttribute("GearOrigin")) then
                        break;
                    end;

                    task.wait(0.05);
                    local _ = i;
                end;

                u4[u126] = nil;

                if not u126:IsDescendantOf(workspace) then
                    return;
                end;

                local Attribute = u126:GetAttribute("GearRequestId");
                local Attribute2 = u126:GetAttribute("GearOrigin");
                local Attribute3 = u126:GetAttribute("GearVisualKind");

                if type(Attribute) ~= "string" or (typeof(Attribute2) ~= "Vector3" or not u7[Attribute3]) then
                    return;
                end;

                local v128;

                if u126:GetAttribute("GearOwnerId") == LocalPlayer.UserId then
                    v128 = u6[Attribute];
                else
                    v128 = false;
                end;

                local v129 = u2[Attribute];

                if v129 and v129.item ~= Attribute3 then
                    if v129.proxy then
                        v129.proxy:Destroy();
                    end;

                    restore(v129);

                    if u2[v129.id] == v129 then
                        u2[v129.id] = nil;
                        v129 = nil;
                    else
                        v129 = nil;
                    end;
                end;

                if v129 and v129.server then
                    return;
                end;

                if Attribute3 == "RufusLeash" and (v128 and (not v129 and workspace:GetServerTimeNow() - v128.started >= u7.RufusLeash)) then
                    u126:Destroy();

                    return;
                end;

                local v130 = v129 or build({
                    id = Attribute,
                    item = Attribute3,
                    origin = Attribute2,
                    direction = u126:GetAttribute("GearDirection") or Vector3.new(0, 0, 1),
                    started = v128 and v128.started or u126:GetAttribute("GearSpawnedAt"),
                    predicted = v128 ~= nil,
                    landing = u126:GetAttribute("GearLanding"),
                    cf = u126:GetAttribute("GearTargetCFrame")
                }, u126);

                if not v130 then
                    return;
                end;

                v130.server = u126;
                v130.origin = Attribute2;
                v130.direction = u126:GetAttribute("GearDirection") or v130.direction;
                v130.landing = u126:GetAttribute("GearLanding") or v130.landing;
                v130.cf = u126:GetAttribute("GearTargetCFrame") or v130.cf;
                v130.duration = u126:GetAttribute("GearDuration") or v130.duration;
                v130.speed = u126:GetAttribute("GearSpeed") or v130.speed;
                v130.serverStarted = u126:GetAttribute("GearSpawnedAt") or v130.started;

                if not v130.predicted then
                    v130.started = v130.serverStarted;
                end;

                local PlayerByUserId = Players:GetPlayerByUserId(u126:GetAttribute("GearOwnerId") or 0);

                if PlayerByUserId then
                    PlayerByUserId = PlayerByUserId.Character;
                end;

                if u10[v130.item] and PlayerByUserId then
                    v130.hand = PlayerByUserId:FindFirstChild("RightHand") or PlayerByUserId:FindFirstChild("Right Arm");
                end;

                local v131 = u126;
                v130.serverLast = v131:IsA("Model") and v131:GetPivot() or v131.CFrame;
                v130.serverChanged = workspace:GetServerTimeNow();

                if v130.item == "BowlingBall" and u5[Attribute] then
                    v130.authoritativeCF = u5[Attribute].cf;
                    v130.authoritativeAt = u5[Attribute].received;
                    v130.authoritativeTime = u5[Attribute].serverTime;
                end;

                hide(v130, u126);
            end);
        end;
    end;
end;

GearEvent.OnClientEvent:Connect(function(p132, p133) -- Line: 730
    -- upvalues: u5 (copy), u2 (copy), u3 (copy), u65 (ref), LocalPlayer (copy), restore (copy), removeSides (copy), u1 (copy), startRocket (copy), u10 (copy)
    if p132 == "BowlingPosition" then
        if type(p133) == "table" and (type(p133.requestId) == "string" and typeof(p133.cf) == "CFrame") then
            local ServerTimeNow = workspace:GetServerTimeNow();
            u5[p133.requestId] = {
                cf = p133.cf,
                received = ServerTimeNow,
                serverTime = p133.serverTime
            };
            local v134 = u2[p133.requestId];

            if v134 and v134.item == "BowlingBall" then
                v134.authoritativeCF = p133.cf;
                v134.authoritativeAt = ServerTimeNow;
                v134.authoritativeTime = p133.serverTime;
            end;
        end;

        return;
    end;

    if p132 ~= "PredictionResult" or type(p133) ~= "table" then
        return;
    end;

    local v135 = u3[p133.requestId];

    if not v135 then
        return;
    end;

    if p133.accepted ~= true then
        local requestId = p133.requestId;
        local v136 = u65;

        if v136 and (not requestId or v136.id == requestId) then
            u65 = nil;
            v136.velocity:Destroy();
            v136.attachment:Destroy();
            v136.velocity = nil;
            v136.attachment = nil;

            if v136.root.Parent and v136.character == LocalPlayer.Character then
                v136.root.AssemblyLinearVelocity = Vector3.new(0, 1, 0) * v136.root.AssemblyLinearVelocity.Y;
            end;
        end;

        local v137 = u2[p133.requestId];

        if v137 then
            if v137.proxy then
                v137.proxy:Destroy();
            end;

            restore(v137);

            if u2[v137.id] == v137 then
                u2[v137.id] = nil;
            end;
        end;

        removeSides(p133.requestId);
        u1.Cancel:Fire({
            character = v135.character,
            item = v135.item,
            requestId = p133.requestId
        });
        u3[p133.requestId] = nil;

        return;
    end;

    v135.accepted = true;

    if p133.item == v135.item then
        if v135.item == "RocketShoes" and typeof(p133.direction) == "Vector3" then
            startRocket(p133.requestId, v135.character, p133.direction);
        end;

        local v138 = u2[p133.requestId];

        if v138 then
            if typeof(p133.direction) == "Vector3" then
                v138.direction = p133.direction;
            end;

            if typeof(p133.landing) == "CFrame" then
                v138.landing = p133.landing;
            end;

            if typeof(p133.cf) == "CFrame" then
                v138.cf = p133.cf;
            end;

            if not u10[v138.item] and typeof(p133.position) == "Vector3" then
                v138.origin = p133.position;
            end;
        end;

        return;
    end;

    local requestId = p133.requestId;
    local v139 = u65;

    if v139 and (not requestId or v139.id == requestId) then
        u65 = nil;
        v139.velocity:Destroy();
        v139.attachment:Destroy();
        v139.velocity = nil;
        v139.attachment = nil;

        if v139.root.Parent and v139.character == LocalPlayer.Character then
            v139.root.AssemblyLinearVelocity = Vector3.new(0, 1, 0) * v139.root.AssemblyLinearVelocity.Y;
        end;
    end;

    local v140 = u2[p133.requestId];

    if v140 and v140.item == v135.item then
        if v140.proxy then
            v140.proxy:Destroy();
        end;

        restore(v140);

        if u2[v140.id] == v140 then
            u2[v140.id] = nil;
        end;
    end;

    u1.Cancel:Fire({
        character = v135.character,
        item = v135.item,
        requestId = p133.requestId
    });
    v135.item = p133.item;
    v135.emitted = {};
end);

local function target(p141, p142, p143, p144) -- Line: 793
    -- upvalues: u10 (copy), GearCatalog (copy), TweenService (copy)
    local v145 = p142 - p141.started;

    if p141.trail then
        local v146 = not u10[p141.item];

        if not v146 then
            if v145 >= 0.18 then
                v146 = v145 < 0.75;
            else
                v146 = false;
            end;
        end;

        p141.trail.Enabled = v146;
    end;

    if not (p141.server and (not u10[p141.item] and p141.item ~= "PocketDoor")) then
        if u10[p141.item] and p141.landing then
            if p141.server and v145 < 0.18 then
                local server = p141.server;
                p141.origin = (server:IsA("Model") and server:GetPivot() or server.CFrame).Position;
            end;

            if v145 < 0.18 then
                if p141.hand and p141.hand.Parent then
                    p141.origin = p141.hand.Position - p141.hand.CFrame.UpVector * p141.hand.Size.Y * 0.35;
                end;

                return CFrame.new(p141.origin);
            end;

            local math_clamp_ret = math.clamp((v145 - 0.18) / 0.57, 0, 1);
            local v147 = p141.origin:Lerp(p141.landing.Position, math_clamp_ret) + Vector3.new(0, 1, 0) * (math_clamp_ret * 14 * (1 - math_clamp_ret));
            local v148 = CFrame.new(v147) * p141.landing.Rotation * CFrame.Angles(-12.566370614359172 * (1 - math_clamp_ret), 0, math.sin(math_clamp_ret * 3.141592653589793) * 0.4);

            if p141.item == "SpringBox" and math_clamp_ret >= 1 then
                v148 = v148 * GearCatalog.boxShake(0.9 + GearCatalog.Items.SpringBox.TrapDuration - v145, os.clock());
            end;

            return v148;
        end;

        if p141.item == "PocketDoor" and p141.cf then
            if not p141.server or v145 < 0.2 then
                local Value = TweenService:GetValue(math.clamp(v145 / 0.2, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out);

                return (p141.cf * CFrame.new(-2.6, 0, 0) * CFrame.Angles(0, 1.3962634015954636, 0) * CFrame.new(2.6, 0, 0)):Lerp(p141.cf, Value);
            end;

            if p141.predicted and p142 - (p141.serverStarted or p141.started) < 0.2 then
                return p141.cf;
            end;

            local server = p141.server;

            return server:IsA("Model") and server:GetPivot() or server.CFrame;
        end;

        local v149 = p141.speed * p143;

        if p141.item == "RufusLeash" then
            local v150 = (p141.position - p141.origin):Dot(p141.direction);
            p141.distance = math.clamp(v150, 0, GearCatalog.Items.RufusLeash.ThrowRange);
            p141.position = p141.origin + p141.direction * p141.distance;
            local math_max_ret = math.max(0, GearCatalog.Items.RufusLeash.ThrowRange - p141.distance);
            v149 = math.min(v149, math_max_ret);
        end;

        local v151 = p141.direction * v149;
        local v152;

        if v149 > 0 then
            v152 = workspace:Raycast(p141.position, v151, p144);
        else
            v152 = false;
        end;

        if not v152 then
            p141.position = p141.position + v151;
            p141.distance = p141.distance + v151.Magnitude;

            if p141.item == "RufusLeash" then
                p141.distance = math.min(p141.distance, GearCatalog.Items.RufusLeash.ThrowRange);
                p141.position = p141.origin + p141.direction * p141.distance;
            end;
        end;

        local v153 = p141.item == "BowlingBall" and workspace:Raycast(p141.position + Vector3.new(0, 2, 0), Vector3.new(-0, -5, -0), p144);

        if v153 then
            p141.position = Vector3.new(p141.position.X, v153.Position.Y + 1.05, p141.position.Z);
        end;

        return CFrame.lookAt(p141.position, p141.position + p141.direction) * (p141.item == "BowlingBall" and CFrame.Angles(-p141.distance, 0, 0) or CFrame.identity);
    end;

    local server = p141.server;
    local v154 = server:IsA("Model") and server:GetPivot() or server.CFrame;

    if (v154.Position - p141.serverLast.Position).Magnitude > 0.005 or v154.LookVector:Dot(p141.serverLast.LookVector) < 0.9999 then
        p141.serverLast = v154;
        p141.serverChanged = p142;
    end;

    if p141.item == "BowlingBall" then
        local serverChanged = p141.serverChanged;

        if p141.authoritativeCF and p142 - (p141.authoritativeAt or 0) < 0.25 then
            v154 = p141.authoritativeCF;
            serverChanged = p141.authoritativeTime or p141.authoritativeAt;
        end;

        local v155 = math.clamp(p142 - serverChanged, 0, 0.25) * p141.speed;

        if v155 > 0.001 then
            local v156 = workspace:Spherecast(v154.Position, 0.8, p141.direction * v155, p144);

            if v156 then
                v155 = math.max(0, v156.Distance - 0.03);
            end;
        end;

        local v157 = v154.Position + p141.direction * v155;
        local v158 = workspace:Raycast(v157 + Vector3.new(0, 2, 0), Vector3.new(-0, -5, -0), p144);

        if v158 then
            v157 = Vector3.new(v157.X, v158.Position.Y + 1.05, v157.Z);
        end;

        return CFrame.lookAt(v157, v157 + p141.direction) * CFrame.Angles(-(v157 - p141.origin):Dot(p141.direction), 0, 0);
    end;

    if p141.item ~= "RufusLeash" then
        return v154;
    end;

    local v159 = math.min(0.08, p142 - p141.serverChanged) * p141.speed;
    local v160 = (v154.Position - p141.origin):Dot(p141.direction);
    local math_clamp_ret = math.clamp(v160, 0, GearCatalog.Items.RufusLeash.ThrowRange);
    local v161 = v154 + (p141.origin + p141.direction * math_clamp_ret - v154.Position);
    local math_min_ret = math.min(v159, GearCatalog.Items.RufusLeash.ThrowRange - math_clamp_ret);

    if math_min_ret > 0.001 then
        local v162 = workspace:Spherecast(v161.Position, p141.item == "BowlingBall" and 0.8 or 0.2, p141.direction * math_min_ret, p144);

        if v162 then
            math_min_ret = math.max(0, v162.Distance - 0.03);
        end;
    end;

    local v163 = v161 + p141.direction * math_min_ret;

    if p141.item == "BowlingBall" then
        local v164 = workspace:Raycast(v163.Position + Vector3.new(0, 2, 0), Vector3.new(-0, -5, -0), p144);

        if v164 then
            v163 = v163 + Vector3.new(0, 1, 0) * (v164.Position.Y + 1.05 - v163.Position.Y);
        end;
    end;

    return v163;
end;

RunService.RenderStepped:Connect(function(p165) -- Line: 914
    -- upvalues: settleRocket (copy), u65 (ref), params (copy), u66 (ref), LocalPlayer (copy), u2 (copy), restore (copy), target (copy), GearCatalog (copy), GearEvent (copy), u5 (copy), u6 (copy), u3 (copy), u1 (copy), removeSides (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    settleRocket(ServerTimeNow);
    local v166 = u65;

    if v166 then
        if v166.character:GetAttribute("GearMotion") == true then
            v166.flag = v166.flag or "Set";
        elseif v166.flag == "Set" then
            v166.flag = "Cleared";
        end;

        local v167 = v166.direction * (math.min(p165, 0.08) * 64 + 1.5);
        local v168 = workspace:Spherecast(v166.root.Position, 1.1, v167, (params()));
        v166.velocity.PlaneVelocity = v168 and Vector2.zero or Vector2.new(v166.direction.X, v166.direction.Z) * 64;
    end;

    local v169 = u66;

    if v169 then
        if v169.carryEnds <= ServerTimeNow or v169.character ~= LocalPlayer.Character then
            u66 = nil;
        elseif v169.character:GetAttribute("GearMotion") == true then
            v169.flag = v169.flag or "Set";
        elseif v169.flag == "Set" then
            v169.flag = "Cleared";
        end;
    end;

    local v170 = next(u2) and params() or nil;

    for _, v in u2 do
        if v.proxy.Parent and (not v.server or v.server:IsDescendantOf(workspace)) and (v.server or ServerTimeNow - v.started <= math.min(v.duration, 3)) then
            local v171 = target(v, ServerTimeNow, math.min(p165, 0.1), v170);

            if v.item == "BowlingBall" and v.server then
                local v172 = v.display.Position - (v.ballTarget or v171).Position;
                v.ballTarget = v171;
                v.display = v171 + (v172.Magnitude > 6 and Vector3.new(0, 0, 0) or v172 * math.exp(-18 * p165));
            else
                if v.server then
                    v171 = v.display:Lerp(v171, 1 - math.exp(-30 * p165)) or v171;
                end;

                v.display = v171;
            end;

            if v.item == "RufusLeash" then
                local v173 = (v.display.Position - v.origin):Dot(v.direction);
                local math_clamp_ret = math.clamp(v173, 0, GearCatalog.Items.RufusLeash.ThrowRange);
                v.display = v.display + (v.origin + v.direction * math_clamp_ret - v.display.Position);
            end;

            local proxy = v.proxy;
            local display = v.display;

            if proxy:IsA("Model") then
                proxy:PivotTo(display);
            else
                proxy.CFrame = display;
            end;

            if v.item == "BowlingBall" and (LocalPlayer:GetAttribute("InMatch") and LocalPlayer:GetAttribute("GameRole") == "Runner") then
                local Character = LocalPlayer.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart");
                end;

                local v174 = v.authoritativeCF and v.authoritativeCF.Position or v.display.Position;

                if Character and (math.abs(Character.Position.Y - v174.Y) <= 5.5 and ((Vector3.new(Character.Position.X, 0, Character.Position.Z) - Vector3.new(v174.X, 0, v174.Z)).Magnitude <= 3.4 and ServerTimeNow - (v.lastHitReport or (-1 / 0)) >= 0.16)) then
                    v.lastHitReport = ServerTimeNow;
                    GearEvent:FireServer("BowlingHitReport", v.id, Character.Position, nil, v.authoritativeTime or ServerTimeNow);
                end;
            end;
        else
            if v.proxy then
                v.proxy:Destroy();
            end;

            restore(v);

            if u2[v.id] == v then
                u2[v.id] = nil;
            end;
        end;
    end;

    for i, v in u5 do
        if ServerTimeNow - v.received > 4 then
            u5[i] = nil;
        end;
    end;

    for i, v in u6 do
        if ServerTimeNow - v.started > 90 then
            u6[i] = nil;
        end;
    end;

    for i, v in u3 do
        if v.accepted or ServerTimeNow - v.started <= 3 then
            if ServerTimeNow - v.started > 20 then
                u3[i] = nil;
            end;
        else
            u1.Cancel:Fire({
                character = v.character,
                item = v.item,
                requestId = i
            });
            local v175 = u2[i];

            if v175 and not v175.server then
                if v175.proxy then
                    v175.proxy:Destroy();
                end;

                restore(v175);

                if u2[v175.id] == v175 then
                    u2[v175.id] = nil;
                end;
            end;

            removeSides(i, true);
            u3[i] = nil;
        end;
    end;
end);
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 1004
    -- upvalues: u66 (ref), u2 (copy), u3 (copy), restore (copy), u1 (copy)
    u66 = nil;

    for _, v in u2 do
        if u3[v.id] then
            if v.proxy then
                v.proxy:Destroy();
            end;

            restore(v);

            if u2[v.id] == v then
                u2[v.id] = nil;
            end;
        end;
    end;

    for i, v in u3 do
        u1.Cancel:Fire({
            character = v.character,
            item = v.item,
            requestId = i
        });
    end;

    table.clear(u3);
end);

return u1;