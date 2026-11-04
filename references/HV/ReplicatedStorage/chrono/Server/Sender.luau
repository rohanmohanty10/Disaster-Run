 

 

local RunService = game:GetService("RunService");
local Ticker = require(script.Parent.Parent.Shared.Ticker);
local Entity = require(script.Parent.Parent.Shared.Entity);
local EntityGrid = require(script.Parent.EntityGrid);
require(script.Parent.Parent.Shared.Types);
local Shared = script.Parent.Parent.Shared;
local ModelHelper = require(Shared.ModelHelper);
local ClockUnwrap = require(Shared.ClockUnwrap);
local SERVER = require(Shared.Stats).SERVER;
local u1 = 0;
local u2 = 0;
local buffer_create_ret = buffer.create(951);
local Replicate = Shared.Remotes.Replicate;
local ReplicateFull = Shared.Remotes.ReplicateFull;

local function WriteTickerHeader(p3: buffer, p4: number, p5: any, p6: boolean?) -- Line: 25
    -- upvalues: ClockUnwrap (copy)
    local FULL_ROTATION = p5.config.FULL_ROTATION;
    local v7 = ClockUnwrap.quantize(p5.lastTicked);
    buffer.writeu32(p3, p4, v7);
    local v8 = p4 + 4;
    local v9 = p6 and 1 or 0;

    if FULL_ROTATION then
        v9 = v9 + 2;
    end;

    buffer.writeu8(p3, v8, v9);

    return v8 + 1;
end;

local function Flush(p10: any, p11: number, p12: any) -- Line: 43
    -- upvalues: buffer_create_ret (copy), Replicate (copy), u1 (ref), u2 (ref)
    local buffer_create_ret2 = buffer.create(p11);
    buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, p11);
    Replicate:FireClient(p10, p12, buffer_create_ret2);
    u1 = u1 + p11;
    u2 = u2 + 1;
end;

local function FlushClientOwned(p13: any, p14: table) -- Line: 52
    -- upvalues: ClockUnwrap (copy), buffer_create_ret (copy), Replicate (copy), u1 (ref), u2 (ref)
    local v15 = 0;

    for i, v in p14 do
        local v16 = ClockUnwrap.quantize(i);
        buffer.writeu32(buffer_create_ret, v15, v16);
        local v17 = v15 + 4;
        v15 = v17 + 1;
        local v18 = 0;

        for _, v2 in v do
            local buffer_len_ret = buffer.len(v2);

            if v15 + buffer_len_ret > 900 then
                buffer.writeu8(buffer_create_ret, v17, v18);
                local buffer_create_ret2 = buffer.create(v15);
                buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v15);
                Replicate:FireClient(p13, "O", buffer_create_ret2);
                u1 = u1 + v15;
                u2 = u2 + 1;
                local v19 = 0;
                buffer.writeu32(buffer_create_ret, v19, v16);
                v17 = v19 + 4;
                v15 = v17 + 1;
                v18 = 0;
            end;

            buffer.copy(buffer_create_ret, v15, v2, 0, buffer_len_ret);
            v18 = v18 + 1;
            v15 = v15 + buffer_len_ret;
        end;

        buffer.writeu8(buffer_create_ret, v17, v18);
    end;

    if v15 > 0 then
        local buffer_create_ret2 = buffer.create(v15);
        buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v15);
        Replicate:FireClient(p13, "O", buffer_create_ret2);
        u1 = u1 + v15;
        u2 = u2 + 1;
    end;
end;

