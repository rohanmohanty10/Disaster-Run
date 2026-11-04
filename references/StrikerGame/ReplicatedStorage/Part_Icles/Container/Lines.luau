 

 

local Clock = require(script.Parent.Clock);
local Colors = require(script.Parent.Colors);
local Graph = require(script.Parent.Parent.Graph);
local u8 = {
    kindOf = function(p1) -- Line: 64, Name: kindOf
        return p1:IsA("Beam") and "Beam" or (p1:IsA("Trail") and "Trail" or nil);
    end,

    base = function(p2, p3) -- Line: 74, Name: base
        local v4 = {
            brightness = p2.Brightness,
            lightInfluence = p2.LightInfluence,
            lightEmission = p2.LightEmission,
            color = p2.Color
        };

        if p3 ~= "Beam" then
            v4.widthScale = p2.WidthScale;
            v4.lifetime = p2.Lifetime;

            return v4;
        end;

        v4.width0 = p2.Width0;
        v4.width1 = p2.Width1;
        v4.curveSize0 = p2.CurveSize0;
        v4.curveSize1 = p2.CurveSize1;
        v4.textureSpeed = p2.TextureSpeed;

        return v4;
    end,

    scaled = function(p5, p6) -- Line: 94, Name: scaled
        local v7 = {};

        for i, v in ipairs(p5.Keypoints) do
            v7[i] = NumberSequenceKeypoint.new(v.Time, v.Value * p6, v.Envelope * p6);
        end;

        return NumberSequence.new(v7);
    end
};

local function timescaleAt(p9, p10) -- Line: 103
    -- upvalues: Clock (copy), Graph (copy)
    local play = p9.play;
    local v11 = Clock.position(play.Mode, p10, play.ContainerLife, p9.timing);
    local v12 = Graph.QueryPointsWithTime(v11, play.ActiveGraphs.DriveTimescale, play.Seeds.DriveTimescale);

    return math.max(v12, 0);
end;

function u8.lifetimeAhead(p13, p14, p15) -- Line: 113
    -- upvalues: Clock (copy), Graph (copy)
    local v16 = p14.play._stepAt or 0;

    if p13.aheadFor ~= p15 or v16 < p13.nowSlice * 0.03333333333333333 then
        p13.aheadFor = p15;
        p13.nowSlice = math.floor(v16 / 0.03333333333333333);
        p13.nowSum = 0;
        p13.endSlice = p13.nowSlice;
        p13.endSum = 0;
    end;

    while (p13.nowSlice + 1) * 0.03333333333333333 <= v16 do
        local nowSum = p13.nowSum;
        local play = p14.play;
        local v17 = Clock.position(play.Mode, (p13.nowSlice + 0.5) * 0.03333333333333333, play.ContainerLife, p14.timing);
        local v18 = Graph.QueryPointsWithTime(v17, play.ActiveGraphs.DriveTimescale, play.Seeds.DriveTimescale);
        p13.nowSum = nowSum + math.max(v18, 0) * 0.03333333333333333;
        p13.nowSlice = p13.nowSlice + 1;
    end;

    local nowSum = p13.nowSum;
    local v19 = v16 - p13.nowSlice * 0.03333333333333333;
    local play = p14.play;
    local v20 = Clock.position(play.Mode, (p13.nowSlice + 0.5) * 0.03333333333333333, play.ContainerLife, p14.timing);
    local v21 = Graph.QueryPointsWithTime(v20, play.ActiveGraphs.DriveTimescale, play.Seeds.DriveTimescale);
    local v22 = nowSum + v19 * math.max(v21, 0);

    if p13.endSlice < p13.nowSlice then
        p13.endSlice = p13.nowSlice;
        p13.endSum = p13.nowSum;
    end;

    while p13.endSum - v22 < p15 and p13.endSlice * 0.03333333333333333 - v16 < 20 do
        local play2 = p14.play;
        local v23 = Clock.position(play2.Mode, (p13.endSlice + 0.5) * 0.03333333333333333, play2.ContainerLife, p14.timing);
        local v24 = Graph.QueryPointsWithTime(v23, play2.ActiveGraphs.DriveTimescale, play2.Seeds.DriveTimescale);
        local math_max_ret = math.max(v24, 0);
        p13.endSum = p13.endSum + math_max_ret * 0.03333333333333333;
        p13.endSlice = p13.endSlice + 1;
        p13.endLast = math_max_ret;
    end;

    local v25 = p13.endSlice * 0.03333333333333333 - v16;
    local v26 = p13.endSum - v22 - p15;
    local v27 = p13.endLast or 0;

    if v26 > 0 and v27 > 0 then
        v25 = v25 - v26 / v27;
    end;

    return math.clamp(v25, 0.01, 20);
