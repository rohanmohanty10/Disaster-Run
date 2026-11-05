  

 

game:GetService("Players");
local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");
local u2 = {};
local u3 = {};

local function GetFriends(u4) -- Line: 15
    -- upvalues: u3 (copy), u2 (copy)
    if u3[u4.UserId] then
        return u3[u4.UserId];
    end;

    if u2[u4.UserId] then
        table.insert(u2[u4.UserId], coroutine.running());

        return coroutine.yield();
    end;

    u2[u4.UserId] = {};
    local u5 = {};
    local success, result = pcall(function() -- Line: 23
        -- upvalues: u4 (copy), u5 (copy)
        local v6 = game.Players:GetFriendsAsync(u4.UserId);

        while true do
            for _, v in ipairs(v6:GetCurrentPage()) do
                table.insert(u5, v);
            end;

            if v6.IsFinished then
                return;
            end;

            v6:AdvanceToNextPageAsync();
        end;
    end);

    if success ~= true then
        for _, v in u2[u4.UserId] do
            task.spawn(v, false, result);
        end;

        u2[u4.UserId] = nil;

        return false, result;
    end;

    u3[u4.UserId] = u5;
    task.delay(180, function() -- Line: 43
        -- upvalues: u3 (ref), u4 (copy)
        u3[u4.UserId] = nil;
    end);

    for _, v in u2[u4.UserId] do
        task.spawn(v, u5);
    end;

    u2[u4.UserId] = nil;

    return u5;
end;

return {
    ItemId = "MOUNT_38",
    Inherit = "Hoverboard",
    Model = game.ReplicatedStorage["Client Assets"].Misc.NoobieBike,
    MovementProperties = {
        MAX_SPEED = 80,
        MOTIONAL_ACCELERATION = 1.15
    },

    OnSetup = function(p7) -- Line: 61, Name: OnSetup
        -- upvalues: GetFriends (copy), u1 (copy)
        local v8 = GetFriends(p7.Player);
        local v9;

        if #v8 > 0 then
            v9 = v8[math.random(1, #v8)].Id;
        else
            v9 = math.random(1, 2) == 1 and 21141528 or 110231579;
        end;

        u1.FireAllClients("Avatar Mount Render", p7.Character, v9);
    end
};