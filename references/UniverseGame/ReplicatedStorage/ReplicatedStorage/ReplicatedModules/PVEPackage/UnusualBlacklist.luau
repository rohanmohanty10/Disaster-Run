  

 

local u1 = {
    Items = {}
};

function u1.IsBlacklisted(p2) -- Line: 8
    -- upvalues: u1 (copy)
    if table.find(u1.Items, p2) then
        return true;
    end;
end;

return u1;