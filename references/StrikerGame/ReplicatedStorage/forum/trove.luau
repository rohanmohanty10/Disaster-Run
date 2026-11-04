 

 

local RunService = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local table_freeze_ret = table.freeze({ "Destroy", "Disconnect", "destroy", "disconnect" });

local function GetObjectCleanupFunction(p3: any, p4: string?) -- Line: 126
    -- upvalues: u1 (copy), u2 (copy), table_freeze_ret (copy)
    local v5 = typeof(p3);

    if v5 == "function" then
        return u1;
    end;

    if v5 == "thread" then
        return u2;
    end;

    if typeof(p4) == "string" then
        return p4;
    end;

    if v5 == "Instance" then
        return "Destroy";
    end;

    if v5 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v5 == "table" then
        for _, v in table_freeze_ret do
            if typeof(p3[v]) == "function" then
                return v;
            end;
        end;
    end;

    error(`failed to get cleanup function for object {v5}: {p3}`, 3);
end;

local function AssertPromiseLike(p6) -- Line: 155
    if typeof(p6) ~= "table" or (typeof(p6.getStatus) ~= "function" or (typeof(p6.finally) ~= "function" or typeof(p6.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
end;

local function TroveWarn(p7: string) -- Line: 166
    warn((`[TROVE]: {debug.traceback(p7)}`));
end;

local u8 = {};
u8.__index = u8;

function u8.new() -- Line: 186
    -- upvalues: u8 (copy)
    local v9 = setmetatable({}, u8);
    v9._objects = {};
    v9._cleaning = false;

    return v9;
end;

function u8.Add(p10: any, p11: any, p12: string?, ...) -- Line: 245
    -- upvalues: GetObjectCleanupFunction (copy)
    if p11 then
        if p10._cleaning then
            error("cannot call trove:Add() while cleaning", 2);
        end;

        local v13 = { p11, GetObjectCleanupFunction(p11, p12), ... };
        table.insert(p10._objects, v13);

        return p11;
    end;
end;

function u8.Clone(p14: any, p15: userdata) -- Line: 269
    if p14._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;

    return p14:Add(p15:Clone());
end;

function u8.Construct(p16, p17, ...) -- Line: 312
    if p16._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v18 = nil;
    local v19 = typeof(p17);

    if v19 == "table" then
        v18 = p17.new(...);
    elseif v19 == "function" then
        v18 = p17(...);
    elseif v19 == "Instance" then
        v18 = p17:Clone();
    end;

    return p16:Add(v18);
end;

function u8.Connect(p20: any, p21: table, p22: function) -- Line: 347
    if p20._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p20:Add(p21:Connect(p22));
end;

function u8.BindToRenderStep(p23: any, u24: string, p25: number, p26: function) -- Line: 370
    -- upvalues: RunService (copy)
    if p23._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u24, p25, p26);
    p23:Add(function() -- Line: 377
        -- upvalues: RunService (ref), u24 (copy)
        RunService:UnbindFromRenderStep(u24);
    end);
end;

function u8.AddPromise(u27: any, u28: table) -- Line: 407
    if u27._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;

    if typeof(u28) ~= "table" or (typeof(u28.getStatus) ~= "function" or (typeof(u28.finally) ~= "function" or typeof(u28.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;

    if u28:getStatus() == "Started" then
        u28:finally(function() -- Line: 414
            -- upvalues: u27 (copy), u28 (copy)
            if u27._cleaning then
                return;
            end;

            u27:_findAndRemoveFromObjects(u28, false);
        end);
        u27:Add(u28, "cancel");
    end;

    return u28;
end;

function u8.Remove(p29, p30) -- Line: 439
    if p29._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;

    return p29:_findAndRemoveFromObjects(p30, true);
end;

function u8.Pop(p31, p32) -- Line: 459
    if p31._cleaning then
        error("cannot call trove:Pop() while cleaning", 2);
    end;

    return p31:_findAndRemoveFromObjects(p32, false);
end;

function u8.Extend(p33) -- Line: 488
    -- upvalues: u8 (copy)
    if p33._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;

    return p33:Construct(u8);
end;

function u8.IsEmpty(p34) -- Line: 507
    return #p34._objects == 0;
end;

function u8.Clean(p35) -- Line: 523
    if p35._cleaning then
        return;
    end;

    p35._cleaning = true;

    for _, v in ipairs(p35._objects) do
        p35:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p35._objects);
    p35._cleaning = false;
end;

function u8.WrapClean(u36) -- Line: 565
    return function() -- Line: 566
        -- upvalues: u36 (copy)
        u36:Clean();
    end;
end;

function u8._findAndRemoveFromObjects(p37: any, p38: any, p39: boolean) -- Line: 571
    local _objects = p37._objects;

    for i, v in _objects do
        if v[1] == p38 then
            local v40 = #_objects;
            _objects[i] = _objects[v40];
            _objects[v40] = nil;

            if p39 then
                p37:_cleanupObject(table.unpack(v));
            end;

            return true;
        end;
    end;

    return false;
end;

function u8._cleanupObject(p41: any, p42: any, p43: string?, ...) -- Line: 591
    -- upvalues: u1 (copy), TroveWarn (copy), u2 (copy)
    if p43 == u1 then
        xpcall(p42, TroveWarn, ...);

        return;
    end;

    if p43 == u2 then
        pcall(task.cancel, p42);

        return;
    end;

    if p43 == "Destroy" and (typeof(p42) == "Instance" and p42:IsA("AnimationTrack")) then
        p42:Stop();
    end;

    p42[p43](p42, ...);
end;

function u8.AttachToInstance(u44: any, p45: userdata) -- Line: 634
    if u44._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p45:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;

    return u44:Add(p45.AncestryChanged:Once(function() -- Line: 641
        -- upvalues: u44 (copy)
        u44:Destroy();
    end));
end;

function u8.Destroy(p46) -- Line: 656
    p46:Clean();
end;

return {
    new = u8.new
};