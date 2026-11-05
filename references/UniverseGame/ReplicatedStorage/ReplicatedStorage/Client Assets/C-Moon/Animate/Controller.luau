  

 

local Parent = script.Parent;
local Humanoid = Parent.Parent:WaitForChild("Humanoid");
local Loaded = Parent:WaitForChild("Loaded");
require(Parent:WaitForChild("VerifyAnims"))(Humanoid, Parent);
local v1;

if Humanoid.RigType == Enum.HumanoidRigType.R6 then
    v1 = require(Parent:WaitForChild("R6"));
else
    v1 = require(Parent:WaitForChild("R15"));
end;

Loaded.Value = true;

return v1;