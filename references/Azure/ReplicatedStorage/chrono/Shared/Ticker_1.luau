 
 

game:GetService("RunService");
local u1 = {};

local function popSwap(p2, p3, p4) -- Line: 6
    local v5 = #p2;

    if p4 ~= v5 then
        local v6 = p2[v5];
        p2[p4] = v6;
        v6._tickerIndex = p4;
    end;

    p2[v5] = nil;
end;

require(script.Parent.Types);
local Warn = require(script.Parent.Warn);
local u7 = 0;

function u1._IncrementGlobalTick() -- Line: 23
    -- upvalues: u7 (ref)
    u7 = u7 + 1;
end;

function u1.GetGlobalTick() -- Line: 27
    -- upvalues: u7 (ref)
    return u7;
end;

function u1.new(p8) -- Line: 31
    return {
        tickedHalf = false,
        lastTicked = 0,
        tickedFrame = 0,
        dt = 0,
        halfdt = 0,
        tickHalfRate = p8.TICK_RATE * 2,
        tickRate = p8.TICK_RATE,
        objects = {},
        callbacks = {},
        config = p8
    };
end;

function u1.AddCallback(p9: any, p10: function) -- Line: 47
    table.insert(p9.callbacks, p10);
end;

function u1.RemoveCallback(p11: any, p12: function) -- Line: 51
    local table_find_ret = table.find(p11.callbacks, p12);

    if table_find_ret then
        table.remove(p11.callbacks, table_find_ret);
    end;
end;

function u1.Add(p13, p14) -- Line: 58
    table.insert(p13.objects, p14);
    p14._ticker = p13;
    p14._tickerIndex = #p13.objects;
end;

function u1.Remove(p15, p16) -- Line: 64
    -- upvalues: Warn (copy)
    local _tickerIndex = p16._tickerIndex;

    if not _tickerIndex then
        Warn.low("Ticker.remove called on object not in ticker", p16.id);

        return;
    end;

    local objects = p15.objects;
    local v17 = #objects;

    if _tickerIndex ~= v17 then
        local v18 = objects[v17];
        objects[_tickerIndex] = v18;
        v18._tickerIndex = _tickerIndex;
    end;

    objects[v17] = nil;
    p16._ticker = nil;
    p16._tickerIndex = nil;
end;

function u1.move(p19, p20) -- Line: 77
    -- upvalues: u1 (copy)
    local _ticker = p19._ticker;

    if _ticker then
        u1.Remove(_ticker, p19);
    end;

    u1.Add(p20, p19);
end;

function u1.CheckUpdate(p21) -- Line: 85
    -- upvalues: u7 (ref)
    local v22 = os.clock() - p21.lastTicked;

    if p21.tickRate > v22 then
        return false;
    end;

    p21.lastTicked = os.clock();
    p21.tickedFrame = u7;
    p21.tickedHalf = not p21.tickedHalf;

    if p21.tickedHalf then
        p21.halfdt = v22 + p21.dt;
    else
        p21.halfdt = v22;
    end;

    p21.dt = v22;

    if #p21.callbacks > 0 then
        for _, v in p21.callbacks do
            v(p21, v22);
        end;
    end;

    return true;
end;

return u1;