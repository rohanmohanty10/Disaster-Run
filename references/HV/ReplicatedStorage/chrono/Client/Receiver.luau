 

 

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

local function UnmapRotation(p7: number) -- Line: 36
    return p7 / 65535 * 6.283185307179586 - 3.141592653589793;
end;

local function ReadTickerHeader(p8: buffer, p9: number) -- Line: 40
    -- upvalues: ClockUnwrap (copy), u5 (copy)
    local v10 = ClockUnwrap.unwrap(u5, (buffer.readu32(p8, p9)));
    local buffer_readu8_ret = buffer.readu8(p8, p9 + 4);
    local v11 = bit32.band(buffer_readu8_ret, 1) == 1;

    return v10, bit32.band(buffer_readu8_ret, 2) == 2, v11;
end;

local function DeserializeFull(p12: buffer, p13: number) -- Line: 50
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

local function DeserializeYaw(p22: buffer, p23: number) -- Line: 68
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

local function HandleRemoved(p28: number) -- Line: 82
    -- upvalues: Holder (copy), Entity (copy), Warn (copy)
    local EntityFromId = Holder.GetEntityFromId(p28);

    if EntityFromId then
        Entity.Destroy(EntityFromId);

        return;
    end;

    Warn.high("Tried to remove non existent entity with id", p28);
end;

local u33 = {
    networkOwner = Entity["设置网络主控玩家"],
    isHalfTicked = _SetTickMode,
    _data = Entity.SetData,
    entityConfig = Entity.SetConfig,
    autoUpdatePos = Entity.SetAutoUpdatePos,

    mountParentId = function(p29: any, p30: number?) -- Line: 91, Name: SetMountId
        -- upvalues: Events (copy)
        p29.mountParentId = p30;
        Events._Signals.EntityMountChanged:Fire(p29, p30);
    end,

    mountOffset = function(p31: any, p32) -- Line: 96, Name: SetMountOffset
        p31.mountOffset = p32 or CFrame.identity;
    end,

    broadPhase = Entity.SetBroadPhase,
    _interpolationMode = Entity.SetInterpolationMode,
    _humanoidDisabledStates = Entity._SetHumanoidDisabledStates,
    _humanoidState = Entity._SetHumanoidState
};

local function HandleChanges(p34: table) -- Line: 114
    -- upvalues: Holder (copy), u33 (copy), Entity (copy), Warn (copy), ModelHelper (copy)
    local EntityFromId = Holder.GetEntityFromId(p34.id);

    if not EntityFromId then
        return;
    end;

    local v35 = nil;
    local v36 = nil;

    for _, v in p34.data do
        local v37 = v[1];
        local v38 = v[2];
        local v39 = u33[v37];

        if v39 then
            v39(EntityFromId, v38);
        elseif v37 == "latestCFrame" then
            Entity.SetCFrame(EntityFromId, v38);
        elseif v37 == "_modelMetaData" then
            v36 = v38;
        elseif v37 == "model" then
            v35 = v38;
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

    if v35 ~= nil then
        local v41, v42 = ModelHelper.CreateModelFromData(v35);
        Entity.SetModel(EntityFromId, v41, v42);
        EntityFromId._modelMetaData = v36;
    end;
end;

local function HandleNewEntity(p43) -- Line: 168
    -- upvalues: ModelHelper (copy), Entity (copy), _SetTickMode (copy), Holder (copy)
    local v44, v45 = ModelHelper.CreateModelFromData(p43.model);
    local v46 = Entity._new(p43.config, v44, v45, p43.cframe);
    v46.id = p43.id;
    v46._player = p43._player;
    v46._modelMetaData = p43._modelMetaData;
    v46.paused = p43.paused or false;
    v46.isHalfTicked = p43.isHalfTicked;
    v46._data = p43._data;
    v46.mountParentId = p43.mountParentId;
    v46.mountOffset = p43.mountOffset or CFrame.identity;
    v46.broadPhase = p43.broadPhase or v46.broadPhase;
    v46._lockedCFReplication = p43._lockedCFReplication or false;
    v46._interpolationMode = p43._interpolationMode;
    Entity.Push(v46, p43.time, p43.cframe);
    Entity["设置网络主控玩家"](v46, p43.networkOwner);
    Entity._SetHumanoidDisabledStates(v46, p43._humanoidDisabledStates);
    Entity._SetHumanoidState(v46, p43._humanoidState);
    _SetTickMode(v46, p43.isHalfTicked);
    Holder.RegisterEntity(v46);
