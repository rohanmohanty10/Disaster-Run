  

 

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");

return function() -- Line: 8
    -- upvalues: PlayerGui (copy), TweenService (copy), Lighting (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = PlayerGui.Core;
    local v1 = TweenService:Create(Frame, TweenInfo.new(0.25), {
        BackgroundTransparency = 0
    });
    v1:Play();
    v1.Completed:Wait();
    local Atmosphere = Instance.new("Atmosphere");
    Atmosphere.Color = Color3.new(0, 0, 0);
    Atmosphere.Decay = Color3.new(0, 0, 0);
    Atmosphere.Density = 1;
    Atmosphere.Offset = 0;
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 10;
    Atmosphere.Parent = Lighting;
    task.wait(0.5);
    TweenService:Create(Frame, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play();
end;