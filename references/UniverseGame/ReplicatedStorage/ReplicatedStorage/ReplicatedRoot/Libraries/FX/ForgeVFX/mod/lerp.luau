  

 

local u1 = require("./color/Oklab");
local u17 = {
    number = function(p2, p3, p4) -- Line: 7, Name: number
        return p2 + (p3 - p2) * p4;
    end,

    Vector3 = function(p5, p6, p7) -- Line: 11, Name: Vector3
        return p5:Lerp(p6, p7);
    end,

    Vector2 = function(p8, p9, p10) -- Line: 15, Name: Vector2
        return p8:Lerp(p9, p10);
    end,

    CFrame = function(p11, p12, p13) -- Line: 19, Name: CFrame
        return p11:Lerp(p12, p13);
    end,

    UDim2 = function(p14, p15, p16) -- Line: 23, Name: UDim2
        return p14:Lerp(p15, p16);
    end
};

function u17.UDim(p18, p19, p20) -- Line: 27
    -- upvalues: u17 (copy)
    return UDim.new(u17.number(p18.Scale, p19.Scale, p20), u17.number(p18.Offset, p19.Offset, p20));
end;

function u17.NumberRange(p21, p22, p23) -- Line: 35
    -- upvalues: u17 (copy)
    return NumberRange.new(u17.number(p21.Min, p22.Min, p23), u17.number(p21.Max, p22.Max, p23));
end;

function u17.Color3(p24, p25, p26) -- Line: 43
    -- upvalues: u1 (copy)
    return u1.toSRGB(u1.fromSRGB(p24):Lerp(u1.fromSRGB(p25), p26));
end;

function u17.PhysicalProperties(p27, p28, p29) -- Line: 50
    -- upvalues: u17 (copy)
    return PhysicalProperties.new(u17.number(p27.Density, p28.Density, p29), u17.number(p27.Friction, p28.Friction, p29), u17.number(p27.Elasticity, p28.Elasticity, p29), u17.number(p27.FrictionWeight, p28.FrictionWeight, p29), u17.number(p27.ElasticityWeight, p28.ElasticityWeight, p29));
end;

function u17.Rect(p30, p31, p32) -- Line: 60
    return Rect.new(p30.Min:Lerp(p31.Min, p32), p30.Max:Lerp(p31.Max, p32));
end;

function u17.NumberSequence(p33, p34, p35) -- Line: 65
    local v36 = {};
    local v37 = {};
    local v38 = 0;

    for _, v in p33.Keypoints do
        local v39 = nil;
        local v40 = nil;

        for _, v2 in p34.Keypoints do
            if v2.Time == v.Time then
                v39 = v2;
                v40 = v39;
                local v41 = v39;
                v39 = v40;
                v41 = v40;
                break;
            end;

            if v2.Time < v.Time and (v39 == nil or v2.Time > v39.Time) then
                v39 = v2;
            elseif v2.Time > v.Time and (v40 == nil or v2.Time < v40.Time) then
                v40 = v2;
            end;
        end;

        local v42, v43;

        if v40 == v39 then
            v42 = v40.Value;
            v43 = v40.Envelope;
        else
            local v44 = (v.Time - v39.Time) / (v40.Time - v39.Time);
            v42 = (v40.Value - v39.Value) * v44 + v39.Value;
            v43 = (v40.Envelope - v39.Envelope) * v44 + v39.Envelope;
        end;

        v38 = v38 + 1;
        v36[v38] = NumberSequenceKeypoint.new(v.Time, (v42 - v.Value) * p35 + v.Value, (v43 - v.Envelope) * p35 + v.Envelope);
        v37[v.Time] = true;
    end;

    for _, v in p34.Keypoints do
        if not v37[v.Time] then
            local v45 = nil;
            local v46 = nil;

            for _, v2 in p33.Keypoints do
                if v2.Time == v.Time then
                    v45 = v2;
                    v46 = v45;
                    local v47 = v45;
                    v45 = v46;
                    v47 = v46;
                    break;
                end;

                if v2.Time < v.Time and (v45 == nil or v2.Time > v45.Time) then
                    v45 = v2;
                elseif v2.Time > v.Time and (v46 == nil or v2.Time < v46.Time) then
                    v46 = v2;
                end;
            end;

            local v48, v49;

            if v46 == v45 then
                v48 = v46.Value;
                v49 = v46.Envelope;
            else
                local v50 = (v.Time - v45.Time) / (v46.Time - v45.Time);
                v48 = (v46.Value - v45.Value) * v50 + v45.Value;
                v49 = (v46.Envelope - v45.Envelope) * v50 + v45.Envelope;
            end;

            v38 = v38 + 1;
            v36[v38] = NumberSequenceKeypoint.new(v.Time, (v.Value - v48) * p35 + v48, (v.Envelope - v49) * p35 + v49);
        end;
    end;

    table.sort(v36, function(p51, p52) -- Line: 136
        return p51.Time < p52.Time;
    end);
    local v53;

    if #v36 > 20 then
        local v54 = (#v36 - 1) / 19;
        v53 = {};

        for i = 0, 19 do
            local v55 = v36[math.floor(i * v54 + 1)];
            table.insert(v53, v55);
        end;

        if v53[#v53].Time < v36[#v36].Time then
            v53[#v53] = v36[#v36];
        end;
    else
        v53 = v36;
    end;

    return NumberSequence.new(v53);
end;

local function getColorAtTime(p56, p57) -- Line: 161
    local Keypoints = p56.Keypoints;

    if p57 <= Keypoints[1].Time then
        return Keypoints[1].Value;
    end;

    if Keypoints[#Keypoints].Time <= p57 then
        return Keypoints[#Keypoints].Value;
    end;

    local v58 = nil;
    local v59 = nil;

    for i = 1, #Keypoints do
        local v60 = Keypoints[i];

        if v60.Time == p57 then
            return v60.Value;
        end;

        if v60.Time < p57 then
            v58 = v60;
        elseif p57 < v60.Time then
            v59 = v60;
            break;
        end;
    end;

    return v58.Value:Lerp(v59.Value, (p57 - v58.Time) / (v59.Time - v58.Time));
end;

function u17.ColorSequence(p61, p62, p63) -- Line: 192
    -- upvalues: getColorAtTime (copy), u1 (copy)
    local v64 = {};

    for _, v in ipairs(p62.Keypoints) do
        local v65 = getColorAtTime(p61, v.Time);
        local v66 = u1.toSRGB(u1.fromSRGB(v65:Lerp(v.Value, p63)));
        table.insert(v64, ColorSequenceKeypoint.new(v.Time, v66));
    end;

    return ColorSequence.new(v64);
end;

function u17.Other(p67, p68, p69) -- Line: 206
    if p69 < 0.5 then
        p68 = p67 or p68;
    end;

    return p68;
end;

return u17;