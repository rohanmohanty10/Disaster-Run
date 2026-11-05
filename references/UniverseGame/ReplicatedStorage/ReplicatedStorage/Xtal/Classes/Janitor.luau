  

 

local GetPromiseLibrary = require(script.GetPromiseLibrary);
local Symbol = require(script.Symbol);
local u1, u2 = GetPromiseLibrary();
local u3 = Symbol("IndicesReference");
local u4 = Symbol("LinkToInstanceIndex");
local u5 = {
    ClassName = "Janitor",
    CurrentlyCleaning = true,
    [u3] = nil
};
u5.__index = u5;
local u6 = {
    ["function"] = true,
    RBXScriptConnection = "Disconnect"
};

function u5.Is(p7) -- Line: 42
    -- upvalues: u5 (copy)
    local v8;

    if type(p7) == "table" then
        v8 = getmetatable(p7) == u5;
    else
        v8 = false;
    end;

    return v8;
end;

function u5.Add(p9, p10, p11, p12) -- Line: 106
    -- upvalues: u3 (copy), u6 (copy)
    if p12 then
        p9:Remove(p12);
        local v13 = p9[u3];

        if not v13 then
            v13 = {};
            p9[u3] = v13;
        end;

        v13[p12] = p10;
    end;

    local v14 = p11 or (u6[typeof(p10)] or "Destroy");

    if type(p10) ~= "function" and not p10[v14] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p10), tostring(v14), debug.traceback(nil, 2)));
    end;

    p9[p10] = v14;

    return p10;
end;

function u5.AddPromise(p15, u16) -- Line: 150
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return u16;
    end;

    if not u2.is(u16) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(u16), (tostring(u16))));
    end;

    if u16:getStatus() ~= u2.Status.Started then
        return u16;
    end;

    local v17 = newproxy(false);
    local v21 = p15:Add(u2.new(function(p18, p19, p20) -- Line: 158
        -- upvalues: u16 (copy)
        if p20(function() -- Line: 159
            -- upvalues: u16 (ref)
            u16:cancel();
        end) then
            return;
        end;

        p18(u16);
    end), "cancel", v17);
    v21:finallyCall(p15.Remove, p15, v17);

    return v21;
end;

function u5.Remove(p22, p23) -- Line: 199
    -- upvalues: u3 (copy)
    local v24 = p22[u3];
    local v25 = v24 and v24[p23];

    if v25 then
        local v26 = p22[v25];

        if v26 then
            if v26 == true then
                v25();
            else
                local v27 = v25[v26];

                if v27 then
                    v27(v25);
                end;
            end;

            p22[v25] = nil;
        end;

        v24[p23] = nil;
    end;

    return p22;
end;

function u5.Get(p28, p29) -- Line: 249
    -- upvalues: u3 (copy)
    local v30 = p28[u3];

    if v30 then
        return v30[p29];
    end;

    return nil;
end;

local function GetFenv(u31) -- Line: 258
    -- upvalues: u3 (copy)
    return function() -- Line: 259
        -- upvalues: u31 (copy), u3 (ref)
        for i, v in pairs(u31) do
            if i ~= u3 then
                return i, v;
            end;
        end;
    end;
end;

function u5.Cleanup(u32) -- Line: 281
    -- upvalues: u3 (copy)
    if not u32.CurrentlyCleaning then
        u32.CurrentlyCleaning = nil;

        local function v33() -- Line: 259
            -- upvalues: u32 (copy), u3 (ref)
            for i, v in pairs(u32) do
                if i ~= u3 then
                    return i, v;
                end;
            end;
        end;

        local v34, v35 = v33();

        while v34 and v35 do
            if v35 == true then
                v34();
            else
                local v36 = v34[v35];

                if v36 then
                    v36(v34);
                end;
            end;

            u32[v34] = nil;
            v34, v35 = v33();
        end;

        local v37 = u32[u3];

        if v37 then
            table.clear(v37);
            u32[u3] = {};
        end;

        u32.CurrentlyCleaning = false;
    end;
end;

function u5.Destroy(p38) -- Line: 319
    p38:Cleanup();
    table.clear(p38);
    setmetatable(p38, nil);
end;

u5.__call = u5.Cleanup;
local u39 = {
    Connected = true
};
u39.__index = u39;

function u39.Disconnect(p40) -- Line: 340
    if p40.Connected then
        p40.Connected = false;
        p40.Connection:Disconnect();
    end;
end;

function u39._new(p41) -- Line: 347
    -- upvalues: u39 (copy)
    return setmetatable({
        Connection = p41
    }, u39);
end;

function u39.__tostring(p42) -- Line: 353
    return "RbxScriptConnection<" .. tostring(p42.Connected) .. ">";
end;

function u5.LinkToInstance(u43, p44, p45) -- Line: 398
    -- upvalues: u4 (copy), u39 (copy)
    local u46 = nil;
    local v47 = p45 and newproxy(false) or u4;
    local u48 = p44.Parent == nil;
    local u49 = setmetatable({}, u39);
    u46 = p44.AncestryChanged:Connect(function(p50, p51) -- Line: 404, Name: ChangedFunction
        -- upvalues: u49 (copy), u48 (ref), u46 (ref), u43 (copy)
        u48 = u49.Connected and p51 == nil;

        if u48 then
            task.defer(function() -- Line: 410
                -- upvalues: u49 (ref), u46 (ref), u43 (ref), u48 (ref)
                if not u49.Connected then
                    return;
                end;

                if not u46.Connected then
                    u43:Cleanup();

                    return;
                end;

                while u48 and (u46.Connected and u49.Connected) do
                    task.wait();
                end;

                if u49.Connected and u48 then
                    u43:Cleanup();
                end;
            end);
        end;
    end);
    u49.Connection = u46;

    if u48 then
        local Parent = p44.Parent;

        if u49.Connected then
            if Parent == nil then
                u48 = true;
            else
                u48 = false;
            end;

            if u48 then
                task.defer(function() -- Line: 410
                    -- upvalues: u49 (copy), u46 (ref), u43 (copy), u48 (ref)
                    if not u49.Connected then
                        return;
                    end;

                    if not u46.Connected then
                        u43:Cleanup();

                        return;
                    end;

                    while u48 and (u46.Connected and u49.Connected) do
                        task.wait();
                    end;

                    if u49.Connected and u48 then
                        u43:Cleanup();
                    end;
                end);
            end;
        end;
    end;

    return u43:Add(u49, "Disconnect", v47);
end;

function u5.LinkToInstances(p52, ...) -- Line: 446
    -- upvalues: u5 (copy)
    local v53 = u5.new();

    for _, v in ipairs({ ... }) do
        v53:Add(p52:LinkToInstance(v, true), "Disconnect");
    end;

    return v53;
end;

function u5.new() -- Line: 459
    -- upvalues: u3 (copy), u5 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u3] = nil
    }, u5);
end;

return u5;