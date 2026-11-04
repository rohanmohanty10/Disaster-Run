  

local v1 = {};
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local MetaData = require(script.Parent.Parent.Parent.MetaData);
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local Utilities = require(script.Parent.Utilities);
local GBRequests = require(script.Parent.GBRequests);
local Changesets = require(script.Parent.Changesets);
local InternalExperiments = require(script.Parent.InternalExperiments);
local InternalConfigs = require(script.Parent.InternalConfigs);
local u2 = require(script.Parent.DatastoreBackup).new(RunService:IsStudio());
local u3 = false;
local u4 = nil;
local u5 = 0;
local u6 = nil;

local function GetBackupKey() -- Line: 106
    -- upvalues: DataCache (copy), RunService (copy)
    return "Configs_" .. (DataCache:Get("Settings").environment or (RunService:IsStudio() and "studio" or "production"));
end;

local function ParseVersion(p7) -- Line: 113
    if type(p7) ~= "string" then
        return nil;
    end;

    local string_match_ret, v8, v9 = string.match(p7, "^v?(%d+)%.(%d+)%.(%d+)");

    return string_match_ret and { tonumber(string_match_ret), tonumber(v8), (tonumber(v9)) } or nil;
end;

local function IsFiniteNumber(p10) -- Line: 126
    local v11;

    if type(p10) == "number" and (p10 == p10 and p10 ~= (1 / 0)) then
        v11 = p10 ~= (-1 / 0);
    else
        v11 = false;
    end;

    return v11;
end;

function v1.GetConnectionRetryDelay(p12: table, p13: number, p14: number?, p15: number?) -- Line: 133
    return ((p14 == 401 or p14 == 403) and 300 or math.min(2 ^ (p13 - 1) * 10, 300)) * (1 + (p15 or math.random()) * 0.25);
end;

function v1.IsVersionOutdated(p16: table, p17: string, p18: string) -- Line: 144
    -- upvalues: ParseVersion (copy)
    local v19 = ParseVersion(p17);
    local v20 = ParseVersion(p18);

    if not (v19 and v20) then
        return false;
    end;

    if v19[1] ~= v20[1] then
        return v19[1] < v20[1];
    end;

    if v19[2] ~= v20[2] then
        return v19[2] < v20[2];
    end;

    if v19[3] == v20[3] then
        return false;
    end;

    return v19[3] < v20[3];
end;

function v1.SetPollingDirective(p21: table, p22: table?) -- Line: 163
    -- upvalues: Utilities (copy), u4 (ref), u5 (ref), DataCache (copy)
    if p22 ~= nil and type(p22) ~= "table" then
        Utilities.GBLog("Ignoring malformed polling directive:", p22);
        p22 = nil;
    end;

    local v23;

    if p22 then
        v23 = p22.intervalSeconds;
    else
        v23 = p22;
    end;

    if v23 ~= nil then
        local v24;

        if type(v23) == "number" and (v23 == v23 and v23 ~= (1 / 0)) then
            v24 = v23 ~= (-1 / 0);
        else
            v24 = false;
        end;

        if not v24 then
            Utilities.GBLog("Ignoring non-numeric poll interval from the backend:", v23);
            v23 = nil;
        end;
    end;

    if p22 then
        p22 = p22.jitterRatio;
    end;

    if p22 ~= nil then
        local v25;

        if type(p22) == "number" and (p22 == p22 and p22 ~= (1 / 0)) then
            v25 = p22 ~= (-1 / 0);
        else
            v25 = false;
        end;

        if not (v25 and (p22 >= 0 and p22 <= 1)) then
            Utilities.GBLog((`Ignoring poll jitter ratio of {p22}, expected a number between 0 and {1}`));
            p22 = nil;
        end;
    end;

    u4 = v23;
    u5 = p22 or 0;
    local statusPollRate = DataCache:Get("Settings").statusPollRate;

    if v23 and v23 < statusPollRate then
        Utilities.GBLog((`Backend asked for a {v23}s poll interval, under the statusPollRate setting of {statusPollRate}s; staying on the setting`));
    end;
end;

function v1.GetPollDelay(p26: table, p27: number?) -- Line: 195
    -- upvalues: DataCache (copy), u4 (ref), u5 (ref)
    local statusPollRate = DataCache:Get("Settings").statusPollRate;

    if u4 and statusPollRate < u4 then
        statusPollRate = u4;
    end;

    return statusPollRate * (1 + (p27 or math.random()) * u5);
end;

