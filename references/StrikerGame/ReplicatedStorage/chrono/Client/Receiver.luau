 

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Shared = script.Parent.Parent.Shared;
local Warn = require(Shared.Warn);
local Entity = require(Shared.Entity);
local Events = require(Shared.Events);
local Holder = require(Shared.Holder);
local ModelHelper = require(Shared.ModelHelper);
require(Shared.Types);
local ClockUnwrap = require(Shared.ClockUnwrap);
local PositionCodec = require(Shared.PositionCodec);
local CLIENT = require(Shared.Stats).CLIENT;
local ClientClock = require(script.Parent.ClientClock);
local u1 = 0;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local _SetTickMode = Entity._SetTickMode;
local Replicate = Shared.Remotes.Replicate;
local ReplicateFull = Shared.Remotes.ReplicateFull;
local Heartbeat = Shared.Remotes.Heartbeat;
local ClientClockRelay = Shared.Remotes.ClientClockRelay;
local u5 = ClockUnwrap.new();
local u6 = {};

local function UnmapRotation(p7: number) -- Line: 37
    return p7 / 65535 * 6.283185307179586 - 3.141592653589793;
end;

local function ReadTickerHeader(p8: buffer, p9: number) -- Line: 41
    -- upvalues: ClockUnwrap (copy), u5 (copy)
    local v10 = ClockUnwrap.unwrap(u5, (buffer.readu32(p8, p9)));
    local buffer_readu8_ret = buffer.readu8(p8, p9 + 4);
    local v11 = bit32.band(buffer_readu8_ret, 1) == 1;

    return v10, bit32.band(buffer_readu8_ret, 2) == 2, v11;
end;

local function DeserializeFull(p12: buffer, p13: number) -- Line: 51
    local buffer_readf32_ret = buffer.readf32(p12, p13);
    local v14 = p13 + 4;
    local buffer_readf32_ret2 = buffer.readf32(p12, v14);
    local v15 = v14 + 4;
    local buffer_readf32_ret3 = buffer.readf32(p12, v15);
    local v16 = v15 + 4;
    local v17 = buffer.readu16(p12, v16) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v18 = v16 + 2;
    local v19 = buffer.readu16(p12, v18) / 65535 * 6.283185307179586 - 3.141592653589793;
    local v20 = v18 + 2;
    local v21 = buffer.readu16(p12, v20) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v20 + 2;

    return CFrame.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3) * CFrame.fromOrientation(v17, v19, v21);
end;

local function DeserializeYaw(p22: buffer, p23: number) -- Line: 69
    local buffer_readf32_ret = buffer.readf32(p22, p23);
    local v24 = p23 + 4;
    local buffer_readf32_ret2 = buffer.readf32(p22, v24);
    local v25 = v24 + 4;
    local buffer_readf32_ret3 = buffer.readf32(p22, v25);
    local v26 = v25 + 4;
    local v27 = buffer.readu16(p22, v26) / 65535 * 6.283185307179586 - 3.141592653589793;
    local _ = v26 + 2;

    return CFrame.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3) * CFrame.fromOrientation(0, v27, 0);
end;

local function HandleRemoved(p28: number) -- Line: 83
    -- upvalues: Holder (copy), Entity (copy), Warn (copy)
    local EntityFromId = Holder.GetEntityFromId(p28);

    if EntityFromId then
        Entity.Destroy(EntityFromId);

        return;
    end;

    Warn.high("Tried to remove non existent entity with id", p28);
end;

local u33 = {
    networkOwner = Entity._SetEntityNetworkOwner,
    isHalfTicked = _SetTickMode,
    _data = Entity.SetData,
    entityConfig = Entity.SetConfig,
    autoUpdatePosition = Entity.SetAutoUpdatePos,

    mountParentId = function(p29: any, p30: number?) -- Line: 92, Name: SetMountId
        -- upvalues: Events (copy)
        p29.mountParentId = p30;
        Events._Signals.EntityMountChanged:Fire(p29, p30);
    end,

    mountOffset = function(p31: any, p32) -- Line: 97, Name: SetMountOffset
        p31.mountOffset = p32 or CFrame.identity;
    end,

    broadPhase = Entity.SetBroadPhase,
    _interpolationMode = Entity.SetInterpolationMode,
    _humanoidDisabledStates = Entity._SetHumanoidDisabledStates,
    _humanoidState = Entity._SetHumanoidState
};

