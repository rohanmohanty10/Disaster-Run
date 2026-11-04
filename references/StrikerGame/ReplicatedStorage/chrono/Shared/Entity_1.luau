 
 

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
local AlignDriver = require(script.Parent.Parent.Client.AlignDriver);
local Warn = require(script.Parent.Warn);
local HumanoidState = require(script.Parent.HumanoidState);
local CFrameLock = require(script.Parent.CFrameLock);
local VelocityAt = InterpolationMath.VelocityAt;
local _clientOwned = Holder._clientOwned;
local u2 = RunService:IsServer();
local u3;

if u2 then
    u3 = nil;
else
    u3 = Players.LocalPlayer;
end;

local u4 = false;
Config._WaitForLock(function() -- Line: 30
    -- upvalues: u4 (ref)
    u4 = true;
end);
local RegisterChange = Holder.RegisterChange;

local function SafeDestroy(p5: userdata?) -- Line: 37
    if p5 then
        pcall(p5.Destroy, p5);
    end;
end;

local function GetPart(p6) -- Line: 43
    -- upvalues: Warn (copy)
    local model = p6.model;

    if not model then
        return nil;
    end;

    if model:IsA("BasePart") then
        return model;
    end;

    if model:IsA("Model") then
        local _chronoPrimary = p6._chronoPrimary;

        if _chronoPrimary then
            local v7 = model:FindFirstChild(_chronoPrimary);

            if v7 and v7:IsA("BasePart") then
                return v7;
            end;

            Warn.low((`Chrono primary part {_chronoPrimary} not found or not a BasePart in model {model:GetFullName()} for entity id {p6.id}. Falling back to default PrimaryPart.`));
        end;

        local PrimaryPart = model.PrimaryPart;

        if PrimaryPart then
            return PrimaryPart;
        end;
    end;

    return nil;
end;

local function GetRootPart(p8) -- Line: 71
    -- upvalues: u1 (copy), u2 (copy), CFrameLock (copy)
    local PrimaryPart = u1.GetPrimaryPart(p8);

    if PrimaryPart and (u2 and p8._lockedCFReplication) then
        return CFrameLock.GetLockedRoot(PrimaryPart);
    end;

    return PrimaryPart;
end;

local function SetPartCFrame(p9: any, p10) -- Line: 79
    -- upvalues: u1 (copy), u2 (copy), CFrameLock (copy)
    local PrimaryPart = u1.GetPrimaryPart(p9);

    if PrimaryPart and (u2 and p9._lockedCFReplication) then
        PrimaryPart = CFrameLock.GetLockedRoot(PrimaryPart);
    end;

    if PrimaryPart then
        PrimaryPart.CFrame = p10;
    end;
end;

local function FireEvent(p11: any, p12: string, ...) -- Line: 87
    local _events = p11._events;

    if not _events then
        return;
    end;

    local v13 = _events[p12];

    if v13 then
        v13:Fire(p11, ...);
    end;
end;

local function SetClock(p14, p15) -- Line: 111
    -- upvalues: ClientClock (copy)
    if p14._clientClock then
        p14._clientClock:Destroy();
        p14._clientClock = nil;
    end;

    if p15 == false then
        p14._clockBuffer = nil;
        p15 = nil;
    end;

    local v16 = p15 or p14._clockBuffer;
    p14._clockBuffer = v16;
    local v17 = v16 or (p14.entityConfig.BUFFER or 0);

    if p14.networkOwner or v16 then
        local networkOwner = p14.networkOwner;
        p14._clientClock = ClientClock.new(p14.entityConfig.TICK_RATE, `Entity id: {p14.id} plr: {networkOwner and (networkOwner.Name or "SERVER") or "SERVER"}`, v17, networkOwner);
    end;
end;

