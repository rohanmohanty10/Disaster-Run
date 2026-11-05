  

 

local RunService = game:GetService("RunService");
local ReplicatedRoot = game.ReplicatedStorage:WaitForChild("ReplicatedRoot");

if RunService:IsServer() then
    game.ServerStorage:WaitForChild("ServerRoot");
end;

require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);

return true;