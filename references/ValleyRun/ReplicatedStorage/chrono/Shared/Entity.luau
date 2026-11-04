 

 

local u1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
require(script.Parent.Types);
local Config = require(script.Parent.Config);
local Snapshots = require(script.Parent.Snapshots);
local InterpolationMath = require(script.Parent.InterpolationMath);
local ClientClock = require(script.Parent.Parent.Client.ClientClock);
local Holder = require(script.Parent.Holder);
local Signal = require(script.Parent.Signal);
local Events = require(script.Parent.Events);
local ModelHelper = require(script.Parent.ModelHelper);
local AlignDriver = require(script.Parent.AlignDriver);
local Warn = require(script.Parent.Warn);
local VelocityAt = InterpolationMath.VelocityAt;
local u2 = {};
local _clientOwned = Holder._clientOwned;
local u3 = RunService:IsServer();
local u4;

if u3 then
    u4 = nil;
else
    u4 = Players.LocalPlayer;
end;

local u5 = {};

for _, v in Enum.HumanoidStateType:GetEnumItems() do
    u5[v.Value] = v;
end;

local Part = Instance.new("Part");
Part.Size = Vector3.new(0.1, 0.1, 0.1);
Part.Name = "__CHRONO_CENTER";
Part.Anchored = true;
Part.Transparency = 1;
Part.CanCollide = false;
Part.CanTouch = false;
Part.CanQuery = false;
local u6 = false;
Config._WaitForLock(function() -- Line: 44
    -- upvalues: u6 (ref)
    u6 = true;
end);

local function SafeDestroy(u7: userdata?) -- Line: 48
    if u7 then
        pcall(function() -- Line: 50
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end;
end;

local function SafeSetNetworkOwner(u8: userdata, u9: userdata?) -- Line: 56
    pcall(function() -- Line: 57
        -- upvalues: u8 (copy), u9 (copy)
        u8:SetNetworkOwner(u9);
    end);
end;

local function GetPart(p10) -- Line: 62
    -- upvalues: Warn (copy)
    local model = p10.model;

    if not model then
        return nil;
    end;

    if model:IsA("BasePart") then
        return model;
    end;

    if model:IsA("Model") then
        local _chronoPrimary = p10._chronoPrimary;

        if _chronoPrimary then
            local v11 = model:FindFirstChild(_chronoPrimary);

            if v11 and v11:IsA("BasePart") then
                return v11;
            end;

            Warn.low((`Chrono primary part {_chronoPrimary} not found or not a BasePart in model {model:GetFullName()} for entity id {p10.id}. Falling back to default PrimaryPart.`));
        end;

        local PrimaryPart = model.PrimaryPart;

        if PrimaryPart then
            return PrimaryPart;
        end;
    end;

    return nil;
end;

local function GetRootPart(p12) -- Line: 90
    -- upvalues: u1 (copy), u3 (copy)
    local PrimaryPart = u1.GetPrimaryPart(p12);

    if not PrimaryPart then
        return;
    end;

    if not (u3 and p12._lockedCFReplication) then
        return PrimaryPart;
    end;

    local __CHRONO_LOCKER = PrimaryPart:FindFirstChild("__CHRONO_LOCKER");

    if __CHRONO_LOCKER then
        local v13 = __CHRONO_LOCKER:FindFirstChildWhichIsA("BasePart");

        if v13 and v13:IsA("BasePart") then
            return v13;
        end;

        return PrimaryPart;
    end;
end;

local function LockCFReplication(p14: userdata?) -- Line: 114
    -- upvalues: u3 (copy)
    if p14 then
        local CFrame2 = p14.CFrame;
        local __CHRONO_LOCKER = p14:FindFirstChild("__CHRONO_LOCKER");

        if __CHRONO_LOCKER then
            local __CHRONO_WELD = __CHRONO_LOCKER:FindFirstChild("__CHRONO_WELD");

            if __CHRONO_WELD then
                __CHRONO_WELD.Part1 = p14;
                p14.CFrame = CFrame2;

                return __CHRONO_WELD.Part0;
            end;

            if __CHRONO_LOCKER then
                pcall(function() -- Line: 50
                    -- upvalues: __CHRONO_LOCKER (copy)
                    __CHRONO_LOCKER:Destroy();
                end);
            end;
        end;

        local Camera = Instance.new("Camera", p14);
        Camera.Archivable = false;
        Camera.Name = "__CHRONO_LOCKER";
        local Weld = Instance.new("Weld", Camera);
        Weld.Name = "__CHRONO_WELD";
        local Part2 = Instance.new("Part");
        Part2.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0);
        Part2.Name = "__CHRONO_LOCKER_PART";
        Part2.Parent = Camera;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CanTouch = false;
        Part2.Transparency = u3 and 0 or 1;
        Part2.Color = Color3.new(1, 0, 0);
        Part2.Massless = false;
        Part2.RootPriority = 126;
        Part2.Size = Vector3.new(0, 0, 0);
        Weld.Part0 = Part2;
        Weld.Part1 = p14;
        p14.CFrame = CFrame2;

        return Part2;
    end;
end;

local function SetPartCFrame(p15: any, p16) -- Line: 155
    -- upvalues: GetRootPart (copy)
    local v17 = GetRootPart(p15);

    if v17 then
        v17.CFrame = p16;
    end;
end;

