 
 

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local creatorTitles = require(script.Parent.creatorTitles);
local u1 = {};
local CreatorTitleGithub = script.Parent:FindFirstChild("CreatorTitleGithub");

if not CreatorTitleGithub then
    CreatorTitleGithub = Instance.new("StringValue");
    CreatorTitleGithub.Name = "CreatorTitleGithub";
    CreatorTitleGithub.Value = "{}";
    CreatorTitleGithub.Parent = script.Parent;
end;

local u2 = nil;

local function parseRawTitle(p3) -- Line: 18
    if typeof(p3) ~= "table" then
        return nil;
    end;

    local tagText = p3.tagText;

    if typeof(tagText) ~= "string" or tagText == "" then
        return nil;
    end;

    local v4 = {};

    if typeof(p3.tagColor) == "table" then
        for _, v in p3.tagColor do
            if typeof(v) == "table" then
                local v5 = tonumber(v[1]);
                local v6 = tonumber(v[2]);
                local v7 = tonumber(v[3]);
                local v8 = tonumber(v[4]);

                if v5 and (v6 and (v7 and v8)) then
                    table.insert(v4, ColorSequenceKeypoint.new(v5, Color3.fromRGB(v6, v7, v8)));
                end;
            end;
        end;
    end;

    if #v4 < 1 then
        return nil;
    end;

    local v9 = {
        tagText = tagText,
        tagColor = ColorSequence.new(v4),
        specialer = p3.specialer == true
    };

    if p3.nameaddition == true then
        v9.nameaddition = true;
    end;

    return v9;
end;

local function loadGithubFromReplication() -- Line: 61
    -- upvalues: u2 (ref), HttpService (copy), CreatorTitleGithub (ref), parseRawTitle (copy)
    if u2 then
        return u2;
    end;

    local v10 = {};
    local success, result = pcall(function() -- Line: 67
        -- upvalues: HttpService (ref), CreatorTitleGithub (ref)
        return HttpService:JSONDecode(CreatorTitleGithub.Value);
    end);

    if success and typeof(result) == "table" then
        for i, v in pairs(result) do
            local v11 = tonumber(i);

            if v11 then
                local v12 = parseRawTitle(v);

                if v12 then
                    v10[v11] = v12;
                end;
            end;
        end;
    end;

    u2 = v10;

    return v10;
end;

if RunService:IsClient() then
    CreatorTitleGithub.Changed:Connect(function() -- Line: 88
        -- upvalues: u2 (ref)
        u2 = nil;
    end);
end;

local v13 = {};
setmetatable(v13, {
    __index = function(p14: any, p15: number) -- Line: 96, Name: __index
        -- upvalues: RunService (copy), loadGithubFromReplication (copy), u1 (copy), creatorTitles (copy)
        if RunService:IsClient() then
            local v16 = loadGithubFromReplication()[p15];

            if v16 then
                return v16;
            end;
        else
            local v17 = u1[p15];

            if v17 then
                return v17;
            end;
        end;

        return creatorTitles[p15];
    end
});

function v13.applyGithub(p18: number, p19: any) -- Line: 112
    -- upvalues: u1 (copy)
    u1[p18] = p19;
end;

function v13.removeGithub(p20: number) -- Line: 116
    -- upvalues: u1 (copy)
    u1[p20] = nil;
end;

function v13.reconcileGithub(p21: table) -- Line: 120
    -- upvalues: parseRawTitle (copy), u1 (copy), RunService (copy), CreatorTitleGithub (ref), HttpService (copy)
    local v22 = {};

    for i, v in pairs(p21) do
        local v23 = tonumber(i);

        if v23 then
            local v24 = parseRawTitle(v);

            if v24 then
                u1[v23] = v24;
                v22[v23] = true;
            end;
        end;
    end;

    for i in pairs(u1) do
        if not v22[i] then
            u1[i] = nil;
        end;
    end;

    if RunService:IsServer() then
        CreatorTitleGithub.Value = HttpService:JSONEncode(p21);
    end;
end;

return v13;