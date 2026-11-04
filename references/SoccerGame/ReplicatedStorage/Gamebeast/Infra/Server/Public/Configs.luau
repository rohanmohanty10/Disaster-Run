  

local v1 = {};
game:GetService("ReplicatedStorage");
local InternalConfigs = require(script.Parent.Parent.Modules.InternalConfigs);

function v1.Get(p2, p3) -- Line: 37
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:Get(nil, p3);
end;

function v1.GetForPlayer(p4: table, p5: userdata, p6: any) -- Line: 41
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:Get(p5, p6);
end;

function v1.Observe(u7: table, u8: any, u9: function) -- Line: 45
    local u10 = u7:OnChanged(u8, u9);
    task.spawn(function() -- Line: 48
        -- upvalues: u7 (copy), u8 (copy), u10 (copy), u9 (copy)
        local v11 = u7:Get(u8);

        if u10.Connected then
            u9(v11, nil);
        end;
    end);

    return u10;
end;

function v1.ObserveForPlayer(u12: table, u13: userdata, u14: any, u15: function) -- Line: 59
    local u16 = u12:OnChangedForPlayer(u13, u14, u15);
    task.spawn(function() -- Line: 62
        -- upvalues: u12 (copy), u13 (copy), u14 (copy), u16 (copy), u15 (copy)
        local ForPlayer = u12:GetForPlayer(u13, u14);

        if u16.Connected then
            u15(ForPlayer, nil);
        end;
    end);

    return u16;
end;

function v1.OnChanged(p17: table, p18: any, p19: function) -- Line: 72
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:OnChanged(nil, p18, p19);
end;

function v1.OnChangedForPlayer(p20: table, p21: userdata, p22: any, p23: function) -- Line: 76
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:OnChanged(p21, p22, p23);
end;

function v1.OnReady(p24: table, p25: function) -- Line: 80
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:OnReady(p25);
end;

function v1.IsReady(p26) -- Line: 84
    -- upvalues: InternalConfigs (copy)
    return InternalConfigs:IsReady();
end;

return v1;