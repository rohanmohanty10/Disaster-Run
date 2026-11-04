 

 

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local u1 = { "rinnoplay", "cc", "funnyvoicelines", "ihatekunigami", "gagamarupunch", "becomeai", "ncd", "f", "ball", "kuon", "homelander", "concept", "saeawk", "kaiserawk", "mobian", "skillbuilder", "announce", "serverban", "slifer", "overtimetest", "heat", "sillysong", "control", "evil", "yurier", "tungify", "teleport", "invisible", "legalhbe", "metavision", "fl", "remmybirthday", "ignoreflowcooldown", "respawn", "teambalancing", "awaketest", "kick", "isagi", "rebel", "ccd", "marble", "marbleball", "gubby" };
local u2 = {};

for _, v in u1 do
    u2[v] = {};
end;

local CommandWhitelistGithub = script:FindFirstChild("CommandWhitelistGithub");

if not CommandWhitelistGithub then
    CommandWhitelistGithub = Instance.new("StringValue");
    CommandWhitelistGithub.Name = "CommandWhitelistGithub";
    CommandWhitelistGithub.Value = "{}";
    CommandWhitelistGithub.Parent = script;
end;

local u3 = nil;

local function decodeReplication() -- Line: 65
    -- upvalues: u1 (copy), HttpService (copy), CommandWhitelistGithub (ref)
    local v4 = {};

    for _, v in u1 do
        v4[v] = {};
    end;

    local success, result = pcall(function() -- Line: 71
        -- upvalues: HttpService (ref), CommandWhitelistGithub (ref)
        return HttpService:JSONDecode(CommandWhitelistGithub.Value);
    end);

    if success and typeof(result) == "table" then
        for i, v in pairs(result) do
            local string_lower_ret = string.lower(i);

            if v4[string_lower_ret] and typeof(v) == "table" then
                for _, v2 in v do
                    local v5 = tonumber(v2);

                    if v5 and not table.find(v4[string_lower_ret], v5) then
                        table.insert(v4[string_lower_ret], v5);
                    end;
                end;
            end;
        end;
    end;

    return v4;
end;

local function getLists() -- Line: 95
    -- upvalues: RunService (copy), u3 (ref), decodeReplication (copy), u2 (copy)
    if not RunService:IsClient() then
        return u2;
    end;

    if not u3 then
        u3 = decodeReplication();
    end;

    return u3;
end;

local function publishReplication() -- Line: 105
    -- upvalues: RunService (copy), u1 (copy), u2 (copy), CommandWhitelistGithub (ref), HttpService (copy)
    if not RunService:IsServer() then
        return;
    end;

    local v6 = {};

    for _, v in u1 do
        v6[v] = u2[v];
    end;

    CommandWhitelistGithub.Value = HttpService:JSONEncode(v6);
end;

local function reconcileIds(p7: table, p8: table) -- Line: 118
    local v9 = {};

    for _, v in ipairs(p8) do
        local v10 = tonumber(v);

        if v10 then
            v9[v10] = true;
        end;
    end;

    for i = #p7, 1, -1 do
        local v11;

        if v9[p7[i]] then
            v11 = i;
        else
            table.remove(p7, i);
            v11 = i;
        end;
    end;

    for i, _ in pairs(v9) do
        if not table.find(p7, i) then
            table.insert(p7, i);
        end;
    end;
end;

local v12 = {};
setmetatable(v12, {
    __index = function(p13: any, p14: string) -- Line: 143, Name: __index
        -- upvalues: RunService (copy), u3 (ref), decodeReplication (copy), u2 (copy)
        local v15;

        if RunService:IsClient() then
            if not u3 then
                u3 = decodeReplication();
            end;

            v15 = u3;
        else
            v15 = u2;
        end;

        return v15[p14] or u2[p14];
    end
});

function v12.reconcileGithub(p16: table) -- Line: 152
    -- upvalues: u1 (copy), reconcileIds (copy), u2 (copy), publishReplication (copy)
    for _, v in u1 do
        reconcileIds(u2[v], {});
    end;

    if typeof(p16) == "table" then
        for i, v in pairs(p16) do
            local string_lower_ret = string.lower(i);

            if u2[string_lower_ret] and typeof(v) == "table" then
                reconcileIds(u2[string_lower_ret], v);
            end;
        end;
    end;

    publishReplication();
end;

function v12.mergeGithub(p17: table) -- Line: 169
    -- upvalues: u2 (copy), publishReplication (copy)
    if typeof(p17) ~= "table" then
        return;
    end;

    for i, v in pairs(p17) do
        local string_lower_ret = string.lower(i);

        if u2[string_lower_ret] and typeof(v) == "table" then
            for _, v2 in v do
                local v18 = tonumber(v2);

                if v18 and not table.find(u2[string_lower_ret], v18) then
                    table.insert(u2[string_lower_ret], v18);
                end;
            end;
        end;
    end;

    publishReplication();
end;

function v12.force(p19: table) -- Line: 189
    -- upvalues: u1 (copy), u2 (copy), publishReplication (copy)
    for _, v in u1 do
        local v20 = v;

        for _, v2 in p19 do
            if not table.find(u2[v20], v2) then
                table.insert(u2[v20], v2);
            end;
        end;
    end;

    publishReplication();
end;

if RunService:IsClient() then
    CommandWhitelistGithub.Changed:Connect(function() -- Line: 202
        -- upvalues: u3 (ref)
        u3 = nil;
    end);
end;

return v12;