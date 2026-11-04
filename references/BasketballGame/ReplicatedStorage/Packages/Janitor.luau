 
 

local u1;

if script.Parent:FindFirstChild("Promise") then
    u1 = require(script.Parent.Promise);
else
    u1 = nil;
end;

local u2 = setmetatable({}, {
    __tostring = function() -- Line: 12, Name: __tostring
        return "IndicesReference";
    end
});
local u3 = setmetatable({}, {
    __tostring = function() -- Line: 18, Name: __tostring
        return "LinkToInstanceIndex";
    end
});
local u4 = {
    ClassName = "Janitor",
    CurrentlyCleaning = true,
    SuppressInstanceReDestroy = false,
    [u2] = nil
};
u4.__index = u4;
local u5 = {
    ["function"] = true,
    thread = true,
    RBXScriptConnection = "Disconnect"
};

function u4.new() -- Line: 70
    -- upvalues: u2 (copy), u4 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u2] = nil
    }, u4);
end;

function u4.Is(p6) -- Line: 83
    -- upvalues: u4 (copy)
    local v7;

    if type(p6) == "table" then
        v7 = getmetatable(p6) == u4;
    else
        v7 = false;
    end;

    return v7;
end;

u4.instanceof = u4.Is;

function u4.Add(p8, p9, p10, p11) -- Line: 177
    -- upvalues: u2 (copy), u5 (copy)
    if p11 then
        p8:Remove(p11);
        local v12 = p8[u2];

        if not v12 then
            v12 = {};
            p8[u2] = v12;
        end;

        v12[p11] = p9;
    end;

    local v13 = typeof(p9);
    local v14 = p10 or (u5[v13] or "Destroy");

    if v13 == "function" or v13 == "thread" then
        if v14 ~= true then
            warn(string.format("Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*", v13, tostring(v14), debug.traceback(nil, 2)));
        end;
    elseif not p9[v14] then
        warn(string.format("Object %* doesn\'t have method %*, are you sure you want to add it? Traceback: %*", tostring(p9), tostring(v14), debug.traceback(nil, 2)));
    end;

    p8[p9] = v14;

    return p9;
end;

function u4.Clone(p15: table, p16: userdata, ...) -- Line: 214
    if p15.CurrentlyCleaning then
        error("Cannot call janitor:Clone() while cleaning", 2);
    end;

    return p15:Add(p16:Clone(), ...);
end;

function u4.AddPromise(p17, u18) -- Line: 247
    -- upvalues: u1 (copy)
    if not u1 then
        return u18;
    end;

    if not u1.is(u18) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %* (%*)) Traceback: %*", typeof(u18), tostring(u18), debug.traceback(nil, 2)));
    end;

    if u18:getStatus() ~= u1.Status.Started then
        return u18;
    end;

    local v19 = newproxy(false);
    local v23 = p17:Add(u1.new(function(p20, p21, p22) -- Line: 258
        -- upvalues: u18 (copy)
        if p22(function() -- Line: 259
            -- upvalues: u18 (ref)
            u18:cancel();
        end) then
            return;
        end;

        p20(u18);
    end), "cancel", v19);
    v23:finallyCall(p17.Remove, p17, v19);

    return v23;
end;

function u4.Remove(p24, p25) -- Line: 300
    -- upvalues: u2 (copy)
    local v26 = p24[u2];
    local u27 = v26 and v26[p25];

    if u27 then
        local v28 = p24[u27];

        if v28 then
            if v28 == true then
                if type(u27) == "function" then
                    u27();
                else
                    local v29;

                    if coroutine.running() == u27 then
                        v29 = nil;
                    else
                        v29 = pcall(function() -- Line: 316
                            -- upvalues: u27 (copy)
                            task.cancel(u27);
                        end);
                    end;

                    if not v29 then
                        task.defer(function() -- Line: 322
                            -- upvalues: u27 (copy)
                            if u27 then
                                task.cancel(u27);
                            end;
                        end);
                    end;
                end;
            else
                local v30 = u27[v28];

                if v30 then
                    if p24.SuppressInstanceReDestroy and (v28 == "Destroy" and typeof(u27) == "Instance") then
                        pcall(v30, u27);
                    else
                        v30(u27);
                    end;
                end;
            end;

            p24[u27] = nil;
        end;

        v26[p25] = nil;
    end;

    return p24;
end;

function u4.RemoveNoClean(p31, p32) -- Line: 383
    -- upvalues: u2 (copy)
    local v33 = p31[u2];

    if v33 then
        local v34 = v33[p32];

        if v34 then
            p31[v34] = nil;
        end;

        v33[p32] = nil;
    end;

    return p31;
