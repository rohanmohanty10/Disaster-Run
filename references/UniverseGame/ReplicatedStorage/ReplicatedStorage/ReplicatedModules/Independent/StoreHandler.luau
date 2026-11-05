  

 

local u1 = {
    Stores = {}
};

function u1.GetStore(p2) -- Line: 7
    -- upvalues: u1 (copy)
    if not u1.Stores[p2] then
        u1.Stores[p2] = {};
    end;

    return u1.Stores[p2];
end;

return u1;