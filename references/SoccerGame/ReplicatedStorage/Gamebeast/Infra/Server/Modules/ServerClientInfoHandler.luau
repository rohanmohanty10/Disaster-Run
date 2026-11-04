  

local u1 = {};
local Players = game:GetService("Players");
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
require(script.Parent.GBRequests);
require(script.Parent.Parent.Parent.Shared.Modules.SignalTimeout);
local Schema = require(script.Parent.Parent.Parent.Shared.Modules.Schema);
local Utilities = require(script.Parent.Utilities);
local ServerGate = require(script.Parent.ServerGate);
local u2 = GetRemote("Event", "ClientInfoChanged");
local u3 = GetRemote("Function", "GetClientInfo");
local u4 = GetRemote("Function", "GetProductPrice");
local u5 = Signal.new({
    copyArguments = false
});
local u6 = Signal.new({
    copyArguments = false
});
local u7 = {
    inputType = {
        keyboard = true,
        gamepad = true,
        touch = true,
        unknown = true
    },
    device = {
        mobile = true,
        console = true,
        pc = true,
        vr = true,
        unknown = true
    },
    deviceSubType = {
        tablet = true,
        phone = true,
        xbox = true,
        playstation = true,
        unknown = true
    }
};
local u8 = Schema.new({
    inputType = {
        default = "unknown",
        type = "string"
    },
    device = {
        default = "unknown",
        type = "string"
    },
    deviceSubType = {
        default = "unknown",
        type = "string"
    },
    sessionId = {
        default = nil,
        type = "string"
    },
    joinTime = {
        default = nil,
        type = "number"
    },
    totalFriendPlaytime = {
        default = 0,
        type = "number"
    },
    hasFriendsOnline = {
        default = false,
        type = "boolean"
    },
    friendClockStart = {
        default = nil,
        type = "number"
    }
});
local Cache = ServerGate:GetCache();

