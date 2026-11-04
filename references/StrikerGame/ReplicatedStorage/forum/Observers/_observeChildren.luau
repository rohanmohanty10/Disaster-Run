 

 

local function defaultChildGuard(p1) -- Line: 5
    return true;
end;

return function(u2: any, u3: function, u4: function?) -- Line: 29, Name: observeChildren
    -- upvalues: defaultChildGuard (copy)
    local u5 = nil;
    local u6 = {};
    local u7 = {};

    if u4 == nil then
        u4 = defaultChildGuard;
    end;

    local function OnChildAdded(p8: userdata) -- Line: 45
        -- upvalues: u5 (ref), u6 (copy), u4 (copy), u3 (copy), u2 (copy), u7 (copy)
        if not u5.Connected then
            return;
        end;

        if u6[p8] then
            return;
        end;

        u6[p8] = true;

        if not u4(p8) then
            return;
        end;

        local v12, v13 = xpcall(function(p9) -- Line: 62
            -- upvalues: u3 (ref)
            local v10 = u3(p9);

            if v10 ~= nil then
                local v11 = typeof(v10) == "function";
                assert(v11, "callback must return a function or nil");
            end;

            return v10;
        end, debug.traceback, p8);

        if v12 then
            if v13 then
                if u5.Connected and p8.Parent ~= nil then
                    u7[p8] = v13;

                    return;
                end;

                task.spawn(v13);
            end;

            return;
        end;

        local v14 = string.split(v13, "\n")[1];
        local string_find_ret = string.find(v14, ": ");
        local v15 = not string_find_ret and "" or v14:sub(string_find_ret + 1);
        warn((`error while calling observeChildren({u2}) callback:{v15}\n{v13}`));
    end;

    u5 = u2.ChildAdded:Connect(OnChildAdded);
    local u18 = u2.ChildRemoved:Connect(function(p16: userdata) -- Line: 94, Name: OnChildRemoved
        -- upvalues: u6 (copy), u7 (copy)
        u6[p16] = nil;
        local v17 = u7[p16];
        u7[p16] = nil;

        if typeof(v17) == "function" then
            task.spawn(v17);
        end;
    end);

    for _, child in u2:GetChildren() do
        task.defer(OnChildAdded, child);
    end;

    return function() -- Line: 113
        -- upvalues: u5 (ref), u18 (ref), u7 (copy), u6 (copy)
        u5:Disconnect();
        u18:Disconnect();

        for i, _ in pairs(u7) do
            u6[i] = nil;
            local v19 = u7[i];
            u7[i] = nil;

            if typeof(v19) == "function" then
                task.spawn(v19);
            end;
        end;
    end;
end;