local function FlushEntities(p20: any, p21: table, p22: boolean?) -- Line: 90
    -- upvalues: buffer_create_ret (copy), ClockUnwrap (copy), Replicate (copy), u1 (ref), u2 (ref)
    local v23 = buffer_create_ret;
    local v24 = 0;

    for i, v in p21 do
        local v25 = i.config.FULL_ROTATION and 20 or 16;
        local FULL_ROTATION = i.config.FULL_ROTATION;
        local v26 = ClockUnwrap.quantize(i.lastTicked);
        buffer.writeu32(v23, v24, v26);
        local v27 = v24 + 4;
        local v28 = p22 and 1 or 0;

        if FULL_ROTATION then
            v28 = v28 + 2;
        end;

        buffer.writeu8(v23, v27, v28);
        local v29 = v27 + 1;
        v24 = v29 + 1;
        local v30 = i;
        local v31 = 0;

        for _, v2 in v do
            if v24 + v25 > 900 then
                buffer.writeu8(v23, v29, v31);
                local buffer_create_ret2 = buffer.create(v24);
                buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v24);
                Replicate:FireClient(p20, "X", buffer_create_ret2);
                u1 = u1 + v24;
                u2 = u2 + 1;
                local v32 = 0;
                local FULL_ROTATION2 = v30.config.FULL_ROTATION;
                local v33 = ClockUnwrap.quantize(v30.lastTicked);
                buffer.writeu32(v23, v32, v33);
                local v34 = v32 + 4;
                local v35 = p22 and 1 or 0;

                if FULL_ROTATION2 then
                    v35 = v35 + 2;
                end;

                buffer.writeu8(v23, v34, v35);
                v29 = v34 + 1;
                v24 = v29 + 1;
                v31 = 0;
            end;

            v31 = v31 + 1;
            buffer.copy(v23, v24, v2, 0, v25);
            v24 = v24 + v25;
        end;

        buffer.writeu8(v23, v29, v31);
    end;

    if v24 > 0 then
        local buffer_create_ret2 = buffer.create(v24);
        buffer.copy(buffer_create_ret2, 0, buffer_create_ret, 0, v24);
        Replicate:FireClient(p20, "X", buffer_create_ret2);
        u1 = u1 + v24;
        u2 = u2 + 1;
    end;
end;

local function GetEntityFullData(p36: userdata, p37: any) -- Line: 124
    -- upvalues: ModelHelper (copy), Entity (copy)
    if p37.destroyed then
        return nil;
    end;

    local v38, v39 = ModelHelper.ReadyModelFromRep(p37, p36);
    local NAME = p37.entityConfig.NAME;

    if NAME == "DEFAULT" then
        NAME = nil;
    end;

    local v40 = p37.latestCFrame or CFrame.identity;
    local v41 = p37.lastClientClock or 0;

    if p37.isContextOwner then
        local PrimaryPart = Entity.GetPrimaryPart(p37);

        if PrimaryPart then
            v40 = PrimaryPart.CFrame;
        end;

        v41 = os.clock();
    end;

    return {
        id = p37.id,
        _player = p37._player,
        networkOwner = p37.networkOwner,
        cframe = v40,
        time = v41,
        config = NAME,
        model = v38,
        _modelMetaData = v39,
        paused = p37.paused,
        isHalfTicked = p37.isHalfTicked,
        _data = p37._data,
        _lockedCFReplication = p37._lockedCFReplication,
        _interpolationMode = p37._interpolationMode,
        _humanoidState = p37._humanoidState,
        _humanoidDisabledStates = p37._humanoidDisabledStates,
        mountParentId = p37.mountParentId,
        mountOffset = p37.mountOffset,
        broadPhase = p37.broadPhase
    };
end;

local u42 = 0;
local u43 = 0;

