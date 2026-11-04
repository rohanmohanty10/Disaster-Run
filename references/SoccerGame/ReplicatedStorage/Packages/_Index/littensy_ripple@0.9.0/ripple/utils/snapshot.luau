  

local HttpService = game:GetService("HttpService");
require(script.Parent.Parent.types);
local createMotion = require(script.Parent.Parent.createMotion);

local function createSnapshot(p1: any, p2: number?) -- Line: 9
    -- upvalues: createMotion (copy), HttpService (copy)
    local v3 = createMotion(0);
    v3:to(p1);
    local v4 = {};

    for i = 1, p2 or 20 do
        local v5 = v3:step(0.1);

        if v5 < 1 then
            v5 = math.floor(v5 * 100) / 100;
        elseif v5 > 1 then
            v5 = math.ceil(v5 * 100) / 100;
        end;

        table.insert(v4, v5);

        if v5 == 1 then
            break;
        end;

        local _ = i;
    end;

    return HttpService:JSONEncode(v4), v3;
end;

return {
    createSnapshot = createSnapshot,

    testSnapshot = function(p6: any, p7: string) -- Line: 33, Name: testSnapshot
        -- upvalues: createSnapshot (copy)
        local v8, v9 = createSnapshot(p6, select(2, string.gsub(p7, ",", ",")) + 1);

        if v8 ~= p7 then
            error(`Snapshot does not match expected value.\n\nExpected:\n{p7}\n\nActual:\n{v8}`, 2);
        end;

        return v9;
    end
};