 

 

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__RemoteEvent__2 = (l__LocalPlayer__1.Character or l__LocalPlayer__1.CharacterAdded:wait()):WaitForChild("RemoteEvent");
local l__Parent__3 = script.Parent;
local l__Frame__4 = l__Parent__3:WaitForChild("Frame");
local l__Check__5 = l__Frame__4:WaitForChild("Check");
local l__X__6 = l__Frame__4:WaitForChild("X");
local l__Item__7 = l__Parent__3:WaitForChild("Item");
l__Check__5.MouseButton1Down:Connect(function() --[[ Line: 12 ]]
    -- upvalues: l__RemoteEvent__2 (copy), l__Item__7 (copy), l__Parent__3 (copy)
    l__RemoteEvent__2:FireServer("DeleteItem", l__Item__7.Value);
    l__Parent__3:Destroy();
end);
l__X__6.MouseButton1Down:Connect(function() --[[ Line: 17 ]]
    -- upvalues: l__Parent__3 (copy)
    l__Parent__3:Destroy();
end);