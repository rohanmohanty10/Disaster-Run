  

local u1 = {};
local u2 = {};

function u1.ReportMetric(p3: table, p4: string, p5: number) -- Line: 31
    -- upvalues: u2 (copy)
    if not p4 then
        return;
    end;

    if typeof(p5) ~= "number" then
        return;
    end;

    local v6 = u2[p4];

    if not v6 then
        v6 = {};
        u2[p4] = v6;
    end;

    table.insert(v6, p5);
end;

function u1.ReadAndResetMetric(p7: table, p8: string) -- Line: 50
    -- upvalues: u2 (copy)
    local v9 = u2[p8];

    if not v9 then
        return {};
    end;

    local table_clone_ret = table.clone(v9);
    u2[p8] = {};

    return table_clone_ret;
end;

function u1.ReadAndResetAllMetrics(p10) -- Line: 64
    -- upvalues: u2 (copy), u1 (copy)
    local v11 = {};

    for i, _ in u2 do
        v11[i] = u1:ReadAndResetMetric(i);
    end;

    return v11;
end;

return u1;