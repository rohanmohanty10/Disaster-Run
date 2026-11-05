  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedLibraries.Networking.ByteNet);
local u1 = {
    Name = "PingController",
    Last = {},
    Packets = require(Core.ReplicatedLibraries.Networking.Packets.PingService)
};
local v2;

if Core.Context == "Client" then
    v2 = require(script:WaitForChild("Data"));
else
    v2 = false;
end;

u1.Data = v2;

if Core.Context == "Server" then
    return u1;
end;

function u1.Get() -- Line: 14
    -- upvalues: u1 (copy)
    local v3 = {};
    local v4 = {};

    for i, v in pairs(u1.Data) do
        local v5 = v(v3);

        if u1.Last[i] ~= v5 then
            v4[i] = v5;
            u1.Last[i] = v5;
        end;
    end;

    return v4;
end;

function u1.Ping() -- Line: 27
    -- upvalues: u1 (copy)
    local v6 = u1.Get();
    u1.Packets.Ping.send(v6);
end;

function u1._Start() -- Line: 32
    -- upvalues: u1 (copy)
    os.clock();
    local u7 = 0;
    game:GetService("RunService").RenderStepped:Connect(function(p8) -- Line: 37
        -- upvalues: u7 (ref), u1 (ref)
        if u7 <= os.clock() then
            u1.Ping();
            u7 = os.clock() + 0.013333333333333334;
        end;
    end);
end;

return u1;