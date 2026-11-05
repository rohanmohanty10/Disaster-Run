  

 

local Parent = script.Parent;
local Main = Parent.Parent.Parent:WaitForChild("Main");
local TweenService = game:GetService("TweenService");
Parent.Activated:Connect(function() -- Line: 4
    -- upvalues: TweenService (copy), Main (copy), Parent (copy)
    local v1 = TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        Size = UDim2.new(0.664, 0, 0, 0)
    });
    v1:Play();
    v1.Completed:Wait();
    Main.Visible = false;
    Parent.Visible = false;
end);