function v1.ComposeAndApplyConfig(p28: table, p29: number, p30: boolean?, p31: table?) -- Line: 206
    -- upvalues: InternalConfigs (copy), Changesets (copy), InternalExperiments (copy), Players (copy)
    local BaseConfig = InternalConfigs:GetBaseConfig(p29);

    if not BaseConfig then
        return;
    end;

    InternalConfigs:ApplyConfigs(nil, p29, Changesets.apply(BaseConfig.base, InternalExperiments:GetChangesetsForConfig(p29)), p30, p31);

    for _, v in Players:GetPlayers() do
        if InternalExperiments:HasPlayerOverlays(v, p29) then
            InternalConfigs:ApplyConfigs(v, p29, Changesets.apply(BaseConfig.base, InternalExperiments:GetChangesetsForConfig(p29, v)), p30, p31);
        elseif BaseConfig.viewByPlayer[v] then
            InternalConfigs:ApplyConfigs(v, p29, nil, p30, p31);
        end;
    end;
end;

function v1.ComposeAndApplyAll(p32: table, p33: boolean?, p34: table?) -- Line: 226
    -- upvalues: InternalConfigs (copy)
    for i in InternalConfigs:GetConfigHashes() do
        local v35;

        if p34 then
            v35 = p34[i];
        else
            v35 = p34;
        end;

        p32:ComposeAndApplyConfig(i, p33, v35);
    end;
end;

function v1.ComposeAndApplyForPlayer(p36: table, p37: userdata) -- Line: 233
    -- upvalues: InternalConfigs (copy), InternalExperiments (copy), Changesets (copy)
    for i in InternalConfigs:GetConfigHashes() do
        local BaseConfig = InternalConfigs:GetBaseConfig(i);

        if BaseConfig then
            if InternalExperiments:HasPlayerOverlays(p37, i) then
                InternalConfigs:ApplyConfigs(p37, i, (Changesets.apply(BaseConfig.base, InternalExperiments:GetChangesetsForConfig(i, p37))));
            elseif BaseConfig.viewByPlayer[p37] then
                InternalConfigs:ApplyConfigs(p37, i, nil);
            end;
        end;
    end;
end;

function v1.ApplyBootstrap(p38: table, u39: any, p40: boolean?) -- Line: 251
    -- upvalues: InternalConfigs (copy), InternalExperiments (copy), Utilities (copy)
    p38:SetPollingDirective(u39.polling);
    local v41 = {};
    local v42 = {};

    for _, v in u39.configurations do
        v41[v.id] = InternalConfigs:SetBaseConfig(v);
        v42[v.id] = true;
    end;

    for i in InternalConfigs:GetConfigHashes() do
        if not v42[i] then
            InternalConfigs:RemoveConfig(i);
        end;
    end;

    if u39.experiments then
        local coroutine_running_ret = coroutine.running();
        local u43 = false;
        task.spawn(function() -- Line: 273
            -- upvalues: InternalExperiments (ref), u39 (copy), u43 (ref), coroutine_running_ret (copy)
            InternalExperiments:UpdateCatalog(u39.experiments, u39.requiredProperties);

            if not u43 then
                u43 = true;
                coroutine.resume(coroutine_running_ret);
            end;
        end);
        task.delay(10, function() -- Line: 280
            -- upvalues: u43 (ref), Utilities (ref), coroutine_running_ret (copy)
            if not u43 then
                u43 = true;
                Utilities.GBWarn("Initial experiment assignment taking unusually long, temporarily falling back to canonical config");
                coroutine.resume(coroutine_running_ret);
            end;
        end);

        if not u43 then
            coroutine.yield();
        end;
    end;

    p38:ComposeAndApplyAll(p40, v41);
    InternalConfigs:SetReady();
    p38:QueueBackupSave();
end;

function v1.ApplyStatus(p44, p45) -- Line: 303
    -- upvalues: InternalConfigs (copy), Utilities (copy), GBRequests (copy), InternalExperiments (copy)
    p44:SetPollingDirective(p45.polling);
    local ConfigHashes = InternalConfigs:GetConfigHashes();
    local v46 = {};
    local v47 = true;

    for _, v in p45.configurations do
        v46[v.id] = true;

        if ConfigHashes[v.id] == v.hash then
            InternalConfigs:UpdateConfigIdentity(v.id, v.name, v.alias);
        else
            local v48 = v.alias or v.name;

            if v48 then
                local v49, v50, v51 = GBRequests:GBRequestAsync("v2/configurations", {
                    configuration = v48,
                    hash = ConfigHashes[v.id]
                });

                if v51 == 304 then
                    Utilities.GBLog("Config", v.id, "is not updated yet where it is fetched from; retrying next poll");
                    v47 = false;
                elseif v49 and v50 then
                    if type(v50.hash) == "string" then
                        if v50.configurationId == nil or tonumber(v50.configurationId) == v.id then
                            if v50.hash ~= v.hash then
                                v47 = false;
                            end;

                            local v52 = InternalConfigs:SetBaseConfig({
                                id = v.id,
                                name = v.name,
                                alias = v.alias,
                                hash = v50.hash,
                                updatedAt = v50.updatedAt,
                                configuration = v50.configuration,
                                privacy = v50.privacy
                            });
                            p44:ComposeAndApplyConfig(v.id, nil, v52);
                            p44:QueueBackupSave();
                        else
                            Utilities.GBLog("Config", v.id, "fetched as", v50.configurationId, "; retrying next poll");
                            v47 = false;
                        end;
                    else
                        Utilities.GBWarn("Config", v.id, "was returned without a hash and was not applied.");
                        v47 = false;
                    end;
                else
                    Utilities.GBWarn("Failed to fetch updated config:", v.id);
                    v47 = false;
                end;
            else
                Utilities.GBWarn("Config", v.id, "has no alias or name and cannot be refetched.");
            end;
        end;
    end;

    for i in ConfigHashes do
        if not v46[i] then
            Utilities.GBLog("Config removed:", i);
            InternalConfigs:RemoveConfig(i);
            p44:QueueBackupSave();
        end;
    end;

    if not InternalExperiments:UpdateCatalog(p45.experiments, p45.requiredProperties) then
        v47 = false;
    end;

    return v47;
