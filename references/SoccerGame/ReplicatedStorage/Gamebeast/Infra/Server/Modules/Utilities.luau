  

local MarketplaceService = game:GetService("MarketplaceService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local u2 = {
    GBWarn = function(...) -- Line: 13
        -- upvalues: DataCache (copy)
        if DataCache:Get("Settings").sdkWarningsEnabled then
            warn("GamebeastSDK:", ...);

            if DataCache:Get("Settings").includeWarningStackTrace then
                warn("GamebeastSDK Traceback:", debug.traceback());
            end;
        end;
    end,

    GBLog = function(...) -- Line: 22
        -- upvalues: DataCache (copy)
        if DataCache:Get("Settings").sdkDebugEnabled then
            print("GamebeastSDK:", ...);
        end;
    end,

    resolvePlayerObject = function(p1) -- Line: 28
        if typeof(p1) == "number" then
            return game.Players:GetPlayerByUserId(p1);
        end;

        return p1;
    end
};

function u2.promiseReturn(p3, u4, p5) -- Line: 37
    -- upvalues: u2 (copy)
    if p3 and not p5 then
        p5 = 0;
    elseif p5 and p3 < p5 then
        return nil, false;
    end;

    local u6 = nil;
    local success, result = pcall(function() -- Line: 47
        -- upvalues: u6 (ref), u4 (copy)
        u6 = u4();
    end);

    if success then
        return u6, true;
    end;

    task.wait();

    if p5 then
        p5 = p5 + 1;

        if p3 < p5 then
            u2.GBWarn(result);
        end;
    end;

    return u2.promiseReturn(p3, u4, p5);
end;

function u2.PCallRetry(p7: table, p8: number, p9: function, p10: number?) -- Line: 67
    local v11 = p10 or 0;
    local success, result = pcall(p9);

    if success then
        return true, result;
    end;

    if v11 >= p8 then
        return false, result;
    end;

    task.wait(0.1);

    return p7:PCallRetry(p8, p9, v11 + 1);
end;

function u2.primativeDeepEqual(p12, p13) -- Line: 87
    -- upvalues: u2 (copy)
    if p12 == p13 then
        return true;
    end;

    if typeof(p12) ~= typeof(p13) then
        return false;
    end;

    if typeof(p12) ~= "table" then
        return false;
    end;

    local v14 = 0;

    for _ in p12 do
        v14 = v14 + 1;
    end;

    local v15 = 0;

    for _ in p13 do
        v15 = v15 + 1;
    end;

    if v14 ~= v15 then
        return false;
    end;

    for i, v in p12 do
        local v16 = p13[i];

        if v16 == nil then
            return false;
        end;

        if not u2.primativeDeepEqual(v, v16) then
            return false;
        end;
    end;

    return true;
end;

function u2.formatTime(p17, p18) -- Line: 128
    local math_floor_ret = math.floor(p17 / 60 / 60);
    local math_floor_ret2 = math.floor(p17 / 60 - math_floor_ret * 60);
    local math_floor_ret3 = math.floor(p17 - math_floor_ret2 * 60 - math_floor_ret * 60 * 60);
    local v19 = tostring(math_floor_ret);
    local v20 = tostring(math_floor_ret2);
    local v21 = tostring(math_floor_ret3);

    if #v19 < 2 then
        v19 = "0" .. v19;
    end;

    if #v20 < 2 then
        v20 = "0" .. v20;
    end;

    if #v21 < 2 then
        v21 = "0" .. v21;
    end;

    return p18 and v20 .. ":" .. v21 or v19 .. ":" .. v20 .. ":" .. v21;
end;

function u2.convertSecstoDay(p22) -- Line: 151
    local v23 = p22 % 86400;
    local v24 = v23 % 3600;

    return math.floor(p22 / 86400) .. "d " .. math.floor(v23 / 3600) .. "h " .. math.floor(v24 / 60) .. "m " .. math.floor(v24 % 60) .. "s";
