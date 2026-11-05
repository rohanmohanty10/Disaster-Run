  

 

local u1 = newproxy();
local u2 = newproxy();
local RunService = game:GetService("RunService");

local function GetObjectCleanupFunction(p3, p4) -- Line: 12
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

local function AssertPromiseLike(p6) -- Line: 37
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

    return v8;
end;

function u7.Extend(p9) -- Line: 83
    -- upvalues: u7 (copy)
    return p9:Construct(u7);
end;

function u7.Clone(p10, p11) -- Line: 92
    return p10:Add(p11:Clone());
end;

function u7.Construct(p12, p13, ...) -- Line: 130
    local v14 = nil;
    local v15 = type(p13);

    if v15 == "table" then
        v14 = p13.new(...);
    elseif v15 == "function" then
        v14 = p13(...);
    end;

    return p12:Add(v14);
end;

function u7.Connect(p16, p17, p18) -- Line: 157
    return p16:Add(p17:Connect(p18));
end;

function u7.BindToRenderStep(p19, u20, p21, p22) -- Line: 175
    -- upvalues: RunService (copy)
    RunService:BindToRenderStep(u20, p21, p22);
    p19:Add(function() -- Line: 177
        -- upvalues: RunService (ref), u20 (copy)
        RunService:UnbindFromRenderStep(u20);
    end);
end;

function u7.AddPromise(u23, u24) -- Line: 206
    if type(u24) ~= "table" or (type(u24.getStatus) ~= "function" or (type(u24.finally) ~= "function" or type(u24.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;

    if u24:getStatus() == "Started" then
        u24:finally(function() -- Line: 209
            -- upvalues: u23 (copy), u24 (copy)
            return u23:_findAndRemoveFromObjects(u24, false);
        end);
        u23:Add(u24, "cancel");
    end;

    return u24;
end;

function u7.Add(p25, p26, p27) -- Line: 266
    -- upvalues: GetObjectCleanupFunction (copy)
    local v28 = GetObjectCleanupFunction(p26, p27);

    if p25.DestroyPartsAddedAfter then
        p25:_cleanupObject(p26, v28);

        return p26;
    end;

    table.insert(p25._objects, { p26, v28 });

    return p26;
end;

function u7.Remove(p29, p30, p31) -- Line: 287
    return p29:_findAndRemoveFromObjects(p30, not p31);
end;

function u7.Clean(p32) -- Line: 297
    for _, v in ipairs(p32._objects) do
        p32:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p32._objects);
end;

function u7._findAndRemoveFromObjects(p33, p34, p35) -- Line: 305
    local _objects = p33._objects;

    for i, v in ipairs(_objects) do
        if v[1] == p34 then
            local v36 = #_objects;
            _objects[i] = _objects[v36];
            _objects[v36] = nil;

            if p35 then
                p33:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u7._cleanupObject(p37, p38, p39) -- Line: 322
    -- upvalues: u1 (copy), u2 (copy), RunService (copy)
    if p39 == u1 then
        xpcall(p38, function(p40) -- Line: 325
            warn(p40, "\n", debug.traceback());
        end);

        return;
    end;

    if p39 == u2 then
        if coroutine.status(p38) == "suspended" then
            coroutine.close(p38);
        end;
    else
        if not p38[p39] then
            if RunService:IsStudio() then
                warn(debug.traceback((typeof(p38))));
            end;

            return;
        end;

        p38[p39](p38);
    end;
end;

function u7.AttachToInstance(u41, u42) -- Line: 353
    local v43 = u42:IsDescendantOf(game);
    assert(v43, "Instance is not a descendant of the game hierarchy");

    return u41:Connect(u42.AncestryChanged, function() -- Line: 355
        -- upvalues: u42 (copy), u41 (copy)
        if not u42.Parent then
            u41:Destroy();
        end;
    end);
end;

function u7.Destroy(p44) -- Line: 369
    p44:Clean();
end;

return u7;