local function UnlockCFReplication(p18: userdata?) -- Line: 162
    if not p18 then
        return;
    end;

    local CFrame2 = p18.CFrame;
    local __CHRONO_LOCKER = p18:FindFirstChild("__CHRONO_LOCKER");

    if __CHRONO_LOCKER then
        __CHRONO_LOCKER:Destroy();
        p18.CFrame = CFrame2;
    end;
end;

local function SetValue(p19: any, p20: string, p21: any, p22: boolean?, p23: any) -- Line: 181
    -- upvalues: u3 (copy), u2 (copy)
    if not p22 and p19[p20] == p21 then
        return;
    end;

    p19[p20] = p21;

    if not u3 then
        return;
    end;

    if not u2[p19] then
        u2[p19] = {};
    end;

    u2[p19][p20] = p23 or (p21 or false);
end;

local function FireEvent(p24: any, p25: string, ...) -- Line: 195
    local _events = p24._events;

    if not _events then
        return;
    end;

    local v26 = _events[p25];

    if v26 then
        v26:Fire(p24, ...);
    end;
end;

local function SetClock(p27, p28) -- Line: 207
    -- upvalues: ClientClock (copy)
    if p27._clientClock then
        p27._clientClock:Destroy();
        p27._clientClock = nil;
    end;

    if p28 == false then
        p27._clockBuffer = nil;
        p28 = nil;
    end;

    local v29 = p28 or p27._clockBuffer;
    p27._clockBuffer = v29;
    local v30 = v29 or (p27.entityConfig.BUFFER or 0);

    if p27.networkOwner or v29 then
        local networkOwner = p27.networkOwner;
        p27._clientClock = ClientClock.new(p27.entityConfig.TICK_RATE, `Entity id: {p27.id} plr: {networkOwner and (networkOwner.Name or "SERVER") or "SERVER"}`, v30, networkOwner);
    end;
end;

local function CheckNetworkOwner(p31: any, p32: userdata?) -- Line: 230
    -- upvalues: u4 (copy), u3 (copy), GetPart (copy), LockCFReplication (copy), GetRootPart (copy), Snapshots (copy), InterpolationMath (copy), SetClock (copy), FireEvent (copy), _clientOwned (copy), Events (copy)
    p31.isContextOwner = p31.networkOwner == u4;
    local v33 = p31.networkOwner == p32;

    if not v33 then
        p31.latestTime = 0;
        p31.lastClientClock = 0;
    end;

    if u3 then
        local u34 = GetPart(p31);

        if u34 then
            local _lockedCFReplication = p31._lockedCFReplication;

            if _lockedCFReplication and u34 then
                local CFrame2 = u34.CFrame;
                local __CHRONO_LOCKER = u34:FindFirstChild("__CHRONO_LOCKER");

                if __CHRONO_LOCKER then
                    __CHRONO_LOCKER:Destroy();
                    u34.CFrame = CFrame2;
                end;
            end;

            local networkOwner = p31.networkOwner;
            pcall(function() -- Line: 57
                -- upvalues: u34 (copy), networkOwner (copy)
                u34:SetNetworkOwner(networkOwner);
            end);

            if _lockedCFReplication then
                LockCFReplication(u34);
                local u35 = GetRootPart(p31);

                if u35 then
                    local networkOwner2 = p31.networkOwner;
                    pcall(function() -- Line: 57
                        -- upvalues: u35 (copy), networkOwner2 (copy)
                        u35:SetNetworkOwner(networkOwner2);
                    end);
                    u35.Anchored = not v33;
                end;
            end;
        end;

        if p31.isContextOwner and not p31.entityConfig.STORE_SNAPSHOTS then
            p31.snapshot = nil;
        elseif not p31.snapshot then
            p31.snapshot = Snapshots(InterpolationMath.Hermite);
        end;
    elseif p31._lockedCFReplication and p31.isContextOwner then
        local v36 = GetPart(p31);

        if v36 then
            LockCFReplication(v36);
            p31._cfLockFailed = nil;
        else
            p31._cfLockFailed = true;
        end;

        if p31._player and v36 then
            local CFrame2 = v36.CFrame;
            local __CHRONO_LOCKER = v36:FindFirstChild("__CHRONO_LOCKER");

            if __CHRONO_LOCKER then
                __CHRONO_LOCKER:Destroy();
                v36.CFrame = CFrame2;
            end;
        end;
    end;

    if v33 then
        return;
    end;

    if p31.snapshot then
        p31.snapshot:Clear();
    end;

    if not u3 then
        SetClock(p31);
    end;

    FireEvent(p31, "NetworkOwnerChanged", p31.networkOwner, p32);
    local v37 = p32 and _clientOwned[p32];

    if v37 then
        v37[p31] = nil;
        Events._Signals.PlayerOwnedRemoved:Fire(p32, p31);
    end;

    if p31.networkOwner then
        local v38 = _clientOwned[p31.networkOwner];

        if not v38 then
            return;
        end;

        v38[p31] = true;
        Events._Signals.PlayerOwnedAdded:Fire(p31.networkOwner, p31);
    end;
end;

function u1.SyncOwnerShip(p39) -- Line: 311
    -- upvalues: CheckNetworkOwner (copy)
    CheckNetworkOwner(p39, p39.networkOwner);
end;

local function CheckModelReplicationMode(p40, p41) -- Line: 315
    -- upvalues: Warn (copy)
    local v42 = (p41 or p40.modelReplicationMode or p40.entityConfig.MODEL_REPLICATION_MODE):upper();

    if v42 ~= "NATIVE" and (v42 ~= "CUSTOM" and v42 ~= "NATIVE_WITH_LOCK") then
        Warn.medium((`Invalid model replication mode {v42} for entity id {p40.id}, defaulting to NATIVE`));
        v42 = "NATIVE";
    end;

    p40._lockedCFReplication = false;

    if v42 == "NATIVE_WITH_LOCK" then
        p40._lockedCFReplication = true;
        v42 = "NATIVE";
    end;

    return v42;