end;

local function trailLife(p28, p29, p30) -- Line: 149
    -- upvalues: u8 (copy)
    if not p29.slowed then
        return p28.lifetime;
    end;

    local v31 = u8.lifetimeAhead(p30, p29, p28.lifetime);
    local lifetime = p30.lifetime;

    if lifetime and v31 < lifetime then
        if p29.timescale >= 0.25 then
            lifetime = v31;
        end;
    else
        lifetime = v31;
    end;

    p30.lifetime = lifetime;

    return lifetime;
end;

function u8.write(p32, p33, p34, p35, p36) -- Line: 162
    -- upvalues: u8 (copy), Colors (copy)
    local scale = p35.scale;

    if p33 == "Beam" then
        p32.Width0 = p34.width0 * scale;
        p32.Width1 = p34.width1 * scale;

        if p34.curveSize0 then
            p32.CurveSize0 = p34.curveSize0 * scale;
            p32.CurveSize1 = p34.curveSize1 * scale;
        end;

        if p34.textureSpeed then
            p32.TextureSpeed = p34.textureSpeed * p35.timescale;
        end;
    else
        local scale2 = p36.scale;

        if p36.widthFrom ~= p34.widthScale or (scale2 == nil or math.abs(scale - scale2) > math.max(scale2, 0.005) * 0.005) then
            p36.widthFrom = p34.widthScale;
            p36.scale = scale;
            p36.width = u8.scaled(p34.widthScale, scale);
        end;

        p32.WidthScale = p36.width;
        local v37;

        if p35.slowed then
            local v38 = u8.lifetimeAhead(p36, p35, p34.lifetime);
            v37 = p36.lifetime;

            if v37 and v38 < v37 then
                if p35.timescale >= 0.25 then
                    v37 = v38;
                end;
            else
                v37 = v38;
            end;

            p36.lifetime = v37;
        else
            v37 = p34.lifetime;
        end;

        p32.Lifetime = v37;
    end;

    p32.Brightness = p34.brightness * p35.brightness;
    p32.LightInfluence = math.clamp(p34.lightInfluence + p35.lightInfluence, 0, 1);
    p32.LightEmission = math.clamp(p34.lightEmission + p35.lightEmission, 0, 1);
    local look = p35.look;

    if look and p34.color then
        if p36.colorFrom ~= p34.color or p36.colorStamp ~= p35.colorStamp then
            p36.colorFrom = p34.color;
            p36.colorStamp = p35.colorStamp;
            p36.color = Colors.sequence(p34.color, look);
        end;

        p32.Color = p36.color;
    end;
end;

local function hasStates(p39) -- Line: 205
    local v40;

    if p39 == nil then
        v40 = false;
    else
        v40 = #p39 >= 1;
    end;

    return v40;
end;

