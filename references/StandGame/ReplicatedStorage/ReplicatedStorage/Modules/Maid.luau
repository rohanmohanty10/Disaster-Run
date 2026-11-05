 

 

local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 5 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        _tasks = {},
        Destroy = u1.Clean
    }, u1);
end;
function u1.__index(p2, p3) --[[ Line: 9 ]]
    -- upvalues: u1 (copy)
    if u1[p3] then
        return u1[p3];
    else
        return p2._tasks[p3];
    end;
end;
function u1.__newindex(p4, p5, p6) --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    if u1[p5] ~= nil then
        error(("\'%s\' is reserved"):format((tostring(p5))), 2);
    end;
    local l___tasks__1 = p4._tasks;
    local v7 = l___tasks__1[p5];
    if v7 == p6 then
    else
        l___tasks__1[p5] = p6;
        if v7 then
            if type(v7) == "function" then
                v7();
                return;
            end;
            if typeof(v7) == "RBXScriptConnection" then
                v7:Disconnect();
                return;
            end;
            if v7.Destroy then
                v7:Destroy();
            end;
        end;
    end;
end;
function u1.AddTask(p8, p9) --[[ Line: 42 ]]
    if not p9 then
        error("Task cannot be false or nil", 2);
    end;
    local v10 = #p8._tasks + 1;
    p8[v10] = p9;
    if type(p9) == "table" and not p9.Destroy then
        print(p9);
        warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback());
    end;
    return v10;
end;
function u1.Clean(p11) --[[ Line: 58 ]]
    local l___tasks__2 = p11._tasks;
    for v12, v13 in pairs(l___tasks__2) do
        if typeof(v13) == "RBXScriptConnection" then
            l___tasks__2[v12] = nil;
            v13:Disconnect();
        end;
    end;
    local v14, v15 = next(l___tasks__2);
    while v15 ~= nil do
        l___tasks__2[v14] = nil;
        if type(v15) == "function" then
            v15();
        elseif typeof(v15) == "RBXScriptConnection" then
            v15:Disconnect();
        elseif v15.Destroy then
            v15:Destroy();
        end;
        v14, v15 = next(l___tasks__2);
    end;
end;
return u1;