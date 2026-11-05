  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 30
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._Patches = {};
    v2._Result = {};
    v2._Recompute = false;

    return v2;
end;

function u1.Patch(p3, p4, p5) -- Line: 40
    -- upvalues: TableUtil (copy)
    local v6 = p5 or {};
    local v7 = p3._Patches[p4] or {};
    local v8;

    if v6.Reconcile == false then
        v8 = v6.Values and (TableUtil.Copy(v6.Values, true) or {}) or {};
    else
        v8 = TableUtil.Reconcile(v6.Values or {}, v7.Values or {});
    end;

    v7.Values = v8;
    v7.Priority = v6.Priority or (v7.Priority or 0);
    local v9;

    if v6.Priority then
        v9 = v6.Priority;
    elseif v7.Multiply then
        v9 = v7.Multiply;
    else
        v9 = false;
    end;

    v7.Multiply = v9;
    p3._Recompute = true;

    return v7;
end;

function u1.Get(p10, p11) -- Line: 56
    local v12 = p10._Patches[p11];

    return v12 and v12.Values or {};
end;

function u1.Clear(p13, p14) -- Line: 61
    if p13._Patches[p14] then
        p13._Patches[p14] = nil;
        p13._Recompute = true;
    end;
end;

function u1.Compute(p15) -- Line: 69
    if not p15._Recompute then
        return p15._Result;
    end;

    local v16 = {};
    local v17 = {};

    for _, v in pairs(p15._Patches) do
        table.insert(v16, v);
    end;

    table.sort(v16, function(p18, p19) -- Line: 81
        return p18.Priority < p19.Priority;
    end);

    local function Apply(p20, p21, p22, p23) -- Line: 85
        -- upvalues: Apply (copy)
        local v24 = p21[p23];
        local v25 = p22[p23];

        if typeof(v24) == "table" and typeof(v25) == "table" then
            for i, _ in pairs(v24) do
                Apply(p20, v24, v25, i);
            end;

            return;
        end;

        if typeof(v24) ~= "number" or typeof(v25) ~= "number" then
            p22[p23] = v24;

            return;
        end;

        if p20.Multiply then
            p22[p23] = p22[p23] * v24;

            return;
        end;

        p22[p23] = p22[p23] + v24;
    end;

    for _, v in pairs(v16) do
        for i, _ in pairs(v) do
            Apply(v, v.Values, v17, i);
        end;
    end;

    p15._Result = v17;
    p15._Recompute = false;

    return v17;
end;

function u1.Destroy(p26) -- Line: 116
    if table.isfrozen(p26) then
        return;
    end;

    table.clear(p26);
    table.freeze(p26);
end;

return u1;