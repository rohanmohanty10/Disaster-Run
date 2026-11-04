 
 

local Sites = require(script.Parent.Sites);
local Pieces = require(script.Parent.Pieces);
local Fissure = require(script.Parent.Fissure);
local Crack = require(script.Parent.Crack);
local u1 = {
    PLATE_ROOM = 1.5
};

local function partFrame(p2) -- Line: 72
    return p2.rest * p2.box:Inverse();
end;

local function stands(p3, p4) -- Line: 76
    local v5 = p3.pieces[p4];
    local v6;

    if p3.state[p4] == 0 and p3.pendingPush[p4] == nil then
        v6 = not v5.retired and not v5.fixed;
    else
        v6 = false;
    end;

    return v6;
end;

local function nearest(p7, p8) -- Line: 82
    local v9 = (1 / 0);
    local v10 = nil;

    for i, v in ipairs(p7) do
        local Magnitude = (v - p8).Magnitude;

        if Magnitude < v9 then
            v10 = i;
            v9 = Magnitude;
        end;
    end;

    return v10;
end;

local function ownerOf(p11, p12, p13) -- Line: 97
    local pieceOf = p12.pieceOf;
    local v14 = (1 / 0);
    local v15 = nil;

    for i, v in ipairs(p12.sites) do
        local Magnitude = (v - p13).Magnitude;

        if Magnitude < v14 then
            v15 = i;
            v14 = Magnitude;
        end;
    end;

    local v16 = pieceOf[v15];

    while v16 do
        local v17 = p11.pieces[v16];

        if not v17.retired then
            return v16;
        end;

        local children = v17.children;
        local v18 = (1 / 0);
        local v19 = nil;

        for i, v in ipairs(v17.cutPoints) do
            local Magnitude = (v - p13).Magnitude;

            if Magnitude < v18 then
                v19 = i;
                v18 = Magnitude;
            end;
        end;

        v16 = children[v19];
    end;

    return nil;
end;

local function grounds(p20) -- Line: 112
    local v21 = {};
    local v22 = {};
    local v23 = 0;

    for i, v in ipairs(p20.pieces) do
        if not v.retired then
            v23 = v23 + 1;
        end;

        if v.box and (v.siteIndex and not v.fixed) then
            local v24 = v.cut or v.part;
            local v25 = v21[v24];

            if not v25 then
                local Size = v.part.Size;

                if v.cut then
                    Size = v.cut.size;
                end;

                v25 = {
                    size = Size
                };
                v25.face = v.cut and v.cut.face;
                v25.frame = v.rest * v.box:Inverse();
                v25.pieceOf = {};
                v25.strikes = {};
                v25.pieces = {};
                v21[v24] = v25;
                table.insert(v22, v25);
            end;

            table.insert(v25.pieces, i);

            if v.sites then
                v25.sites = v.sites;
                v25.pieceOf[v.siteIndex] = i;
            end;

            if v.strike and not table.find(v25.strikes, v.strike) then
                table.insert(v25.strikes, v.strike);
            end;
        end;
    end;

    return v22, v23;
end;

local function comesNear(p26, p27, p28, p29) -- Line: 147
    -- upvalues: Sites (copy)
    if not p29 then
        return (p27 - Sites.hitIn(p26, p27)).Magnitude <= p28 * Sites.RUN_ON;
    end;

    for _, v in ipairs(p29.path.points) do
        if (v - Sites.hitIn(p26, v)).Magnitude <= p29.reach * Sites.RUN_ON then
            return true;
        end;
    end;

    return false;
end;

