  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local Lottery = require(ReplicatedStorage.Shared.Functions.Lottery);
local u1 = {
    Odds = { { "5", 8 }, { "2", 8.5 }, { "1", 15 }, { "6", 30 }, { "3", 54 }, { "4", 1.5 } }
};

function u1.Roll(p2) -- Line: 17
    -- upvalues: TableUtil (copy), u1 (copy), Lottery (copy)
    local v3 = TableUtil.Copy(u1.Odds);

    return Lottery(unpack(v3));
end;

return u1;