 

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local v1 = {};
local u2 = {};
local u3 = {};
local Shared = script.Parent.Parent.Shared;
local Ticker = require(Shared.Ticker);
local InterpolationMath = require(Shared.InterpolationMath);
local Warn = require(Shared.Warn);
local ServerClock = require(script.Parent.ServerClock);
require(Shared.Types);
local Holder = require(Shared.Holder);
local Entity = require(Shared.Entity);
local Config = require(Shared.Config);
local ClockUnwrap = require(Shared.ClockUnwrap);
local SERVER = require(Shared.Stats).SERVER;
local u4 = {};
local u5 = 300;
Config._WaitForLock(function() -- Line: 22
    -- upvalues: u5 (ref), Config (copy)
    u5 = Config._GetConfig("MAX_TOTAL_BYTES_PER_FRAME_PER_PLAYER");
end);
local u6 = 0;
local Replicate = Shared.Remotes.Replicate;
local SafeReplicate = Shared.Remotes.SafeReplicate;

local function FireMiddleMans(p7: userdata, p8: any, p9, p10: number) -- Line: 35
    -- upvalues: u3 (ref)
    if #u3 == 0 then
        return false;
    end;

    debug.profilebegin("FireMiddleMans");

    for _, v in u3 do
        if v.func(p7, p8, p9, p10) then
            return true;
        end;
    end;

    debug.profileend();

    return false;
end;

local function UnmapRotation(p11: number) -- Line: 49
    return p11 / 65535 * 6.283185307179586 - 3.141592653589793;
end;

local function DeserializeFull(p12: buffer, p13: number) -- Line: 52
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

local function DeserializeEntityPacket(p28: buffer, p29: number) -- Line: 80
    -- upvalues: DeserializeFull (copy), DeserializeYaw (copy)
    local buffer_readu16_ret = buffer.readu16(p28, p29);
    local v30 = p29 + 2;
    local buffer_readu8_ret = buffer.readu8(p28, v30);
    local v31 = v30 + 1;
    local v32 = bit32.band(buffer_readu8_ret, 1) == 1;
    local v33 = bit32.band(buffer_readu8_ret, 4) == 4;
    local v34, v35;

    if v32 then
        v34 = DeserializeFull(p28, v31);
        v35 = v31 + 18;
    else
        v34 = DeserializeYaw(p28, v31);
        v35 = v31 + 14;
    end;

    return buffer_readu16_ret, v34, v35, v33;
end;

local function CalculateMaxThroughputForPlayer(p36: userdata) -- Line: 100
    -- upvalues: Holder (copy), u5 (ref)
    local v37 = 0;

    for _ in Holder._clientOwned[p36] or {} do
        v37 = v37 + 1;
    end;

    return u5 + v37 * 21;
end;

local function HandleEntity(p38: userdata, p39: number, p40: number, p41: number, p42, p43: buffer, p44: boolean) -- Line: 108
    -- upvalues: Holder (copy), FireMiddleMans (copy), Config (copy), InterpolationMath (copy), Entity (copy), Ticker (copy)
    local EntityFromId = Holder.GetEntityFromId(p39);

    if not EntityFromId or EntityFromId.networkOwner ~= p38 then
        return;
    end;

    local _teleport = EntityFromId._teleport;
    local NetworkPing = p38:GetNetworkPing();
    local v45 = math.max(NetworkPing, 0) + 0.05;

    if _teleport then
        _teleport = os.clock() - _teleport < v45 + 0.5;
    end;

    if p44 then
        if _teleport then
            EntityFromId._teleport = nil;
        else
            local buffer_readu8_ret = buffer.readu8(p43, 2);
            local bit32_band_ret = bit32.band(buffer_readu8_ret, 4294967291);
            buffer.writeu8(p43, 2, bit32_band_ret);
        end;
    elseif _teleport then
        return;
    end;

    if EntityFromId.lastClientClock and p41 < EntityFromId.lastClientClock then
        return;
    end;

    debug.profilebegin("HandleEntity.FireMiddleMans");

    if FireMiddleMans(p38, EntityFromId, p42, p40) then
        debug.profileend();

        return;
    end;

    debug.profileend();
    local v46 = nil;

    if Config.FLAGS.SERVER_VELOCITY_FIX and EntityFromId.snapshot then
        local Latest = EntityFromId.snapshot:GetLatest();
        local v47 = EntityFromId.lastClientClock or p41;
        local TICK_RATE = EntityFromId.entityConfig.TICK_RATE;

        if EntityFromId.isHalfTicked then
            TICK_RATE = TICK_RATE * 2;
        end;

        if Latest then
            v46 = InterpolationMath.CalculateVelocity(Latest.value.Position, v47, p42.Position, p41, TICK_RATE);
        end;
    end;

    if Entity.Push(EntityFromId, p40, p42, v46) then
        EntityFromId.arriveFrame = Ticker.GetGlobalTick();
        EntityFromId.lastClientClock = p41;
        EntityFromId.cframeBuffer = p43;

        if EntityFromId.modelReplicationMode == "NATIVE" and not EntityFromId._lockedCFReplication then
            return;
        end;

        Entity._SetPartCFrame(EntityFromId, p42);
    end;
