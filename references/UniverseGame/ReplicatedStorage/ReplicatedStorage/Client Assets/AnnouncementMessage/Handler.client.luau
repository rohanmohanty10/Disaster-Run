  

 

local TweenService = game:GetService("TweenService");
local Parent = script.Parent;
local Main = Parent.Main;
local u1 = false;
Main.Close.MouseButton1Down:Connect(function() -- Line: 9
    -- upvalues: u1 (ref), TweenService (copy), Main (copy), Parent (copy)
    if u1 == true then
        return;
    end;

    u1 = true;
    TweenService:Create(Main, TweenInfo.new(0.5), {
        Position = UDim2.new(0.002, 0, -1, 0)
    }):Play();
    task.wait(0.5);
    Parent:Destroy();
end);