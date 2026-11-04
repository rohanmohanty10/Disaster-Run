 

 

local AssetService = game:GetService("AssetService");
local Sides = require(script.Parent.Sides);
local View = require(script.Parent.View);
local u1 = {
    AXES = {
        World = "World",
        Pivot = "Pivot",
        Spine = "Spine"
    },
    FAR = 100000000
};
local u2 = {
    [Enum.MeshType.Brick] = true,
    [Enum.MeshType.Sphere] = true,
    [Enum.MeshType.Cylinder] = true,
    [Enum.MeshType.Wedge] = true
};

function u1.hide(p3) -- Line: 69
    p3.Material = Enum.Material.Glass;
    p3.LocalTransparencyModifier = 1;
    p3.CastShadow = false;

    for _, child in ipairs(p3:GetChildren()) do
        if child:IsA("Decal") then
            child.LocalTransparencyModifier = 1;
        end;
    end;
end;

function u1.partsOf(p4) -- Line: 80
    local v5 = {};

    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            table.insert(v5, descendant);
        end;
    end;

    return v5;
end;

local function dress(p6) -- Line: 90
    p6.Name = "Shape";
    p6.Archivable = false;
    p6.Material = Enum.Material.Glass;
    p6.Transparency = 0.99;
    p6.LocalTransparencyModifier = 0;
    p6.CastShadow = false;

    if p6:IsA("MeshPart") then
        p6.TextureID = "";
    end;
end;

local u7 = {};

local function meshPart(u8) -- Line: 106
    -- upvalues: u7 (copy), AssetService (copy)
    local u9 = u7[u8];

    if not u9 then
        u9 = {
            part = nil,
            loading = false,
            failedAt = nil
        };
        u7[u8] = u9;
    end;

    if u9.part then
        return u9.part;
    end;

    if u9.loading or u9.failedAt and os.clock() - u9.failedAt < 5 then
        return nil;
    end;

    u9.loading = true;
    task.spawn(function() -- Line: 119
        -- upvalues: AssetService (ref), u8 (copy), u9 (ref)
        local success, result = pcall(function() -- Line: 120
            -- upvalues: AssetService (ref), u8 (ref)
            return AssetService:CreateMeshPartAsync(Content.fromUri(u8));
        end);
        u9.loading = false;

        if not (success and result) then
            u9.failedAt = os.clock();

            return;
        end;

        result.Anchored = true;
        result.CanCollide = false;
        result.CanQuery = false;
        result.CanTouch = false;
        result.Name = "Shape";
        result.Archivable = false;
        result.Material = Enum.Material.Glass;
        result.Transparency = 0.99;
        result.LocalTransparencyModifier = 0;
        result.CastShadow = false;

        if result:IsA("MeshPart") then
            result.TextureID = "";
        end;

        u9.part = result;
    end);

    return nil;
end;

local u10 = Vector3.new(0, 0, 0);
local u11 = 1;

function u1.scene(p12, p13) -- Line: 145
    -- upvalues: u10 (ref), u11 (ref)
    u10 = p12;
    u11 = p13;
end;

local function seated(p14) -- Line: 151
    -- upvalues: u11 (ref), u10 (ref)
    if u11 == 1 then
        return p14;
    end;

    return p14 + (p14.Position - u10) * (u11 - 1);
end;

local function sceneMoved(p15) -- Line: 159
    -- upvalues: u11 (ref), u10 (ref)
    local v16;

    if p15.shrink == u11 then
        if u11 == 1 then
            v16 = false;
        else
            v16 = p15.eye ~= u10;
        end;
    else
        v16 = true;
    end;

    return v16;
end;

local function reshape(u17, u18) -- Line: 164
    pcall(function() -- Line: 165
        -- upvalues: u17 (copy), u18 (copy)
        u17:ApplyMesh(u18);
    end);
    u17.TextureID = "";
end;

