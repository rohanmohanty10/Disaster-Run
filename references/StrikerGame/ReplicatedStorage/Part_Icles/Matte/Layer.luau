 

 

local Looks = require(script.Parent.Looks);
local View = require(script.Parent.View);
local v1 = {};
local CFrame_new_ret = CFrame.new(0, 10000000, 0);

local function newSheet() -- Line: 48
    return {
        fields = nil,
        shown = nil,
        away = false,
        side = 0,
        color = nil,
        plane = nil,
        columns = 0,
        rows = 0,
        wears = {},
        stored = {},
        places = {}
    };
end;

function v1.new(p2, p3) -- Line: 64
    -- upvalues: newSheet (copy)
    local Part = Instance.new("Part");
    Part.Name = "MatteLayer";
    Part.Archivable = false;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Locked = true;
    Part.Parent = p3;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Name = "PartIclesMatte";
    SurfaceGui.Archivable = false;
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.Face = Enum.NormalId.Back;
    SurfaceGui.LightInfluence = 0;
    SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
    SurfaceGui.Adornee = Part;
    SurfaceGui.Enabled = false;
    SurfaceGui.Parent = p2;
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.Ambient = Color3.new(1, 1, 1);
    ViewportFrame.LightColor = Color3.new(0, 0, 0);
    ViewportFrame.Parent = SurfaceGui;
    local Camera = Instance.new("Camera");
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;

    return {
        mask = nil,
        canvasX = 0,
        canvasY = 0,
        shown = false,
        brightness = 1,
        transparency = 0,
        quad = Part,
        gui = SurfaceGui,
        viewport = ViewportFrame,
        eye = Camera,
        sheet = {},
        picture = newSheet()
    };
end;

local function build(p4, p5, p6) -- Line: 120
    local v7 = {};

    for i = 1, p5 do
        local v8 = p6(p4);

        if not v8 then
            break;
        end;

        table.insert(v7, v8);
        local _ = i;
    end;

    if #v7 >= p5 then
        return v7;
    end;

    for _, v in ipairs(v7) do
        v:Destroy();
    end;

    return nil;
end;

local function undress(p9, p10) -- Line: 139
    -- upvalues: Looks (copy)
    for i, v in pairs(p9.wears) do
        if v then
            Looks.give(p10, p9.stored[i], v);
        end;

        p9.wears[i] = nil;
        p9.stored[i] = nil;
    end;

    p9.shown = nil;
end;

local function dress(p11, p12, p13) -- Line: 151
    -- upvalues: Looks (copy)
    local v14 = p12.look(p13);

    if not v14 and p12.needsLook then
        return false;
    end;

    for i, v in ipairs(p11.fields) do
        local v15 = p11.wears[i];

        if not v15 or p11.stored[i] ~= v14 then
            if v15 then
                Looks.give(p12.owner, p11.stored[i], v15);
            end;

            local v16;

            if v14 then
                v16 = Looks.take(p12.owner, v14) or false;
            else
                v16 = false;
            end;

            if v16 then
                if p12.backing then
                    v.Color = p12.backing;
                end;

                v16.Parent = v;
            end;

            p11.wears[i] = v16;
            p11.stored[i] = v14 or nil;
        end;
    end;

    p11.shown = p13;
    p11.color = nil;

    return true;
end;

