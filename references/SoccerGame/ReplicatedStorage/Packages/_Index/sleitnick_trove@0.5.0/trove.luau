  

local u1 = newproxy();
local u2 = newproxy();
local RunService = game:GetService("RunService");

local function GetObjectCleanupFunction(p3, p4) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v5 = typeof(p3);

    if v5 == "function" then
        return u1;
    end;

    if v5 == "thread" then
        return u2;
    end;

    if p4 then
        return p4;
    end;

    if v5 == "Instance" then
        return "Destroy";
    end;

    if v5 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v5 == "table" then
        if typeof(p3.Destroy) == "function" then
            return "Destroy";
        end;

        if typeof(p3.Disconnect) == "function" then
            return "Disconnect";
        end;
    end;

    error("Failed to get cleanup function for object " .. v5 .. ": " .. tostring(p3), 3);
end;

local function AssertPromiseLike(p6) -- Line: 34
    if type(p6) ~= "table" or (type(p6.getStatus) ~= "function" or (type(p6.finally) ~= "function" or type(p6.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;
end;

local u7 = {};
u7.__index = u7;

function u7.new() -- Line: 57
    -- upvalues: u7 (copy)
    local v8 = setmetatable({}, u7);
    v8._objects = {};
    v8._cleaning = false;

    return v8;
end;

function u7.Extend(p9) -- Line: 83
    -- upvalues: u7 (copy)
    if p9._cleaning then
        error("Cannot call trove:Extend() while cleaning", 2);
    end;

    return p9:Construct(u7);
end;

function u7.Clone(p10: table, p11: userdata) -- Line: 94
    if p10._cleaning then
        error("Cannot call trove:Clone() while cleaning", 2);
    end;

    return p10:Add(p11:Clone());
end;

function u7.Construct(p12, p13, ...) -- Line: 134
    if p12._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v14 = nil;
    local v15 = type(p13);

    if v15 == "table" then
        v14 = p13.new(...);
    elseif v15 == "function" then
        v14 = p13(...);
    end;

    return p12:Add(v14);
end;

function u7.Connect(p16, p17, p18) -- Line: 163
    if p16._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p16:Add(p17:Connect(p18));
end;

function u7.BindToRenderStep(p19: table, u20: string, p21: number, p22: function) -- Line: 183
    -- upvalues: RunService (copy)
    if p19._cleaning then
        error("Cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u20, p21, p22);
    p19:Add(function() -- Line: 188
        -- upvalues: RunService (ref), u20 (copy)
        RunService:UnbindFromRenderStep(u20);
    end);
end;

function u7.AddPromise(u23, u24) -- Line: 216
    if u23._cleaning then
        error("Cannot call trove:AddPromise() while cleaning", 2);
    end;

    if type(u24) ~= "table" or (type(u24.getStatus) ~= "function" or (type(u24.finally) ~= "function" or type(u24.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;

    if u24:getStatus() == "Started" then
        u24:finally(function() -- Line: 222
            -- upvalues: u23 (copy), u24 (copy)
            if u23._cleaning then
                return;
            end;

            u23:_findAndRemoveFromObjects(u24, false);
        end);
        u23:Add(u24, "cancel");
    end;

    return u24;
end;

function u7.Add(p25: table, p26: any, p27: string?) -- Line: 281
    -- upvalues: GetObjectCleanupFunction (copy)
    if p25._cleaning then
        error("Cannot call trove:Add() while cleaning", 2);
    end;

    local v28 = { p26, (GetObjectCleanupFunction(p26, p27)) };
    table.insert(p25._objects, v28);

    return p26;
end;

function u7.Remove(p29, p30) -- Line: 300
    if p29._cleaning then
        error("Cannot call trove:Remove() while cleaning", 2);
    end;

    return p29:_findAndRemoveFromObjects(p30, true);
end;

function u7.Clean(p31) -- Line: 313
    if p31._cleaning then
        return;
    end;

    p31._cleaning = true;

    for _, v in p31._objects do
        p31:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p31._objects);
    p31._cleaning = false;
end;

function u7._findAndRemoveFromObjects(p32: table, p33: any, p34: boolean) -- Line: 325
    local _objects = p32._objects;

    for i, v in ipairs(_objects) do
        if v[1] == p33 then
            local v35 = #_objects;
            _objects[i] = _objects[v35];
            _objects[v35] = nil;

            if p34 then
                p32:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u7._cleanupObject(p36, p37, p38) -- Line: 341
    -- upvalues: u1 (copy), u2 (copy)
    if p38 == u1 then
        p37();

        return;
    end;

    if p38 == u2 then
        coroutine.close(p37);

        return;
    end;

    p37[p38](p37);
end;

function u7.AttachToInstance(u39: table, p40: userdata) -- Line: 364
    if u39._cleaning then
        error("Cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p40:IsDescendantOf(game) then
        error("Instance is not a descendant of the game hierarchy", 2);
    end;

    return u39:Connect(p40.Destroying, function() -- Line: 370
        -- upvalues: u39 (copy)
        u39:Destroy();
    end);
end;

function u7.Destroy(p41) -- Line: 378
    p41:Clean();
end;

return u7;