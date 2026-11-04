 
 

local Trajectory = require(script.Parent.Parent.Rocks.Trajectory);
local Blade = require(script.Parent.Blade);
local Pieces = require(script.Parent.Pieces);
local Shards = require(script.Parent.Shards);
local Sites = require(script.Parent.Sites);
local Carve = require(script.Parent.Carve);
local CFrame_new_ret = CFrame.new(0, 0, 0);
local u1 = {};

local function poseOf(p2, p3) -- Line: 72
    if p2.state[p3] == 0 then
        return p2.crackFrame[p3] or p2.pieces[p3].rest;
    end;

    return p2.lastFrame[p3];
end;

local function carvable(p4, p5, p6) -- Line: 79
    -- upvalues: Shards (copy)
    local v7 = p4.pieces[p5];
    local v8 = p4.state[p5];

    if v8 ~= 0 and (v8 ~= 2 and v8 ~= 1) then
        return false;
    end;

    if v7.retired or (v7.bit or (v7.uncut or (p4.pendingPush[p5] ~= nil or v7.reach < 1))) then
        return false;
    end;

    if v7.strike or v7.fixed and not v7.slash then
        return false;
    end;

    if v7.slash and v7.slash.by == p6 then
        return false;
    end;

    return v7.shard ~= nil and true or (v7.blockSize ~= nil and true or Shards.cuttable(v7.part));
end;

local function growth(p9, p10, p11) -- Line: 100
    -- upvalues: Carve (copy)
    if p10 == "Pieces" then
        return math.max(p11, 1);
    end;

    if p10 ~= "Band" then
        return 1;
    end;

    local v12 = p9.halfExt * 2;
    local math_max_ret = math.max(v12.X, v12.Y, v12.Z);
    local v13 = math_max_ret * (v12.X + v12.Y + v12.Z - math_max_ret - math.min(v12.X, v12.Y, v12.Z)) / 9;
    local math_round_ret = math.round(v13);

    return math.clamp(math_round_ret, 3, Carve.MOST_BITS) + 1;
end;

local function jobFor(p14, p15, p16, p17, p18) -- Line: 113
    -- upvalues: CFrame_new_ret (copy), Sites (copy), Blade (copy)
    local v19 = p14.pieces[p15];
    local v20 = v19.box or CFrame_new_ret;
    local v21 = CFrame_new_ret;

    if v19.shard then
        v21 = v19.shard.ExtentsCFrame * v20:Inverse();
    elseif not v19.blockSize then
        v21 = v19.part.CFrame;
    end;

    local v22;

    if p14.state[p15] == 0 then
        v22 = p14.crackFrame[p15] or p14.pieces[p15].rest;
    else
        v22 = p14.lastFrame[p15];
    end;

    local v23 = v20 * v22:Inverse();
    local mode = p17.cut.mode;
    local v24 = Sites.seedAt(p16.origin) + p15;
    local v25, v26 = Blade.ribbonFor(p16, v19.part.CFrame, v19.part.Size, v23);
    local v27 = nil;
    local v28;

    if mode == "Pieces" and p18 >= 2 then
        local v29 = v19.halfExt * 2;
        local Size = v19.part.Size;
        local v30 = p18 * (v29.X * v29.Y * v29.Z / math.max(Size.X * Size.Y * Size.Z, 1e-6));
        local math_min_ret = math.min(v30, Sites.MAX);
        v28 = math.round(math_min_ret);

        if v28 >= 2 then
            local v31 = Sites.sequence(v24);
            v27 = table.create(v28);

            for i = 1, v28 do
                local v32 = (v31() - 0.5) * v29.X;
                local v33 = (v31() - 0.5) * v29.Y;
                local v34 = (v31() - 0.5) * v29.Z;
                v27[i] = v20:PointToWorldSpace(Vector3.new(v32, v33, v34) * 0.9);
                local _ = i;
            end;
        else
            v28 = 0;
        end;
    else
        v28 = 0;
    end;

    local v35 = {
        index = p15,
        part = v19.part,
        template = v19.shard,
        blockSize = v19.blockSize,
        baked = v19.baked,
        frame = v21,
        bladeFrame = v23 * p16.frame,
        bladeSize = p16.size,
        ribbon = v25,
        ribbonFrame = v26,
        slash = {
            origin = v23:PointToWorldSpace(p16.origin),
            normal = v23:VectorToWorldSpace(p16.normal),
            heading = v23:VectorToWorldSpace(p16.heading),
            kerf = p16.kerf
        },
        mode = mode,
        count = v28,
        points = v27,
        seed = v24
    };
    local v36;

    if v19.fixed == true then
        v36 = v19.cut ~= nil;
    else
        v36 = false;
    end;

    v35.stands = v36;

    return v35;
