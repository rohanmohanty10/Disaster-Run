  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

return function(p1) -- Line: 8
    -- upvalues: LocalPlayer (copy), PlayerGui (copy), Lighting (copy), TweenService (copy)
    local v2 = p1 or {};
    local Settings = LocalPlayer:FindFirstChild("Settings");

    if Settings and not Settings.ImpactFrame.Value then
        return;
    end;

    local v3 = v2.StartingColor or Color3.new(0, 0, 0);
    local v4 = v2.EndingColor or Color3.new(0, 0, 0);
    local u5 = v2.TweenTime or 0.25;
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "VignetteScreen";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Parent = PlayerGui;
    task.delay(u5 * 3, ScreenGui.Destroy, ScreenGui);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageColor3 = v3;
    ImageLabel.Image = "rbxassetid://3124804643";
    ImageLabel.ImageTransparency = 1;
    ImageLabel.Parent = ScreenGui;

    if v2.Blur then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = v2.Blur;
        BlurEffect.Parent = Lighting;
        task.delay(u5 * 2, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(BlurEffect, TweenInfo.new(u5 * 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = 0
        }):Play();
    end;

    TweenService:Create(ImageLabel, TweenInfo.new(u5 / 2), {
        ImageTransparency = v2.Transparency or 0
    }):Play();
    TweenService:Create(ImageLabel, TweenInfo.new(u5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true, u5), {
        ImageColor3 = v4
    }):Play();
    task.delay(u5 * 2, function() -- Line: 51
        -- upvalues: TweenService (ref), ImageLabel (copy), u5 (copy)
        TweenService:Create(ImageLabel, TweenInfo.new(u5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
    end);
end;