end;

local u43 = nil;

local function SetModel(p44: any, p45: any, p46: any, p47: boolean?) -- Line: 340
    -- upvalues: u3 (copy), GetPart (copy), Config (copy), CheckModelReplicationMode (copy), Holder (copy), Warn (copy), u1 (copy)
    local v48 = p44.modelReplicationMode == "CUSTOM";

    if u3 then
        if p44.modelReplicationMode == "NATIVE" and p44._lockedCFReplication then
            local v49 = GetPart(p44);
            p44._lockedCFReplication = false;

            if v49 then
                local CFrame2 = v49.CFrame;
                local __CHRONO_LOCKER = v49:FindFirstChild("__CHRONO_LOCKER");

                if __CHRONO_LOCKER then
                    __CHRONO_LOCKER:Destroy();
                    v49.CFrame = CFrame2;
                end;
            end;
        end;

        local u50 = not p47 and p44.model;

        if u50 then
            pcall(function() -- Line: 50
                -- upvalues: u50 (copy)
                u50:Destroy();
            end);
        end;

        p44.model = nil;
    elseif u3 or not v48 then
        if not u3 and p44._lockedCFReplication then
            local v51 = GetPart(p44);
            p44._lockedCFReplication = false;

            if v51 then
                local CFrame2 = v51.CFrame;
                local __CHRONO_LOCKER = v51:FindFirstChild("__CHRONO_LOCKER");

                if __CHRONO_LOCKER then
                    __CHRONO_LOCKER:Destroy();
                    v51.CFrame = CFrame2;
                end;
            end;
        end;
    else
        local model = p44.model;

        if model then
            pcall(function() -- Line: 50
                -- upvalues: model (copy)
                model:Destroy();
            end);
        end;

        p44.model = nil;
    end;

    local v52;

    if type(p45) == "string" then
        v52 = Config._GetEntityModel(p45);

        if v52 then
            v52 = v52:Clone();
        end;

        if v52 then
            v52.Parent = workspace;
        end;
    else
        v52 = p45;
        p45 = nil;
    end;

    local v53 = Config._GetBroadPhase(p45);
    local v54 = CheckModelReplicationMode(p44, p46);
    p44.modelString = p45;
    p44.model = v52;

    if u3 or not p44.broadPhase then
        p44.broadPhase = v53;
    end;

    if v52 then
        if v54 == "CUSTOM" then
            v52.Parent = Holder.GetEntityStorageInstance();
        end;

        local Attribute = v52:GetAttribute("__CHRONO_PRIMARY");

        if Attribute and type(Attribute) == "string" then
            p44._chronoPrimary = Attribute;
        end;
    end;

    p44.modelReplicationMode = v54;
    local v55 = GetPart(p44);

    if v52 and not v55 then
        (u3 and Warn.high or Warn.low)((`{v52:GetFullName()} must have a PrimaryPart set for things like autoReplication and movement.`));
    elseif v52 and not v52.Archivable then
        Warn.low((`{v52:GetFullName()} is not Archivable. It is recommended to set Archivable to true for entity models to prevent potential issues when cloning. Archivable has been set to true automatically.`));
        v52.Archivable = true;
    end;

    if not v55 then
        return;
    end;

    local CFrame2 = v55.CFrame;

    if not p44.latestCFrame then
        u1.SetCFrame(p44, CFrame2 or v55.CFrame);
    end;

    if p44.latestCFrame then
        v55.CFrame = p44.latestCFrame;
    end;

    p44.modelReplicationMode = u1.GetModelReplicationType(p44);

    if p44.modelReplicationMode == "NATIVE_WITH_LOCK" then
        p44._lockedCFReplication = true;
        p44.modelReplicationMode = "NATIVE";
    end;

    if not (u3 or (p44.isContextOwner or v54 ~= "CUSTOM" and not p44._lockedCFReplication)) then
        v55.Anchored = true;
    end;
end;

function u1._new(p56: string?, p57: any, p58: any, p59) -- Line: 436
    -- upvalues: Config (copy), Warn (copy), u3 (copy), u4 (copy), Snapshots (copy), InterpolationMath (copy), SetModel (copy), u43 (ref), CheckNetworkOwner (copy)
    local v60 = Config._GetEntityType(p56);

    if not v60 then
        Warn.medium((`Entity config {p56} not found. Using DEFAULT config.`));
        v60 = Config._GetEntityType("DEFAULT");
    end;

    if p59 == nil and (typeof(p57) == "string" and Config._GetEntityModel(p57) == false) then
        Warn.medium("Entity\'s model doesn\'t exist, initCFrame is required. DEFAULTING to CFrame.new(0, 0, 0)");
        p59 = CFrame.new(0, 0, 0);
    end;

    local v61 = {
        id = -1,
        registered = false,
        isContextOwner = false,
        networkOwner = nil,
        paused = false,
        destroyed = false,
        autoUpdatePosition = v60.AUTO_UPDATE_POSITION ~= false,
        latestCFrame = p59,
        entityConfig = v60,
        interpolation = not u3 and true
    };

    if u4 then
        v61.snapshot = Snapshots(InterpolationMath.Hermite);
    end;

    SetModel(v61, p57, p58);
    u43(v61, true);
    CheckNetworkOwner(v61, nil);

    return v61;
