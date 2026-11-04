 
 

local u1 = {
    ATTRIBUTE = "DragModel",
    ROBLOX = "Roblox"
};

function u1.isRoblox(p2) -- Line: 33
    -- upvalues: u1 (copy)
    return p2:GetAttribute(u1.ATTRIBUTE) == u1.ROBLOX;
end;

function u1.rate(p3, p4) -- Line: 37
    -- upvalues: u1 (copy)
    local Attribute = p3:GetAttribute(p4);

    if type(Attribute) ~= "number" then
        return 0;
    end;

    if u1.isRoblox(p3) then
        return Attribute * 0.6931471805599453;
    end;

    return Attribute;
end;

function u1.mark(p5) -- Line: 48
    -- upvalues: u1 (copy)
    p5:SetAttribute(u1.ATTRIBUTE, u1.ROBLOX);
end;

function u1.toRoblox(p6) -- Line: 52
    return math.floor(p6 / 0.6931471805599453 * 10000 + 0.5) / 10000;
end;

return u1;