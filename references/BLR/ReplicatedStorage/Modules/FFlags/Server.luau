  

local MemoryStoreService = game:GetService("MemoryStoreService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataStoreService = game:GetService("DataStoreService");
local RunService = game:GetService("RunService");
local Replion = require(ReplicatedStorage.Packages.Replion);
local Signal = require(ReplicatedStorage.Packages.Signal);
require(script.Parent.Types);
local Environments = require(script.Parent.Environments);
local Overrides = require(script.Parent.Overrides);
local Random_new_ret = Random.new();
local u1 = nil;
local u2 = nil;
local v3 = {
    _loaded = false,
    _loadedSignal = Signal.new(),
    _updatedSignal = Signal.new()
};

local function waitForBudget(p4: any, p5: number?) -- Line: 61
    -- upvalues: DataStoreService (copy)
    local os_clock_ret = os.clock();
    local v6 = os_clock_ret;
    local v7 = p5 or 10;

    while DataStoreService:GetRequestBudgetForRequestType(p4) < 1 and os_clock_ret - v6 < v7 do
        task.wait();
        os_clock_ret = os.clock();
    end;

    return os_clock_ret - v6 < v7;
end;

function v3.IsLoaded(p8) -- Line: 74
    return p8._loaded;
end;

function v3.OnLoad(p9, p10) -- Line: 78
    return p9._loadedSignal:Connect(p10);
end;

function v3.OnUpdate(p11, p12) -- Line: 82
    return p11._updatedSignal:Connect(p12);
end;

function v3.OnChange(p13, p14, p15) -- Line: 86
    -- upvalues: u2 (ref)
    return u2:OnChange({ "Values", p14 }, p15);
end;

function v3.Get(p16, p17, p18) -- Line: 91
    -- upvalues: u2 (ref)
    if not p16:IsLoaded() then
        p16._loadedSignal:Wait();
    end;

    local v19 = u2:Get({ "Values", p17 });

    if v19 == nil then
        return p18;
    end;

    return v19;
end;

function v3.GetInstant(p20, p21, p22) -- Line: 104
    -- upvalues: u2 (ref)
    local v23 = u2:Get({ "Values", p21 });

    if v23 == nil then
        return p22;
    end;

    return v23;
end;

function v3.Set(p24, u25, u26, u27) -- Line: 113
    -- upvalues: u1 (ref), u2 (ref), Overrides (copy), MemoryStoreService (copy), DataStoreService (copy), waitForBudget (copy)
    if u27 == u1 or (u27 == "all" or u27 == "local") then
        u2:Set({ "Values", u25 }, u26);
        u2:Set("LastChange", workspace:GetServerTimeNow());
    end;

    if u27 == "local" then
        if not Overrides[u1] then
            Overrides[u1] = {};
        end;

        Overrides[u1][u25] = u26;

        return true;
    end;

    local function transformData(p28) -- Line: 128
        -- upvalues: u25 (copy), u27 (copy), u26 (copy)
        local UnixTimestamp = DateTime.now().UnixTimestamp;
        local v29 = not (p28 and (typeof(p28) == "table" and typeof(p28.Values) == "table")) and {
            Values = {},
            LastUpdate = UnixTimestamp
        } or p28;
        local v30 = false;

        for _, v in v29.Values do
            if u25 == v[1] and u27 == v[3] then
                v30 = true;
                v[2] = u26;

                if u27 == nil then
                    table.remove(v, 3);
                else
                    v[3] = u27;
                end;
            end;
        end;

        if not v30 then
            local v31 = { u25, u26 };

            if u27 ~= nil then
                table.insert(v31, u27);
            end;

            table.insert(v29.Values, v31);
        end;

        return v29;
    end;

    for i = 1, 5 do
        local success, result = pcall(function() -- Line: 177
            -- upvalues: MemoryStoreService (ref), i (copy)
            return MemoryStoreService:GetHashMap((`FFlags-{i}`));
        end);
        local v32;

        if success then
            local success2, result2 = pcall(function() -- Line: 186
                -- upvalues: result (copy), transformData (copy)
                return result:UpdateAsync("FFlags", transformData, 3888000);
            end);

            if success2 then
                v32 = i;
            else
                warn((`Failed to update HashMap FFlags-{i}/FFlags: {result2}`));
                v32 = i;
            end;
        else
            warn((`Failed to save HashMap FFlags-{i}/FFlags: {result}`));
            v32 = i;
        end;
    end;

    for i = 1, 3 do
        local success, result = pcall(function() -- Line: 201
            -- upvalues: DataStoreService (ref), i (copy)
            return DataStoreService:GetDataStore((`FFlags-{i}`));
        end);
        local v33;

        if success then
            if not waitForBudget(Enum.DataStoreRequestType.UpdateAsync, 30) then
                warn("No DataStore:UpdateAsync() request budget available");

                return false;
            end;

            local success2, result2 = pcall(function() -- Line: 216
                -- upvalues: result (copy), transformData (copy)
                return result:UpdateAsync("FFlags", transformData);
            end);

            if success2 then
                v33 = i;
            else
                warn((`Failed to update DataStore FFlags-{i}/FFlags: {result2}`));
                v33 = i;
            end;
        else
            warn((`Failed to save DataStore FFlags-{i}/FFlags: {result}`));
            v33 = i;
        end;
    end;

    return true;
end;

function v3._loadMemoryStore(p34, p35) -- Line: 229
    -- upvalues: Random_new_ret (copy), MemoryStoreService (copy)
    local u36 = p35 or Random_new_ret:NextInteger(1, 5);
    local success, result = pcall(function() -- Line: 231
        -- upvalues: MemoryStoreService (ref), u36 (copy)
        return MemoryStoreService:GetHashMap((`FFlags-{u36}`));
    end);

    if not success then
        warn((`MemoryStoreService:GetHashMap() failed on 'FFlags-{u36}': {result}`));

        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 240
        -- upvalues: result (copy)
        return result:GetAsync("FFlags");
    end);

    if not success2 then
        warn((`Failed to load HashMap FFlags-{u36}/FFlags: {result2}`));

        return false;
    end;

    if typeof(result2) ~= "table" or typeof(result2.Values) ~= "table" then
        warn((`Invalid data format in HashMap FFlags-{u36}/FFlags: {result2}`));
        result2 = {
            LastUpdate = 0,
            Values = {}
        };
    end;

    local UnixTimestamp = DateTime.now().UnixTimestamp;
    local v37;

    if typeof(result2.LastUpdate) == "number" then
        v37 = result2.LastUpdate;
    else
        v37 = UnixTimestamp;
    end;

    if UnixTimestamp - v37 >= 2592000 then
        task.spawn(function() -- Line: 261
            -- upvalues: u36 (copy), result (copy)
            print((`Reconciling data in HashMap FFlags-{u36}/FFlags`));
            local success3, result3 = pcall(result.UpdateAsync, result, "FFlags", function(p38) -- Line: 264
                local UnixTimestamp2 = DateTime.now().UnixTimestamp;
                local v39 = (typeof(p38) ~= "table" or typeof(p38.Values) ~= "table") and {
                    LastUpdate = 0,
                    Values = {}
                } or p38;

                if UnixTimestamp2 - (typeof(v39.LastUpdate) ~= "number" and 0 or v39.LastUpdate) < 2592000 then
                    return nil;
                end;

                v39.LastUpdate = UnixTimestamp2;

                return v39;
            end, 3888000);

            if success3 then
                print((`Successfully reconciled data in HashMap FFlags-{u36}/FFlags`));

                return;
            end;

            warn((`Failed to reconcile data in HashMap FFlags-{u36}/FFlags: {result3}`));
        end);
    end;

    return true, result2;
