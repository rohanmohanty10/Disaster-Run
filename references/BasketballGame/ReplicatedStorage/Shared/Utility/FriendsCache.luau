 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = {
    _cache = require(ReplicatedStorage.Packages.Kache)(3600)
};

function u1.GetFriendsFromUserId(p2: table, p3: number) -- Line: 9
    -- upvalues: u1 (copy)
    local v4 = p2._cache:Get(p3);

    if v4 then
        return v4;
    end;

    local v5 = u1:UpdateFriends(p3);
    p2._cache:Set(p3, v5);

    return v5;
end;

function u1.UpdateFriends(p6: table, u7: number) -- Line: 21
    -- upvalues: Players (copy)
    local v8 = {};
    local success, result = pcall(function() -- Line: 23
        -- upvalues: Players (ref), u7 (copy)
        return Players:GetFriendsAsync(u7);
    end);

    if success then
        repeat
            local CurrentPage = result:GetCurrentPage();

            for _, v in pairs(CurrentPage) do
                table.insert(v8, v.Id);
            end;

            if not result.IsFinished then
                result:AdvanceToNextPageAsync();
            end;
        until result.IsFinished;
    end;

    return v8;
end;

Players.PlayerAdded:Connect(function(p9) -- Line: 38
    -- upvalues: u1 (copy)
    u1._cache:Set(p9.UserId, u1:UpdateFriends(p9.UserId));
end);

return u1;