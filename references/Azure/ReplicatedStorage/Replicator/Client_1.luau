 
 

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local u1 = require("@game/ReplicatedStorage/Network/NetworkSystem");
local u2 = require("@game/ReplicatedStorage/Network/SyncSystem");
local u3 = require("./Types");
local u4 = require("./Events");
local u5 = require("./Clock");
local u6 = require("./Codec");
local u7 = require("./Snapshots");
local u8 = require("./Lock");
local LocalPlayer = Players.LocalPlayer;
local u10 = {
    entities = {},
    playerEntities = {},
    byModel = {},
    config = u3.defaultConfig(),
    _lookupAt = {},

    _localTime = function() -- Line: 55, Name: _localTime
        return os.clock();
    end,

    _findTagged = function(p9: number) -- Line: 59, Name: _findTagged
        -- upvalues: CollectionService (copy)
        for _, v in CollectionService:GetTagged("ReplicatorEntity") do
            if v:IsA("Model") and v:GetAttribute("ReplicatorId") == p9 then
                return v;
            end;
        end;

        return nil;
    end
};

function u10._resolve(p11) -- Line: 68
    -- upvalues: u10 (copy)
    local model = p11.model;

    if not (model and model.Parent) then
        if p11.player then
            model = p11.player.Character;
        else
            local os_clock_ret = os.clock();

            if (u10._lookupAt[p11] or 0) <= os_clock_ret then
                u10._lookupAt[p11] = os_clock_ret + 1;
                model = u10._findTagged(p11.id);
            end;
        end;

        if model then
            p11.model = model;
            u10.byModel[model] = p11;
        end;
    end;

    if not model then
        p11.root = nil;

        return nil;
    end;

    local root = p11.root;

    if root and root.Parent == model then
        return root;
    end;

    local v12 = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart;

    if not (v12 and v12:IsA("BasePart")) then
        v12 = nil;
    end;

    p11.root = v12;

    return p11.root;
end;

function u10._isOwned(p13) -- Line: 98
    -- upvalues: LocalPlayer (copy)
    return p13.owner == LocalPlayer;
end;

function u10._applyOwnership(p14) -- Line: 102
    -- upvalues: u10 (copy), LocalPlayer (copy), u8 (copy)
    local v15 = u10._resolve(p14);

    if not v15 then
        return;
    end;

    if p14.player ~= LocalPlayer then
        return;
    end;

    if u10._isOwned(p14) then
        u8.remove(v15);

        if p14.anchored then
            v15.Anchored = false;
            p14.anchored = false;
        end;
    elseif u10.config.lockCharacters then
        v15.Anchored = true;
        p14.anchored = true;
    end;
end;

function u10.getEntity(p16: userdata) -- Line: 122
    -- upvalues: u10 (copy)
    return u10.byModel[p16];
end;

function u10.getEntityFromPlayer(p17: userdata) -- Line: 126
    -- upvalues: u10 (copy)
    return u10.playerEntities[p17];
end;

function u10.getEntityFromId(p18: number) -- Line: 130
    -- upvalues: u10 (copy)
    return u10.entities[p18];
end;

function u10.getLocalEntity() -- Line: 134
    -- upvalues: u10 (copy), LocalPlayer (copy)
    return u10.playerEntities[LocalPlayer];
end;

function u10.getAt(p19: any, p20: number) -- Line: 138
    -- upvalues: u7 (copy)
    return u7.sample(p19.snapshots, p20);
end;

function u10.getRenderDelay(p21) -- Line: 142
    -- upvalues: u5 (copy)
    local renderAt = p21.renderAt;

    return not renderAt and 0 or u5.now() - renderAt;
end;

function u10._resetClock(p22) -- Line: 150
    p22.offset = nil;
    p22.peak = 0;
    p22.interval = 0;
    p22.lastSample = nil;
    p22.renderAt = nil;
end;

function u10._getBuffer(p23) -- Line: 158
    -- upvalues: u10 (copy)
    local config = u10.config;
    local v24 = math.max(config.tickRate, p23.interval) * 1.5 + p23.peak;

    if v24 < config.minBuffer then
        v24 = config.minBuffer + (config.minBuffer - v24) * 0.2;
    end;

    return math.min(v24, config.maxBuffer);
