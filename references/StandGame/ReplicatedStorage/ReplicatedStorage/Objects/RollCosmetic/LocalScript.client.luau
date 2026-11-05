 

 

local l__Parent__1 = script.Parent;
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__FunctionLibrary__3 = require(game.ReplicatedStorage.Modules.FunctionLibrary);
local l__Frame__4 = l__Parent__1:WaitForChild("Frame");
local l__Percentages__5 = l__Frame__4:WaitForChild("Percentages");
local l__Roll__6 = l__Frame__4:WaitForChild("Roll");
l__Frame__4:WaitForChild("Exit").MouseButton1Click:Connect(function() --[[ Line: 12 ]]
    -- upvalues: l__Parent__1 (copy)
    l__Parent__1:Destroy();
end);
l__Roll__6.MouseButton1Click:Connect(function() --[[ Line: 16 ]]
    -- upvalues: l__LocalPlayer__2 (copy)
    if l__LocalPlayer__2:GetAttribute("ArePaidRandomItemsRestricted") == nil or l__LocalPlayer__2:GetAttribute("ArePaidRandomItemsRestricted") == true then
        _G.Message({
            Text = "You can not purchase random items with ROBUX due to your Country\'s laws (ArePaidRandomItemsRestricted is true)",
            TextColor = BrickColor.new("Really red"),
            Sound = {
                Sound = "Error",
                ClientOnly = true
            }
        });
    else
        game:GetService("MarketplaceService"):PromptProductPurchase(l__LocalPlayer__2, 999116657);
    end;
end);
local v1 = 0;
for _, v2 in pairs(l__FunctionLibrary__3.SBRCosmeticChances) do
    local v3 = l__Percentages__5.Sample:Clone();
    v3.Parent = l__Percentages__5;
    v3.Text = v2.Name .. " - " .. v2.Percentage * 100 .. "%";
    v3.Name = v2.Name;
    v3.Visible = true;
    v3.Position = v3.Position + UDim2.new(0, 0, v1, 0);
    v3.TextColor3 = l__FunctionLibrary__3.CosmeticRarities[v2.Name].Color;
    v1 = v1 + 0.05;
end;