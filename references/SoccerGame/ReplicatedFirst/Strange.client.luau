  

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Football = workspace:WaitForChild("Football");
Football:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 5
    -- upvalues: LocalPlayer (copy), Football (copy)
    local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v1 and ((v1.Position - Football.Position).Magnitude > 45 and Football.Char.Value == v1.Parent) then
        Football.Position = v1.Position;
        v1.Parent:FindFirstChild("Humanoid");
    end;
end);