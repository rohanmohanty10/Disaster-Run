 

 

local Lighting = game:GetService("Lighting");
local Humanoid = script.Parent:WaitForChild("Humanoid");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace_CurrentCamera.CameraSubject = Humanoid;
workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
local GoalDepth = Lighting:FindFirstChild("GoalDepth");

if GoalDepth then
    GoalDepth:Destroy();
end;