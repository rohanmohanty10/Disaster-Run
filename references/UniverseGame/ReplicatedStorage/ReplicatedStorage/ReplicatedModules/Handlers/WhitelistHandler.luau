  

 

local PathShortcuts = require(game:GetService("ReplicatedStorage").ReplicatedModules.PathShortcuts);
local RunService = game:GetService("RunService");
local Stands = PathShortcuts.ReplicatedModules.Stands;
local u1 = require(Stands);
require(Stands.whitelisted);
local CRAbilities = require(script.CRAbilities);
local WhitelistedUsers = require(script.WhitelistedUsers);
local ItemWhitelist = require(script.ItemWhitelist);
local u2 = {};
local u3 = { "Dragon Sage" };
local u4 = {};

if RunService:IsServer() then
    local u5 = game:GetService("MemoryStoreService"):GetSortedMap("RobuxLeaderboard");

    local function RefreshDynamicWhitelists() -- Line: 24
        -- upvalues: u5 (copy), u3 (copy), u4 (copy)
        local success, result = pcall(function() -- Line: 25
            -- upvalues: u5 (ref)
            return u5:GetAsync("AllTime");
        end);

        if not success or type(result) ~= "table" then
            warn("Failed to refresh RobuxLeaderboard dynamic whitelist:", result);

            return;
        end;

        local v6 = {};
        local v7 = result[1];

        if v7 and v7.UserId then
            v6[v7.UserId] = true;
        end;

        local v8 = result[2];

        if v8 and v8.UserId then
            v6[v8.UserId] = true;
        end;

        local v9 = result[3];

        if v9 and v9.UserId then
            v6[v9.UserId] = true;
        end;

        for _, v in u3 do
            u4[v] = v6;
        end;
    end;

    task.spawn(function() -- Line: 47
        -- upvalues: RefreshDynamicWhitelists (copy)
        while true do
            RefreshDynamicWhitelists();
            task.wait(300);
        end;
    end);
end;

function u2.GetItemWhitelist() -- Line: 55
    -- upvalues: ItemWhitelist (copy)
    return ItemWhitelist;
end;

function u2.IsAbilityIdCR(p10) -- Line: 59
    -- upvalues: u1 (copy), u2 (copy)
    return u2.IsAbilityNameCR(u1[p10]);
end;

function u2.IsAbilityNameCR(p11) -- Line: 64
    -- upvalues: CRAbilities (copy)
    if p11 then
        return table.find(CRAbilities, p11) and true;
    end;
end;

function u2.GetCRAbilities() -- Line: 69
    -- upvalues: CRAbilities (copy)
    return CRAbilities;
end;

function u2.IsUserWhitelistedForAbilityId(p12, p13) -- Line: 73
    -- upvalues: u1 (copy), WhitelistedUsers (copy), u4 (copy)
    local v14 = u1[p13];

    if v14 then
        if WhitelistedUsers[p12] and table.find(WhitelistedUsers[p12], v14) then
            return true;
        end;

        local v15 = u4[v14];

        return v15 and v15[p12] and true or false;
    end;
end;

function u2.IsUserWhitelistedForItemId(p16, p17) -- Line: 87
    -- upvalues: ItemWhitelist (copy)
    local v18 = ItemWhitelist[p17] and table.find(ItemWhitelist[p17], p16);

    return v18;
end;

return u2;