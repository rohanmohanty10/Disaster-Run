 

 

local Players = game:GetService("Players");

return function(u1: function) -- Line: 21, Name: observePlayer
    -- upvalues: Players (copy)
    local u2 = nil;
    local u3 = {};
    local u4 = {};

    local function OnPlayerAdded(p5: userdata) -- Line: 27
        -- upvalues: u2 (ref), u3 (copy), u1 (copy), u4 (copy)
        if not u2.Connected then
            return;
        end;

        if u3[p5] then
            return;
        end;

        u3[p5] = true;
        local v9, v10 = xpcall(function(p6) -- Line: 37
            -- upvalues: u1 (ref)
            local v7 = u1(p6);

            if v7 ~= nil then
                local v8 = typeof(v7) == "function";
                assert(v8, "callback must return a function or nil");
            end;

            return v7;
        end, debug.traceback, p5);

        if v9 then
            if v10 then
                if u2.Connected and p5.Parent then
                    u4[p5] = v10;

                    return;
                end;

                task.spawn(v10);
            end;

            return;
        end;

        local v11 = string.split(v10, "\n")[1];
        local string_find_ret = string.find(v11, ": ");
        local v12 = not string_find_ret and "" or v11:sub(string_find_ret + 1);
        warn((`error while calling observePlayer() callback:{v12}\n{v10}`));
    end;

    u2 = Players.PlayerAdded:Connect(OnPlayerAdded);
    local u15 = Players.PlayerRemoving:Connect(function(p13: userdata) -- Line: 66, Name: OnPlayerRemoving
        -- upvalues: u3 (copy), u4 (copy)
        u3[p13] = nil;
        local v14 = u4[p13];
        u4[p13] = nil;

        if typeof(v14) == "function" then
            task.spawn(v14);
        end;
    end);

    for _, v in Players:GetPlayers() do
        task.defer(OnPlayerAdded, v);
    end;

    return function() -- Line: 85
        -- upvalues: u2 (ref), u15 (ref), u4 (copy), u3 (copy)
        u2:Disconnect();
        u15:Disconnect();
        local v16 = next(u4);

        while v16 do
            u3[v16] = nil;
            local v17 = u4[v16];
            u4[v16] = nil;

            if typeof(v17) == "function" then
                task.spawn(v17);
            end;

            v16 = next(u4);
        end;
    end;
end;