local function HandleChanges(p34: table) -- Line: 116
    -- upvalues: Holder (copy), u33 (copy), Entity (copy), Warn (copy), ModelHelper (copy)
    local EntityFromId = Holder.GetEntityFromId(p34.id);

    if not EntityFromId then
        return;
    end;

    local v35 = false;
    local v36 = nil;

    for _, v in p34.data do
        local v37 = v[1];
        local v38 = v[2];
        local v39 = u33[v37];

        if v39 then
            v39(EntityFromId, v38);
        elseif v37 == "latestCFrame" then
            Entity.SetCFrame(EntityFromId, v38);
        elseif v37 == "model" then
            v36 = v38;
            v35 = true;
        elseif v37 == "_player" then
            if v38 then
                Holder.SetAsCharacter(v38, EntityFromId);
            else
                Holder.RemovePlayerCharacter(EntityFromId);
            end;
        elseif v37 == "paused" then
            if v38 then
                Entity.PauseReplication(EntityFromId);
            else
                Entity.ResumeReplication(EntityFromId);
            end;
        elseif v37 == "_lockedCFReplication" then
            EntityFromId._lockedCFReplication = v38;

            if v38 then
                Entity.SyncOwnerShip(EntityFromId);
            else
                local v40 = Entity._GetPart(EntityFromId);

                if v40 then
                    Entity._UnlockPartPhysicsReplication(v40);
                end;
            end;
        else
            Warn.high("Unhandled entity change key:", v37);
        end;
    end;

    if v35 then
        local v41, v42, v43 = ModelHelper.CreateModelFromData(v36);
        Entity.SetModel(EntityFromId, v41, v42);
        EntityFromId._modelHandle = v43;
    end;
end;

local function HandleNewEntity(p44) -- Line: 169
    -- upvalues: ModelHelper (copy), Entity (copy), _SetTickMode (copy), Holder (copy)
    local v45, v46, v47 = ModelHelper.CreateModelFromData(p44.model);
    local v48 = Entity._new(p44.config, v45, v46, p44.cframe);
    v48.id = p44.id;
    v48._player = p44._player;
    v48._modelHandle = v47;
    v48.paused = p44.paused or false;
    v48.autoUpdatePosition = p44.autoUpdatePosition or false;
    v48.isHalfTicked = p44.isHalfTicked;
    v48._data = p44._data;
    v48.mountParentId = p44.mountParentId;
    v48.mountOffset = p44.mountOffset or CFrame.identity;
    v48.broadPhase = p44.broadPhase or v48.broadPhase;
    v48._lockedCFReplication = p44._lockedCFReplication or false;
    v48._interpolationMode = p44._interpolationMode;
    Entity.Push(v48, p44.time, p44.cframe);
    Entity._SetEntityNetworkOwner(v48, p44.networkOwner);
    Entity._SetHumanoidDisabledStates(v48, p44._humanoidDisabledStates);
    Entity._SetHumanoidState(v48, p44._humanoidState);
    _SetTickMode(v48, p44.isHalfTicked);
    Holder.RegisterEntity(v48);
end;