end;

function u1.new(p62: string?, p63: any, p64: any, p65) -- Line: 493
    -- upvalues: u6 (ref), u1 (copy), Holder (copy)
    if not u6 then
        error("Entity.new cannot be called until Chrono.Start() is called.");
    end;

    local v66 = u1._new(p62, p63, p64, p65);
    Holder.RegisterEntity(v66);

    return v66;
end;

function u1.SetModel(p67: any, p68: any, p69: any, p70: boolean?) -- Line: 514
    -- upvalues: SetModel (copy), u3 (copy), ModelHelper (copy), u2 (copy), CheckNetworkOwner (copy), u43 (ref), FireEvent (copy)
    local model = p67.model;
    SetModel(p67, p68, p69, p70);

    if u3 then
        local v71, v72 = ModelHelper.ReadyModelFromRep(p67, nil);
        local model2 = p67.model;
        local v73 = v71 or false;
        p67.model = model2;

        if u3 then
            if not u2[p67] then
                u2[p67] = {};
            end;

            u2[p67].model = v73 or (model2 or false);
        end;

        p67._modelMetaData = v72;

        if u3 then
            if not u2[p67] then
                u2[p67] = {};
            end;

            if not (v72 or v72) then
                v72 = false;
            end;

            u2[p67]._modelMetaData = v72;
        end;

        CheckNetworkOwner(p67, p67.networkOwner);
    end;

    u43(p67, true);
    FireEvent(p67, "ModelChanged", p67.model, model);
end;

u1._FireEvent = FireEvent;

function u1.SetConfig(p74: any, p75: string) -- Line: 550
    -- upvalues: Config (copy), Warn (copy), u3 (copy), u2 (copy), u43 (ref), SetClock (copy)
    local v76 = Config._GetEntityType(p75);

    if not v76 then
        Warn.medium((`Entity config {p75} not found. Using Default config.`));
        v76 = Config._GetEntityType("DEFAULT");
    end;

    local NAME = v76.NAME;

    if p74.entityConfig ~= v76 then
        p74.entityConfig = v76;

        if u3 then
            if not u2[p74] then
                u2[p74] = {};
            end;

            u2[p74].entityConfig = NAME or (v76 or false);
        end;
    end;

    u43(p74);

    if not u3 then
        SetClock(p74);
    end;
end;

function u1.SetClockBuffer(p77: any, p78: number?) -- Line: 568
    -- upvalues: u3 (copy), SetClock (copy)
    if u3 then
        error("SetClockBuffer can only be called on the client");
    end;

    if p78 == nil or not p78 then
        p78 = false;
    end;

    SetClock(p77, p78);
end;

function u1.SetBroadPhase(p79: any, p80: vector?) -- Line: 580
    -- upvalues: u3 (copy), u2 (copy)
    if p79.broadPhase == p80 then
        return;
    end;

    p79.broadPhase = p80;

    if not u3 then
        return;
    end;

    if not u2[p79] then
        u2[p79] = {};
    end;

    u2[p79].broadPhase = p80 or false;
end;

function u1.GetData(p81) -- Line: 589
    return p81._data;
end;

function u1.GetModel(p82) -- Line: 598
    return p82.model;
end;

function u1.SetData(p83, p84) -- Line: 607
    -- upvalues: u3 (copy), u2 (copy), FireEvent (copy)
    p83._data = p84;

    if u3 then
        if not u2[p83] then
            u2[p83] = {};
        end;

        u2[p83]._data = p84 or false;
    end;

    FireEvent(p83, "DataChanged", p84);
end;

function u1._SetTickMode(p85: any, p86: boolean?) -- Line: 612
    -- upvalues: u3 (copy), u2 (copy), FireEvent (copy)
    if p85.isHalfTicked == p86 then
        return;
    end;

    if p85.isContextOwner then
        p85.isHalfTicked = p86;
    elseif p85.isHalfTicked ~= p86 then
        p85.isHalfTicked = p86;

        if u3 then
            if not u2[p85] then
                u2[p85] = {};
            end;

            u2[p85].isHalfTicked = p86 or false;
        end;
    end;

    FireEvent(p85, "TickChanged", p86 == nil and "NONE" or (p86 and "HALF" or "NORMAL"));
end;

function u1.ClearMount(p87) -- Line: 627
    -- upvalues: u3 (copy), u2 (copy), Events (copy)
    if not u3 then
        error("ClearMount can only be called on the server");
    end;

    if not p87.mountParentId then
        return;
    end;

    if p87.mountParentId ~= nil then
        p87.mountParentId = nil;

        if u3 then
            if not u2[p87] then
                u2[p87] = {};
            end;

            u2[p87].mountParentId = false;
        end;
    end;

    if p87.mountOffset ~= nil then
        p87.mountOffset = nil;

        if u3 then
            if not u2[p87] then
                u2[p87] = {};
            end;

            u2[p87].mountOffset = false;
        end;
    end;

    Events._Signals.EntityMountChanged:Fire(p87, nil);
end;

