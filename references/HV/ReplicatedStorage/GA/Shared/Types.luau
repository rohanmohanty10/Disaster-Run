 

 

local v1 = {
    EventType = {
        SESSION_START = "session_start",
        SESSION_END = "session_end",
        CUSTOM = "custom_event",
        PROGRESSION = "progression_event",
        ECONOMY = "economy_event",
        INTERACTION = "interaction_event",
        BUSINESS = "business_event"
    },
    ProgressionStatus = {
        START = "start",
        COMPLETE = "complete",
        FAIL = "fail"
    },
    EconomyFlow = {
        SOURCE = "source",
        SINK = "sink"
    },
    BusinessType = {
        GAMEPASS = "gamepass",
        DEV_PRODUCT = "dev_product",
        PREMIUM = "premium"
    },
    _validEventTypes = {}
};

for _, v in v1.EventType do
    v1._validEventTypes[v] = true;
end;

v1._validProgressionStatuses = {};

for _, v in v1.ProgressionStatus do
    v1._validProgressionStatuses[v] = true;
end;

v1._validEconomyFlows = {};

for _, v in v1.EconomyFlow do
    v1._validEconomyFlows[v] = true;
end;

v1._validBusinessTypes = {};

for _, v in v1.BusinessType do
    v1._validBusinessTypes[v] = true;
end;

return v1;