 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GroupService = game:GetService("GroupService");
local wiki = require(ReplicatedStorage.wiki);
local u1 = { 998091053, 432828236, 3730120158 };

local function checkforgroup(u2) -- Line: 10
    -- upvalues: RunService (copy), wiki (copy), GroupService (copy)
    if RunService:IsStudio() then
        return 255;
    end;

    if typeof(u2) == "Instance" then
        local success, result = pcall(function() -- Line: 16
            -- upvalues: u2 (copy), wiki (ref)
            return u2:GetRankInGroup(wiki.groupId);
        end);

        return not success and 0 or result;
    end;

    local success, result = pcall(function() -- Line: 27
        -- upvalues: GroupService (ref), u2 (copy)
        return GroupService:GetGroupsAsync(u2);
    end);

    if not success or type(result) ~= "table" then
        return 0;
    end;

    for _, v in result do
        if v.Id == wiki.groupId then
            return v.Rank;
        end;
    end;

    return 0;
end;

local function player_owns_vip(p3: userdata) -- Line: 44
    if typeof(p3) == "Instance" and p3:IsA("Player") then
        return p3:HasTag("PS");
    end;

    return false;
end;

local function player_owns_vip_gamepass(p4) -- Line: 52
    if typeof(p4) == "Instance" and p4:IsA("Player") then
        return p4:HasTag("PSgp");
    end;

    return false;
end;

return function(p5) -- Line: 60
    -- upvalues: checkforgroup (copy), u1 (copy), ReplicatedStorage (copy), RunService (copy), wiki (copy)
    local v6 = checkforgroup(p5);
    local v7;

    if typeof(p5) == "Instance" and p5:IsA("Player") then
        v7 = p5.UserId;
    else
        v7 = not table.find({ "string", "number" }, p5) and -67 or p5;
    end;

    local v8 = tonumber(v7);

    if typeof(v8) ~= "number" or v8 == -67 then
        return {};
    end;

    local v9 = u1[v8] == true;
    local v10;

    if typeof(p5) == "Instance" and p5:IsA("Player") then
        v10 = p5:HasTag("PS");
    else
        v10 = false;
    end;

    local v11;

    if typeof(p5) == "Instance" and p5:IsA("Player") then
        v11 = p5:HasTag("PSgp");
    else
        v11 = false;
    end;

    local v12 = ReplicatedStorage.vipserverownerid.Value ~= 0;
    local v13 = ReplicatedStorage.vipserverownerid.Value == v8 and true or ReplicatedStorage:GetAttribute("PSOwner") == v8;
    local v14 = RunService:IsStudio();

    if v14 then
        v12 = v14;
    elseif v12 then
        if v13 then
            v12 = v10 or v11;
        else
            v12 = v13;
        end;
    end;

    local v15 = wiki.isTestGame() and v6 >= 3;
    local v16 = {
        contentcreator = v6 >= 2,
        owner = v6 >= 255,
        scripter = v6 >= 252,
        developer = v6 >= 10,
        headofstaff = v6 >= 11,
        moderator = v6 >= 6,
        senior_mod = v6 >= 7,
        admin = v6 >= 8,
        contributor = v6 == 5,
        tester = v15 or (v9 or v6 >= 4),
        trialtester = v15 or (v9 or v6 >= 3),
        myvipserver = v13,
        highrank = v12 or (v15 or (v9 or v6 >= 4))
    };

    if v16.contributor then
        local myvipserver = v16.myvipserver;

        for i in v16 do
            if i ~= "contributor" then
                v16[i] = false;
            end;
        end;

        if v11 and myvipserver then
            v16.highrank = true;
        end;
    end;

    if v9 or v6 >= 4 then
        v16.truehighrank = true;
    end;

    for _, child in script.extrahr:GetChildren() do
        local v17 = tonumber(child.Name);

        if v17 and v17 == v8 then
            v16.highrank = true;
        end;
    end;

    return v16;
end;