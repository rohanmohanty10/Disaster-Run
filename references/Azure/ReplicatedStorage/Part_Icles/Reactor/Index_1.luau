 
 

local CollectionService = game:GetService("CollectionService");
local u1 = {
    TAG = "PartIcleReactor",
    MARKS = { "Transformed", "Qwinkle", "IsReactor", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop" }
};

function u1.reactors() -- Line: 19
    -- upvalues: CollectionService (copy), u1 (copy)
    local v2 = {};

    for _, v in ipairs(CollectionService:GetTagged(u1.TAG)) do
        if v:IsDescendantOf(workspace) and not v:GetAttribute("_PartIcleEmit") then
            table.insert(v2, v);
        end;
    end;

    return v2;
end;

function u1.reachOf(p3) -- Line: 30
    if p3.shape == "Linear" then
        return math.sqrt(p3.range * p3.range + p3.halfWidth * p3.halfWidth + p3.halfHeight * p3.halfHeight);
    end;

    if p3.shape == "Vortex" then
        return math.sqrt(p3.range * p3.range + p3.height * p3.height);
    end;

    return p3.range;
end;

function u1.reaches(p4, p5, p6) -- Line: 39
    -- upvalues: u1 (copy)
    return (p5 - p4.origin.Position).Magnitude <= p6 + u1.reachOf(p4);
end;

function u1.unmark(p7) -- Line: 44
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.MARKS) do
        p7:SetAttribute(v, nil);
    end;

    p7:RemoveTag(u1.TAG);
end;

function u1.groupMatches(p8, p9) -- Line: 52
    return p8 == "" and true or p8 == p9;
end;

return u1;