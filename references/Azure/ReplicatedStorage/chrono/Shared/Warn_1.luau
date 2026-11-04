 
 

local Config = require(script.Parent.Config);

local function checkLevel(p1) -- Line: 5
    -- upvalues: Config (copy)
    local v2 = {
        NONE = 0,
        LOW = 1,
        MEDIUM = 2,
        HIGH = 3
    };
    local v3 = v2[Config._GetConfig("WARNING_SEVERITY")] or 0;

    if v3 == 0 then
        return false;
    end;

    return v3 <= (v2[p1] or 0);
end;

return setmetatable({}, {
    __index = function(p4, p5) -- Line: 22, Name: __index
        -- upvalues: Config (copy)
        local v6 = p5:upper();
        local v7 = {
            NONE = 0,
            LOW = 1,
            MEDIUM = 2,
            HIGH = 3
        };
        local v8 = v7[Config._GetConfig("WARNING_SEVERITY")] or 0;
        local v9;

        if v8 == 0 then
            v9 = false;
        else
            v9 = v8 <= (v7[v6] or 0);
        end;

        return not v9 and function() -- Line: 24
        end or warn;
    end
});