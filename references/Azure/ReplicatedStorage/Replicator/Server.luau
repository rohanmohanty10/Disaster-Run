 

 

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Network/NetworkSystem");
local u2 = require("@game/ReplicatedStorage/Network/SyncSystem");
local u3 = require("./Types");
local u4 = require("./Events");
local u5 = require("./Clock");
local u6 = require("./Codec");
local u7 = require("./Snapshots");
local u8 = require("./Lock");
local u9 = require("./Guard");
local u10 = {
    _accumulator = 0,
    entities = {},
    playerEntities = {},
    byModel = {},
    config = u3.defaultConfig(),
    _handlers = {},
    _dirty = {},
    _settling = {},
    _usedIds = {},
    _players = {},
    _joined = {},
    _connections = {},

    _localTime = function() -- Line: 49, Name: _localTime
        return os.clock();
    end
};

function u10._viewers() -- Line: 53
    -- upvalues: u10 (copy)
    local v11 = {};

    for i in u10._players do
        table.insert(v11, i);
    end;

    return v11;
end;

function u10._allocateId() -- Line: 61
    -- upvalues: u10 (copy)
    for i = 1, 255 do
        if not u10._usedIds[i] then
            u10._usedIds[i] = true;

            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u10._describe(p12) -- Line: 71
    return {
        id = p12.id,
        model = p12.model,
        player = p12.player,
        owner = p12.owner,
        cframe = p12.cframe,
        full = p12.fullRotation
    };
end;

function u10._applyCFrame(p13: any, p14) -- Line: 82
    local locker = p13.locker;

    if locker and locker.Parent then
        locker.CFrame = p14;

        return;
    end;

    if p13.player then
        return;
    end;

    local root = p13.root;

    if root and root.Parent then
        root.CFrame = p14;
    end;
end;

function u10._markDirty(p15: any, p16: number?) -- Line: 97
    -- upvalues: u10 (copy)
    u10._dirty[p15] = bit32.bor(u10._dirty[p15] or 0, p16 or 0);
end;

function u10._record(p17: any, p18, p19: number, p20: number, p21: number?) -- Line: 101
    -- upvalues: u5 (copy), u7 (copy), u10 (copy), u4 (copy)
    local v22 = p21 ~= nil and p21 ~= 0 and true or not p18:FuzzyEq(p17.cframe, 0.0001);
    p17.cframe = p18;
    p17.tick = math.floor(p19);
    p17.time = u5.time(p19);
    u7.push(p17.snapshots, p20, p18);

    if v22 or u10.config.sendUnchanged then
        u10._markDirty(p17, p21);
        u10._settling[p17] = 6;
    end;

    u4.Snapshot:Fire(p17, p20, p18);
end;

function u10.getEntity(p23: userdata) -- Line: 114
    -- upvalues: u10 (copy)
    return u10.byModel[p23];
end;

function u10.getEntityFromPlayer(p24: userdata) -- Line: 118
    -- upvalues: u10 (copy)
    return u10.playerEntities[p24];
end;

function u10.getEntityFromId(p25: number) -- Line: 122
    -- upvalues: u10 (copy)
    return u10.entities[p25];
end;

function u10.getAt(p26: any, p27: number) -- Line: 126
    -- upvalues: u7 (copy)
    return u7.sample(p26.snapshots, p27);
end;

function u10.onPacket(p28: string, p29: number, p30: any) -- Line: 130
    -- upvalues: u10 (copy)
    u10.removePacketHandler(p28);
    table.insert(u10._handlers, {
        name = p28,
        priority = p29,
        fn = p30
    });
    table.sort(u10._handlers, function(p31: table, p32: table) -- Line: 133
        return p31.priority > p32.priority;
    end);
end;

function u10.removePacketHandler(p33: string) -- Line: 138
    -- upvalues: u10 (copy)
    for i = #u10._handlers, 1, -1 do
        local v34;

        if u10._handlers[i].name == p33 then
            table.remove(u10._handlers, i);
            v34 = i;
        else
            v34 = i;
        end;
    end;