local function ReplicatePlayer(u44: userdata) -- Line: 174
    -- upvalues: EntityGrid (copy), Ticker (copy), GetEntityFullData (copy), FlushClientOwned (copy), FlushEntities (copy), ReplicateFull (copy), u42 (ref), u43 (ref)
    local EntityHolder = EntityGrid.GetEntityHolder(u44);

    if not EntityHolder then
        return;
    end;

    debug.profilebegin("ReplicatePlayer");
    local REPLICATED = EntityHolder.REPLICATED;
    local table_clone_ret = table.clone(REPLICATED);
    EntityHolder.REPLICATED = table_clone_ret;
    local EntityAdded = EntityHolder.EntityAdded;
    local EntityRemoving = EntityHolder.EntityRemoving;
    local NORMAL = EntityHolder.NORMAL;
    local HALF = EntityHolder.HALF;
    local u45 = {};
    local u46 = {};
    local u47 = {};
    local u48 = {};
    local u49 = {};
    local GlobalTick = Ticker.GetGlobalTick();

    local function HandleClientEntities(p50) -- Line: 198
        -- upvalues: GlobalTick (copy), u44 (copy), u46 (copy)
        if p50.arriveFrame ~= GlobalTick then
            return;
        end;

        if p50.networkOwner == u44 then
            return;
        end;

        local v51 = p50.lastClientClock or 0;

        if not u46[v51] then
            u46[v51] = {};
        end;

        table.insert(u46[v51], p50.cframeBuffer);
    end;

    local function Handle(p52: any, p53: boolean) -- Line: 213
        -- upvalues: table_clone_ret (copy), REPLICATED (copy), EntityAdded (copy), u45 (copy), GetEntityFullData (ref), u44 (copy), u47 (copy), GlobalTick (copy), u46 (copy), u49 (copy), u48 (copy)
        if p52.destroyed then
            return;
        end;

        table_clone_ret[p52] = true;

        if not REPLICATED[p52] then
            EntityAdded:Fire(p52);
            local v54 = GetEntityFullData(u44, p52);
            table.insert(u45, v54);

            return;
        end;

        if p52._changes then
            table.insert(u47, p52._changes);
        end;

        REPLICATED[p52] = nil;

        if p52.paused then
            return;
        end;

        if not p52.isContextOwner then
            if p52.arriveFrame ~= GlobalTick then
                return;
            end;

            if p52.networkOwner == u44 then
                return;
            end;

            local v55 = p52.lastClientClock or 0;

            if not u46[v55] then
                u46[v55] = {};
            end;

            table.insert(u46[v55], p52.cframeBuffer);

            return;
        end;

        local _ticker = p52._ticker;

        if not (_ticker and (_ticker.tickedFrame == GlobalTick and p52.cframeBuffer)) then
            return;
        end;

        local v56 = p52.isHalfTicked or not p53;

        if v56 and not _ticker.tickedHalf then
            return;
        end;

        local v57;

        if v56 then
            v57 = u49;
        else
            v57 = u48;
        end;

        local v58 = v57[_ticker];

        if not v58 then
            v58 = {};
            v57[_ticker] = v58;
        end;

        table.insert(v58, p52.cframeBuffer);
    end;

    local os_clock_ret = os.clock();
    local v59 = {};

    for _, v in NORMAL do
        Handle(v, true);
    end;

    for _, v in HALF do
        Handle(v, false);
    end;

    for i, _ in REPLICATED do
        table_clone_ret[i] = nil;
        EntityRemoving:Fire(i);
        table.insert(v59, i._lastId or i.id);
    end;

    FlushClientOwned(u44, u46);
    FlushEntities(u44, u48);
    FlushEntities(u44, u49, true);

    if #v59 > 0 or (#u45 > 0 or #u47 > 0) then
        ReplicateFull:FireClient(u44, u45, v59, u47);
    end;

    debug.profileend();
    u42 = u42 + (os.clock() - os_clock_ret);
    u43 = u43 + 1;
end;

local os_clock_ret = os.clock();
RunService.Heartbeat:Connect(function() -- Line: 294
    -- upvalues: SERVER (copy), u42 (ref), u43 (ref), os_clock_ret (ref), u1 (ref), u2 (ref)
    SERVER.REPLICATE_PLAYER_TIME_MS = u42 / math.max(u43, 1) * 1000;

    if os.clock() - os_clock_ret > 1 then
        SERVER.BYTES_SENT_PER_SEC = u1;
        SERVER.PACKETS_SENT_PER_SEC = u2;
        u1 = 0;
        u2 = 0;
        os_clock_ret = os.clock();
        u42 = 0;
        u43 = 0;
    end;
end);

return {
    ReplicatePlayer = ReplicatePlayer
};