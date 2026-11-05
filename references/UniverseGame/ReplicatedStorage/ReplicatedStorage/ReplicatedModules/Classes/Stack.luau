  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = {
        Items = {}
    };
    setmetatable(v2, u1);

    return v2;
end;

function u1.IsEmpty(p3) -- Line: 12
    return #p3.Items <= 0;
end;

function u1.Peek(p4) -- Line: 16
    return p4.Items[#p4.Items];
end;

function u1.Pop(p5) -- Line: 20
    return table.remove(p5.Items, #p5.Items);
end;

function u1.Push(p6, p7) -- Line: 24
    table.insert(p6.Items, p7);
end;

function u1.All(p8) -- Line: 28
    return p8.Items;
end;

function u1.GetAmount(p9) -- Line: 32
    return #p9.Items;
end;

function u1.Destroy(p10) -- Line: 36
    table.clear(p10.Items);
    table.clear(p10);
end;

function u1.__len(p11) -- Line: 41
    return #p11.Items;
end;

return u1;