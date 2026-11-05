 

 

local l__RunService__1 = game:GetService("RunService");
local l__deferred__2 = require(script.deferred);
local u1 = nil;
local u2 = nil;
local u3 = {
    ClassName = "Promise"
};
u3.__index = u3;
function u3.isPromise(p4) --[[ Line: 6 ]]
    local v5;
    if type(p4) == "table" then
        v5 = p4.ClassName == "Promise";
    else
        v5 = false;
    end;
    return v5;
end;
function u3.new(p6) --[[ Line: 20 ]]
    -- upvalues: u3 (copy)
    local v7 = setmetatable({
        _unconsumedException = true,
        _source = "",
        _pendingExecuteList = {}
    }, u3);
    if type(p6) == "function" then
        p6(v7:_getResolveReject());
    end;
    return v7;
end;
function u3.defer(p8) --[[ Line: 34 ]]
    -- upvalues: u3 (copy), l__deferred__2 (copy)
    local v9 = u3.new();
    l__deferred__2(p8, v9:_getResolveReject());
    return v9;
end;
function u3.resolved(...) --[[ Line: 42 ]]
    -- upvalues: u2 (ref), u3 (copy)
    local v10 = select("#", ...);
    if v10 == 0 then
        return u2;
    end;
    if v10 == 1 then
        local v11 = ...;
        local v12;
        if type(v11) == "table" then
            v12 = v11.ClassName == "Promise";
        else
            v12 = false;
        end;
        if v12 then
            local v13 = ...;
            if not v13._pendingExecuteList then
                return v13;
            end;
        end;
    end;
    local v14 = u3.new();
    v14:Resolve(...);
    return v14;
end;
function u3.rejected(...) --[[ Line: 59 ]]
    -- upvalues: u1 (ref), u3 (copy)
    local v15 = select("#", ...);
    if v15 == 0 then
        return u1;
    end;
    local v16 = u3.new();
    v16:_reject({ ... }, v15);
    return v16;
end;
function u3.spawn(p17) --[[ Line: 70 ]]
    -- upvalues: u3 (copy)
    local v18 = u3.new();
    task.spawn(p17, v18:_getResolveReject());
    return v18;
end;
function u3.IsPending(p19) --[[ Line: 78 ]]
    return p19._pendingExecuteList ~= nil;
end;
function u3.IsFulfilled(p20) --[[ Line: 82 ]]
    return p20._fulfilled ~= nil;
end;
function u3.IsRejected(p21) --[[ Line: 86 ]]
    return p21._rejected ~= nil;
end;
function u3.Wait(p22) --[[ Line: 90 ]]
    if p22._fulfilled then
        return unpack(p22._fulfilled, 1, p22._valuesLength);
    elseif p22._rejected then
        return error(tostring(p22._rejected[1]), 2);
    else
        local u23 = Instance.new("BindableEvent");
        p22:Then(function() --[[ Line: 98 ]]
            -- upvalues: u23 (copy)
            u23:Fire();
        end, function() --[[ Line: 100 ]]
            -- upvalues: u23 (copy)
            u23:Fire();
        end);
        u23.Event:Wait();
        u23:Destroy();
        if p22._rejected then
            return error(tostring(p22._rejected[1]), 2);
        else
            return unpack(p22._fulfilled, 1, p22._valuesLength);
        end;
    end;
end;
function u3.Yield(p24) --[[ Line: 115 ]]
    if p24._fulfilled then
        return true, unpack(p24._fulfilled, 1, p24._valuesLength);
    end;
    if p24._rejected then
        return false, unpack(p24._rejected, 1, p24._valuesLength);
    end;
    local u25 = Instance.new("BindableEvent");
    p24:Then(function() --[[ Line: 123 ]]
        -- upvalues: u25 (copy)
        u25:Fire();
    end, function() --[[ Line: 125 ]]
        -- upvalues: u25 (copy)
        u25:Fire();
    end);
    u25.Event:Wait();
    u25:Destroy();
    if p24._fulfilled then
        return true, unpack(p24._fulfilled, 1, p24._valuesLength);
    end;
    if p24._rejected then
        return false, unpack(p24._rejected, 1, p24._valuesLength);
    end;
