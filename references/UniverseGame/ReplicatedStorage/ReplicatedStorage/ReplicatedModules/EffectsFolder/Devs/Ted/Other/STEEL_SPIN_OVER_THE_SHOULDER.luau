  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
local LocalPlayer = game.Players.LocalPlayer;
require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetCameras();
local SteelSpin = LocalPlayer.PlayerGui.UI.Gameplay.Abilities.SteelSpin;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CurrentCamera = workspace.CurrentCamera;
local u1 = Vector2.new();
local u2 = Vector2.new();
RunService:BindToRenderStep("Contiguous_Mouse_Delta", Enum.RenderPriority.Camera.Value, function(p3) -- Line: 20
    -- upvalues: u1 (ref), UserInputService (copy), u2 (ref)
    local v4 = p3 * 60;
    u1 = u1:Lerp(UserInputService:GetMouseDelta(), 0.5 * v4);
    u2 = u2 - u1 * 0.017453292519943295 * v4;
    u2 = Vector2.new(u2.X, (math.clamp(u2.Y, -0.5235987755982988, 0.5235987755982988)));
end);

local function ActivateCrosshair() -- Line: 28
    -- upvalues: UserInputService (copy), SteelSpin (copy), TweenService (copy)
    UserInputService.MouseIconEnabled = false;
    SteelSpin.Visible = true;

    for _, child in pairs(SteelSpin:GetChildren()) do
        local Position = child.Position;
        child.Position = UDim2.new(child.Position.X.Scale + 0.2, 0, child.Position.Y.Scale, 0);
        child.ImageTransparency = 1;
        TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Position = Position
        }):Play();
    end;

    coroutine.wrap(function() -- Line: 37
        -- upvalues: TweenService (ref), SteelSpin (ref)
        local v5 = 1;

        repeat
            TweenService:Create(SteelSpin.SpinningLines, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Rotation = SteelSpin.SpinningLines.Rotation + 180
            }):Play();
            task.wait(0.1);
            v5 = v5 + 1;
        until SteelSpin.Visible == false;
    end)();
end;

local function HideCrosshair() -- Line: 48
    -- upvalues: UserInputService (copy), SteelSpin (copy), TweenService (copy)
    UserInputService.MouseIconEnabled = true;

    for _, child in pairs(SteelSpin:GetChildren()) do
        TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end;

    task.delay(0.3, function() -- Line: 53
        -- upvalues: SteelSpin (ref)
        SteelSpin.Visible = false;
    end);
end;

return function(p6, p7) -- Line: 58
    -- upvalues: TweenService (copy), CurrentCamera (copy), ActivateCrosshair (copy), RunService (copy), UserInputService (copy), HideCrosshair (copy)
    local HumanoidRootPart = p6:FindFirstChild("HumanoidRootPart");

    if not p7 then
        TweenService:Create(CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
        }):Play();
        HideCrosshair();
        task.wait(0.2);
        RunService:UnbindFromRenderStep("Steel_Spin_Over_The_Shoulder_Camera");
        CurrentCamera:SetAttribute("HeadOffset", nil);
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;

        if HumanoidRootPart:FindFirstChild("OverShouldAttach") then
            HumanoidRootPart.OverShouldAttach:Destroy();
        end;

        return;
    end;

    TweenService:Create(CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        FieldOfView = 60
    }):Play();
    ActivateCrosshair();
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "OverShouldAttach";
    Attachment.Parent = HumanoidRootPart;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Responsiveness = 100;
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.MaxTorque = 1000000;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.Parent = Attachment;
    RunService:BindToRenderStep("Steel_Spin_Over_The_Shoulder_Camera", Enum.RenderPriority.Last.Value, function(p8) -- Line: 79
        -- upvalues: UserInputService (ref), CurrentCamera (ref), HumanoidRootPart (copy), AlignOrientation (copy)
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        CurrentCamera:SetAttribute("HeadOffset", HumanoidRootPart.CFrame.LookVector * -2.5 + HumanoidRootPart.CFrame.UpVector + HumanoidRootPart.CFrame.RightVector * -3);
        AlignOrientation.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1));
    end);
end;