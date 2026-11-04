  

local RunService = game:GetService("RunService");
local Freeze = require(script.Parent.Parent.Parent.Freeze);
require(script.Parent.Types);

local function getPathTable(p1) -- Line: 9
    if type(p1) == "table" then
        return p1;
    end;

    return type(p1) ~= "string" and { p1 } or string.split(p1, ".");
end;

local function getPathString(p2) -- Line: 19
    if type(p2) == "string" then
        return p2;
    end;

    if type(p2) == "table" then
        return table.concat(p2, ".");
    end;

    return tostring(p2);
end;

local function getValue(p3) -- Line: 29
    -- upvalues: Freeze (copy)
    if p3 == Freeze.None or p3 == "\0" then
        return nil;
    end;

    return p3;
end;

local function safeCancelThread(p4: thread) -- Line: 33
    if coroutine.status(p4) ~= "dead" then
        task.cancel(p4);
    end;
end;

local table_freeze = table.freeze;
local v5 = {
    SerializedNone = "\0"
};
local v6 = RunService:IsStudio() and not RunService:IsRunning();
v5.ShouldMock = v6;
v5.getValue = getValue;
v5.getPathTable = getPathTable;
v5.getPathString = getPathString;
v5.safeCancelThread = safeCancelThread;

return table_freeze(v5);