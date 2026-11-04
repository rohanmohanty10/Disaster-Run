  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Packages.Trove);
local LimitedStyleDrop = require(ReplicatedStorage.Shared.Configs.LimitedStyleDrop);

return function(u1: userdata, u2: function) -- Line: 10, Name: bindLimitedStyleCountdown
    -- upvalues: Trove (copy), LimitedStyleDrop (copy)
    local u3 = Trove.new();
    local u4 = nil;
    u3:Add(function() -- Line: 14, Name: cancelScheduled
        -- upvalues: u4 (ref)
        local v5 = u4;
        u4 = nil;

        if v5 and coroutine.status(v5) == "suspended" then
            task.cancel(v5);
        end;
    end);

    local function refresh() -- Line: 24
        -- upvalues: u4 (ref), u1 (copy), u2 (copy), LimitedStyleDrop (ref), refresh (copy)
        local v6 = u4;
        u4 = nil;

        if v6 and coroutine.status(v6) == "suspended" then
            task.cancel(v6);
        end;

        if not u1.Parent then
            return;
        end;

        u2();
        local os_time_ret = os.time();
        local v7 = LimitedStyleDrop.IsActive(os_time_ret);
        local v8 = LimitedStyleDrop.GetEndTime() - os_time_ret;

        if v8 <= 0 then
            return;
        end;

        if u1.Enabled and v7 then
            v8 = math.min(v8, 1);
        end;

        u4 = task.delay(v8, function() -- Line: 42
            -- upvalues: u4 (ref), refresh (ref)
            u4 = nil;
            refresh();
        end);
    end;

    u3:Connect(u1:GetPropertyChangedSignal("Enabled"), refresh);
    u3:Connect(workspace:GetAttributeChangedSignal("updateTimer"), refresh);
    u3:Connect(workspace:GetAttributeChangedSignal("liveDataAvailable"), refresh);
    u3:Connect(u1.Destroying, function() -- Line: 51
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
    refresh();

    return u3;
end;