end;

function u1.plan(p37, p38, p39, p40) -- Line: 174
    -- upvalues: carvable (copy), Blade (copy), jobFor (copy), growth (copy)
    local v41 = {};
    local v42 = 0;

    for i, v in ipairs(p37.pieces) do
        if p37.state[i] ~= 3 then
            v42 = v42 + 1;
        end;

        if carvable(p37, i, p39) then
            local v43;

            if p37.state[i] == 0 then
                v43 = p37.crackFrame[i] or p37.pieces[i].rest;
            else
                v43 = p37.lastFrame[i];
            end;

            if Blade.touches(p38, v43, v.halfExt * 2) then
                table.insert(v41, {
                    index = i,
                    fixed = v.fixed == true,
                    away = (v43.Position - p38.origin).Magnitude
                });
            end;
        end;
    end;

    table.sort(v41, function(p44, p45) -- Line: 188
        if p44.fixed == p45.fixed then
            return p44.away < p45.away;
        end;

        return p44.fixed;
    end);
    local settings = p37.settings;
    local v46 = (settings.MostPieces or settings.MaxPieces) - v42;
    local v47 = settings.MaxPieces - v42;
    local v48 = {};

    for _, v in ipairs(v41) do
        if #v48 >= 64 then
            break;
        end;

        local v49 = jobFor(p37, v.index, p38, p39, p40);
        local v50 = growth(p37.pieces[v.index], v49.mode, v49.count);

        if math.min(v46, v47) < v50 then
            v49.mode = "Halves";
            v49.count = 0;
            v49.points = nil;
            v50 = 1;
        end;

        if v50 <= v46 or v.fixed then
            v46 = v46 - v50;
            table.insert(v48, v49);
        end;
    end;

    return {
        blade = p38,
        record = p39,
        jobs = v48
    };
end;

local function discard(p51) -- Line: 220
    for _, v in ipairs(p51 or {}) do
        v.template:Destroy();
    end;
end;

local function replace(p52, p53, p54, p55, p56, p57, p58) -- Line: 227
    -- upvalues: CFrame_new_ret (copy), Trajectory (copy), Pieces (copy)
    local index = p54.index;
    local v59 = p52.pieces[index];
    local v60 = v59.box or CFrame_new_ret;
    local v61 = p52.crackFrame[index];
    local v62 = nil;
    local v63 = Vector3.new(0, 1, 0);
    local v64 = nil;
    local v65 = nil;
    local v66 = nil;

    if p52.state[index] == 2 then
        v62 = p52.lastFrame[index];
        v63 = p52.path[index].restNormal or Vector3.new(0, 1, 0);
    elseif p52.state[index] == 1 then
        local v67 = p52.clock - p52.pathStart[index];
        v64 = Trajectory.evaluate(p52.path[index], v67, p52.gravity[index]);
        v65, v66 = Trajectory.velocity(p52.path[index], v67, p52.gravity[index]);
    end;

    local siblings = v59.siblings;

    if siblings then
        local table_find_ret = table.find(siblings, index);

        if table_find_ret then
            table.remove(siblings, table_find_ret);
        end;
    else
        siblings = {};
    end;

    local v68 = 0;

    for _, v in ipairs(p55) do
        if not v.bit then
            v68 = v68 + 1;
        end;
    end;

    local v69;

    if v59.fixed == true then
        v69 = v59.cut ~= nil and true or v68 <= 1;
    else
        v69 = false;
    end;

    local v70 = v59.rest * v60:Inverse();
    local Size = v59.part.Size;

    if v59.cut then
        Size = v59.cut.size;
    end;

    local blade = p53.blade;
    local v71 = {
        origin = blade.origin,
        normal = blade.normal,
        heading = blade.heading,
        kerf = blade.kerf,
        by = p53.record
    };
    local v72 = nil;

    for _, v in ipairs(p55) do
        local v73 = v59.rest * v60:ToObjectSpace(v.box);
        local v74 = Pieces.ofShard(v59.part, v73, v);
        v74.siblings = siblings;
        v74.slash = v71;
        v74.side = v.side;
        v74.bit = v.bit;
        v74.baked = v.baked;

        if v69 then
            v74.partStands = v59.partStands;
            v74.fixed = not v.bit or nil;
        end;

        v74.cut = v59.cut;

        if v59.cut and (v74.fixed and Pieces.reachesFace(v.box, v74.halfExt, v59.cut)) then
            v74.atFace = true;
        end;

        if v69 and v.bit then
            v74.under = Pieces.underTop(v70, Size, v74);
        end;

        table.insert(p52.pieces, v74);
        local v75 = #p52.pieces;
        table.insert(siblings, v75);
        table.insert(p56, v75);
        v72 = v72 or v75;
        p52.state[v75] = 0;
        local v76 = nil;

        if v62 then
            v76 = v62 * v59.rest:ToObjectSpace(v73);
            p52.state[v75] = 2;
            p52.path[v75] = Trajectory.lying(v76, v63);
            p52.pathStart[v75] = p52.clock;
            p52.pathBuilt[v75] = true;
            p52.lastFrame[v75] = v76;
            p52.landedAfter[v75] = 0;
            p52:_rolled(v75);
            p52.awake = p52.awake + 1;
        elseif v64 then
            v76 = v64 * v59.rest:ToObjectSpace(v73);
            p52:_launch(v75, v76, v65, v66);
            p52.awake = p52.awake + 1;
        elseif v61 and not (v69 and v.bit) then
            v76 = v61 * v59.rest:ToObjectSpace(v73);
            p52.crackFrame[v75] = v76;
        end;

        if v76 then
            table.insert(p57, v75);
            table.insert(p58, v76);
        end;
    end;

    v59.retired = true;
    p52.state[index] = 3;
    p52.cracked[index] = nil;
    p52.crackFrame[index] = nil;
    p52.display.drop(index);

    if v62 or v64 then
        p52.awake = p52.awake - 1;
    elseif not v61 then
        p52.hidden = p52.hidden + 1;
    end;

    if v72 then
        p52.display.wake(v72);
    end;
