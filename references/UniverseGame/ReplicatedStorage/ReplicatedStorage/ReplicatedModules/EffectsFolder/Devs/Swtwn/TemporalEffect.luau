  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(u1, u2, p3) -- Line: 5
    -- upvalues: LocalPlayer (copy), TweenService (copy), Debris (copy)
    local u4 = p3 or 2;
    local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui);
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Name = "VignetteGUI";
    local ImageLabel = Instance.new("ImageLabel", ScreenGui);
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://3124804643";
    ImageLabel.ImageColor3 = Color3.fromRGB(0, 46, 255);
    ImageLabel.ImageTransparency = 1;
    local BloomEffect = Instance.new("BloomEffect", game.Lighting);
    BloomEffect.Name = "TSpeedBloom";
    local v5 = BloomEffect:Clone();
    TweenService:Create(ImageLabel, TweenInfo.new(0.25), {
        ImageTransparency = 0,
        ImageColor3 = u1
    }):Play();
    task.spawn(function() -- Line: 23
        -- upvalues: u4 (copy), TweenService (ref), ImageLabel (copy), u2 (copy), u1 (copy), ScreenGui (copy)
        for _ = 2, u4 / 0.25 / 2 do
            wait(0.25);
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageColor3 = u2
            }):Play();
            wait(0.25);
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageColor3 = u1
            }):Play();
        end;

        wait(0.25);
        TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        wait(0.25);
        ScreenGui:Destroy();
    end);
    TweenService:Create(BloomEffect, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Intensity = 5,
        Size = 100,
        Threshold = 0.3
    }):Play();
    wait(u4);
    TweenService:Create(BloomEffect, TweenInfo.new(0.5), {
        Intensity = v5.Intensity,
        Size = v5.Size,
        Threshold = v5.Threshold
    }):Play();
    v5:Destroy();
    Debris:AddItem(BloomEffect, 0.6);
end;