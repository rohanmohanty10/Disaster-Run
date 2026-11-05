  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local _ = game.Players.LocalPlayer;
local u1 = Knit.CreateController({
    Name = "PingController"
});
u1.Remote = nil;
u1.Data = nil;
u1.Last = {};
local u2 = nil;

function u1.KnitStart(p3, p4) -- Line: 19
    -- upvalues: u1 (copy), u2 (ref), Knit (copy)
    u1.Clock = os.clock();
    u1.Remote = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("NewPing");
    u1.Data = require(script:WaitForChild("Data"));
    u2 = Knit.GetService("PingService");
    u1.Remote.OnClientEvent:Connect(function() -- Line: 25
        -- upvalues: u1 (ref)
        u1.Clock = os.clock();
    end);
end;

function u1.Get() -- Line: 35
    -- upvalues: u1 (copy)
    local v5 = {};
    local v6 = {};

    for i, v in pairs(u1.Data) do
        local v7 = v(v5);

        if u1.Last[i] ~= v7 then
            v6[i] = v7;
            u1.Last[i] = v7;
        end;
    end;

    return v6;
end;

local u8 = 0;

function u1.Ping() -- Line: 49
    -- upvalues: u8 (ref), u1 (copy)
    local v9 = os.clock();

    if u8 < v9 then
        u8 = v9 + 0.022222222222222223;
        u1.Remote:FireServer(u1.Get());
    end;
end;

function u1.GetClock() -- Line: 57
    -- upvalues: u1 (copy)
    return u1.Clock;
end;

return u1;