  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DMCShop = require(ReplicatedStorage.ReplicatedModules.DMCShop);

return function(u1) -- Line: 4
    -- upvalues: DMCShop (copy)
    local Parent = script.Parent;
    local Assets = Parent:WaitForChild("Assets");
    local Items = Parent:WaitForChild("Items");
    local LimitedCurrency = Parent:WaitForChild("Price"):WaitForChild("LimitedCurrency");
    local Knit = u1.Knit;
    Knit.OnStart():await();
    local u2 = Knit.GetService("ShopService");

    local function CreateButton(u3, p4) -- Line: 15
        -- upvalues: Assets (copy), Items (copy), u1 (copy), u2 (copy)
        local v5 = Assets.ContainerNormal:Clone();
        v5.LayoutOrder = -p4;
        v5.Visible = true;
        v5:WaitForChild("ItemName").Text = u3;
        v5:WaitForChild("Price"):WaitForChild("LimitedCurrency").Text = `{p4} Crimson Orbs`;
        v5.Parent = Items;
        v5.MouseButton1Click:Connect(function() -- Line: 25
            -- upvalues: u1 (ref), u3 (copy), u2 (ref)
            u1:PlaySound("Click");
            u1.NewPrompt({
                Delay = 0.75,
                RichText = true,
                Title = `Purchase {u3}`,
                Text = `Are you sure you want to purchase {u3}?`,
                Options = { "Yes", "No" },

                Callback = function(p6) -- Line: 36, Name: Callback
                    -- upvalues: u2 (ref), u3 (ref)
                    if p6.Choice ~= 1 then
                        return;
                    end;

                    u2:BuyDMCShop(u3):expect();
                end
            });
        end);

        return v5;
    end;

    for i, v in DMCShop do
        CreateButton(i, v.Price);
    end;

    local u7 = u1.Knit.GetService("ShopService");
    pcall(function() -- Line: 52, Name: UpdateCurrency
        -- upvalues: u7 (copy), LimitedCurrency (copy)
        LimitedCurrency.Text = `{u7:GetCurrencyType("DMC_RedOrbs"):expect()} Crimson Orbs`;
    end);
    u1.CurrencyUpdated:Connect(function(p8) -- Line: 58
        -- upvalues: u7 (copy), LimitedCurrency (copy)
        if p8 ~= "Changed" then
            return;
        end;

        LimitedCurrency.Text = `{u7:GetCurrencyType("DMC_RedOrbs"):expect()} Crimson Orbs`;
    end);
end;