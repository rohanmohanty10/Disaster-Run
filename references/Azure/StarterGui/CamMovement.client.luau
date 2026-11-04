 

 

local RunService = game:GetService("RunService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local Character = game.Players.LocalPlayer.Character;
local Head = Character:WaitForChild("Head");
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
local Humanoid = Character:WaitForChild("Humanoid");

function LerpCamera(p1)
    -- upvalues: Head (copy), HumanoidRootPart (copy), Humanoid (copy), workspace_CurrentCamera (copy)
    if not (Head:IsDescendantOf(game) and (HumanoidRootPart:IsDescendantOf(game) and Humanoid:IsDescendantOf(game))) then
        return;
    end;

    local TargetPart = workspace_CurrentCamera:FindFirstChild("TargetPart");
    local v2 = workspace_CurrentCamera.CameraSubject ~= Humanoid and Vector3.new(0, 0, 0) or HumanoidRootPart.CFrame:PointToObjectSpace(Head.Position) - Vector3.new(0, 1.5, 0);

    if TargetPart and TargetPart.Value ~= nil then
        v2 = HumanoidRootPart.CFrame:PointToObjectSpace(TargetPart.Value.Position) - Vector3.new(0, 1.5, 0);
    end;

    Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(v2, (math.clamp(p1 * 20, 0, 1)));
end;

RunService:BindToRenderStep("cameraRenderLerpUpdate", Enum.RenderPriority.Camera.Value, LerpCamera);