  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
require(PathShortcuts.KnitPath.Trove);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 11
    local v2 = p1:WaitForChild("Celestial Starboard", 5);

    if not v2 then
        return;
    end;

    while true do
        local v3 = task.wait();

        if v2:IsDescendantOf(game) and v2:FindFirstChild("Rotatable") then
            local Rotatable = v2:FindFirstChild("Rotatable");
            Rotatable.C0 = Rotatable.C0 * CFrame.Angles(3.141592653589793 * v3, 0, 0);
        end;

        if not (p1:IsDescendantOf(game) and p1:GetAttribute("Mount")) then
            p1:IsDescendantOf(game);

            return;
        end;
    end;
end;