local function CheckNetworkOwner(p18: any, p19: userdata?) -- Line: 134
    -- upvalues: u3 (copy), u2 (copy), GetPart (copy), CFrameLock (copy), u1 (copy), Snapshots (copy), InterpolationMath (copy), AlignDriver (copy), SetClock (copy), FireEvent (copy), _clientOwned (copy), Events (copy)
    p18.isContextOwner = p18.networkOwner == u3;
    local v20 = p18.networkOwner == p19;

    if not v20 then
        p18.latestTime = 0;
        p18.lastClientClock = 0;
    end;

    if u2 then
        local v21 = GetPart(p18);

        if v21 then
            local _lockedCFReplication = p18._lockedCFReplication;

            if _lockedCFReplication then
                CFrameLock.Unlock(v21);
            end;

            CFrameLock.SafeSetNetworkOwner(v21, p18.networkOwner);

            if _lockedCFReplication then
                CFrameLock.Lock(v21);
                local PrimaryPart = u1.GetPrimaryPart(p18);

                if PrimaryPart and (u2 and p18._lockedCFReplication) then
                    PrimaryPart = CFrameLock.GetLockedRoot(PrimaryPart);
                end;

                if PrimaryPart then
                    CFrameLock.SafeSetNetworkOwner(PrimaryPart, p18.networkOwner);
                    PrimaryPart.Anchored = not v20;
                end;
            end;
        end;

        if p18.isContextOwner and not p18.entityConfig.STORE_SNAPSHOTS then
            p18.snapshot = nil;
        elseif not p18.snapshot then
            p18.snapshot = Snapshots(InterpolationMath.Hermite);
        end;
    else
        if p18.isContextOwner then
            AlignDriver.Clear(p18);
        end;

        if p18._lockedCFReplication and p18.isContextOwner then
            local v22 = GetPart(p18);

            if v22 then
                CFrameLock.Lock(v22);
                p18._cfLockFailed = nil;
            else
                p18._cfLockFailed = true;
            end;

            if p18._player then
                CFrameLock.Unlock(v22);
            end;
        end;
    end;

    if v20 then
        return;
    end;

    if p18.snapshot then
        p18.snapshot:Clear();
    end;

    if not u2 then
        SetClock(p18);
    end;

    FireEvent(p18, "NetworkOwnerChanged", p18.networkOwner, p19);
    local v23 = p19 and _clientOwned[p19];

    if v23 then
        v23[p18] = nil;
        Events._Signals.PlayerOwnedRemoved:Fire(p19, p18);
    end;

    if p18.networkOwner then
        local v24 = _clientOwned[p18.networkOwner];

        if not v24 then
            return;
        end;

        v24[p18] = true;
        Events._Signals.PlayerOwnedAdded:Fire(p18.networkOwner, p18);
    end;
end;

local function SetEntityNetworkOwner(p25: any, p26: userdata?) -- Line: 218
    -- upvalues: RegisterChange (copy), CheckNetworkOwner (copy), u1 (copy), u2 (copy)
    if p26 ~= p25.networkOwner then
        local networkOwner = p25.networkOwner;
        RegisterChange(p25, "networkOwner", p26);
        CheckNetworkOwner(p25, networkOwner);
        u1.Clear(p25);
    end;

    p25.lastCheckedCFrame = nil;
    local v27 = not u2 and (p25.modelReplicationMode == "CUSTOM" and u1.GetPrimaryPart(p25));

    if v27 then
        v27.Anchored = not p25.isContextOwner;
    end;
end;

local function CheckModelReplicationMode(p28, p29) -- Line: 235
    -- upvalues: Warn (copy)
    local v30 = (p29 or p28.modelReplicationMode or p28.entityConfig.MODEL_REPLICATION_MODE):upper();

    if v30 ~= "NATIVE" and (v30 ~= "CUSTOM" and v30 ~= "NATIVE_WITH_LOCK") then
        Warn.medium((`Invalid model replication mode {v30} for entity id {p28.id}, defaulting to NATIVE`));
        v30 = "NATIVE";
    end;

    p28._lockedCFReplication = false;

    if v30 == "NATIVE_WITH_LOCK" then
        p28._lockedCFReplication = true;
        v30 = "NATIVE";
    end;

    return v30;
end;