function u8.driveBeam(p41) -- Line: 209
    -- upvalues: u8 (copy)
    local VisualPart = p41.VisualPart;
    local _driveBase = p41._driveBase;
    local AnimatedProps = p41.AnimatedProps;
    local _driveAuthored = p41._driveAuthored;
    local v42 = p41.ParentScale ~= nil;
    _driveAuthored.width0 = (AnimatedProps.Width0 or v42) and VisualPart.Width0 or _driveBase.width0;
    _driveAuthored.width1 = (AnimatedProps.Width1 or v42) and VisualPart.Width1 or _driveBase.width1;
    _driveAuthored.curveSize0 = (AnimatedProps.CurveSize0 or v42) and VisualPart.CurveSize0 or _driveBase.curveSize0;
    _driveAuthored.curveSize1 = (AnimatedProps.CurveSize1 or v42) and VisualPart.CurveSize1 or _driveBase.curveSize1;
    _driveAuthored.brightness = AnimatedProps.Brightness and VisualPart.Brightness or _driveBase.brightness;
    _driveAuthored.lightInfluence = AnimatedProps.LightInfluence and VisualPart.LightInfluence or _driveBase.lightInfluence;
    _driveAuthored.lightEmission = AnimatedProps.LightEmission and VisualPart.LightEmission or _driveBase.lightEmission;
    _driveAuthored.textureSpeed = nil;

    if not AnimatedProps.TextureSpeed then
        _driveAuthored.textureSpeed = _driveBase.textureSpeed;
    end;

    _driveAuthored.color = _driveBase.color;

    if p41.SkipColor then
        _driveAuthored.color = nil;
    else
        local ColorStates = p41.ColorStates;
        local v43;

        if ColorStates == nil then
            v43 = false;
        else
            v43 = #ColorStates >= 1;
        end;

        if v43 then
            _driveAuthored.color = VisualPart.Color;
        end;
    end;

    u8.write(VisualPart, "Beam", _driveAuthored, p41._drive, p41._driveState);
end;

function u8.driveTrail(p44) -- Line: 235
    -- upvalues: Graph (copy), u8 (copy)
    local VisualPart = p44.VisualPart;
    local _driveBase = p44._driveBase;
    local _driveAuthored = p44._driveAuthored;
    local v45 = not p44.SkipColor;
    _driveAuthored.widthScale = _driveBase.widthScale;

    if v45 then
        local WidthStates = p44.WidthStates;
        local v46;

        if WidthStates == nil then
            v46 = false;
        else
            v46 = #WidthStates >= 1;
        end;

        if v46 then
            _driveAuthored.widthScale = VisualPart.WidthScale;
        end;
    end;

    _driveAuthored.color = _driveBase.color;

    if v45 then
        local ColorStates = p44.ColorStates;
        local v47;

        if ColorStates == nil then
            v47 = false;
        else
            v47 = #ColorStates >= 1;
        end;

        if v47 then
            _driveAuthored.color = VisualPart.Color;
        end;
    else
        _driveAuthored.color = nil;
    end;

    _driveAuthored.lifetime = _driveBase.lifetime;
    local Graphs = p44.Graphs;
    local Seeds = p44.Seeds;
    local v48 = p44.CurrentStep / math.max(p44.TotalKeyFrames, 1);
    _driveAuthored.brightness = _driveBase.brightness;

    if Graphs.Brightness then
        _driveAuthored.brightness = Graph.QueryPointsWithTime(v48, Graphs.Brightness, Seeds.Brightness);
    end;

    _driveAuthored.lightInfluence = _driveBase.lightInfluence;

    if Graphs.LightInfluence then
        _driveAuthored.lightInfluence = Graph.QueryPointsWithTime(v48, Graphs.LightInfluence, Seeds.LightInfluence);
    end;

    _driveAuthored.lightEmission = _driveBase.lightEmission;

    if Graphs.LightEmission then
        _driveAuthored.lightEmission = Graph.QueryPointsWithTime(v48, Graphs.LightEmission, Seeds.LightEmission);
    end;

    u8.write(VisualPart, "Trail", _driveAuthored, p44._drive, p44._driveState);
end;

function u8.carry(p49, p50, p51) -- Line: 273
    -- upvalues: u8 (copy)
    p49._drive = p51;
    p49._driveBase = u8.base(p49.VisualPart, p50);
    p49._driveAuthored = {};
    p49._driveState = {};
    p49._noPool = true;

    if p50 == "Beam" then
        u8.driveBeam(p49);

        return;
    end;

    u8.driveTrail(p49);
end;

return u8;