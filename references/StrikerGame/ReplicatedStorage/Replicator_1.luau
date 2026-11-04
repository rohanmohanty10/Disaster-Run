 
 

local RunService = game:GetService("RunService");
local u1 = require("@self/Types");
local u2 = {
    started = false,
    Events = require("@self/Events"),
    Clock = require("@self/Clock"),
    Snapshots = require("@self/Snapshots"),
    Codec = require("@self/Codec"),
    config = u1.defaultConfig()
};
local u3;

if RunService:IsServer() then
    u3 = require("@self/Server");
else
    u3 = require("@self/Client");
end;

for i, v in u3 do
    if string.sub(i, 1, 1) ~= "_" then
        u2[i] = v;
    end;
end;

function u2.start(p4) -- Line: 32
    -- upvalues: u2 (copy), u1 (copy), u3 (copy), RunService (copy)
    if u2.started then
        warn("Replicator already started");

        return;
    end;

    u2.started = true;
    local v5 = u1.defaultConfig();

    if typeof(p4) == "Instance" then
        p4 = require(p4);
    end;

    if type(p4) == "table" then
        for i, v in p4 do
            v5[i] = v;
        end;
    end;

    u2.config = v5;
    u3.start(v5);
    print((`Replicator started ({RunService:IsServer() and "server" or "client"} tick is {math.round(1 / v5.tickRate)} Hz)`));
end;

return u2;