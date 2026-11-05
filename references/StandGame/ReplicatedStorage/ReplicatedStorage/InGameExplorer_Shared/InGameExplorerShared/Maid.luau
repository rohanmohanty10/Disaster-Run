 

 

local l__GetPromiseLibrary__1 = require(script.GetPromiseLibrary);
local l__Symbol__2 = require(script.Symbol);
local u1, u2 = l__GetPromiseLibrary__1();
local u3 = l__Symbol__2("IndicesReference");
local u4 = l__Symbol__2("LinkToInstanceIndex");
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
function u5.Is(p7) --[[ Line: 42 ]]
    -- upvalues: u5 (copy)
    local v8;
    if type(p7) == "table" then
        v8 = getmetatable(p7) == u5;
    else
        v8 = false;
    end;
    return v8;
end;
function u5._Add(p9, p10, p11, p12) --[[ Line: 80 ]]
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
function u5.Add(p15, ...) --[[ Line: 101 ]]
    for _, v16 in pairs({ ... }) do
        p15:_Add(v16);
    end;
end;
function u5.AddPromise(p17, u18) --[[ Line: 129 ]]
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return u18;
    end;
    if not u2.is(u18) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(u18), (tostring(u18))));
    end;
    if u18:getStatus() ~= u2.Status.Started then
        return u18;
    end;
    local v19 = newproxy(false);
    local v22 = p17:_Add(u2.new(function(p20, _, p21) --[[ Line: 137 ]]
        -- upvalues: u18 (copy)
        if p21(function() --[[ Line: 138 ]]
            -- upvalues: u18 (ref)
            u18:cancel();
        end) then
        else
            p20(u18);
        end;
    end), "cancel", v19);
    v22:finallyCall(p17.Remove, p17, v19);
    return v22;
end;
function u5.Remove(p23, p24) --[[ Line: 178 ]]
    -- upvalues: u3 (copy)
    local v25 = p23[u3];
    local v26 = v25 and v25[p24];
    if v26 then
        local v27 = p23[v26];
        if v27 then
            if v27 == true then
                v26();
            else
                local v28 = v26[v27];
                if v28 then
                    v28(v26);
                end;
            end;
            p23[v26] = nil;
        end;
        v25[p24] = nil;
    end;
    return p23;
end;
function u5.Get(p29, p30) --[[ Line: 226 ]]
    -- upvalues: u3 (copy)
    local v31 = p29[u3];
    if v31 then
        return v31[p30];
    else
        return nil;
    end;
end;
function u5.Cleanup(u32) --[[ Line: 258 ]]
    -- upvalues: u3 (copy)
    if not u32.CurrentlyCleaning then
        u32.CurrentlyCleaning = nil;
        local function v35() --[[ Line: 236 ]]
            -- upvalues: u32 (copy), u3 (ref)
            for v33, v34 in pairs(u32) do
                if v33 ~= u3 then
                    return v33, v34;
                end;
            end;
        end;
        local v36, v37 = v35();
        while v36 and v37 do
            if v37 == true then
                v36();
            else
                local v38 = v36[v37];
                if v38 then
                    v38(v36);
                end;
            end;
            u32[v36] = nil;
            v36, v37 = v35();
        end;
        local v39 = u32[u3];
        if v39 then
            table.clear(v39);
            u32[u3] = {};
        end;
        u32.CurrentlyCleaning = false;
    end;
end;
function u5.Destroy(p40) --[[ Line: 296 ]]
    p40:Cleanup();
    table.clear(p40);
    setmetatable(p40, nil);
end;
u5.__call = u5.Cleanup;
local u41 = {
    Connected = true
};
u41.__index = u41;
function u41.Disconnect(p42) --[[ Line: 317 ]]
    if p42.Connected then
        p42.Connected = false;
        p42.Connection:Disconnect();
    end;
end;
function u41._new(p43) --[[ Line: 324 ]]
    -- upvalues: u41 (copy)
    return setmetatable({
        Connection = p43
    }, u41);
end;
function u41.__tostring(p44) --[[ Line: 330 ]]
    return "RbxScriptConnection<" .. tostring(p44.Connected) .. ">";
end;
function u5.LinkToInstance(u45, p46, p47) --[[ Line: 375 ]]
    -- upvalues: u4 (copy), u41 (copy)
    local u48 = nil;
    local v49 = p47 and newproxy(false) or u4;
    local u50 = p46.Parent == nil;
    local u51 = setmetatable({}, u41);
    local u53 = p46.AncestryChanged:Connect(function(_, p52) --[[ Name: ChangedFunction, Line 381 ]]
        -- upvalues: u51 (copy), u50 (ref), u48 (ref), u45 (copy)
        u50 = u51.Connected and p52 == nil;
        if u50 then
            task.defer(function() --[[ Line: 387 ]]
                -- upvalues: u51 (ref), u48 (ref), u45 (ref), u50 (ref)
                if u51.Connected then
                    if u48.Connected then
                        while u50 and (u48.Connected and u51.Connected) do
                            task.wait();
                        end;
                        if u51.Connected and u50 then
                            u45:Cleanup();
                        end;
                    else
                        u45:Cleanup();
                    end;
                end;
            end);
        end;
    end);
    u51.Connection = u53;
    if u50 then
        local l__Parent__3 = p46.Parent;
        if u51.Connected then
            if l__Parent__3 == nil then
                u50 = true;
            else
                u50 = false;
            end;
            if u50 then
                task.defer(function() --[[ Line: 387 ]]
                    -- upvalues: u51 (copy), u53 (ref), u45 (copy), u50 (ref)
                    if u51.Connected then
                        if u53.Connected then
                            while u50 and (u53.Connected and u51.Connected) do
                                task.wait();
                            end;
                            if u51.Connected and u50 then
                                u45:Cleanup();
                            end;
                        else
                            u45:Cleanup();
                        end;
                    end;
                end);
            end;
        end;
    end;
    return u45:_Add(u51, "Disconnect", v49);
end;
function u5.LinkToInstances(p54, ...) --[[ Line: 423 ]]
    -- upvalues: u5 (copy)
    local v55 = u5.new();
    for _, v56 in ipairs({ ... }) do
        v55:_Add(p54:LinkToInstance(v56, true), "Disconnect");
    end;
    return v55;
end;
function u5.new() --[[ Line: 436 ]]
    -- upvalues: u3 (copy), u5 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u3] = nil
    }, u5);
end;
return u5;