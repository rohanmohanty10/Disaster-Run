  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Packages.Signal);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u3 = {
    Changed = Signal.new(),

    GetFriendsInGame = function(p2) -- Line: 14, Name: GetFriendsInGame
        -- upvalues: u1 (copy)
        return #u1;
    end
};
task.defer(function() -- Line: 19
    -- upvalues: Players (copy), LocalPlayer (copy), u1 (copy), u3 (copy)
    local v4 = false;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and LocalPlayer:IsFriendsWith(v.UserId) then
            table.insert(u1, v);
            v4 = true;
        end;
    end;

    if v4 then
        u3.Changed:Fire();
    end;
end);
Players.PlayerAdded:Connect(function(p5) -- Line: 35
    -- upvalues: LocalPlayer (copy), u1 (copy), u3 (copy)
    if LocalPlayer:IsFriendsWith(p5.UserId) then
        table.insert(u1, p5);
        u3.Changed:Fire();
    end;
end);
Players.PlayerRemoving:Connect(function(p6) -- Line: 42
    -- upvalues: u1 (copy), u3 (copy)
    local table_find_ret = table.find(u1, p6);

    if table_find_ret then
        table.remove(u1, table_find_ret);
        u3.Changed:Fire();
    end;
end);

return u3;