local function PushCFrameFor(p49: number, p50: boolean, p51, p52: number, p53: boolean, p54: boolean?) -- Line: 196
    -- upvalues: Holder (copy), Warn (copy), _SetTickMode (copy), Entity (copy)
    local EntityFromId = Holder.GetEntityFromId(p49);

    if not EntityFromId then
        Warn.high("Received update for non existent entity with id", p49);

        return false;
    end;

    local v55 = EntityFromId._teleport and os.clock() - EntityFromId._teleport < 0.5;

    if v55 then
        if not p54 then
            return false;
        end;

        EntityFromId._teleport = nil;
    end;

    if p50 then
        local _clientClock = EntityFromId._clientClock;

        if _clientClock then
            if p53 then
                _clientClock:SetTickRate(_clientClock._baseTickRate * 2);
            else
                _clientClock:SetTickRate(_clientClock._baseTickRate);
            end;

            _clientClock:OnSnapShot(p52);
        end;
    else
        local CLIENT_CLOCK = EntityFromId.entityConfig.CLIENT_CLOCK;
        local v56 = CLIENT_CLOCK and (p53 and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL);

        if v56 then
            v56:OnSnapShot(p52);
        end;
    end;

    if EntityFromId.isHalfTicked ~= p53 then
        _SetTickMode(EntityFromId, p53);
    end;

    EntityFromId.isHalfTicked = p53;
    Entity.Push(EntityFromId, p52, p51);

    return true;
end;

local function HandleClientOwned(p57: buffer) -- Line: 248
    -- upvalues: u1 (ref), PositionCodec (copy), Holder (copy), Warn (copy), ClockUnwrap (copy), u6 (copy), PushCFrameFor (copy)
    u1 = u1 + buffer.len(p57);
    local buffer_len_ret = buffer.len(p57);
    local v58 = 0;

    while v58 < buffer_len_ret do
        local buffer_readu32_ret = buffer.readu32(p57, v58);
        local v59 = v58 + 4;
        local buffer_readu8_ret = buffer.readu8(p57, v59);
        v58 = v59 + 1;

        for i = 1, buffer_readu8_ret do
            local buffer_readu16_ret = buffer.readu16(p57, v58);
            local v60 = v58 + 2;
            local buffer_readu8_ret2 = buffer.readu8(p57, v60);
            local v61 = bit32.band(buffer_readu8_ret2, 1) == 1;
            local v62 = bit32.band(buffer_readu8_ret2, 2) == 2;
            local v63 = bit32.band(buffer_readu8_ret2, 4) == 4;
            local v64 = bit32.band(buffer_readu8_ret2, PositionCodec.COMPACT_FLAG) == PositionCodec.COMPACT_FLAG;
            local v65, v66 = PositionCodec.read(p57, v60 + 1, v64);
            local v67;

            if v61 then
                local v68 = buffer.readu16(p57, v66) / 65535 * 6.283185307179586 - 3.141592653589793;
                local v69 = buffer.readu16(p57, v66 + 2) / 65535 * 6.283185307179586 - 3.141592653589793;
                local v70 = buffer.readu16(p57, v66 + 4) / 65535 * 6.283185307179586 - 3.141592653589793;
                v58 = v66 + 6;
                v67 = CFrame.new(v65) * CFrame.fromOrientation(v68, v69, v70);
            else
                local v71 = buffer.readu16(p57, v66) / 65535 * 6.283185307179586 - 3.141592653589793;
                v58 = v66 + 2;
                v67 = CFrame.new(v65) * CFrame.fromOrientation(0, v71, 0);
            end;

            local EntityFromId = Holder.GetEntityFromId(buffer_readu16_ret);
            local v72;

            if EntityFromId then
                PushCFrameFor(buffer_readu16_ret, true, v67, ClockUnwrap.unwrapFor(u6, EntityFromId.networkOwner or "__unknown", buffer_readu32_ret), v62, v63);
                v72 = i;
            else
                Warn.medium("Received update for non existent entity with id", buffer_readu16_ret);
                v72 = i;
            end;
        end;
    end;
end;