end;

local function PushCFrameFor(p47: number, p48: boolean, p49, p50: number, p51: boolean, p52: boolean?) -- Line: 194
    -- upvalues: Holder (copy), Warn (copy), _SetTickMode (copy), Entity (copy)
    local EntityFromId = Holder.GetEntityFromId(p47);

    if not EntityFromId then
        Warn.high("Received update for non existent entity with id", p47);

        return false;
    end;

    local v53 = EntityFromId._teleport and os.clock() - EntityFromId._teleport < 0.5;

    if v53 then
        if not p52 then
            return false;
        end;

        EntityFromId._teleport = nil;
    end;

    if p48 then
        local _clientClock = EntityFromId._clientClock;

        if _clientClock then
            if p51 then
                _clientClock:SetTickRate(_clientClock._baseTickRate * 2);
            else
                _clientClock:SetTickRate(_clientClock._baseTickRate);
            end;

            _clientClock:OnSnapShot(p50);
        end;
    else
        local CLIENT_CLOCK = EntityFromId.entityConfig.CLIENT_CLOCK;
        local v54 = CLIENT_CLOCK and (p51 and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL);

        if v54 then
            v54:OnSnapShot(p50);
        end;
    end;

    if EntityFromId.isHalfTicked ~= p51 then
        _SetTickMode(EntityFromId, p51);
    end;

    EntityFromId.isHalfTicked = p51;
    Entity.Push(EntityFromId, p50, p49);

    return true;
end;

local function HandleClientOwned(p55: buffer) -- Line: 246
    -- upvalues: u1 (ref), DeserializeFull (copy), DeserializeYaw (copy), Holder (copy), Warn (copy), ClockUnwrap (copy), u6 (copy), PushCFrameFor (copy)
    u1 = u1 + buffer.len(p55);
    local buffer_len_ret = buffer.len(p55);
    local v56 = 0;

    while v56 < buffer_len_ret do
        local buffer_readu32_ret = buffer.readu32(p55, v56);
        local v57 = v56 + 4;
        local buffer_readu8_ret = buffer.readu8(p55, v57);
        v56 = v57 + 1;

        for i = 1, buffer_readu8_ret do
            local buffer_readu16_ret = buffer.readu16(p55, v56);
            local v58 = v56 + 2;
            local buffer_readu8_ret2 = buffer.readu8(p55, v58);
            local v59 = v58 + 1;
            local v60 = bit32.band(buffer_readu8_ret2, 1) == 1;
            local v61 = bit32.band(buffer_readu8_ret2, 2) == 2;
            local v62 = bit32.band(buffer_readu8_ret2, 4) == 4;
            local v63;

            if v60 then
                v63 = DeserializeFull(p55, v59);
                v56 = v59 + 18;
            else
                v63 = DeserializeYaw(p55, v59);
                v56 = v59 + 14;
            end;

            local EntityFromId = Holder.GetEntityFromId(buffer_readu16_ret);
            local v64;

            if EntityFromId then
                PushCFrameFor(buffer_readu16_ret, true, v63, ClockUnwrap.unwrapFor(u6, EntityFromId.networkOwner or "__unknown", buffer_readu32_ret), v61, v62);
                v64 = i;
            else
                Warn.medium("Received update for non existent entity with id", buffer_readu16_ret);
                v64 = i;
            end;
        end;
    end;
end;