local function lay(p17, p18, p19, p20, p21, p22, p23, p24, p25, p26) -- Line: 180
    -- upvalues: View (copy), build (copy), undress (copy), CFrame_new_ret (copy), dress (copy)
    local v27, v28, v29, v30 = View.fit(p20, p21, p22, p23, p24);

    if not (p17.fields and (v27 == p17.plane and (v29 == p17.columns and v30 == p17.rows))) then
        local v31 = build(v27, v29 * v30, p25.plane);

        if v31 then
            if p17.fields then
                undress(p17, p25.owner);

                for _, v in ipairs(p17.fields) do
                    v:Destroy();
                end;
            end;

            for _, v in ipairs(v31) do
                v.CFrame = CFrame_new_ret;
                v.Parent = p18;
            end;

            p17.fields = v31;
            p17.plane = v27;
            p17.columns = v29;
            p17.rows = v30;
            p17.side = 0;
        end;
    end;

    local fields = p17.fields;

    if not fields then
        return;
    end;

    local v32;

    if v27 == p17.plane and v29 == p17.columns then
        v32 = v30 == p17.rows;
    else
        v32 = false;
    end;

    if v32 and p17.shown ~= p26 then
        dress(p17, p25, p26);
    end;

    if p17.shown == nil then
        return;
    end;

    local places = p17.places;

    if v32 then
        if v28 ~= p17.side then
            p17.side = v28;
            local v33 = #fields > 1 and 1.0005 or 1;
            local Vector3_new_ret = Vector3.new(v28 * v33, v28 * v33, View.THICKNESS);

            for _, v in ipairs(fields) do
                v.Size = Vector3_new_ret;
            end;
        end;

        for i = 1, v30 do
            local v34 = i;

            for i2 = 1, v29 do
                places[(v34 - 1) * v29 + i2] = View.tile(p22, v28, i2, v29, v34, v30);
                local _ = i2;
            end;
        end;
    end;

    for i, v in ipairs(fields) do
        local v35 = places[i];

        if v35 then
            v.CFrame = p19 * v35;
        end;
    end;

    p17.away = false;
end;

function v1.place(p36, p37, p38, p39, p40, p41, p42, p43, p44, p45) -- Line: 243
    -- upvalues: lay (copy), View (copy), newSheet (copy), CFrame_new_ret (copy)
    local v46 = p45 or 1;
    local ViewportSize = p37.ViewportSize;
    local v47;

    if p38 == nil or ViewportSize.Y < 1 then
        v47 = false;
    else
        v47 = ViewportSize.X >= 1;
    end;

    if v47 ~= p36.shown then
        p36.shown = v47;
        p36.gui.Enabled = v47;
    end;

    if not v47 then
        return;
    end;

    local v48 = ViewportSize.X / ViewportSize.Y;
    local FieldOfView = p37.FieldOfView;
    local CFrame2 = p37.CFrame;
    p36.eye.CFrame = p38.eyeFrame;
    p36.eye.FieldOfView = p38.eyeFov;
    p36.quad.Size = p38.quadSize;
    p36.quad.CFrame = p38.quadFrame;

    if p38.canvasX ~= p36.canvasX or p38.canvasY ~= p36.canvasY then
        p36.canvasX = p38.canvasX;
        p36.canvasY = p38.canvasY;
        p36.gui.CanvasSize = Vector2.new(p38.canvasX, p38.canvasY);
    end;

    lay(p36.picture, p36.viewport, CFrame2, FieldOfView, v48, View.behind(p39) * v46, p40, p41, p42, p43);
    local mask = p36.mask;

    if not p44 then
        if mask and (mask.fields and not mask.away) then
            mask.away = true;

            for _, v in ipairs(mask.fields) do
                v.CFrame = CFrame_new_ret;
            end;
        end;

        return;
    end;

    if not mask then
        mask = newSheet();
        p36.mask = mask;
    end;

    lay(mask, p36.viewport, CFrame2, FieldOfView, v48, p44.distance * v46, p44.scale, p41, p44.from, p44.frame);
end;

function v1.look(p49, p50, p51, p52, p53) -- Line: 284
    if p50 ~= p49.brightness then
        p49.brightness = p50;
        p49.gui.Brightness = p50;
    end;

    if p51 ~= p49.transparency then
        p49.transparency = p51;
        p49.viewport.ImageTransparency = p51;
    end;

    local picture = p49.picture;

    if picture.fields and (picture.shown ~= nil and p52 ~= picture.color) then
        picture.color = p52;

        for i, v in ipairs(picture.fields) do
            local v54 = picture.wears[i];

            if v54 then
                if v54.Color ~= p52 then
                    v54.Color = p52;
                end;
            else
                v.Color = p52;
            end;
        end;
    end;

    local mask = p49.mask;

    if p53 ~= nil and (mask and (mask.fields and (mask.shown ~= nil and p53 ~= mask.color))) then
        mask.color = p53;

        for i in ipairs(mask.fields) do
            local v55 = mask.wears[i];

            if v55 and v55.Color ~= p53 then
                v55.Color = p53;
            end;
        end;
    end;
end;

function v1.rest(p56) -- Line: 318
    p56.shown = false;
    p56.gui.Enabled = false;
end;

function v1.destroy(p57) -- Line: 323
    p57.gui:Destroy();
    p57.quad:Destroy();
end;

return v1;