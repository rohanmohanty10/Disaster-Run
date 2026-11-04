 
 

local Shards = require(script.Parent.Shards);
local Sites = require(script.Parent.Sites);
local Fissure = require(script.Parent.Fissure);
local Pieces = require(script.Parent.Pieces);
local Blade = require(script.Parent.Blade);
local Carve = require(script.Parent.Carve);
local Layers = require(script.Parent.Layers);
local u4 = {
    byEngine = function(p1) -- Line: 43, Name: byEngine
        return p1.Break == "Shards" and true or p1.Break == "Blocks";
    end,

    waitsForHit = function(p2) -- Line: 47, Name: waitsForHit
        local v3;

        if p2.Break == "Shards" then
            v3 = p2.ShardPattern == "Around hit" and true or p2.ShardPattern == "Cracks";
        else
            v3 = false;
        end;

        return v3;
    end
};

function u4.strike(p5, p6) -- Line: 51
    -- upvalues: u4 (copy), Blade (copy)
    if not p6 then
        return nil;
    end;

    local v7 = {};

    if u4.waitsForHit(p5) then
        v7.hit = p6.field.origin.Position;
    end;

    if p6.cut then
        v7.blade = Blade.of(p6.field, p6.cut);
        v7.mode = p6.cut.mode;
    elseif v7.hit and p5.ShardPattern == "Cracks" then
        v7.reach = p6.field.range;
        v7.field = p6.field;
    end;

    if v7.hit or v7.blade then
        return v7;
    end;

    return nil;
end;

local function splitOf(p8, p9, p10, p11) -- Line: 75
    -- upvalues: Sites (copy), Fissure (copy)
    local v12, v13 = Sites.face(p8.Size, p10);
    local v14 = Sites.alongFace(v12, 0, 0, v13);
    local v15 = Sites.seedAt(p9);
    local v16 = Fissure.of(p11, p8.CFrame, v14 * (p8.Size[v12] / 2), v14, Sites.sequence(v15));

    if v16 then
        v16.seed = v15;
        v16.face = {
            axis = v12,
            side = v13
        };
    end;

    return v16;
end;

local function carveJob(p17, p18, p19, p20, p21) -- Line: 89
    -- upvalues: Shards (copy), Blade (copy), u4 (copy), Sites (copy), Carve (copy)
    local blade = p20.blade;

    if not Shards.cuttable(p17) or p21 and p21[p17] then
        if Shards.refused(p17) and Blade.touches(blade, p17.ExtentsCFrame, p17.ExtentsSize) then
            Shards.explain(p17);
        end;

        return nil;
    end;

    local CFrame = p17.CFrame;

    if not Blade.touches(blade, p17.ExtentsCFrame, p17.ExtentsSize) then
        return nil;
    end;

    local v22 = (p20.mode ~= "Pieces" or not u4.byEngine(p18)) and 0 or Sites.count(p17.Size, p18.Pieces);
    local v23 = p18.Break == "Blocks";
    local v24 = Blade.inPart(blade, CFrame);
    local v25, v26 = Blade.ribbonFor(blade, CFrame, p17.Size, CFrame:Inverse());

    return {
        part = p17,
        key = Carve.key(p17, v24, blade.size, p20.mode, v22, p19, v23, blade.grain),
        bladeFrame = v24,
        bladeSize = blade.size,
        ribbon = v25,
        ribbonFrame = v26,
        slash = {
            origin = CFrame:PointToObjectSpace(blade.origin),
            normal = CFrame:VectorToObjectSpace(blade.normal),
            heading = CFrame:VectorToObjectSpace(blade.heading),
            kerf = blade.kerf
        },
        mode = p20.mode,
        count = v22,
        seed = p19,
        grid = v23
    };
end;

local function breakJob(p27, p28, p29, p30, p31) -- Line: 131
    -- upvalues: Sites (copy), Pieces (copy), Shards (copy), splitOf (copy)
    local v32 = p28.Break == "Blocks";
    local v33 = Sites.count(p27.Size, p28.Pieces);
    local v34 = (v32 and Pieces.isPlainBlock(p27) or p31 and p31[p27]) and 0 or v33;
    local v35;

    if p30 then
        v35 = p30.hit;
    else
        v35 = p30;
    end;

    local v36;

    if p30 then
        v36 = p30.reach;
    else
        v36 = p30;
    end;

    local v37;

    if v35 then
        v37 = p27.CFrame:PointToObjectSpace(v35);
        local v38 = Sites.hitIn(p27.Size, v37);

        if v36 then
            if (v37 - v38).Magnitude > v36 * Sites.RUN_ON then
                v34 = 0;
            end;
        else
            v37 = v38;
        end;
    else
        v37 = nil;
    end;

    if v34 < 2 or not Shards.cuttable(p27) then
        if v34 >= 2 then
            Shards.explain(p27);
        end;

        return nil;
    end;

    local v39;

    if v36 and p30.field then
        v39 = splitOf(p27, v35, v37, p30.field);
    else
        v39 = nil;
    end;

    local v40 = {
        part = p27,
        key = Shards.key(p27, v34, p29, v37, v36, v32, v39),
        count = v34,
        seed = p29,
        hit = v37,
        reach = v36,
        grid = v32,
        line = v39
    };

    if v39 then
        v39 = v39.face;
    end;

    v40.face = v39;

    return v40;
end;

function u4.grounds(p41) -- Line: 175
    -- upvalues: Pieces (copy), Shards (copy), Layers (copy)
    local v42 = {};
    local v43 = {};
    local v44 = {};

    for _, v in ipairs(Pieces.parts(p41)) do
        if Pieces.isPlainBlock(v) then
            v42[v] = true;
            table.insert(v43, v);
        elseif (v:IsA("MeshPart") or v:IsA("PartOperation")) and Shards.cuttable(v) then
            table.insert(v44, v);
        end;
    end;

    local v45, v46 = Layers.grounds(v43, v44);

    for i in pairs(v46) do
        v42[i] = true;
    end;

    return v45, v42;
end;

function u4.of(p47, p48, p49, p50) -- Line: 194
    -- upvalues: u4 (copy), Pieces (copy), carveJob (copy), breakJob (copy), Shards (copy)
    local v51 = {};
    local v52 = {};

    if p49 then
        local v53;
        v53, p49 = u4.grounds(p47);
    end;

    local v54 = u4.byEngine(p48);

    for i, v in ipairs(Pieces.parts(p47)) do
        local v55 = i * 7919 + 13;
        local v56;

        if p50 and p50.blade then
            v56 = carveJob(v, p48, v55, p50, p49);
        else
            v56 = nil;
        end;

        if not v56 and v54 then
            v56 = breakJob(v, p48, v55, p50, p49);
        end;

        if v56 then
            local v57 = Shards.get(v, v56.key);

            if v57 == nil then
                table.insert(v52, v56);
            elseif v57 then
                v51[v] = v57;
            end;
        end;
    end;

    return v51, v52;
end;

return u4;