  

 

local HttpService = game:GetService("HttpService");
local Output = require(script.Parent.Output);

return {
    CreateUUID = function() -- Line: 8, Name: CreateUUID
        -- upvalues: HttpService (copy)
        return string.gsub(HttpService:GenerateGUID(false), "-", "");
    end,

    FromHex = function(p1) -- Line: 13, Name: FromHex
        return string.gsub(p1, "..", function(p2) -- Line: 15
            local v3 = tonumber(p2, 16);

            return string.char(v3);
        end);
    end,

    ToHex = function(p4) -- Line: 20, Name: ToHex
        -- upvalues: Output (copy)
        Output.fatalAssert(typeof(p4) == "string", (`ToHex takes string, got {p4}`));

        return string.gsub(p4, ".", function(p5) -- Line: 23
            return string.format("%02X", string.byte(p5));
        end);
    end,

    ToReadableHex = function(p6) -- Line: 28, Name: ToReadableHex
        -- upvalues: Output (copy)
        Output.fatalAssert(typeof(p6) == "string", (`ToReadableHex takes string, got {p6}`));

        return string.format(string.rep("%02X ", #p6), string.byte(p6, 1, -1));
    end
};