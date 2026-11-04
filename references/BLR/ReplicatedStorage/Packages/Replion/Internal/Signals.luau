  

local Freeze = require(script.Parent.Parent.Parent.Freeze);
local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Types);
local Utils = require(script.Parent.Utils);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 19
    -- upvalues: u1 (copy)
    return setmetatable({
        _containers = {}
    }, u1);
end;

function u1._getContainer(p2: any, p3: string) -- Line: 25
    assert(p2._containers, "You\'re trying to use a Replion that has been destroyed!");
    local v4 = p2._containers[p3];

    if not v4 then
        v4 = {};
        p2._containers[p3] = v4;
    end;

    return v4;
end;

function u1.Connect(p5: any, p6: string, p7: any, p8: function) -- Line: 38
    local v9 = p5:Get(p6, p7);

    return assert(v9, "Signal does not exist!"):Connect(p8);
end;

function u1.Get(p10: any, p11: string, p12: any, p13: boolean?) -- Line: 44
    -- upvalues: Utils (copy), Signal (copy)
    local v14 = p10:_getContainer(p11);
    local v15 = nil;

    for _, v in Utils.getPathTable(p12) do
        local v16 = v14[v];

        if not v16 then
            v16 = {};
            v14[v] = v16;
        end;

        v15 = v16.__signal;
        v14 = v16;
    end;

    if not (v15 or p13 ~= nil and not p13) then
        v15 = Signal.new();
        v14.__signal = v15;
    end;

    return v15;
end;

function u1.FireEvent(p17: any, p18: string, p19: any, ...) -- Line: 71
    local v20 = p17:Get(p18, p19);

    if v20 then
        v20:Fire(...);
    end;
end;

function u1.FireChange(p21, p22, p23, p24) -- Line: 78
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p22);

    for i = #PathTable, 1, -1 do
        local v25 = Freeze.List.slice(PathTable, 1, i);
        local v26 = p21:Get("onChange", v25, false);
        local In = Freeze.Dictionary.getIn(p23, v25);
        local In2 = Freeze.Dictionary.getIn(p24, v25);

        if v26 then
            v26:Fire(In, In2);
        end;

        local v27;

        if i > 1 then
            local v28 = p21:Get("onDescendantChange", Freeze.List.slice(PathTable, 1, i - 1), false);

            if v28 then
                v28:Fire(v25, In, In2);
                v27 = i;
            else
                v27 = i;
            end;
        else
            v27 = i;
        end;
    end;
end;

function u1.Destroy(p29) -- Line: 102
    assert(p29._containers, "This Replion has already been destroyed!");

    local function destroySignals(p30: table) -- Line: 105
        -- upvalues: destroySignals (copy)
        if p30.__signal then
            p30.__signal:Destroy();
            p30.__signal = nil;
        end;

        for _, v in p30 do
            destroySignals(v);
        end;
    end;

    for _, v in p29._containers do
        if v.__signal then
            v.__signal:Destroy();
            v.__signal = nil;
        end;

        for _, v2 in v do
            destroySignals(v2);
        end;
    end;

    p29._containers = nil;
end;

return u1;