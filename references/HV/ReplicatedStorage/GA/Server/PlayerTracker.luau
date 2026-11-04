 

 

local Players = game:GetService("Players");
local v1 = {};
local u2 = {};
local u3 = {};
local u4 = 0;

function v1._init(u5) -- Line: 8
    -- upvalues: u3 (copy), u4 (ref), u2 (copy), Players (copy)
    table.insert(u2, Players.PlayerAdded:Connect(function(p6: userdata) -- Line: 9, Name: added
        -- upvalues: u3 (ref), u4 (ref), u5 (copy)
        if u3[p6] then
            return;
        end;

        u3[p6] = true;
        u4 = u4 + 1;

        if not u5:_beginSession(p6) then
            u5:track(p6, "session_start", {});
        end;
    end));
    table.insert(u2, Players.PlayerRemoving:Connect(function(p7: userdata) -- Line: 25
        -- upvalues: u3 (ref), u4 (ref), u5 (copy)
        if not u3[p7] then
            return;
        end;

        u3[p7] = nil;
        u4 = math.max(0, u4 - 1);
        local v8 = os.time() - u5:getSessionStartedAt(p7);
        local math_max_ret = math.max(0, v8);

        if not u5:_consumeTeleportFlag(p7.UserId) then
            u5:track(p7, "session_end", {
                sessionDuration = math_max_ret
            });
            u5:_fireRealLeave(p7, math_max_ret);
        end;

        u5:_onPlayerLeaving(p7.UserId);
    end));

    for _, v in Players:GetPlayers() do
        if not u3[v] then
            u3[v] = true;
            u4 = u4 + 1;

            if not u5:_beginSession(v) then
                u5:track(v, "session_start", {});
            end;
        end;
    end;
end;

function v1.getActivePlayerCount(p9) -- Line: 48
    -- upvalues: u4 (ref)
    return u4;
end;

function v1.shutdown(p10) -- Line: 52
    -- upvalues: u2 (copy), u3 (copy), u4 (ref)
    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);
    table.clear(u3);
    u4 = 0;
end;

return v1;