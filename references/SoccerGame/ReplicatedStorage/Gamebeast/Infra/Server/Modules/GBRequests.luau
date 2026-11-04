  

local v1 = {};
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Utilities = require(script.Parent.Utilities);
local DataCache = require(script.Parent.Parent.Parent.Shared.Modules.DataCache);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local MetaData = require(script.Parent.Parent.Parent.MetaData);
local u2 = { {
        URL = "https://api.gamebeast.gg",
        Requests = {
            ["v1/markers"] = "POST",
            ["v1/latest/version?platform=roblox"] = "GET",
            ["v1/servers/roblox/{serverId}"] = "POST",
            ["v1/cohorts/membership"] = "POST",
            ["v2/bootstrap"] = "GET",
            ["v2/status"] = "GET",
            ["v2/configurations"] = "GET",
            ["v2/experiments/active"] = "GET",
            ["v2/experiments/assignments/bulk"] = "POST"
        },
        EndpointTree = {}
    } };
local u3 = {
    production = "false",
    studio = "true"
};
local u4 = Signal.new();
local u5 = 0;
local u6 = false;
local u7 = false;

local function GetEndpointForRequest(p8: string) -- Line: 65
    -- upvalues: u2 (copy), DataCache (copy)
    local v9, v10, v11;
    v9, v10, v11 = u2, nil, nil;
    local v12, v13, v14;

    if type(v9) == "function" then
        v12, v13 = v9(v10, v14);
    else
        v12, v13 = next(v9, v14);
    end;

    v14 = v12;
    local EndpointTree = v13.EndpointTree;

    for _, v in string.split(p8, "/") do
        EndpointTree = EndpointTree[v];

        if not EndpointTree then
            return nil, nil;
        end;
    end;

    return (DataCache:Get("Settings").customUrl or v13.URL) .. "/sdk", EndpointTree.__method;
end;

local function YeildForKey() -- Line: 79
    -- upvalues: DataCache (copy), u6 (ref), Utilities (copy)
    local v15 = tick();

    while not DataCache:Get("Key") do
        task.wait();

        if tick() - v15 > 5 and not u6 then
            Utilities.GBWarn("Gamebeast key not found! Did you call Gamebeast:Setup()?");
            u6 = true;
            break;
        end;
    end;

    return DataCache:Get("Key");
end;

function v1.OnFinalRequestCall(p16: table, u17: function) -- Line: 96
    -- upvalues: u4 (copy)
    return u4:Connect(function() -- Line: 97
        -- upvalues: u17 (copy)
        local coroutine_running_ret = coroutine.running();
        u17();

        if coroutine_running_ret ~= coroutine.running() then
            error("Final request should not yeild!");
        end;
    end);
end;

function v1.GBRequest(u18: table, u19: string, u20: table, u21: table?, u22: number?) -- Line: 107
    -- upvalues: GetEndpointForRequest (copy), Utilities (copy)
    local _, v23 = GetEndpointForRequest(u19);

    if v23 ~= "POST" then
        Utilities.GBWarn("GBRequest should only be used for POST requests. Use GBRequestAsync for other request types.");
    end;

    task.spawn(function() -- Line: 113
        -- upvalues: u18 (copy), u19 (copy), u20 (copy), u21 (copy), u22 (copy)
        u18:GBRequestAsync(u19, u20, u21, u22);
    end);
end;

