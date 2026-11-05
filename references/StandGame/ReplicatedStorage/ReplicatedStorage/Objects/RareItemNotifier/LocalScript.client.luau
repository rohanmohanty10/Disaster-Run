 

 

local _ = game.Players.LocalPlayer.PlayerGui;
local l__Parent__1 = script.Parent;
local l__Frame__2 = l__Parent__1.Frame;
script.Sound:Play();
l__Frame__2:TweenPosition(UDim2.new(0.332, 0, 0.12, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1, true);
wait(15);
l__Frame__2:TweenPosition(UDim2.new(0.332, 0, -1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 2, true);
wait(2);
l__Parent__1:Destroy();