  

local CollectionService = game:GetService("CollectionService");

function observeTagNoAncestry(u1: string, u2: function)
    -- upvalues: CollectionService (copy)
    local u3 = {};
    local u4 = nil;

    local function OnInstanceAdded(u5: userdata) -- Line: 11
        -- upvalues: u4 (ref), u2 (copy), u1 (copy), u3 (copy)
        if not u4.Connected then
            return;
        end;

        task.defer(function() -- Line: 17
            -- upvalues: u2 (ref), u5 (copy), u1 (ref), u3 (ref)
            local v9, v10 = xpcall(function(p6: userdata) -- Line: 19
                -- upvalues: u2 (ref)
                local v7 = u2(p6);
                local v8 = typeof(v7) == "nil" and true or typeof(v7) == "function";
                assert(v8, "callback must return a function");

                return v7;
            end, debug.traceback, u5);

            if v9 then
                if type(v10) == "function" then
                    if not u5:HasTag(u1) then
                        task.spawn(v10);

                        return;
                    end;

                    u3[u5] = v10;
                end;

                return;
            end;

            local v11 = string.split(v10, "\n")[1];
            local string_find_ret = string.find(v11, ": ");
            local v12 = not string_find_ret and "" or v11:sub(string_find_ret + 1);
            warn((`error while calling observeTag("{u1}") callback:{v12}\n{v10}`));
        end);
    end;

    u4 = CollectionService:GetInstanceAddedSignal(u1):Connect(OnInstanceAdded);
    local u15 = CollectionService:GetInstanceRemovedSignal(u1):Connect(function(p13: userdata) -- Line: 49, Name: OnInstanceRemoved
        -- upvalues: u3 (copy)
        local v14 = u3[p13];

        if typeof(v14) == "function" then
            task.spawn(v14);
        end;
    end);
    task.defer(function() -- Line: 61
        -- upvalues: u4 (ref), CollectionService (ref), u1 (copy), OnInstanceAdded (copy)
        if not u4.Connected then
            return;
        end;

        for _, v in CollectionService:GetTagged(u1) do
            task.spawn(OnInstanceAdded, v);
        end;
    end);

    return function() -- Line: 72
        -- upvalues: u4 (ref), u15 (ref), u3 (copy)
        u4:Disconnect();
        u15:Disconnect();
        local v16 = next(u3);

        while v16 do
            local v17 = u3[v16];

            if typeof(v17) == "function" then
                task.spawn(v17);
            end;

            v16 = next(u3);
        end;
    end;
end;

return observeTagNoAncestry;