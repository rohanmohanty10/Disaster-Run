 

 

local GeometryService = game:GetService("GeometryService");
local Refusals = require(script.Parent.Refusals);
local Sites = require(script.Parent.Sites);
local Dice = require(script.Parent.Dice);
local Carve = require(script.Parent.Carve);
local LayerCuts = require(script.Parent.LayerCuts);
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function bakesColours(p3) -- Line: 86
    local v4 = p3:IsA("PartOperation") and not p3.UsePartColor;

    return v4;
end;

v1.refused = Refusals.refused;
v1.explain = Refusals.explain;

function v1.cuttable(p5) -- Line: 93
    -- upvalues: Refusals (copy)
    if p5:IsA("MeshPart") then
        return not Refusals.refused(p5);
    end;

    if p5:IsA("PartOperation") then
        return true;
    end;

    if p5:IsA("Part") or (p5:IsA("WedgePart") or p5:IsA("CornerWedgePart")) then
        return p5:FindFirstChildWhichIsA("DataModelMesh") == nil;
    end;

    return false;
end;

function v1.key(p6, p7, p8, p9, p10, p11, p12) -- Line: 107
    local Size = p6.Size;
    local ClassName = p6.ClassName;

    if p6:IsA("MeshPart") then
        ClassName = ClassName .. p6.MeshId;
    elseif p6:IsA("Part") then
        ClassName = ClassName .. p6.Shape.Name;
    else
        local v13 = p6:IsA("PartOperation") and not p6.UsePartColor;

        if v13 then
            ClassName = ClassName .. ":baked";
        end;
    end;

    local v14 = not p9 and "even" or string.format("%d,%d,%d", math.round(p9.X / 0.5), math.round(p9.Y / 0.5), (math.round(p9.Z / 0.5)));

    if p10 then
        v14 = string.format("cracks:%s:%d", v14, (math.round(p10 / 0.5)));
    end;

    if p12 then
        local points = p12.path.points;
        local v15 = points[1];
        local v16 = points[#points];
        v14 = string.format("%s:split:%d,%d,%d:%d,%d,%d:%.2f:%d", v14, math.round(v15.X / 0.5), math.round(v15.Y / 0.5), math.round(v15.Z / 0.5), math.round(v16.X / 0.5), math.round(v16.Y / 0.5), math.round(v16.Z / 0.5), p12.reach, p12.seed or 0);
    end;

    return string.format("%s|%.3f,%.3f,%.3f|%d|%d|%s", ClassName, Size.X, Size.Y, Size.Z, p7, p8, p11 and "blocks" or v14);
end;

function v1.get(p17, p18) -- Line: 139
    -- upvalues: u2 (copy)
    local v19 = u2[p17];

    if v19 and v19.key == p18 then
        return v19.shards;
    end;

    return nil;
end;

local function fragment(u20, u21) -- Line: 149
    -- upvalues: GeometryService (copy)
    local success, result = pcall(function() -- Line: 150
        -- upvalues: GeometryService (ref), u20 (copy), u21 (copy)
        return GeometryService:FragmentAsync(u20, u21);
    end);

    if success and type(result) == "table" then
        return result;
    end;

    local v22;

    if success then
        v22 = nil;
    else
        v22 = tostring(result);
    end;

    local success2, result2 = pcall(function() -- Line: 160
        -- upvalues: GeometryService (ref), u20 (copy)
        return GeometryService:UnionAsync(u20, {});
    end);
    local u23;

    if success2 and type(result2) == "table" then
        u23 = result2[1] or nil;
    else
        u23 = nil;
    end;

    if not u23 then
        return nil, v22;
    end;

    local success3, result3 = pcall(function() -- Line: 167
        -- upvalues: GeometryService (ref), u23 (copy), u21 (copy)
        return GeometryService:FragmentAsync(u23, u21);
    end);
    u23:Destroy();

    if success3 and type(result3) == "table" then
        return result3;
    end;

    return nil, v22;
end;

local function shardOf(p24, p25, p26, p27) -- Line: 178
    local ExtentsCFrame = p24.ExtentsCFrame;

    return {
        template = p24,
        box = p25:ToObjectSpace(ExtentsCFrame),
        size = p24.ExtentsSize,
        standOffset = ExtentsCFrame:ToObjectSpace(p24.CFrame),
        fixed = p26,
        siteIndex = p27
    };
end;

local function solidCopy(p28) -- Line: 191
    local Instance_fromExisting_ret = Instance.fromExisting(p28);
    Instance_fromExisting_ret.Archivable = true;
    Instance_fromExisting_ret.Anchored = true;

    return Instance_fromExisting_ret;
end;

local function clip(p29, p30, p31) -- Line: 203
    -- upvalues: GeometryService (copy)
    local Instance_fromExisting_ret = Instance.fromExisting(p30);
    Instance_fromExisting_ret.Archivable = true;
    Instance_fromExisting_ret.Anchored = true;

    if p31 then
        Instance_fromExisting_ret.CFrame = p31 * p30.CFrame;
    end;

    Instance_fromExisting_ret.Color = Color3.new(1, 1, 1);

    if Instance_fromExisting_ret:IsA("PartOperation") then
        Instance_fromExisting_ret.UsePartColor = true;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Size = p29.Size;
    Part.CFrame = p29.CFrame;
    Part.Color = Color3.new(1, 1, 1);
    local success, result = pcall(function() -- Line: 219
        -- upvalues: GeometryService (ref), Part (copy), Instance_fromExisting_ret (copy)
        return GeometryService:IntersectAsync(Part, { Instance_fromExisting_ret });
    end);
    Part:Destroy();
    Instance_fromExisting_ret:Destroy();

    if not (success and (type(result) == "table" and result[1])) then
        return nil;
    end;

    for i = 2, #result do
        result[i]:Destroy();
        local _ = i;
    end;

    return result[1];
end;

LayerCuts.use(fragment, shardOf, clip);
local u32 = setmetatable({}, {
    __mode = "k"
});

function v1.warm(u33) -- Line: 239
    -- upvalues: u32 (copy), clip (copy)
    if u32[u33] then
        return;
    end;

    u32[u33] = true;
    task.spawn(function() -- Line: 244
        -- upvalues: u33 (copy), clip (ref)
        local Part = Instance.new("Part");
        Part.Size = Vector3.new(1, 1, 1);
        Part.CFrame = u33.CFrame;
        local v34 = clip(Part, u33, nil);
        Part:Destroy();

        if v34 then
            v34:Destroy();
        end;
    end);
end;

function v1.without(p35, p36) -- Line: 259
    -- upvalues: GeometryService (copy)
    local Instance_fromExisting_ret = Instance.fromExisting(p35);
    Instance_fromExisting_ret.Archivable = true;
    Instance_fromExisting_ret.Anchored = true;
    local table_create_ret = table.create(#p36);

    for i, v in ipairs(p36) do
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Size = v.size;
        Part.CFrame = v.frame;
        table_create_ret[i] = Part;
    end;

    local success, result = pcall(function() -- Line: 269
        -- upvalues: GeometryService (ref), Instance_fromExisting_ret (copy), table_create_ret (copy)
        return GeometryService:SubtractAsync(Instance_fromExisting_ret, table_create_ret, {
            SplitApart = false
        });
    end);
    Instance_fromExisting_ret:Destroy();

    for _, v in ipairs(table_create_ret) do
        v:Destroy();
    end;

    if not (success and (type(result) == "table" and result[1])) then
        return nil;
    end;

    for i = 2, #result do
        result[i]:Destroy();
        local _ = i;
    end;

    return result[1];
end;

local function archivable(p37) -- Line: 290
    if p37.Archivable then
        return p37, false;
    end;

    local Instance_fromExisting_ret = Instance.fromExisting(p37);
    Instance_fromExisting_ret.Archivable = true;

    return Instance_fromExisting_ret, true;
end;

local function cut(p38) -- Line: 300
    -- upvalues: LayerCuts (copy), Carve (copy), fragment (copy), shardOf (copy), Refusals (copy), Sites (copy), Dice (copy)
    local part = p38.part;

    if not (part.Parent or p38.loose) then
        return false;
    end;

    local layers = p38.layers;
    local v39;

    if layers == nil then
        v39 = false;
    else
        v39 = #layers > 1;
    end;

    if p38.bladeFrame then
        if v39 then
            return LayerCuts.carve(p38, part.CFrame, Carve.cut);
        end;

        local v40, v41 = Carve.cut(p38, fragment, shardOf);

        if v41 and (Refusals.notSolid(v41) and not p38.loose) then
            Refusals.refuse(part, v41);
        end;

        if v40 and layers then
            LayerCuts.stamp(v40, layers[1]);
        end;

        return v40;
    end;

    local CFrame = part.CFrame;
    local v42, v43;

    if part.Archivable then
        v42 = part;
        v43 = false;
    else
        v42 = Instance.fromExisting(part);
        v42.Archivable = true;
        v43 = true;
    end;

    local v44 = Sites.sequence(p38.seed);
    local v45 = nil;
    local v46 = nil;
    local v47;

    if p38.grid then
        v47 = Dice.centres(part.Size, p38.count);
    elseif p38.reach then
        v47, v45, v46 = Sites.cracks(part.Size, p38.count, p38.hit, p38.reach, v44, {
            face = p38.face,
            fill = p38.loose == true,
            line = p38.line
        });
    elseif p38.hit then
        v47 = Sites.aroundHit(part.Size, p38.count, p38.hit, v44);
    else
        v47 = Sites.even(part.Size, p38.count, v44);
    end;

    local table_create_ret = table.create(#v47);

    for i, v in ipairs(v47) do
        table_create_ret[i] = CFrame:PointToWorldSpace(v);
    end;

    if v39 then
        local v48 = LayerCuts.cut(p38, v42, CFrame, table_create_ret, v46);

        if v43 then
            v42:Destroy();
        end;

        if v48 then
            v48.sites = v47;
            v48.strike = v45;
        end;

        return v48;
    end;

    local v49 = nil;
    local v50 = nil;
    local v51;

    if v46 then
        local v52 = fragment(v42, { CFrame:PointToWorldSpace(v46.inCrust), CFrame:PointToWorldSpace(v46.inBase) });

        if v52 and #v52 == 2 then
            v51 = v42;

            for _, v in ipairs(v52) do
                if v.Index == 1 then
                    v49 = v.Instance;
                else
                    v50 = v.Instance;
                end;
            end;
        else
            v51 = v42;
        end;

        if v49 and v50 then
            v51 = v49;
        else
            v50 = nil;
        end;
    else
        v51 = v42;
    end;

    local v53, v54 = fragment(v51, table_create_ret);

    if v49 then
        v49:Destroy();
    end;

    if v43 then
        v42:Destroy();
    end;

    if not v53 or #v53 < 2 then
        if v50 then
            v50:Destroy();
        end;

        if v54 and not p38.loose then
            Refusals.refuse(part, v54);
        end;

        return false;
    end;

    Refusals.cut(part);
    local table_create_ret2 = table.create(#v53 + 1);

    for _, v in ipairs(v53) do
        local v55 = shardOf(v.Instance, CFrame, false, v.Index);
        table.insert(table_create_ret2, v55);
    end;

    if v50 then
        local v56 = shardOf(v50, CFrame, true, nil);
        table.insert(table_create_ret2, v56);
    end;

    local v57 = part:IsA("PartOperation") and not part.UsePartColor;

    if v57 then
        for _, v in ipairs(table_create_ret2) do
            v.baked = true;
        end;
    end;

    if layers then
        LayerCuts.stamp(table_create_ret2, layers[1]);
    end;

    table_create_ret2.sites = v47;
    table_create_ret2.strike = v45;

    return table_create_ret2;
end;

local function cutAgain(p58) -- Line: 416
    -- upvalues: Carve (copy), fragment (copy), shardOf (copy), Refusals (copy), LayerCuts (copy)
    if p58.bladeFrame then
        local v59, v60 = Carve.cut(p58, fragment, shardOf);

        if v60 and (Refusals.notSolid(v60) and (p58.part and not (p58.template or p58.blockSize))) then
            Refusals.refuse(p58.part, v60);
        end;

        return v59;
    end;

    if p58.layered then
        return LayerCuts.cutAgain(p58);
    end;

    local template = p58.template;
    local CFrame = template.CFrame;
    local table_create_ret = table.create(#p58.points);

    for i, v in ipairs(p58.points) do
        table_create_ret[i] = CFrame:PointToWorldSpace(v);
    end;

    local v61 = fragment(template, table_create_ret);

    if not v61 or #v61 < 2 then
        return false;
    end;

    local table_create_ret2 = table.create(#v61);

    for _, v in ipairs(v61) do
        local v62 = shardOf(v.Instance, CFrame, false, v.Index);
        table.insert(table_create_ret2, v62);
    end;

    return table_create_ret2;
end;

function v1.judge(p63, p64) -- Line: 445
    -- upvalues: Refusals (copy), fragment (copy)
    Refusals.judge(p63, fragment, p64);
end;

function v1.prepare(u65, u66) -- Line: 449
    -- upvalues: cut (copy), u2 (copy)
    local u67 = #u65;

    if u67 == 0 then
        u66();

        return;
    end;

    local u68 = 0;
    local u69 = 0;

    local function work() -- Line: 457
        -- upvalues: u68 (ref), u67 (copy), u65 (copy), cut (ref), u2 (ref), u69 (ref), u66 (ref)
        while u68 < u67 do
            u68 = u68 + 1;
            local v70 = u65[u68];
            local success, result = pcall(cut, v70);
            u2[v70.part] = {
                key = v70.key,
                shards = success and result and result or false
            };
            u69 = u69 + 1;
        end;

        if u69 == u67 and u66 then
            local v71 = u66;
            u66 = nil;
            v71();
        end;
    end;

    for i = 1, math.min(4, u67) do
        task.spawn(work);
        local _ = i;
    end;
end;

function v1.recut(u72, u73) -- Line: 476
    -- upvalues: cutAgain (copy)
    local u74 = #u72;
    local table_create_ret = table.create(u74, false);

    if u74 == 0 then
        u73(table_create_ret);

        return;
    end;

    local u75 = 0;
    local u76 = 0;

    local function v79() -- Line: 485
        -- upvalues: u75 (ref), u74 (copy), cutAgain (ref), u72 (copy), table_create_ret (copy), u76 (ref), u73 (ref)
        while u75 < u74 do
            u75 = u75 + 1;
            local v77 = u75;
            local success, result = pcall(cutAgain, u72[v77]);
            table_create_ret[v77] = success and result and result or false;
            u76 = u76 + 1;
        end;

        if u76 == u74 and u73 then
            local v78 = u73;
            u73 = nil;
            v78(table_create_ret);
        end;
    end;

    for i = 1, math.min(4, u74) do
        task.spawn(v79);
        local _ = i;
    end;
end;

return v1;