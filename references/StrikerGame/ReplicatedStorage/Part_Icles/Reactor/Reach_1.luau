 
 

local Fields = require(script.Parent.Parent.Force.Fields);
local v1 = {};

local function passedBefore(p2, p3, p4) -- Line: 30
    if p2.actsAs ~= "Impulse" or p2.moving then
        return false;
    end;

    local v5 = p2.age - p4;

    if v5 <= 0 then
        return false;
    end;

    return p2.travelSpeed <= 0 and true or p3 <= p2.travelSpeed * v5;
end;

function v1.moved(p6, p7, p8, p9, p10) -- Line: 44
    -- upvalues: Fields (copy)
    local strength = p6.strength;
    local v11, v12, v13 = Fields.sample(p6.field, p7, strength < 0);

    if not v11 or p6.front < v12 then
        return false;
    end;

    local v14;

    if p6.actsAs == "Impulse" and not p6.moving then
        local v15 = p6.age - p10;

        if v15 <= 0 then
            v14 = false;
        else
            v14 = p6.travelSpeed <= 0 and true or v12 <= p6.travelSpeed * v15;
        end;
    else
        v14 = false;
    end;

    if v14 then
        return false;
    end;

    local v16 = (p8.X * p8.Y * p8.Z) ^ 0.3333333333333333;

    return p9 < math.abs(strength) * Fields.kept(p6.falloff, v13) * Fields.sizeShare(v16, p6.sizeResponse);
end;

function v1.inBlade(p17, p18, p19, p20) -- Line: 58
    local field = p17.field;
    local v21 = field.origin:PointToObjectSpace(p18);
    local v22 = -v21.Z;

    if field.range + p19 < v22 or v22 < field.inner - p19 then
        return false;
    end;

    if math.abs(v21.X) > field.halfWidth + p19 or math.abs(v21.Y) > field.halfHeight + p19 then
        return false;
    end;

    if v22 - p19 > p17.front then
        return false;
    end;

    local v23;

    if p17.actsAs == "Impulse" and not p17.moving then
        local v24 = p17.age - p20;

        if v24 <= 0 then
            v23 = false;
        else
            v23 = p17.travelSpeed <= 0 and true or v22 <= p17.travelSpeed * v24;
        end;
    else
        v23 = false;
    end;

    return not v23;
end;

return v1;