end;

function v1.GetBackupConfigs(p53) -- Line: 400
    -- upvalues: u2 (copy), DataCache (copy), RunService (copy), Utilities (copy)
    local v54, v55 = u2:Get("Configs_" .. (DataCache:Get("Settings").environment or (RunService:IsStudio() and "studio" or "production")));

    if v54 then
        if v55 and v55.schemaVersion == 2 then
            return v55.configurations;
        end;

        return nil;
    end;

    Utilities.GBWarn("Couldn\'t get configs from backup. Attempting to re-establish connection with Gamebeast...");

    return nil;
end;

function v1.SaveConfigsToBackup(p56) -- Line: 418
    -- upvalues: InternalConfigs (copy), u2 (copy), DataCache (copy), RunService (copy)
    local v57 = {};

    for i in InternalConfigs:GetConfigHashes() do
        local BaseConfig = InternalConfigs:GetBaseConfig(i);

        if BaseConfig then
            table.insert(v57, {
                id = BaseConfig.id,
                name = BaseConfig.name,
                alias = BaseConfig.alias,
                hash = BaseConfig.hash,
                updatedAt = BaseConfig.updatedAt,
                configuration = BaseConfig.base,
                privacy = BaseConfig.privacy
            });
        end;
    end;

    u2:Set("Configs_" .. (DataCache:Get("Settings").environment or (RunService:IsStudio() and "studio" or "production")), {
        schemaVersion = 2,
        savedAt = DateTime.now().UnixTimestampMillis,
        configurations = v57
    });
end;

function v1.QueueBackupSave(u58) -- Line: 443
    -- upvalues: u3 (ref)
    if u3 then
        return;
    end;

    u3 = true;
    task.delay(30, function() -- Line: 449
        -- upvalues: u3 (ref), u58 (copy)
        u3 = false;
        u58:SaveConfigsToBackup();
    end);
end;