end;

function u10._trackSample(p25: any, p26: number) -- Line: 165
    -- upvalues: u10 (copy)
    local v27 = u10._localTime();
    local lastSample = p25.lastSample;

    if lastSample then
        local v28 = p26 - lastSample;

        if v28 > 0 and v28 < 0.25 then
            if p25.interval > 0 then
                v28 = p25.interval + (v28 - p25.interval) * 0.1;
            end;

            p25.interval = v28;
        end;
    end;

    p25.lastSample = p26;
    local offset = p25.offset;

    if offset then
        local v29 = v27 - offset - p26;

        if math.abs(v29) <= 1 then
            local math_max_ret = math.max(v29, 0);
            p25.peak = math.max(math_max_ret, p25.peak - 0.05 * (v27 - p25.peakAt));
            p25.peakAt = v27;
            p25.offset = math.min(offset + 0.02 * (v27 - p25.offsetAt), v27 - p26);
            p25.offsetAt = v27;

            return;
        end;

        u10._resetClock(p25);
        p25.lastSample = p26;
    end;

    p25.offset = v27 - p26;
    p25.offsetAt = v27;
    p25.peak = 0;
    p25.peakAt = v27;
end;

function u10._remove(p30: number) -- Line: 195
    -- upvalues: u10 (copy), u4 (copy)
    local v31 = u10.entities[p30];

    if not v31 then
        return;
    end;

    v31.destroyed = true;
    u10.entities[p30] = nil;
    u10._lookupAt[v31] = nil;

    if v31.model then
        u10.byModel[v31.model] = nil;
    end;

    local player = v31.player;

    if player and u10.playerEntities[player] == v31 then
        u10.playerEntities[player] = nil;
        u4.CharacterUnregistered:Fire(player, v31);
    end;

    u4.EntityRemoved:Fire(v31);
end;

function u10._add(p32) -- Line: 214
    -- upvalues: u10 (copy), u3 (copy), u7 (copy), u5 (copy), u4 (copy)
    local id = p32.id;

    if u10.entities[id] then
        u10._remove(id);
    end;

    local config = u10.config;
    local v33 = u3.newEntity(id, p32.model, nil, p32.player, p32.owner, p32.cframe, p32.full, config.snapshotCount);
    v33.snapshots.spacing = config.tickRate;
    u7.push(v33.snapshots, u5.now(), p32.cframe);
    u10.entities[id] = v33;

    if p32.model then
        u10.byModel[p32.model] = v33;
    end;

    local player = p32.player;

    if player then
        u10.playerEntities[player] = v33;
    end;

    u10._resolve(v33);
    u10._applyOwnership(v33);
    u4.EntityAdded:Fire(v33);

    if player then
        u4.CharacterRegistered:Fire(player, v33);
    end;
end;

function u10._onSync() -- Line: 243
    -- upvalues: u1 (copy), u6 (copy), u10 (copy)
    local v34 = u1.readuint(8);
    local table_create_ret = table.create(v34);

    for i = 1, v34 do
        table_create_ret[i] = u6.readDescription();
        local _ = i;
    end;

    for _, v in table_create_ret do
        u10._add(v);
    end;
end;

function u10._onAdd() -- Line: 254
    -- upvalues: u10 (copy), u6 (copy)
    u10._add(u6.readDescription());
end;

function u10._onRemove() -- Line: 258
    -- upvalues: u10 (copy), u1 (copy)
    u10._remove(u1.readuint(8));
end;

function u10._onOwner() -- Line: 262
    -- upvalues: u1 (copy), u10 (copy), u7 (copy), LocalPlayer (copy), u4 (copy)
    local v35 = u1.readuint(8);
    local v36 = u1.readref();
    local v37 = u10.entities[v35];

    if not v37 then
        return;
    end;

    if typeof(v36) ~= "Instance" or not v36:IsA("Player") then
        v36 = nil;
    end;

    local owner = v37.owner;
    v37.owner = v36;
    u7.clear(v37.snapshots);
    u10._resetClock(v37);
    v37.lastSent = nil;
    v37.lastSentAt = nil;
    v37.held = false;

    if v36 == LocalPlayer then
        v37.copy = nil;
    end;

    u10._applyOwnership(v37);
    u4.OwnerChanged:Fire(v37, v36, owner);
