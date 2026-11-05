  

 

local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;

return function(p1, p2) -- Line: 3
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy)
    local u3 = game.ReplicatedStorage["Client Assets"]["Gold Experience"].CinematicBars:Clone();
    u3.Parent = LocalPlayer.PlayerGui;
    LocalPlayer.PlayerGui.Core.MainGUI.Enabled = false;
    local u4 = false;
    local u5 = nil;
    local u6 = nil;
    u5 = p1:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 10
        -- upvalues: u4 (ref), CurrentCamera (ref), u5 (ref), u6 (ref), LocalPlayer (ref), u3 (copy)
        u4 = true;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        u5:Disconnect();
        u6:Disconnect();
        u5 = nil;
        u6 = nil;
        LocalPlayer.PlayerGui.Core.MainGUI.Enabled = true;
        u3:Destroy();
    end);
    u6 = p2:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 20
        -- upvalues: u4 (ref), CurrentCamera (ref), u5 (ref), u6 (ref), LocalPlayer (ref), u3 (copy)
        u4 = true;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        u5:Disconnect();
        u6:Disconnect();
        u5 = nil;
        u6 = nil;
        LocalPlayer.PlayerGui.Core.MainGUI.Enabled = true;
        u3:Destroy();
    end);
    wait(0.8);

    if p1.Parent ~= workspace.Living or p2.Parent ~= workspace.Living then
        return;
    end;

    local HumanoidRootPart = p1.HumanoidRootPart;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local Frames = game:GetService("ReplicatedStorage")["Client Assets"]["Gold Experience"].Frames;

    for i = 1, #Frames:GetChildren() do
        local v7 = Frames:FindFirstChild(i);

        if not v7 or (u4 or not game:GetService("CollectionService"):HasTag(p1, "Cutscening")) then
            break;
        end;

        CurrentCamera.CFrame = HumanoidRootPart.CFrame * v7.Value;
        wait(0.01);
    end;

    CurrentCamera.CameraType = Enum.CameraType.Custom;
    LocalPlayer.PlayerGui.Core.MainGUI.Enabled = true;
    u3:Destroy();
end;