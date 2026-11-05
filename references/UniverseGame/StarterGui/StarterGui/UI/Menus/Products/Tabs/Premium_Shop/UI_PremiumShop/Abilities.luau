  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);

return function(u1, u2) -- Line: 8
    -- upvalues: Players (copy), ItemData (copy)
    local _ = Players.LocalPlayer;
    local Knit = u1.Knit;
    Knit.OnStart():await();
    local Button = u2.Assets.Button;
    local u3 = Knit.GetService("ShopService");

    local function CreateButton(u4, u5, u6) -- Line: 18
        -- upvalues: u2 (copy), Button (copy), ItemData (ref), u1 (copy), u3 (copy)
        if not u4 then
            return;
        end;

        if not u5.UPoints then
            return;
        end;

        local Name = u5.Name;

        if u2.ItemsFrame:FindFirstChild((`{Name}_{u2.Tab}`)) then
            return;
        end;

        local v7 = Button:Clone();
        v7.Name = `{Name}_{u2.Tab}`;
        v7.ItemName.Text = Name;
        v7.Prices.PremiumCurrency.Text = `{u5.UPoints} <s>u</s>P`;
        v7.Visible = true;
        v7.Image.Visible = true;
        v7:SetAttribute("Tab", u2.Tab);
        v7.Parent = u2.ItemsFrame;

        if v7:FindFirstChild("UIStroke") then
            v7.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
            v7.ItemName.UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
            v7:FindFirstChild("UIStroke").UIGradient.Color = ColorSequence.new(ItemData.Rarities[u5.Rarity or 1].Color);
        end;

        if v7.Image:FindFirstChild("UIGradient") then
            v7.Image:FindFirstChild("UIGradient").Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, ItemData.Rarities[u5.Rarity or 1].Color), ColorSequenceKeypoint.new(1, Color3.fromHex("#7dafff")) });
        end;

        v7.LayoutOrder = 1 - u5.UPoints;
        v7.MouseButton1Click:Connect(function() -- Line: 52
            -- upvalues: u1 (ref), u6 (copy), Name (copy), ItemData (ref), u5 (copy), u3 (ref), u4 (copy)
            u1:PlaySound("Click");
            u1.NewPrompt({
                Delay = 0.3,
                RichText = true,
                Title = `{u6} - {Name}`,
                Text = `Purchase <font color="#{ItemData.Rarities[u5.Rarity or 1].Color:ToHex()}">{Name}</font>`,
                Options = { "Purchase", "Cancel" },

                Callback = function(p8) -- Line: 63, Name: Callback
                    -- upvalues: u1 (ref), u6 (ref), ItemData (ref), u5 (ref), Name (ref), u3 (ref), u4 (ref)
                    if p8.Choice == 2 then
                        return;
                    end;

                    u1.NewPrompt({
                        Delay = 0.75,
                        RichText = true,
                        Title = `Purchase {u6}`,
                        Text = `Are you sure you want to purchase <font color="#{ItemData.Rarities[u5.Rarity or 1].Color:ToHex()}">{Name}</font> for <font color="#ffc053">{u5.UPoints} <s>u</s>P</font>?`,
                        Options = { "Yes", "No" },

                        Callback = function(p9) -- Line: 75, Name: Callback
                            -- upvalues: u3 (ref), u4 (ref)
                            if p9.Choice ~= 1 then
                                return;
                            end;

                            u3:BuyPremiumAbility(u4):expect();
                        end
                    });
                end
            });
        end);
    end;

    for i, v in ItemData.GetAbilities() do
        if v.UPoints then
            CreateButton(i, v, "Ability");
        end;
    end;

    for i, v in ItemData.GetItems("SubPowers") do
        if v.UPoints then
            CreateButton(i, v, "SubPower");
        end;
    end;
end;