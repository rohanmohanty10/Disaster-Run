  

 

local LocalPlayer = game.Players.LocalPlayer;

for _, v in pairs(game.Players:GetPlayers()) do
    if v:GetAttribute("_vanished") and LocalPlayer.Name ~= v.Name then
        v.Parent = nil;
    end;
end;

game.Players.PlayerAdded:Connect(function(p1) -- Line: 11
    if p1:GetAttribute("_vanished") then
        p1.Parent = nil;
    end;
end);

return function(p2, p3) -- Line: 17
    -- upvalues: LocalPlayer (copy)
    if p3 then
        if p2.Name == LocalPlayer.Name then
            return;
        end;

        p2.Parent = nil;

        return;
    end;

    if p2.Name == LocalPlayer.Name then
        return;
    end;

    p2.Parent = game.Players;
end;