function v1.Init(u59) -- Line: 456
    -- upvalues: GBRequests (copy), MetaData (copy), Utilities (copy), InternalExperiments (copy), InternalConfigs (copy), u6 (ref)
    task.spawn(function() -- Line: 459
        -- upvalues: GBRequests (ref), u59 (copy), MetaData (ref), Utilities (ref)
        local v60, v61 = GBRequests:GBRequestAsync("v1/latest/version?platform=roblox");

        if v60 and (v61 and u59:IsVersionOutdated(MetaData.version, v61.version)) then
            Utilities.GBWarn((`Gamebeast SDK is out of date! Please update to the latest version. {MetaData.version} -> {v61.version}`));
        end;
    end);

    local function fetchBootstrap() -- Line: 468
        -- upvalues: GBRequests (ref)
        local v62, v63, v64 = GBRequests:GBRequestAsync("v2/bootstrap");

        if not v62 then
            v63 = nil;
        end;

        return v63, v64;
    end;

    local function tryApply(p65: any, p66: boolean) -- Line: 475
        -- upvalues: u59 (copy), Utilities (ref)
        local success, result = pcall(u59.ApplyBootstrap, u59, p65, p66);

        if not success then
            Utilities.GBWarn("Failed to apply configurations from Gamebeast:", result);
        end;

        return success;
    end;

    local v67, v68, v69 = GBRequests:GBRequestAsync("v2/bootstrap");

    if not v67 then
        v68 = nil;
    end;

    local v70, v71, v72, v73, v74, v75, v76, v77, v78, v79;

    if v68 then
        local success, result = pcall(u59.ApplyBootstrap, u59, v68, true);

        if not success then
            Utilities.GBWarn("Failed to apply configurations from Gamebeast:", result);
        end;

        if not success then
            Utilities.GBWarn("Couldn\'t get configurations from Gamebeast. Attempting to load from backup...");
            v70 = true;
            v71 = u59:GetBackupConfigs();

            if v71 then
                v72, v73 = pcall(u59.ApplyBootstrap, u59, {
                    configurations = v71,
                    experiments = {
                        user = {},
                        server = {}
                    },
                    requiredProperties = {}
                }, true);

                if not v72 then
                    Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v73);
                end;

                if v72 then
                    v70 = false;
                end;
            end;

            v74 = 0;

            while true do
                if true then
                    v74 = v74 + 1;
                    v75 = u59:GetConnectionRetryDelay(v74, v69);
                    Utilities.GBWarn((`Couldn't reach Gamebeast; retrying in {math.ceil(v75)}s.`));
                    task.wait(v75);
                    v76, v77, v69 = GBRequests:GBRequestAsync("v2/bootstrap");

                    if not v76 then
                        v77 = nil;
                    end;

                    if v77 then
                        v78, v79 = pcall(u59.ApplyBootstrap, u59, v77, v70);

                        if not v78 then
                            Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v79);
                        end;

                        if v78 then
                            break;
                        end;
                    end;
                else
                    v78, v79 = pcall(u59.ApplyBootstrap, u59, v77, v70);

                    if not v78 then
                        Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v79);
                    end;

                    if v78 then
                        break;
                    end;
                end;
            end;

            Utilities.GBWarn("Connection to Gamebeast established.");
        end;
    else
        Utilities.GBWarn("Couldn\'t get configurations from Gamebeast. Attempting to load from backup...");
        v70 = true;
        v71 = u59:GetBackupConfigs();

        if v71 then
            v72, v73 = pcall(u59.ApplyBootstrap, u59, {
                configurations = v71,
                experiments = {
                    user = {},
                    server = {}
                },
                requiredProperties = {}
            }, true);

            if not v72 then
                Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v73);
            end;

            if v72 then
                v70 = false;
            end;
        end;

        v74 = 0;

        while true do
            if true then
                v74 = v74 + 1;
                v75 = u59:GetConnectionRetryDelay(v74, v69);
                Utilities.GBWarn((`Couldn't reach Gamebeast; retrying in {math.ceil(v75)}s.`));
                task.wait(v75);
                v76, v77, v69 = GBRequests:GBRequestAsync("v2/bootstrap");

                if not v76 then
                    v77 = nil;
                end;

                if v77 then
                    v78, v79 = pcall(u59.ApplyBootstrap, u59, v77, v70);

                    if not v78 then
                        Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v79);
                    end;

                    if v78 then
                        break;
                    end;
                end;
            else
                v78, v79 = pcall(u59.ApplyBootstrap, u59, v77, v70);

                if not v78 then
                    Utilities.GBWarn("Failed to apply configurations from Gamebeast:", v79);
                end;

                if v78 then
                    break;
                end;
            end;
        end;

        Utilities.GBWarn("Connection to Gamebeast established.");
    end;

    InternalExperiments.OnServerAssignmentsChanged:Connect(function() -- Line: 516
        -- upvalues: InternalConfigs (ref), u59 (copy)
        if InternalConfigs:IsReady() then
            u59:ComposeAndApplyAll();
        end;
    end);
    InternalExperiments.OnPlayerAssignmentsChanged:Connect(function(p80: userdata) -- Line: 522
        -- upvalues: InternalConfigs (ref), u59 (copy)
        if InternalConfigs:IsReady() then
            u59:ComposeAndApplyForPlayer(p80);
        end;
    end);
    task.spawn(function() -- Line: 529
        -- upvalues: u59 (copy), GBRequests (ref), u6 (ref), Utilities (ref)
        local v81 = tick();
        local math_random_ret = math.random();

        while true do
            while true do
                local v82 = u59:GetPollDelay(math_random_ret) - (tick() - v81);

                if v82 <= 0 then
                    break;
                end;

                task.wait((math.min(v82, 5)));
            end;

            local v83, v84, v85 = GBRequests:GBRequestAsync("v2/status", {
                hash = u6
            });

            if v85 == 304 then
                Utilities.GBLog("Status unchanged since the last poll");
            elseif v83 and v84 then
                local success, result = pcall(u59.ApplyStatus, u59, v84);

                if success and result then
                    u6 = v84.hash;
                elseif success then
                    u6 = nil;
                    Utilities.GBLog("Status poll applied in part; retrying the rest next poll");
                else
                    u6 = nil;
                    Utilities.GBWarn("Failed to apply the status poll:", result);
                end;
            else
                Utilities.GBLog("Status poll failed, retrying next interval");
            end;

            v81 = tick();
            math_random_ret = math.random();
        end;
    end);
end;

return v1;