local function planGround(p30, p31, p32, p33, p34) -- Line: 162
    -- upvalues: Sites (copy), Fissure (copy), comesNear (copy), ownerOf (copy), Crack (copy)
    if not p31.sites or #p31.strikes == 0 then
        return;
    end;

    local frame = p31.frame;
    local size = p31.size;
    local hit = p32.hit;
    local reach = p32.reach;
    local v35 = frame:PointToObjectSpace(hit);
    local v36 = Sites.count(size, p32.count);
    local v37 = p31.strikes[1];
    local v38 = frame:VectorToObjectSpace(v37.normal);
    local v39;

    if p32.field then
        v39 = Fissure.of(p32.field, frame, frame:PointToObjectSpace(v37.origin), v38, Sites.sequence(Sites.seedAt(hit)));
    else
        v39 = nil;
    end;

    if v36 < 2 or not comesNear(size, v35, reach, v39) then
        return;
    end;

    if v39 then
        v39.seed = p32.seed;
    end;

    local v40 = Sites.sequence(p32.seed + p33 * 7919);
    local v41, v42 = Sites.cracks(size, v36, v35, reach, v40, {
        face = p31.face,
        crust = v37.crust,
        line = v39
    });

    if v42.normal:Dot(v38) < 0.99 then
        return;
    end;

    local v43 = {
        origin = frame:PointToWorldSpace(v42.origin),
        normal = v37.normal,
        reach = v42.reach,
        crust = v37.crust
    };

    if v42.path then
        v43.path = Fissure.moved(v42.path, frame, false);
    end;

    table.insert(p34.strikes, v43);
    local v44 = {};

    for _, v in ipairs(v41) do
        local v45 = ownerOf(p30, p31, v);

        if v45 then
            local v46 = p30.pieces[v45];
            local v47;

            if p30.state[v45] == 0 and p30.pendingPush[v45] == nil then
                v47 = not v46.retired and not v46.fixed;
            else
                v47 = false;
            end;

            if v47 then
                local v48 = v44[v45];

                if not v48 then
                    v48 = {};
                    v44[v45] = v48;
                end;

                table.insert(v48, v);
            end;
        end;
    end;

    for _, v in ipairs(p31.pieces) do
        local v49 = p30.pieces[v];
        local v50;

        if p30.state[v] == 0 and p30.pendingPush[v] == nil then
            v50 = not v49.retired and not v49.fixed;
        else
            v50 = false;
        end;

        if v50 then
            local v51 = p30.pieces[v];
            local v52 = Crack.shareAt(v43, v51.rest.Position) <= 1;
            local v53 = v44[v];

            if v53 and (#v53 >= 2 and v51.reach >= 1.5) then
                local jobs = p34.jobs;
                local v54 = {
                    index = v,
                    template = v51.shard,
                    layered = v51.layered,
                    points = v53,
                    strike = v43,
                    within = v52,
                    always = Crack.outsizes(v51, v43)
                };
                table.insert(jobs, v54);
            elseif v52 then
                table.insert(p34.joins, {
                    index = v,
                    strike = v43
                });
            end;
        end;
    end;
end;

local function fit(p55, p56, p57) -- Line: 227
    local v58 = {};

    for _, v in ipairs(p55.jobs) do
        local points = v.points;
        local v59;

        if v.always then
            v59 = p57;
        else
            v59 = p56;
        end;

        local v60 = v;

        for i = #points, math.max(v59 + 2, 1), -1 do
            points[i] = nil;
            local _ = i;
        end;

        if #points >= 2 then
            p56 = p56 - (#points - 1);
            p57 = p57 - (#points - 1);
            table.insert(v58, v60);
        elseif v60.within then
            table.insert(p55.joins, {
                index = v60.index,
                strike = v60.strike
            });
        end;
    end;

    p55.jobs = v58;
end;

function u1.plan(p61, p62, p63, p64, p65, p66) -- Line: 249
    -- upvalues: grounds (copy), planGround (copy), u1 (copy), fit (copy)
    local v67, v68 = grounds(p61);
    local v69 = {
        hit = p62,
        reach = p63,
        count = p64,
        seed = p65,
        field = p66
    };
    local v70 = {
        jobs = {},
        joins = {},
        strikes = {}
    };

    for i, v in ipairs(v67) do
        planGround(p61, v, v69, i, v70);
    end;

    if #v70.jobs == 0 and #v70.joins == 0 then
        return nil;
    end;

    local settings = p61.settings;
    fit(v70, settings.MaxPieces - v68, (settings.MostPieces or settings.MaxPieces * u1.PLATE_ROOM) - v68);

    return v70;
end;

local function replace(p71, p72, p73, p74, p75, p76) -- Line: 269
    -- upvalues: Pieces (copy)
    local v77 = p71.pieces[p72.index];
    local siblings = v77.siblings;
    local table_find_ret = table.find(siblings, p72.index);

    if table_find_ret then
        table.remove(siblings, table_find_ret);
    end;

    local v78 = p71.crackFrame[p72.index];
    local v79 = {};
    local v80 = nil;

    for _, v in ipairs(p73) do
        local v81 = v77.rest * v77.box:ToObjectSpace(v.box);
        local v82 = Pieces.ofShard(v77.part, v81, v, v77.looks);
        v82.siblings = siblings;
        v82.strike = p72.strike;
        v82.baked = v77.baked;
        v82.cut = v77.cut;

        if v77.cut and Pieces.touchesSide(v.box, v82.halfExt, v77.cut) then
            v82.atEdge = true;
        end;

        if v77.cut and Pieces.reachesFace(v.box, v82.halfExt, v77.cut) then
            v82.atFace = true;
        end;

        table.insert(p71.pieces, v82);
        local v83 = #p71.pieces;
        p71.state[v83] = 0;
        table.insert(siblings, v83);
        table.insert(p74, v83);

        if v.siteIndex then
            v79[v.siteIndex] = v83;
        end;

        v80 = v80 or v83;

        if v78 then
            local v84 = v78 * v77.rest:ToObjectSpace(v81);
            p71.crackFrame[v83] = v84;
            table.insert(p75, v83);
            table.insert(p76, v84);
        end;
    end;

    v77.retired = true;
    v77.children = v79;
    v77.cutPoints = p72.points;
    p71.state[p72.index] = 3;
    p71.cracked[p72.index] = nil;
    p71.crackFrame[p72.index] = nil;
    p71.display.drop(p72.index);

    if not v78 then
        p71.hidden = p71.hidden + 1;
    end;

    p71.display.wake(v80);
end;

function u1.apply(u85, p86, p87) -- Line: 324
    -- upvalues: replace (copy)
    local u88 = {};

    local function join(p89, p90) -- Line: 328
        -- upvalues: u85 (copy), u88 (copy)
        local v91 = u85;
        local v92 = v91.pieces[p89];
        local v93;

        if v91.state[p89] == 0 and v91.pendingPush[p89] == nil then
            v93 = not v92.retired and not v92.fixed;
        else
            v93 = false;
        end;

        if not v93 then
            return;
        end;

        local v94 = u85.pieces[p89];
        v94.strike = p90;
        v94.joined = true;
        u85.cracked[p89] = nil;
        table.insert(u88, p89);
    end;

    local v95 = {};
    local v96 = {};

    for i, v in ipairs(p86.jobs) do
        local v97 = p87[i];
        local v98, v99, v100, v101, v102;

        if v97 and #v97 >= 2 then
            local index = v.index;
            local v103 = u85.pieces[index];
            local v104;

            if u85.state[index] == 0 and u85.pendingPush[index] == nil then
                v104 = not v103.retired and not v103.fixed;
            else
                v104 = false;
            end;

            if v104 then
                replace(u85, v, v97, u88, v95, v96);
            elseif v.within then
                v98 = v.index;
                v99 = v.strike;
                v100 = u85.pieces[v98];

                if u85.state[v98] == 0 and u85.pendingPush[v98] == nil then
                    v101 = not v100.retired and not v100.fixed;
                else
                    v101 = false;
                end;

                if v101 then
                    v102 = u85.pieces[v98];
                    v102.strike = v99;
                    v102.joined = true;
                    u85.cracked[v98] = nil;
                    table.insert(u88, v98);
                end;
            end;
        elseif v.within then
            v98 = v.index;
            v99 = v.strike;
            v100 = u85.pieces[v98];

            if u85.state[v98] == 0 and u85.pendingPush[v98] == nil then
                v101 = not v100.retired and not v100.fixed;
            else
                v101 = false;
            end;

            if v101 then
                v102 = u85.pieces[v98];
                v102.strike = v99;
                v102.joined = true;
                u85.cracked[v98] = nil;
                table.insert(u88, v98);
            end;
        end;
    end;

    for _, v in ipairs(p86.joins) do
        local index = v.index;
        local strike = v.strike;
        local v105 = u85.pieces[index];
        local v106;

        if u85.state[index] == 0 and u85.pendingPush[index] == nil then
            v106 = not v105.retired and not v105.fixed;
        else
            v106 = false;
        end;

        if v106 then
            local v107 = u85.pieces[index];
            v107.strike = strike;
            v107.joined = true;
            u85.cracked[index] = nil;
            table.insert(u88, index);
        end;
    end;

    if #v95 > 0 then
        u85.display.move(v95, v96, #v95);
    end;

    u85.support = nil;

    return u88;
end;

return u1;