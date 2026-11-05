  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 7
    -- upvalues: TweenService (copy), CurrentCamera (copy)
    local UI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI");
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = UI;
    TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, true), {
        BackgroundTransparency = 0
    }):Play();
    game.Debris:AddItem(Frame, 0.8);
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local v1 = TweenService:Create(CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FieldOfView = 50,
        CFrame = CurrentCamera.CFrame * CFrame.Angles(0, 0, 0.5235987755982988)
    });
    v1:Play();
    local u2 = nil;
    u2 = v1.Completed:Connect(function() -- Line: 25
        -- upvalues: u2 (ref), CurrentCamera (ref)
        u2:Disconnect();
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value;
    end);
end;