end;

function u4.RemoveList(p35, ...) -- Line: 439
    -- upvalues: u2 (copy)
    if p35[u2] then
        local v36 = select("#", ...);

        if v36 == 1 then
            return p35:Remove(...);
        end;

        for i = 1, v36 do
            p35:Remove(select(i, ...));
            local _ = i;
        end;
    end;

    return p35;
end;

function u4.RemoveListNoClean(p37, ...) -- Line: 496
    -- upvalues: u2 (copy)
    local v38 = p37[u2];

    if v38 then
        local v39 = select("#", ...);

        if v39 == 1 then
            return p37:RemoveNoClean(...);
        end;

        for i = 1, v39 do
            local v40 = select(i, ...);
            local v41 = v38[v40];

            if v41 then
                p37[v41] = nil;
            end;

            v38[v40] = nil;
            local _ = i;
        end;
    end;

    return p37;
end;

function u4.Get(p42, p43) -- Line: 544
    -- upvalues: u2 (copy)
    local v44 = p42[u2];

    if v44 then
        return v44[p43];
    end;

    return nil;
end;

function u4.GetAll(p45) -- Line: 574
    -- upvalues: u2 (copy)
    local v46 = p45[u2];

    return not v46 and {} or table.freeze(table.clone(v46));
end;

local function GetFenv(u47) -- Line: 579
    -- upvalues: u2 (copy)
    return function() -- Line: 580
        -- upvalues: u47 (copy), u2 (ref)
        for i, v in next, u47 do
            if i ~= u2 and i ~= "SuppressInstanceReDestroy" then
                return i, v;
            end;
        end;
    end;
end;

function u4.Cleanup(u48) -- Line: 606
    -- upvalues: u2 (copy)
    if not u48.CurrentlyCleaning then
        u48.CurrentlyCleaning = nil;

        local function v49() -- Line: 580
            -- upvalues: u48 (copy), u2 (ref)
            for i, v in next, u48 do
                if i ~= u2 and i ~= "SuppressInstanceReDestroy" then
                    return i, v;
                end;
            end;
        end;

        local u50, v51 = v49();

        while u50 and v51 do
            if v51 == true then
                if type(u50) == "function" then
                    u50();
                else
                    local v52;

                    if coroutine.running() == u50 then
                        v52 = nil;
                    else
                        v52 = pcall(function() -- Line: 620
                            -- upvalues: u50 (ref)
                            task.cancel(u50);
                        end);
                    end;

                    if not v52 then
                        task.defer(function() -- Line: 626
                            -- upvalues: u50 (ref)
                            if u50 then
                                task.cancel(u50);
                            end;
                        end);
                    end;
                end;
            else
                local v53 = u50[v51];

                if v53 then
                    if u48.SuppressInstanceReDestroy and (v51 == "Destroy" and typeof(u50) == "Instance") then
                        pcall(v53, u50);
                    else
                        v53(u50);
                    end;
                end;
            end;

            u48[u50] = nil;
            u50, v51 = v49();
        end;

        local v54 = u48[u2];

        if v54 then
            table.clear(v54);
            u48[u2] = {};
        end;

        u48.CurrentlyCleaning = false;
    end;
end;

function u4.Destroy(p55) -- Line: 665
    p55:Cleanup();
    table.clear(p55);
    setmetatable(p55, nil);
end;

u4.__call = u4.Cleanup;

function u4.LinkToInstance(u56: table, p57: userdata, p58: boolean?) -- Line: 714
    -- upvalues: u3 (copy)
    local v59;

    if p58 then
        v59 = newproxy(false);
    else
        v59 = u3;
    end;

    return u56:Add(p57.Destroying:Connect(function() -- Line: 717
        -- upvalues: u56 (copy)
        u56:Cleanup();
    end), "Disconnect", v59);
end;

u4.LegacyLinkToInstance = u4.LinkToInstance;

function u4.LinkToInstances(p60, ...) -- Line: 730
    -- upvalues: u4 (copy)
    local v61 = u4.new();

    for i = 1, select("#", ...) do
        local v62 = select(i, ...);
        local v63;

        if typeof(v62) == "Instance" then
            v61:Add(p60:LinkToInstance(v62, true), "Disconnect");
            v63 = i;
        else
            v63 = i;
        end;
    end;

    return v61;
end;

function u4.__tostring(p64) -- Line: 744
    return "Janitor";
end;

table.freeze(u4);

return u4;