 

 

local l__TweenService__1 = game:GetService("TweenService");
local l__Frame__2 = script.Parent:WaitForChild("Frame");
local l__Meter__3 = l__Frame__2:WaitForChild("Bar"):WaitForChild("Meter");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local u1 = l__LocalPlayer__4.Character:WaitForChild("Lethal Tempo");
local function u3(p2) --[[ Line: 9 ]]
    -- upvalues: l__Frame__2 (copy), l__TweenService__1 (copy), l__Meter__3 (copy), u1 (copy)
    l__Frame__2.Visible = p2 > 0;
    l__TweenService__1:Create(l__Meter__3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(p2 / u1.MaxValue, 0, 1, 0)
    }):Play();
end;
u3(u1.Value);
u1.Changed:connect(function(p4) --[[ Line: 18 ]]
    -- upvalues: u3 (copy)
    u3(p4);
end);
local v5 = {};
for _, v6 in pairs(l__LocalPlayer__4.PlayerGui:GetChildren()) do
    if v6:IsA("GuiBase") and game:GetService("ReplicatedStorage").Objects.Bars:FindFirstChild(v6.Name) then
        table.insert(v5, v6);
    end;
end;
table.sort(v5, function(p7, p8) --[[ Line: 30 ]]
    return string.lower(p8.Name) < string.lower(p7.Name);
end);
for v9, v10 in pairs(v5) do
    v10.Frame.Position = UDim2.new(0.033, 0, 0.18 + 0.05 * (v9 - 1), 0);
end;
l__LocalPlayer__4.PlayerGui.ChildAdded:Connect(function() --[[ Line: 42 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__5 = script.Parent;
    local v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
    if v11 then
        v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__5.Enabled = v11;
end);
l__LocalPlayer__4.PlayerGui.ChildRemoved:Connect(function() --[[ Line: 46 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__6 = script.Parent;
    local v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
    if v12 then
        v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__6.Enabled = v12;
end);
local l__Parent__7 = script.Parent;
local v13 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("MainMenu");
if v13 then
    v13 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
end;
l__Parent__7.Enabled = v13;