 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Shared = script.Parent.Parent.Shared;
local ApplyMounts = require(Shared.ApplyMounts);
local Warn = require(Shared.Warn);
local Bin = require(Shared.Bin);
local Holder = require(Shared.Holder);
local Events = require(Shared.Events);
local Ticker = require(Shared.Ticker);
local Config = require(Shared.Config);
require(Shared.Types);
local Entity = require(Shared.Entity);
local EntityGrid = require(script.Parent.EntityGrid);
require(script.Parent.Player);
local Sender = require(script.Parent.Sender);
local Receiver = require(script.Parent.Receiver);
local SERVER = require(Shared.Stats).SERVER;
local Heartbeat = Shared.Remotes.Heartbeat;
local ClientClockRelay = Shared.Remotes.ClientClockRelay;
local u1 = 0;
local u2 = 0;
local u3 = {};
Config._WaitForLock(function() -- Line: 34
    -- upvalues: Config (copy), u3 (copy), Warn (copy)
    for _, v in Config._EntityConfigs do
        if v.TICKER then
            table.insert(u3, v.TICKER);
        else
            Warn.high(v, "TICKERS not found on server config load");
        end;
    end;
end);

local function FireEvent(p4: any, p5: string, ...) -- Line: 44
    local _events = p4._events;

    if not _events then
        return;
    end;

    local v6 = _events[p5];

    if v6 then
        v6:Fire(p4, ...);
    end;
end;

local function MapRotation(p7: number) -- Line: 60
    return math.round((p7 + 3.141592653589793) / 0.00009587526218325454);
end;