local function followPlain(p19) -- Line: 171
    -- upvalues: u11 (ref), u10 (ref), u1 (copy)
    local source = p19.source;
    local v20;

    if p19.shrink == u11 then
        if u11 == 1 then
            v20 = false;
        else
            v20 = p19.eye ~= u10;
        end;
    else
        v20 = true;
    end;

    local CFrame2 = source.CFrame;

    if CFrame2 ~= p19.frame or v20 then
        p19.frame = CFrame2;
        local v21;

        if u11 == 1 then
            v21 = CFrame2;
        else
            v21 = CFrame2 + (CFrame2.Position - u10) * (u11 - 1);
        end;

        p19.twin.CFrame = v21;

        if p19.other then
            p19.other.CFrame = v21 * p19.mirror;
        end;
    end;

    local Size = source.Size;

    if Size ~= p19.size or p19.shrink ~= u11 then
        p19.size = Size;
        p19.box = Size;
        p19.twin.Size = Size * u11;

        if p19.other then
            p19.other.Size = Size * u11;
        end;
    end;

    p19.shrink = u11;
    p19.eye = u10;

    if p19.watch then
        local MeshId = source.MeshId;
        local MeshSize = source.MeshSize;

        if MeshId ~= p19.meshId or MeshSize ~= p19.meshSize then
            p19.meshId = MeshId;
            p19.meshSize = MeshSize;
            local twin = p19.twin;
            pcall(function() -- Line: 165
                -- upvalues: twin (copy), source (copy)
                twin:ApplyMesh(source);
            end);
            twin.TextureID = "";

            if p19.other then
                local other = p19.other;
                pcall(function() -- Line: 165
                    -- upvalues: other (copy), source (copy)
                    other:ApplyMesh(source);
                end);
                other.TextureID = "";
            end;
        end;
    end;

    p19.live = math.abs(CFrame2.X) < u1.FAR;
end;

local function followScaled(p22) -- Line: 211
    -- upvalues: followPlain (copy)
    followPlain(p22);
    local Scale = p22.mesh.Scale;

    if Scale ~= p22.scale then
        p22.scale = Scale;
        p22.twinMesh.Scale = Scale;
    end;

    p22.box = p22.size * Scale;
end;

local function followFile(p23) -- Line: 223
    -- upvalues: meshPart (copy), u11 (ref), u10 (ref), u1 (copy)
    local mesh = p23.mesh;
    local MeshId = mesh.MeshId;

    if MeshId ~= p23.meshId then
        p23.meshId = MeshId;

        if p23.twin then
            p23.twin:Destroy();
            p23.twin = nil;
        end;
    end;

    local twin = p23.twin;

    if not twin then
        local v24;

        if MeshId == "" then
            v24 = nil;
        else
            v24 = meshPart(MeshId) or nil;
        end;

        if not v24 then
            p23.live = false;

            return;
        end;

        twin = Instance.fromExisting(v24);
        p23.twin = twin;
        p23.meshSize = v24.MeshSize;
        p23.frame = nil;
        p23.size = nil;
        twin.Parent = p23.viewport;
    end;

    local CFrame2 = p23.source.CFrame;

    if p23.offset then
        CFrame2 = CFrame2 * p23.offset;
    end;

    local v25;

    if CFrame2 == p23.frame then
        local v26;

        if p23.shrink == u11 then
            if u11 == 1 then
                v26 = false;
            else
                v26 = p23.eye ~= u10;
            end;
        else
            v26 = true;
        end;

        if v26 then
            p23.frame = CFrame2;

            if u11 == 1 then
                v25 = CFrame2;
            else
                v25 = CFrame2 + (CFrame2.Position - u10) * (u11 - 1);
            end;

            twin.CFrame = v25;
        end;
    else
        p23.frame = CFrame2;

        if u11 == 1 then
            v25 = CFrame2;
        else
            v25 = CFrame2 + (CFrame2.Position - u10) * (u11 - 1);
        end;

        twin.CFrame = v25;
    end;

    local v27 = p23.meshSize * mesh.Scale;

    if v27 ~= p23.size or p23.shrink ~= u11 then
        p23.size = v27;
        p23.box = v27;
        twin.Size = v27 * u11;
    end;

    p23.shrink = u11;
    p23.eye = u10;
    p23.live = math.abs(CFrame2.X) < u1.FAR;
