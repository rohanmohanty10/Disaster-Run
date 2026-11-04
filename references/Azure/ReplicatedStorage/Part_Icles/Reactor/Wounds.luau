 

 

local Ground = require(script.Parent.Ground);
local Footprint = require(script.Parent.Footprint);
local Sites = require(script.Parent.Sites);
local Pieces = require(script.Parent.Pieces);
local Recrack = require(script.Parent.Recrack);
local Recarve = require(script.Parent.Recarve);
local WoundBudget = require(script.Parent.WoundBudget);
require(script.Parent.Recut);
local Blade = require(script.Parent.Blade);
local Index = require(script.Parent.Index);
local Fields = require(script.Parent.Parent.Force.Fields);
local Registry = require(script.Parent.Parent.Force.Registry);
local u1 = {};
u1.__index = u1;
u1.PATCH_REACH = Footprint.PATCH_REACH;

for i, v in pairs(WoundBudget.methods) do
    u1[i] = v;
end;

local livePieces = WoundBudget.livePieces;

function u1.new(p2) -- Line: 102
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.grounds = p2.grounds;
    v3.pieceCount = p2.pieceCount;
    v3.maxPieces = p2.maxPieces;
    v3.after = p2.after;
    v3.afterDelay = p2.afterDelay;
    v3.snap = p2.snap;
    v3.cut = p2.cut;
    v3.play = p2.play;
    v3.draw = p2.draw;
    v3.isCurrent = p2.isCurrent;
    v3.revive = p2.revive;
    v3.open = {};
    v3.groups = {};
    v3.struck = setmetatable({}, {
        __mode = "k"
    });

    return v3;
end;

local function settle(p4) -- Line: 125
    if p4.sheet and p4.sheet:isWhole() then
        p4.sheet = nil;
        p4.face = nil;
    end;
end;

