  

 

local Players = game:GetService("Players");

return function(u1, u2) -- Line: 3
    -- upvalues: Players (copy)
    local _ = Players.LocalPlayer;
    local Knit = u1.Knit;
    Knit.OnStart():await();
    local Button = u2.Assets.Button;
    local Mounts = game:GetService("ReplicatedStorage")["Client Assets"].Mounts;
    local u3 = Knit.GetService("MountService");
    local Mounts2 = require(u1.PathShortcuts.ReplicatedModules.Mounts);
    local ItemData = require(u1.PathShortcuts.ReplicatedModules.ItemData);

    local function CreateButton(p4, p5) -- Line: 16
        -- upvalues: ItemData (copy), u2 (copy), Mounts (copy), Button (copy), u1 (copy), u3 (copy)
        local ItemId = p5.ItemId;

        if not ItemId then
            return;
        end;

        local u6 = ItemData.GetItemInfo(ItemId);

        if not u6.UPoints or u6.Available == false then
            return;
        end;

        local u7 = u6.Name or p4;

        if u2.ItemsFrame:FindFirstChild((`{u7}_{u2.Tab}`)) then
            return;
        end;

        if not (p5.DisplayModel or (p5.Model or Mounts:FindFirstChild(p4))) then
            return;
        end;

        local v8 = Button:Clone();
        local Camera = Instance.new("Camera");
        Camera.Parent = v8.ViewportFrame;
        v8.ViewportFrame.CurrentCamera = Camera;
        local v9 = (p5.DisplayModel or (p5.Model or Mounts[p4 or "Bike"])):Clone();
        v9.Parent = v8.ViewportFrame;
        local identity = CFrame.identity;
        v9:PivotTo(identity);
        Camera.CFrame = CFrame.lookAt(identity.LookVector * 5 + Vector3.new(5, 5, 0), identity.Position);
        v8.Name = `{u7}_{u2.Tab}`;
        v8.ItemName.Text = u7;
        v8.Prices.PremiumCurrency.Text = `{u6.UPoints} <s>u</s>P`;
        v8.Visible = true;
        v8:SetAttribute("Tab", u2.Tab);
        v8.Parent = u2.ItemsFrame;

        if v8:FindFirstChild("UIStroke") then
            v8.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u6.Rarity or 1].Color);
            v8.ItemName.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u6.Rarity or 1].Color);
            v8:FindFirstChild("UIStroke").UIGradient.Color = ColorSequence.new(ItemData.Rarities[u6.Rarity or 1].Color);
        end;

        if ItemId == "MOUNT_37" then
            local v10 = u2.Assets.RainbowGradient:Clone();
            v10.Parent = v8.ViewportFrame;
            v10.Enabled = true;
        end;

        v8.LayoutOrder = 1 - u6.UPoints;
        v8.MouseButton1Click:Connect(function() -- Line: 65
            -- upvalues: u1 (ref), ItemData (ref), u6 (copy), u7 (copy), u3 (ref), ItemId (copy)
            u1:PlaySound("Click");
            u1.NewPrompt({
                Title = "Purchase Mount",
                Delay = 0.75,
                RichText = true,
                Text = `Are you sure you want to purchase <font color="#{ItemData.Rarities[u6.Rarity or 1].Color:ToHex()}">{u7}</font> for <font color="#ffc053">{u6.UPoints} <s>u</s>P</font>?`,
                Options = { "Yes", "No" },

                Callback = function(p11) -- Line: 76, Name: Callback
                    -- upvalues: u3 (ref), ItemId (ref), u1 (ref), u7 (ref)
                    if p11.Choice ~= 1 then
                        return;
                    end;

                    local v12 = u3:BuyMount(ItemId):expect();

                    if v12 == "AlreadyOwned" then
                        u1.NewPrompt({
                            Title = "Purchase Failed",
                            Text = `You already own {u7}`
                        });

                        return;
                    end;

                    if v12 == "NotEnough" then
                        u1.NewPrompt({
                            Title = "Purchase Failed",
                            Text = `Not enough UPoints to purchase {u7}`
                        });
                    end;
                end
            });
        end);
    end;

    for i, v in Mounts2 do
        CreateButton(i, v);
    end;
end;