end;

local function newUnit(p28, p29, p30) -- Line: 267
    -- upvalues: followPlain (copy), followFile (copy), u1 (copy), u2 (copy), followScaled (copy), Sides (copy)
    local v31 = {
        twin = nil,
        other = nil,
        mirror = nil,
        viewport = nil,
        frame = nil,
        size = nil,
        box = nil,
        live = false,
        watch = false,
        meshId = nil,
        mesh = nil,
        twinMesh = nil,
        scale = nil,
        meshSize = nil,
        offset = nil,
        source = p28,
        follow = followPlain
    };
    local v32;

    if p28:IsA("MeshPart") then
        v32 = nil;
    else
        v32 = p28:FindFirstChildOfClass("SpecialMesh") or nil;
    end;

    if v32 and v32.MeshType == Enum.MeshType.FileMesh then
        v31.mesh = v32;
        v31.follow = followFile;
        local Offset = v32.Offset;

        if Offset.Magnitude > 0 then
            v31.offset = CFrame.new(Offset);
        end;

        return v31;
    end;

    local Instance_fromExisting_ret = Instance.fromExisting(p28);
    Instance_fromExisting_ret.Name = "Shape";
    Instance_fromExisting_ret.Archivable = false;
    Instance_fromExisting_ret.Material = Enum.Material.Glass;
    Instance_fromExisting_ret.Transparency = 0.99;
    Instance_fromExisting_ret.LocalTransparencyModifier = 0;
    Instance_fromExisting_ret.CastShadow = false;

    if Instance_fromExisting_ret:IsA("MeshPart") then
        Instance_fromExisting_ret.TextureID = "";
    end;

    v31.twin = Instance_fromExisting_ret;
    v31.frame = p28.CFrame;
    v31.size = p28.Size;
    v31.box = v31.size;
    v31.live = math.abs(v31.frame.X) < u1.FAR;

    if not (v32 and u2[v32.MeshType]) then
        if p28:IsA("MeshPart") then
            v31.watch = p30;
            v31.meshId = p28.MeshId;
            v31.meshSize = p28.MeshSize;
            local v33 = Sides.wanted(p28) and Sides.axis(p29, p28.Size);

            if v33 then
                local v34, v35 = Sides.twin(Instance_fromExisting_ret, v33);
                v31.other = v34;
                v31.mirror = v35;
            end;
        end;

        return v31;
    end;

    local Instance_fromExisting_ret2 = Instance.fromExisting(v32);
    Instance_fromExisting_ret2.TextureId = "";
    Instance_fromExisting_ret2.Parent = Instance_fromExisting_ret;
    v31.mesh = v32;
    v31.twinMesh = Instance_fromExisting_ret2;
    v31.scale = v32.Scale;
    v31.box = v31.size * v31.scale;
    v31.follow = followScaled;

    return v31;
end;

function u1.single(p36, p37) -- Line: 326
    -- upvalues: newUnit (copy)
    local v38 = newUnit(p36, p37, true);

    return {
        frame = nil,
        size = nil,
        source = p36,
        unit = v38,
        shape = v38.twin
    };
end;

