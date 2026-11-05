  

 

local Parent = script.Parent;
local ImageLabel = Parent.ImageLabel;
Parent.Sound:Play();
game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.1), {
    ImageTransparency = 1
}):Play();