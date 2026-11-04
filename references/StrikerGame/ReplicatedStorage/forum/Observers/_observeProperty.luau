 

 

local function defaultValueGuard(p1) -- Line: 3
    return true;
end;

return function(u2: userdata, u3: string, u4: function, u5: function?) -- Line: 32, Name: observeProperty
    -- upvalues: defaultValueGuard (copy)
    local u6 = nil;
    local u7 = nil;
    local u8 = 0;

    if u5 == nil then
        u5 = defaultValueGuard;
    end;

    local function onPropertyChanged() -- Line: 45
        -- upvalues: u7 (ref), u6 (ref), u8 (ref), u2 (copy), u3 (copy), u5 (copy), u4 (copy)
        if not u7.Connected then
            return;
        end;

        if u6 then
            task.spawn(u6);
            u6 = nil;
        end;

        u8 = u8 + 1;
        local v9 = u8;
        local v10 = u2[u3];

        if not u5(v10) then
            return;
        end;

        local v14, v15 = xpcall(function(p11) -- Line: 64
            -- upvalues: u4 (ref)
            local v12 = u4(p11);

            if v12 ~= nil then
                local v13 = typeof(v12) == "function";
                assert(v13, "callback must return a function or nil");
            end;

            return v12;
        end, debug.traceback, v10);

        if v14 then
            if v9 == u8 and u7.Connected then
                u6 = v15;

                return;
            end;

            if v15 then
                task.spawn(v15);
            end;

            return;
        end;

        local v16 = string.split(v15, "\n")[1];
        local string_find_ret = string.find(v16, ": ");
        local v17 = not string_find_ret and "" or v16:sub(string_find_ret + 1);
        warn((`error while calling observeProperty("{u3}") callback:{v17}\n{v15}`));
    end;

    u7 = u2:GetPropertyChangedSignal(u3):Connect(onPropertyChanged);
    task.defer(onPropertyChanged);

    return function() -- Line: 99
        -- upvalues: u7 (ref), u6 (ref)
        u7:Disconnect();

        if u6 then
            task.spawn(u6);
            u6 = nil;
        end;
    end;
end;