end;

local u48 = {};

local function OnReceive(p49: userdata, p50: buffer) -- Line: 178
    -- upvalues: u48 (copy), u6 (ref), Holder (copy), u5 (ref), Warn (copy), ClockUnwrap (copy), u4 (copy), ServerClock (copy), DeserializeFull (copy), DeserializeYaw (copy), HandleEntity (copy)
    if not p50 then
        return;
    end;

    u48[p49] = (u48[p49] or 0) + buffer.len(p50);
    u6 = u6 + buffer.len(p50);
    local v51 = 0;

    for _ in Holder._clientOwned[p49] or {} do
        v51 = v51 + 1;
    end;

    local v52 = u5 + v51 * 21;

    if v52 < u48[p49] then
        Warn.medium("Player", p49.Name, "exceeded max bytes per frame:", u48[p49], "max:", v52);

        return;
    end;

    debug.profilebegin("Receiver.OnReceive");
    local v53 = 0;
    local v54 = ClockUnwrap.unwrapFor(u4, p49, (buffer.readu32(p50, v53)));
    local v55 = v53 + 4;
    local os_clock_ret = os.clock();
    local buffer_len_ret = buffer.len(p50);
    ServerClock.Store(p49, v54);

    while v55 < buffer_len_ret do
        local buffer_readu16_ret = buffer.readu16(p50, v55);
        local v56 = v55 + 2;
        local buffer_readu8_ret = buffer.readu8(p50, v56);
        local v57 = v56 + 1;
        local v58 = bit32.band(buffer_readu8_ret, 1) == 1;
        local v59 = bit32.band(buffer_readu8_ret, 4) == 4;
        local v60, v61;

        if v58 then
            v60 = DeserializeFull(p50, v57);
            v61 = v57 + 18;
        else
            v60 = DeserializeYaw(p50, v57);
            v61 = v57 + 14;
        end;

        local buffer_create_ret = buffer.create(v61 - v55);
        buffer.copy(buffer_create_ret, 0, p50, v55, v61 - v55);
        HandleEntity(p49, buffer_readu16_ret, os_clock_ret, v54, v60, buffer_create_ret, v59);
        v55 = v61;
    end;

    debug.profileend();
end;

function v1.RegisterMiddleMan(p62: string, p63: number, p64: function) -- Line: 215
    -- upvalues: u2 (copy), u3 (ref)
    u2[p62] = {
        priority = p63,
        func = p64
    };
    u3 = {};

    for _, v in u2 do
        table.insert(u3, v);
    end;

    table.sort(u3, function(p65, p66) -- Line: 230
        return p65.priority > p66.priority;
    end);
end;

function v1.UnregisterMiddleMan(p67: string) -- Line: 239
    -- upvalues: u2 (copy), u3 (ref)
    u2[p67] = nil;
    u3 = {};

    for _, v in u2 do
        table.insert(u3, v);
    end;

    table.sort(u3, function(p68, p69) -- Line: 245
        return p68.priority > p69.priority;
    end);
end;

if RunService:IsServer() then
    local u70 = 0;
    RunService.Heartbeat:Connect(function(p71: number) -- Line: 252
        -- upvalues: u48 (copy), u70 (ref), SERVER (copy), u6 (ref)
        table.clear(u48);

        if os.clock() - u70 > 1 then
            SERVER.BYTES_RECEIVED_PER_SEC = u6;
            u6 = 0;
            u70 = os.clock();
        end;
    end);
    Replicate.OnServerEvent:Connect(OnReceive);
    SafeReplicate.OnServerEvent:Connect(OnReceive);
    Shared.Remotes.ClientHeartbeat.OnServerEvent:Connect(function(p72: userdata, p73: number) -- Line: 264
        -- upvalues: ClockUnwrap (copy), u4 (copy), ServerClock (copy)
        if type(p73) ~= "number" then
            return;
        end;

        local v74 = ClockUnwrap.seatFullFor(u4, p72, p73);
        ServerClock.Store(p72, v74);
    end);
    Players.PlayerRemoving:Connect(function(p75) -- Line: 272
        -- upvalues: u4 (copy)
        u4[p75] = nil;
    end);
end;

function v1._GetClientClockRaws() -- Line: 277
    -- upvalues: u4 (copy)
    local v76 = {};

    for i, v in u4 do
        if v.lastRaw then
            table.insert(v76, {
                player = i,
                raw = v.lastRaw,
                offset = v.offset
            });
        end;
    end;

    return v76;
end;

return v1;