end;

function u10.setGuardConfig(p35: table) -- Line: 146
    -- upvalues: u9 (copy)
    u9.setConfig(p35);
end;

function u10._onRootSet(p36: any, p37: userdata) -- Line: 150
    -- upvalues: u10 (copy)
    if p36.destroyed then
        return;
    end;

    local CFrame = p37.CFrame;

    if CFrame:FuzzyEq(p36.cframe, 0.001) then
        return;
    end;

    u10._teleport(p36, CFrame, false);
end;

function u10.register(u38: userdata, p39: userdata?, p40: userdata?) -- Line: 161
    -- upvalues: u10 (copy), u3 (copy), u5 (copy), u7 (copy), u8 (copy), CollectionService (copy), u1 (copy), u6 (copy), u4 (copy)
    local v41 = u10.byModel[u38];

    if v41 then
        return v41;
    end;

    local u42 = u38:FindFirstChild("HumanoidRootPart") or u38.PrimaryPart;

    if not (u42 and u42:IsA("BasePart")) then
        return nil;
    end;

    local v43 = u10._allocateId();

    if not v43 then
        warn("Replicator: out of entity ids");

        return nil;
    end;

    local config = u10.config;
    local u44 = u3.newEntity(v43, u38, u42, p40, p39, u42.CFrame, config.fullRotation, config.snapshotCount);
    u44.snapshots.spacing = config.tickRate;
    u44.tick = u5.tick() - u5.TicksPerSecond;
    u44.time = u5.time(u44.tick);
    u7.push(u44.snapshots, u10._localTime(), u42.CFrame);

    if p40 and config.lockCharacters then
        u44.locker = u8.apply(u42, p39);
    end;

    u38:SetAttribute("ReplicatorId", v43);
    CollectionService:AddTag(u38, "ReplicatorEntity");
    u10.entities[v43] = u44;
    u10.byModel[u38] = u44;

    if p40 then
        u10.playerEntities[p40] = u44;
    end;

    local v45 = { u38.AncestryChanged:Connect(function() -- Line: 199
            -- upvalues: u38 (copy), u10 (ref)
            if not u38:IsDescendantOf(game) then
                u10.unregister(u38);
            end;
        end) };

    if p40 and (config.setterTeleports and not u44.locker) then
        local PropertyChangedSignal = u42:GetPropertyChangedSignal("CFrame");
        table.insert(v45, PropertyChangedSignal:Connect(function() -- Line: 206
            -- upvalues: u10 (ref), u44 (copy), u42 (copy)
            u10._onRootSet(u44, u42);
        end));
    end;

    u10._connections[u44] = v45;
    u1.write("replicatorAdd", "reliable");
    u6.writeDescription(u10._describe(u44));
    u1.sendTo(u10._viewers());
    u4.EntityAdded:Fire(u44);

    if p40 then
        u4.CharacterRegistered:Fire(p40, u44);
    end;

    return u44;
end;

function u10.unregister(p46: userdata) -- Line: 223
    -- upvalues: u10 (copy), u8 (copy), CollectionService (copy), u1 (copy), u4 (copy)
    local v47 = u10.byModel[p46];

    if not v47 then
        return;
    end;

    v47.destroyed = true;
    u10.entities[v47.id] = nil;
    u10.byModel[p46] = nil;
    u10._dirty[v47] = nil;
    u10._settling[v47] = nil;
    u10._usedIds[v47.id] = false;
    local v48 = u10._connections[v47];

    if v48 then
        for _, v in v48 do
            v:Disconnect();
        end;

        u10._connections[v47] = nil;
    end;

    local root = v47.root;

    if root and root.Parent then
        u8.remove(root);
    end;

    v47.locker = nil;

    if p46:IsDescendantOf(game) then
        p46:SetAttribute("ReplicatorId", nil);
        CollectionService:RemoveTag(p46, "ReplicatorEntity");
    end;

    local player = v47.player;

    if player and u10.playerEntities[player] == v47 then
        u10.playerEntities[player] = nil;
    end;

    u1.write("replicatorRemove", "reliable").writeuint(v47.id, 8).sendTo(u10._viewers());

    if player then
        u4.CharacterUnregistered:Fire(player, v47);
    end;

    u4.EntityRemoved:Fire(v47);
