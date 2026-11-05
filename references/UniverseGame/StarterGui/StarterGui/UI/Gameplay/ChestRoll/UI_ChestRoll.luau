  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local ItemData = require(u1.PathShortcuts.ReplicatedModules.ItemData);
    local Parent = script.Parent;
    local Holder = Parent.Holder;
    local u2 = Parent.Assets.CardBase:Clone();
    local AnimateCard = require(script.AnimateCard);
    local Player = u1.Player;
    local TweenService = game:GetService("TweenService");
    local v3 = Knit.GetService("ChestService");
    local u4 = Knit.GetService("EmoteService");
    local v5 = Knit.GetService("ShopService");
    local CommunityPack1Contributors = require(script:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("CommunityPack1Contributors", true));
    local u6 = (table.find(CommunityPack1Contributors, Player.UserId) or (game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, 948648926) or v5:OwnsGamepass(Player.UserId, 948648926):expect())) and true or false;

    local function EXPERIMENTAL_VISUAL() -- Line: 26
        -- upvalues: Player (copy)
        return Player.Settings.HideVisuals.Value;
    end;

    local u7 = {
        Common = 1,
        Uncommon = 2,
        Rare = 3,
        Epic = 4,
        Legendary = 5,
        Mythic = 6,
        Event = 7,
        Universal = 7,
        Limited = 7,
        Unobtainable = 8,
        Developer = 10
    };
    local u8 = { "Mythic", "Event", "Universal", "Limited", "Unobtainable", "Developer" };
    local u9 = {
        [25] = Color3.fromRGB(255, 90, 90),
        [50] = Color3.fromRGB(255, 194, 12),
        [75] = Color3.fromRGB(88, 255, 144),
        [100] = Color3.fromRGB(255, 51, 218)
    };
    Random.new();
    local u10 = {
        Skin = function() -- Line: 63, Name: Skin
            return "Skin";
        end,

        Ability = function() -- Line: 66, Name: Ability
            return "Ability";
        end,

        Item = function() -- Line: 69, Name: Item
            return "Item";
        end,

        Mount = function() -- Line: 72, Name: Mount
            return "Mount";
        end,

        KillEffect = function() -- Line: 75, Name: KillEffect
            return "Kill Effect";
        end
    };

    local function CreateCard(p11, p12) -- Line: 80
        -- upvalues: Holder (copy), ItemData (copy), u2 (copy), u7 (copy), u10 (copy), u9 (copy), u1 (copy), TweenService (copy)
        if Holder:FindFirstChild(p11) then
            Holder:FindFirstChild(p11):Destroy();
        end;

        local v13 = ItemData.GetItemInfo(p12.ItemId);
        local v14 = ItemData.GetRarityData(v13.Rarity);
        local Color = v14.Color;
        local Name = v13.Name;
        local u15 = u2:Clone();
        u15.Content.Title.Label.Text = Name;
        local v16 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, Color) });
        local v17 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
        u15.Content.UIStroke.Color = Color;
        u15.Content.UIGradient.Color = v16;
        u15.Content.Rating.UIGradient.Color = v17;
        u15.Content.ModifiersTitle.UIGradient.Color = v17;

        for _, descendant in u15:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = Color;
            end;
        end;

        u15:SetAttribute("Rarity", v14.Name);
        u15.Content.Rating.Text = string.rep("★", u7[v14.Name]);
        local v18 = string.split(v13.Description, " ");
        local v19 = "";
        local v20;

        if v18 and #v18 > 17 then
            for i = 1, 17 do
                v19 = v19 .. `{v18[i]} `;
            end;

            v20 = v19 .. "[...]";
        else
            v20 = v13.Description;
        end;

        u15.Content.Description.Text = v20;

        if string.find(v13.Description, "<b>") then
            u15.Content.Description.RichText = true;
        end;

        if p12.ShardAmount and p12.Ability then
            u15.Content.Title.Label.Text = `x{p12.ShardAmount} {p12.Ability} Shards`;
            u15.Content.Description.Text = `Can be used to craft {p12.Ability}`;
        end;

        local v21 = u10[v13.Type] and u10[v13.Type]();

        if v21 then
            local Description = u15.Content.Description;
            Description.Text = Description.Text .. `\n[{v14.Name} {v21}]`;
        end;

        if p12.Purity and p12.Purity > 0 then
            local Purity = p12.Purity;
            local v22 = u9[100];
            local BlackMarketBasePrice = v13.BlackMarketBasePrice;
            local BlackMarketMaxPrice = v13.BlackMarketMaxPrice;
            local v23;

            if BlackMarketBasePrice and BlackMarketMaxPrice then
                local v24 = BlackMarketMaxPrice - BlackMarketBasePrice;
                local v25 = u1:AbbreviateNumber(v24 * (Purity / 100));
                v23 = `<font size="28"><font color="rgb(90,255,90)">+ Market Price: {u1:AbbreviateNumber(BlackMarketBasePrice + v24 * (Purity / 100))} {u1.CurrencyString}</font><font color="#{v22:ToHex()}"> [+{v25}!]</font></font>`;
            else
                v23 = "";
            end;

            u15.Content.Description.RichText = true;
            local Description = u15.Content.Description;
            Description.Text = Description.Text .. `\n<font color="#{v22:ToHex()}">Purity: {p12.Purity}%</font> \n{v23}`;
        end;

        u15.Name = p11;
        u15.LayoutOrder = p11;
        u15.Parent = Holder;
        u15.Visible = true;
        u15.Content.Position = UDim2.fromScale(0.5, -4);
        u15:SetAttribute("Ready", false);
        local v26 = TweenInfo.new((p11 + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local u27 = TweenService:Create(u15.Content, v26, {
            Position = UDim2.fromScale(0.5, 0.5)
        });
        u27.Completed:Connect(function() -- Line: 183
            -- upvalues: u15 (copy), u27 (copy)
            u15:SetAttribute("Ready", true);
            u27:Destroy();
        end);
        u27:Play();
        u15.MouseEnter:Connect(function() -- Line: 189
            -- upvalues: TweenService (ref), u15 (copy)
            TweenService:Create(u15.Content, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1.1, 1.1)
            }):Play();
        end);
        u15.MouseLeave:Connect(function() -- Line: 194
            -- upvalues: TweenService (ref), u15 (copy)
            TweenService:Create(u15.Content, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 1)
            }):Play();
        end);

        return u15;
    end;

    local u28 = {};

    local function ClearCards() -- Line: 205
        -- upvalues: Player (copy), u4 (copy), u28 (copy), TweenService (copy), u1 (copy)
        if Player:GetAttribute("_PlayedSpecialist") then
            Player:SetAttribute("_PlayedSpecialist", false);
            u4:Cancel(Player);
        end;

        for i, v in u28 do
            local v29 = TweenInfo.new((i + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            TweenService:Create(v.Content, v29, {
                Position = UDim2.fromScale(0.5, -4)
            }):Play();
            task.delay(1, v.Destroy, v);
        end;

        u1:PlaySound("card_dismiss");
        table.clear(u28);
    end;

    local function ShowSelectAll() -- Line: 225
        -- upvalues: Parent (copy)
        Parent.SelectAll.Visible = true;
        Parent.SelectAll.Active = true;
        Parent.Close.Visible = false;
        Parent.Close.Active = false;
    end;

    local function ShowClose() -- Line: 233
        -- upvalues: Parent (copy)
        Parent.SelectAll.Visible = false;
        Parent.SelectAll.Active = false;
        Parent.Close.Visible = true;
        Parent.Close.Active = true;
    end;

    Parent.SelectAll.MouseButton1Click:Connect(function() -- Line: 241
        -- upvalues: u28 (copy), AnimateCard (copy), u1 (copy), u8 (copy), Parent (copy), u6 (copy), Player (copy), u4 (copy), ShowClose (copy)
        local v30 = false;

        for i, v in u28 do
            task.delay(i / 10, AnimateCard, v, u1);

            if not v30 then
                if table.find(u8, v:GetAttribute("Rarity")) then
                    v30 = true;
                else
                    v30 = false;
                end;
            end;
        end;

        Parent.SelectAll.Visible = false;
        Parent.SelectAll.Active = false;

        if u6 and (v30 and (Player.Settings.SpecialistOnValuable.Value and not Player:GetAttribute("_PlayedSpecialist"))) then
            Player:SetAttribute("_PlayedSpecialist", true);
            task.delay(1.45, function() -- Line: 259
                -- upvalues: u4 (ref)
                u4:Play("_Specialist");
            end);
        end;

        task.delay(1.5, ShowClose);
    end);
    Parent.Close.MouseButton1Click:Connect(function() -- Line: 267
        -- upvalues: ClearCards (copy), Parent (copy), TweenService (copy)
        ClearCards();
        Parent.Close.Visible = false;
        Parent.Close.Active = false;
        TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
        task.wait(1);
        Parent.Visible = false;
        Parent.SelectAll.Visible = true;
        Parent.SelectAll.Active = true;
        Parent.Close.Visible = false;
        Parent.Close.Active = false;
    end);
    v3.ChestRolled:Connect(function(p31) -- Line: 282
        -- upvalues: Player (copy), ItemData (copy), u10 (copy), u1 (copy), Parent (copy), ClearCards (copy), CreateCard (copy), AnimateCard (copy), u28 (copy), u6 (copy), u8 (copy), u4 (copy), TweenService (copy), ShowClose (copy), ShowSelectAll (copy)
        if Player.Settings.HideVisuals.Value then
            for _, v in p31 do
                local v32 = ItemData.GetItemInfo(v.ItemId);
                local Color = ItemData.GetRarityData(v32.Rarity).Color;
                local Name = v32.Name;

                if v.ShardAmount and v.Ability then
                    Name = `x{v.ShardAmount} {v.Ability} Shards`;
                end;

                local v33 = {};
                local v34;

                if u10[v32.Type] then
                    local v35 = string.upper(u10[v32.Type]());
                    v34 = string.gsub(v35, " ", "");
                else
                    v34 = "";
                end;

                local v36 = {
                    NumericalContent = 1,
                    Verb = "Obtained",
                    DisableStacking = true,
                    NumericalSuffix = `NEW {v34}`,
                    Subject = Name,
                    SubjectColor = Color,
                    NumericalContentColor = Color,
                    VerbColor = Color3.fromRGB(255, 255, 255)
                };
                table.insert(v33, v36);

                for _, v2 in v33 do
                    task.spawn(function() -- Line: 350
                        -- upvalues: u1 (ref), v2 (copy)
                        u1:CreateMiddleNotification(v2);
                    end);
                end;

                task.wait(0.5);
            end;

            return;
        end;

        Parent.Visible = true;
        Parent.SelectAll.Visible = false;
        Parent.SelectAll.Active = false;
        Parent.Close.Visible = false;
        Parent.Close.Active = false;
        Player:SetAttribute("_PlayedSpecialist", false);
        u1:PlaySound("cards_appear");
        ClearCards();

        for i, v in p31 do
            local u37 = CreateCard(i, v);
            u37.MouseButton1Click:Connect(function() -- Line: 375
                -- upvalues: AnimateCard (ref), u37 (copy), u1 (ref), u28 (ref), u6 (ref), u8 (ref), Player (ref), u4 (ref), Parent (ref), TweenService (ref), ShowClose (ref)
                AnimateCard(u37, u1);

                for _, v2 in u28 do
                    if not v2:GetAttribute("Animated") then
                        return;
                    end;
                end;

                if u6 and (table.find(u8, u37:GetAttribute("Rarity")) and (Player.Settings.SpecialistOnValuable.Value and not Player:GetAttribute("_PlayedSpecialist"))) then
                    Player:SetAttribute("_PlayedSpecialist", true);
                    task.delay(1.45, function() -- Line: 385
                        -- upvalues: u4 (ref)
                        u4:Play("_Specialist");
                    end);
                end;

                Parent.TextLabel.TextTransparency = 1;
                TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                Parent.SelectAll.Visible = false;
                Parent.SelectAll.Active = false;
                task.delay(1.5, ShowClose);
            end);
            table.insert(u28, u37);
        end;

        task.delay(1, ShowSelectAll);
    end);
    local StarterGui = game:GetService("StarterGui");
    local Core = require(game:GetService("ReplicatedStorage").ReplicatedRoot:WaitForChild("Core"));
    Core.OnStart():await();
    local u38 = Core.GetClientService("ConfigurationService"):GetFFlags():expect();
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 414
        -- upvalues: u38 (copy), u1 (copy), Parent (copy), StarterGui (copy)
        if u38.new_backpack_enabled then
            u1:SetBackpackEnabled(not Parent.Visible);

            return;
        end;

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Parent.Visible);
    end);
end;