function u1.group(p39, p40, p41, p42, p43) -- Line: 331
    -- upvalues: newUnit (copy), u1 (copy)
    local table_create_ret = table.create(#p40);

    for i, v in ipairs(p40) do
        table_create_ret[i] = newUnit(v, p41, false);
    end;

    return {
        frame = nil,
        size = nil,
        holder = p39,
        units = table_create_ret,
        axes = p42 or u1.AXES.World,
        spine = p43 or #p40,
        box = {}
    };
end;

local function settleUnit(p44, p45) -- Line: 347
    p44.viewport = p45;

    if p44.twin then
        p44.twin.Parent = p45;
    end;

    if p44.other then
        p44.other.Parent = p45;
    end;
end;

function u1.settle(p46, p47) -- Line: 357
    if not p46.unit then
        for _, v in ipairs(p46.units) do
            v.viewport = p47;

            if v.twin then
                v.twin.Parent = p47;
            end;

            if v.other then
                v.other.Parent = p47;
            end;
        end;

        return;
    end;

    local unit = p46.unit;
    unit.viewport = p47;

    if unit.twin then
        unit.twin.Parent = p47;
    end;

    if unit.other then
        unit.other.Parent = p47;
    end;
end;

local function followGroup(p48) -- Line: 367
    -- upvalues: u1 (copy), View (copy)
    local units = p48.units;
    local spine = p48.spine;
    local v49 = 0;
    local v50 = nil;
    local v51 = nil;

    for i = 1, #units do
        local v52 = units[i];
        v52.follow(v52);
        local v53;

        if v52.live then
            v49 = v49 + 1;

            if i <= spine then
                v51 = v52;
                v53 = i;
                v50 = v50 or v52;
            else
                v53 = i;
            end;
        else
            v53 = i;
        end;
    end;

    if v49 == 0 then
        p48.frame = nil;
        p48.size = nil;

        return nil;
    end;

    local box = p48.box;

    if p48.axes == u1.AXES.Pivot then
        View.groupStart(box, p48.holder:GetPivot());
    elseif p48.axes == u1.AXES.Spine and (v50 and v51 ~= v50) then
        View.groupAlong(box, v50.frame.Position, v51.frame.Position);
    else
        View.groupWorld(box);
    end;

    for i = 1, #units do
        local v54 = units[i];
        local v55;

        if v54.live then
            View.groupAdd(box, v54.frame, v54.box);
            v55 = i;
        else
            v55 = i;
        end;
    end;

    local v56, v57 = View.groupBox(box);
    p48.frame = v56;
    p48.size = v57;

    return p48.frame, p48.size;
end;

function u1.follow(p58) -- Line: 408
    -- upvalues: followGroup (copy)
    if p58.units then
        return followGroup(p58);
    end;

    local unit = p58.unit;
    unit.follow(unit);
    p58.shape = unit.twin;

    if unit.live then
        p58.frame = unit.frame;
        p58.size = unit.box;

        return unit.frame, unit.box;
    end;

    p58.frame = nil;
    p58.size = nil;

    return nil;
end;

function u1.alive(p59) -- Line: 425
    return (p59.holder or p59.source).Parent ~= nil;
end;

local function destroyUnit(p60) -- Line: 430
    if p60.twin then
        p60.twin:Destroy();
        p60.twin = nil;
    end;

    if p60.other then
        p60.other:Destroy();
        p60.other = nil;
    end;

    p60.live = false;
end;

function u1.destroy(p61) -- Line: 442
    if not p61.unit then
        for _, v in ipairs(p61.units) do
            if v.twin then
                v.twin:Destroy();
                v.twin = nil;
            end;

            if v.other then
                v.other:Destroy();
                v.other = nil;
            end;

            v.live = false;
        end;

        return;
    end;

    local unit = p61.unit;

    if unit.twin then
        unit.twin:Destroy();
        unit.twin = nil;
    end;

    if unit.other then
        unit.other:Destroy();
        unit.other = nil;
    end;

    unit.live = false;
    p61.shape = nil;
end;

function u1.dismiss(p62) -- Line: 453
    local v63 = p62.holder or p62.source;

    if v63.Parent then
        v63:Destroy();
    end;
end;

return u1;