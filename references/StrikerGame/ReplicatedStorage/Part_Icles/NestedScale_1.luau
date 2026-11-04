 
 

local u2 = {
    textureScales = function(p1) -- Line: 43, Name: textureScales
        return p1.TextureMode ~= Enum.TextureMode.Stretch;
    end
};

local function copiedAt(p3, p4) -- Line: 49
    local Attribute = p3:GetAttribute("_copiedScale");

    if Attribute then
        return Attribute;
    end;

    while p4 do
        local Owner = p4.Owner;

        if Owner and Owner.IsAnimate then
            local VisualPart = Owner.VisualPart;

            if not (VisualPart and VisualPart.Parent) then
                return 1;
            end;

            local Scale = VisualPart:GetScale();

            return math.max(Scale, 0.001);
        end;

        p4 = p4.Parent;
    end;

    return 1;
end;

local function collect(p5, p6) -- Line: 70
    -- upvalues: collect (copy), u2 (copy)
    for _, child in ipairs(p5:GetChildren()) do
        if not child:GetAttribute("_PartIcleEmit") then
            if child:IsA("Attachment") then
                table.insert(p6.attachments, child);
                table.insert(p6.positions, child.Position);
                collect(child, p6);
            elseif child:IsA("Beam") then
                table.insert(p6.beams, child);
                local shapes = p6.shapes;
                local v7 = {
                    width0 = child.Width0,
                    width1 = child.Width1,
                    curveSize0 = child.CurveSize0,
                    curveSize1 = child.CurveSize1,
                    segments = child.Segments,
                    textureLength = p6.scaleTexture and (u2.textureScales(child) and child.TextureLength) or nil
                };
                table.insert(shapes, v7);
            elseif not (child:IsA("BasePart") or child:IsA("Model")) then
                collect(child, p6);
            end;
        end;
    end;
end;

function u2.start(p8, p9, p10, p11) -- Line: 96
    -- upvalues: copiedAt (copy), collect (copy), u2 (copy)
    if not (p9 or p11) then
        return nil;
    end;

    local v12 = not p9 and 1 or copiedAt(p8, p9);
    local v13 = {
        drive = 1,
        copied = v12,
        factor = v12
    };
    local v14;

    if p9 == nil then
        v14 = false;
    else
        v14 = p9.ScaleTextureLength ~= false;
    end;

    v13.scaleTexture = v14;
    v13.attachments = {};
    v13.positions = {};
    v13.beams = {};
    v13.shapes = {};
    collect(p8, v13);

    if #v13.attachments == 0 and #v13.beams == 0 then
        return nil;
    end;

    if v12 ~= 1 then
        p8:SetAttribute("_copiedScale", v12);
    end;

    u2.apply(v13, p10, p11);

    return v13;
end;

function u2.apply(p15, p16, p17) -- Line: 125
    local v18 = p17 or 1;

    if p16 == p15.factor and v18 == p15.drive then
        return;
    end;

    local v19 = p16 ~= p15.factor;
    p15.factor = p16;
    p15.drive = v18;
    local v20 = p16 / p15.copied;
    local positions = p15.positions;

    for i, v in ipairs(p15.attachments) do
        v.Position = positions[i] * (v20 * v18);
    end;

    if not v19 then
        return;
    end;

    local shapes = p15.shapes;

    for i, v in ipairs(p15.beams) do
        local v21 = shapes[i];
        v.Width0 = v21.width0 * v20;
        v.Width1 = v21.width1 * v20;
        v.CurveSize0 = v21.curveSize0 * v20;
        v.CurveSize1 = v21.curveSize1 * v20;
        local segments = v21.segments;
        local math_round_ret = math.round(v21.segments * v20);
        v.Segments = math.max(segments, math_round_ret);

        if v21.textureLength then
            v.TextureLength = v21.textureLength * v20;
        end;
    end;
end;

function u2.restore(p22) -- Line: 158
    -- upvalues: u2 (copy)
    u2.apply(p22, p22.copied, 1);
end;

return u2;