end;

function u10._onTeleport() -- Line: 284
    -- upvalues: u1 (copy), u10 (copy), u7 (copy), u4 (copy)
    local v38 = u1.readuint(8);
    local v39 = u1.readcframe();
    local v40 = u10.entities[v38];

    if not v40 then
        return;
    end;

    local v41 = u10._resolve(v40);

    if v41 and u10._isOwned(v40) then
        v41.CFrame = v39;
        v41.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
    end;

    v40.cframe = v39;
    v40.pendingAck = true;
    u7.clear(v40.snapshots);
    u4.Teleported:Fire(v40, v39);
end;

function u10._readEntries(p42: boolean) -- Line: 302
    -- upvalues: u1 (copy), u6 (copy)
    local v43 = u1.readuint(8);
    local table_create_ret = table.create(v43);

    for i = 1, v43 do
        local v44, v45, v46, v47 = u6.readEntry(p42);
        table_create_ret[i] = {
            id = v44,
            flags = v45,
            offset = v46,
            cframe = v47
        };
        local _ = i;
    end;

    return table_create_ret;
end;

function u10._onSnapshot() -- Line: 312
    -- upvalues: u5 (copy), u1 (copy), u10 (copy), u6 (copy), u7 (copy), u4 (copy)
    local v48 = u5.unwrap(u1.readuint(32), u5.tick());

    for _, v in u10._readEntries(true) do
        local v49 = u10.entities[v.id];

        if v49 and not (v49.destroyed or u10._isOwned(v49)) then
            local copy = v49.copy;
            local v50, v51, v52, v53;

            if copy then
                if v48 > copy.tick then
                    v49.copy = nil;
                    v50 = v48 + v.offset;
                    v51 = u5.time(v50);
                    v52 = u6.hasFlag(v.flags, u6.FlagSnap);

                    if v52 then
                        u7.clear(v49.snapshots);
                        v49.renderAt = nil;
                    end;

                    v53 = u7.latest(v49.snapshots);

                    if not v53 or v51 > v53 then
                        if not (v52 or u6.hasFlag(v.flags, u6.FlagAck)) then
                            u10._trackSample(v49, v51);
                        end;

                        u7.push(v49.snapshots, v51, v.cframe);
                        v49.cframe = v.cframe;
                        v49.tick = math.floor(v50);
                        v49.time = v51;
                        u4.Snapshot:Fire(v49, v51, v.cframe);
                    end;
                end;
            else
                v50 = v48 + v.offset;
                v51 = u5.time(v50);
                v52 = u6.hasFlag(v.flags, u6.FlagSnap);

                if v52 then
                    u7.clear(v49.snapshots);
                    v49.renderAt = nil;
                end;

                v53 = u7.latest(v49.snapshots);

                if not v53 or v51 > v53 then
                    if not (v52 or u6.hasFlag(v.flags, u6.FlagAck)) then
                        u10._trackSample(v49, v51);
                    end;

                    u7.push(v49.snapshots, v51, v.cframe);
                    v49.cframe = v.cframe;
                    v49.tick = math.floor(v50);
                    v49.time = v51;
                    u4.Snapshot:Fire(v49, v51, v.cframe);
                end;
            end;
        end;
    end;
end;

function u10._enterCopyMode(p54) -- Line: 349
    -- upvalues: u10 (copy), u7 (copy)
    local v55 = u10._resolve(p54);
    local v56;

    if v55 then
        v56 = v55.CFrame;
    else
        v56 = p54.cframe;
    end;

    local v57 = {
        alpha = 1,
        tick = 0,
        buffer = {},
        from = v56,
        cframe = v56
    };
    p54.copy = v57;
    u7.clear(p54.snapshots);
    u10._resetClock(p54);

    return v57;
end;

