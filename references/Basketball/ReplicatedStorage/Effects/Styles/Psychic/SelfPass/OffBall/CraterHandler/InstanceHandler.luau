 
 

local u1 = {};
u1.__index = u1;
local InstanceCache = require(script:WaitForChild("InstanceCache"));

local function _(p2, p3) -- Line: 9
    local Instance_new_ret = Instance.new(p2);

    for i, v in next, p3 do
        if i ~= "Parent" and Instance_new_ret[i] ~= nil then
            Instance_new_ret[i] = v;
        end;
    end;

    Instance_new_ret.Parent = p3.Parent or nil;

    return Instance_new_ret;
end;

function u1.new(p4, ...) -- Line: 21
    -- upvalues: InstanceCache (copy), u1 (copy)
    local v5 = InstanceCache.new(p4, ...);
    u1[p4.Name] = v5;
end;

function u1.getInstance(p6) -- Line: 26
    -- upvalues: u1 (copy)
    local v7 = u1[p6] and u1[p6]:GetObject();

    return v7;
end;

function u1.returnInstance(p8, p9) -- Line: 29
    -- upvalues: u1 (copy)
    local v10 = u1[p8] and u1[p8]:ReturnObject(p9);

    return v10;
end;

return u1;