local function SetModel(p31: any, p32: any, p33: any, p34: boolean?) -- Line: 256
    -- upvalues: u2 (copy), GetPart (copy), CFrameLock (copy), Config (copy), CheckModelReplicationMode (copy), Holder (copy), Warn (copy), u1 (copy)
    local v35 = p31.modelReplicationMode == "CUSTOM";

    if u2 then
        if p31.modelReplicationMode == "NATIVE" and p31._lockedCFReplication then
            local v36 = GetPart(p31);
            p31._lockedCFReplication = false;
            CFrameLock.Unlock(v36);
        end;

        local v37 = not p34 and p31.model;

        if v37 then
            pcall(v37.Destroy, v37);
        end;

        p31.model = nil;
    elseif u2 or not v35 then
        if not u2 and p31._lockedCFReplication then
            local v38 = GetPart(p31);
            p31._lockedCFReplication = false;
            CFrameLock.Unlock(v38);
        end;
    else
        local model = p31.model;

        if model then
            pcall(model.Destroy, model);
        end;

        p31.model = nil;
    end;

    local v39;

    if type(p32) == "string" then
        v39 = Config._GetEntityModel(p32);

        if v39 then
            v39 = v39:Clone();
        end;

        if v39 then
            v39.Parent = workspace;
        end;
    else
        v39 = p32;
        p32 = nil;
    end;

    local v40 = Config._GetBroadPhase(p32);
    local v41 = CheckModelReplicationMode(p31, p33);
    p31.modelString = p32;
    p31.model = v39;

    if u2 or not p31.broadPhase then
        p31.broadPhase = v40;
    end;

    if v39 then
        if v41 == "CUSTOM" then
            v39.Parent = Holder.GetEntityStorageInstance();
        end;

        local Attribute = v39:GetAttribute("__CHRONO_PRIMARY");

        if Attribute and type(Attribute) == "string" then
            p31._chronoPrimary = Attribute;
        end;
    end;

    p31.modelReplicationMode = v41;
    local v42 = GetPart(p31);

    if v39 and not v42 then
        (u2 and Warn.high or Warn.low)((`{v39:GetFullName()} must have a PrimaryPart set for things like autoReplication and movement.`));
    elseif v39 and not v39.Archivable then
        Warn.low((`{v39:GetFullName()} is not Archivable. It is recommended to set Archivable to true for entity models to prevent potential issues when cloning. Archivable has been set to true automatically.`));
        v39.Archivable = true;
    end;

    if not v42 then
        return;
    end;

    if not p31.latestCFrame then
        u1.SetCFrame(p31, v42.CFrame);
    end;

    if p31.latestCFrame then
        v42.CFrame = p31.latestCFrame;
    end;

    p31.modelReplicationMode = u1.GetModelReplicationType(p31);

    if p31.modelReplicationMode == "NATIVE_WITH_LOCK" then
        p31._lockedCFReplication = true;
        p31.modelReplicationMode = "NATIVE";
    end;

    if not (u2 or (p31.isContextOwner or v41 ~= "CUSTOM" and not p31._lockedCFReplication)) then
        v42.Anchored = true;
    end;
end;

function u1._new(p43: string?, p44: any, p45: any, p46) -- Line: 351
    -- upvalues: Config (copy), Warn (copy), u2 (copy), u3 (copy), Snapshots (copy), InterpolationMath (copy), SetModel (copy), HumanoidState (copy), CheckNetworkOwner (copy)
    local v47 = Config._GetEntityType(p43);

    if not v47 then
        Warn.medium((`Entity config {p43} not found. Using DEFAULT config.`));
        v47 = Config._GetEntityType("DEFAULT");
    end;

    if p46 == nil and (typeof(p44) == "string" and Config._GetEntityModel(p44) == false) then
        Warn.medium("Entity\'s model doesn\'t exist, initCFrame is required. DEFAULTING to CFrame.new(0, 0, 0)");
        p46 = CFrame.new(0, 0, 0);
    end;

    local v48 = {
        id = -1,
        registered = false,
        isContextOwner = false,
        networkOwner = nil,
        paused = false,
        destroyed = false,
        autoUpdatePosition = v47.AUTO_UPDATE_POSITION ~= false,
        latestCFrame = p46,
        entityConfig = v47,
        interpolation = not u2 and true
    };

    if u3 then
        v48.snapshot = Snapshots(InterpolationMath.Hermite);
    end;

    SetModel(v48, p44, p45);
    HumanoidState.Refresh(v48, true);
    CheckNetworkOwner(v48, nil);

    return v48;