function u1.SetMount(p88: any, p89: any, p90) -- Line: 646
    -- upvalues: u3 (copy), u1 (copy), Warn (copy), u2 (copy), Events (copy)
    if not u3 then
        error("SetMount can only be called on the server");
    end;

    if p89 == nil then
        return u1.ClearMount(p88);
    end;

    if p88 == p89 then
        Warn.medium("An entity cannot mount itself");

        return;
    end;

    if not p89.id then
        Warn.high("Parent entity must be registered before mounting");

        return;
    end;

    local id = p89.id;

    if p88.mountParentId ~= id then
        p88.mountParentId = id;

        if u3 then
            if not u2[p88] then
                u2[p88] = {};
            end;

            u2[p88].mountParentId = id or false;
        end;
    end;

    if p88.mountOffset ~= p90 then
        p88.mountOffset = p90;

        if u3 then
            if not u2[p88] then
                u2[p88] = {};
            end;

            u2[p88].mountOffset = p90 or false;
        end;
    end;

    Events._Signals.EntityMountChanged:Fire(p88, p89.id);
end;

u1["设置网络主控玩家"] = function(p91: any, p92: userdata?) -- Line: 670
    -- upvalues: u3 (copy), u2 (copy), CheckNetworkOwner (copy), u1 (copy)
    if p92 ~= p91.networkOwner then
        local networkOwner = p91.networkOwner;

        if p91.networkOwner ~= p92 then
            p91.networkOwner = p92;

            if u3 then
                if not u2[p91] then
                    u2[p91] = {};
                end;

                u2[p91].networkOwner = p92 or false;
            end;
        end;

        CheckNetworkOwner(p91, networkOwner);
        u1.Clear(p91);
    end;

    p91.lastCheckedCFrame = nil;
    local v93 = not u3 and (p91.modelReplicationMode == "CUSTOM" and u1.GetPrimaryPart(p91));

    if v93 then
        v93.Anchored = not p91.isContextOwner;
    end;
end;

function u1.SetNetworkOwner(p94: any, p95: userdata?) -- Line: 691
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    if not u3 or p95 == p94.networkOwner then
        if not u3 then
            error("SetNetworkOwner can only be called on the server");
        end;

        return;
    end;

    u1["设置网络主控玩家"](p94, p95);
    local isHalfTicked = p94.isHalfTicked;
    p94.isHalfTicked = isHalfTicked;

    if not u3 then
        return;
    end;

    if not u2[p94] then
        u2[p94] = {};
    end;

    u2[p94].isHalfTicked = isHalfTicked or false;
end;

function u1.Clear(p96) -- Line: 703
    local snapshot = p96.snapshot;
    p96.latestTime = nil;
    p96.lastClientClock = nil;

    if snapshot then
        snapshot:Clear();
    end;
end;

function u1.PauseReplication(p97) -- Line: 716
    -- upvalues: u3 (copy), u2 (copy)
    if p97.paused == true then
        return;
    end;

    p97.paused = true;

    if not u3 then
        return;
    end;

    if not u2[p97] then
        u2[p97] = {};
    end;

    u2[p97].paused = true;
end;

function u1.ResumeReplication(p98) -- Line: 723
    -- upvalues: u3 (copy), u2 (copy)
    if p98.paused == false then
        return;
    end;

    p98.paused = false;

    if not u3 then
        return;
    end;

    if not u2[p98] then
        u2[p98] = {};
    end;

    u2[p98].paused = false;
end;

function u1.Push(p99: any, p100: number, p101, p102: vector?) -- Line: 736
    -- upvalues: u3 (copy), u1 (copy), Warn (copy), VelocityAt (copy), FireEvent (copy)
    local snapshot = p99.snapshot;
    local v103 = not p99.latestTime or p99.latestTime < p100;

    if v103 then
        p99.latestTime = p100;
        p99.latestCFrame = p101;
    end;

    if snapshot then
        local Latest = snapshot:GetLatest();

        if not u3 and (v103 and (Latest and (p100 - Latest.t < 5 and not p99.isContextOwner))) then
            local v104 = u1.GetTargetRenderTime(p99) - Latest.t;

            if math.abs(v104) > 5 then
                snapshot:Clear();
                Warn.low("Clearing Snapshot due to large time difference");
            end;
        end;

        local TICK_RATE = p99.entityConfig.TICK_RATE;

        if p99.isHalfTicked then
            TICK_RATE = TICK_RATE * 2;
        end;

        snapshot:PushWithCheck(p100, p101, p102 or VelocityAt(snapshot:GetLatest(), p100, p101, TICK_RATE), TICK_RATE);
    end;

    FireEvent(p99, "PushedSnapShot", p100, p101, v103);

    return v103;
end;

function u1.GetAt(p105: any, p106: number) -- Line: 774
    local snapshot = p105.snapshot;

    if snapshot then
        return snapshot:GetAt(p106);
    end;

    return p105.latestCFrame;
end;

function u1.GetTargetRenderTime(p107) -- Line: 788
    local _clientClock = p107._clientClock;

    if not _clientClock then
        local CLIENT_CLOCK = p107.entityConfig.CLIENT_CLOCK;

        if not CLIENT_CLOCK then
            return -1;
        end;

        _clientClock = p107.isHalfTicked and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL;
    end;

    return not _clientClock and -1 or _clientClock:GetTargetRenderTime();
end;

function u1.SetAutoUpdatePos(p108: any, p109: boolean) -- Line: 809
    -- upvalues: u3 (copy), u2 (copy)
    if p108.autoUpdatePos == p109 then
        return;
    end;

    p108.autoUpdatePos = p109;

    if not u3 then
        return;
    end;

    if not u2[p108] then
        u2[p108] = {};
    end;

    u2[p108].autoUpdatePos = p109 or false;
end;

