 

 

local function defaultAncestryGuard(p1: userdata, p2: userdata?) -- Line: 8
    return true;
end;

return function(u3: any, u4: function, p5: function?) -- Line: 23, Name: observeAncestry
    -- upvalues: defaultAncestryGuard (copy)
    local v6 = typeof(u3) == "Instance";
    assert(v6, "Bad argument #1 to observeAncestry, expected Instance");
    local u7 = p5 or defaultAncestryGuard;
    local u8 = nil;
    local u9 = nil;

    local function onAncestryChanged(p10: userdata, p11: userdata?) -- Line: 40
        -- upvalues: u9 (ref), u8 (ref), u7 (copy), u4 (copy), u3 (copy)
        if not u9.Connected then
            return;
        end;

        if u8 then
            task.spawn(u8);
            u8 = nil;
        end;

        if not p10:IsDescendantOf(game) then
            return;
        end;

        if not u7(p10, p11) then
            return;
        end;

        local v16, v17 = xpcall(function(p12, p13) -- Line: 64
            -- upvalues: u4 (ref)
            local v14 = u4(p12, p13);

            if v14 ~= nil then
                local v15 = typeof(v14) == "function";
                assert(v15, "callback must return a function or nil");
            end;

            return v14;
        end, debug.traceback, p10, p11);

        if v16 then
            if v17 then
                if u9.Connected then
                    u8 = v17;

                    return;
                end;

                task.spawn(v17);
            end;

            return;
        end;

        local v18 = string.split(v17, "\n")[1];
        local string_find_ret = string.find(v18, ": ");
        local v19 = not string_find_ret and "" or v18:sub(string_find_ret + 1);
        warn((`error while calling observeAncestry({u3}) callback:{v19}\n{v17}`));
    end;

    u9 = u3.AncestryChanged:Connect(onAncestryChanged);
    task.defer(onAncestryChanged, u3, u3.Parent);

    return function() -- Line: 100
        -- upvalues: u9 (ref), u8 (ref)
        if u9.Connected then
            u9:Disconnect();
        end;

        if u8 then
            task.spawn(u8);
            u8 = nil;
        end;
    end;
end;