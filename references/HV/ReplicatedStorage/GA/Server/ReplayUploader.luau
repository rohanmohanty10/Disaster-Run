 

 

local HttpService = game:GetService("HttpService");
local Config = require(script.Parent.Parent.Shared.Config);
local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 43
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._appId = p2.appId;
    v3._apiKey = p2.apiKey;
    v3._endpoint = p2.endpoint;

    return v3;
end;

function u1.upload(u4: table, u5: string, p6: table) -- Line: 62
    -- upvalues: Config (copy), HttpService (copy)
    local u7 = {
        Authorization = Config.authorizationHeader(u4._apiKey),
        ["Content-Type"] = "application/octet-stream",
        ["X-Replay-App-Id"] = u4._appId,
        ["X-Replay-Session"] = tostring(p6.sessionId),
        ["X-Replay-User"] = tostring(p6.userId),
        ["X-Replay-Server"] = tostring(p6.serverId),
        ["X-Replay-Reason"] = tostring(p6.reason)
    };
    local math_floor_ret = math.floor(p6.capturedAtMs);
    u7["X-Replay-Captured-At"] = tostring(math_floor_ret);
    local math_floor_ret2 = math.floor(p6.durationMs);
    u7["X-Replay-Duration-Ms"] = tostring(math_floor_ret2);
    u7["X-Replay-Format-Version"] = tostring(p6.formatVersion);

    if p6.device ~= nil and p6.device ~= "" then
        u7["X-Replay-Device"] = p6.device;
    end;

    if p6.sessionDurationMs ~= nil then
        local math_floor_ret3 = math.floor(p6.sessionDurationMs);
        u7["X-Replay-Session-Duration-Ms"] = tostring(math_floor_ret3);
    end;

    if p6.configVersion ~= nil then
        u7["X-Replay-Config-Version"] = tostring(p6.configVersion);
    end;

    if p6.gameVersion ~= nil then
        u7["X-Replay-Game-Version"] = tostring(p6.gameVersion);
    end;

    for i = 1, 3 do
        local success, result = pcall(function() -- Line: 92
            -- upvalues: HttpService (ref), u4 (copy), u7 (copy), u5 (copy)
            return HttpService:RequestAsync({
                Method = "POST",
                Url = u4._endpoint,
                Headers = u7,
                Body = u5,
                Compress = Enum.HttpCompression.Gzip
            });
        end);

        if success and result.Success then
            local success2, result2 = pcall(function() -- Line: 105
                -- upvalues: HttpService (ref), result (copy)
                return HttpService:JSONDecode(result.Body);
            end);
            local v8;

            if success2 and type(result2) == "table" then
                v8 = result2.replay_id or result2.replayId;
            else
                v8 = nil;
            end;

            return true, v8;
        end;

        local v9;

        if success then
            v9 = result.StatusCode;
        else
            v9 = nil;
        end;

        local v10;

        if success then
            v10 = result.Body;
        else
            v10 = tostring(result);
        end;

        if v9 and (v9 >= 400 and v9 < 500) then
            warn((`[GA:Replay] Upload rejected ({v9}): {v10}. Not retrying.`));

            return false, `HTTP {v9}: {v10}`;
        end;

        if i >= 3 then
            warn((`[GA:Replay] Upload failed after {3} attempts (status: {v9 or "network"}): {v10}. Replay dropped.`));

            return false, tostring(v10);
        end;

        local v11 = 2 ^ (i - 1) * 2;
        warn((`[GA:Replay] Upload failed (attempt {i}/{3}, status: {v9 or "network"}). Retrying in {v11}s...`));
        task.wait(v11);
        local _ = i;
    end;

    return false, "unreachable";
end;

return u1;