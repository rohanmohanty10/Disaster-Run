  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);
local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;
local u3 = { "Initialized", "Fired", "Ended", "Completed", "Cancelled" };

function u1.new(p4) -- Line: 65
    -- upvalues: u1 (copy), Trove (copy), u3 (copy), Signal (copy)
    local v5 = p4 or {};
    local v6 = setmetatable({}, u1);
    v6.Data = v5 or {};
    v6.Name = typeof(v5.Name) == "string" and (v5.Name or "Action") or "Action";
    v6.Collector = Trove.new();
    v6._Callbacks = {};
    v6._Calls = {};
    v6._Initialized = false;

    for _, v in pairs(u3) do
        v6[v] = v6.Collector:Construct(Signal);
    end;

    return v6;
end;

function u1.newCall(p7, p8) -- Line: 85
    -- upvalues: u2 (copy)
    local v9 = setmetatable({}, u2);
    v9.Parameters = p8 or {};
    v9.Type = (p8 == nil or typeof(p8.Type) ~= "string") and "Fire" or (p8.Type or "Fire");
    v9.Arguments = (p8 == nil or typeof(p8.Arguments) ~= "table") and {} or (p8.Arguments or {});
    v9.Action = p7;
    v9.Collector = p7.Collector:Extend();
    v9.Result = {
        Running = false,
        Completed = false,
        Cancelled = false,
        Errored = false
    };
    v9.Promise = nil;
    v9.Action:RunCallback("PreCall", v9);
    table.insert(v9.Action._Calls, v9);

    return v9;
end;

function u1.Init(p10) -- Line: 110
    if p10._Initialized then
        return;
    end;

    p10._Initialized = true;
    p10:RunCallback("Init", p10);
    p10.Initialized:Fire();
end;

function u1.BindCallback(p11, p12, p13) -- Line: 120
    p11._Callbacks[p12] = p13;
end;

function u1.RunCallback(p14, p15, ...) -- Line: 124
    local v16 = p14._Callbacks[p15];

    if typeof(v16) == "function" then
        return v16(p14, ...);
    end;
end;

function u1.Fire(p17, p18) -- Line: 131
    -- upvalues: u1 (copy)
    local v19 = u1.newCall(p17, p18);
    v19:Run();

    return v19;
end;

function u1.GetCalls(p20) -- Line: 137
    return p20._Calls;
end;

function u1.IsRunning(p21) -- Line: 141
    for _, v in pairs(p21:GetCalls()) do
        if v.Result.Running == true then
            return true;
        end;
    end;

    return false;
end;

function u1.Destroy(p22) -- Line: 150
    if table.isfrozen(p22) then
        return;
    end;

    p22.Collector:Destroy();
    table.clear(p22);
    table.freeze(p22);
end;

function u2.IsRunning(p23) -- Line: 162
    return p23.Result and p23.Result.Running == true and true or false;
end;

function u2.Run(u24, ...) -- Line: 166
    -- upvalues: Promise (copy)
    u24.Promise = Promise.try(function(...) -- Line: 167
        -- upvalues: u24 (copy)
        u24.Result.Running = true;
        u24.Action.Fired:Fire(u24, ...);

        return u24.Action:RunCallback(u24.Type, u24, ...);
    end):andThen(function(...) -- Line: 171
        -- upvalues: u24 (copy)
        u24.Result.Completed = true;
        u24.Action.Completed:Fire(u24, ...);
    end):finally(function(...) -- Line: 174
        -- upvalues: u24 (copy)
        u24.Result.Running = false;
        u24.Action.Ended:Fire(u24, ...);
        u24:Destroy();
    end, ...):catch(function(p25) -- Line: 178
        -- upvalues: u24 (copy)
        warn(p25);

        if u24 and u24.Result then
            u24.Result.Errored = true;
        end;
    end);

    return u24.Promise;
end;

function u2.Cancel(u26) -- Line: 187
    -- upvalues: Promise (copy)
    if u26.Result.Running == true then
        u26.Result.Running = false;
        u26.Result.Cancelled = true;
        u26.Action.Cancelled:Fire(u26);

        return Promise.try(function(...) -- Line: 197
            -- upvalues: u26 (copy)
            return u26.Action:RunCallback("Cancel", u26);
        end):finallyCall(function(...) -- Line: 199
            -- upvalues: u26 (copy)
            if u26.Promise then
                u26.Promise:Cancel();
            end;
        end):catch(warn);
    end;
end;

function u2.Destroy(u27) -- Line: 206
    if table.isfrozen(u27) then
        return;
    end;

    if u27.Action then
        local v28 = table.find(u27.Action._Calls, u27);

        if v28 ~= nil then
            table.remove(u27.Action._Calls, v28);
        end;
    end;

    if u27.Collector then
        u27.Collector:Destroy();
    end;

    task.defer(function() -- Line: 222
        -- upvalues: u27 (copy)
        table.clear(u27);
        table.freeze(u27);
    end);
end;

return u1;