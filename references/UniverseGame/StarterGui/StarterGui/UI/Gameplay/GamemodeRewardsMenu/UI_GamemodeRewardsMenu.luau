  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local TweenService = game:GetService("TweenService");
    local LocalPlayer = game.Players.LocalPlayer;
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local u2 = 0;
    local u3 = {
        uCoins = Color3.fromRGB(255, 225, 103),
        EXP = Color3.fromRGB(255, 225, 103),
        ["Player Exp"] = Color3.fromRGB(255, 225, 103),
        Floor = Color3.fromRGB(255, 90, 90),
        Kills = Color3.fromRGB(255, 90, 90),
        BossKills = Color3.fromRGB(255, 90, 90),
        TimeElapsed = Color3.fromRGB(120, 120, 120),
        DamageDealt = Color3.fromRGB(255, 90, 90),
        HealDealt = Color3.fromRGB(90, 255, 90),
        Deaths = Color3.fromRGB(90, 90, 90),
        CommonAbilityShard = Color3.fromRGB(225, 225, 225),
        UncommonAbilityShard = Color3.fromRGB(90, 255, 90),
        RareAbilityShard = Color3.fromRGB(75, 150, 255),
        EpicAbilityShard = Color3.fromRGB(175, 90, 255),
        LegendaryAbilityShard = Color3.fromRGB(255, 150, 75),
        MythicAbilityShard = Color3.fromRGB(255, 85, 0)
    };
    local u4 = {
        EXP = 1,
        ["Player Exp"] = 1,
        Floor = 1,
        uCoins = 5,
        TimeElapsed = 5,
        Kills = 10,
        BossKills = 11,
        DamageDealt = 15,
        HealDealt = 20,
        Deaths = 30,
        CommonAbilityShard = 6,
        UncommonAbilityShard = 7,
        RareAbilityShard = 8,
        EpicAbilityShard = 9,
        LegendaryAbilityShard = 10,
        MythicAbilityShard = 11
    };
    local u5 = {
        EXP = "+EXP",
        Floor = "FLOOR REACHED",
        uCoins = "+uCoins",
        TimeElapsed = "TOTAL TIME",
        Kills = "KILLS",
        BossKills = "BOSSES SLAIN",
        DamageDealt = "DAMAGE DEALT",
        HealDealt = "HEALING DEALT",
        Deaths = "DEATHS",
        ["Player Exp"] = "PLAYER EXP",
        CommonAbilityShard = "+ COMMON ABILITY SHARD(S)",
        UncommonAbilityShard = "+ UNCOMMON ABILITY SHARD(S)",
        RareAbilityShard = "+ RARE ABILITY SHARD(S)",
        EpicAbilityShard = "+ EPIC ABILITY SHARD(S)!",
        LegendaryAbilityShard = "+ LEGENDARY ABILITY SHARD(S)!!",
        MythicAbilityShard = "+ MYTHIC ABILITY SHARD(S)!!!"
    };

    function u1.ShowGameOver(u6, u7, p8, p9) -- Line: 68
        -- upvalues: Parent (copy), LocalPlayer (copy), TweenService (copy)
        print(u7, p8);
        Parent.Visible = true;
        Parent.BackgroundTransparency = 1;
        local u10 = p9 or {};
        local u11 = p8 or {};

        for _, child in Parent:GetChildren() do
            if (child:IsA("TextButton") or (child:IsA("Frame") or child:IsA("TextLabel"))) and child.Name ~= "Blackout" then
                child.Visible = false;
            end;
        end;

        task.delay(1, function() -- Line: 82
            -- upvalues: Parent (ref), u7 (copy), LocalPlayer (ref), u6 (copy), u10 (ref), u11 (ref)
            for _, child in Parent:GetChildren() do
                if (child:IsA("TextButton") or (child:IsA("Frame") or child:IsA("TextLabel"))) and child.Name ~= "Blackout" then
                    child.Visible = true;
                end;
            end;

            Parent.BackgroundTransparency = 0;
            local v12 = {};

            for i, _ in u7 do
                table.insert(v12, i);
            end;

            table.sort(v12, function(p13, p14) -- Line: 94
                -- upvalues: LocalPlayer (ref)
                return p13 == LocalPlayer.Name;
            end);
            print("SORTEDNAMES:", v12);

            for i, v in u7 do
                u6:MakePerformancePage(u7, v12, i, v, u10[i]);
            end;

            u6:MakeRewardsPage(u11[LocalPlayer.Name]);
            local UIPageLayout = Parent.Performance.UIPageLayout;
            UIPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function() -- Line: 105
                -- upvalues: UIPageLayout (copy), Parent (ref)
                local v15 = Parent.Scroller:FindFirstChild("Scroller" .. UIPageLayout.CurrentPage:GetAttribute("Page"));

                if v15 then
                    for _, child in Parent.Scroller:GetChildren() do
                        if child:IsA("ImageButton") then
                            child.ImageColor3 = Color3.fromRGB(173, 173, 173);
                            child.Size = UDim2.new(0, 17, 0, 17);
                        end;
                    end;

                    v15.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    v15.Size = UDim2.new(0, 25, 0, 25);
                end;
            end);
        end);
        TweenService:Create(Parent.Blackout, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
            BackgroundTransparency = 0
        }):Play();
    end;

    Parent.Back.MouseButton1Click:Connect(function() -- Line: 127
        -- upvalues: u1 (copy), PathShortcuts (copy), LocalPlayer (copy)
        u1:HideGameOverMenu();
        game:GetService("TeleportService"):Teleport(PathShortcuts.LinkedPlaces[game.GameId].GameModeLobby, LocalPlayer);
    end);

    function u1.HideGameOverMenu(p16) -- Line: 132
        -- upvalues: TweenService (copy), Parent (copy)
        TweenService:Create(Parent.Blackout, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0
        }):Play();
    end;

    function u1.UpdateGameOverClock(p17, p18) -- Line: 138
        -- upvalues: Parent (copy)
        Parent.TimeRemaining.Text = p18.TimeRemaining .. " REMAINING";
    end;

    function u1.MakePerformancePage(p19, p20, p21, p22, p23, p24) -- Line: 142
        -- upvalues: Assets (copy), u3 (copy), u4 (copy), LocalPlayer (copy), Parent (copy)
        local v25 = Assets.Performance:Clone();
        v25.Name = p22;
        v25.Visible = true;
        local v26 = { "PerformanceRating" };
        local v27 = p24 or {};

        for i, v in p23 do
            if not table.find(v26, i) then
                p19:MakeLabel(v25.Content, {
                    LabelName = i,
                    LabelNumericalValue = v,
                    LabelColor = u3[i],
                    LabelLayoutOrder = u4[i],
                    LabelShouldAppendNewRecord = table.find(v27, i)
                });
            end;
        end;

        v25.LayoutOrder = p22 == LocalPlayer.Name and 0 or 1;
        v25.Switch.Text = `< {p22} >`;
        v25.Title.Text = `Performance: <font color="rgb(255,225,103)">{p23.PerformanceRating}</font>`;
        v25.Parent = Parent.Performance;
        local v28 = Assets.ScrollDot:Clone();

        if p22 == LocalPlayer.Name then
            v28.ImageColor3 = Color3.fromRGB(255, 255, 255);
            v28.Size = UDim2.new(0, 25, 0, 25);
        else
            v28.ImageColor3 = Color3.fromRGB(173, 173, 173);
        end;

        local v29 = table.find(p21, p22);
        v28.LayoutOrder = p22;
        v28.Name = "Scroller" .. v29;
        v28.Visible = true;
        v28.Parent = Parent.Scroller;
        v25:SetAttribute("Page", v29);
    end;

    function u1.BindPerformanceSwitch(p30, u31, u32, u33) -- Line: 187
        -- upvalues: u2 (ref), Parent (copy)
        local u34 = #u32;
        u33.MouseButton1Click:Connect(function() -- Line: 190
            -- upvalues: u2 (ref), u34 (copy), u31 (copy), Parent (ref), u32 (copy), u33 (copy)
            u2 = u2 + 1;

            if u34 <= u2 then
                u2 = 1;
            end;

            for i, _ in u31 do
                Parent:FindFirstChild(i).Visible = false;
            end;

            local v35 = u32[u2];
            Parent:FindFirstChild(v35).Visible = true;
            u33.Parent.Text = `< {v35} >`;
        end);
    end;

    function u1.MakeRewardsPage(p36, p37) -- Line: 206
        -- upvalues: Parent (copy), u3 (copy), u4 (copy)
        print("REWARDS: ", p37);
        local Content = Parent.Rewards.Content;

        for _, v in p37 or {} do
            local RewardName = v.RewardName;
            p36:MakeLabel(Content, {
                LabelName = RewardName,
                LabelNumericalValue = v.RewardValue,
                LabelColor = u3[RewardName],
                LabelLayoutOrder = u4[RewardName]
            });
        end;
    end;

    function u1.MakeLabel(p38, p39, p40) -- Line: 223
        -- upvalues: u5 (copy), Assets (copy)
        local LabelName = p40.LabelName;
        local v41 = p40.LabelNumericalValue or 0;
        local v42 = p40.LabelColor or Color3.fromRGB(255, 255, 255);
        local v43 = p40.LabelShouldAppendNewRecord or false;
        local v44 = p40.LabelLayoutOrder or 1;
        local v45 = u5[LabelName] or LabelName;

        if typeof(v41) == "number" then
            v41 = math.floor(v41);
        end;

        local v46 = Assets.ContentLabel:Clone();
        v46.LayoutOrder = v44;
        v46.Name = v45;
        v46.Visible = true;
        v46.RichText = true;
        v46.Text = `<font color="#{v42:ToHex()}">{v45:upper()}:</font> {v41}{v43 and "• <font color=\"rgb(255,90,90)\">NEW RECORD!</font>" or ""}`;
        v46.Parent = p39;

        return v46;
    end;
end;