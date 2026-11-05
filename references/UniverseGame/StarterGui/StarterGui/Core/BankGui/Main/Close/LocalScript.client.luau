  

 

local Parent = script.Parent;
local Main = Parent.Parent.Parent:WaitForChild("Main");
game:GetService("TweenService");
Parent.Activated:Connect(function() -- Line: 4
    -- upvalues: Main (copy)
    Main.Visible = false;
end);