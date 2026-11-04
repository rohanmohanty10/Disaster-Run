  

local v1 = {};
local ClientConfigs = require(script.Parent.Parent.Modules.ClientConfigs);

function v1.Get(p2, p3) -- Line: 35
    -- upvalues: ClientConfigs (copy)
    return ClientConfigs:Get(p3);
end;

function v1.Observe(u4: table, u5: any, u6: function) -- Line: 39
    local u7 = u4:OnChanged(u5, u6);
    task.spawn(function() -- Line: 42
        -- upvalues: u4 (copy), u5 (copy), u7 (copy), u6 (copy)
        local v8 = u4:Get(u5);

        if u7.Connected then
            u6(v8, nil);
        end;
    end);

    return u7;
end;

function v1.OnChanged(p9: table, p10: any, p11: function) -- Line: 53
    -- upvalues: ClientConfigs (copy)
    return ClientConfigs:OnChanged(p10, p11);
end;

function v1.OnReady(p12: table, p13: function) -- Line: 57
    -- upvalues: ClientConfigs (copy)
    return ClientConfigs:OnReady(p13);
end;

function v1.IsReady(p14) -- Line: 61
    -- upvalues: ClientConfigs (copy)
    return ClientConfigs:IsReady();
end;

function v1.GetForPlayer(p15: table, p16: userdata, p17: any) -- Line: 67
    error("Configs:GetForPlayer is a server-only method. Use :Get instead.");
end;

function v1.ObserveForPlayer(p18: table, p19: userdata, p20: any, p21: function) -- Line: 71
    error("Configs:ObserveForPlayer is a server-only method. Use :Observe instead.");
end;

function v1.OnChangedForPlayer(p22: table, p23: userdata, p24: any, p25: function) -- Line: 75
    error("Configs:OnChangedForPlayer is a server-only method. Use :OnChanged instead.");
end;

return v1;