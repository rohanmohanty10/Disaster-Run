  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);

function AddStat(u1: any, u2: any, p3: number)
    -- upvalues: TableUtil (copy)
    local function GetValue() -- Line: 8
        -- upvalues: TableUtil (ref), u1 (copy), u2 (copy)
        return TableUtil.FindPathOnArray(u1.Data, u2) or 0;
    end;

    local v4 = TableUtil.FindPathOnArray(u1.Data, u2) or 0;
    u1:SetValue(u2, v4 + p3);

    return v4 ~= (TableUtil.FindPathOnArray(u1.Data, u2) or 0);
end;

function AddStats(p5: any, p6: table)
    for i, v in pairs(p6) do
        task.spawn(AddStat, p5, i, v);
    end;
end;

return {
    AddStat = AddStat,
    AddStats = AddStats
};