function u1._leave(p5, p6) -- Line: 134
    p6.leaving = true;

    for _, v in ipairs(table.clone(p6.wounds)) do
        local play = v.play;

        if play.phase == "live" and (#play.flying > 0 or (#play.driven > 0 or #play.pendingWake > 0)) then
            p5:_close(v);
            local ground = v.ground;

            if ground.sheet and ground.sheet:isWhole() then
                ground.sheet = nil;
                ground.face = nil;
            end;
        end;
    end;

    p5:_send(p6, "Return", 0.25);
end;

function u1._draw(p7, p8) -- Line: 147
    local sheet = p8.sheet;
    local v9 = {};
    local v10 = false;

    for _, v in ipairs(p7.open) do
        if v.ground == p8 then
            if v.shown then
                v10 = true;
            else
                v9[v] = true;
            end;
        end;
    end;

    if sheet and v10 then
        p7.draw(p8, sheet:remainder(v9), p8.face);

        return;
    end;

    p7.draw(p8, nil, nil);
end;

function u1._close(p11, p12, p13) -- Line: 167
    if p12.closed then
        return;
    end;

    p12.closed = true;
    table.remove(p11.open, table.find(p11.open, p12));
    table.clear(p12.cracks);
    local group = p12.group;
    table.remove(group.wounds, table.find(group.wounds, p12));

    if #group.wounds == 0 then
        table.remove(p11.groups, table.find(p11.groups, group));
    end;

    if p12.display then
        p12.display.clear();
    end;

    local ground = p12.ground;

    if ground.sheet then
        ground.sheet:release(p12);
    end;

    if not p13 then
        p11:_draw(ground);
    end;
end;

local function touch(p14, p15) -- Line: 195
    p14.idle = 0;

    if p15.after and not p14.leaving then
        p14.after = p15.after;
        p14.delay = p15.afterDelay;
    end;
end;

function u1._closeGroup(p16, p17) -- Line: 204
    for _, v in ipairs(table.clone(p17.wounds)) do
        p16:_close(v);
    end;
end;

function u1._merge(p18, p19, p20) -- Line: 211
    if not p19 or p19 == p20 then
        return p20;
    end;

    if table.find(p18.groups, p20) >= table.find(p18.groups, p19) then
        local v21 = p20;
        p20 = p19;
        p19 = v21;
    end;

    for _, v in ipairs(p19.wounds) do
        v.group = p20;
        table.insert(p20.wounds, v);
    end;

    table.remove(p18.groups, table.find(p18.groups, p19));

    return p20;
end;

local function stillOpen(u22, u23) -- Line: 228
    return function() -- Line: 229
        -- upvalues: u23 (copy), u22 (copy)
        local v24 = not u23.closed and u22.isCurrent();

        return v24;
    end;
end;

function u1._again(u25, u26, p27, p28) -- Line: 236
    -- upvalues: Recarve (copy), Recrack (copy)
    local group = u26.group;
    group.idle = 0;

    if p27.after and not group.leaving then
        group.after = p27.after;
        group.delay = p27.afterDelay;
    end;

    u25:_room(u26);
    local v29;

    if p27.cut then
        v29 = Recarve;
    else
        v29 = Recrack;
    end;

    v29.request(u26, p27, p28, function() -- Line: 229
        -- upvalues: u26 (copy), u25 (copy)
        local v30 = not u26.closed and u25.isCurrent();

        return v30;
    end, u25.revive);
end;

function u1._crackAgain(p31, p32, p33) -- Line: 245
    -- upvalues: Footprint (copy), Sites (copy)
    local play = p32.play;

    if play then
        if play:watch(p33) then
            if p33.cut then
                p31:_sweep(Footprint.bladePieces(p33.cut.mode));
            else
                p31:_makeRoom((p33.pieces or p31.pieceCount) * Sites.LAYERS, p32.group);
            end;

            p31:_again(p32, p33, play.kicks[p33]);
        end;

        return;
    end;

    table.insert(p32.waiting, p33);
end;

function u1._show(p34, p35, p36, p37) -- Line: 266
    -- upvalues: Pieces (copy)
    if p35.closed or not p34.isCurrent() then
        return;
    end;

    local ground = p35.ground;
    local v38 = {};
    local v39 = {};

    for i, v in ipairs(p36) do
        local v40 = p37[i];

        if v40 and (#v40 >= 2 or v40.slash) then
            Pieces.ofSet(v38, ground.part, v.frame, v40, v39, {
                size = v.size,
                face = v.face
            }, ground.layers);
        else
            local v41 = v;

            for _, v2 in ipairs(v.layers or {
                {
                    offset = Vector3.new(0, 0, 0),
                    size = v.size
                }
            }) do
                local part = ground.part;

                if v2.index then
                    part = ground.layers[v2.index].part;
                end;

                local v42 = Pieces.ofBlock(part, v41.frame * CFrame.new(v2.offset), v2.size);
                v42.fixed = true;
                v42.siblings = v39;
                table.insert(v38, v42);
                table.insert(v39, #v38);
            end;
        end;
    end;

    for _, v in ipairs(v38) do
        if v.strike then
            v.strike.by = p35.record;
        end;

        if v.slash then
            v.slash.by = p35.record;
        end;
    end;

    local v43, v44 = p34.play(v38, p35.record);
    p35.play = v43;
    p35.display = v44;
    p35.shown = true;
    v43.settings.After = "Stay";
    local group = p35.group;
    local record = p35.record;
    group.idle = 0;

    if record.after and not group.leaving then
        group.after = record.after;
        group.delay = record.afterDelay;
    end;

    v44.wake(1);
    p34:_draw(ground);
    v43:strike(p35.record);

    for _, v in ipairs(p35.waiting) do
        local v45, v46 = v43:strike(v);

        if v45 then
            p34:_again(p35, v, v46);
        end;
    end;

    table.clear(p35.waiting);
    p34.revive();
end;

function u1._crack(u47, p48, p49, p50, p51) -- Line: 326
    -- upvalues: Sites (copy), Ground (copy), Footprint (copy), Blade (copy), Fields (copy)
    local size = p48.size;
    local v52 = p48.frame:PointToObjectSpace(p50);

    if p51 < (v52 - Sites.hitIn(size, v52)).Magnitude then
        return;
    end;

    local v53, v54 = Sites.face(size, v52);
    local face = p48.face;

    if p49.cut then
        if face then
            v53 = face.axis;
            v54 = face.side;
        else
            v54 = 1;
        end;
    end;

    if face and (face.axis ~= v53 or face.side ~= v54) then
        return;
    end;

    if not face then
        p48.face = {
            axis = v53,
            side = v54
        };
        local v55, v56 = Sites.faceAxes(v53);
        p48.uAxis = v55;
        p48.vAxis = v56;
        p48.sheet = Ground.new(size[p48.uAxis] / 2, size[p48.vAxis] / 2, u47.snap);
    end;

    local sheet = p48.sheet;
    local v57 = Sites.seedAt(p50);
    local v58;

    if p49.cut then
        u47:_sweep(2 * Footprint.bladePieces(p49.cut.mode));
        v58 = Footprint.ofBlade(p48, Blade.of(p49.field, p49.cut), p49.cut.mode, u47.maxPieces - u47:_held());

        if not v58 then
            if p48.sheet and p48.sheet:isWhole() then
                p48.sheet = nil;
                p48.face = nil;
            end;

            return;
        end;
    else
        v58 = Footprint.of(p48, p49.field, v52, p51, v57);
    end;

    local v59 = sheet:touching(v58.minU, v58.minV, v58.maxU, v58.maxV);
    local v60 = nil;

    for _, v in ipairs(v59) do
        if not v.closed then
            if v.group.sent then
                u47:_closeGroup(v.group);
            else
                v60 = u47:_merge(v60, v.group);
            end;
        end;
    end;

    for _, v in ipairs(v59) do
        if not v.closed then
            u47:_crackAgain(v, p49);
        end;
    end;

    if v58.probes and not Fields.reachesAny(p49.field, p48.frame, v58.probes, p49.strength < 0) then
        if p48.sheet and p48.sheet:isWhole() then
            p48.sheet = nil;
            p48.face = nil;
        end;

        return;
    end;

    local v61 = p49.pieces or u47.pieceCount;
    local u62 = {
        ground = p48,
        record = p49,
        cracks = {},
        waiting = {},
        pieceCount = u47.pieceCount
    };
    local v63 = sheet:claimArea(u62, v58.minU, v58.minV, v58.maxU, v58.maxV);
    local v64 = false;

    for _, v in ipairs(v63) do
        if Footprint.reaches(v58, v) then
            v64 = true;
        end;
    end;

    if not v64 then
        sheet:release(u62);

        if p48.sheet and p48.sheet:isWhole() then
            p48.sheet = nil;
            p48.face = nil;
        end;

        return;
    end;

    u62.centre = p48.frame:PointToWorldSpace(Sites.alongFace(v53, (v58.minU + v58.maxU) / 2, (v58.minV + v58.maxV) / 2, v54 * size[v53] / 2));
    u62.radius = math.sqrt((v58.maxU - v58.minU) ^ 2 + (v58.maxV - v58.minV) ^ 2) / 2 * 1.5;

    if not v60 then
        v60 = {
            idle = 0,
            sent = false,
            leaving = false,
            wounds = {},
            after = u47.after,
            delay = u47.afterDelay
        };
        table.insert(u47.groups, v60);
    end;

    u62.group = v60;
    table.insert(v60.wounds, u62);
    v60.idle = 0;
    table.insert(u47.open, u62);
    local u65 = {};

    for i, v in ipairs(v63) do
        u65[i] = Footprint.job(p48, v, v58, v52, v57 + i * 7919, #v63 == 1, v61);
    end;

    u62.expected = Footprint.pieces(v58, u65);
    u47:_makeRoom(0, nil);
    u47.cut(u65, function(p66) -- Line: 425
        -- upvalues: u47 (copy), u62 (copy), u65 (copy)
        u47:_show(u62, u65, p66);
    end);
end;

function u1.strike(p67, p68) -- Line: 430
    if p68.actsAs ~= "Impulse" then
        return;
    end;

    local Position = p68.field.origin.Position;
    local range = p68.field.range;
    local v69 = p67.struck[p68];

    if v69 and (v69 - Position).Magnitude < range * 0.5 then
        return;
    end;

    p67.struck[p68] = Position;

    for _, v in ipairs(p67.grounds) do
        p67:_crack(v, p68, Position, range);
    end;
end;

function u1.watch(p70, p71) -- Line: 447
    -- upvalues: Index (copy)
    local v72 = false;

    for _, v in ipairs(p70.open) do
        if v.play and (Index.reaches(p71.field, v.centre, v.radius) and v.play:watch(p71)) then
            v72 = true;
        end;
    end;

    return v72;
end;

function u1.step(p73, p74, p75, p76) -- Line: 457
    -- upvalues: Registry (copy)
    local v77 = "done";

    for _, v in ipairs(p73.groups) do
        v.busy = false;
    end;

    local v78 = 1;

    while v78 <= #p73.open do
        local v79 = p73.open[v78];
        local v80;

        if v79.play then
            local v81 = p76 and 0 or (p75 or Registry.slowest(v79.play.times));
            v80 = v79.play:step(p74 * math.max(v81, 0));
        else
            v80 = "active";
        end;

        if v80 == "done" then
            p73:_close(v79);
            local ground = v79.ground;

            if ground.sheet and ground.sheet:isWhole() then
                ground.sheet = nil;
                ground.face = nil;
            end;
        else
            v78 = v78 + 1;

            if not v79.play or v79.play.busy then
                v79.group.busy = true;
            end;

            if v80 == "active" then
                v77 = "active";
            elseif v77 == "done" then
                v77 = "dormant";
            end;
        end;
    end;

    for _, v in ipairs(p73.groups) do
        if v.busy then
            v.idle = 0;
        elseif not v.sent and v.after ~= "Stay" then
            v77 = "active";

            if not p76 then
                v.idle = v.idle + p74;

                if v.idle >= v.delay then
                    p73:_send(v, v.after, nil);
                end;
            end;
        end;
    end;

    return v77;
end;

function u1.restore(p82) -- Line: 507
    for _, v in ipairs(table.clone(p82.open)) do
        p82:_close(v, true);
    end;

    p82.groups = {};

    for _, v in ipairs(p82.grounds) do
        p82.draw(v, nil, nil);
        v.sheet = nil;
        v.face = nil;
    end;
end;

function u1.busy(p83) -- Line: 520
    for _, v in ipairs(p83.open) do
        if not v.play then
            return true;
        end;
    end;

    return false;
end;

function u1.count(p84) -- Line: 529
    -- upvalues: livePieces (copy)
    local v85 = 0;

    for _, v in ipairs(p84.open) do
        if v.play then
            v85 = v85 + livePieces(v);
        end;
    end;

    return #p84.open, v85;
end;

return u1;