function v1.GBRequestAsync(p24: table, p25: string, p26: table, p27: table?, p28: number?) -- Line: 120
    -- upvalues: YeildForKey (copy), GetEndpointForRequest (copy), Utilities (copy), DataCache (copy), RunService (copy), u3 (copy), MetaData (copy), HttpService (copy), u5 (ref), u7 (ref)
    local v29 = YeildForKey();
    local v30, u31 = GetEndpointForRequest(p25);

    if not (v30 and u31) then
        Utilities.GBWarn("Invalid request route:", p25);

        return false, nil;
    end;

    local u32 = nil;
    local u33 = p26 or {};
    local environment = DataCache:Get("Settings").environment;
    local v34 = tostring(RunService:IsStudio());

    if environment and u3[environment] then
        v34 = u3[environment];
    end;

    local u35 = {
        authorization = v29,
        isstudio = v34,
        environment = environment or (RunService:IsStudio() and "studio" or "production"),
        sdkversion = MetaData.version,
        universeid = tostring(game.GameId),
        serverid = Utilities.getServerId(),
        ["server-id"] = Utilities.getServerId()
    };

    if p27 then
        for i, v in p27 do
            u35[i] = v;
        end;
    end;

    local u36 = v30 .. "/" .. p25;
    local success, result = pcall(function() -- Line: 163
        -- upvalues: u31 (copy), u32 (ref), HttpService (ref), u33 (ref), u35 (copy), u36 (ref)
        if u31 ~= "POST" and u31 ~= "PUT" then
            if u31 == "GET" then
                local v37 = "?";

                for i, v in u33 do
                    v37 = v37 .. i .. "=" .. HttpService:UrlEncode(v) .. "&";
                end;

                u36 = u36 .. string.sub(v37, 1, #v37 - 1);
            end;

            return;
        end;

        u32 = HttpService:JSONEncode(u33);
        u35["Content-Type"] = "application/json";
    end);

    if not success then
        Utilities.GBWarn(`Couldn't encode the request to {p25}, so it was not sent:`, result);

        return false, nil;
    end;

    u5 = u5 + 1;
    local u38, v39 = Utilities.promiseReturn(p28 or 1, function() -- Line: 187
        -- upvalues: HttpService (ref), u36 (ref), u31 (copy), u35 (copy), u32 (ref)
        return HttpService:RequestAsync({
            Url = u36,
            Method = u31,
            Headers = u35,
            Body = u32
        });
    end);
    u5 = u5 - 1;
    local v40;

    if v39 then
        v40 = u38.Success or false;
    else
        v40 = false;
    end;

    local v41;

    if u38 then
        v41 = u38.StatusCode or nil;
    else
        v41 = nil;
    end;

    if not u38 or #u38.Body <= 0 then
        return v40, nil, v41;
    end;

    if not (v41 ~= 401 and v41 ~= 403 or u7) then
        Utilities.GBWarn("Gamebeast project key invalid or not set! Set your project key in the :Setup method.");
        u7 = true;
    end;

    local v42 = Utilities.promiseReturn(0, function() -- Line: 207
        -- upvalues: HttpService (ref), u38 (copy)
        return HttpService:JSONDecode(u38.Body);
    end);

    if v40 == false and v41 ~= 304 then
        Utilities.GBWarn("Request failed (" .. v41 .. ") | " .. p25 .. " | " .. (v42 and (v42.message or "Unknown error") or "Unknown error"));
    end;

    return v40, v42, v41;
end;

function v1.Init(p43) -- Line: 223
    -- upvalues: u4 (copy), u5 (ref)
    game:BindToClose(function() -- Line: 224
        -- upvalues: u4 (ref), u5 (ref)
        u4:Fire();

        repeat
            task.wait();
        until u5 == 0;
    end);
end;

for _, v in u2 do
    local v44 = v;

    for i, v2 in v.Requests do
        local string_split_ret = string.split(i, "/");
        local EndpointTree = v44.EndpointTree;

        for _, v3 in string_split_ret do
            local v45 = string.match(v3, "{(.*)}") ~= nil;

            if not EndpointTree[v3] then
                if v45 then
                    local u46 = {};
                    setmetatable(EndpointTree, {
                        __index = function(p47, p48) -- Line: 245, Name: __index
                            -- upvalues: u46 (copy)
                            return u46;
                        end
                    });
                else
                    EndpointTree[v3] = {};
                end;
            end;

            EndpointTree = EndpointTree[v3];
        end;

        EndpointTree.__method = v2;
    end;
end;

return v1;