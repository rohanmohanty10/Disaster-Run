  

local v1 = {};
game:GetService("Players");
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local Schema = require(script.Parent.Parent.Parent.Shared.Modules.Schema);
local ServerGate = require(script.Parent.ServerGate);
local u2 = Signal.new();
local u3 = Schema.new({
    join_time = {
        type = "number",

        default = function() -- Line: 34, Name: default
            return os.time();
        end
    },
    teleporting_to = {
        default = function() -- Line: 37, Name: default
            return nil;
        end,

        type = { "number", "nil" }
    }
});
local Cache = ServerGate:GetCache();

function v1.SetStat(p4: table, p5: userdata, p6: string, p7: any) -- Line: 52
    -- upvalues: Cache (copy), u3 (copy)
    if not Cache[p5] and p5.Parent then
        p4:Reset(p5);
    end;

    if not u3:HasKey(p6) then
        error("Cannot set stat: " .. p6);
    end;

    Cache[p5][p6] = p7;
end;

function v1.GetStats(p8: table, p9: userdata) -- Line: 64
    -- upvalues: Cache (copy)
    return Cache[p9];
end;

function v1.GetStat(p10: table, p11: userdata, p12: string) -- Line: 68
    -- upvalues: Cache (copy)
    if Cache[p11] then
        return Cache[p11][p12];
    end;

    return nil;
end;

function v1.Clear(p13: table, p14: userdata) -- Line: 75
    -- upvalues: Cache (copy)
    Cache[p14] = nil;
end;

function v1.Reset(p15: table, p16: userdata) -- Line: 79
    -- upvalues: Cache (copy), u3 (copy), u2 (copy)
    Cache[p16] = u3:GetDefault();
    u2:Fire(p16, Cache[p16]);
end;

function v1.OnDefaultStatsResolved(p17: table, u18: userdata, u19: function) -- Line: 85
    -- upvalues: u2 (copy), Cache (copy)
    local u20 = nil;
    u20 = u2:Connect(function(p21, p22) -- Line: 86
        -- upvalues: u18 (copy), u19 (copy), u20 (ref)
        if p21 == u18 then
            u19(p22);
            u20:Disconnect();
        end;
    end);

    if Cache[u18] then
        u20:Disconnect();
        task.spawn(function() -- Line: 95
            -- upvalues: u19 (copy), Cache (ref), u18 (copy)
            u19(Cache[u18]);
        end);
    end;

    return u20;
end;

function v1.Init(u23) -- Line: 103
    -- upvalues: ServerGate (copy)
    ServerGate:OnPlayerAdded(function(p24) -- Line: 104
        -- upvalues: u23 (copy)
        u23:Reset(p24);
    end);
end;

return v1;