end;

function u1.new(p49: string?, p50: any, p51: any, p52) -- Line: 408
    -- upvalues: u4 (ref), u1 (copy), Holder (copy)
    if not u4 then
        error("Entity.new cannot be called until Chrono.Start() is called.");
    end;

    local v53 = u1._new(p49, p50, p51, p52);
    Holder.RegisterEntity(v53);

    return v53;
end;

function u1.Destroy(p54) -- Line: 425
    -- upvalues: FireEvent (copy), Holder (copy), HumanoidState (copy), AlignDriver (copy), u2 (copy), GetPart (copy), CFrameLock (copy)
    p54.destroyed = true;
    FireEvent(p54, "Destroying");
    Holder.UnregisterEntity(p54);

    if p54._clientClock then
        p54._clientClock:Destroy();
    end;

    HumanoidState.Stop(p54);
    AlignDriver.Clear(p54);

    if u2 then
        local model = p54.model;

        if model then
            pcall(model.Destroy, model);
        end;
    else
        local modelReplicationMode = p54.modelReplicationMode;
        local v55 = GetPart(p54);

        if modelReplicationMode == "CUSTOM" then
            local model = p54.model;

            if model then
                pcall(model.Destroy, model);
            end;
        elseif v55 then
            if p54._lockedCFReplication then
                CFrameLock.Unlock(v55);
            end;

            v55.CFrame = CFrame.new(0, 1000000, 0);
        end;
    end;

    for _, v in p54._events or {} do
        v:DisconnectAll();
    end;

    p54.model = nil;
end;

function u1.SetModel(p56: any, p57: any, p58: any, p59: boolean?) -- Line: 466
    -- upvalues: SetModel (copy), u2 (copy), ModelHelper (copy), RegisterChange (copy), CheckNetworkOwner (copy), HumanoidState (copy), FireEvent (copy)
    local model = p56.model;
    SetModel(p56, p57, p58, p59);

    if u2 then
        local v60 = ModelHelper.ReadyModelFromRep(p56, nil);
        RegisterChange(p56, "model", p56.model, true, v60 or false);
        CheckNetworkOwner(p56, p56.networkOwner);
    end;

    HumanoidState.Refresh(p56, true);
    FireEvent(p56, "ModelChanged", p56.model, model);
end;

function u1.GetModel(p61) -- Line: 488
    return p61.model;
end;

function u1.GetPrimaryPart(p62) -- Line: 497
    -- upvalues: GetPart (copy)
    if p62.model then
        return GetPart(p62);
    end;

    return nil;
end;

function u1.GetModelReplicationType(p63) -- Line: 508
    return (p63.modelReplicationMode or p63.entityConfig.MODEL_REPLICATION_MODE) == "CUSTOM" and "CUSTOM" or (p63._lockedCFReplication and "NATIVE_WITH_LOCK" or "NATIVE");
end;

