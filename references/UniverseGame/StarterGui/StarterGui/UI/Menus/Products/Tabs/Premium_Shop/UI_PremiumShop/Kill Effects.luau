  

 

local Players = game:GetService("Players");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(u1, u2) -- Line: 4
    -- upvalues: Players (copy), EffectsHandler (copy)
    local _ = Players.LocalPlayer;
    local Knit = u1.Knit;
    Knit.OnStart():await();
    local u3 = Knit.GetService("KillEffectService");
    local Button = u2.Assets.Button;
    local ItemData = require(u1.PathShortcuts.ReplicatedModules.ItemData);

    local function CreateButton(u4, u5) -- Line: 16
        -- upvalues: u2 (copy), Button (copy), ItemData (copy), u1 (copy), EffectsHandler (ref), u3 (copy)
        if not u4 then
            return;
        end;

        if not u5.UPoints or u5.Available == false then
            return;
        end;

        local Name = u5.Name;

        if u2.ItemsFrame:FindFirstChild((`{Name}_{u2.Tab}`)) then
            return;
        end;

        local v6 = Button:Clone();
        v6.Name = `{Name}_{u2.Tab}`;
        v6.ItemName.Text = Name;
        v6.Prices.PremiumCurrency.Text = `{u5.UPoints} <s>u</s>P`;
        v6.Visible = true;
        v6.Image.Visible = true;
        v6:SetAttribute("Tab", u2.Tab);
        v6.Parent = u2.ItemsFrame;

        if v6:FindFirstChild("UIStroke") then
            v6.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
            v6.ItemName.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
            v6:FindFirstChild("UIStroke").UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
        end;

        if v6.Image:FindFirstChild("UIGradient") then
            v6.Image:FindFirstChild("UIGradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, ItemData.Rarities[u5.Rarity or 1].Color), ColorSequenceKeypoint.new(1, Color3.fromHex("#7dafff")) });
        end;

        v6.LayoutOrder = 1 - u5.UPoints;
        v6.MouseButton1Click:Connect(function() -- Line: 50
            -- upvalues: u1 (ref), Name (copy), ItemData (ref), u5 (copy), EffectsHandler (ref), u4 (copy), u3 (ref)
            u1:PlaySound("Click");
            u1.NewPrompt({
                Delay = 0.3,
                RichText = true,
                Title = `Kill Effect - {Name}`,
                Text = `Purchase or preview <font color="#{ItemData.Rarities[u5.Rarity or 1].Color:ToHex()}">{Name}</font>`,
                Options = { "Purchase", "Preview", "Cancel" },

                Callback = function(p7) -- Line: 62, Name: Callback
                    -- upvalues: u1 (ref), EffectsHandler (ref), u4 (ref), ItemData (ref), u5 (ref), Name (ref), u3 (ref)
                    if p7.Choice == 3 then
                        return;
                    end;

                    if p7.Choice ~= 2 then
                        u1.NewPrompt({
                            Title = "Purchase Kill Effect",
                            Delay = 0.75,
                            RichText = true,
                            Text = `Are you sure you want to purchase <font color="#{ItemData.Rarities[u5.Rarity or 1].Color:ToHex()}">{Name}</font> for <font color="#ffc053">{u5.UPoints} <s>u</s>P</font>?`,
                            Options = { "Yes", "No" },

                            Callback = function(p8) -- Line: 87, Name: Callback
                                -- upvalues: u3 (ref), u4 (ref), u1 (ref), Name (ref)
                                if p8.Choice ~= 1 then
                                    return;
                                end;

                                local v9 = u3:BuyKillEffect(u4):expect();

                                if v9 == "InventoryFull" then
                                    u1.NewPrompt({
                                        Title = "Purchase Failed",
                                        Text = "Your kill effect inventory is full."
                                    });

                                    return;
                                end;

                                if v9 == "NotEnough" then
                                    u1.NewPrompt({
                                        Title = "Purchase Failed",
                                        Text = `Not enough UPoints to purchase {Name}`
                                    });
                                end;
                            end
                        });

                        return;
                    end;

                    if u1.UI then
                        u1:ToggleMenu(false);
                        u1:Lock(true);
                        task.delay(3, function() -- Line: 68
                            -- upvalues: u1 (ref)
                            u1:Lock(false);
                            u1:ToggleMenu(true);
                        end);
                    end;

                    task.wait();
                    EffectsHandler.CallEffect("PreviewKillEffect", u4);
                end
            });
        end);
    end;

    for i, v in ItemData.GetKillEffects() do
        if v.Available then
            CreateButton(i, v);
        end;
    end;
end;