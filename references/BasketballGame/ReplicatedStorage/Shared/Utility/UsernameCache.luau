 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserService = game:GetService("UserService");
local Kache = require(ReplicatedStorage.Packages.Kache);
local Promise = require(ReplicatedStorage.Packages.Promise);
local u1 = {
    _cache = Kache(3600)
};
local u2 = false;
local u3 = {};

local function fetchThread() -- Line: 18
    -- upvalues: u3 (copy), UserService (copy), u2 (ref)
    while true do
        local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26;
        local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, u2;
        local v27 = 0;

        while true do
            if v27 == 0 then
                v27 = -1;

                while true do
                    v15 = {};

                    for i, _ in u3 do
                        if #v15 >= 200 then
                            v27 = 1;
                            break;
                        end;

                        table.insert(v15, i);
                    end;

                    if v27 ~= -1 then
                        break;
                    end;

                    if #v15 == 0 then
                        u2 = false;

                        return;
                    end;

                    v16, v17 = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, v15);

                    if v16 then
                        if #v17 == 0 then
                            for v21, v9 in u3 do
                                for v25, v18 in v9 do
                                    v18("???");
                                end;
                            end;
                        else
                            for v26, v13 in v17 do
                                v14 = u3[v13.Id];

                                if v14 then
                                    v6 = v13;

                                    for v19, v5 in v14 do
                                        v5(v6.Username);
                                    end;

                                    u3[v6.Id] = nil;
                                end;
                            end;
                        end;
                    else
                        for v22, v7 in u3 do
                            for v23, v8 in v7 do
                                v8("[couldn\'t fetch]");
                            end;
                        end;
                    end;

                    for v20, v4 in v15 do
                        v10 = u3[v4];

                        if v10 then
                            v12 = v4;

                            for v24, v11 in v10 do
                                v11("???");
                            end;

                            u3[v12] = nil;
                        end;
                    end;

                    task.wait(#v15 / 200 * 60);
                end;

                if v27 ~= -1 then
                    continue;
                end;

                v27 = 1;
                continue;
            elseif v27 == 1 then
                v27 = -1;

                if #v15 == 0 then
                    u2 = false;

                    return;
                end;

                v16, v17 = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, v15);

                if v16 then
                    if #v17 == 0 then
                        for v21, v9 in u3 do
                            for v25, v18 in v9 do
                                v18("???");
                            end;
                        end;
                    else
                        for v26, v13 in v17 do
                            v14 = u3[v13.Id];

                            if v14 then
                                v6 = v13;

                                for v19, v5 in v14 do
                                    v5(v6.Username);
                                end;

                                u3[v6.Id] = nil;
                            end;
                        end;
                    end;
                else
                    for v22, v7 in u3 do
                        for v23, v8 in v7 do
                            v8("[couldn\'t fetch]");
                        end;
                    end;
                end;

                for v20, v4 in v15 do
                    v10 = u3[v4];

                    if v10 then
                        v12 = v4;

                        for v24, v11 in v10 do
                            v11("???");
                        end;

                        u3[v12] = nil;
                    end;
                end;

                task.wait(#v15 / 200 * 60);
                break;
            else
                break;
            end;
        end;
    end;
end;

local function schedule() -- Line: 80
    -- upvalues: u2 (ref), fetchThread (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.defer(function() -- Line: 86
        -- upvalues: fetchThread (ref)
        task.wait();
        task.spawn(fetchThread);
    end);
end;

local function getUsername(p28: number) -- Line: 92
    -- upvalues: Promise (copy), u3 (copy), u2 (ref), fetchThread (copy)
    local u29 = nil;
    local v31 = Promise.new(function(p30) -- Line: 95
        -- upvalues: u29 (ref)
        u29 = p30;
    end);

    if not u3[p28] then
        u3[p28] = {};
    end;

    table.insert(u3[p28], u29);

    if not u2 then
        u2 = true;
        task.defer(function() -- Line: 86
            -- upvalues: fetchThread (ref)
            task.wait();
            task.spawn(fetchThread);
        end);
    end;

    local _, v32 = v31:await();

    return v32;
end;

function u1.GetNameFromUserIdAsync(p33: table, p34: number) -- Line: 112
    -- upvalues: getUsername (copy)
    local v35 = p33._cache:Get(p34);

    if v35 == nil then
        v35 = getUsername(p34);
    end;

    if v35 == "[couldn\'t fetch]" then
        return v35;
    end;

    p33._cache:Set(p34, v35);

    return v35;
end;

function u1.UpdateUIElementWithName(u36: table, u37: number, u38: function) -- Line: 128
    u38("...");
    task.spawn(function() -- Line: 131
        -- upvalues: u38 (copy), u36 (copy), u37 (copy)
        u38(u36:GetNameFromUserIdAsync(u37));
    end);
end;

Players.PlayerAdded:Connect(function(p39) -- Line: 136
    -- upvalues: u1 (copy)
    u1._cache:Set(p39.UserId, p39.Name);
end);

return u1;