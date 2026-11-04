 

 

local Range = require(script.Parent.Parent.Range);
local Play = require(script.Parent.Play);
local Pieces = require(script.Parent.Pieces);
local Support = require(script.Parent.Support);
local Display = require(script.Parent.Display);
local Shards = require(script.Parent.Shards);
local CutPlan = require(script.Parent.CutPlan);
local Recrack = require(script.Parent.Recrack);
local Recarve = require(script.Parent.Recarve);
local Wounds = require(script.Parent.Wounds);
local Owned = require(script.Parent.Owned);
local Patches = require(script.Parent.Patches);
local GroundDisplay = require(script.Parent.GroundDisplay);
local Batch = require(script.Parent.Batch);
local u1 = {};

local function playSettings(u2, p3) -- Line: 75
    -- upvalues: Range (copy)
    return {
        wakeBudget = 100,
        buildBudget = 150,
        Hold = u2.Hold,
        HoldSpread = u2.HoldSpread,
        Collapse = u2.Collapse,
        isAnchored = p3,
        After = u2.After,
        AfterDelay = u2.AfterDelay,
        AfterTime = u2.AfterTime,
        MaxPieces = u2.MaxPieces,
        MaxAirTime = u2.MaxAirTime,
        random = math.random,

        rollGravity = function() -- Line: 89, Name: rollGravity
            -- upvalues: Range (ref), u2 (copy)
            return Range.RandomValueFromRange(u2.Gravity);
        end,

        rollBounciness = function() -- Line: 92, Name: rollBounciness
            -- upvalues: Range (ref), u2 (copy)
            return Range.RandomValueFromRange(u2.Bounciness);
        end,

        rollFriction = function() -- Line: 95, Name: rollFriction
            -- upvalues: Range (ref), u2 (copy)
            return Range.RandomValueFromRange(u2.Friction);
        end,

        rollTumble = function() -- Line: 98, Name: rollTumble
            -- upvalues: Range (ref), u2 (copy)
            local v4 = Range.RandomValueFromRange(u2.TumbleSpeed);

            return math.rad(v4);
        end
    };
end;

local function hostFrame(p5) -- Line: 105
    if p5:IsA("Model") then
        return p5:GetPivot();
    end;

    return p5.CFrame;
end;

function u1.emitOrigin(p6) -- Line: 113
    if not p6 then
        return nil;
    end;

    local v7;

    if p6.EventOriginResolver then
        v7 = p6.EventOriginResolver();
    else
        v7 = nil;
    end;

    local v8 = v7 or p6.EventOriginCF;

    if v8 then
        return v8, p6.UseFullOrigin == true;
    end;

    return nil;
end;

local function hasGrounds(p9, p10) -- Line: 130
    -- upvalues: u1 (copy)
    local v11;

    if p9.Break == "Shards" and (p9.ShardPattern == "Cracks" and u1.emitOrigin(p10) == nil) then
        v11 = not p9.NoGrounds;
    else
        v11 = false;
    end;

    return v11;
end;

local function applyHitFilter(u12, u13) -- Line: 136
    if u13.HitGroup and u13.HitGroup ~= "" then
        pcall(function() -- Line: 139
            -- upvalues: u12 (copy), u13 (copy)
            u12.CollisionGroup = u13.HitGroup;
        end);
    end;

    for _, v in ipairs(u13.HitExcludes or {}) do
        u12:AddToFilter(v);
    end;
end;

