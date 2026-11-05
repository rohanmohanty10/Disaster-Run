  

 

return function(p1) -- Line: 12
    local u2 = {};
    u2.__index = u2;

    function u2.new() -- Line: 16
        -- upvalues: u2 (copy)
        local v3 = setmetatable({
            Type = "EffectPrefab",
            _internal = {}
        }, u2);

        getmetatable(v3).__call = function(p4, p5) -- Line: 19
            for i, v in pairs(p5) do
                p4._internal[i] = v;
            end;

            return p4;
        end;

        return v3;
    end;

    return u2;
end;