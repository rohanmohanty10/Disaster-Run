 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = require(script.Parent:WaitForChild("UIProportions")).watch(LocalPlayer:WaitForChild("PlayerGui"));
script.Destroying:Connect(v1);