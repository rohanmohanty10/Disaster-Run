  

 

local RunService = game:GetService("RunService");
local LocalPlayer = game.Players.LocalPlayer;
UserSettings():GetService("UserGameSettings");

return function(p1) -- Line: 6
    -- upvalues: LocalPlayer (copy), RunService (copy)
    if not LocalPlayer then
        return;
    end;

    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Parent = HumanoidRootPart;
    AlignOrientation.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.Responsiveness = p1.Responsiveness or 15;
    AlignOrientation.MaxTorque = p1.MaxTorque or 250000;
    RunService:BindToRenderStep("CharacterCameraLock", Enum.RenderPriority.Camera.Value - 1, function(p2) -- Line: 19
        -- upvalues: HumanoidRootPart (copy), AlignOrientation (copy)
        local Position = HumanoidRootPart.Position;
        AlignOrientation.CFrame = CFrame.new(Position, Position + workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1));
    end);

    while Character.Parent and (p1.Reference and p1.Reference.Parent) do
        task.wait(0.1);
    end;

    RunService:UnbindFromRenderStep("CharacterCameraLock");

    if not Character then
        return;
    end;

    AlignOrientation:Destroy();
end;