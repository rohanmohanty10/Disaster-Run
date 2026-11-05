 

 

local l__TweenService__1 = game:GetService("TweenService");
local l__Frame__2 = script.Parent:WaitForChild("Frame");
local l__Meter__3 = l__Frame__2:WaitForChild("Bar"):WaitForChild("Meter");
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__Character__5 = l__LocalPlayer__4.Character;
local l__Hamon__6 = l__Character__5:WaitForChild("Hamon");
local u1 = l__LocalPlayer__4:FindFirstChild("SpecSkillTree"):FindFirstChild("Bubble Lenses");
local u2 = Color3.fromRGB(172, 123, 197);
local l__CollectionService__7 = game:GetService("CollectionService");
local function u4(p3) --[[ Line: 13 ]]
    -- upvalues: l__Frame__2 (copy), u1 (copy), l__CollectionService__7 (copy), l__Character__5 (copy), l__Meter__3 (copy), u2 (copy), l__TweenService__1 (copy), l__Hamon__6 (copy)
    l__Frame__2.Visible = p3 > 0;
    if u1 and (u1.Value and (p3 >= 50 and not l__CollectionService__7:HasTag(l__Character__5, "Charge Frozen"))) then
        l__Meter__3.BackgroundColor3 = u2;
    elseif l__CollectionService__7:HasTag(l__Character__5, "Charge Frozen") then
        l__Meter__3.BackgroundColor3 = Color3.fromRGB(85, 255, 255);
    else
        l__Meter__3.BackgroundColor3 = Color3.fromRGB(247, 238, 134);
    end;
    l__TweenService__1:Create(l__Meter__3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(p3 / l__Hamon__6.MaxValue, 0, 1, 0)
    }):Play();
end;
u4(l__Hamon__6.Value);
l__Hamon__6.Changed:connect(function(p5) --[[ Line: 30 ]]
    -- upvalues: u4 (copy)
    u4(p5);
end);
local v6 = {};
for _, v7 in pairs(l__LocalPlayer__4.PlayerGui:GetChildren()) do
    if v7:IsA("GuiBase") and game:GetService("ReplicatedStorage").Objects.Bars:FindFirstChild(v7.Name) then
        table.insert(v6, v7);
    end;
end;
table.sort(v6, function(p8, p9) --[[ Line: 42 ]]
    return string.lower(p9.Name) < string.lower(p8.Name);
end);
for v10, v11 in pairs(v6) do
    v11.Frame.Position = UDim2.new(0.033, 0, 0.18 + 0.05 * (v10 - 1), 0);
end;
l__LocalPlayer__4.PlayerGui.ChildAdded:Connect(function() --[[ Line: 54 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__8 = script.Parent;
    local v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
    if v12 then
        v12 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__8.Enabled = v12;
end);
l__LocalPlayer__4.PlayerGui.ChildRemoved:Connect(function() --[[ Line: 58 ]]
    -- upvalues: l__LocalPlayer__4 (copy)
    local l__Parent__9 = script.Parent;
    local v13 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
    if v13 then
        v13 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
    end;
    l__Parent__9.Enabled = v13;
end);
local l__Parent__10 = script.Parent;
local v14 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("LoadingScreen");
if v14 then
    v14 = not l__LocalPlayer__4.PlayerGui:FindFirstChild("No Bar");
end;
l__Parent__10.Enabled = v14;