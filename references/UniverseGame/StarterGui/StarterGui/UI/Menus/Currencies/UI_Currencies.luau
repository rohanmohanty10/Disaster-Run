  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local Data = u1.Player:WaitForChild("Data");
    Parent.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 6
        -- upvalues: Parent (copy)
        Parent.Visible = Parent.Parent.Visible;
    end);
    local UCoins = Data:WaitForChild("UCoins");
    local ExcessUCoins = Data:WaitForChild("ExcessUCoins");
    local Currency = Data:WaitForChild("Currency");
    local ExcessUShards = Data:WaitForChild("ExcessUShards");
    local PremiumCurrency = Data:WaitForChild("PremiumCurrency");
    local EventCurrency = Data:WaitForChild("EventCurrency");
    local AdventureTokens = Data:WaitForChild("AdventureTokens");

    local function UpdateUCoins(p2, p3) -- Line: 20
        -- upvalues: Parent (copy)
        if p3 > 0 then
            Parent.Coins.Text = `{p2} (+{p3}) UCoins`;

            return;
        end;

        Parent.Coins.Text = `{p2} UCoins`;
    end;

    local function UpdateUShards(p4, p5) -- Line: 28
        -- upvalues: Parent (copy), u1 (copy)
        if p5 > 0 then
            Parent.Currency.Text = `{p4} (+{p5}) {u1.CurrencyString}`;

            return;
        end;

        Parent.Currency.Text = `{p4} {u1.CurrencyString}`;
    end;

    local Value = UCoins.Value;
    local Value2 = ExcessUCoins.Value;

    if Value2 > 0 then
        Parent.Coins.Text = `{Value} (+{Value2}) UCoins`;
    else
        Parent.Coins.Text = `{Value} UCoins`;
    end;

    UCoins.Changed:Connect(function(p6) -- Line: 37
        -- upvalues: ExcessUCoins (copy), Parent (copy)
        local Value3 = ExcessUCoins.Value;

        if Value3 > 0 then
            Parent.Coins.Text = `{p6} (+{Value3}) UCoins`;

            return;
        end;

        Parent.Coins.Text = `{p6} UCoins`;
    end);
    ExcessUCoins.Changed:Connect(function(p7) -- Line: 41
        -- upvalues: UCoins (copy), Parent (copy)
        local Value3 = UCoins.Value;

        if p7 > 0 then
            Parent.Coins.Text = `{Value3} (+{p7}) UCoins`;

            return;
        end;

        Parent.Coins.Text = `{Value3} UCoins`;
    end);
    local Value3 = Currency.Value;
    local Value4 = ExcessUShards.Value;

    if Value4 > 0 then
        Parent.Currency.Text = `{Value3} (+{Value4}) {u1.CurrencyString}`;
    else
        Parent.Currency.Text = `{Value3} {u1.CurrencyString}`;
    end;

    Currency.Changed:Connect(function(p8) -- Line: 46
        -- upvalues: ExcessUShards (copy), Parent (copy), u1 (copy)
        local Value5 = ExcessUShards.Value;

        if Value5 > 0 then
            Parent.Currency.Text = `{p8} (+{Value5}) {u1.CurrencyString}`;

            return;
        end;

        Parent.Currency.Text = `{p8} {u1.CurrencyString}`;
    end);
    ExcessUShards.Changed:Connect(function(p9) -- Line: 50
        -- upvalues: Currency (copy), Parent (copy), u1 (copy)
        local Value5 = Currency.Value;

        if p9 > 0 then
            Parent.Currency.Text = `{Value5} (+{p9}) {u1.CurrencyString}`;

            return;
        end;

        Parent.Currency.Text = `{Value5} {u1.CurrencyString}`;
    end);
    Parent.PremiumCurrency.Text = `{PremiumCurrency.Value} {u1.PremiumCurrencyString}`;
    PremiumCurrency.Changed:Connect(function(p10) -- Line: 55
        -- upvalues: Parent (copy), u1 (copy)
        Parent.PremiumCurrency.Text = `{p10} {u1.PremiumCurrencyString}`;
    end);
    Parent.EventCurrency.Text = `{EventCurrency.Value} {u1.EventCurrencyString}`;
    EventCurrency.Changed:Connect(function(p11) -- Line: 60
        -- upvalues: Parent (copy), u1 (copy)
        Parent.EventCurrency.Text = `{p11} {u1.EventCurrencyString}`;
    end);
    Parent.QuestCurrency.Text = `{AdventureTokens.Value} {u1.QuestCurrencyString}`;
    AdventureTokens.Changed:Connect(function(p12) -- Line: 65
        -- upvalues: Parent (copy), u1 (copy)
        Parent.QuestCurrency.Text = `{p12} {u1.QuestCurrencyString}`;
    end);
end;