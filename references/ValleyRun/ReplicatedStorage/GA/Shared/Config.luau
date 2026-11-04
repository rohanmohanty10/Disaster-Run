 

 

return {
    DEFAULT = {
        API_ENDPOINT = "https://ingest.kosmic.games/v1/ingest",
        BATCH_SIZE = 200,
        FLUSH_INTERVAL = 10,
        MAX_QUEUE_SIZE = 5000,
        SESSION_HEARTBEAT = 60,
        SDK_VERSION = "2.4",
        MAX_PROPERTIES = 50,
        MAX_PROPERTY_KEY_LENGTH = 64,
        MAX_PROPERTY_VALUE_LENGTH = 256,
        REPLAY_ENDPOINT = "https://ingest.kosmic.games/v1/replay",
        REPLAY_WINDOW_SECONDS = 15,
        REPLAY_RATE_HZ = 10,
        REPLAY_BYTE_BUDGET = 1000000,
        REPLAY_FORMAT_VERSION = 1,
        REPLAY_SAMPLE_RATE = 0
    },

    isApiKey = function(p1) -- Line: 32, Name: isApiKey
        local v2;

        if typeof(p1) == "Secret" then
            v2 = true;
        elseif type(p1) == "string" then
            v2 = #p1 > 0;
        else
            v2 = false;
        end;

        return v2;
    end,

    authorizationHeader = function(p3) -- Line: 36, Name: authorizationHeader
        if typeof(p3) == "Secret" then
            return p3:AddPrefix("Bearer ");
        end;

        return "Bearer " .. p3;
    end
};