local function HandleServerOwned(p65: buffer) -- Line: 285
    -- upvalues: u1 (ref), ClockUnwrap (copy), u5 (copy), DeserializeFull (copy), DeserializeYaw (copy), PushCFrameFor (copy)
    local buffer_len_ret = buffer.len(p65);
    u1 = u1 + buffer_len_ret;
    local v66 = 0;

    while v66 < buffer_len_ret do
        local v67 = ClockUnwrap.unwrap(u5, (buffer.readu32(p65, v66)));
        local buffer_readu8_ret = buffer.readu8(p65, v66 + 4);
        local v68 = bit32.band(buffer_readu8_ret, 1) == 1;
        local v69 = bit32.band(buffer_readu8_ret, 2) == 2;
        local v70 = v66 + 5;
        local buffer_readu8_ret2 = buffer.readu8(p65, v70);
        v66 = v70 + 1;

        for i = 1, buffer_readu8_ret2 do
            local buffer_readu16_ret = buffer.readu16(p65, v66);
            local v71 = v66 + 2;
            local v72;

            if v69 then
                v72 = DeserializeFull(p65, v71);
                v66 = v71 + 18;
            else
                v72 = DeserializeYaw(p65, v71);
                v66 = v71 + 14;
            end;

            PushCFrameFor(buffer_readu16_ret, false, v72, v67, v68);
            local _ = i;
        end;
    end;
end;

local function HandleReliable(p73: table, p74: table, p75: table) -- Line: 320
    -- upvalues: Holder (copy), Entity (copy), Warn (copy), u3 (ref), HandleNewEntity (copy), u2 (ref), HandleChanges (copy), u4 (ref)
    if p74 then
        for _, v in p74 do
            local EntityFromId = Holder.GetEntityFromId(v);

            if EntityFromId then
                Entity.Destroy(EntityFromId);
            else
                Warn.high("Tried to remove non existent entity with id", v);
            end;
        end;

        u3 = u3 + #p74;
    end;

    if p73 then
        for _, v in p73 do
            HandleNewEntity(v);
        end;

        u2 = u2 + #p73;
    end;

    if p75 then
        for _, v in p75 do
            HandleChanges(v);
        end;

        u4 = u4 + #p75;
    end;
end;

Replicate.OnClientEvent:Connect(function(p76: string, p77: buffer) -- Line: 310, Name: HandleUnreliable
    -- upvalues: HandleServerOwned (copy), HandleClientOwned (copy), Warn (copy)
    if p76 == "X" then
        HandleServerOwned(p77);

        return;
    end;

    if p76 == "O" then
        HandleClientOwned(p77);

        return;
    end;

    Warn.high("Unknown unreliable replicate id", p76);
end);
ReplicateFull.OnClientEvent:Connect(HandleReliable);
Heartbeat.OnClientEvent:Connect(function(p78: number) -- Line: 347
    -- upvalues: ClockUnwrap (copy), u5 (copy), ClientClock (copy)
    local v79 = ClockUnwrap.unwrap(u5, ClockUnwrap.quantize(p78));

    for i in ClientClock.serverOwnedClocks do
        i:Refresh(v79);
    end;
end);
ClientClockRelay.OnClientEvent:Connect(function(p80: table) -- Line: 361
    -- upvalues: u6 (copy), ClockUnwrap (copy)
    if type(p80) ~= "table" then
        return;
    end;

    for _, v in p80 do
        local player = v.player;
        local raw = v.raw;
        local offset = v.offset;

        if player and (type(raw) == "number" and type(offset) == "number") then
            local v81 = u6[player];

            if not v81 then
                v81 = ClockUnwrap.new();
                u6[player] = v81;
            end;

            v81.lastRaw = raw;
            v81.offset = math.max(v81.offset, offset);
        end;
    end;
end);
Players.PlayerRemoving:Connect(function(p82) -- Line: 381
    -- upvalues: u6 (copy)
    u6[p82] = nil;
end);
local u83 = 0;
RunService.Heartbeat:Connect(function() -- Line: 386
    -- upvalues: u83 (ref), CLIENT (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref)
    if os.clock() - u83 > 1 then
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
        u83 = os.clock();
    end;
end);

return nil;