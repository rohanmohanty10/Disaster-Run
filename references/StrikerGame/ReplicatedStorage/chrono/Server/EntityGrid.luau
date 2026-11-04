 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Events = require(script.Parent.Parent.Shared.Events);
local Config = require(script.Parent.Parent.Shared.Config);
local Allows = require(script.Parent.Parent.Shared.ReplicationRules).Allows;
local Stats = require(script.Parent.Parent.Shared.Stats);
local Warn = require(script.Parent.Parent.Shared.Warn);
local Shared = script.Parent.Parent.Shared;
require(Shared.Types);
local Holder = require(Shared.Holder);
local Ticker = require(Shared.Ticker);
local Entity = require(Shared.Entity);
local Signal = require(Shared.Signal);
local _SetTickMode = Entity._SetTickMode;
local u1 = 0.1;
local u2 = 0.0005;
local u3 = 0;
Config._WaitForLock(function() -- Line: 29
    -- upvalues: u1 (ref), Config (copy), u2 (ref)
    u1 = Config._GetConfig("GRID_UPDATE_INTERVAL") or u1;
    u2 = Config._GetConfig("GRID_MAX_UPDATE_TIME") or u2;
end);
local u4 = 0;
local u5 = 0;
local u6 = 0;
local idMap = Holder.idMap;
local u7 = {};
local u8 = {};

local function Check(p9) -- Line: 44
    -- upvalues: Entity (copy), Warn (copy), u8 (copy), u7 (copy), Allows (copy), _SetTickMode (copy), u5 (ref), u4 (ref), u6 (ref), Ticker (copy)
    local PrimaryPart = Entity.GetPrimaryPart(p9);
    local v10 = PrimaryPart and PrimaryPart.CFrame or p9.latestCFrame;

    if not v10 or p9.destroyed then
        return;
    end;

    if p9.id < 1 then
        Warn.high(p9, " has invalid id, cannot check for proximity");

        return;
    end;

    local Position = v10.Position;
    local entityConfig = p9.entityConfig;
    local v11 = false;
    local v12 = false;
    local v13 = entityConfig.HALF_TICK_DISTANCE or (1 / 0);
    local v14 = entityConfig.NORMAL_TICK_DISTANCE or (1 / 0);
    local networkOwner = p9.networkOwner;

    if networkOwner then
        networkOwner = u8[networkOwner];
    end;

    local v15 = p9._lockedCFReplication or p9.modelReplicationMode ~= "NATIVE";

    for i, v in u7 do
        if Allows(p9, i.PLAYER) then
            local vector_magnitude_ret = vector.magnitude(Position - v);

            if v13 < vector_magnitude_ret and v15 then
                if i == networkOwner then
                    table.insert(i._TEMP_NORMAL, p9);
                end;
            elseif vector_magnitude_ret <= v14 then
                table.insert(i._TEMP_NORMAL, p9);
                v11 = true;
            else
                table.insert(i._TEMP_HALF, p9);
                v12 = true;
            end;
        end;
    end;

    local TICKER = entityConfig.TICKER;

    if not TICKER then
        return;
    end;

    local _ticker = p9._ticker;

    if v12 and not v11 then
        _SetTickMode(p9, true);
        u5 = u5 + 1;
    elseif v11 then
        _SetTickMode(p9, false);
        u4 = u4 + 1;
    else
        u6 = u6 + 1;
    end;

    if (v11 or v12) and p9._ticker ~= TICKER then
        Ticker.move(p9, TICKER);

        return;
    end;

    if not (v11 or (v12 or not _ticker)) then
        _SetTickMode(p9, nil);
        Ticker.Remove(_ticker, p9);
    end;
end;

local u16 = nil;
local u17 = 0;

