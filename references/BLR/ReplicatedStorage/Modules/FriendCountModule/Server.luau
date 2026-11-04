  

local Players = game:GetService("Players");
local u1 = {};

local function CountFriends(p2) -- Line: 6
    -- upvalues: Players (copy)
    local v3 = 0;

    for _, v in Players:GetPlayers() do
        if p2 ~= v and p2:IsFriendsWith(v.UserId) then
            v3 = v3 + 1;
        end;
    end;

    return v3;
end;

local function UpdateFriendCounts() -- Line: 19
    -- upvalues: Players (copy), u1 (copy), CountFriends (copy)
    for _, v in Players:GetPlayers() do
        u1[v] = CountFriends(v);
    end;
end;

task.spawn(UpdateFriendCounts);
Players.PlayerAdded:Connect(UpdateFriendCounts);
Players.PlayerRemoving:Connect(function() -- Line: 27
    -- upvalues: Players (copy), u1 (copy), CountFriends (copy)
    task.wait();

    for _, v in Players:GetPlayers() do
        u1[v] = CountFriends(v);
    end;
end);

return {
    GetFriendsInGame = function(p4, p5) -- Line: 35, Name: GetFriendsInGame
        -- upvalues: u1 (copy)
        return u1[p5] or 0;
    end
};