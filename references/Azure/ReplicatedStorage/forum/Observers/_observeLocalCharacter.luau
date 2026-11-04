 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");

return function(u1: function) -- Line: 21, Name: observeLocalCharacter
    -- upvalues: RunService (copy), Players (copy)
    local v2 = RunService:IsClient();
    assert(v2, "observeLocalCharacter() is client-only!");
    local LocalPlayer = Players.LocalPlayer;
    local u3 = false;
    local u4 = nil;
    local u5 = nil;

    local function onCharacterAdded(p6: userdata) -- Line: 28
        -- upvalues: u5 (ref), u3 (ref), u4 (ref), u1 (copy)
        if not u5.Connected then
            return;
        end;

        if u3 then
            return;
        end;

        u3 = true;
        local u7 = nil;
        local u8 = nil;
        u8 = p6.AncestryChanged:Connect(function(p9, p10) -- Line: 39
            -- upvalues: u8 (ref), u3 (ref), u7 (ref), u4 (ref)
            if p10 == nil and u8.Connected then
                u3 = false;
                u8:Disconnect();

                if u7 ~= nil then
                    task.spawn(u7);

                    if u4 == u7 then
                        u4 = nil;
                    end;

                    u7 = nil;
                end;
            end;
        end);
        local v14, v15 = xpcall(function(p11) -- Line: 54
            -- upvalues: u1 (ref)
            local v12 = u1(p11);

            if v12 ~= nil then
                local v13 = typeof(v12) == "function";
                assert(v13, "callback must return a function or nil");
            end;

            return v12;
        end, debug.traceback, p6);

        if v14 then
            if v15 then
                if u5.Connected and p6.Parent then
                    u7 = v15;
                    u4 = v15;
                else
                    task.spawn(v15);
                end;
            end;

            return;
        end;

        local v16 = string.split(v15, "\n")[1];
        local string_find_ret = string.find(v16, ": ");
        local v17 = not string_find_ret and "" or v16:sub(string_find_ret + 1);
        warn((`error while calling observeLocalCharacter() callback:{v17}\n{v15}`));
    end;

    u5 = LocalPlayer.CharacterAdded:Connect(onCharacterAdded);

    if LocalPlayer.Character then
        task.defer(onCharacterAdded, LocalPlayer.Character);
    end;

    return function() -- Line: 90
        -- upvalues: u5 (ref), u4 (ref)
        u5:Disconnect();

        if u4 ~= nil then
            task.spawn(u4);
            u4 = nil;
        end;
    end;
end;