local function DoLoop() -- Line: 115
    -- upvalues: u17 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (copy), idMap (copy), Check (copy), u2 (ref), u16 (ref), Stats (copy), u8 (copy)
    u17 = 0;
    u4 = 0;
    u5 = 0;
    u6 = 0;

    for i, _ in u7 do
        table.clear(i._TEMP_HALF);
        table.clear(i._TEMP_NORMAL);
    end;

    debug.profilebegin("EntityGrid.Update");
    local os_clock_ret = os.clock();
    local v18 = 0;
    local v19 = 1;

    for _, v in table.clone(idMap) do
        debug.profilebegin("Check One");
        Check(v);
        v18 = v18 + 1;
        debug.profileend();

        if u2 < os.clock() - os_clock_ret then
            v19 = v19 + 1;
            debug.profileend();
            u17 = u17 + (os.clock() - os_clock_ret);
            u16 = coroutine.running();
            coroutine.yield();
            u16 = nil;
            os_clock_ret = os.clock();
            debug.profilebegin("EntityGrid.ResumeUpdate");
        end;
    end;

    debug.profileend();
    u17 = u17 + (os.clock() - os_clock_ret);
    Stats.SERVER.GRID_UPDATE_SECTIONS = v19;
    Stats.SERVER.ENTITY_GRID_UPDATE_TIME_MS = u17 * 1000;
    Stats.SERVER.NUMBER_OF_ENTITIES = v18;
    Stats.SERVER.ENTITIES_FULL_TICKED = u4;
    Stats.SERVER.ENTITIES_HALF_TICKED = u5;
    Stats.SERVER.NON_TICKED = u6;

    for _, v in u8 do
        table.clear(v.HALF);
        table.clear(v.NORMAL);
        local v20 = v;

        for _, v2 in v._TEMP_NORMAL do
            table.insert(v20.NORMAL, v2);
        end;

        for _, v2 in v20._TEMP_HALF do
            table.insert(v20.HALF, v2);
        end;
    end;

    if Stats.SERVER._SHOULD_REPLICATE then
        local v21 = {};

        for _, v in u8 do
            local v22 = v;
            local v23 = {
                HALF = {},
                NORMAL = {}
            };

            for _, v2 in v.NORMAL do
                table.insert(v23.NORMAL, v2.id);
            end;

            for _, v2 in v22.HALF do
                table.insert(v23.HALF, v2.id);
            end;

            v21[v22.PLAYER.Name] = v23;
        end;

        Stats.SERVER.GRID_STATS = v21;
    end;
end;

local function Update() -- Line: 181
    -- upvalues: u16 (ref), u3 (ref), u1 (ref), DoLoop (copy)
    if u16 then
        task.spawn(u16);

        return;
    end;

    if os.clock() - u3 < u1 then
        return;
    end;

    u3 = os.clock();
    task.spawn(DoLoop);
end;

local function UpdatePlayerPosition(p24: userdata, p25: vector) -- Line: 193
    -- upvalues: u8 (copy), u7 (copy)
    local v26 = u8[p24];

    if not v26 then
        return;
    end;

    u7[v26] = p25;
end;

local function GetEntityHolder(p27: userdata) -- Line: 201
    -- upvalues: u8 (copy)
    return u8[p27];
end;

local function PlayerAdded(p28: userdata) -- Line: 205
    -- upvalues: u8 (copy), Signal (copy), u7 (copy), Events (copy)
    if u8[p28] then
        return;
    end;

    local v29 = {
        PLAYER = p28,
        HALF = {},
        NORMAL = {},
        REPLICATED = {},
        _TEMP_HALF = {},
        _TEMP_NORMAL = {},
        EntityAdded = Signal.new(),
        EntityRemoving = Signal.new()
    };
    u8[p28] = v29;
    u7[v29] = Vector3.new(0, 0, 0);
    Events._Signals.PlayerLoaded:Fire(p28);
end;

if RunService:IsServer() then
    Shared.Remotes.ClientLoaded.OnServerEvent:Connect(PlayerAdded);
    Players.PlayerRemoving:Connect(function(p30: userdata) -- Line: 227
        -- upvalues: u8 (copy), u7 (copy)
        local v31 = u8[p30];

        if not v31 then
            return;
        end;

        v31.EntityAdded:DisconnectAll();
        v31.EntityRemoving:DisconnectAll();
        u7[v31] = nil;
        u8[p30] = nil;
    end);
end;

return {
    Update = Update,
    UpdatePlayerPosition = UpdatePlayerPosition,
    GetEntityHolder = GetEntityHolder
};