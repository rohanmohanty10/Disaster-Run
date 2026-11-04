 
 

local function defaultGuard(p1: string, p2: any) -- Line: 5
    return true;
end;

return function(u3: any, u4: function, u5: function?) -- Line: 30, Name: observeAllAttributes
    -- upvalues: defaultGuard (copy)
    local u6 = {};
    local u7 = {};

    if u5 == nil then
        u5 = defaultGuard;
    end;

    local u8 = nil;

    local function onAttributeChanged(p9: string) -- Line: 40
        -- upvalues: u8 (ref), u6 (copy), u7 (copy), u3 (copy), u5 (copy), u4 (copy)
        if not u8.Connected then
            return;
        end;

        local v10 = u6[p9];

        if typeof(v10) == "function" then
            task.spawn(v10);
            u6[p9] = nil;
        end;

        if not u7[p9] then
            u7[p9] = 0;
        end;

        local v11 = u7;
        v11[p9] = v11[p9] + 1;
        local v12 = u7[p9];
        local Attribute = u3:GetAttribute(p9);

        if Attribute == nil or not u5(p9, Attribute) then
            return;
        end;

        local v17, v18 = xpcall(function(p13, p14) -- Line: 65
            -- upvalues: u4 (ref)
            local v15 = u4(p13, p14);

            if v15 ~= nil then
                local v16 = typeof(v15) == "function";
                assert(v16, "callback must return a function or nil");
            end;

            return v15;
        end, debug.traceback, p9, Attribute);

        if v17 then
            if v18 then
                if u8.Connected and u7[p9] == v12 then
                    u6[p9] = v18;

                    return;
                end;

                task.spawn(v18);
            end;

            return;
        end;

        local v19 = string.split(v18, "\n")[1];
        local string_find_ret = string.find(v19, ": ");
        local v20 = not string_find_ret and "" or v19:sub(string_find_ret + 1);
        warn((`error while calling observeAllAttributes({u3}) callback:{v20}\n{v18}`));
    end;

    u8 = u3.AttributeChanged:Connect(onAttributeChanged);

    for i, _ in u3:GetAttributes() do
        task.defer(onAttributeChanged, i);
    end;

    return function() -- Line: 104
        -- upvalues: u8 (ref), u6 (copy)
        u8:Disconnect();

        for i, v in pairs(u6) do
            u6[i] = nil;

            if typeof(v) == "function" then
                task.spawn(v);
            end;
        end;
    end;
end;