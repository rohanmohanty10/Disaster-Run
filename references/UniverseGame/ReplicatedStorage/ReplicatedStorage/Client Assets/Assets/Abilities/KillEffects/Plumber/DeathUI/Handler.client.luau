  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Parent = script.Parent;
local u1 = TweenService:Create(Parent.Symbol, TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
    Size = UDim2.fromScale(0.01, 0.01)
});
u1.Completed:Once(function() -- Line: 10
    -- upvalues: u1 (copy), Parent (copy)
    u1:Destroy();
    Parent.Main.Visible = true;
end);
Parent.Symbol.Size = UDim2.fromScale(15, 15.01);
u1:Play();