end;
function u3.Resolve(u26, ...) --[[ Line: 140 ]]
    if u26._pendingExecuteList then
        local v27 = select("#", ...);
        if v27 == 0 then
            u26:_fulfill({}, 0);
        elseif u26 == ... then
            u26:Reject("TypeError: Resolved to self");
        else
            local v28 = ...;
            local v29;
            if type(v28) == "table" then
                v29 = v28.ClassName == "Promise";
            else
                v29 = false;
            end;
            if v29 then
                if v27 > 1 then
                    local v30 = ("When resolving a promise, extra arguments are discarded! See:\n\n%s"):format(u26._source);
                    warn(v30);
                end;
                local v31 = ...;
                if v31._pendingExecuteList then
                    v31._unconsumedException = false;
                    v31._pendingExecuteList[#v31._pendingExecuteList + 1] = { function(...) --[[ Line: 161 ]]
                            -- upvalues: u26 (copy)
                            u26:Resolve(...);
                        end, function(...) --[[ Line: 164 ]]
                            -- upvalues: u26 (copy)
                            if u26._pendingExecuteList then
                                u26:_reject({ ... }, select("#", ...));
                            end;
                        end, nil };
                elseif v31._rejected then
                    v31._unconsumedException = false;
                    u26:_reject(v31._rejected, v31._valuesLength);
                elseif v31._fulfilled then
                    u26:_fulfill(v31._fulfilled, v31._valuesLength);
                else
                    error("[Promise.Resolve] - Bad promise2 state");
                end;
            else
                if type(...) == "function" then
                    if v27 > 1 then
                        local v32 = ("When resolving a function, extra arguments are discarded! See:\n\n%s"):format(u26._source);
                        warn(v32);
                    end;
                    local v33 = { ... };
                    if type(v33) == "function" then
                        v33(u26:_getResolveReject());
                    end;
                else
                    u26:_fulfill({ ... }, v27);
                end;
            end;
        end;
    end;
end;
function u3._fulfill(p34, p35, p36) --[[ Line: 195 ]]
    if p34._pendingExecuteList then
        p34._fulfilled = p35;
        p34._valuesLength = p36;
        local l___pendingExecuteList__3 = p34._pendingExecuteList;
        p34._pendingExecuteList = nil;
        for _, v37 in pairs(l___pendingExecuteList__3) do
            p34:_executeThen(unpack(v37));
        end;
    end;
end;
function u3.Reject(p38, ...) --[[ Line: 210 ]]
    p38:_reject({ ... }, select("#", ...));
end;
function u3._reject(u39, p40, p41) --[[ Line: 214 ]]
    -- upvalues: l__RunService__1 (copy)
    if u39._pendingExecuteList then
        u39._rejected = p40;
        u39._valuesLength = p41;
        local l___pendingExecuteList__4 = u39._pendingExecuteList;
        u39._pendingExecuteList = nil;
        for _, v42 in pairs(l___pendingExecuteList__4) do
            u39:_executeThen(unpack(v42));
        end;
        if u39._unconsumedException and u39._valuesLength > 0 then
            coroutine.resume(coroutine.create(function() --[[ Line: 229 ]]
                -- upvalues: l__RunService__1 (ref), u39 (copy)
                l__RunService__1.Heartbeat:Wait();
                if u39._unconsumedException then
                    warn(("[Promise] - Uncaught exception in promise: %q"):format((tostring(u39._rejected[1]))));
                end;
            end));
        end;
    end;
