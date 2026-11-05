 

 

local l__Parent__1 = script.Parent;
local l__Frame__2 = l__Parent__1:WaitForChild("Frame");
l__Frame__2:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 2);
wait(5);
l__Frame__2:TweenPosition(UDim2.new(0, 0, -0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5);
wait(0.5);
l__Parent__1:Destroy();