end;

function u10._teleport(p49: any, p50, p51: boolean) -- Line: 266
    -- upvalues: u10 (copy), u7 (copy), u5 (copy), u6 (copy), u4 (copy), u1 (copy)
    local v52 = u10._localTime();
    u7.clear(p49.snapshots);
    u10._record(p49, p50, u5.tick(), v52, u6.FlagSnap);
    p49.teleportedAt = v52;

    if p51 then
        u10._applyCFrame(p49, p50);
    end;

    u4.Teleported:Fire(p49, p50);
    local owner = p49.owner;

    if owner then
        p49.teleportAt = v52;
        u1.write("replicatorTeleport", "reliable").writeuint(p49.id, 8).writecframe(p50).sendTo({ owner });
    end;
end;

function u10.setCFrame(p53: any, p54) -- Line: 283
    -- upvalues: u10 (copy)
    if p53.destroyed then
        return;
    end;

    u10._teleport(p53, p54, true);
end;

function u10.setOwner(p55: any, p56: userdata?) -- Line: 290
    -- upvalues: u5 (copy), u8 (copy), u1 (copy), u10 (copy), u6 (copy), u4 (copy)
    if p55.destroyed or p55.owner == p56 then
        return;
    end;

    local owner = p55.owner;
    p55.owner = p56;
    p55.teleportAt = nil;
    p55.tick = u5.tick() - u5.TicksPerSecond;
    p55.guardSamples = {};
    local root = p55.root;

    if root and (root.Parent and p55.locker) then
        p55.locker = u8.setOwner(root, p56);
    end;

    u1.write("replicatorOwner", "reliable").writeuint(p55.id, 8).writeref(p56).sendTo(u10._viewers());
    u10._markDirty(p55, u6.FlagSnap);
    u4.OwnerChanged:Fire(p55, p56, owner);
end;

