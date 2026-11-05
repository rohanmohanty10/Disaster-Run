  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local Query = Parent.Query;
    local Close = Parent.Close;
    local CurrencyList = Parent.CurrencyList;
    local UserId = Parent.UserId;
    local Date = Parent.Date;
    local Currency = Parent.Assets.Currency;
    local _ = game.Players.LocalPlayer;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.ReplicatedModules.Stands);
    local u2 = u1.Knit.GetService("PlayerDataService");
    game:GetService("UserService");

    local function ClearList() -- Line: 21
        -- upvalues: CurrencyList (copy)
        for _, child in CurrencyList:GetChildren() do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;
    end;

    function u1.ViewCurrencyHistory(p3, p4, p5) -- Line: 29
        -- upvalues: Parent (copy)
        p3:SetMenu("CurrencyHistoryViewer", {
            Overlap = true
        });
        Parent.Visible = true;
    end;

    Query.MouseButton1Click:Connect(function() -- Line: 36
        -- upvalues: UserId (copy), Date (copy), u1 (copy), u2 (copy), ClearList (copy), Currency (copy), CurrencyList (copy)
        local v6 = tonumber(UserId.Text);
        local v7 = tonumber(Date.Month.Text);
        local v8 = tonumber(Date.Day.Text);
        local v9 = tonumber(Date.Year.Text);

        if not (v6 and (v7 and (v8 and v9))) then
            u1.NewPrompt({
                Title = "Invalid Input",
                Text = "UserId or Date wrong"
            });

            return;
        end;

        if not game.Players:GetNameFromUserIdAsync(v6) then
            u1.NewPrompt({
                Title = "Invalid UserId",
                Text = "UserId doesn\'t exist on roblox"
            });

            return;
        end;

        local success, _ = pcall(DateTime.fromUniversalTime, v9, v7, v8);

        if not success then
            u1.NewPrompt({
                Title = "Invalid Date",
                Text = "Date out of range"
            });

            return;
        end;

        local v10 = u2:ViewCurrencyHistory(v6, {
            Day = v8,
            Month = v7,
            Year = v9
        }):expect();
        local Currencies = v10.Currencies;

        if not Currencies then
            u1.NewPrompt({
                Title = "Invalid Data",
                Text = "Currencies couldn\'t be found at that specified date"
            });

            return;
        end;

        ClearList();

        for i, v in Currencies do
            local v11 = Currency:Clone();
            v11.Name = i;
            v11.Text = `{i} {v}`;
            v11.Visible = true;
            v11.LayoutOrder = -v;
            v11.Parent = CurrencyList;
        end;

        local v12 = Currency:Clone();
        v12.Name = "TotalRobuxSpent";
        v12.Text = `TotalRobuxSpent {v10.TotalRobuxSpent}`;
        v12.TextColor3 = Color3.new(0, 1, 0);
        v12.Visible = true;
        v12.LayoutOrder = -v10.TotalRobuxSpent;
        v12.Parent = CurrencyList;
    end);
    Close.MouseButton1Click:Connect(function() -- Line: 100
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);
end;