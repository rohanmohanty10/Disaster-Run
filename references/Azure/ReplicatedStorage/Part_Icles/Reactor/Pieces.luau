 

 

local Dice = require(script.Parent.Dice);
local Sites = require(script.Parent.Sites);
local Fissure = require(script.Parent.Fissure);
local u1 = {};

local function record(p2, p3, p4) -- Line: 70
    return {
        part = p2,
        rest = p3,
        halfExt = p4 / 2,
        size = (p4.X * p4.Y * p4.Z) ^ 0.3333333333333333,
        reach = math.max(p4.X, p4.Y, p4.Z)
    };
end;

local function whole(p5) -- Line: 86
    local ExtentsCFrame = p5.ExtentsCFrame;

    if (ExtentsCFrame.Position - p5.CFrame.Position).Magnitude >= 0.01 then
        local ExtentsSize = p5.ExtentsSize;

        return {
            part = p5,
            rest = ExtentsCFrame,
            halfExt = ExtentsSize / 2,
            size = (ExtentsSize.X * ExtentsSize.Y * ExtentsSize.Z) ^ 0.3333333333333333,
            reach = math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z),
            standOffset = ExtentsCFrame:ToObjectSpace(p5.CFrame),
            box = p5.CFrame:ToObjectSpace(ExtentsCFrame)
        };
    end;

    local Size = p5.Size;

    return {
        part = p5,
        rest = p5.CFrame,
        halfExt = Size / 2,
        size = (Size.X * Size.Y * Size.Z) ^ 0.3333333333333333,
        reach = math.max(Size.X, Size.Y, Size.Z)
    };
end;

function u1.isPlainBlock(p6) -- Line: 99
    if p6.ClassName ~= "Part" or p6.Shape ~= Enum.PartType.Block then
        return false;
    end;

    for _, child in ipairs(p6:GetChildren()) do
        if child:IsA("DataModelMesh") then
            return false;
        end;
    end;

    return true;
end;

function u1.ofBlock(p7, p8, p9) -- Line: 113
    return {
        part = p7,
        rest = p8,
        halfExt = p9 / 2,
        size = (p9.X * p9.Y * p9.Z) ^ 0.3333333333333333,
        reach = math.max(p9.X, p9.Y, p9.Z),
        blockSize = p9
    };
end;