end;

function u2.getProductInfo(u25, u26) -- Line: 177
    -- upvalues: u2 (copy), MarketplaceService (copy)
    return u2.promiseReturn(2, function() -- Line: 178
        -- upvalues: MarketplaceService (ref), u25 (copy), u26 (copy)
        return MarketplaceService:GetProductInfoAsync(u25, u26);
    end);
end;

function u2.recursiveCopy(p27, p28) -- Line: 184
    -- upvalues: u2 (copy)
    local v29 = {};

    for i, v in p27 do
        local v30;

        if type(v) == "table" then
            v30 = u2.recursiveCopy(v, p28);

            if p28 and not table.isfrozen(v30) then
                table.freeze(v30);
            end;
        else
            v30 = v;
        end;

        v29[i] = v30;
    end;

    return v29;
end;

function u2.roundNum(p31, p32) -- Line: 203
    return math.floor(0.5 + p31 / p32) / (1 / p32);
end;

function u2.getTableValues(p33: table) -- Line: 208
    local v34 = {};

    for _, v in p33 do
        table.insert(v34, v);
    end;

    return v34;
end;

function u2.getValueAtPath(p35: any, p36: table) -- Line: 217
    for _, v in p36 do
        if typeof(p35) ~= "table" then
            return nil;
        end;

        local v37 = p35[v];

        if v37 == nil and tonumber(v) ~= nil then
            p35 = p35[tonumber(v)];
        else
            p35 = v37;
        end;
    end;

    return p35;
end;

local u38;

if RunService:IsStudio() then
    u38 = `studio:{HttpService:GenerateGUID(false):lower()}`;
else
    u38 = game.JobId;
end;

function u2.getServerId() -- Line: 236
    -- upvalues: u38 (copy)
    return u38;
end;

function u2.OnPlayerAdded(p39: table, p40: function) -- Line: 241
    for _, v in pairs(game.Players:GetPlayers()) do
        task.spawn(p40, v);
    end;

    return game.Players.PlayerAdded:Connect(p40);
end;

function u2.FindPlayer(p41, p42) -- Line: 248
    if tonumber(p42) then
        return game.Players:GetPlayerByUserId((tonumber(p42)));
    end;

    return game.Players:FindFirstChild(p42);
end;

function u2.waitForAllCalls(p43: table) -- Line: 260
    -- upvalues: u2 (copy)
    local u44 = #p43;

    if u44 == 0 then
        return;
    end;

    local coroutine_running_ret = coroutine.running();

    for i, v in p43 do
        task.spawn(function() -- Line: 269
            -- upvalues: v (copy), u2 (ref), i (copy), u44 (ref), coroutine_running_ret (copy)
            local success, result = pcall(v);

            if not success then
                u2.GBWarn((`Uncaught error in waitForAllCalls callback {i}: {result}`));
            end;

            u44 = u44 - 1;

            if u44 == 0 then
                coroutine.resume(coroutine_running_ret);
            end;
        end);
    end;

    if u44 > 0 then
        coroutine.yield();
    end;
end;

function u2.waitForAnyCall(p45: table) -- Line: 290
    -- upvalues: u2 (copy)
    if #p45 == 0 then
        return;
    end;

    local coroutine_running_ret = coroutine.running();
    local u46 = false;

    for i, v in p45 do
        task.spawn(function() -- Line: 299
            -- upvalues: v (copy), u2 (ref), i (copy), u46 (ref), coroutine_running_ret (copy)
            local success, result = pcall(v);

            if not success then
                u2.GBWarn((`Uncaught error in waitForAnyCall callback {i}: {result}`));
            end;

            if not u46 then
                u46 = true;
                coroutine.resume(coroutine_running_ret);
            end;
        end);
    end;

    if not u46 then
        coroutine.yield();
    end;
end;

return u2;