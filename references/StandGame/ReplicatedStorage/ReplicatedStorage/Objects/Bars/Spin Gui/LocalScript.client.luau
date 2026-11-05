 

 

local l__TweenService__1 = game:GetService("TweenService");
local l__Frame__2 = script.Parent:WaitForChild("Frame");
local l__Meter__3 = l__Frame__2:WaitForChild("Bar"):WaitForChild("Meter");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__Character__5 = l__LocalPlayer__4.Character;
local l__Spin__6 = l__Character__5:WaitForChild("Spin");
local l__CollectionService__7 = game:GetService("CollectionService");
local function u2(p1) --[[ Line: 10 ]]
    -- upvalues: l__Frame__2 (copy), l__CollectionService__7 (copy), l__Character__5 (copy), l__Meter__3 (copy), l__TweenService__1 (copy), l__Spin__6 (copy)
    l__Frame__2.Visible = p1 > 0;
    if l__CollectionService__7:HasTag(l__Character__5, "Charge Frozen") then
        l__Meter__3.BackgroundColor3 = Color3.fromRGB(85, 255, 255);
    else
        l__Meter__3.BackgroundColor3 = Color3.fromRGB(205, 253, 2);
    end;
    l__TweenService__1:Create(l__Meter__3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(p1 / l__Spin__6.MaxValue, 0, 1, 0)
    }):Play();
end;
u2(l__Spin__6.Value);
l__Spin__6.Changed:connect(function(p3) --[[ Line: 25 ]]
    -- upvalues: u2 (copy)
    u2(p3);
end);
local v4 = {};
for _, v5 in pairs(l__LocalPlayer__4.PlayerGui:GetChildren()) do
    if v5:IsA("GuiBase") and game:GetService("ReplicatedStorage").Objects.Bars:FindFirstChild(v5.Name) then
        table.insert(v4, v5);
    end;
end;
table.sort(v4, function(p6, p7) --[[ Line: 37 ]]
    return string.lower(p7.Name) < string.lower(p6.Name);
end);
for v8, v9 in pairs(v4) do
    v9.Frame.Position = UDim2.new(0.033, 0, 0.18 + 0.05 * (v8 - 1), 0);
end;
l__LocalPlayer__4.PlayerGui.ChildAdded:Connect(function() --[[ Line: 49 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__8 = script.Parent;
    local v10 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
    if v10 then
        v10 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__8.Enabled = v10;
end);
l__LocalPlayer__4.PlayerGui.ChildRemoved:Connect(function() --[[ Line: 53 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__9 = script.Parent;
    local v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
    if v11 then
        v11 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__9.Enabled = v11;
end);
local l__Parent__10 = script.Parent;
local v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
if v12 then
    v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
end;
l__Parent__10.Enabled = v12;