end;

function v3._loadDataStore(p40, p41) -- Line: 299
    -- upvalues: Random_new_ret (copy), DataStoreService (copy), waitForBudget (copy)
    local u42 = p41 or Random_new_ret:NextInteger(1, 3);
    local success, result = pcall(function() -- Line: 301
        -- upvalues: DataStoreService (ref), u42 (copy)
        return DataStoreService:GetDataStore((`FFlags-{u42}`));
    end);

    if not success then
        warn((`DataStoreService:GetDataStore() failed on 'FFlags-{u42}': {result}`));

        return false;
    end;

    local DataStoreGetOptions = Instance.new("DataStoreGetOptions");
    DataStoreGetOptions.UseCache = false;

    if not waitForBudget(Enum.DataStoreRequestType.GetAsync) then
        warn("No DataStore:GetAsync() request budget available");

        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 319
        -- upvalues: result (copy), DataStoreGetOptions (copy)
        return result:GetAsync("FFlags", DataStoreGetOptions);
    end);

    if success2 then
        if typeof(result2) ~= "table" or typeof(result2.Values) ~= "table" then
            warn((`Invalid data format in DataStore FFlags-{u42}/FFlags: {result2}`));
            result2 = {
                LastUpdate = 0,
                Values = {}
            };
        end;

        return true, result2;
    end;

    warn((`Failed to load DataStore FFlags-{u42}/FFlags: {result2}`));

    return false;
