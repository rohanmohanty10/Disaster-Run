 

 

local PoolHide = require(script.Parent.PoolHide);
local VisualHost = require(script.Parent.VisualHost);
local AtRest = require(script.Parent.AtRest);
local Log = require(script.Parent.Log);
local u1 = {};

local function _getPoolFolder() -- Line: 17
    -- upvalues: VisualHost (copy)
    return VisualHost.getPoolFolder();
end;

u1._pools = {};
u1._totalSize = 0;
u1._lastSweepAt = 0;
u1._lastReportAt = 0;
u1._releaseGen = setmetatable({}, {
    __mode = "k"
});
u1.MAX_POOL_TOTAL = 2048;
u1.TTL = 5;
u1.SWEEP_INTERVAL = 2;
u1.REPORT_INTERVAL = 0;
u1.MIN_CAP = 8;
u1.CAP_SAFETY = 1.25;

local function estimateCap(p2) -- Line: 37
    -- upvalues: u1 (copy)
    local v3 = math.max(p2 or 0, 0) * u1.TTL * u1.CAP_SAFETY;

    return math.ceil(v3) + u1.MIN_CAP;
end;

local function getOrInitPool(p4) -- Line: 42
    -- upvalues: u1 (copy)
    local v5 = u1._pools[p4];

    if v5 then
        return v5;
    end;

    local v6 = {
        peakSize = 0,
        hits = 0,
        misses = 0,
        evictions = 0,
        entries = {},
        gen = p4:GetAttribute("_PoolGen") or 0,
        cap = u1.MIN_CAP
    };
    u1._pools[p4] = v6;

    return v6;
end;

function u1.dropCloneMap(p7) -- Line: 58
    -- upvalues: u1 (copy)
    if p7 and u1._cloneMaps then
        u1._cloneMaps[p7] = nil;
    end;
end;

local function destroyEntry(u8) -- Line: 62
    -- upvalues: u1 (copy)
    if u8 and u8.instance then
        u1.dropCloneMap(u8.instance);
        pcall(function() -- Line: 65
            -- upvalues: u8 (copy)
            u8.instance:Destroy();
        end);
    end;
end;