function u10._pushCopy(p58: any, p59, p60: boolean) -- Line: 365
    local buffer = p58.buffer;

    if p60 then
        table.clear(buffer);
        p58.from = p59;
        p58.cframe = p59;
        p58.alpha = 1;

        return;
    end;

    table.insert(buffer, 1, p59);

    if #buffer <= 3 then
        if #buffer == 1 then
            p58.from = p58.cframe;
            p58.alpha = 0;
        end;

        return;
    end;

    p58.from = table.remove(buffer, 4);
    p58.alpha = 0;
end;

function u10._onReplicate() -- Line: 385
    -- upvalues: u5 (copy), u1 (copy), u10 (copy), u6 (copy), u4 (copy)
    local v61 = u5.unwrap(u1.readuint(32), u5.tick());

    for _, v in u10._readEntries(false) do
        local v62 = u10.entities[v.id];

        if v62 and not (v62.destroyed or u10._isOwned(v62)) then
            local v63 = v62.copy or u10._enterCopyMode(v62);

            if v61 >= v63.tick then
                v63.tick = v61;
                u10._pushCopy(v63, v.cframe, u6.hasFlag(v.flags, u6.FlagSnap));
                local v64 = u5.time(v61);
                v62.cframe = v.cframe;
                v62.tick = v61;
                v62.time = v64;
                u4.Snapshot:Fire(v62, v64, v.cframe);
            end;
        end;
    end;
end;

function u10._stepCopy(p65: any, p66: any, p67: number) -- Line: 407
    -- upvalues: u10 (copy)
    local v68 = u10._resolve(p65);

    if v68 and (v68.Parent and u10._canInterpolate(p65, v68)) then
        v68.CFrame = p66.cframe;
    end;

    local buffer = p66.buffer;

    if p66.alpha == 1 or #buffer == 0 then
        return;
    end;

    p66.alpha = p66.alpha + p67 / 0.03333333333333333 * #buffer;
    local v69 = buffer[#buffer];

    if p66.alpha >= 1 then
        table.remove(buffer);

        if #buffer == 0 then
            p66.alpha = 1;
        else
            p66.alpha = 0;
            p66.from = v69;
        end;
    end;

    p66.cframe = p66.from:Lerp(v69, p66.alpha);
end;

function u10._canInterpolate(p70: any, p71: userdata) -- Line: 432
    if p70.player and (p71.Anchored and not p70.anchored) then
        return false;
    end;

    return p71.AssemblyRootPart == p71;
end;

function u10._interpolate(p72: any, p73: number) -- Line: 439
    -- upvalues: u10 (copy), u7 (copy)
    local v74 = u10._resolve(p72);

    if not (v74 and (v74.Parent and p72.snapshots.count ~= 0)) then
        return;
    end;

    local offset = p72.offset;

    if not (offset and u10._canInterpolate(p72, v74)) then
        return;
    end;

    local v75 = u10._getBuffer(p72);
    local v76 = u10._localTime() - offset;
    local v77 = v76 - v75;
    local v78 = (p72.renderAt or v77) + p73;
    local v79 = v75 - (v76 - v78);

    if math.abs(v79) > 0.1 then
        v78 = v77;
    elseif v79 > 0.01 then
        v78 = math.max(v77, v78 - p73 * 0.1);
    elseif v79 < -0.01 then
        v78 = math.min(v77, v78 + p73 * 0.1);
    end;

    p72.renderAt = v78;
    local v80 = u7.sample(p72.snapshots, v78);

    if v80 then
        v74.CFrame = v80;
    end;
end;

function u10._velocity(p81: userdata, p82, p83, p84: number, p85: boolean) -- Line: 469
    local v86 = p81.Anchored and Vector3.new(0, 0, 0) or p81.AssemblyLinearVelocity;

    if p85 or (not p82 or p84 <= 0) then
        return v86;
    end;

    local v87 = (p83.Position - p82.Position) / p84;

    if v87.Magnitude > 500 then
        return v86;
    end;

    if p81.Anchored then
        return v87;
    end;

    if Vector3.new(v87.X, 0, v87.Z).Magnitude > Vector3.new(v86.X, 0, v86.Z).Magnitude + 20 then
        return Vector3.new(v87.X, v86.Y, v87.Z);
    end;

    return v86;
end;

function u10._send(p88: any, p89: number, p90: number) -- Line: 487
    -- upvalues: u10 (copy), u8 (copy), u6 (copy), u1 (copy), u5 (copy)
    local v91 = u10._resolve(p88);

    if not (v91 and v91.Parent) then
        return;
    end;

    if u8.get(v91) then
        u8.remove(v91);
    end;

    if v91.Anchored and not p88.anchored then
        p88.held = true;

        return;
    end;

    local CFrame = v91.CFrame;

    if not u6.isFinite(CFrame.Position) then
        return;
    end;

    local v92 = u10._localTime();
    local lastSent = p88.lastSent;

    if p88.held then
        p88.held = false;

        if lastSent and (CFrame.Position - lastSent.Position).Magnitude > 1 then
            p88.snapPending = true;
        end;
    end;

    if lastSent and CFrame:FuzzyEq(lastSent, 0.0001) then
        if not (p88.pendingAck or (p88.snapPending or u10.config.sendUnchanged)) then
            if p88.settle > 0 then
                p88.settle = p88.settle - 1;
            elseif v92 - (p88.lastSentAt or (-1 / 0)) < 0.5 then
                return;
            end;
        end;
    else
        p88.settle = 6;
    end;

    local snapPending = p88.snapPending;
    local pendingAck = p88.pendingAck;
    local v93 = u10._velocity(v91, lastSent, CFrame, v92 - (p88.lastSentAt or v92), snapPending or pendingAck);
    local v94 = (not pendingAck and 0 or u6.FlagAck) + (not snapPending and 0 or u6.FlagSnap);
    u1.write("replicatorMove", "unreliable").writeuint(u5.wrap(p89), 32).writeuint(p90, 8);
    u6.writeEntry(p88.id, v94, CFrame, p88.fullRotation);
    u1.writevector(v93).send();
    p88.pendingAck = false;
    p88.snapPending = false;
    p88.lastSent = CFrame;
    p88.lastSentAt = v92;
    p88.cframe = CFrame;
end;

function u10._onUpdate() -- Line: 540
    -- upvalues: u5 (copy), u2 (copy), u10 (copy)
    local v95 = u5.tick();
    local v96 = (u2.now() * u5.TicksPerSecond - v95) * 256;
    local math_floor_ret = math.floor(v96);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, 255);

    for _, v in u10.entities do
        if not v.destroyed and u10._isOwned(v) then
            u10._send(v, v95, math_clamp_ret);
        end;
    end;
