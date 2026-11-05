  

 

local u1 = newproxy();
local u2 = newproxy();
local u3 = { "Destroy", "Disconnect", "destroy", "disconnect" };
local RunService = game:GetService("RunService");

local function GetObjectCleanupFunction(p4, p5) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = typeof(p4);

    if v6 == "function" then
        return u1;
    end;

    if v6 == "thread" then
        return u2;
    end;

    if p5 then
        return p5;
    end;

    if v6 == "Instance" then
        return "Destroy";
    end;

    if v6 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v6 == "table" then
        for _, v in u3 do
            if typeof(p4[v]) == "function" then
                return v;
            end;
        end;
    end;

    error("Failed to get cleanup function for object " .. v6 .. ": " .. tostring(p4), 3);
end;

local function AssertPromiseLike(p7) -- Line: 34
    if typeof(p7) ~= "table" or (typeof(p7.getStatus) ~= "function" or (typeof(p7.finally) ~= "function" or typeof(p7.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;
end;

local function AssertFutureLike(p8) -- Line: 45
    if typeof(p8) ~= "table" or (typeof(p8.Await) ~= "function" or (typeof(p8.After) ~= "function" or typeof(p8.Cancel) ~= "function")) then
        error("Did not receive a Future as an argument", 3);
    end;
end;

local u9 = {};
u9.__index = u9;

function u9.new() -- Line: 73
    -- upvalues: u9 (copy)
    local v10 = setmetatable({}, u9);
    v10._objects = {};
    v10._cleaning = false;

    return v10;
end;

function u9.Extend(p11) -- Line: 99
    -- upvalues: u9 (copy)
    if p11._cleaning then
        error("Cannot call trove:Extend() while cleaning", 2);
    end;

    return p11:Construct(u9);
end;

function u9.Clone(p12, p13) -- Line: 110
    if p12._cleaning then
        error("Cannot call trove:Clone() while cleaning", 2);
    end;

    return p12:Add(p13:Clone());
end;

function u9.Construct(p14, p15, ...) -- Line: 150
    if p14._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v16 = nil;
    local v17 = typeof(p15);

    if v17 == "table" then
        v16 = p15.new(...);
    elseif v17 == "function" then
        v16 = p15(...);
    end;

    return p14:Add(v16);
end;

function u9.Connect(p18, p19, p20) -- Line: 179
    if p18._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p18:Add(p19:Connect(p20));
end;

function u9.Once(u21, p22, u23) -- Line: 193
    if u21._cleaning then
        error("Cannot call trove:Once() while cleaning", 2);
    end;

    local u24 = nil;
    u24 = p22:Connect(function(...) -- Line: 198
        -- upvalues: u23 (copy), u24 (ref), u21 (copy)
        u23(...);
        u24:Disconnect();
        u21:_findAndRemoveFromObjects(u24, false);
    end);

    return u21:Add(u24);
end;

function u9.BindToRenderStep(p25, u26, p27, p28) -- Line: 219
    -- upvalues: RunService (copy)
    if p25._cleaning then
        error("Cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u26, p27, p28);
    p25:Add(function() -- Line: 224
        -- upvalues: RunService (ref), u26 (copy)
        RunService:UnbindFromRenderStep(u26);
    end);
end;

function u9.AddPromise(u29, u30) -- Line: 252
    if u29._cleaning then
        error("Cannot call trove:AddPromise() while cleaning", 2);
    end;

    if typeof(u30) ~= "table" or (typeof(u30.getStatus) ~= "function" or (typeof(u30.finally) ~= "function" or typeof(u30.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;

    if u30:getStatus() == "Started" then
        u30:finally(function() -- Line: 258
            -- upvalues: u29 (copy), u30 (copy)
            if u29._cleaning then
                return;
            end;

            u29:_findAndRemoveFromObjects(u30, false);
        end);
        u29:Add(u30, "cancel");
    end;

    return u30;
end;

function u9.AddFuture(u31, u32) -- Line: 292
    if u31._cleaning then
        error("Cannot call trove:AddFuture() while cleaning", 2);
    end;

    if typeof(u32) ~= "table" or (typeof(u32.Await) ~= "function" or (typeof(u32.After) ~= "function" or typeof(u32.Cancel) ~= "function")) then
        error("Did not receive a Future as an argument", 3);
    end;

    if u32:IsPending() then
        u32:After(function() -- Line: 298
            -- upvalues: u31 (copy), u32 (copy)
            if u31._cleaning then
                return;
            end;

            u31:_findAndRemoveFromObjects(u32, false);
        end);
        u31:Add(u32, "Cancel");
    end;

    return u32;
end;

function u9.Add(p33, p34, p35) -- Line: 357
    -- upvalues: GetObjectCleanupFunction (copy)
    if p33._cleaning then
        error("Cannot call trove:Add() while cleaning", 2);
    end;

    local v36 = { p34, (GetObjectCleanupFunction(p34, p35)) };
    table.insert(p33._objects, v36);

    return p34;
end;

function u9.Remove(p37, p38) -- Line: 377
    if p37._cleaning then
        error("Cannot call trove:Remove() while cleaning", 2);
    end;

    return p37:_findAndRemoveFromObjects(p38, true);
end;

function u9.Clean(p39) -- Line: 390
    if p39._cleaning then
        return;
    end;

    p39._cleaning = true;

    for _, v in p39._objects do
        p39:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p39._objects);
    p39._cleaning = false;
end;

function u9._findAndRemoveFromObjects(p40, p41, p42) -- Line: 402
    local _objects = p40._objects;

    for i, v in ipairs(_objects) do
        if v[1] == p41 then
            local v43 = #_objects;
            _objects[i] = _objects[v43];
            _objects[v43] = nil;

            if p42 then
                p40:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u9._cleanupObject(p44, p45, p46) -- Line: 418
    -- upvalues: u1 (copy), u2 (copy)
    if p46 == u1 then
        p45();

        return;
    end;

    if p46 == u2 then
        pcall(task.cancel, p45);

        return;
    end;

    p45[p46](p45);
end;

function u9.AttachToInstance(u47, p48) -- Line: 441
    if u47._cleaning then
        error("Cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p48:IsDescendantOf(game) then
        error("Instance is not a descendant of the game hierarchy", 2);
    end;

    return u47:Connect(p48.Destroying, function() -- Line: 447
        -- upvalues: u47 (copy)
        u47:Destroy();
    end);
end;

function u9.IsCleaning(p49) -- Line: 453
    return p49._cleaning;
end;

function u9.Destroy(p50) -- Line: 460
    p50:Clean();
end;

return u9;