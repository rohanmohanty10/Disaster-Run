  

local v1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local Cleaner = require(script.Parent.Parent.Parent.Shared.Modules.Cleaner);
local u2 = Signal.new();
local u3 = {};
local u4 = {};
local u5 = {};

local function MakeCacheObject() -- Line: 43
    -- upvalues: u3 (copy), u4 (copy)
    local u6 = nil;
    u6 = {
        RawData = {},

        __index = function(p7, p8) -- Line: 46, Name: __index
            -- upvalues: u3 (ref), u6 (ref)
            local v9 = type(p8) == "userdata";
            assert(v9, "PlayerCache keys must be a Player object");

            if u3[p8] then
                u3[p8].LastFetch = os.clock();
            end;

            return u6.RawData[p8];
        end,

        __newindex = function(p10, p11, p12) -- Line: 55, Name: __newindex
            -- upvalues: u6 (ref)
            local v13 = type(p11) == "userdata";
            assert(v13, "PlayerCache keys must be a Player object");

            if not p11.Parent then
                return;
            end;

            u6.RawData[p11] = p12;
        end
    };
    table.insert(u4, u6);

    return setmetatable({}, u6);
end;

function v1.GetCache(p14) -- Line: 73
    -- upvalues: MakeCacheObject (copy)
    return MakeCacheObject();
end;

function v1.OnPlayerAdded(p15: table, u16: function) -- Line: 77
    -- upvalues: u5 (copy), Cleaner (copy), Players (copy)
    local function add(p17) -- Line: 78
        -- upvalues: u5 (ref), Cleaner (ref), u16 (copy)
        if not u5[p17] then
            u5[p17] = Cleaner.new();
        end;

        task.spawn(u16, p17, u5[p17]);
    end;

    for _, v in Players:GetPlayers() do
        if not u5[v] then
            u5[v] = Cleaner.new();
        end;

        task.spawn(u16, v, u5[v]);
    end;

    return Players.PlayerAdded:Connect(add);
end;

function v1.OnPlayerRemoved(p18: table, p19: function) -- Line: 93
    -- upvalues: u2 (copy)
    return u2:Connect(p19);
end;

Players.PlayerRemoving:Connect(function(p20) -- Line: 99
    -- upvalues: u3 (copy)
    u3[p20] = {
        LastFetch = os.clock()
    };
end);
RunService.Heartbeat:Connect(function() -- Line: 105
    -- upvalues: u3 (copy), u4 (copy), u5 (copy), u2 (copy)
    for i, v in u3 do
        if os.clock() - v.LastFetch > 5 then
            u3[i] = nil;
            local v21 = i;

            for _, v2 in u4 do
                v2.RawData[v21] = nil;
            end;

            if u5[v21] then
                u5[v21]:Destroy();
                u5[v21] = nil;
            end;

            u2:Fire(v21);
        end;
    end;
end);

return v1;