end;

function u10._onPreSimulation(p97: number) -- Line: 550
    -- upvalues: u10 (copy)
    for _, v in u10.entities do
        local copy = v.copy;

        if copy and not (v.destroyed or u10._isOwned(v)) then
            u10._stepCopy(v, copy, p97);
        end;
    end;
end;

function u10._onHeartbeat(p98: number) -- Line: 559
    -- upvalues: u10 (copy)
    for _, v in u10.entities do
        if not (v.destroyed or (v.copy or u10._isOwned(v))) then
            u10._interpolate(v, p98);
        end;
    end;
end;

function u10.start(p99) -- Line: 567
    -- upvalues: u10 (copy), u1 (copy), u2 (copy), RunService (copy), LocalPlayer (copy)
    u10.config = p99;
    u1.receive("replicatorSync", u10._onSync);
    u1.receive("replicatorAdd", u10._onAdd);
    u1.receive("replicatorRemove", u10._onRemove);
    u1.receive("replicatorOwner", u10._onOwner);
    u1.receive("replicatorTeleport", u10._onTeleport);
    u1.receive("replicatorSnapshot", u10._onSnapshot);
    u1.receive("replicatorReplicate", u10._onReplicate);
    u1.write("replicatorReady", "reliable").send();
    u2.onUpdate:Connect(u10._onUpdate);
    RunService.PreSimulation:Connect(u10._onPreSimulation);
    RunService.Heartbeat:Connect(u10._onHeartbeat);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 583
        -- upvalues: u10 (ref), LocalPlayer (ref)
        for _, v in u10.entities do
            if v.player == LocalPlayer then
                v.root = nil;
                v.lastSent = nil;
                v.lastSentAt = nil;
                v.held = false;
                u10._applyOwnership(v);
            end;
        end;
    end);
end;

return u10;