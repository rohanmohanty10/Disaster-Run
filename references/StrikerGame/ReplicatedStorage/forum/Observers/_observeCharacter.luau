 

 

local _observePlayer = require(script.Parent._observePlayer);

return function(u1: function) -- Line: 21, Name: observeCharacter
    -- upvalues: _observePlayer (copy)
    return _observePlayer(function(u2) -- Line: 22
        -- upvalues: u1 (copy)
        local u3 = nil;
        local u4 = false;
        local u5 = nil;

        local function OnCharacterAdded(p6: userdata) -- Line: 27
            -- upvalues: u5 (ref), u4 (ref), u3 (ref), u1 (ref), u2 (copy)
            if not u5.Connected then
                return;
            end;

            if u4 then
                return;
            end;

            u4 = true;
            local u7 = nil;
            local u8 = nil;
            u8 = p6.AncestryChanged:Connect(function(p9, p10) -- Line: 39
                -- upvalues: u8 (ref), u4 (ref), u7 (ref), u3 (ref)
                if p10 == nil and u8.Connected then
                    u4 = false;
                    u8:Disconnect();

                    if u7 ~= nil then
                        task.spawn(u7);

                        if u3 == u7 then
                            u3 = nil;
                        end;

                        u7 = nil;
                    end;
                end;
            end);
            local v15, v16 = xpcall(function(p11, p12) -- Line: 54
                -- upvalues: u1 (ref)
                local v13 = u1(p11, p12);

                if v13 ~= nil then
                    local v14 = typeof(v13) == "function";
                    assert(v14, "callback must return a function or nil");
                end;

                return v13;
            end, debug.traceback, u2, p6);

            if v15 then
                if v16 then
                    if u5.Connected and p6.Parent then
                        u7 = v16;
                        u3 = v16;
                    else
                        task.spawn(v16);
                    end;
                end;

                return;
            end;

            local v17 = string.split(v16, "\n")[1];
            local string_find_ret = string.find(v17, ": ");
            local v18 = not string_find_ret and "" or v17:sub(string_find_ret + 1);
            warn((`error while calling observeCharacter() callback:{v18}\n{v16}`));
        end;

        u5 = u2.CharacterAdded:Connect(OnCharacterAdded);

        if u2.Character then
            task.defer(OnCharacterAdded, u2.Character);
        end;

        return function() -- Line: 94
            -- upvalues: u5 (ref), u3 (ref)
            u5:Disconnect();

            if u3 ~= nil then
                task.spawn(u3);
                u3 = nil;
            end;
        end;
    end);
end;