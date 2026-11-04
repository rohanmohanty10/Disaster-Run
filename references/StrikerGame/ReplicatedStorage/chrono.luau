 

 

local u1 = game:GetService("RunService"):IsServer();
local Config = require(script.Shared.Config);
local HttpService = game:GetService("HttpService");
local Stats = require(script.Shared.Stats);
local Player = require(script.Server.Player);
local Receiver = require(script.Server.Receiver);
local ServerClock = require(script.Server.ServerClock);
local Entity = require(script.Shared.Entity);
local Events = require(script.Shared.Events);
local Holder = require(script.Shared.Holder);
local ReplicationRules = require(script.Shared.ReplicationRules);
local Snapshots = require(script.Shared.Snapshots);
require(script.Shared.Types);
local EntityGrid = require(script.Server.EntityGrid);

local function CheckVersion() -- Line: 36
    -- upvalues: HttpService (copy), Config (copy)
    task.spawn(function() -- Line: 37
        -- upvalues: HttpService (ref), Config (ref)
        pcall(function() -- Line: 38
            -- upvalues: HttpService (ref), Config (ref)
            local success, result = pcall(function() -- Line: 40
                -- upvalues: HttpService (ref)
                return HttpService:GetAsync("https://api.github.com/repos/Parihsz/Chrono/releases/latest");
            end);

            if not success then
                return;
            end;

            local tag_name = HttpService:JSONDecode(result).tag_name;
            local v2 = Config._GetConfig("__VERSION");

            if tag_name ~= v2 then
                warn(("bronewversion"):format(v2, tag_name));
            end;
        end);
    end);
end;

local u3 = false;

return {
    Start = function(p4: userdata?) -- Line: 62, Name: Start
        -- upvalues: u3 (ref), u1 (copy), Config (copy), HttpService (copy)
        if u3 then
            warn("Replication: Already Started. Ignoring subsequent calls.");

            return;
        end;

        u3 = true;

        if p4 then
            require(p4);
        end;

        if u1 then
            require(script.Server.Replicate);
        else
            require(script.Client.Replicate);
        end;

        Config._Lock();

        if u1 and Config._GetConfig("CHECK_NEW_VERSION") then
            task.spawn(function() -- Line: 37
                -- upvalues: HttpService (ref), Config (ref)
                pcall(function() -- Line: 38
                    -- upvalues: HttpService (ref), Config (ref)
                    local success, result = pcall(function() -- Line: 40
                        -- upvalues: HttpService (ref)
                        return HttpService:GetAsync("https://api.github.com/repos/Parihsz/Chrono/releases/latest");
                    end);

                    if not success then
                        return;
                    end;

                    local tag_name = HttpService:JSONDecode(result).tag_name;
                    local v5 = Config._GetConfig("__VERSION");

                    if tag_name ~= v5 then
                        warn(("bronewversion"):format(v5, tag_name));
                    end;
                end);
            end);
        end;

        local v6 = Config._GetConfig("__VERSION");
        print((`Replication {v6} Started.`));
    end,

    Holder = Holder,
    Entity = Entity,
    Stats = Stats,
    Config = Config,
    ReplicationRules = ReplicationRules,
    Events = Events,
    Snapshots = Snapshots,
    ServerClock = ServerClock,
    Player = Player,
    ServerReceiver = Receiver,
    EntityGrid = EntityGrid
};