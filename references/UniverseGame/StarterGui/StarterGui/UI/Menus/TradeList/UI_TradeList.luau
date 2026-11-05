  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local List = Parent.List;
    local TextBox = Parent:WaitForChild("Buttons"):WaitForChild("Search"):WaitForChild("TextBox");
    local LocalPlayer = game.Players.LocalPlayer;
    require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local u2 = u1.Knit.GetService("TradeService");

    function u1.SetTradeList(p3) -- Line: 10
        -- upvalues: Parent (copy)
        Parent.Visible = p3;
    end;

    local u4 = {};

    local function Search() -- Line: 16
        -- upvalues: TextBox (copy), u4 (copy)
        local Text = TextBox.Text;

        if Text == nil or Text == "" then
            for _, v in u4 do
                v.Visible = true;
            end;

            return;
        end;

        local v5 = Text:lower();

        for i, v in u4 do
            if i.Name:lower():find(v5) or i.DisplayName:lower():find(v5) then
                v.Visible = true;
            else
                v.Visible = false;
            end;
        end;
    end;

    local function CreateContainer(u6) -- Line: 34
        -- upvalues: Assets (copy), u4 (copy), u2 (copy), List (copy)
        local v7 = Assets.Frame:Clone();
        u4[u6] = v7;
        v7.Username.Text = "@" .. u6.Name;
        v7.DisplayName.Text = u6.DisplayName;
        v7.Trade.MouseButton1Click:Connect(function() -- Line: 40
            -- upvalues: u2 (ref), u6 (copy)
            u2.NotifyTrade:Fire(u6);
        end);
        v7.Parent = List;
    end;

    game.Players.PlayerAdded:Connect(function(p8) -- Line: 47
        -- upvalues: CreateContainer (copy), Search (copy)
        CreateContainer(p8);
        Search();
    end);
    game.Players.PlayerRemoving:Connect(function(p9) -- Line: 52
        -- upvalues: u4 (copy), Search (copy)
        if u4[p9] then
            u4[p9]:Destroy();
            u4[p9] = nil;
        end;

        Search();
    end);
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 60
        -- upvalues: Search (copy)
        Search();
    end);

    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer then
            CreateContainer(v);
        end;
    end;

    Search();
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 71
        -- upvalues: u1 (copy), Parent (copy)
        if u1.CanTradePaidItems then
            Parent.Warning.Visible = false;
        else
            Parent.Warning.Visible = true;

            if u1.PolicyError then
                Parent.Warning.Text = "An error has occurred with Roblox services. You will not be able to trade paid items.";
            end;
        end;
    end);
end;