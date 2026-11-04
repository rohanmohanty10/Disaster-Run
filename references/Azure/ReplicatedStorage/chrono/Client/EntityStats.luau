 

 

local Shared = script.Parent.Parent.Shared;
local ClientClock = require(script.Parent.ClientClock);
local Stats = require(Shared.Stats);
local Entity = require(Shared.Entity);
local Holder = require(Shared.Holder);
local CLIENT = Stats.CLIENT;
local idMap = Holder.idMap;

return function() -- Line: 11, Name: UpdateEntityStats
    -- upvalues: Stats (copy), CLIENT (copy), idMap (copy), ClientClock (copy), Entity (copy)
    if not Stats.SERVER._SHOULD_REPLICATE or CLIENT._PAUSE then
        return;
    end;

    local v1 = {};

    for _, v in idMap do
        local id = v.id;
        local entityConfig = v.entityConfig;
        local v2 = entityConfig and entityConfig.NAME or "DEFAULT";
        local networkOwner = v.networkOwner;
        local v3 = v._player ~= nil;
        local v4 = v.latestTime or 0;
        local v5 = v.lastReplicatedTime or 0;
        local _clientClock = v._clientClock;

        if not _clientClock then
            local CLIENT_CLOCK = v.entityConfig.CLIENT_CLOCK;

            if CLIENT_CLOCK then
                _clientClock = v.isHalfTicked and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL;
            end;
        end;

        local v6 = 0;
        local v7 = 0;
        local v8, v9;

        if _clientClock then
            v8 = _clientClock:GetTargetRenderTime();
            local buffer = _clientClock.buffer;

            if buffer then
                v6 = buffer.averageLatency;
                v7 = buffer.deviation;
            end;

            v9 = ClientClock._getBuffer(_clientClock);
        else
            v8 = 0;
            v9 = 0;
        end;

        local PrimaryPart = Entity.GetPrimaryPart(v);
        local snapshot = v.snapshot;

        if PrimaryPart then
            PrimaryPart = PrimaryPart.Position;
        end;

        local v10 = {};
        local v11;

        if snapshot then
            v11 = v;

            for _, v12 in snapshot.cache do
                table.insert(v10, {
                    t = v12.t,
                    value = v12.value,
                    velocity = v12.velocity
                });
            end;

            table.sort(v10, function(p12, p13) -- Line: 57
                return p12.t > p13.t;
            end);
        else
            v11 = v;
        end;

        table.insert(v1, {
            id = id,
            entity = v11,
            networkOwner = networkOwner,
            isCharacter = v3,
            config = v2,
            lastReceivedTime = v4,
            lastReplicatedTime = v5,
            targetTime = v8,
            averageLatency = v6,
            deviation = v7,
            bufferedTime = v9,
            currentPosition = PrimaryPart,
            snapshots = v10
        });
    end;

    CLIENT.CLIENT_ENTITIES = v1;
end;