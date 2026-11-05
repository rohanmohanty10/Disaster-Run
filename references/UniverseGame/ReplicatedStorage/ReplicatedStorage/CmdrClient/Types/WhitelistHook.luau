  

 

local u1 = {
    ScriptDevelopers = { 696133166, 314716019, 195353328, 156538383, -1, -2, -3, -4 },
    HeadDevs = { 468046718, 21141528, 17645326, 459880822 },
    Admins = { 156538383, 195353328, 459880822 }
};
u1.ScriptDevs = u1.ScriptDevelopers;
local u2 = { 1900951801, 2913165147 };
local u3 = {
    [5] = "Testers",
    [6] = { "Senior Tester", "Testers" },
    [201] = "Mods",
    [202] = "Mods",
    [205] = "Admins",
    [206] = { "HOS", "Admins" },
    [243] = { "Devs", "Mods" },
    [246] = { "Devs", "Mods" },
    [247] = { "Devs", "Mods" },
    [248] = "ScriptDevs",
    [252] = "ScriptDevs"
};
local Core = require(game.ReplicatedStorage:WaitForChild("ReplicatedRoot").Core);
local MemoryStoreService = game:GetService("MemoryStoreService");
local u4 = game:GetService("RunService"):IsServer();
local u5 = nil;

return function(p6) -- Line: 62
    -- upvalues: u4 (copy), MemoryStoreService (copy), u5 (ref), u3 (copy), u1 (copy), u2 (copy), Core (copy)
    p6:RegisterHook("BeforeRun", function(p7) -- Line: 63
        -- upvalues: u4 (ref), MemoryStoreService (ref), u5 (ref), u3 (ref), u1 (ref), u2 (ref), Core (ref)
        local v8 = p7:GetStore("GroupCache");
        local v9 = false;
        local Executor = p7.Executor;
        local UserId = Executor.UserId;
        local u10 = 0;
        local v11 = {};
        pcall(function() -- Line: 71
            -- upvalues: u10 (ref), Executor (copy)
            u10 = Executor:GetRankInGroup(6556072);
        end);
        p7.GroupRank = u10;
        local u12 = u4 and MemoryStoreService:GetSortedMap("PrivateCodes");

        if u4 then
            if u4 and game.PrivateServerId == "" then
                u5 = 1;
            end;
        else
            u5 = tostring(UserId);
        end;

        while not u5 do
            pcall(function() -- Line: 86
                -- upvalues: u5 (ref), u12 (copy)
                u5 = u12:GetAsync(game.PrivateServerId) or 1;

                if u5 ~= 1 then
                    task.spawn(function() -- Line: 89
                        -- upvalues: u12 (ref), u5 (ref)
                        u12:SetAsync(game.PrivateServerId, u5, 691200);
                    end);
                end;

                warn(u5, "PS OWNER");
            end);
        end;

        local v13 = u3[UserId] or u3[u10];
        p7.isPublicTester = false;

        if type(p7.Group) == "table" then
            if table.find(p7.Group, "Studio") and not game:GetService("RunService"):IsStudio() then
                return "Studio Only Command";
            end;

            for _, v in ipairs(p7.Group) do
                if type(u1[v]) == "table" and table.find(u1[v], UserId) then
                    v8[UserId] = v;
                    table.insert(v11, v);
                    p7.isPublicTester = false;
                    v9 = true;
                    break;
                end;

                if type(v) == "number" and v == UserId then
                    p7.isPublicTester = false;
                    v9 = true;
                    break;
                end;
            end;

            if not v9 then
                if v13 and table.find(p7.Group, v13) then
                    v8[UserId] = v13;
                    table.insert(v11, v13);
                    p7.isPublicTester = false;
                    v9 = true;
                elseif table.find(p7.Group, "PublicTesters") and (table.find(u2, game.GameId) and (u10 >= 5 and not Core.Flags.IsPublicTesting)) then
                    v8[UserId] = "PublicTesters";
                    table.insert(v11, "PublicTesters");
                    p7.isPublicTester = true;
                    v9 = true;
                elseif table.find(p7.Group, "PSOwner") and tostring(UserId) == tostring(u5) then
                    v8[UserId] = "PSOwner";
                    table.insert(v11, "PSOwner");
                    p7.isPublicTester = false;
                    v9 = true;
                elseif type(v13) == "table" then
                    for _, v in ipairs(v13) do
                        if table.find(p7.Group, v) then
                            v8[UserId] = v;
                            table.insert(v11, v);
                            p7.isPublicTester = false;
                            v9 = true;
                            break;
                        end;
                    end;
                end;

                if not v9 then
                    if table.find(p7.Group, "Public") then
                        v8[UserId] = "Public";
                        table.insert(v11, "Public");
                        p7.isPublicTester = false;
                        v9 = true;
                    elseif table.find(p7.Group, "GuestTesters") and Core.Flags.IsPublicTesting then
                        v8[UserId] = "GuestTester";
                        table.insert(v11, "GuestTesters");
                        p7.isPublicTester = false;
                        p7.isGuestTester = true;
                        v9 = true;
                    end;
                end;
            end;
        end;

        p7.AvailableGroups = v11;

        if not v9 then
            return "You don\'t have permission to run this command";
        end;
    end);
end;