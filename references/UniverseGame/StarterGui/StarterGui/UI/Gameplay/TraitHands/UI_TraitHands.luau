  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local Player = u1.Player;
    local TraitHandler = require(u1.PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    local TweenService = game:GetService("TweenService");
    local Parent = script.Parent;
    local Holder = Parent.Holder;
    local TraitDisclaimer = Parent.TraitDisclaimer;
    local u2 = Parent.Assets.CardBase:Clone();
    local AnimateCard = require(script.AnimateCard);
    local u3 = Knit.GetService("TraitService");
    local u4 = Knit.GetService("ShopService");
    local u5 = Knit.GetService("EmoteService");

    local function EXPERIMENTAL_VISUAL() -- Line: 19
        -- upvalues: Player (copy)
        return Player.Settings.HideVisuals.Value;
    end;

    local u6 = {};
    local u7 = false;
    local u8 = false;
    local u9 = false;
    local u10 = false;
    local u11 = nil;
    local CommunityPack1Contributors = require(script:FindFirstAncestorWhichIsA("ScreenGui"):FindFirstChild("CommunityPack1Contributors", true));
    local u12 = table.find(CommunityPack1Contributors, Player.UserId) or (game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, 948648926) or u4:OwnsGamepass(Player.UserId, 948648926):expect());
    local v13 = u3:GetTraitsMetadata():expect();
    local RarityColors = v13.RarityColors;
    local RarityIndices = v13.RarityIndices;
    local StatRanges = v13.StatRanges;

    local function CreateCard(p14, p15, p16) -- Line: 45
        -- upvalues: Holder (copy), RarityColors (copy), u2 (copy), RarityIndices (copy), StatRanges (copy), Player (copy), u1 (copy), TweenService (copy)
        if Holder:FindFirstChild(p14) then
            Holder:FindFirstChild(p14):Destroy();
        end;

        local v17 = p15.Hexed and RarityColors.Hexed or RarityColors[p16.Rarity];
        local v18 = p15.Hexed and `{p16.HexPrefix} {p15.Trait}` or p15.Trait;
        local u19 = u2:Clone();
        u19.Content.Title.Label.Text = v18;

        if p15.Hexed then
            u19.Content.Title.Label.TextStrokeTransparency = 0;
            u19.Content.Title.Label.TextStrokeColor3 = v17;
        end;

        local v20 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v17) });
        local v21 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v17), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
        u19.Content.UIStroke.Color = v17;
        u19.Content.UIGradient.Color = v20;
        u19.Content.Rating.UIGradient.Color = v21;
        u19.Content.ModifiersTitle.UIGradient.Color = v21;

        for _, descendant in u19:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = v17;
            end;
        end;

        u19:SetAttribute("Hexed", p15.Hexed == true);
        u19:SetAttribute("Rarity", p16.Rarity);
        u19.Content.Rating.Text = string.rep("★", RarityIndices[p16.Rarity]);
        u19.Content.Description.Text = p15.Hexed and p16.HexDescription or p16.Description;

        if p15.StatBonuses then
            local v22 = StatRanges[p15.Hexed and "Hexed" or p16.Rarity];
            u19.Content.ModifiersTitle.Visible = true;
            u19.Content.Modifiers.Visible = true;
            local v23 = 0;

            for i, v in p15.StatBonuses do
                local v24 = v22.Max <= v;
                local v25 = v <= v22.Min;
                v23 = v23 + (v24 and 1 or (v25 and -1 or 0));
                local Modifiers = u19.Content.Modifiers;
                Modifiers.Text = Modifiers.Text .. `{v25 and "<font color=\"#FF0000\">💔</font> " or (v24 and "<font color=\"#FFB000\">★</font> " or "")}{i}: {v}{v25 and " <font color=\"#FF0000\">💔</font>" or (v24 and " <font color=\"#FFB000\">★</font>" or "")}<br />`;
            end;

            u19.Content.Title.Label.RichText = true;
            u19.Content.Title.Label.Text = (v23 >= 4 and "<font color=\"#FFB000\">Perfect</font> " or (v23 <= -4 and "<font color=\"#FF0000\">Depressing</font> " or "")) .. v18;
        end;

        u19.Name = p14;
        u19.LayoutOrder = p14;
        u19.Parent = Holder;
        u19.Visible = true;

        if Player.Settings.HideVisuals.Value then
            u19.Content.Position = UDim2.fromScale(0.5, 0.5);
            u19:SetAttribute("Ready", true);
            u19:SetAttribute("Animated", true);

            if u19.Content:FindFirstChild("Cover") then
                u19.Content.Cover.Visible = false;
            end;

            if p15.Hexed then
                u1:PlaySound("card_hexedlaugh");
            end;
        else
            u19.Content.Position = UDim2.fromScale(0.5, -4);
            u19:SetAttribute("Ready", false);
            local u26 = TweenService:Create(u19.Content, TweenInfo.new((p14 + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.5)
            });
            u26.Completed:Connect(function() -- Line: 136
                -- upvalues: u19 (copy), u26 (copy)
                u19:SetAttribute("Ready", true);
                u26:Destroy();
            end);
            u26:Play();
        end;

        u1:AddHoverCallbacks({
            TweenSize = true,
            PlaySounds = true,
            Object = u19.Content
        });

        return u19;
    end;

    local function ClearCards() -- Line: 153
        -- upvalues: u8 (ref), Player (copy), u5 (copy), u11 (ref), u1 (copy), u6 (copy), TweenService (copy)
        u8 = true;

        if Player:GetAttribute("_PlayedSpecialist") then
            Player:SetAttribute("_PlayedSpecialist", false);
            u5:Cancel(Player);
        end;

        if u11 then
            u11:Destroy();
            u1:ResolveLock();
        end;

        for i, v in u6 do
            if v:FindFirstChild("Content") then
                if Player.Settings.HideVisuals.Value then
                    v:Destroy();
                else
                    TweenService:Create(v:FindFirstChild("Content"), TweenInfo.new((i + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Position = UDim2.fromScale(0.5, -4)
                    }):Play();
                    task.delay(1, v.Destroy, v);
                end;
            end;
        end;

        if not Player.Settings.HideVisuals.Value then
            u1:PlaySound("card_dismiss");
        end;

        table.clear(u6);
    end;

    local function ShowSelectAll() -- Line: 189
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = true;
        Parent.ShowAll.Active = true;
        Parent.Discard.Visible = false;
        Parent.Discard.Active = false;
    end;

    local function ShowClose() -- Line: 196
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        Parent.Discard.Visible = true;
        Parent.Discard.Active = true;
    end;

    local function UpdateDisclaimer() -- Line: 203
        -- upvalues: Player (copy), u4 (copy), RarityColors (copy), TraitDisclaimer (copy)
        local v27 = Player.Data.Ability:GetAttribute("AscensionRank");
        local v28 = u4:GetPityInfo():expect();
        local v29 = v27 >= 10 and "Mythic" or (v27 >= 5 and "Legendary" or "Epic");
        TraitDisclaimer.Text = `HIGHEST TRAIT ROLL RARITY: <font color="#{RarityColors[v29]:ToHex()}">{v29}</font>`;
        local v30 = TraitDisclaimer;
        v30.Text = v30.Text .. "\nTRAIT ROLL RARITY WILL CHANGE AS YOU INCREASE ASCENSION RANK";
        local v31 = TraitDisclaimer;
        v31.Text = v31.Text .. `\n<font color="#{Color3.new(0, 1, 0):ToHex()}">TRAIT PITY: {v28.TraitRerollPity} / {v27 >= 10 and 100 or (v27 >= 5 and 80 or 60)}</font>`;
    end;

    Parent.ShowAll.MouseButton1Click:Connect(function() -- Line: 220
        -- upvalues: u6 (copy), Player (copy), AnimateCard (copy), u1 (copy), Parent (copy), u12 (copy), u5 (copy), ShowClose (copy)
        local v32 = false;

        for i, v in u6 do
            if Player.Settings.HideVisuals.Value then
                v32 = v32 or v:GetAttribute("Rarity") == "Mythic";
            else
                task.delay(i / 10, AnimateCard, v, u1);
                v32 = v32 or v:GetAttribute("Rarity") == "Mythic";
            end;
        end;

        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;

        if u12 and (v32 and (Player.Settings.SpecialistOnValuable.Value and not Player:GetAttribute("_PlayedSpecialist"))) then
            Player:SetAttribute("_PlayedSpecialist", true);

            if Player.Settings.HideVisuals.Value then
                u5:Play("_Specialist");
            else
                task.delay(1.45, function() -- Line: 242
                    -- upvalues: u5 (ref)
                    u5:Play("_Specialist");
                end);
            end;
        end;

        if not Player.Settings.HideVisuals.Value then
            task.delay(1.5, ShowClose);

            return;
        end;

        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        Parent.Discard.Visible = true;
        Parent.Discard.Active = true;
    end);
    Parent.Discard.MouseButton1Click:Connect(function() -- Line: 255
        -- upvalues: u6 (copy), u9 (ref), u1 (copy), Player (copy), u7 (ref), u8 (ref), u3 (copy), ClearCards (copy), u10 (ref), Parent (copy)
        for _, v in u6 do
            if not v:GetAttribute("Animated") then
                return;
            end;
        end;

        if not u9 then
            return;
        end;

        u1.NewPrompt({
            Title = "Discard Traits",
            Text = "Are you sure you want to discard these traits?",
            Delay = Player.Settings.HideVisuals.Value and 0 or 0.45,
            Options = { "Yes", "No" },

            Callback = function(p33) -- Line: 270, Name: Callback
                -- upvalues: u7 (ref), u8 (ref), u9 (ref), u3 (ref), ClearCards (ref), u10 (ref), Parent (ref), Player (ref)
                if p33.Choice ~= 1 or (u7 or u8) then
                    return;
                end;

                u7 = true;
                u9 = false;
                u3:DiscardTraits();
                ClearCards();
                u10 = true;
                Parent.Discard.Visible = false;
                Parent.Discard.Active = false;

                if Player.Settings.HideVisuals.Value then
                    u10 = false;
                    Parent.Visible = false;
                    Parent.ShowAll.Visible = true;
                    Parent.ShowAll.Active = true;
                    Parent.Discard.Visible = false;
                    Parent.Discard.Active = false;

                    return;
                end;

                task.wait(1);
                u10 = false;
                Parent.Visible = false;
                Parent.ShowAll.Visible = true;
                Parent.ShowAll.Active = true;
                Parent.Discard.Visible = false;
                Parent.Discard.Active = false;
            end
        });
    end);
    u1:AddHoverCallbacks({
        TweenSize = true,
        PlaySounds = true,
        Object = Parent.ShowAll
    });
    u1:AddHoverCallbacks({
        TweenSize = true,
        PlaySounds = true,
        Object = Parent.Discard
    });
    u1:AddHoverCallbacks({
        TweenSize = true,
        PlaySounds = true,
        Object = Parent.Parent.TraitHandPrompt
    });
    u3.TraitHand:Connect(function(u34) -- Line: 314
        -- upvalues: u10 (ref), Parent (copy), u7 (ref), u8 (ref), Player (copy), u1 (copy), u11 (ref), UpdateDisclaimer (copy), TweenService (copy), u9 (ref), TraitHandler (copy), CreateCard (copy), u3 (copy), RarityIndices (copy), ClearCards (copy), u6 (copy), AnimateCard (copy), u12 (copy), u5 (copy), ShowClose (copy), ShowSelectAll (copy)
        if u10 then
            repeat
                task.wait();
            until not u10;
        end;

        u10 = true;

        if Parent.Parent.MoveHandPrompt.Visible then
            repeat
                task.wait();
            until not Parent.Parent.MoveHandPrompt.Visible;
        end;

        u7 = false;
        u8 = false;
        Player:SetAttribute("_PlayedSpecialist", false);

        if not u1.MakeLockInstance then
            repeat
                task.wait();
            until u1.MakeLockInstance;
        end;

        u11 = u1:MakeLockInstance();
        u1:SetMenu(nil);
        u1:DestroyPrompt();
        UpdateDisclaimer();
        local TraitHandPrompt = Parent.Parent.TraitHandPrompt;
        TraitHandPrompt.Visible = true;

        if Player.Settings.HideVisuals.Value then
            TraitHandPrompt.Position = UDim2.fromScale(0.5, 0.05);
        else
            TraitHandPrompt.Position = UDim2.fromScale(0.5, -0.1);
            local v35 = TweenService:Create(TraitHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.05)
            });
            v35:Play();
            v35.Completed:Wait();
            v35:Destroy();
        end;

        local u36 = not Player.Settings.HideVisuals.Value;

        if not Player.Settings.HideVisuals.Value then
            task.spawn(function() -- Line: 360
                -- upvalues: u36 (ref), TweenService (ref), TraitHandPrompt (copy)
                local u37 = 0;

                while u36 do
                    u37 = u37 + 1;
                    task.spawn(function() -- Line: 365
                        -- upvalues: u37 (ref), TweenService (ref), TraitHandPrompt (ref)
                        if u37 % 5 == 0 then
                            task.spawn(function() -- Line: 367
                                -- upvalues: TweenService (ref), TraitHandPrompt (ref)
                                local v38 = TweenService:Create(TraitHandPrompt, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, true), {
                                    Position = UDim2.fromScale(0.5, 0.054)
                                });
                                v38:Play();
                                v38.Completed:Wait();
                                v38:Destroy();
                            end);
                        end;

                        for _, child in TraitHandPrompt:GetChildren() do
                            if child.Name == "Arrow" then
                                local u39 = child:Clone();
                                u39.Parent = TraitHandPrompt;
                                local Scale = u39.Size.X.Scale;
                                local Scale2 = u39.Size.Y.Scale;
                                local u40 = TweenService:Create(u39, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    TextTransparency = 1,
                                    Size = UDim2.fromScale(Scale * 2, Scale2 * 2)
                                });
                                u40:Play();
                                local u41 = nil;
                                u41 = u40.Completed:Connect(function() -- Line: 398
                                    -- upvalues: u40 (copy), u41 (ref), u39 (copy)
                                    u40:Destroy();
                                    u41:Disconnect();
                                    u39:Destroy();
                                end);
                            end;
                        end;
                    end);
                    task.wait(1);
                end;
            end);
        end;

        local u42 = nil;
        u42 = TraitHandPrompt.MouseButton1Click:Once(function() -- Line: 412
            -- upvalues: u36 (ref), u9 (ref), u42 (ref), Player (ref), TraitHandPrompt (copy), Parent (ref), TweenService (ref), u1 (ref), u34 (copy), TraitHandler (ref), CreateCard (ref), u8 (ref), u3 (ref), RarityIndices (ref), u7 (ref), ClearCards (ref), u10 (ref), u6 (ref), AnimateCard (ref), u12 (ref), u5 (ref), ShowClose (ref), ShowSelectAll (ref)
            u36 = false;
            u9 = true;
            u42:Disconnect();

            if Player.Settings.HideVisuals.Value then
                TraitHandPrompt.Visible = false;
                Parent.Visible = true;
                Parent.TextLabel.TextTransparency = 0;
                Parent.ShowAll.Visible = false;
                Parent.ShowAll.Active = false;
                Parent.Discard.Visible = true;
                Parent.Discard.Active = true;
            else
                local v43 = TweenService:Create(TraitHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, -0.1)
                });
                task.delay(0.25, function() -- Line: 429
                    -- upvalues: Parent (ref)
                    Parent.Visible = true;
                end);
                v43:Play();
                v43.Completed:Wait();
                v43:Destroy();
                TraitHandPrompt.Visible = false;
                Parent.TextLabel.TextTransparency = 1;
                TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                u1:PlaySound("cards_appear");
            end;

            for i, v in u34 do
                local u44 = TraitHandler.GetTraitData(v.Trait);
                local u45 = CreateCard(i, v, u44);

                if Player.Settings.HideVisuals.Value then
                    local function HandleCardClick() -- Line: 454
                        -- upvalues: u1 (ref), u8 (ref), u9 (ref), u3 (ref), v (copy), u44 (copy), RarityIndices (ref), TraitHandler (ref), u7 (ref), i (copy), ClearCards (ref), Parent (ref), u10 (ref)
                        if u1.UI.Prompt.Visible or (u8 or not u9) then
                            return;
                        end;

                        local v46 = u3:GetCurrentTraitInfo():expect();
                        local v47 = v.Hexed and `{u44.HexPrefix} {v.Trait}` or v.Trait;
                        local v48 = RarityIndices[u44.Rarity] + (v.Hexed and 0.5 or 0);
                        local v49, v50;

                        if v46 then
                            v49 = RarityIndices[v46.Rarity] + (v46.Hexed and 0.5 or 0);

                            if v48 == v49 then
                                local v51 = 0;
                                local v52 = 0;

                                if v.StatBonuses then
                                    for _, v2 in v.StatBonuses do
                                        v51 = v51 + v2;
                                    end;
                                end;

                                if v46.StatBonuses then
                                    for _, v2 in v46.StatBonuses do
                                        v52 = v52 + v2;
                                    end;
                                end;

                                if v51 <= v52 then
                                    v50 = true;
                                else
                                    v50 = false;
                                end;
                            else
                                v50 = v48 <= v49;
                            end;
                        else
                            v50 = false;
                            v49 = nil;
                        end;

                        local v53, v54;

                        if v50 then
                            local v55 = TraitHandler.GetTraitData(v46.Trait);
                            local v56 = v46.Hexed and `{v55.HexPrefix} {v46.Trait}` or v46.Trait;
                            local v57 = nil;

                            if v48 < v49 then
                                v57 = "a lower rarity than";
                            elseif v48 == v49 then
                                local v58 = 0;
                                local v59 = 0;

                                if v.StatBonuses then
                                    for _, v2 in v.StatBonuses do
                                        v58 = v58 + v2;
                                    end;
                                end;

                                if v46.StatBonuses then
                                    for _, v2 in v46.StatBonuses do
                                        v59 = v59 + v2;
                                    end;
                                end;

                                if v58 < v59 then
                                    v57 = "the same rarity as but has lower stat bonuses than";
                                else
                                    v57 = "the same rarity as";
                                end;
                            end;

                            v53 = `{v47} is {v57} your current trait ({v56}, {v46.Rarity}). Are you sure you want to pick it?`;
                            v54 = "Possible Downgrade!";
                        else
                            v53 = `Are you sure you want to pick this trait ({v47})?`;
                            v54 = "Pick Trait";
                        end;

                        u1.NewPrompt({
                            Title = v54,
                            Text = v53,
                            Delay = v50 and 1.5 or 0,
                            Options = { "Yes", "No" },

                            Callback = function(p60) -- Line: 518, Name: Callback
                                -- upvalues: u8 (ref), u7 (ref), u9 (ref), u3 (ref), i (ref), ClearCards (ref), Parent (ref), u10 (ref)
                                if p60.Choice ~= 1 or u8 then
                                    return;
                                end;

                                u7 = true;
                                u9 = false;
                                u3:PickTrait(i);
                                ClearCards();
                                Parent.Discard.Visible = false;
                                Parent.Discard.Active = false;
                                Parent.TextLabel.TextTransparency = 1;
                                u10 = true;
                                u10 = false;
                                Parent.Visible = false;
                            end
                        });
                    end;

                    table.insert(u6, u45);
                    u45.MouseButton1Click:Connect(HandleCardClick);
                else
                    local u61 = false;

                    local function v79() -- Line: 542
                        -- upvalues: u9 (ref), u61 (ref), u45 (copy), AnimateCard (ref), u1 (ref), u12 (ref), Player (ref), u5 (ref), u6 (ref), Parent (ref), ShowClose (ref), u8 (ref), u3 (ref), v (copy), u44 (copy), RarityIndices (ref), TraitHandler (ref), u7 (ref), i (copy), ClearCards (ref), TweenService (ref), u10 (ref)
                        if not u9 or u61 then
                            return;
                        end;

                        u61 = true;
                        task.delay(1, function() -- Line: 546
                            -- upvalues: u61 (ref)
                            u61 = false;
                        end);

                        if u45:GetAttribute("Animated") then
                            local u62 = nil;
                            u62 = u45.MouseButton1Click:Connect(function() -- Line: 575
                                -- upvalues: u1 (ref), u8 (ref), u9 (ref), u3 (ref), v (ref), u44 (ref), RarityIndices (ref), TraitHandler (ref), u7 (ref), i (ref), ClearCards (ref), Parent (ref), TweenService (ref), u10 (ref), u62 (ref)
                                if u1.UI.Prompt.Visible or (u8 or not u9) then
                                    return;
                                end;

                                local v63 = u3:GetCurrentTraitInfo():expect();
                                local v64 = v.Hexed and `{u44.HexPrefix} {v.Trait}` or v.Trait;
                                local v65 = RarityIndices[u44.Rarity] + (v.Hexed and 0.5 or 0);
                                local v66, v67;

                                if v63 then
                                    v66 = RarityIndices[v63.Rarity] + (v63.Hexed and 0.5 or 0);

                                    if v65 == v66 then
                                        local v68 = 0;
                                        local v69 = 0;

                                        if v.StatBonuses then
                                            for _, v2 in v.StatBonuses do
                                                v68 = v68 + v2;
                                            end;
                                        end;

                                        if v63.StatBonuses then
                                            for _, v2 in v63.StatBonuses do
                                                v69 = v69 + v2;
                                            end;
                                        end;

                                        if v68 <= v69 then
                                            v67 = true;
                                        else
                                            v67 = false;
                                        end;
                                    else
                                        v67 = v65 <= v66;
                                    end;
                                else
                                    v67 = false;
                                    v66 = nil;
                                end;

                                local v70, v71;

                                if v67 then
                                    local v72 = TraitHandler.GetTraitData(v63.Trait);
                                    local v73 = v63.Hexed and `{v72.HexPrefix} {v63.Trait}` or v63.Trait;
                                    local v74 = nil;

                                    if v65 < v66 then
                                        v74 = "a lower rarity than";
                                    elseif v65 == v66 then
                                        local v75 = 0;
                                        local v76 = 0;

                                        if v.StatBonuses then
                                            for _, v2 in v.StatBonuses do
                                                v75 = v75 + v2;
                                            end;
                                        end;

                                        if v63.StatBonuses then
                                            for _, v2 in v63.StatBonuses do
                                                v76 = v76 + v2;
                                            end;
                                        end;

                                        if v75 < v76 then
                                            v74 = "the same rarity as but has lower stat bonuses than";
                                        else
                                            v74 = "the same rarity as";
                                        end;
                                    end;

                                    v70 = `{v64} is {v74} your current trait ({v73}, {v63.Rarity}). Are you sure you want to pick it?`;
                                    v71 = "Possible Downgrade!";
                                else
                                    v70 = `Are you sure you want to pick this trait ({v64})?`;
                                    v71 = "Pick Trait";
                                end;

                                u1.NewPrompt({
                                    Title = v71,
                                    Text = v70,
                                    Delay = v67 and 1.5 or 0.45,
                                    Options = { "Yes", "No" },

                                    Callback = function(p77) -- Line: 639, Name: Callback
                                        -- upvalues: u8 (ref), u7 (ref), u9 (ref), u3 (ref), i (ref), ClearCards (ref), Parent (ref), TweenService (ref), u10 (ref), u62 (ref)
                                        if p77.Choice ~= 1 or u8 then
                                            return;
                                        end;

                                        u7 = true;
                                        u9 = false;
                                        u3:PickTrait(i);
                                        ClearCards();
                                        Parent.Discard.Visible = false;
                                        Parent.Discard.Active = false;
                                        TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            TextTransparency = 1
                                        }):Play();
                                        u10 = true;
                                        task.wait(1);
                                        u10 = false;
                                        Parent.Visible = false;
                                        u62:Disconnect();
                                    end
                                });
                            end);
                        else
                            AnimateCard(u45, u1);

                            if u12 and (u45:GetAttribute("Rarity") == "Mythic" and (Player.Settings.SpecialistOnValuable.Value and not Player:GetAttribute("_PlayedSpecialist"))) then
                                Player:SetAttribute("_PlayedSpecialist", true);
                                task.delay(1.45, function() -- Line: 555
                                    -- upvalues: u5 (ref)
                                    u5:Play("_Specialist");
                                end);
                            end;

                            local v78 = true;

                            for _, v2 in u6 do
                                if not v2:GetAttribute("Animated") then
                                    v78 = false;
                                    break;
                                end;
                            end;

                            if v78 then
                                Parent.ShowAll.Visible = false;
                                Parent.ShowAll.Active = false;
                                task.delay(1.5, ShowClose);
                            end;
                        end;
                    end;

                    table.insert(u6, u45);
                    u45.MouseButton1Click:Connect(v79);
                end;
            end;

            if not Player.Settings.HideVisuals.Value then
                task.delay(1, ShowSelectAll);
            end;
        end);
    end);
    Player:WaitForChild("Data"):WaitForChild("Ability"):GetAttributeChangedSignal("AscensionRank"):Connect(UpdateDisclaimer);
end;