local function IsValidClientInfo(p9: string, p10: any) -- Line: 107
    -- upvalues: u8 (copy), u7 (copy)
    if not u8:MatchesType(p9, p10) then
        return false;
    end;

    if type(p10) == "number" then
        local v11;

        if p10 == p10 and p10 ~= (1 / 0) then
            v11 = p10 ~= (-1 / 0);
        else
            v11 = false;
        end;

        return v11;
    end;

    if type(p10) == "string" then
        if #p10 > 64 then
            return false;
        end;

        local v12 = u7[p9];

        if v12 then
            return v12[p10] == true;
        end;

        if p9 == "sessionId" then
            return string.match(p10, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil;
        end;
    end;

    return true;
end;

local function UpdateClientInfoCache(p13: userdata, p14: table) -- Line: 136
    -- upvalues: Cache (copy), u8 (copy), IsValidClientInfo (copy), u6 (copy), u5 (copy)
    if type(p14) ~= "table" then
        return;
    end;

    local v15;

    if Cache[p13] then
        v15 = false;
    else
        Cache[p13] = u8:GetDefault();
        v15 = true;
    end;

    for i, v in pairs(p14) do
        if type(i) == "string" and (u8:HasKey(i) and (IsValidClientInfo(i, v) and Cache[p13][i] ~= v)) then
            Cache[p13][i] = v;
            u6:Fire(p13, i, v);
        end;
    end;

    if v15 then
        u5:Fire(p13, Cache[p13]);
    end;
end;

function u1.IsValidClientInfo(p16: table, p17: string, p18: any) -- Line: 174
    -- upvalues: u8 (copy), IsValidClientInfo (copy)
    local v19 = u8:HasKey(p17) and IsValidClientInfo(p17, p18);

    return v19;
end;

function u1.GetClientInfo(p20: table, p21: any, p22: string) -- Line: 178
    -- upvalues: Players (copy), Cache (copy), u8 (copy)
    if typeof(p21) == "number" then
        p21 = Players:GetPlayerByUserId(p21);
    end;

    if p21 and (Cache[p21] and Cache[p21][p22] ~= nil) then
        return Cache[p21][p22];
    end;

    return u8:GetDefaultForKey(p22);
end;

function u1.OnClientInfoResolved(p23: table, u24: userdata, u25: function) -- Line: 190
    -- upvalues: Cache (copy), u5 (copy)
    if not p23:IsClientInfoResolved(u24) then
        local u26 = nil;
        u26 = u5:Connect(function(p27: userdata, p28: table) -- Line: 197
            -- upvalues: u24 (copy), u26 (ref), u25 (copy)
            if p27 == u24 then
                u26:Disconnect();

                if p28 then
                    u25(table.clone(p28));
                end;
            end;
        end);

        return u26;
    end;

    u25(table.clone(Cache[u24]));
end;

function u1.OnClientInfoChanged(p29: table, u30: userdata, u31: function) -- Line: 210
    -- upvalues: u6 (copy)
    return u6:Connect(function(p32: userdata, p33: string, p34: any) -- Line: 211
        -- upvalues: u30 (copy), u31 (copy)
        if p32 == u30 then
            u31(p33, p34);
        end;
    end);
end;

function u1.IsClientInfoResolved(p35, p36) -- Line: 219
    -- upvalues: Players (copy), Cache (copy)
    assert(p36, "Player must be provided to check client info resolution.");

    if typeof(p36) == "number" then
        p36 = Players:GetPlayerByUserId(p36);
    end;

    return Cache[p36] ~= nil;
end;

function u1.WaitUntilClientInfoResolved(p37: table, p38: userdata, p39: number?) -- Line: 235
    -- upvalues: u1 (copy)
    if u1:IsClientInfoResolved(p38) then
        return;
    end;

    local coroutine_running_ret = coroutine.running();
    local u40 = nil;
    local u41 = false;
    local v42 = p37:OnClientInfoResolved(p38, function() -- Line: 245
        -- upvalues: u41 (ref), coroutine_running_ret (copy)
        if not u41 then
            u41 = true;
            coroutine.resume(coroutine_running_ret);
        end;
    end);

    if p39 then
        u40 = task.delay(p39, function() -- Line: 254
            -- upvalues: u41 (ref), u40 (ref), coroutine_running_ret (copy)
            if not u41 then
                u40 = nil;
                u41 = true;
                coroutine.resume(coroutine_running_ret);
            end;
        end);
    end;

    coroutine.yield();
    v42:Disconnect();

    if u40 then
        task.cancel(u40);
    end;
end;

function u1.GetProductInfoForPlayer(p43: table, u44: any, u45: number, u46: any) -- Line: 273
    -- upvalues: Players (copy), u4 (copy)
    if typeof(u44) == "number" then
        u44 = Players:GetPlayerByUserId(u44);
    end;

    if not (u44 and p43:IsClientInfoResolved(u44)) then
        return nil;
    end;

    local coroutine_running_ret = coroutine.running();
    local u47 = false;
    task.spawn(function() -- Line: 286
        -- upvalues: u4 (ref), u44 (ref), u45 (copy), u46 (copy), u47 (ref), coroutine_running_ret (copy)
        local success, result = pcall(function() -- Line: 287
            -- upvalues: u4 (ref), u44 (ref), u45 (ref), u46 (ref)
            return u4:InvokeClient(u44, u45, u46);
        end);

        if not u47 then
            u47 = true;

            if not success then
                result = nil;
            end;

            task.spawn(coroutine_running_ret, result);
        end;
    end);
    task.delay(10, function() -- Line: 296
        -- upvalues: u47 (ref), coroutine_running_ret (copy)
        if not u47 then
            u47 = true;
            task.spawn(coroutine_running_ret, nil);
        end;
    end);

    return coroutine.yield();
end;

function u1.UpdateClientData(p48: table, u49: any, u50: string, u51: any) -- Line: 306
    -- upvalues: Players (copy), u2 (copy)
    if typeof(u49) == "number" then
        u49 = Players:GetPlayerByUserId(u49);
    end;

    p48:OnClientInfoResolved(u49, function() -- Line: 311
        -- upvalues: u49 (ref), u2 (ref), u50 (copy), u51 (copy)
        if not u49.Parent then
            return;
        end;

        u2:FireClient(u49, u50, u51);
    end);
end;

function u1.Init(p52) -- Line: 322
    -- upvalues: Utilities (copy), u3 (copy), UpdateClientInfoCache (copy), Players (copy), u5 (copy), u2 (copy)
    Utilities:OnPlayerAdded(function(u53) -- Line: 324
        -- upvalues: u3 (ref), UpdateClientInfoCache (ref)
        local success, result = pcall(function() -- Line: 325
            -- upvalues: u3 (ref), u53 (copy)
            return u3:InvokeClient(u53);
        end);

        if success and result then
            UpdateClientInfoCache(u53, result);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p54: userdata) -- Line: 334
        -- upvalues: u5 (ref)
        u5:Fire(p54, nil);
    end);
    u2.OnServerEvent:Connect(UpdateClientInfoCache);
end;

return u1;