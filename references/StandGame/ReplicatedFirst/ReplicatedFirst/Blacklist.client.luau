 

 

local l__LocalPlayer__1 = game.Players.LocalPlayer;
for _, v1 in pairs({
    {
        ID = 23833848,
        Message = "CujohJolyne be like 🤡"
    },
    {
        ID = 0,
        Message = "Test"
    }
}) do
    if v1.ID == l__LocalPlayer__1.UserId or v1.UserName == l__LocalPlayer__1.Name then
        l__LocalPlayer__1:Kick(v1.Message);
    end;
end;
game.ReplicatedFirst:WaitForChild("ClientHandler");
game.ReplicatedStorage:WaitForChild("Checker").OnClientInvoke = function() --[[ Line: 20 ]]
    local v2 = game.ReplicatedFirst:FindFirstChild("ClientHandler");
    if v2 then
        v2 = not game.ReplicatedFirst:FindFirstChild("ClientHandler").Disabled;
    end;
    print(v2);
    return true;
end;