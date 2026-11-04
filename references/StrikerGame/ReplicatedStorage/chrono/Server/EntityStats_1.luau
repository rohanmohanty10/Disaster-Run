 
 

local Shared = script.Parent.Parent.Shared;
require(Shared.Types);
local Entity = require(Shared.Entity);
local Holder = require(Shared.Holder);
local SERVER = require(Shared.Stats).SERVER;
local idMap = Holder.idMap;

return function() -- Line: 10, Name: UpdateEntityStats
    -- upvalues: SERVER (copy), idMap (copy), Entity (copy)
    if not SERVER._SHOULD_REPLICATE then
        SERVER.SERVER_ENTITIES = {};

        return;
    end;

    local v1 = {};

    for _, v in idMap do
        local entityConfig = v.entityConfig;
        local v2 = 1 / entityConfig.TICK_RATE;
        local isHalfTicked = v.isHalfTicked;
        local v3;

        if v.latestCFrame then
            v3 = v.latestCFrame.Position or nil;
        else
            v3 = nil;
        end;

        local v4;

        if isHalfTicked == true then
            v4 = v2 / 2;
        else
            v4 = isHalfTicked == nil and 0 or v2;
        end;

        local v5 = v4 // 1;
        local v6 = v._interpolationMode or (v.entityConfig.INTERPOLATION_MODE or "CFRAME");
        local v7 = {
            isPaused = v.paused,
            id = v.id,
            networkOwner = v.networkOwner,
            isCharacter = v._player ~= nil,
            config = entityConfig and (entityConfig.NAME or "DEFAULT") or "DEFAULT",
            tickRate = (v5 ~= v5 or v5 == (1 / 0)) and 0 or v5,
            lastTicked = v.latestTime,
            lastPosition = v3,
            modelType = Entity.GetModelReplicationType(v),
            interpolationMode = v6
        };
        table.insert(v1, v7);
    end;

    SERVER.SERVER_ENTITIES = v1;
end;