end;

function u1.apply(p77, p78, p79) -- Line: 341
    -- upvalues: carvable (copy), replace (copy), discard (copy)
    local v80 = {};
    local v81 = {};
    local v82 = {};

    for i, v in ipairs(p78.jobs) do
        local v83 = p79[i];

        if v83 and (#v83 >= 1 and carvable(p77, v.index, p78.record)) then
            replace(p77, p78, v, v83, v81, v82, v80);
        else
            discard(v83 or nil);
        end;
    end;

    if #v82 > 0 then
        p77.display.move(v82, v80, #v82);
    end;

    p77.support = nil;

    return v81;
end;

local function takeNext(u84, u85, u86) -- Line: 361
    -- upvalues: takeNext (copy), Blade (copy), u1 (copy), Shards (copy), discard (copy)
    local u87 = u84.carves[1];

    if not u87 then
        return;
    end;

    local play = u84.play;
    local record = u87.record;

    local function finish(p88) -- Line: 371
        -- upvalues: u84 (copy), play (copy), record (copy), u87 (copy), u86 (copy), takeNext (ref), u85 (copy)
        table.remove(u84.carves, 1);
        play.recracking[record] = nil;

        if play.slashed then
            play.slashed[record] = nil;
        end;

        play:kickAgain(record, u87.kicked, p88 or {});
        u86();
        takeNext(u84, u85, u86);
    end;

    local v89 = Blade.of(record.field, record.cut);

    if play.phase ~= "live" or not v89 then
        finish(nil);

        return;
    end;

    local u90 = u1.plan(play, v89, record, not u84.breaks and 0 or u84.pieceCount);

    if #u90.jobs == 0 then
        finish(nil);

        return;
    end;

    Shards.recut(u90.jobs, function(p91) -- Line: 396
        -- upvalues: u85 (copy), play (copy), discard (ref), finish (copy), u84 (copy), u1 (ref), u90 (copy)
        if u85() and play.phase == "live" then
            finish(u1.apply(play, u90, p91));

            return;
        end;

        for _, v in ipairs(p91) do
            discard(v or nil);
        end;

        if u85() then
            finish(nil);

            return;
        end;

        table.clear(u84.carves);
    end);
end;

function u1.request(p92, p93, p94, p95, p96) -- Line: 412
    -- upvalues: takeNext (copy)
    if not (p94 and p93.cut) then
        return;
    end;

    if not p92.carved then
        p92.carved = setmetatable({}, {
            __mode = "k"
        });
        p92.carves = {};
    end;

    if p92.carved[p93] then
        return;
    end;

    p92.carved[p93] = true;
    table.insert(p92.carves, {
        record = p93,
        kicked = p94
    });
    p92.play.recracking[p93] = "all";

    if #p92.carves == 1 then
        takeNext(p92, p95, p96);
    end;
end;

return u1;