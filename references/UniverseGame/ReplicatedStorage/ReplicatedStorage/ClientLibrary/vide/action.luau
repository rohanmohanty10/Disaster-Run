  

 

local u1 = table.freeze({});

local function is_action(p2) -- Line: 8
    -- upvalues: u1 (copy)
    return getmetatable(p2) == u1;
end;

local function action(p3, p4) -- Line: 12
    -- upvalues: u1 (copy)
    local v5 = {
        priority = p4 or 1,
        callback = p3
    };
    setmetatable(v5, u1);

    return table.freeze(v5);
end;

return function() -- Line: 23
    -- upvalues: action (copy), is_action (copy)
    return action, is_action;
end;