local function discardAllEntries(p9) -- Line: 69
    -- upvalues: u1 (copy)
    for i = 1, #p9.entries do
        local u10 = p9.entries[i];
        local v11;

        if u10 and u10.instance then
            u1.dropCloneMap(u10.instance);
            pcall(function() -- Line: 65
                -- upvalues: u10 (copy)
                u10.instance:Destroy();
            end);
            v11 = i;
        else
            v11 = i;
        end;
    end;

    u1._totalSize = math.max(0, u1._totalSize - #p9.entries);
    p9.entries = {};
end;

function u1.acquire(p12, p13) -- Line: 76
    -- upvalues: getOrInitPool (copy), discardAllEntries (copy), u1 (copy), PoolHide (copy)
    if not p12 then
        return nil;
    end;

    local v14 = getOrInitPool(p12);
    local v15 = p12:GetAttribute("_PoolGen") or 0;

    if v15 ~= v14.gen then
        discardAllEntries(v14);
        v14.gen = v15;
    end;

    while #v14.entries > 0 do
        local table_remove_ret = table.remove(v14.entries);
        u1._totalSize = math.max(0, u1._totalSize - 1);
        local instance = table_remove_ret.instance;

        if instance and instance.Parent then
            PoolHide.show(instance, p13);
            v14.hits = v14.hits + 1;

            return instance;
        end;
    end;

    v14.misses = v14.misses + 1;

    return nil;
end;

function u1.release(u16, p17, p18, p19) -- Line: 100
    -- upvalues: getOrInitPool (copy), u1 (copy), PoolHide (copy), VisualHost (copy)
    if not (u16 and p17) then
        return;
    end;

    if not u16.Parent then
        return;
    end;

    local v20 = getOrInitPool(p17);

    if p19 then
        local v21 = math.max(p19 or 0, 0) * u1.TTL * u1.CAP_SAFETY;
        v20.cap = math.ceil(v21) + u1.MIN_CAP;
    end;

    if u1._totalSize >= u1.MAX_POOL_TOTAL then
        u1.dropCloneMap(u16);
        pcall(function() -- Line: 107
            -- upvalues: u16 (copy)
            u16:Destroy();
        end);

        return;
    end;

    while #v20.entries >= v20.cap do
        local table_remove_ret = table.remove(v20.entries, 1);
        u1._totalSize = math.max(0, u1._totalSize - 1);

        if table_remove_ret and table_remove_ret.instance then
            u1.dropCloneMap(table_remove_ret.instance);
            pcall(function() -- Line: 65
                -- upvalues: table_remove_ret (copy)
                table_remove_ret.instance:Destroy();
            end);
        end;

        v20.evictions = v20.evictions + 1;
    end;

    PoolHide.hide(u16, p18);
    u1._releaseGen[u16] = (u1._releaseGen[u16] or 0) + 1;
    pcall(function() -- Line: 121
        -- upvalues: u16 (copy), VisualHost (ref)
        u16.Parent = VisualHost.getPoolFolder();
    end);
    v20.entries[#v20.entries + 1] = {
        instance = u16,
        pooledAt = os.clock()
    };
    local v22 = u1;
    v22._totalSize = v22._totalSize + 1;

    if #v20.entries > v20.peakSize then
        v20.peakSize = #v20.entries;
    end;
end;

function u1.linkGen(p23) -- Line: 127
    -- upvalues: u1 (copy)
    return u1._releaseGen[p23] or 0;
end;

function u1.tickSweep(p24) -- Line: 132
    -- upvalues: u1 (copy)
    if p24 - u1._lastSweepAt < u1.SWEEP_INTERVAL then
        return;
    end;

    u1._lastSweepAt = p24;
    local v25 = 64;
    local v26 = nil;

    for i, v in pairs(u1._pools) do
        local v27 = i;
        local v28 = v;
        local v29 = 1;

        while v29 <= #v28.entries and v25 > 0 do
            local u30 = v28.entries[v29];
            local instance = u30.instance;

            if p24 - u30.pooledAt > u1.TTL and true or not (instance and instance.Parent) then
                if u30 and u30.instance then
                    u1.dropCloneMap(u30.instance);
                    pcall(function() -- Line: 65
                        -- upvalues: u30 (copy)
                        u30.instance:Destroy();
                    end);
                end;

                local v31 = #v28.entries;

                if v29 < v31 then
                    v28.entries[v29] = v28.entries[v31];
                end;

                v28.entries[v31] = nil;
                u1._totalSize = math.max(0, u1._totalSize - 1);
                v28.evictions = v28.evictions + 1;
                v25 = v25 - 1;
            else
                v29 = v29 + 1;
            end;
        end;

        if #v28.entries == 0 and not (v27 and v27.Parent) then
            v26 = v26 or {};
            v26[#v26 + 1] = v27;
        end;
    end;

    if v26 then
        for _, v in ipairs(v26) do
            u1._pools[v] = nil;
        end;
    end;
end;

function u1.bumpGen(u32) -- Line: 173
    if not u32 then
        return;
    end;

    local u33 = u32:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 176
        -- upvalues: u32 (copy), u33 (copy)
        u32:SetAttribute("_PoolGen", u33 + 1);
    end);
end;

function u1.flushSource(p34) -- Line: 180
    -- upvalues: u1 (copy), discardAllEntries (copy)
    local v35 = u1._pools[p34];

    if not v35 then
        return;
    end;

    discardAllEntries(v35);
    u1._pools[p34] = nil;
end;

function u1.flushAll() -- Line: 188
    -- upvalues: u1 (copy), discardAllEntries (copy)
    for _, v in pairs(u1._pools) do
        discardAllEntries(v);
    end;

    u1._pools = {};
    u1._totalSize = 0;
    u1._cloneMaps = setmetatable({}, {
        __mode = "k"
    });
end;

function u1.tickReport(p36) -- Line: 198
    -- upvalues: u1 (copy), Log (copy)
    if u1.REPORT_INTERVAL <= 0 then
        return;
    end;

    if p36 - u1._lastReportAt < u1.REPORT_INTERVAL then
        return;
    end;

    u1._lastReportAt = p36;
    local v37 = 0;
    local v38 = 0;
    local v39 = 0;
    local v40 = 0;
    local v41 = 0;
    local v42 = 0;

    for _ in pairs(u1._pools) do
        v37 = v37 + 1;
    end;

    for _, v in pairs(u1._pools) do
        v38 = v38 + #v.entries;
        v39 = v39 + v.hits;
        v40 = v40 + v.misses;
        v41 = v41 + v.evictions;

        if v42 < v.peakSize then
            v42 = v.peakSize;
        end;
    end;

    Log.print(string.format("[Part-Icles Pool] sources=%d entries=%d/%d peak=%d hits=%d misses=%d (%.1f%% hit) evictions=%d", v37, v38, u1.MAX_POOL_TOTAL, v42, v39, v40, v39 + v40 > 0 and (v39 / (v39 + v40) * 100 or 0) or 0, v41));
end;

function u1.acquireOrClone(p43, p44, p45) -- Line: 221
    -- upvalues: u1 (copy)
    local v46;

    if p45 == false then
        v46 = p43:Clone();
    else
        v46 = u1.acquire(p43, p44) or p43:Clone();
    end;

    v46:SetAttribute("_PartIcleEmit", true);

    return v46;
end;

local u47 = { "Attachment0", "Attachment1" };
local u48 = setmetatable({}, {
    __mode = "k"
});

local function copyBare(p49, p50, p51) -- Line: 243
    -- upvalues: AtRest (copy), copyBare (copy), u47 (copy), u48 (copy)
    local v52 = p50 or {};
    local Instance_fromExisting_ret = Instance.fromExisting(p49);
    AtRest.wakeCopy(Instance_fromExisting_ret);
    v52[p49] = Instance_fromExisting_ret;

    for _, child in ipairs(p49:GetChildren()) do
        if not (child:GetAttribute("Transformed") or child:GetAttribute("_PartIcleEmit")) then
            copyBare(child, v52, false).Parent = Instance_fromExisting_ret;
        end;
    end;

    if p51 == nil or p51 then
        local v53 = nil;

        for i, v in pairs(v52) do
            if i:IsA("Trail") or i:IsA("Beam") then
                local v54 = v;
                local v55 = i;

                for _, v2 in ipairs(u47) do
                    local v56 = v55[v2];

                    if v56 and v52[v56] then
                        v54[v2] = v52[v56];
                    elseif v56 and v56:GetAttribute("Transformed") then
                        v53 = v53 or {};
                        table.insert(v53, {
                            clone = v54,
                            property = v2,
                            source = v56
                        });
                    end;
                end;
            elseif i:IsA("Model") and i.PrimaryPart then
                v.PrimaryPart = v52[i.PrimaryPart];
            end;
        end;

        u48[v52] = v53;
    end;

    return Instance_fromExisting_ret, v52;
end;

u1.copyBare = copyBare;

function u1.registerEmitted(p57, p58, p59) -- Line: 286
    -- upvalues: u48 (copy)
    rawset(p57, p58, p59);
    local v60 = u48[p57];

    if not v60 then
        return;
    end;

    for _, v in ipairs(v60) do
        if v.source == p58 then
            v.clone[v.property] = p59;
        end;
    end;
end;

local function resetLateEnds(p61) -- Line: 297
    -- upvalues: u48 (copy)
    local v62 = u48[p61];

    if not v62 then
        return;
    end;

    for _, v in ipairs(v62) do
        v.clone[v.property] = v.source;
        rawset(p61, v.source, nil);
    end;
end;

u1._cloneMaps = setmetatable({}, {
    __mode = "k"
});

function u1.acquireOrCopyBare(p63, p64, p65) -- Line: 310
    -- upvalues: copyBare (copy), u1 (copy), resetLateEnds (copy)
    local v66, v67;

    if p65 == false then
        v66, v67 = copyBare(p63);
    else
        v66 = u1.acquire(p63, p64);

        if v66 then
            v67 = u1._cloneMaps[v66];

            if v67 then
                resetLateEnds(v67);
            end;
        else
            v66, v67 = copyBare(p63);
        end;
    end;

    if v67 then
        u1._cloneMaps[v66] = v67;
    end;

    v66:SetAttribute("_PartIcleEmit", true);

    return v66;
end;

function u1.restoreTrails(u68, u69) -- Line: 333
    -- upvalues: PoolHide (copy)
    task.delay(0, function() -- Line: 334
        -- upvalues: u68 (copy), PoolHide (ref), u69 (copy)
        if not (u68 and u68.Parent) then
            return;
        end;

        PoolHide.restoreTrails(u68, u69);
    end);
end;

function u1.tick(p70) -- Line: 341
    -- upvalues: u1 (copy)
    u1.tickSweep(p70);
    u1.tickReport(p70);
end;

function u1.stats() -- Line: 346
    -- upvalues: u1 (copy)
    local v71 = {
        totalSize = u1._totalSize,
        sources = {}
    };

    for i, v in pairs(u1._pools) do
        v71.sources[i] = {
            size = #v.entries,
            peakSize = v.peakSize,
            cap = v.cap,
            gen = v.gen,
            hits = v.hits,
            misses = v.misses,
            evictions = v.evictions
        };
    end;

    return v71;
end;

return u1;