 
 

local HttpService = game:GetService("HttpService");
local LocalizationService = game:GetService("LocalizationService");
local RunService = game:GetService("RunService");
local script_shardData = require(script.shardData);

local function getShardForCountry(p1: string) -- Line: 23
    -- upvalues: script_shardData (ref)
    for _, v in script_shardData do
        local v2 = v;

        for _, v3 in v.countries do
            if v3 == p1 then
                return v2.id;
            end;
        end;
    end;

    warn("[Shards] No shard found for country", p1, "defaulting to Other shard");

    return -1;
end;

return {
    getShardForCountry = getShardForCountry,

    getShardForPlayer = function(p3: userdata) -- Line: 37, Name: getShardForPlayer
        -- upvalues: LocalizationService (copy), getShardForCountry (copy)
        return getShardForCountry((LocalizationService:GetCountryRegionForPlayerAsync(p3)));
    end,

    getShardName = function(p4: number) -- Line: 43, Name: getShardName
        -- upvalues: script_shardData (ref)
        for _, v in script_shardData do
            if v.id == p4 then
                return v.displayName;
            end;
        end;

        return "Other";
    end,

    loadRemoteShardData = function(u5: string?) -- Line: 53, Name: loadRemoteShardData
        -- upvalues: RunService (copy), HttpService (copy), script_shardData (ref)
        if RunService:IsClient() then
            error("can\'t load remote shard data on the client", 2);
        end;

        local success, result = pcall(function() -- Line: 58
            -- upvalues: HttpService (ref), u5 (copy)
            return HttpService:GetAsync(u5 or "https://oss.playcurrent.com/shards/data/shards.json");
        end);

        if success then
            script_shardData = HttpService:JSONDecode(result);

            return;
        end;

        warn((`[Shards] Could not load remote shard data, will use existing data instead: {result}`));
    end
};