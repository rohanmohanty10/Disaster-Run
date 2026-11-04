 
 

local function defaultGuard(p1) -- Line: 2
    return true;
end;

return function(u2: any, u3: string, u4: function, u5: function?) -- Line: 43, Name: observeAttribute
    -- upvalues: defaultGuard (copy)
    local u6 = nil;
    local u7 = nil;
    local u8 = 0;

    if u5 == nil then
        u5 = defaultGuard;
    end;

    local function OnAttributeChanged() -- Line: 56
        -- upvalues: u7 (ref), u6 (ref), u8 (ref), u2 (copy), u3 (copy), u5 (copy), u4 (copy)
        if not u7.Connected then
            return;
        end;

        if u6 ~= nil then
            task.spawn(u6);
            u6 = nil;
        end;

        u8 = u8 + 1;
        local v9 = u8;
        local Attribute = u2:GetAttribute(u3);

        if Attribute == nil or not u5(Attribute) then
            return;
        end;

        local v13, v14 = xpcall(function(p10) -- Line: 75
            -- upvalues: u4 (ref)
            local v11 = u4(p10);

            if v11 ~= nil then
                local v12 = typeof(v11) == "function";
                assert(v12, "callback must return a function or nil");
            end;

            return v11;
        end, debug.traceback, Attribute);

        if v13 then
            if v14 then
                if v9 == u8 and u7.Connected then
                    u6 = v14;

                    return;
                end;

                task.spawn(v14);
            end;

            return;
        end;

        local v15 = string.split(v14, "\n")[1];
        local string_find_ret = string.find(v15, ": ");
        local v16 = not string_find_ret and "" or v15:sub(string_find_ret + 1);
        warn((`error while calling observeAttribute("{u3}") callback:{v16}\n{v14}`));
    end;

    u7 = u2:GetAttributeChangedSignal(u3):Connect(OnAttributeChanged);
    task.defer(OnAttributeChanged);

    return function() -- Line: 111
        -- upvalues: u7 (ref), u6 (ref)
        u7:Disconnect();

        if u6 ~= nil then
            task.spawn(u6);
            u6 = nil;
        end;
    end;
end;