local function SerializeFull(p8: buffer, p9, p10: number) -- Line: 64
    local X = p9.X;
    local Y = p9.Y;
    local Z = p9.Z;
    local v11, v12, v13 = p9:ToOrientation();
    buffer.writef32(p8, p10, X);
    local v14 = p10 + 4;
    buffer.writef32(p8, v14, Y);
    local v15 = v14 + 4;
    buffer.writef32(p8, v15, Z);
    local v16 = v15 + 4;
    local math_round_ret = math.round((v11 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p8, v16, math_round_ret);
    local v17 = v16 + 2;
    local math_round_ret2 = math.round((v12 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p8, v17, math_round_ret2);
    local v18 = v17 + 2;
    local math_round_ret3 = math.round((v13 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p8, v18, math_round_ret3);

    return v18 + 2;
end;

local function SerializeYaw(p19: buffer, p20, p21: number) -- Line: 82
    local X = p20.X;
    local Y = p20.Y;
    local Z = p20.Z;
    local _, v22, _ = p20:ToOrientation();
    buffer.writef32(p19, p21, X);
    local v23 = p21 + 4;
    buffer.writef32(p19, v23, Y);
    local v24 = v23 + 4;
    buffer.writef32(p19, v24, Z);
    local v25 = v24 + 4;
    local math_round_ret = math.round((v22 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p19, v25, math_round_ret);

    return v25 + 2;
end;

local function CFrameChanged(p26, p27) -- Line: 96
    if p26 == p27 then
        return false;
    end;

    return (p26 == nil or p27 == nil) and true or p26:FuzzyEq(p27, 0.0001) == false;
end;

local function PushLatest(p28: any, p29: number) -- Line: 106
    -- upvalues: Entity (copy), Warn (copy)
    if p28.autoUpdatePosition and (p28.isContextOwner and p28.model) then
        local PrimaryPart = Entity.GetPrimaryPart(p28);

        if not PrimaryPart then
            Warn.low("Entity", p28, "has no primary part");

            return;
        end;

        Entity.Push(p28, p29, PrimaryPart.CFrame);
    end;
end;

local function CheckForChanges(p30) -- Line: 118
    local lastCheckedCFrame = p30.lastCheckedCFrame;
    local latestCFrame = p30.latestCFrame;
    local v31;

    if lastCheckedCFrame == latestCFrame then
        v31 = false;
    else
        v31 = (lastCheckedCFrame == nil or latestCFrame == nil) and true or lastCheckedCFrame:FuzzyEq(latestCFrame, 0.0001) == false;
    end;

    if not v31 then
        return nil;
    end;

    p30.lastCheckedCFrame = latestCFrame;

    return latestCFrame;
end;

local function CheckEntity(p32: any, p33: any, p34: boolean, p35: boolean) -- Line: 129
    -- upvalues: Ticker (copy), FireEvent (copy), PushLatest (copy), SerializeFull (copy)
    if p32.destroyed then
        Ticker.Remove(p33, p32);

        return;
    end;

    if not p32.isContextOwner then
        return;
    end;

    local isHalfTicked = p32.isHalfTicked;

    if isHalfTicked and not p35 or p32.paused then
        p32.cframeBuffer = nil;

        return;
    end;

    if isHalfTicked then
        FireEvent(p32, "Ticked", p33.halfdt);
    else
        FireEvent(p32, "Ticked", p33.dt);
    end;

    PushLatest(p32, p33.lastTicked);
    local lastCheckedCFrame = p32.lastCheckedCFrame;
    local latestCFrame = p32.latestCFrame;
    local v36;

    if lastCheckedCFrame == latestCFrame then
        v36 = false;
    else
        v36 = (lastCheckedCFrame == nil or latestCFrame == nil) and true or lastCheckedCFrame:FuzzyEq(latestCFrame, 0.0001) == false;
    end;

    if v36 then
        p32.lastCheckedCFrame = latestCFrame;
    else
        latestCFrame = nil;
    end;

    if not latestCFrame then
        p32.cframeBuffer = nil;

        return;
    end;

    if p32.id == 0 then
        error("Entity Should not have and id of 0");
    end;

    if p34 then
        local buffer_create_ret = buffer.create(20);
        buffer.writeu16(buffer_create_ret, 0, p32.id);
        SerializeFull(buffer_create_ret, latestCFrame, 2);
        p32.cframeBuffer = buffer_create_ret;

        return;
    end;

    local buffer_create_ret = buffer.create(16);
    buffer.writeu16(buffer_create_ret, 0, p32.id);
    local v37 = 2;
    local X = latestCFrame.X;
    local Y = latestCFrame.Y;
    local Z = latestCFrame.Z;
    local _, v38, _ = latestCFrame:ToOrientation();
    buffer.writef32(buffer_create_ret, v37, X);
    local v39 = v37 + 4;
    buffer.writef32(buffer_create_ret, v39, Y);
    local v40 = v39 + 4;
    buffer.writef32(buffer_create_ret, v40, Z);
    local v41 = v40 + 4;
    local math_round_ret = math.round((v38 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(buffer_create_ret, v41, math_round_ret);
    local _ = v41 + 2;
    p32.cframeBuffer = buffer_create_ret;
end;

local u42 = {};

local function CheckEntityChanges() -- Line: 176
    -- upvalues: Entity (copy), u42 (copy)
    for i, v in Entity._Changes do
        local v43 = {
            id = i.id,
            data = {}
        };
        local v44 = i;

        for i2, v2 in v do
            table.insert(v43.data, { i2, v2 or v44[i2] });
        end;

        Entity._Changes[v44] = nil;
        v44._changes = v43;
        table.insert(u42, v44);
    end;
end;

local u45 = 0;
local u46 = 0;

local function UpdateTickers() -- Line: 192
    -- upvalues: u3 (copy), Ticker (copy), CheckEntity (copy), u45 (ref), u46 (ref), SERVER (copy)
    debug.profilebegin("UpdateTickers");
    local os_clock_ret = os.clock();

    for _, v in u3 do
        if next(v.objects) then
            debug.profilebegin((`{v.config.NAME}`));

            if Ticker.CheckUpdate(v) then
                local v47 = v.config.FULL_ROTATION == true;
                local tickedHalf = v.tickedHalf;
                local v48 = v;

                for _, v2 in v.objects do
                    CheckEntity(v2, v48, v47, tickedHalf);
                end;
            end;

            debug.profileend();
        end;
    end;

    debug.profileend();
    u45 = u45 + (os.clock() - os_clock_ret);
    u46 = u46 + 1;
    SERVER.AVG_TICKER_TIME_MS = u45 / u46 * 1000;

    if u46 >= 60 then
        u45 = 0;
        u46 = 0;
    end;
end;

local function UpdatePlayerPositions() -- Line: 224
    -- upvalues: Holder (copy), Entity (copy), EntityGrid (copy)
    for _, v in Holder._playerChars do
        local networkOwner = v.networkOwner;
        local PrimaryPart = Entity.GetPrimaryPart(v);
        local v49 = PrimaryPart and PrimaryPart.CFrame or v.latestCFrame;

        if networkOwner and v49 then
            EntityGrid.UpdatePlayerPosition(networkOwner, v49.Position);
        end;
    end;
end;

local function updateEntityStats() -- Line: 236
    -- upvalues: SERVER (copy), Holder (copy), Entity (copy)
    if not SERVER._SHOULD_REPLICATE then
        SERVER.SERVER_ENTITIES = {};

        return;
    end;

    local v50 = {};

    for _, v in Holder.idMap do
        local entityConfig = v.entityConfig;
        local v51 = 1 / entityConfig.TICK_RATE;
        local isHalfTicked = v.isHalfTicked;
        local v52;

        if v.latestCFrame then
            v52 = v.latestCFrame.Position or nil;
        else
            v52 = nil;
        end;

        local v53;

        if isHalfTicked == true then
            v53 = v51 / 2;
        else
            v53 = isHalfTicked == nil and 0 or v51;
        end;

        local v54 = v53 // 1;
        local v55 = {
            isPaused = v.paused,
            id = v.id,
            networkOwner = v.networkOwner,
            isCharacter = v._player ~= nil,
            config = entityConfig and (entityConfig.NAME or "DEFAULT") or "DEFAULT",
            tickRate = (v54 ~= v54 or v54 == (1 / 0)) and 0 or v54,
            lastTicked = v.latestTime,
            lastPosition = v52,
            modelType = Entity.GetModelReplicationType(v),
            interpolationMode = v._interpolationMode or (v.entityConfig.INTERPOLATION_MODE or "CFRAME")
        };
        table.insert(v50, v55);
    end;

    SERVER.SERVER_ENTITIES = v50;
end;

local function UpdateHeartbeat() -- Line: 280
    -- upvalues: u1 (ref), Players (copy), EntityGrid (copy), Heartbeat (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - u1 >= 0.1 then
        u1 = os_clock_ret;

        for _, v in Players:GetPlayers() do
            if EntityGrid.GetEntityHolder(v) then
                Heartbeat:FireClient(v, os_clock_ret);
            end;
        end;
    end;
end;

local function UpdateClientClockRelay() -- Line: 293
    -- upvalues: u2 (ref), Receiver (copy), ClientClockRelay (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - u2 < 60 then
        return;
    end;

    u2 = os_clock_ret;
    local v56 = Receiver._GetClientClockRaws();

    if #v56 == 0 then
        return;
    end;

    ClientClockRelay:FireAllClients(v56);
end;

local function Update() -- Line: 308
    -- upvalues: EntityGrid (copy), UpdatePlayerPositions (copy), ApplyMounts (copy), UpdateTickers (copy), CheckEntityChanges (copy), UpdateHeartbeat (copy), u2 (ref), Receiver (copy), ClientClockRelay (copy), Players (copy), Sender (copy), u42 (copy), updateEntityStats (copy), Ticker (copy)
    EntityGrid.Update();
    UpdatePlayerPositions();
    ApplyMounts();
    UpdateTickers();
    CheckEntityChanges();
    UpdateHeartbeat();
    local os_clock_ret = os.clock();

    if os_clock_ret - u2 >= 60 then
        u2 = os_clock_ret;
        local v57 = Receiver._GetClientClockRaws();

        if #v57 ~= 0 then
            ClientClockRelay:FireAllClients(v57);
        end;
    end;

    for _, v in Players:GetPlayers() do
        Sender.ReplicatePlayer(v);
    end;

    for _, v in u42 do
        v._changes = nil;
    end;

    table.clear(u42);
    updateEntityStats();
    Ticker._IncrementGlobalTick();
end;

local function HandleEntity(p58, u59) -- Line: 328
    -- upvalues: Bin (copy), Entity (copy)
    local u60, u61 = Bin();

    local function HandleModel(u62) -- Line: 331
        -- upvalues: Entity (ref), u60 (copy)
        if not u62.model then
            return;
        end;

        local u63 = Entity._GetRootPart(u62);

        if not u63 then
            return;
        end;

        local function v64() -- Line: 342
            -- upvalues: u63 (copy), u62 (copy), Entity (ref)
            local CFrame = u63.CFrame;

            if u62.mountParentId then
                u62.latestCFrame = CFrame;

                return;
            end;

            if CFrame == u62.latestCFrame then
                return;
            end;

            Entity.SetCFrame(u62, CFrame);
        end;

        u60(u63:GetPropertyChangedSignal("CFrame"):Connect(v64));
    end;

    local v65, u66 = Bin();
    v65(Entity.GetEvent(u59, "ModelChanged"):Connect(function() -- Line: 358
        -- upvalues: u61 (copy), HandleModel (copy), u59 (copy)
        u61();
        HandleModel(u59);
    end));
    v65(Entity.GetEvent(u59, "LockChanged"):Connect(function() -- Line: 362
        -- upvalues: u61 (copy), HandleModel (copy), u59 (copy)
        u61();
        HandleModel(u59);
    end));
    local u67 = nil;
    local u68 = Entity.GetEvent(u59, "NetworkOwnerChanged"):Once(function() -- Line: 367
        -- upvalues: u61 (copy), u66 (copy), u67 (ref)
        u61();
        u66();
        u67:Disconnect();
    end);
    u67 = Entity.GetEvent(u59, "Destroying"):Once(function() -- Line: 373
        -- upvalues: u61 (copy), u66 (copy), u68 (copy)
        u61();
        u66();
        u68:Disconnect();
    end);
    HandleModel(u59);
end;

local function HandleCFrameSetters() -- Line: 382
    -- upvalues: Config (copy), Events (copy), HandleEntity (copy), Holder (copy)
    local v69 = Config._GetConfig("REPLICATE_CFRAME_SETTERS");

    if v69 == "NONE" then
        return;
    end;

    if v69 == "PLAYER_ENTITIES" then
        Events.PlayerOwnedAdded:Connect(HandleEntity, true);
    else
        Events.PlayerCharacterRegistered:Connect(HandleEntity, true);
    end;

    for _, v in Holder.idMap do
        if v69 == "PLAYER_ENTITIES" and v.networkOwner then
            HandleEntity(v.networkOwner, v);
        elseif v69 == "PLAYER_CHARACTERS" and v._player then
            HandleEntity(v._player, v);
        end;
    end;
end;

local function PlayerAdded(p70: userdata) -- Line: 402
    -- upvalues: Receiver (copy), ClientClockRelay (copy)
    ClientClockRelay:FireAllClients((Receiver._GetClientClockRaws()));
end;

Config._WaitForLock(function() -- Line: 407
    -- upvalues: RunService (copy), HandleCFrameSetters (copy), Events (copy), PlayerAdded (copy), Update (copy)
    if not RunService:IsServer() then
        return;
    end;

    HandleCFrameSetters();
    Events._Signals.PlayerLoaded.Event:Connect(PlayerAdded);
    RunService.PostSimulation:Connect(Update);
end);

return nil;