function u10.publish(p57: table) -- Line: 310
    -- upvalues: u5 (copy), u10 (copy), u1 (copy), u6 (copy)
    local v58 = {};

    for _, v in p57 do
        if not v.entity.destroyed then
            table.insert(v58, v);
        end;
    end;

    if #v58 == 0 then
        return;
    end;

    local v59 = u5.wrap(u5.tick());
    local v60 = u10._viewers();

    for i = 1, #v58, 40 do
        local math_min_ret = math.min(i + 40 - 1, #v58);
        u1.write("replicatorReplicate", "unreliable").writeuint(v59, 32).writeuint(math_min_ret - i + 1, 8);
        local _ = i;

        for i2 = i, math_min_ret do
            local v61 = v58[i2];
            local entity = v61.entity;
            entity.published = true;
            u6.writeEntry(entity.id, not v61.snap and 0 or u6.FlagSnap, v61.cframe, entity.fullRotation);
            local _ = i2;
        end;

        u1.sendTo(v60);
    end;
end;

function u10.unpublish(p62) -- Line: 336
    -- upvalues: u10 (copy), u6 (copy)
    if not p62.published then
        return;
    end;

    p62.published = false;
    u10._markDirty(p62, u6.FlagSnap);
end;

function u10._runHandlers(p63: userdata, p64: any, p65, p66: number) -- Line: 344
    -- upvalues: u10 (copy)
    for _, v in u10._handlers do
        local success, result = pcall(v.fn, p63, p64, p65, p66);

        if success then
            if result == true then
                return nil;
            end;

            if typeof(result) == "CFrame" then
                p65 = result;
            end;
        else
            warn((`Replicator: packet handler {v.name} failed: {result}`));
        end;
    end;

    return p65;
end;

function u10._onMove(p67: userdata) -- Line: 361
    -- upvalues: u1 (copy), u6 (copy), u10 (copy), u5 (copy), u9 (copy), u4 (copy)
    local v68 = u1.readuint(32);
    local v69 = u1.readuint(8);
    local v70, v71, _, v72 = u6.readEntry(false);
    local v73 = u1.readvector();

    if not u10._players[p67] then
        return;
    end;

    local v74 = u10._localTime();
    local v75 = u5.live();
    local v76 = u5.unwrap(v68, (math.floor(v75)));

    if v75 + u10.config.tickAhead < v76 then
        return;
    end;

    local v77 = u10.entities[v70];

    if not (v77 and (not v77.destroyed and v77.owner == p67)) then
        return;
    end;

    if v76 <= v77.tick or not (u6.isFinite(v72.Position) and u6.isFinite(v73)) then
        return;
    end;

    local v78 = v76 + v69 / 256;
    v77.ping = math.max((v75 - v78) / u5.TicksPerSecond, 0);
    local v79 = u6.hasFlag(v71, u6.FlagAck);

    if v77.teleportAt then
        if not v79 and v74 - v77.teleportAt <= u10.config.teleportTimeout then
            return;
        end;

        v77.teleportAt = nil;
    end;

    local v80 = u6.hasFlag(v71, u6.FlagSnap);

    if v80 then
        if v74 - (v77.clientSnapAt or (-1 / 0)) < 0.5 then
            v80 = false;
        else
            v77.clientSnapAt = v74;
        end;
    end;

    local v81 = u10._runHandlers(p67, v77, v72, v74);

    if not v81 then
        return;
    end;

    local v82 = u5.time(v78);
    local v83 = u9.check(v77, v82, v74, v81.Position, v80 or v79, v73);
    v77.velocity = v73;

    if v81 ~= v72 then
        v83 = nil;
    end;

    v77.clientVelocity = v83;
    v77.clientVelocityTime = v74;
    v77.clientVelocityClock = v82;
    local v84;

    if v80 then
        v84 = u6.FlagSnap;
    else
        v84 = nil;
    end;

    u10._record(v77, v81, v78, v74, v84);
    u10._applyCFrame(v77, v81);

    if v80 then
        u4.Teleported:Fire(v77, v81);
    end;
end;

function u10._sampleServerDriven(p85: number) -- Line: 424
    -- upvalues: u10 (copy)
    local v86 = u10._localTime();

    for _, v in u10.entities do
        if v.owner == nil and not v.destroyed then
            local root = v.root;

            if root and root.Parent then
                local CFrame = root.CFrame;

                if not CFrame:FuzzyEq(v.cframe, 0.0001) then
                    u10._record(v, CFrame, p85, v86);
                end;
            end;
        end;
    end;
end;

function u10._queueSettling() -- Line: 442
    -- upvalues: u10 (copy), u6 (copy)
    for i, v in u10._settling do
        if i.destroyed or i.published then
            u10._settling[i] = nil;
        elseif u10._dirty[i] == nil then
            u10._dirty[i] = u6.FlagAck;
            local v87;

            if v > 1 then
                v87 = v - 1;
            else
                v87 = nil;
            end;

            u10._settling[i] = v87;
        end;
    end;
end;

function u10._relay(p88: number) -- Line: 456
    -- upvalues: u10 (copy), u5 (copy), u1 (copy), u6 (copy)
    u10._queueSettling();

    if next(u10._dirty) == nil then
        return;
    end;

    local v89 = {};

    for i in u10._dirty do
        if not (i.destroyed or i.published) then
            table.insert(v89, i);
        end;
    end;

    local v90 = u10._viewers();

    if #v89 > 0 and #v90 > 0 then
        local v91 = u5.wrap(p88);
        local TicksPerSecond = u5.TicksPerSecond;

        for i = 1, #v89, 40 do
            local math_min_ret = math.min(i + 40 - 1, #v89);
            u1.write("replicatorSnapshot", "unreliable").writeuint(v91, 32).writeuint(math_min_ret - i + 1, 8);
            local _ = i;

            for i2 = i, math_min_ret do
                local v92 = v89[i2];
                u6.writeEntry(v92.id, u10._dirty[v92], v92.cframe, v92.fullRotation, v92.time * TicksPerSecond - p88);
                local _ = i2;
            end;

            u1.sendTo(v90);
        end;
    end;

    table.clear(u10._dirty);
end;

function u10._onUpdate(p93: number) -- Line: 487
    -- upvalues: u10 (copy), u5 (copy)
    local v94 = u10;
    v94._accumulator = v94._accumulator + p93;
    local tickRate = u10.config.tickRate;

    if u10._accumulator < tickRate then
        return;
    end;

    u10._accumulator = math.min(u10._accumulator - tickRate, tickRate);
    local v95 = u5.tick();
    u10._sampleServerDriven(v95);
    u10._relay(v95);
end;

function u10._onCharacterAdded(p96: userdata, p97: userdata) -- Line: 500
    -- upvalues: u10 (copy)
    if not (p97:WaitForChild("HumanoidRootPart", 10) and (p96.Character == p97 and p97:IsDescendantOf(workspace))) then
        return;
    end;

    task.wait(0.1);

    if p96.Character ~= p97 or not (p97:IsDescendantOf(workspace) and p96.Parent) then
        return;
    end;

    u10.register(p97, p96, p96);
end;

function u10._onPlayerAdded(u98: userdata) -- Line: 512
    -- upvalues: u10 (copy)
    if u10._joined[u98] then
        return;
    end;

    u10._joined[u98] = true;
    u98.CharacterAdded:Connect(function(p99: userdata) -- Line: 518
        -- upvalues: u10 (ref), u98 (copy)
        task.spawn(u10._onCharacterAdded, u98, p99);
    end);
    u98.CharacterRemoving:Connect(function(p100: userdata) -- Line: 521
        -- upvalues: u10 (ref)
        u10.unregister(p100);
    end);

    if u98.Character then
        task.spawn(u10._onCharacterAdded, u98, u98.Character);
    end;
end;

function u10._onReady(p101: userdata) -- Line: 529
    -- upvalues: u10 (copy), u1 (copy), u6 (copy)
    if not u10._joined[p101] or u10._players[p101] then
        return;
    end;

    u10._players[p101] = true;
    local v102 = {};

    for _, v in u10.entities do
        table.insert(v102, u10._describe(v));
    end;

    u1.write("replicatorSync", "reliable").writeuint(#v102, 8);

    for _, v in v102 do
        u6.writeDescription(v);
    end;

    u1.sendTo({ p101 });
end;

function u10._onPlayerRemoving(p103: userdata) -- Line: 546
    -- upvalues: u10 (copy)
    local v104 = u10.playerEntities[p103];

    if v104 and v104.model then
        u10.unregister(v104.model);
    end;

    u10._players[p103] = nil;
    u10._joined[p103] = nil;
end;

function u10.start(p105) -- Line: 555
    -- upvalues: u10 (copy), u1 (copy), u9 (copy), u2 (copy), Players (copy)
    u10.config = p105;
    local v106 = 4 / p105.tickRate;
    u1.receive("replicatorMove", u10._onMove, v106, v106 * 1.5);
    u1.receive("replicatorReady", u10._onReady, 1, 2);
    u9.start();
    u2.onUpdate:Connect(u10._onUpdate);
    Players.PlayerAdded:Connect(u10._onPlayerAdded);
    Players.PlayerRemoving:Connect(u10._onPlayerRemoving);

    for _, v in Players:GetPlayers() do
        u10._onPlayerAdded(v);
    end;
end;

return u10;