end;

function v3.Load(p43) -- Line: 341
    -- upvalues: RunService (copy), u1 (ref), u2 (ref), Replion (copy), Overrides (copy)
    local v44, v45;

    if RunService:IsStudio() then
        v44, v45 = p43:_loadDataStore();
    else
        v44, v45 = p43:_loadMemoryStore();
    end;

    if not v44 then
        local v46 = 0;

        while v46 < 3 and not v44 do
            warn((`Failed to load FFlags {RunService:IsStudio() and "DataStore" or "MemoryStore HashMap"}, retrying...`));
            v46 = v46 + 1;
            task.wait(v46 * 1);
            v44, v45 = p43:_loadMemoryStore();
        end;

        if not v44 then
            warn("All attempts to load FFlags MemoryStore HashMaps failed, loading DataStore instead");
            v44, v45 = p43:_loadDataStore();
        end;
    end;

    if not (v44 and v45) then
        warn("Failed to load FFlags: both MemoryStore and DataStore requests failed!");

        return false;
    end;

    local v47 = {};

    for _, v in v45.Values do
        local v48 = v[1];
        local v49 = v[2];
        local v50 = v[3] or "all";

        if v48 and (v50 ~= "all" or not v47[v48]) and (v50 == u1 or v50 == "all") then
            v47[v48] = v49;
        end;
    end;

    for i, _ in u2.Data.Values do
        if v47[i] == nil then
            v47[i] = Replion.None;
        end;
    end;

    if Overrides[u1] then
        for i, v in Overrides[u1] do
            v47[i] = v;
        end;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    u2:Update({
        Loaded = true,
        LastUpdate = ServerTimeNow,
        LastChange = ServerTimeNow,
        Values = v47
    });

    if RunService:IsStudio() then
        print("Loaded FFlags:", u2.Data);
    end;

    if not p43._loaded then
        p43._loaded = true;
        p43._loadedSignal:Fire(u2.Data);
    end;

    p43._updatedSignal:Fire(u2.Data);

    return true;
end;

function v3.Start(p51) -- Line: 425
    -- upvalues: Environments (copy), u1 (ref), RunService (copy), Random_new_ret (copy)
    for i, v in Environments do
        if v.UniverseIds and table.find(v.UniverseIds, game.GameId) then
            local v52;

            if RunService:IsStudio() and v.StudioEnvironment then
                v52 = v.StudioEnvironment;
            else
                v52 = i;
            end;

            u1 = v52;
        end;

        if not (v.UniverseIds and (#v.UniverseIds ~= 0 or u1)) then
            u1 = i;
        end;
    end;

    if not u1 then
        warn((`Failed to find matching Environment for UniverseId {game.GameId}`));

        return;
    end;

    local v53 = 0;

    while true do
        local ServerTimeNow = workspace:GetServerTimeNow();

        if v53 < ServerTimeNow then
            v53 = ServerTimeNow + 300 * Random_new_ret:NextNumber(0.7, 1.3);
            p51:Load();
        end;

        task.wait(1);
    end;
end;

u2 = Replion.Server.new({
    Channel = "FFlags",
    ReplicateTo = "All",
    Data = {
        Loaded = false,
        LastUpdate = 0,
        LastChange = 0,
        Values = {}
    }
});
task.spawn(v3.Start, v3);

return v3;