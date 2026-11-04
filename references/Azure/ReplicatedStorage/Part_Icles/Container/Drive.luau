 

 

local Clock = require(script.Parent.Clock);
local Colors = require(script.Parent.Colors);
local Lines = require(script.Parent.Lines);
local Graph = require(script.Parent.Parent.Graph);
local ContainerDriveGraphs = require(script.Parent.Parent.TypeRegistry.TypeData).ContainerDriveGraphs;
local u1 = {};
local u2 = {};

local function hasTransformedAncestor(p3, p4) -- Line: 88
    local Parent = p3.Parent;

    while Parent and Parent ~= p4 do
        if Parent:GetAttribute("Transformed") then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

function u2.collect(p5) -- Line: 99
    -- upvalues: hasTransformedAncestor (copy), Clock (copy)
    local v6 = {};

    for _, descendant in ipairs(p5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not hasTransformedAncestor(descendant, p5) then
            local v7 = {
                emitter = descendant
            };
            local v8 = {};
            local v9 = tonumber(descendant:GetAttribute("EmitDelay")) or 0;
            v8.delay = math.max(v9, 0);
            v8.duration = Clock.maxDuration(descendant:GetAttribute("EmitDuration"));
            v8.life = descendant.Lifetime.Max;
            v7.timing = v8;
            v7.base = {
                rate = descendant.Rate,
                size = descendant.Size,
                timeScale = descendant.TimeScale,
                brightness = descendant.Brightness,
                color = descendant.Color,
                spread = descendant.SpreadAngle,
                lightInfluence = descendant.LightInfluence,
                lightEmission = descendant.LightEmission
            };
            table.insert(v6, v7);
        end;
    end;

    return v6;
end;

local function newAsked(p10, p11, p12) -- Line: 128
    -- upvalues: Clock (copy)
    local v13 = {
        rate = 1,
        scale = 1,
        timescale = 1,
        brightness = 1,
        spreadX = 0,
        spreadY = 0,
        lightInfluence = 0,
        lightEmission = 0,
        look = nil,
        colorStamp = 0,
        kind = p10
    };
    local v14 = {};
    local v15 = tonumber(p11:GetAttribute("EmitDelay")) or 0;
    v14.delay = math.max(v15, 0);
    v14.duration = Clock.maxDuration(p11:GetAttribute("EmitDuration"));
    v14.life = p12;
    v13.timing = v14;

    return v13;
end;

function u2.collectLines(p16) -- Line: 149
    -- upvalues: Lines (copy), hasTransformedAncestor (copy), newAsked (copy)
    local v17 = {};

    for _, descendant in ipairs(p16:GetDescendants()) do
        local v18 = Lines.kindOf(descendant);

        if v18 and not (descendant:GetAttribute("Transformed") or hasTransformedAncestor(descendant, p16)) then
            local v19 = newAsked(v18, descendant, v18 ~= "Trail" and 0 or descendant.Lifetime);
            v19.line = descendant;
            v19.base = Lines.base(descendant, v18);
            v19.state = {};
            table.insert(v17, v19);
        end;
    end;

    return v17;
end;

function u2.collectCarried(p20, u21) -- Line: 168
    -- upvalues: Lines (copy), newAsked (copy)
    local u22 = {};
    local u23 = {};

    local function visit(p24) -- Line: 171
        -- upvalues: u21 (copy), Lines (ref), newAsked (ref), u22 (copy), u23 (copy), visit (copy)
        for _, child in ipairs(p24:GetChildren()) do
            if child:GetAttribute("Transformed") then
                local v25 = u21(child);
                local v26 = typeof(v25) ~= "NumberRange" and 0 or v25.Max;
                local v27 = Lines.kindOf(child) or "Mesh";
                local v28 = newAsked(child:GetAttribute("IsForce") == true and "Reactor" or v27, child, v26);
                v28.item = child;
                table.insert(u22, v28);
                u23[child] = v28;
            else
                visit(child);
            end;
        end;
    end;

    visit(p20);

    return u22, u23;
end;

local function isNeutral(p29, p30) -- Line: 196
    for _, v in ipairs(p29.Keypoints) do
        if v.Value ~= p30 or v.Envelope ~= 0 then
            return false;
        end;
    end;

    return true;
end;

function u2.activeGraphs(p31) -- Line: 205
    -- upvalues: ContainerDriveGraphs (copy)
    local v32 = {};

    for i, v in pairs(ContainerDriveGraphs) do
        local v33 = p31[i];
        local v34 = v == "multiply" and 1 or 0;

        if v33 then
            local v35 = i;
            local v36 = true;

            for _, v2 in ipairs(v33.Keypoints) do
                if v2.Value ~= v34 or v2.Envelope ~= 0 then
                    v36 = false;
                    break;
                end;
            end;

            if not v36 then
                v32[v35] = v33;
            end;
        end;
    end;

    return v32;
end;

function u2.lowestTimescale(p37) -- Line: 220
    local v38 = 1;
    local DriveTimescale = p37.DriveTimescale;

    if DriveTimescale then
        for _, v in ipairs(DriveTimescale.Keypoints) do
            local math_max_ret = math.max(v.Value - v.Envelope, 0);
            v38 = math.min(v38, math_max_ret);
        end;
    end;

    return v38;
end;

function u2.slowestTimescale(p39, p40) -- Line: 231
    -- upvalues: u2 (copy)
    local v41 = u2.lowestTimescale(p40);
    local v42 = 1;

    for _, v in ipairs(p39) do
        v42 = math.min(v42, v.base.timeScale * v41);
    end;

    return v42;
end;

function u2.colorGraph(p43, p44) -- Line: 240
    -- upvalues: Colors (copy)
    if typeof(p43) == "ColorSequence" and not Colors.isNeutral(p43, p44) then
        return p43;
    end;

    return nil;
end;

local function colorMoved(p45, p46) -- Line: 247
    return (math.abs(p46.R - p45.R) > 0.0078125 or math.abs(p46.G - p45.G) > 0.0078125) and true or math.abs(p46.B - p45.B) > 0.0078125;
end;

function u2.apply(p47, p48, p49) -- Line: 251
    -- upvalues: u1 (copy), Lines (copy), Colors (copy)
    local emitter = p47.emitter;
    local base = p47.base;
    local v50 = u1;

    if p49 and p49.Skips then
        v50 = p49.Skips.Emitter;
    end;

    local DriveRate = p48.DriveRate;

    if DriveRate and not v50.DriveRate then
        emitter.Rate = base.rate * math.max(DriveRate, 0);
    end;

    local DriveScale = p48.DriveScale;

    if DriveScale and not v50.DriveScale then
        local math_max_ret = math.max(DriveScale, 0);
        local appliedScale = p47.appliedScale;

        if appliedScale == nil or math.abs(math_max_ret - appliedScale) > math.max(appliedScale, 0.005) * 0.005 then
            p47.appliedScale = math_max_ret;
            emitter.Size = Lines.scaled(base.size, math_max_ret);
        end;
    end;

    local DriveTimescale = p48.DriveTimescale;

    if DriveTimescale and not v50.DriveTimescale then
        emitter.TimeScale = math.clamp(base.timeScale * DriveTimescale, 0, 1);
    end;

    local DriveBrightness = p48.DriveBrightness;

    if DriveBrightness and not v50.DriveBrightness then
        emitter.Brightness = base.brightness * math.max(DriveBrightness, 0);
    end;

    local v51;

    if p49 then
        v51 = p49._color;
    else
        v51 = p49;
    end;

    if v51 and not v50.DriveColor then
        local appliedColor = p47.appliedColor;

        if appliedColor == nil or (math.abs(v51.R - appliedColor.R) > 0.0078125 or math.abs(v51.G - appliedColor.G) > 0.0078125 or math.abs(v51.B - appliedColor.B) > 0.0078125) then
            p47.appliedColor = v51;
            emitter.Color = Colors.apply(base.color, v51, p49.ColorMode, p49.ColorReference);
        end;
    end;

    local DriveSpreadX = p48.DriveSpreadX;
    local DriveSpreadY = p48.DriveSpreadY;

    if (DriveSpreadX or DriveSpreadY) and not v50.DriveSpreadX then
        emitter.SpreadAngle = Vector2.new(base.spread.X + (DriveSpreadX or 0), base.spread.Y + (DriveSpreadY or 0));
    end;

    local DriveLightInfluence = p48.DriveLightInfluence;

    if DriveLightInfluence and not v50.DriveLightInfluence then
        emitter.LightInfluence = math.clamp(base.lightInfluence + DriveLightInfluence, 0, 1);
    end;

    local DriveLightEmission = p48.DriveLightEmission;

    if DriveLightEmission and not v50.DriveLightEmission then
        emitter.LightEmission = math.clamp(base.lightEmission + DriveLightEmission, 0, 1);
    end;
end;

local function sampleAt(p52, p53) -- Line: 312
    -- upvalues: Graph (copy)
    if p52._sampledPosition == p53 then
        return;
    end;

    p52._sampledPosition = p53;
    local _values = p52._values;

    for i, v in pairs(p52.ActiveGraphs) do
        _values[i] = Graph.QueryPointsWithTime(p53, v, p52.Seeds[i]);
    end;

    if p52.ColorGraph then
        p52._color = Graph.QueryColorPointWithTime(p53, p52.ColorGraph);
    end;
end;

local function ask(p54, p55, p56) -- Line: 328
    -- upvalues: u1 (copy), Colors (copy)
    local v57 = u1;

    if p56.Skips then
        v57 = p56.Skips[p54.kind or "Mesh"] or u1;
    end;

    p54.rate = 1;
    p54.scale = 1;
    p54.timescale = 1;
    p54.brightness = 1;
    p54.spreadX = 0;
    p54.spreadY = 0;
    p54.lightInfluence = 0;
    p54.lightEmission = 0;
    local v58;

    if p55.DriveTimescale == nil then
        v58 = false;
    else
        v58 = not v57.DriveTimescale;
    end;

    p54.slowed = v58;

    if not v57.DriveLightInfluence then
        p54.lightInfluence = p55.DriveLightInfluence or 0;
    end;

    if not v57.DriveLightEmission then
        p54.lightEmission = p55.DriveLightEmission or 0;
    end;

    if not v57.DriveRate then
        p54.rate = math.max(p55.DriveRate or 1, 0);
    end;

    if not v57.DriveScale then
        p54.scale = math.max(p55.DriveScale or 1, 0);
    end;

    if not v57.DriveTimescale then
        p54.timescale = p55.DriveTimescale or 1;
    end;

    if not v57.DriveBrightness then
        p54.brightness = math.max(p55.DriveBrightness or 1, 0);
    end;

    if not v57.DriveSpreadX then
        p54.spreadX = p55.DriveSpreadX or 0;
        p54.spreadY = p55.DriveSpreadY or 0;
    end;

    local _color = p56._color;

    if v57.DriveColor then
        _color = nil;
    end;

    if _color then
        if p54.asked == nil then
            p54.asked = _color;
            p54.look = Colors.prepare(p54.look or {}, _color, p56.ColorMode, p56.ColorReference);
            p54.colorStamp = p54.colorStamp + 1;
        else
            local asked = p54.asked;

            if (math.abs(_color.R - asked.R) > 0.0078125 or math.abs(_color.G - asked.G) > 0.0078125) and true or math.abs(_color.B - asked.B) > 0.0078125 then
                p54.asked = _color;
                p54.look = Colors.prepare(p54.look or {}, _color, p56.ColorMode, p56.ColorReference);
                p54.colorStamp = p54.colorStamp + 1;
            end;
        end;
    end;
end;

local function driveLine(p59, p60) -- Line: 377
    -- upvalues: ask (copy), Lines (copy)
    p59.play = p60;
    ask(p59, p60._values, p60);
    Lines.write(p59.line, p59.kind, p59.base, p59, p59.state);
end;

local function driveAdopted(p61, p62, p63) -- Line: 385
    -- upvalues: ask (copy), Lines (copy), u2 (copy)
    local v64 = 1;

    while v64 <= #p61 do
        local v65 = p61[v64];

        if (v65.emitter or v65.line).Parent == nil then
            p61[v64] = p61[#p61];
            p61[#p61] = nil;
        else
            if v65.line and (p62 or v65.kind == "Trail") then
                v65.play = p63;
                ask(v65, p63._values, p63);
                Lines.write(v65.line, v65.kind, v65.base, v65, v65.state);
            elseif p62 and v65.emitter then
                u2.apply(v65, p63._values, p63);
            end;

            v64 = v64 + 1;
        end;
    end;
end;

function u2.stream(p66, p67, p68) -- Line: 406
    if p66 then
        return p67 * p66.rate, p68 * math.max(p66.timescale, 0);
    end;

    return p67, p68;
end;

function u2.adopt(p69, p70) -- Line: 413
    -- upvalues: u2 (copy), sampleAt (copy), ask (copy), Lines (copy)
    local v71;

    if p69 then
        v71 = p69.play;
    else
        v71 = p69;
    end;

    if not (v71 and (not v71._released and v71._drives)) then
        return 0;
    end;

    if p70.IsAnimate or (p70.Type == "Container" or not p70.VisualPart) then
        return 0;
    end;

    local v72 = u2.collect(p70.VisualPart);
    local v73 = u2.collectLines(p70.VisualPart);

    if #v72 + #v73 == 0 then
        return 0;
    end;

    sampleAt(v71, p69.position or 0);
    p69.emitters = p69.emitters or {};

    for _, v in ipairs(v72) do
        u2.apply(v, v71._values, v71);
        table.insert(p69.emitters, v);
    end;

    p69.lines = p69.lines or {};

    for _, v in ipairs(v73) do
        v.timing = p69.timing;
        v.play = v71;
        ask(v, v71._values, v71);
        Lines.write(v.line, v.kind, v.base, v, v.state);
        table.insert(p69.lines, v);
    end;

    p70._noPool = true;

    return #v72 + #v73;
end;

function u2.step(p74, p75) -- Line: 443
    -- upvalues: Clock (copy), sampleAt (copy), u2 (copy), ask (copy), Lines (copy), driveAdopted (copy)
    p74._stepAt = p75;

    for _, v in ipairs(p74.Driven) do
        local v76 = Clock.position(p74.Mode, p75, p74.ContainerLife, v.timing);

        if v76 ~= v.position then
            v.position = v76;
            sampleAt(p74, v76);
            u2.apply(v, p74._values, p74);
        end;
    end;

    for _, v in ipairs(p74.Lines) do
        local v77 = Clock.position(p74.Mode, p75, p74.ContainerLife, v.timing);

        if v77 ~= v.position or v.kind == "Trail" then
            v.position = v77;
            sampleAt(p74, v77);
            v.play = p74;
            ask(v, p74._values, p74);
            Lines.write(v.line, v.kind, v.base, v, v.state);
        end;
    end;

    for _, v in ipairs(p74.Carried) do
        local v78 = Clock.position(p74.Mode, p75, p74.ContainerLife, v.timing);
        local v79 = v78 ~= v.position;

        if v79 then
            v.position = v78;
            sampleAt(p74, v78);
            ask(v, p74._values, p74);
        end;

        if v.emitters then
            driveAdopted(v.emitters, v79, p74);
        end;

        if v.lines then
            if not v79 then
                sampleAt(p74, v78);
            end;

            driveAdopted(v.lines, v79, p74);
        end;
    end;
end;

return u2;