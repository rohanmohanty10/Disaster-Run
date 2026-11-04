  

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 33
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._toClean = {};

    return v2;
end;

function u1.Add(p3, p4) -- Line: 43
    if typeof(p4) == "table" and typeof(p4.Destroy) ~= "function" then
        error("Object does not have a Destroy method.");
    end;

    table.insert(p3._toClean, p4);
end;

function u1.Destroy(p5) -- Line: 51
    for _, v in ipairs(p5._toClean) do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        else
            v:Destroy();
        end;
    end;
end;

u1.Clean = u1.Destroy;

return u1;