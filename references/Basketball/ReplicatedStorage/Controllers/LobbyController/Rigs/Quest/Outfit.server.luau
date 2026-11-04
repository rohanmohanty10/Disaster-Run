 
 

if not script:IsDescendantOf(workspace) then
    return;
end;

local Players = game:GetService("Players");
local Humanoid = script.Parent:WaitForChild("Humanoid");
pcall(function() -- Line: 9
    -- upvalues: Players (copy), Humanoid (copy)
    Humanoid:ApplyDescriptionReset((Players:GetHumanoidDescriptionFromUserId(77242003)));
end);

for _, child in script.Parent:GetChildren() do
    if child:IsA("Clothing") then
        child:Destroy();
    end;
end;

script.Pants:Clone().Parent = script.Parent;