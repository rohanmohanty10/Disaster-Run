 

 

local l__TweenService__1 = game:GetService("TweenService");
local l__Frame__2 = script.Parent:WaitForChild("Frame");
local l__Meter__3 = l__Frame__2:WaitForChild("Bar"):WaitForChild("Meter");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__Dino_Barrage_Phase__5 = l__LocalPlayer__4.Character:WaitForChild("Dino_Barrage_Phase");
local function u2(p1) --[[ Line: 9 ]]
    -- upvalues: l__Frame__2 (copy), l__TweenService__1 (copy), l__Meter__3 (copy), l__Dino_Barrage_Phase__5 (copy)
    l__Frame__2.Visible = p1 > 0;
    l__TweenService__1:Create(l__Meter__3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(p1 / l__Dino_Barrage_Phase__5.MaxValue, 0, 1, 0)
    }):Play();
end;
u2(l__Dino_Barrage_Phase__5.Value);
l__Dino_Barrage_Phase__5.Changed:connect(function(p3) --[[ Line: 18 ]]
    -- upvalues: u2 (copy)
    u2(p3);
end);
local v4 = {};
for _, v5 in pairs(l__LocalPlayer__4.PlayerGui:GetChildren()) do
    if v5:IsA("GuiBase") and game:GetService("ReplicatedStorage").Objects.Bars:FindFirstChild(v5.Name) then
        table.insert(v4, v5);
    end;
end;
table.sort(v4, function(p6, p7) --[[ Line: 30 ]]
    return string.lower(p7.Name) < string.lower(p6.Name);
end);
for v8, v9 in pairs(v4) do
    v9.Frame.Position = UDim2.new(0.033, 0, 0.18 + 0.05 * (v8 - 1), 0);
end;
l__LocalPlayer__4.PlayerGui.ChildAdded:Connect(function() --[[ Line: 42 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__6 = script.Parent;
    local v10 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
    if v10 then
        v10 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__6.Enabled = v10;
end);
l__LocalPlayer__4.PlayerGui.ChildRemoved:Connect(function() --[[ Line: 46 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__7 = script.Parent;
    local v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
    if v11 then
        v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__7.Enabled = v11;
end);
local l__Parent__8 = script.Parent;
local v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
if v12 then
    v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
end;
l__Parent__8.Enabled = v12;