end;
function u3.Then(p43, p44, p45) --[[ Line: 245 ]]
    -- upvalues: u3 (copy)
    if type(p45) == "function" then
        p43._unconsumedException = false;
    end;
    if not p43._pendingExecuteList then
        return p43:_executeThen(p44, p45, nil);
    end;
    local v46 = u3.new();
    p43._pendingExecuteList[#p43._pendingExecuteList + 1] = { p44, p45, v46 };
    return v46;
end;
function u3.Tap(u47, p48, p49) --[[ Line: 259 ]]
    local v50 = u47:Then(p48, p49);
    if v50 == u47 then
        return v50;
    end;
    if v50._fulfilled then
        return u47;
    end;
    if v50._rejected then
        return u47;
    end;
    if v50._pendingExecuteList then
        local function v51() --[[ Line: 271 ]]
            -- upvalues: u47 (copy)
            return u47;
        end;
        return v50:Then(v51, v51);
    end;
    error("Bad result state");
end;
function u3.Finally(p52, p53) --[[ Line: 281 ]]
    return p52:Then(p53, p53);
end;
function u3.Catch(p54, p55) --[[ Line: 285 ]]
    return p54:Then(nil, p55);
end;
function u3.Destroy(p56) --[[ Line: 289 ]]
    p56:_reject({}, 0);
end;
function u3.GetResults(p57) --[[ Line: 293 ]]
    if p57._rejected then
        return false, unpack(p57._rejected, 1, p57._valuesLength);
    end;
    if p57._fulfilled then
        return true, unpack(p57._fulfilled, 1, p57._valuesLength);
    end;
    error("Still pending");
end;
function u3._getResolveReject(u58) --[[ Line: 303 ]]
    return function(...) --[[ Line: 304 ]]
        -- upvalues: u58 (copy)
        u58:Resolve(...);
    end, function(...) --[[ Line: 306 ]]
        -- upvalues: u58 (copy)
        u58:_reject({ ... }, select("#", ...));
    end;
end;
function u3._executeThen(p59, p60, p61, p62) --[[ Line: 311 ]]
    -- upvalues: u2 (ref), u3 (copy)
    if p59._fulfilled then
        if type(p60) ~= "function" then
            if not p62 then
                return p59;
            end;
            p62:_fulfill(p59._fulfilled, p59._valuesLength);
            return p62;
        end;
        if p62 then
            p62:Resolve(p60(unpack(p59._fulfilled, 1, p59._valuesLength)));
            return p62;
        end;
        local v63 = table.pack(p60(unpack(p59._fulfilled, 1, p59._valuesLength)));
        if v63.n == 0 then
            return u2;
        end;
        if v63.n == 1 then
            local v64 = v63[1];
            local v65;
            if type(v64) == "table" then
                v65 = v64.ClassName == "Promise";
            else
                v65 = false;
            end;
            if v65 then
                return v63[1];
            end;
        end;
        local v66 = u3.new();
        v66:Resolve(table.unpack(v63, 1, v63.n));
        return v66;
    end;
    if p59._rejected then
        if type(p61) ~= "function" then
            if not p62 then
                return p59;
            end;
            p62:_reject(p59._rejected, p59._valuesLength);
            return p62;
        end;
        if p62 then
            p62:Resolve(p61(unpack(p59._rejected, 1, p59._valuesLength)));
            return p62;
        end;
        local v67 = table.pack(p61(unpack(p59._rejected, 1, p59._valuesLength)));
        if v67.n == 0 then
            return u2;
        end;
        if v67.n == 1 then
            local v68 = v67[1];
            local v69;
            if type(v68) == "table" then
                v69 = v68.ClassName == "Promise";
            else
                v69 = false;
            end;
            if v69 then
                return v67[1];
            end;
        end;
        local v70 = u3.new();
        v70:Resolve(table.unpack(v67, 1, v67.n));
        return v70;
    end;
    error("Internal error: still pending");
end;
u2 = u3.new();
u2:_fulfill({}, 0);
u1 = u3.new();
u1:_reject({}, 0);
return u3;