function u1.LockNativeServerCFrameReplication(p64) -- Line: 530
    -- upvalues: u2 (copy), RegisterChange (copy), CheckNetworkOwner (copy), FireEvent (copy)
    if not u2 then
        error("LockNativeServerCFrameReplication can only be called on the server");

        return;
    end;

    if p64.modelReplicationMode ~= "NATIVE" then
        error("LockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
    end;

    if p64._lockedCFReplication then
        return;
    end;

    RegisterChange(p64, "_lockedCFReplication", true);
    CheckNetworkOwner(p64, p64.networkOwner);
    FireEvent(p64, "LockChanged", true);
end;

function u1.UnlockNativeServerCFrameReplication(p65) -- Line: 555
    -- upvalues: u2 (copy), RegisterChange (copy), GetPart (copy), CFrameLock (copy), CheckNetworkOwner (copy), FireEvent (copy)
    if not u2 then
        error("UnlockNativeServerCFrameReplication can only be called on the server");

        return;
    end;

    if p65.modelReplicationMode ~= "NATIVE" then
        error("UnlockNativeServerCFrameReplication can only be called on NATIVE model replication mode entities");
    end;

    if not p65._lockedCFReplication then
        return;
    end;

    RegisterChange(p65, "_lockedCFReplication", false);
    local v66 = GetPart(p65);
    CFrameLock.Unlock(v66);
    CheckNetworkOwner(p65, p65.networkOwner);
    FireEvent(p65, "LockChanged", false);
end;

function u1.Push(p67: any, p68: number, p69, p70: vector?) -- Line: 583
    -- upvalues: u2 (copy), u1 (copy), Warn (copy), VelocityAt (copy), FireEvent (copy)
    local snapshot = p67.snapshot;
    local v71 = not p67.latestTime or p67.latestTime < p68;

    if v71 then
        p67.latestTime = p68;
        p67.latestCFrame = p69;
    end;

    if snapshot then
        local Latest = snapshot:GetLatest();

        if not u2 and (v71 and (Latest and (p68 - Latest.t < 5 and not p67.isContextOwner))) then
            local v72 = u1.GetTargetRenderTime(p67) - Latest.t;

            if math.abs(v72) > 5 then
                snapshot:Clear();
                Warn.low("Clearing Snapshot due to large time difference");
            end;
        end;

        local TICK_RATE = p67.entityConfig.TICK_RATE;

        if p67.isHalfTicked then
            TICK_RATE = TICK_RATE * 2;
        end;

        snapshot:PushWithCheck(p68, p69, p70 or VelocityAt(snapshot:GetLatest(), p68, p69, TICK_RATE), TICK_RATE);
    end;

    FireEvent(p67, "PushedSnapShot", p68, p69, v71);

    return v71;
end;

function u1.GetAt(p73: any, p74: number) -- Line: 619
    local snapshot = p73.snapshot;

    if snapshot then
        return snapshot:GetAt(p74);
    end;

    return p73.latestCFrame;
end;

function u1.GetTargetRenderTime(p75) -- Line: 633
    local _clientClock = p75._clientClock;

    if not _clientClock then
        local CLIENT_CLOCK = p75.entityConfig.CLIENT_CLOCK;

        if not CLIENT_CLOCK then
            return -1;
        end;

        _clientClock = p75.isHalfTicked and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL;
    end;

    return not _clientClock and -1 or _clientClock:GetTargetRenderTime();
end;

function u1.GetCFrame(p76) -- Line: 654
    -- upvalues: GetPart (copy)
    local v77 = GetPart(p76);
    local latestCFrame = p76.latestCFrame;

    if latestCFrame then
        v77 = latestCFrame;
    elseif v77 then
        v77 = v77.CFrame;
    end;

    return v77;
end;

function u1.SetCFrame(p78: any, p79) -- Line: 664
    -- upvalues: Config (copy), u2 (copy), u1 (copy), RegisterChange (copy), CFrameLock (copy)
    local v80 = (p78.latestTime or 0) + 0.00002;

    if Config.FLAGS.SET_CFRAME_FIX then
        if u2 or p78.networkOwner then
            p78._teleport = os.clock();
        end;

        if not (u2 or p78.isContextOwner) then
            u1.Clear(p78);
        end;
    end;

    if p78.snapshot and Config.FLAGS.FIX_TELEPORT_JITTER then
        p78.snapshot.lockedTime = v80;
    end;

    u1.Push(p78, v80, p79);
    RegisterChange(p78, "latestCFrame", p79, true);

    if p78.isContextOwner or not u2 then
        local PrimaryPart = u1.GetPrimaryPart(p78);

        if PrimaryPart and (u2 and p78._lockedCFReplication) then
            PrimaryPart = CFrameLock.GetLockedRoot(PrimaryPart);
        end;

        if PrimaryPart then
            PrimaryPart.CFrame = p79;
        end;
    end;
end;

function u1.Clear(p81) -- Line: 688
    local snapshot = p81.snapshot;
    p81.latestTime = nil;
    p81.lastClientClock = nil;

    if snapshot then
        snapshot:Clear();
    end;
end;

function u1.SetAutoUpdatePos(p82: any, p83: boolean) -- Line: 702
    -- upvalues: RegisterChange (copy)
    RegisterChange(p82, "autoUpdatePosition", p83);
end;

function u1.SetNetworkOwner(p84: any, p85: userdata?) -- Line: 712
    -- upvalues: u2 (copy), SetEntityNetworkOwner (copy), RegisterChange (copy)
    if not u2 or p85 == p84.networkOwner then
        if not u2 then
            error("SetNetworkOwner can only be called on the server");
        end;

        return;
    end;

    SetEntityNetworkOwner(p84, p85);
    RegisterChange(p84, "isHalfTicked", p84.isHalfTicked, true);
end;

function u1.SyncOwnerShip(p86) -- Line: 721
    -- upvalues: CheckNetworkOwner (copy)
    CheckNetworkOwner(p86, p86.networkOwner);
end;

function u1.SetConfig(p87: any, p88: string) -- Line: 731
    -- upvalues: Config (copy), Warn (copy), RegisterChange (copy), HumanoidState (copy), u2 (copy), SetClock (copy)
    local v89 = Config._GetEntityType(p88);

    if not v89 then
        Warn.medium((`Entity config {p88} not found. Using Default config.`));
        v89 = Config._GetEntityType("DEFAULT");
    end;

    RegisterChange(p87, "entityConfig", v89, false, v89.NAME);
    HumanoidState.Refresh(p87);

    if u2 then
        return;
    end;

    local _clientClock = p87._clientClock;

    if not _clientClock then
        SetClock(p87);

        return;
    end;

    local TICK_RATE = v89.TICK_RATE;
    _clientClock._baseTickRate = TICK_RATE;

    if p87.isHalfTicked then
        TICK_RATE = TICK_RATE * 2;
    end;

    _clientClock:SetTickRate(TICK_RATE);
    _clientClock:UpdateBuffer(p87._clockBuffer or (v89.BUFFER or 0));
end;

function u1.SetClockBuffer(p90: any, p91: number?) -- Line: 758
    -- upvalues: u2 (copy), SetClock (copy)
    if u2 then
        error("SetClockBuffer can only be called on the client");
    end;

    local _clientClock = p90._clientClock;

    if _clientClock and (p90.networkOwner or p91 ~= nil) then
        p90._clockBuffer = p91;
        _clientClock:UpdateBuffer(p91 or (p90.entityConfig.BUFFER or 0));

        return;
    end;

    local CLIENT_CLOCK = p90.entityConfig.CLIENT_CLOCK;

    if CLIENT_CLOCK then
        CLIENT_CLOCK = p90.isHalfTicked and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL;
    end;

    if p91 == nil or not p91 then
        p91 = false;
    end;

    SetClock(p90, p91);
    local _clientClock2 = p90._clientClock;

    if _clientClock2 and (not p90.networkOwner and (CLIENT_CLOCK and CLIENT_CLOCK.lastClockAt)) then
        _clientClock2.lastClockAt = CLIENT_CLOCK.lastClockAt;
        _clientClock2.lastClockDuration = CLIENT_CLOCK.lastClockDuration;
        _clientClock2.offset = CLIENT_CLOCK.offset;
        _clientClock2.offsetAt = CLIENT_CLOCK.offsetAt;
        _clientClock2.renderAt = CLIENT_CLOCK.renderAt;
    end;
end;

function u1.SetInterpolationMode(p92, p93) -- Line: 788
    -- upvalues: RegisterChange (copy), HumanoidState (copy), AlignDriver (copy)
    RegisterChange(p92, "_interpolationMode", p93);

    if p93 == "ALIGN" then
        HumanoidState.Refresh(p92, true);

        return;
    end;

    HumanoidState.Stop(p92);
    AlignDriver.Clear(p92);
end;

function u1.SetBroadPhase(p94: any, p95: vector?) -- Line: 804
    -- upvalues: RegisterChange (copy)
    RegisterChange(p94, "broadPhase", p95);
end;

function u1._SetTickMode(p96: any, p97: boolean?) -- Line: 808
    -- upvalues: RegisterChange (copy), FireEvent (copy)
    if p96.isHalfTicked == p97 then
        return;
    end;

    if p96.isContextOwner then
        p96.isHalfTicked = p97;
    else
        RegisterChange(p96, "isHalfTicked", p97);
    end;

    FireEvent(p96, "TickChanged", p97 == nil and "NONE" or (p97 and "HALF" or "NORMAL"));
end;

function u1.GetData(p98) -- Line: 826
    return p98._data;
end;

function u1.SetData(p99, p100) -- Line: 835
    -- upvalues: RegisterChange (copy), FireEvent (copy)
    RegisterChange(p99, "_data", p100, true);
    FireEvent(p99, "DataChanged", p100);
end;

function u1.PauseReplication(p101) -- Line: 843
    -- upvalues: RegisterChange (copy)
    RegisterChange(p101, "paused", true);
end;

function u1.ResumeReplication(p102) -- Line: 850
    -- upvalues: RegisterChange (copy)
    RegisterChange(p102, "paused", false);
end;

function u1.SetMount(p103: any, p104: any, p105) -- Line: 861
    -- upvalues: u2 (copy), u1 (copy), Warn (copy), RegisterChange (copy), Events (copy)
    if not u2 then
        error("SetMount can only be called on the server");
    end;

    if p104 == nil then
        return u1.ClearMount(p103);
    end;

    if p103 == p104 then
        Warn.medium("An entity cannot mount itself");

        return;
    end;

    if not p104.registered then
        Warn.high("Parent entity must be registered before mounting");

        return;
    end;

    RegisterChange(p103, "mountParentId", p104.id);
    RegisterChange(p103, "mountOffset", p105);
    Events._Signals.EntityMountChanged:Fire(p103, p104.id);
end;

function u1.ClearMount(p106) -- Line: 888
    -- upvalues: u2 (copy), RegisterChange (copy), Events (copy)
    if not u2 then
        error("ClearMount can only be called on the server");
    end;

    if not p106.mountParentId then
        return;
    end;

    RegisterChange(p106, "mountParentId", nil);
    RegisterChange(p106, "mountOffset", nil);
    Events._Signals.EntityMountChanged:Fire(p106, nil);
end;

function u1.GetEvent(p107: any, p108: string) -- Line: 98
    -- upvalues: Signal (copy)
    if not p107._events then
        p107._events = {};
    end;

    local _events = p107._events;

    if not _events[p108] then
        _events[p108] = Signal.new();
    end;

    return _events[p108].Event;
end;

Players.PlayerAdded:Connect(function(p109) -- Line: 947
    -- upvalues: _clientOwned (copy)
    _clientOwned[p109] = {};
end);

if Players.LocalPlayer then
    _clientOwned[Players.LocalPlayer] = {};
end;

Players.PlayerRemoving:Connect(function(p110) -- Line: 955
    -- upvalues: _clientOwned (copy)
    _clientOwned[p110] = nil;
end);
u1._FireEvent = FireEvent;
u1._GetPart = GetPart;
u1._SetPartCFrame = SetPartCFrame;
u1._GetRootPart = GetRootPart;
u1._LockPartPhysicsReplication = CFrameLock.Lock;
u1._UnlockPartPhysicsReplication = CFrameLock.Unlock;
u1._UpdateClockBuffer = SetClock;
u1._SetHumanoidState = HumanoidState.SetState;
u1._SetHumanoidDisabledStates = HumanoidState.SetDisabledStates;
u1._SetEntityNetworkOwner = SetEntityNetworkOwner;

return u1;