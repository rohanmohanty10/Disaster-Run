  

local DataStoreService = game:GetService("DataStoreService");
local RunService = game:GetService("RunService");
local script_DataStoreQueue = require(script.DataStoreQueue);
local u1 = {
    AutoSaveData = 180,
    PlayerDS = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_PlayerDS_1.0.0"),
    BasePlayerData = {
        Sessions = 0,
        Transactions = 0,
        CurrentCustomDimension01 = "",
        CurrentCustomDimension02 = "",
        CurrentCustomDimension03 = "",
        ConfigsHash = "",
        AbId = "",
        AbVariantId = "",
        InitAuthorized = false,
        ClientServerTimeOffset = 0,
        RemoteConfigsIsReady = false,
        PlayerTeleporting = false,
        OwnedGamepasses = nil,
        CountryCode = "",
        CustomUserId = "",
        ProgressionTries = {},
        SdkConfig = {},
        Configurations = {}
    },
    DataToSave = { "Sessions", "Transactions", "ProgressionTries", "CurrentCustomDimension01", "CurrentCustomDimension02", "CurrentCustomDimension03", "OwnedGamepasses" },
    PlayerCache = {},
    EventsQueue = {},
    DataStoreQueue = script_DataStoreQueue
};

function u1.GetPlayerData(p2, p3) -- Line: 46
    -- upvalues: script_DataStoreQueue (copy), RunService (copy), u1 (copy)
    local UserId = p3.UserId;
    local v4, v5 = script_DataStoreQueue.AddRequest(UserId, function() -- Line: 48
        -- upvalues: RunService (ref), u1 (ref), UserId (copy)
        return RunService:IsStudio() and {} or (u1.PlayerDS:GetAsync(UserId) or {});
    end, 7);

    return not v4 and {} or v5;
end;

function u1.GetPlayerDataFromCache(p6, p7) -- Line: 58
    -- upvalues: u1 (copy)
    return u1.PlayerCache[tonumber(p7)] or u1.PlayerCache[tostring(p7)];
end;

function u1.GetErrorDataStore(p8, u9) -- Line: 67
    -- upvalues: RunService (copy), DataStoreService (copy)
    local u10 = nil;

    return not pcall(function() -- Line: 69
        -- upvalues: u10 (ref), RunService (ref), DataStoreService (ref), u9 (copy)
        u10 = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_ErrorDS_1.0.0", u9);
    end) and {} or u10;
end;

function u1.SavePlayerData(p11, p12) -- Line: 80
    -- upvalues: u1 (copy), RunService (copy), script_DataStoreQueue (copy)
    local PlayerDataFromCache = u1:GetPlayerDataFromCache(p12.UserId);
    local u13 = {};

    if not PlayerDataFromCache then
        return;
    end;

    for _, v in pairs(u1.DataToSave) do
        u13[v] = PlayerDataFromCache[v];
    end;

    local UserId = p12.UserId;

    if not RunService:IsStudio() then
        script_DataStoreQueue.AddRequest(UserId, function() -- Line: 97
            -- upvalues: u1 (ref), UserId (copy), u13 (copy)
            return u1.PlayerDS:SetAsync(UserId, u13);
        end, 7);
    end;
end;

function u1.IncrementErrorCount(p14, p15, p16, p17) -- Line: 103
    -- upvalues: RunService (copy)
    if p16 then
        local _ = not RunService:IsStudio();

        return 0;
    end;
end;

return u1;