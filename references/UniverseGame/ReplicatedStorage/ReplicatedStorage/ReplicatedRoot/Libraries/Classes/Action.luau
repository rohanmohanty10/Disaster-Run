  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = {};
u1.__index = u1;
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local Signal = require(Core.ReplicatedLibraries.Classes.Signal);
local Promise = require(Core.ReplicatedLibraries.Classes.Promise);
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local u2 = { "Initialized", "Activated", "Deactivated", "Ended", "Completed", "Cancelled" };

function u1.new(p3, ...) -- Line: 13
    -- upvalues: u1 (copy), Trove (copy), u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u1);
    v4.Data = p3 or {};
    v4.Name = v4.Data.Name or "Action";
    v4.Collector = Trove.new();
    v4._Initialized = false;
    v4._Calls = {};

    for _, v in pairs(u2) do
        v4[v] = v4.Collector:Construct(Signal);
    end;

    return v4;
end;

function u1.Init(u5, ...) -- Line: 32
    -- upvalues: Promise (copy)
    if u5._Initialized == true then
        return;
    end;

    u5._Initialized = true;
    Promise.try(function() -- Line: 39
        -- upvalues: u5 (copy)
        u5:_Callback("Init");
    end):catch(warn):await();
    u5.Collector:Add(function() -- Line: 43
        -- upvalues: Promise (ref), u5 (copy)
        Promise.try(function() -- Line: 44
            -- upvalues: u5 (ref)
            u5:_Callback("Destroyed");
        end):catch(warn);
    end);
    u5.Initialized:Fire();
end;

function u1._Callback(p6, p7, ...) -- Line: 52
    local v8 = p6.Data[p7];

    if typeof(v8) == "function" then
        return v8(p6, ...);
    end;

    if typeof(v8) == "table" then
        local v9 = table.pack(...);

        for _, v in pairs(v8) do
            v9 = table.pack(v(table.unpack(v9)));
        end;

        return table.unpack(v9);
    end;
end;

function u1._Activate(p10, p11, ...) -- Line: 65
    return p10:_Callback("Activate", p11, ...);
end;

function u1._Deactivate(p12, p13, ...) -- Line: 69
    return p12:_Callback("Deactivate", p13, ...);
end;

function u1._Cancel(p14, p15, ...) -- Line: 73
    return p14:_Callback("Cancel", p15, ...);
end;

function u1.GetCalls(p16) -- Line: 77
    return p16._Calls;
end;

function u1.IsRunning(p17) -- Line: 81
    for _, v in pairs(p17._Calls) do
        if v:IsRunning() then
            return true;
        end;
    end;

    return false;
end;

function u1.IsActive(p18) -- Line: 90
    for _, v in pairs(p18._Calls) do
        if v:IsActive() then
            return true;
        end;
    end;

    return false;
end;

function u1.Activate(u19, p20, ...) -- Line: 99
    -- upvalues: TableUtil (copy), Promise (copy)
    local u21 = TableUtil.Reconcile(p20 or {}, {
        Running = true,
        Active = true,
        Promise = nil,
        Arguments = {},
        Collector = u19.Collector:Extend()
    });

    function u21.GetAction(p22) -- Line: 108
        -- upvalues: u19 (copy)
        return u19;
    end;

    function u21.IsRunning(p23) -- Line: 112
        return p23.Running == true;
    end;

    function u21.IsActive(p24) -- Line: 116
        return p24.Active == true;
    end;

    function u21.Deactivate(u25, ...) -- Line: 120
        -- upvalues: u19 (copy), Promise (ref)
        if u25.Active == true then
            u25.Active = false;
            u19.Deactivated:Fire(u25, ...);

            return Promise.try(function(...) -- Line: 128
                -- upvalues: u19 (ref), u25 (copy)
                return u19:_Deactivate(u25, ...);
            end):catch(warn);
        end;
    end;

    function u21.Cancel(u26, ...) -- Line: 133
        -- upvalues: u19 (copy), Promise (ref)
        if u26.Running == true then
            u19.Cancelled:Fire(u26, ...);

            return Promise.try(function(...) -- Line: 140
                -- upvalues: u19 (ref), u26 (copy)
                return u19:_Cancel(u26, ...);
            end):finallyCall(function(...) -- Line: 142
                -- upvalues: u26 (copy)
                if u26.Promise then
                    u26.Promise:cancel();
                end;
            end):catch(warn);
        end;
    end;

    function u21.Destroy(p27) -- Line: 149
        -- upvalues: u19 (copy)
        local v28 = table.find(u19._Calls, p27);

        if v28 then
            table.remove(u19._Calls, v28);
        end;

        p27.Collector:Destroy();
    end;

    if u19._NewCall then
        u21 = u19:_NewCall(u21) or u21;
    end;

    table.insert(u19._Calls, u21);
    u21.Promise = Promise.try(function(...) -- Line: 164
        -- upvalues: u19 (copy), u21 (ref)
        u19.Activated:Fire(u21);

        return u19:_Activate(u21, ...);
    end):andThen(function(...) -- Line: 167
        -- upvalues: u19 (copy), u21 (ref)
        u19.Completed:Fire(u21, ...);
    end):finally(function() -- Line: 169
        -- upvalues: u21 (ref), u19 (copy)
        u21.Active = false;
        u21.Running = false;
        u19.Ended:Fire(u21);
        u21:Destroy();
    end):catch(warn);

    return u21;
end;

function u1.Deactivate(p29, ...) -- Line: 179
    for _, v in pairs(p29._Calls) do
        if v.Active == true then
            v:Deactivate();
        end;
    end;
end;

function u1.Cancel(p30, ...) -- Line: 187
    for _, v in pairs(p30._Calls) do
        if v.Running == true then
            v:Cancel();
        end;
    end;
end;

function u1.Destroy(p31) -- Line: 195
    if table.isfrozen(p31) then
        return;
    end;

    if p31.Collector then
        p31.Collector:Destroy();
    end;

    table.clear(p31);
    table.freeze(p31);
end;

return u1;