function u1.GetCFrame(p110) -- Line: 818
    -- upvalues: GetPart (copy)
    local v111 = GetPart(p110);
    local latestCFrame = p110.latestCFrame;

    if latestCFrame then
        v111 = latestCFrame;
    elseif v111 then
        v111 = v111.CFrame;
    end;

    return v111;
end;

function u1.SetCFrame(p112: any, p113) -- Line: 828
    -- upvalues: Config (copy), u3 (copy), u1 (copy), u2 (copy), GetRootPart (copy)
    local v114 = (p112.latestTime or 0) + 0.00002;

    if Config.FLAGS.SET_CFRAME_FIX then
        if u3 or p112.networkOwner then
            p112._teleport = os.clock();
        end;

        if not (u3 or p112.isContextOwner) then
            u1.Clear(p112);
        end;
    end;

    if p112.snapshot and Config.FLAGS.FIX_TELEPORT_JITTER then
        p112.snapshot.lockedTime = v114;
    end;

    u1.Push(p112, v114, p113);
    p112.latestCFrame = p113;

    if u3 then
        if not u2[p112] then
            u2[p112] = {};
        end;

        u2[p112].latestCFrame = p113 or false;
    end;

    local v115 = (p112.isContextOwner or not u3) and GetRootPart(p112);

    if v115 then
        v115.CFrame = p113;
    end;
end;

function u1.GetPrimaryPart(p116) -- Line: 854
    -- upvalues: GetPart (copy)
    if p116.model then
        return GetPart(p116);
    end;

    return nil;
end;