local function makePlay(p14, p15, p16, u17, p18) -- Line: 152
    -- upvalues: applyHitFilter (copy), Display (copy), Support (copy), playSettings (copy), Play (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.FilterDescendantsInstances = { p14:GetFolder(), p14:GetPoolFolder() };
    applyHitFilter(RaycastParams_new_ret, p16);
    local u19 = Display.new(u17, p14:GetFolder(), Display.serverOnly(), p18);
    local wake = u19.wake;
    local u20 = {};

    function u19.wake(p21) -- Line: 162
        -- upvalues: wake (copy), u19 (copy), u20 (copy), Display (ref), u17 (copy), RaycastParams_new_ret (copy)
        local v22 = wake(p21);
        local v23 = u19.original(p21);

        if not (u20[v23] or Display.cracked(u17[p21])) then
            u20[v23] = true;
            RaycastParams_new_ret:AddToFilter(v23);
        end;

        return v22;
    end;

    local function castRay(p24, p25) -- Line: 172
        -- upvalues: RaycastParams_new_ret (copy)
        return workspace:Raycast(p24, p25, RaycastParams_new_ret);
    end;

    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.RespectCanCollide = true;
    RaycastParams_new_ret2.FilterDescendantsInstances = { p15, p14:GetFolder(), p14:GetPoolFolder() };
    applyHitFilter(RaycastParams_new_ret2, p16);
    local v29 = playSettings(p16, function(p26) -- Line: 182, Name: isAnchored
        -- upvalues: u17 (copy), Support (ref), RaycastParams_new_ret2 (copy)
        local v27 = u17[p26];

        if v27.fixed then
            return true;
        end;

        local v28 = Support.worldHalf(v27).Y + 0.3;

        return workspace:Raycast(v27.rest.Position, Vector3.new(0, -v28, 0), RaycastParams_new_ret2) ~= nil;
    end);
    v29.closes = p18 == true;

    if not p18 then
        for _, v in ipairs(u17) do
            if v.strike then
                v29.closes = true;
                v29.takesAfter = true;
                break;
            end;
        end;
    end;

    return Play.new(u17, v29, u19, castRay), u19;
end;

local function woundsOf(u30, u31, u32, u33, p34) -- Line: 209
    -- upvalues: GroundDisplay (copy), Display (copy), Shards (copy), Wounds (copy), Batch (copy), Patches (copy), makePlay (copy), u1 (copy)
    if #p34 == 0 then
        return nil;
    end;

    local v35 = GroundDisplay.new(u30:GetFolder(), Display.serverOnly(), Shards.without);

    return Wounds.new({
        snap = 2,
        grounds = p34,
        pieceCount = u33.Pieces,
        maxPieces = u33.MaxPieces,
        after = u33.After,
        afterDelay = u33.AfterDelay,

        cut = function(p36, u37) -- Line: 222, Name: cut
            -- upvalues: Batch (ref), Patches (ref)
            local u38 = Batch.take();
            Patches.cut(p36, function(u39) -- Line: 224
                -- upvalues: Batch (ref), u38 (copy), u37 (copy)
                Batch.give(u38, function() -- Line: 225
                    -- upvalues: u37 (ref), u39 (copy)
                    u37(u39);
                end);
            end);
        end,

        play = function(p40) -- Line: 230, Name: play
            -- upvalues: makePlay (ref), u30 (copy), u32 (copy), u33 (copy)
            return makePlay(u30, u32, u33, p40, true);
        end,

        draw = v35.draw,

        isCurrent = function() -- Line: 234, Name: isCurrent
            -- upvalues: u30 (copy), u32 (copy), u31 (copy)
            return u30._reactorPlays[u32] == u31;
        end,

        revive = function() -- Line: 237, Name: revive
            -- upvalues: u1 (ref), u30 (copy), u31 (copy)
            if not u1.resume(u30, u31) then
                u1.discard(u30, u31);
            end;
        end
    });
end;

local function newEntry(p41, p42, p43, p44, u45, p46) -- Line: 247
    -- upvalues: u1 (copy), CutPlan (copy), Pieces (copy), Owned (copy), makePlay (copy), woundsOf (copy)
    local v47 = {};
    local u48 = {};
    local v49;

    if p43.Break == "Shards" and (p43.ShardPattern == "Cracks" and u1.emitOrigin(p44) == nil) then
        v49 = not p43.NoGrounds;
    else
        v49 = false;
    end;

    if v49 then
        v47, u48 = CutPlan.grounds(p42);
    end;

    local v52 = Pieces.collect(p42, p43.Break, p43.Pieces, u45 and function(p50) -- Line: 254
        -- upvalues: u45 (copy)
        return u45[p50];
    end, function(p51) -- Line: 256
        -- upvalues: u48 (ref)
        return u48[p51] == true;
    end);

    if #v52 == 0 and #v47 == 0 then
        return nil;
    end;

    if p46 then
        Owned.mark(v52, p46);
    end;

    local v53, v54 = u1.emitOrigin(p44);

    if v53 then
        local carry = Pieces.carry;
        local v55;

        if p42:IsA("Model") then
            v55 = p42:GetPivot();
        else
            v55 = p42.CFrame;
        end;

        carry(v52, v55, v53, v54);
    end;

    local v56 = {
        pData = nil,
        reactor = p42,
        group = p43.Group,
        play = makePlay(p41, p42, p43, v52, false)
    };
    local v57;

    if p43.Break == "Shards" then
        v57 = p43.ShardPattern == "Cracks";
    else
        v57 = false;
    end;

    v56.cracksAgain = v57;
    v56.pieceCount = p43.Pieces;
    v56.breaks = CutPlan.byEngine(p43);
    v56.cracks = {};
    v56.wounds = woundsOf(p41, v56, p42, p43, v47);

    if p46 then
        Owned.adopt(v56, p46);
    end;

    return v56;
end;

function u1.resume(p58, u59) -- Line: 288
    if u59.pData then
        return true;
    end;

    local owner = u59.owner;
    local v60 = owner and owner.source or u59.reactor;
    local u61 = {
        Type = "Reactor",
        VisualPart = nil,
        TotalKeyFrames = 1,
        CurrentStep = -1,
        LifeTime = (1 / 0),
        PartLife = 0,
        _effectiveElapsed = 0,
        StartTime = os.clock(),
        Graphs = {},
        Seeds = {},
        _sourceItem = v60,
        _entry = u59
    };

    function u61._onReclaim() -- Line: 309
        -- upvalues: u59 (copy), u61 (copy)
        if u59.pData == u61 then
            u59.pData = nil;
        end;
    end;

    p58._seedTsOverride(u61, v60);
    u59.pData = u61;

    if owner then
        owner = owner.context;
    end;

    p58:_registerEmit(u61, owner);

    return u59.pData == u61;
end;

function u1.putBack(p62) -- Line: 320
    p62.play:restore();

    if p62.wounds then
        p62.wounds:restore();
    end;
end;

function u1.discard(p63, p64, p65) -- Line: 327
    -- upvalues: u1 (copy), Owned (copy)
    u1.putBack(p64);
    p63._reactorPlays[p64.reactor] = nil;
    Owned.gone(p63, p64.owner, p65 == true);
end;

function u1.crackAgain(u66, u67, p68, p69) -- Line: 334
    -- upvalues: u1 (copy), Recarve (copy), Recrack (copy)
    if p68.actsAs ~= "Impulse" then
        return;
    end;

    local function isCurrent() -- Line: 338
        -- upvalues: u66 (copy), u67 (copy)
        return u66._reactorPlays[u67.reactor] == u67;
    end;

    local function revive() -- Line: 341
        -- upvalues: u1 (ref), u66 (copy), u67 (copy)
        if not u1.resume(u66, u67) then
            u1.discard(u66, u67);
        end;
    end;

    if p68.cut then
        if u67.cutBy ~= p68 then
            Recarve.request(u67, p68, p69, isCurrent, revive);
        end;

        return;
    end;

    if u67.cracksAgain then
        Recrack.request(u67, p68, p69, isCurrent, revive);
    end;
end;

function u1.follow(p70, p71, p72, p73) -- Line: 358
    -- upvalues: u1 (copy)
    local play = p71.play;
    local v74 = nil;
    local v75;

    if p73 then
        local v76;

        if p72.cut == nil then
            v76 = false;
        else
            v76 = p71.cutBy ~= p72;
        end;

        local v77;
        v77, v74 = play:answer(p72, v76);
        v75 = v77 or p71.owner ~= nil;
    else
        v75 = play:watch(p72);
    end;

    local wounds = p71.wounds;

    if wounds then
        wounds:strike(p72);
        v75 = (wounds:watch(p72) or wounds:busy()) and true or v75;
    end;

    if not v75 then
        return;
    end;

    if u1.resume(p70, p71) then
        u1.crackAgain(p70, p71, p72, v74 or play.kicks[p72]);

        return;
    end;

    u1.discard(p70, p71);
end;

function u1.step(p78, p79, p80, p81, p82) -- Line: 386
    local v83 = p78.play:step(p79);

    if not p78.wounds then
        return v83;
    end;

    local v84 = p78.wounds:step(p80, p81, p82);

    return (v83 == "active" or v84 == "active") and "active" or (v83 == "done" and v84 == "done" and "done" or "dormant");
end;

local function cutFor(p85, p86) -- Line: 404
    p85.cutBy = p86;

    for _, v in ipairs(p85.play.pieces) do
        if v.strike and not v.strike.by then
            v.strike.by = p86;
        end;

        if v.slash and not v.slash.by then
            v.slash.by = p86;
        end;
    end;
end;

local function startCutting(u87, u88, u89, u90, u91, u92, u93, u94) -- Line: 422
    -- upvalues: Owned (copy), Shards (copy), newEntry (copy), cutFor (copy), u1 (copy), Recrack (copy), Batch (copy)
    local u95 = {
        place = false,
        emitCtx = nil,
        records = {},
        owner = u94
    };
    u87._reactorCutting[u88] = u95;
    local u96 = false;

    local function answer() -- Line: 426
        -- upvalues: u87 (copy), u88 (copy), u95 (copy), Owned (ref), u94 (copy), u91 (copy), u90 (copy), Shards (ref), newEntry (ref), u89 (copy), u93 (copy), cutFor (ref), u1 (ref), u92 (copy), Recrack (ref)
        if u87._reactorCutting[u88] ~= u95 then
            return;
        end;

        u87._reactorCutting[u88] = nil;

        if not ((u95.place or #u95.records > 0) and (u87.Connection and (u88.Parent and not u87._reactorPlays[u88]))) then
            Owned.gone(u87, u94, false);

            return;
        end;

        for _, v in ipairs(u91) do
            u90[v.part] = Shards.get(v.part, v.key) or nil;
        end;

        local v97 = newEntry(u87, u88, u89, u95.emitCtx, u90, u94);

        if not v97 then
            Owned.gone(u87, u94, false);

            return;
        end;

        u87._reactorPlays[u88] = v97;

        if u93 then
            cutFor(v97, u93);
        end;

        local v98 = u95.place or u94 ~= nil;

        if u95.place then
            v97.play:place();
        end;

        local v99 = {};

        for _, v in ipairs(u95.records) do
            local v100;

            if v.cut == nil then
                v100 = false;
            else
                v100 = v97.cutBy ~= v;
            end;

            local v101, v102 = v97.play:answer(v, v100);
            v99[v] = v102;
            v98 = v101 or v98;
        end;

        if not (v98 and u1.resume(u87, v97)) then
            u1.discard(u87, v97);

            return;
        end;

        if u92 then
            Recrack.opened(v97, u95.records, u92);
        end;

        for _, v in ipairs(u95.records) do
            u1.crackAgain(u87, v97, v, v99[v]);

            if v97.wounds then
                v97.wounds:strike(v);
            end;
        end;
    end;

    local function kept() -- Line: 477
        -- upvalues: u96 (ref), kept (copy), Batch (ref), u95 (copy), answer (copy)
        if u96 then
            Batch.give(u95.ticket, answer);

            return;
        end;

        u96 = true;
        task.defer(kept);
    end;

    Shards.prepare(u91, kept);
    u96 = true;

    return u95;
end;

function u1.owe(p103, p104) -- Line: 492
    -- upvalues: Batch (copy)
    if not table.find(p103.records, p104) then
        table.insert(p103.records, p104);
    end;

    if not p103.ticket then
        p103.ticket = Batch.take();
    end;
end;

function u1.forget(p105) -- Line: 502
    if p105 then
        table.clear(p105.records);
        p105.place = false;
        p105.emitCtx = nil;
    end;
end;

function u1.entryFor(p106, p107, p108, p109, p110) -- Line: 510
    -- upvalues: CutPlan (copy), u1 (copy), startCutting (copy), newEntry (copy), cutFor (copy), Recrack (copy)
    local v111 = p106._reactorPlays[p107];

    if v111 then
        return v111;
    end;

    local v112 = p106._reactorCutting[p107];

    if v112 then
        return nil, v112;
    end;

    local v113 = p110 and p110.settings or p106:GetData(p107);

    if not v113 then
        return nil;
    end;

    local v114 = nil;
    local v115 = CutPlan.strike(v113, p109);
    local v116;

    if v115 then
        v116 = v115.hit;
    else
        v116 = v115;
    end;

    if CutPlan.byEngine(v113) or v115 and v115.blade then
        local of = CutPlan.of;
        local v117;

        if v113.Break == "Shards" and (v113.ShardPattern == "Cracks" and u1.emitOrigin(p108) == nil) then
            v117 = not v113.NoGrounds;
        else
            v117 = false;
        end;

        local v118;
        v114, v118 = of(p107, v113, v117, v115);

        if #v118 > 0 then
            return nil, startCutting(p106, p107, v113, v114, v118, v116, v115 and p109, p110);
        end;
    end;

    local v119 = newEntry(p106, p107, v113, p108, v114, p110);
    p106._reactorPlays[p107] = v119;

    if v119 and v115 then
        cutFor(v119, p109);
    end;

    if v119 and v116 then
        Recrack.opened(v119, { p109 }, v116);
    end;

    return v119;
end;

function u1.prepare(p120, p121) -- Line: 548
    -- upvalues: Pieces (copy), Shards (copy), u1 (copy), CutPlan (copy), startCutting (copy)
    if p120._reactorPlays[p121] or p120._reactorCutting[p121] then
        return;
    end;

    for _, v in ipairs(Pieces.parts(p121)) do
        Shards.judge(v);
    end;

    local Data = p120:GetData(p121);

    if Data then
        local v122;

        if Data.Break == "Shards" and (Data.ShardPattern == "Cracks" and u1.emitOrigin(nil) == nil) then
            v122 = not Data.NoGrounds;
        else
            v122 = false;
        end;

        if v122 then
            local _, v123 = CutPlan.grounds(p121);

            for i in pairs(v123) do
                if not Pieces.isPlainBlock(i) then
                    Shards.warm(i);
                end;
            end;
        end;
    end;

    if not (Data and (CutPlan.byEngine(Data) and not CutPlan.waitsForHit(Data))) then
        return;
    end;

    local v124, v125 = CutPlan.of(p121, Data, false, nil);

    if #v125 > 0 then
        startCutting(p120, p121, Data, v124, v125);
    end;
end;

return u1;