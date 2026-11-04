 

 

local function defaultDescendantGuard(p1: userdata) -- Line: 5
    return true;
end;

return function(u2: any, u3: function, u4: function?) -- Line: 27, Name: observeDescendants
    -- upvalues: defaultDescendantGuard (copy)
    local u5 = nil;
    local u6 = {};
    local u7 = {};

    if u4 == nil then
        u4 = defaultDescendantGuard;
    end;

    local function OnDescendantAdded(p8: userdata) -- Line: 42
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

        local v12, v13 = xpcall(function(p9) -- Line: 57
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
                if u5.Connected and p8:IsDescendantOf(u2) then
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
        warn((`error while calling observeDescendants({u2}) callback:{v15}\n{v13}`));
    end;

    u5 = u2.DescendantAdded:Connect(OnDescendantAdded);
    local u18 = u2.DescendantRemoving:Connect(function(p16: userdata) -- Line: 88, Name: OnDescendantRemoving
        -- upvalues: u6 (copy), u7 (copy)
        u6[p16] = nil;
        local v17 = u7[p16];
        u7[p16] = nil;

        if typeof(v17) == "function" then
            task.spawn(v17);
        end;
    end);

    for _, descendant in u2:GetDescendants() do
        task.defer(OnDescendantAdded, descendant);
    end;

    return function() -- Line: 107
        -- upvalues: u5 (ref), u18 (ref), u7 (copy), u6 (copy)
        u5:Disconnect();
        u18:Disconnect();

        for i in pairs(u7) do
            u6[i] = nil;
            local v19 = u7[i];
            u7[i] = nil;

            if typeof(v19) == "function" then
                task.spawn(v19);
            end;
        end;
    end;
end;