local function HandleServerOwned(p73: buffer) -- Line: 293
    -- upvalues: u1 (ref), ClockUnwrap (copy), u5 (copy), DeserializeFull (copy), DeserializeYaw (copy), PushCFrameFor (copy)
    local buffer_len_ret = buffer.len(p73);
    u1 = u1 + buffer_len_ret;
    local v74 = 0;

    while v74 < buffer_len_ret do
        local v75 = ClockUnwrap.unwrap(u5, (buffer.readu32(p73, v74)));
        local buffer_readu8_ret = buffer.readu8(p73, v74 + 4);
        local v76 = bit32.band(buffer_readu8_ret, 1) == 1;
        local v77 = bit32.band(buffer_readu8_ret, 2) == 2;
        local v78 = v74 + 5;
        local buffer_readu8_ret2 = buffer.readu8(p73, v78);
        v74 = v78 + 1;

        for i = 1, buffer_readu8_ret2 do
            local buffer_readu16_ret = buffer.readu16(p73, v74);
            local v79 = v74 + 2;
            local v80;

            if v77 then
                v80 = DeserializeFull(p73, v79);
                v74 = v79 + 18;
            else
                v80 = DeserializeYaw(p73, v79);
                v74 = v79 + 14;
            end;

            PushCFrameFor(buffer_readu16_ret, false, v80, v75, v76);
            local _ = i;
        end;
    end;
end;

local function HandleReliable(p81: table, p82: table, p83: table) -- Line: 328
    -- upvalues: Holder (copy), Entity (copy), Warn (copy), u3 (ref), HandleNewEntity (copy), u2 (ref), HandleChanges (copy), u4 (ref)
    if p82 then
        for _, v in p82 do
            local EntityFromId = Holder.GetEntityFromId(v);

            if EntityFromId then
                Entity.Destroy(EntityFromId);
            else
                Warn.high("Tried to remove non existent entity with id", v);
            end;
        end;

        u3 = u3 + #p82;
    end;

    if p81 then
        for _, v in p81 do
            HandleNewEntity(v);
        end;

        u2 = u2 + #p81;
    end;

    if p83 then
        for _, v in p83 do
            HandleChanges(v);
        end;

        u4 = u4 + #p83;
    end;
end;

Replicate.OnClientEvent:Connect(function(p84: string, p85: buffer) -- Line: 318, Name: HandleUnreliable
    -- upvalues: HandleServerOwned (copy), HandleClientOwned (copy), Warn (copy)
    if p84 == "X" then
        HandleServerOwned(p85);

        return;
    end;

    if p84 == "O" then
        HandleClientOwned(p85);

        return;
    end;

    Warn.high("Unknown unreliable replicate id", p84);
end);
ReplicateFull.OnClientEvent:Connect(HandleReliable);
Heartbeat.OnClientEvent:Connect(function(p86: number) -- Line: 355
    -- upvalues: ClockUnwrap (copy), u5 (copy), ClientClock (copy)
    local v87 = ClockUnwrap.unwrap(u5, ClockUnwrap.quantize(p86));

    for i in ClientClock.serverOwnedClocks do
        i:Refresh(v87);
    end;
end);
ClientClockRelay.OnClientEvent:Connect(function(p88: table) -- Line: 363
    -- upvalues: u6 (copy), ClockUnwrap (copy)
    if type(p88) ~= "table" then
        return;
    end;

    for _, v in p88 do
        local player = v.player;
        local raw = v.raw;
        local offset = v.offset;

        if player and (type(raw) == "number" and type(offset) == "number") then
            local v89 = u6[player];

            if not v89 then
                v89 = ClockUnwrap.new();
                u6[player] = v89;
            end;

            v89.lastRaw = raw;
            v89.offset = math.max(v89.offset, offset);
        end;
    end;
end);
Players.PlayerRemoving:Connect(function(p90) -- Line: 383
    -- upvalues: u6 (copy)
    u6[p90] = nil;
end);
local u91 = 0;
RunService.Heartbeat:Connect(function() -- Line: 388
    -- upvalues: u91 (ref), CLIENT (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref)
    if os.clock() - u91 > 1 then
        if not CLIENT._PAUSE then
            CLIENT.BYTES_RECEIVED_PER_SEC = u1;
            CLIENT.NEW_ENTITIES_PER_SEC = u2;
            CLIENT.ENTITY_CHANGES_PER_SEC = u4;
            CLIENT.ENTITY_REMOVALS_PER_SEC = u3;
        end;

        u2 = 0;
        u3 = 0;
        u4 = 0;
        u1 = 0;
        u91 = os.clock();
    end;
end);

return nil;