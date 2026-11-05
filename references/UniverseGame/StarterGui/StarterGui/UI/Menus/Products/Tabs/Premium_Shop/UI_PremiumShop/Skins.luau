  

 

local Players = game:GetService("Players");
local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);

return function(u1, u2) -- Line: 4
    -- upvalues: Players (copy), ItemData (copy)
    local _ = Players.LocalPlayer;
    local Knit = u1.Knit;
    Knit.OnStart():await();
    local Button = u2.Assets.Button;
    local PremiumSkins = game:GetService("ReplicatedStorage"):WaitForChild("PremiumSkins");
    local u3 = Knit.GetService("ShopService");

    local function CreateButton(p4) -- Line: 15
        -- upvalues: u2 (copy), ItemData (ref), u1 (copy), Button (copy), u3 (copy)
        if u2.ItemsFrame:FindFirstChild((`{p4.Name}_{u2.Tab}`)) then
            return;
        end;

        local v5 = ItemData.GetItemInfo(p4:GetAttribute("ItemId")) or {};
        local u6 = v5.DisplayName or (v5.Name or p4.Name);

        if p4:GetAttribute("Limited") then
            local v7 = (ItemData.GetRarityData(v5.Rarity) or {}).Color or Color3.new(1, 1, 1);
            u1:Notify(`<font color="#{Color3.new(0, 1, 1):ToHex()}">Premium Skin Added</font>`, `<font color="#{v7:ToHex()}">{u6}</font>`, 5);
            u1:PlaySound("ug_levelup");
        end;

        local v8 = Button:Clone();
        local Camera = Instance.new("Camera");
        Camera.Parent = v8.ViewportFrame;
        v8.ViewportFrame.CurrentCamera = Camera;
        local u9 = p4:Clone();
        u9.Parent = v8.ViewportFrame;
        local identity = CFrame.identity;
        u9:PivotTo(identity);
        Camera.CFrame = CFrame.lookAt(identity.LookVector * 5.5, identity.Position);

        if v5.PreviewData then
            Camera.CFrame = v5.PreviewData.CameraOrigin or Camera.CFrame;
            u9:PivotTo(v5.PreviewData.ModelOrigin or u9:GetPivot());
        end;

        local v10 = string.match(u9:GetAttribute("ItemId") or "", "SKIN_(.+)_");
        v8.Name = `{u9.Name}_{u2.Tab}`;
        v8.ItemName.Text = u6;

        if v10 then
            local v11 = ItemData.GetItemInfo("ABILITY_" .. v10);

            if v11 and v11.Name then
                local ItemName = v8.ItemName;
                ItemName.Text = ItemName.Text .. `\n ({v11.Name})`;
            end;
        end;

        if v8:FindFirstChild("UIStroke") then
            v8.UIGradient.Color = ColorSequence.new(ItemData.Rarities[v5.Rarity or 1].Color);
            v8.ItemName.UIGradient.Color = ColorSequence.new(ItemData.Rarities[v5.Rarity or 1].Color);

            if v5.Rarity == 12 then
                v8.ItemName.TextStrokeTransparency = 1;
            end;

            v8:FindFirstChild("UIStroke").UIGradient.Color = ColorSequence.new(ItemData.Rarities[v5.Rarity or 1].Color);
        end;

        v8.Prices.PremiumCurrency.Text = `{u9:GetAttribute("UPoints")} <s>u</s>P`;
        v8.Visible = true;
        v8:SetAttribute("Tab", u2.Tab);
        v8.Parent = u2.ItemsFrame;
        v8.LayoutOrder = -u9:GetAttribute("UPoints");
        v8.MouseButton1Click:Connect(function() -- Line: 78
            -- upvalues: u1 (ref), u6 (copy), u9 (copy), u3 (ref)
            u1:PlaySound("Click");
            u1.NewPrompt({
                Title = "Purchase Premium Skin",
                Delay = 0.75,
                Text = `Are you sure you want to purchase {u6}?`,
                Options = { "Yes", "No" },

                Callback = function(p12) -- Line: 88, Name: Callback
                    -- upvalues: u9 (ref), u3 (ref)
                    if p12.Choice ~= 1 then
                        return;
                    end;

                    u3:BuyPremiumSkin("SKIN_" .. u9:GetAttribute("Ability") .. "_" .. u9:GetAttribute("SkinId")):expect();
                end
            });
        end);
    end;

    for _, child in PremiumSkins:GetChildren() do
        CreateButton(child);
    end;

    PremiumSkins.ChildAdded:Connect(function(u13) -- Line: 103
        -- upvalues: CreateButton (copy)
        task.delay(0.03333333333333333, function() -- Line: 104
            -- upvalues: CreateButton (ref), u13 (copy)
            CreateButton(u13);
        end);
    end);
    PremiumSkins.ChildRemoved:Connect(function(u14) -- Line: 109
        -- upvalues: u2 (copy)
        task.delay(0.03333333333333333, function() -- Line: 110
            -- upvalues: u2 (ref), u14 (copy)
            local v15 = u2.ItemsFrame:FindFirstChild((`{u14.Name}_{u2.Tab}`));

            if v15 then
                v15:Destroy();
            end;
        end);
    end);
end;