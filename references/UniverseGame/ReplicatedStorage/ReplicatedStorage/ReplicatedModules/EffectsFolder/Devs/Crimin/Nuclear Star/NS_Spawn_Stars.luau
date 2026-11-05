  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("RunService");
game:GetService("TweenService");

return function(p1) -- Line: 9
    print(p1);
    local Character = p1.Character;
    local v2 = Character:FindFirstChildOfClass("Humanoid");

    if not (Character:FindFirstChild("HumanoidRootPart") and v2) then
        return;
    end;

    for i, v in p1.Kunais do
        local _ = v.Kurai;
        local _ = v.Joint;
        v.TimeOffset = i * 0.1;
    end;
end;