function u1.LockNativeServerCFrameReplication(p117) -- Line: 868
    -- upvalues: u3 (copy), u2 (copy), CheckNetworkOwner (copy), FireEvent (copy)
    if not u3 then
        error("LockNativeServerCFrameReplication can only be called on the server");

        return;
    end;

    if p117.modelReplicationMode ~= "NATIVE" then
        error("LockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
    end;

    if p117._lockedCFReplication then
        return;
    end;

    if p117._lockedCFReplication ~= true then
        p117._lockedCFReplication = true;

        if u3 then
            if not u2[p117] then
                u2[p117] = {};
            end;

            u2[p117]._lockedCFReplication = true;
        end;
    end;

    CheckNetworkOwner(p117, p117.networkOwner);
    FireEvent(p117, "LockChanged", true);
end;

function u1.UnlockNativeServerCFrameReplication(p118) -- Line: 893
    -- upvalues: u3 (copy), u2 (copy), GetPart (copy), CheckNetworkOwner (copy), FireEvent (copy)
    if not u3 then
        error("LockNativeServerCFrameReplication can only be called on the server");

        return;
    end;

    if p118.modelReplicationMode ~= "NATIVE" then
        error("LockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
    end;

    if not p118._lockedCFReplication then
        return;
    end;

    if p118._lockedCFReplication ~= false then
        p118._lockedCFReplication = false;

        if u3 then
            if not u2[p118] then
                u2[p118] = {};
            end;

            u2[p118]._lockedCFReplication = false;
        end;
    end;

    local v119 = GetPart(p118);

    if v119 then
        local CFrame2 = v119.CFrame;
        local __CHRONO_LOCKER = v119:FindFirstChild("__CHRONO_LOCKER");

        if __CHRONO_LOCKER then
            __CHRONO_LOCKER:Destroy();
            v119.CFrame = CFrame2;
        end;
    end;

    CheckNetworkOwner(p118, p118.networkOwner);
    FireEvent(p118, "LockChanged", false);
end;

function u1.GetModelReplicationType(p120) -- Line: 915
    return (p120.modelReplicationMode or p120.entityConfig.MODEL_REPLICATION_MODE) == "CUSTOM" and "CUSTOM" or (p120._lockedCFReplication and "NATIVE_WITH_LOCK" or "NATIVE");
end;

local function GetHumanoid(p121) -- Line: 930
    local model = p121.model;

    if model and model:IsA("Model") then
        return model:FindFirstChildWhichIsA("Humanoid", true);
    end;

    return nil;
end;

local function GetDisabledStateMask(p122: userdata) -- Line: 938
    -- upvalues: u5 (copy)
    local v123 = 0;

    for i, v in u5 do
        if v ~= Enum.HumanoidStateType.None and not p122:GetStateEnabled(v) then
            local bit32_lshift_ret = bit32.lshift(1, i);
            v123 = bit32.bor(v123, bit32_lshift_ret);
        end;
    end;

    return v123;
end;

local function StopHumanoidStateWatch(p124) -- Line: 951
    -- upvalues: u3 (copy), u2 (copy)
    local _humanoidStateConn = p124._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        p124._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = p124._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        p124._humanoidStateEnabledConn = nil;
    end;

    if u3 then
        if p124._humanoidState ~= nil then
            p124._humanoidState = nil;

            if u3 then
                if not u2[p124] then
                    u2[p124] = {};
                end;

                u2[p124]._humanoidState = false;
            end;
        end;

        if p124._humanoidDisabledStates == nil then
            return;
        end;

        p124._humanoidDisabledStates = nil;

        if not u3 then
            return;
        end;

        if not u2[p124] then
            u2[p124] = {};
        end;

        u2[p124]._humanoidDisabledStates = false;
    end;
end;

local function StartHumanoidStateWatch(u125) -- Line: 969
    -- upvalues: u3 (copy), u2 (copy), GetDisabledStateMask (copy)
    if not u3 then
        return;
    end;

    local _humanoidStateConn = u125._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        u125._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = u125._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        u125._humanoidStateEnabledConn = nil;
    end;

    if u3 then
        if u125._humanoidState ~= nil then
            u125._humanoidState = nil;

            if u3 then
                if not u2[u125] then
                    u2[u125] = {};
                end;

                u2[u125]._humanoidState = false;
            end;
        end;

        if u125._humanoidDisabledStates ~= nil then
            u125._humanoidDisabledStates = nil;

            if u3 then
                if not u2[u125] then
                    u2[u125] = {};
                end;

                u2[u125]._humanoidDisabledStates = false;
            end;
        end;
    end;

    local model = u125.model;
    local u126;

    if model and model:IsA("Model") then
        u126 = model:FindFirstChildWhichIsA("Humanoid", true);
    else
        u126 = nil;
    end;

    if not u126 then
        return;
    end;

    local Value = u126:GetState().Value;
    u125._humanoidState = Value;

    if u3 then
        if not u2[u125] then
            u2[u125] = {};
        end;

        u2[u125]._humanoidState = Value or false;
    end;

    u125._humanoidStateConn = u126.StateChanged:Connect(function(p127, p128) -- Line: 981
        -- upvalues: u125 (copy), u3 (ref), u2 (ref)
        local v129 = u125;
        local Value2 = p128.Value;

        if v129._humanoidState == Value2 then
            return;
        end;

        v129._humanoidState = Value2;

        if not u3 then
            return;
        end;

        if not u2[v129] then
            u2[v129] = {};
        end;

        u2[v129]._humanoidState = Value2 or false;
    end);
    local v130 = GetDisabledStateMask(u126);
    u125._humanoidDisabledStates = v130;

    if u3 then
        if not u2[u125] then
            u2[u125] = {};
        end;

        u2[u125]._humanoidDisabledStates = v130 or false;
    end;

    u125._humanoidStateEnabledConn = u126.StateEnabledChanged:Connect(function() -- Line: 986
        -- upvalues: u125 (copy), GetDisabledStateMask (ref), u126 (copy), u3 (ref), u2 (ref)
        local v131 = u125;
        local v132 = GetDisabledStateMask(u126);

        if v131._humanoidDisabledStates == v132 then
            return;
        end;

        v131._humanoidDisabledStates = v132;

        if not u3 then
            return;
        end;

        if not u2[v131] then
            u2[v131] = {};
        end;

        u2[v131]._humanoidDisabledStates = v132 or false;
    end);
end;

u43 = function(p133: any, p134: boolean?) -- Line: 991, Name: RefreshHumanoidStateWatch
    -- upvalues: u3 (copy), u2 (copy), StartHumanoidStateWatch (copy)
    if not u3 then
        return;
    end;

    local entityConfig = p133.entityConfig;
    local _interpolationMode = p133._interpolationMode;

    if _interpolationMode then
        entityConfig = _interpolationMode;
    elseif entityConfig then
        entityConfig = entityConfig.INTERPOLATION_MODE;
    end;

    if entityConfig == "ALIGN" then
        if p133._humanoidStateConn and not p134 then
            return;
        end;

        StartHumanoidStateWatch(p133);

        if p133._humanoidStateConn then
            return;
        end;

        local model = p133.model;

        if model and model:IsA("Model") then
            return;
        end;

        return;
    end;

    local _humanoidStateConn = p133._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        p133._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = p133._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        p133._humanoidStateEnabledConn = nil;
    end;

    if u3 then
        if p133._humanoidState ~= nil then
            p133._humanoidState = nil;

            if u3 then
                if not u2[p133] then
                    u2[p133] = {};
                end;

                u2[p133]._humanoidState = false;
            end;
        end;

        if p133._humanoidDisabledStates == nil then
            return;
        end;

        p133._humanoidDisabledStates = nil;

        if not u3 then
            return;
        end;

        if not u2[p133] then
            u2[p133] = {};
        end;

        u2[p133]._humanoidDisabledStates = false;
    end;
end;

function u1.SetInterpolationMode(p135, p136) -- Line: 1023
    -- upvalues: u3 (copy), u2 (copy), u43 (ref), AlignDriver (copy)
    if p135._interpolationMode ~= p136 then
        p135._interpolationMode = p136;

        if u3 then
            if not u2[p135] then
                u2[p135] = {};
            end;

            u2[p135]._interpolationMode = p136 or false;
        end;
    end;

    if p136 == "ALIGN" then
        u43(p135, true);

        return;
    end;

    local _humanoidStateConn = p135._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        p135._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = p135._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        p135._humanoidStateEnabledConn = nil;
    end;

    if u3 then
        if p135._humanoidState ~= nil then
            p135._humanoidState = nil;

            if u3 then
                if not u2[p135] then
                    u2[p135] = {};
                end;

                u2[p135]._humanoidState = false;
            end;
        end;

        if p135._humanoidDisabledStates ~= nil then
            p135._humanoidDisabledStates = nil;

            if u3 then
                if not u2[p135] then
                    u2[p135] = {};
                end;

                u2[p135]._humanoidDisabledStates = false;
            end;
        end;
    end;

    if p135._alignDriver then
        AlignDriver.Destroy(p135._alignDriver);
        p135._alignDriver = nil;
    end;
end;

local function SetHumanoidState(p137: any, p138: number?) -- Line: 1037
    -- upvalues: u3 (copy), u2 (copy), u5 (copy)
    if p137._humanoidState ~= p138 then
        p137._humanoidState = p138;

        if u3 then
            if not u2[p137] then
                u2[p137] = {};
            end;

            u2[p137]._humanoidState = p138 or false;
        end;
    end;

    if u3 or (p137.isContextOwner or type(p138) ~= "number") then
        return;
    end;

    local model = p137.model;
    local v139;

    if model and model:IsA("Model") then
        v139 = model:FindFirstChildWhichIsA("Humanoid", true);
    else
        v139 = nil;
    end;

    if not v139 then
        return;
    end;

    local v140 = u5[p138];

    if not v140 then
        return;
    end;

    if v140 == Enum.HumanoidStateType.Ragdoll then
        v140 = Enum.HumanoidStateType.Physics;
    end;

    v139:ChangeState(v140);
end;

local function SetHumanoidDisabledStates(p141: any, p142: number?) -- Line: 1060
    -- upvalues: u3 (copy), u2 (copy), u5 (copy)
    if p141._humanoidDisabledStates ~= p142 then
        p141._humanoidDisabledStates = p142;

        if u3 then
            if not u2[p141] then
                u2[p141] = {};
            end;

            u2[p141]._humanoidDisabledStates = p142 or false;
        end;
    end;

    if u3 or (p141.isContextOwner or type(p142) ~= "number") then
        return;
    end;

    local model = p141.model;
    local v143;

    if model and model:IsA("Model") then
        v143 = model:FindFirstChildWhichIsA("Humanoid", true);
    else
        v143 = nil;
    end;

    if not v143 then
        return;
    end;

    for i, v in u5 do
        if v ~= Enum.HumanoidStateType.None then
            local bit32_lshift_ret = bit32.lshift(1, i);
            v143:SetStateEnabled(v, bit32.band(p142, bit32_lshift_ret) == 0);
        end;
    end;
end;

function u1.Destroy(p144) -- Line: 1082
    -- upvalues: FireEvent (copy), Holder (copy), u3 (copy), u2 (copy), AlignDriver (copy), GetPart (copy)
    p144.destroyed = true;
    FireEvent(p144, "Destroying");
    Holder.UnregisterEntity(p144);

    if p144._clientClock then
        p144._clientClock:Destroy();
    end;

    local _humanoidStateConn = p144._humanoidStateConn;

    if _humanoidStateConn then
        _humanoidStateConn:Disconnect();
        p144._humanoidStateConn = nil;
    end;

    local _humanoidStateEnabledConn = p144._humanoidStateEnabledConn;

    if _humanoidStateEnabledConn then
        _humanoidStateEnabledConn:Disconnect();
        p144._humanoidStateEnabledConn = nil;
    end;

    if u3 then
        if p144._humanoidState ~= nil then
            p144._humanoidState = nil;

            if u3 then
                if not u2[p144] then
                    u2[p144] = {};
                end;

                u2[p144]._humanoidState = false;
            end;
        end;

        if p144._humanoidDisabledStates ~= nil then
            p144._humanoidDisabledStates = nil;

            if u3 then
                if not u2[p144] then
                    u2[p144] = {};
                end;

                u2[p144]._humanoidDisabledStates = false;
            end;
        end;
    end;

    if p144._alignDriver then
        AlignDriver.Destroy(p144._alignDriver);
        p144._alignDriver = nil;
    end;

    if u3 then
        local model = p144.model;

        if model then
            pcall(function() -- Line: 50
                -- upvalues: model (copy)
                model:Destroy();
            end);
        end;
    else
        local modelReplicationMode = p144.modelReplicationMode;
        local v145 = GetPart(p144);

        if modelReplicationMode == "CUSTOM" then
            local model = p144.model;

            if model then
                pcall(function() -- Line: 50
                    -- upvalues: model (copy)
                    model:Destroy();
                end);
            end;
        elseif v145 then
            if p144._lockedCFReplication and v145 then
                local CFrame2 = v145.CFrame;
                local __CHRONO_LOCKER = v145:FindFirstChild("__CHRONO_LOCKER");

                if __CHRONO_LOCKER then
                    __CHRONO_LOCKER:Destroy();
                    v145.CFrame = CFrame2;
                end;
            end;

            v145.CFrame = CFrame.new(0, 1000000, 0);
        end;
    end;

    for _, v in p144._events or {} do
        v:DisconnectAll();
    end;

    p144.model = nil;
end;

function u1.GetEvent(p146: any, p147: string) -- Line: 534
    -- upvalues: Signal (copy)
    if not p146._events then
        p146._events = {};
    end;

    local _events = p146._events;

    if not _events[p147] then
        _events[p147] = Signal.new();
    end;

    return _events[p147].Event;
end;

Players.PlayerAdded:Connect(function(p148) -- Line: 1163
    -- upvalues: _clientOwned (copy)
    _clientOwned[p148] = {};
end);

if Players.LocalPlayer then
    _clientOwned[Players.LocalPlayer] = {};
end;

Players.PlayerRemoving:Connect(function(p149) -- Line: 1171
    -- upvalues: _clientOwned (copy)
    _clientOwned[p149] = nil;
end);
Events._Signals["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"].Event:Connect(SetValue);
u1._Changes = u2;
u1._GetPart = GetPart;
u1._SetPartCFrame = SetPartCFrame;
u1._GetRootPart = GetRootPart;
u1._LockPartPhysicsReplication = LockCFReplication;
u1._UnlockPartPhysicsReplication = UnlockCFReplication;
u1._UpdateClockBuffer = SetClock;
u1._SetHumanoidState = SetHumanoidState;
u1._SetHumanoidDisabledStates = SetHumanoidDisabledStates;

return u1;