function u1.ofShard(p10, p11, p12, p13) -- Line: 121
    local size = p12.size;
    local v14 = {
        part = p10,
        rest = p11,
        halfExt = size / 2,
        size = (size.X * size.Y * size.Z) ^ 0.3333333333333333,
        reach = math.max(size.X, size.Y, size.Z),
        shard = p12.template,
        standOffset = p12.standOffset,
        box = p12.box,
        siteIndex = p12.siteIndex
    };

    if p13 and p12.layer then
        v14.looks = p13;
        v14.part = p13[p12.layer].part;
        v14.plain = not p13[p12.layer].aligned;
        v14.skin = p13[p12.layer].skin;

        if p12.parts then
            local table_create_ret = table.create(#p12.parts);

            for i, v in ipairs(p12.parts) do
                local v15 = p13[v.layer];
                table_create_ret[i] = {
                    shard = v.template,
                    layer = v.layer,
                    part = v15.part,
                    plain = not v15.aligned,
                    skin = v15.skin,
                    standOffset = v.standOffset,
                    offset = v.offset,
                    halfExt = v.size / 2
                };
            end;

            v14.layered = table_create_ret;
        end;
    end;

    return v14;
end;

local function halfHeight(p16, p17) -- Line: 157
    return math.abs(p16.XVector.Y) * p17.X + math.abs(p16.YVector.Y) * p17.Y + math.abs(p16.ZVector.Y) * p17.Z;
end;

function u1.touchesSide(p18, p19, p20) -- Line: 161
    -- upvalues: Sites (copy)
    local v21 = p18:VectorToWorldSpace((Vector3.new(p19.X, 0, 0)));
    local v22 = p18:VectorToWorldSpace((Vector3.new(0, p19.Y, 0)));
    local v23 = p18:VectorToWorldSpace((Vector3.new(0, 0, p19.Z)));
    local v24, v25 = Sites.faceAxes(p20.face.axis);

    for _, v in ipairs({ v24, v25 }) do
        local v26 = math.abs(v21[v]) + math.abs(v22[v]) + math.abs(v23[v]);

        if math.abs(p18.Position[v]) + v26 > p20.size[v] / 2 - 0.05 then
            return true;
        end;
    end;

    return false;
end;

function u1.reachesFace(p27, p28, p29) -- Line: 175
    local axis = p29.face.axis;
    local v30 = p27:VectorToWorldSpace((Vector3.new(p28.X, 0, 0)));
    local v31 = p27:VectorToWorldSpace((Vector3.new(0, p28.Y, 0)));
    local v32 = p27:VectorToWorldSpace((Vector3.new(0, 0, p28.Z)));
    local v33 = math.abs(v30[axis]) + math.abs(v31[axis]) + math.abs(v32[axis]);

    return p27.Position[axis] * p29.face.side + v33 > p29.size[axis] / 2 - 0.05;
end;

function u1.underTop(p34, p35, p36) -- Line: 186
    local v37 = p35 / 2;
    local v38 = p34.Position.Y + (math.abs(p34.XVector.Y) * v37.X + math.abs(p34.YVector.Y) * v37.Y + math.abs(p34.ZVector.Y) * v37.Z) - p36.rest.Position.Y;
    local rest = p36.rest;
    local halfExt = p36.halfExt;
    local v39 = v38 - (math.abs(rest.XVector.Y) * halfExt.X + math.abs(rest.YVector.Y) * halfExt.Y + math.abs(rest.ZVector.Y) * halfExt.Z);

    return math.max(v39, 0);
end;

function u1.ofSet(p40, p41, p42, p43, p44, p45, p46) -- Line: 191
    -- upvalues: Fissure (copy), u1 (copy)
    local v47;

    if p43.strike then
        v47 = {
            origin = p42:PointToWorldSpace(p43.strike.origin),
            normal = p42:VectorToWorldSpace(p43.strike.normal),
            reach = p43.strike.reach,
            crust = p43.strike.crust
        };

        if p43.strike.path then
            v47.path = Fissure.moved(p43.strike.path, p42, false);
        end;
    else
        v47 = nil;
    end;

    local v48 = p43.slash and {
        origin = p42:PointToWorldSpace(p43.slash.origin),
        normal = p42:VectorToWorldSpace(p43.slash.normal),
        heading = p42:VectorToWorldSpace(p43.slash.heading),
        kerf = p43.slash.kerf
    } or nil;
    local v49 = nil;

    if v48 then
        for _, v in ipairs(p43) do
            if v.fixed then
                v49 = true;
            end;
        end;
    end;

    local v50 = p44 or table.create(#p43);

    for _, v in ipairs(p43) do
        local v51 = u1.ofShard(p41, p42 * v.box, v, p46);
        v51.siblings = v50;
        v51.cut = p45;
        v51.slash = v48;
        v51.partStands = v49;
        v51.baked = v.baked;
        v51.side = v.side;
        v51.bit = v.bit;

        if v.bit then
            local Size = p41.Size;

            if p45 then
                Size = p45.size;
            end;

            v51.under = u1.underTop(p42, Size, v51);
        end;

        if v.fixed then
            v51.fixed = true;

            if v48 and (p45 and u1.reachesFace(v.box, v51.halfExt, p45)) then
                v51.atFace = true;
            end;
        else
            v51.strike = v47;
            v51.sites = p43.sites;

            if p45 and u1.touchesSide(v.box, v51.halfExt, p45) then
                v51.atEdge = true;
            end;

            if p45 and u1.reachesFace(v.box, v51.halfExt, p45) then
                v51.atFace = true;
            end;
        end;

        table.insert(p40, v51);
        table.insert(v50, #p40);
    end;

    return v50;
end;

local function addShards(p52, p53, p54) -- Line: 262
    -- upvalues: u1 (copy)
    local v55;

    if p54 then
        v55 = p54(p53) or nil;
    else
        v55 = nil;
    end;

    if not (v55 and (#v55 ~= 0 and (#v55 >= 2 or v55.slash))) then
        return false;
    end;

    u1.ofSet(p52, p53, p53.CFrame, v55);

    return true;
end;

local function add(p56, p57, p58, p59, p60) -- Line: 271
    -- upvalues: u1 (copy), whole (copy), Dice (copy), Sites (copy)
    local v61;

    if p58 == "Blocks" then
        v61 = u1.isPlainBlock(p57);
    else
        v61 = false;
    end;

    local v62;

    if p60 then
        v62 = p60(p57) or nil;
    else
        v62 = nil;
    end;

    local v63;

    if v62 and (#v62 ~= 0 and (#v62 >= 2 or v62.slash)) then
        u1.ofSet(p56, p57, p57.CFrame, v62);
        v63 = true;
    else
        v63 = false;
    end;

    if v63 then
        return;
    end;

    if not v61 then
        local v64 = whole(p57);
        table.insert(p56, v64);

        return;
    end;

    local v65 = Dice.cut(p57.Size, Sites.count(p57.Size, p59), Sites.sequence(#p56 * 7919 + 13));

    if #v65 ~= 1 then
        local table_create_ret = table.create(#v65);

        for _, v in ipairs(v65) do
            local v66 = p57.CFrame * CFrame.new(v.offset.X, v.offset.Y, v.offset.Z);
            local size = v.size;
            local v67 = {
                part = p57,
                rest = v66,
                halfExt = size / 2,
                size = (size.X * size.Y * size.Z) ^ 0.3333333333333333,
                reach = math.max(size.X, size.Y, size.Z),
                blockSize = v.size,
                siblings = table_create_ret
            };
            table.insert(p56, v67);
            table.insert(table_create_ret, #p56);
        end;

        return;
    end;

    local Size = p57.Size;
    local v68 = {
        part = p57,
        rest = p57.CFrame,
        halfExt = Size / 2,
        size = (Size.X * Size.Y * Size.Z) ^ 0.3333333333333333,
        reach = math.max(Size.X, Size.Y, Size.Z)
    };
    table.insert(p56, v68);
end;

local function visit(p69, p70) -- Line: 297
    -- upvalues: visit (copy)
    for _, child in ipairs(p69:GetChildren()) do
        if not child:GetAttribute("Transformed") then
            if child:IsA("BasePart") and not child:IsA("Terrain") then
                table.insert(p70, child);
            end;

            visit(child, p70);
        end;
    end;
end;

function u1.parts(p71) -- Line: 308
    -- upvalues: visit (copy)
    local v72 = {};

    if p71:IsA("BasePart") then
        table.insert(v72, p71);
    end;

    visit(p71, v72);

    return v72;
end;

function u1.carry(p73, p74, p75, p76) -- Line: 320
    -- upvalues: Fissure (copy)
    local v77 = {};
    local v78 = {};

    for _, v in ipairs(p73) do
        if v.strike then
            v77[v.strike] = true;
        end;

        if v.slash then
            v78[v.slash] = true;
        end;
    end;

    if p76 then
        for _, v in ipairs(p73) do
            v.rest = p75 * p74:ToObjectSpace(v.rest);
        end;

        for i in pairs(v77) do
            i.origin = p75:PointToWorldSpace(p74:PointToObjectSpace(i.origin));
            i.normal = p75:VectorToWorldSpace(p74:VectorToObjectSpace(i.normal));

            if i.path then
                i.path = Fissure.moved(Fissure.moved(i.path, p74, true), p75, false);
            end;
        end;

        for i in pairs(v78) do
            i.origin = p75:PointToWorldSpace(p74:PointToObjectSpace(i.origin));
            i.normal = p75:VectorToWorldSpace(p74:VectorToObjectSpace(i.normal));
            i.heading = p75:VectorToWorldSpace(p74:VectorToObjectSpace(i.heading));
        end;

        return;
    end;

    local v79 = p75.Position - p74.Position;

    for _, v in ipairs(p73) do
        v.rest = v.rest + v79;
    end;

    for i in pairs(v77) do
        i.origin = i.origin + v79;

        if i.path then
            i.path = Fissure.moved(i.path, CFrame.new(v79), false);
        end;
    end;

    for i in pairs(v78) do
        i.origin = i.origin + v79;
    end;
end;

function u1.collect(p80, p81, p82, p83, p84) -- Line: 368
    -- upvalues: u1 (copy), add (copy)
    local v85 = {};

    for _, v in ipairs(u1.parts(p80)) do
        if not (p84 and p84(v)) then
            add(v85, v, p81, p82 or 50, p83);
        end;
    end;

    return v85;
end;

return u1;