  

 

local RunService = game:GetService("RunService");
local LocalPlayer = game.Players.LocalPlayer;
local UserGameSettings = UserSettings():GetService("UserGameSettings");

return function() -- Line: 6
    -- upvalues: LocalPlayer (copy), RunService (copy), UserGameSettings (copy)
    if not LocalPlayer then
        return;
    end;

    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u1 = LocalPlayer:GetMouse();
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Parent = HumanoidRootPart;
    AlignOrientation.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    RunService:BindToRenderStep("TheVessel_Lock", Enum.RenderPriority.Last.Value, function(p2) -- Line: 19
        -- upvalues: HumanoidRootPart (copy), UserGameSettings (ref), AlignOrientation (copy), u1 (copy)
        local Position = HumanoidRootPart.Position;

        if UserGameSettings.RotationType == Enum.RotationType.CameraRelative then
            local _, v3, _ = workspace.CurrentCamera.CFrame:ToEulerAngles(Enum.RotationOrder.YXZ);
            AlignOrientation.CFrame = CFrame.new(Position) * CFrame.Angles(0, v3, 0);

            return;
        end;

        local Position2 = u1.Hit.Position;
        AlignOrientation.CFrame = CFrame.new(Position, (Vector3.new(Position2.X, Position.Y, Position2.Z)));
    end);

    while Character.Parent and Character:GetAttribute("MouseLock_Vessel") do
        task.wait(0.1);
    end;

    RunService:UnbindFromRenderStep("TheVessel_Lock");

    if not Character then
        return;
    end;

    AlignOrientation:Destroy();
end;