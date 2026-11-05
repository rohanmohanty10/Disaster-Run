  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local PathShortcuts = u1.PathShortcuts;
    local Player = u1.Player;
    local u2 = nil;
    local u3 = Knit.GetService("GameModeService");
    local TweenService = game:GetService("TweenService");
    require(PathShortcuts.KnitPath.Net);
    local Parent = script.Parent;
    local Holder = Parent.Holder;
    local u4 = Parent.Assets.CardBase:Clone();
    local AnimateCard = require(script.AnimateCard);
    Knit.GetService("LevelService");
    local u5 = Knit.GetService("UpgradeService");
    local u6 = {
        Common = Color3.fromRGB(225, 225, 225),
        Rare = Color3.fromRGB(75, 150, 255),
        Epic = Color3.fromRGB(175, 90, 255),
        Legendary = Color3.fromRGB(255, 150, 75),
        Mythic = Color3.fromRGB(255, 85, 0),
        Hexed = Color3.fromRGB(128, 0, 255)
    };
    local u7 = {
        Common = 1,
        Rare = 2,
        Epic = 3,
        Legendary = 4,
        Mythic = 5
    };

    local function EXPERIMENTAL_VISUAL() -- Line: 40
        -- upvalues: Player (copy)
        return Player.Settings.HideVisuals.Value;
    end;

    function u1.ShowBoundlessTowerSkipVote(p8, p9) -- Line: 44
        -- upvalues: u2 (ref), Player (copy), u3 (copy)
        if u2 then
            u2:Destroy();
            u2 = nil;
        end;

        if p9.Type == "Wave" and Player.Settings.AutoSkipWave.Value then
            u3.Signal:Fire({
                Handler = "BoundlessTower",
                Action = "BoundlessTowerSkipVote"
            });

            return;
        end;

        local Type = p9.Type;
        local _, v13 = p8:Notify((not Type or Type == "Wave") and "Skip Wave?" or (Type == "Floor" and "Skip Floor?" or nil), (not Type or Type == "Wave") and "Please vote to end the wave and spawn the next wave of enemies right now." or (Type == "Floor" and "Please vote to end the intermission and go to the next floor right now." or nil), p9.Duration, { "Yes", "No" }, function(p10, p11, p12) -- Line: 77
            -- upvalues: u3 (ref), u2 (ref)
            if p11 == 1 then
                u3.Signal:Fire({
                    Handler = "BoundlessTower",
                    Action = "BoundlessTowerSkipVote"
                });
            end;

            u2 = nil;
        end);
        u2 = v13;
    end;

    local function CreateCard(p14, p15) -- Line: 95
        -- upvalues: Holder (copy), u6 (copy), u4 (copy), u7 (copy), Player (copy), TweenService (copy), u1 (copy)
        if Holder:FindFirstChild(p14) then
            Holder:FindFirstChild(p14):Destroy();
        end;

        local v16 = u6[p15.Rarity];
        local Upgrade = p15.Upgrade;
        local u17 = u4:Clone();
        u17.Content.Title.Label.Text = Upgrade;
        local v18 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v16) });
        local v19 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v16), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
        u17.Content.UIStroke.Color = v16;
        u17.Content.UIGradient.Color = v18;
        u17.Content.Rating.UIGradient.Color = v19;
        u17.Content.ModifiersTitle.UIGradient.Color = v19;

        for _, descendant in u17:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = v16;
            end;
        end;

        u17:SetAttribute("Rarity", p15.Rarity);
        u17.Content.Rating.Text = string.rep("★", u7[p15.Rarity]);
        u17.Content.Description.Text = p15.Description;

        if p15.StatBonuses then
            u17.Content.ModifiersTitle.Visible = true;
            u17.Content.Modifiers.Visible = true;

            for i, v in p15.StatBonuses do
                local Modifiers = u17.Content.Modifiers;
                Modifiers.Text = Modifiers.Text .. `{i}: {v}<br />`;
            end;
        end;

        u17.Name = p14;
        u17.LayoutOrder = p14;
        u17.Parent = Holder;
        u17.Visible = true;

        if Player.Settings.HideVisuals.Value then
            u17.Content.Position = UDim2.fromScale(0.5, 0.5);
            u17:SetAttribute("Ready", true);
            u17:SetAttribute("Animated", true);

            if u17.Content:FindFirstChild("Cover") then
                u17.Content.Cover.Visible = false;
            end;
        else
            u17.Content.Position = UDim2.fromScale(0.5, -4);
            u17:SetAttribute("Ready", false);
            local v20 = TweenInfo.new((p14 + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local u21 = TweenService:Create(u17.Content, v20, {
                Position = UDim2.fromScale(0.5, 0.5)
            });
            u21.Completed:Connect(function() -- Line: 153
                -- upvalues: u17 (copy), u21 (copy)
                u17:SetAttribute("Ready", true);
                u21:Destroy();
            end);
            u21:Play();
        end;

        u1:AddHoverCallbacks({
            TweenSize = true,
            PlaySounds = true,
            Object = u17.Content
        });

        return u17;
    end;

    local u22 = {};
    local u23 = true;

    local function ClearCards() -- Line: 171
        -- upvalues: u23 (ref), u22 (copy), Player (copy), TweenService (copy), u1 (copy)
        u23 = true;

        for i, v in u22 do
            if Player.Settings.HideVisuals.Value then
                v:Destroy();
            else
                local v24 = TweenInfo.new((i + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                TweenService:Create(v.Content, v24, {
                    Position = UDim2.fromScale(0.5, -4)
                }):Play();
                task.delay(1, v.Destroy, v);
            end;
        end;

        if not Player.Settings.HideVisuals.Value then
            u1:PlaySound("card_dismiss");
        end;

        table.clear(u22);
    end;

    local function ShowSelectAll() -- Line: 191
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = true;
        Parent.ShowAll.Active = true;
        Parent.Discard.Visible = false;
        Parent.Discard.Active = false;
    end;

    local function ShowClose() -- Line: 199
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        Parent.Discard.Visible = true;
        Parent.Discard.Active = true;
    end;

    Parent.ShowAll.MouseButton1Click:Connect(function() -- Line: 207
        -- upvalues: u22 (copy), Player (copy), AnimateCard (copy), u1 (copy), Parent (copy), ShowClose (copy)
        for i, v in u22 do
            if Player.Settings.HideVisuals.Value then
                AnimateCard(v, u1);
            else
                task.delay(i / 10, AnimateCard, v, u1);
            end;
        end;

        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;

        if not Player.Settings.HideVisuals.Value then
            task.delay(1.5, ShowClose);

            return;
        end;

        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        Parent.Discard.Visible = true;
        Parent.Discard.Active = true;
    end);
    Parent.Discard.MouseButton1Click:Connect(function() -- Line: 226
        -- upvalues: u22 (copy), u1 (copy), Player (copy), ClearCards (copy), u5 (copy), Parent (copy)
        for _, v in u22 do
            if not v:GetAttribute("Animated") then
                return;
            end;
        end;

        u1.NewPrompt({
            Title = "Discard Upgrades",
            Text = "Are you sure you want to discard these upgrades?",
            Delay = Player.Settings.HideVisuals.Value and 0 or 0.45,
            Options = { "Yes", "No" },

            Callback = function(p25) -- Line: 238, Name: Callback
                -- upvalues: ClearCards (ref), u5 (ref), Parent (ref), Player (ref)
                if p25.Choice ~= 1 then
                    return;
                end;

                ClearCards();
                u5:DiscardUpgrades();
                Parent.Discard.Visible = false;
                Parent.Discard.Active = false;

                if not Player.Settings.HideVisuals.Value then
                    task.wait(1);
                end;

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
        Object = Parent.Parent.UpgradeHandPrompt
    });
    u5.UpgradeHand:Connect(function(u26) -- Line: 273
        -- upvalues: u23 (ref), Parent (copy), Player (copy), TweenService (copy), u1 (copy), CreateCard (copy), u5 (copy), ClearCards (copy), u22 (copy), AnimateCard (copy), ShowClose (copy), ShowSelectAll (copy)
        u23 = false;
        local UpgradeHandPrompt = Parent.Parent.UpgradeHandPrompt;
        UpgradeHandPrompt.Visible = true;

        if Player.Settings.HideVisuals.Value then
            UpgradeHandPrompt.Position = UDim2.fromScale(0.5, 0.05);
        else
            UpgradeHandPrompt.Position = UDim2.fromScale(0.5, -0.1);
            local v27 = TweenService:Create(UpgradeHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.05)
            });
            v27:Play();
            v27.Completed:Wait();
            v27:Destroy();
        end;

        local u28 = not Player.Settings.HideVisuals.Value;

        if not Player.Settings.HideVisuals.Value then
            task.spawn(function() -- Line: 293
                -- upvalues: u28 (ref), TweenService (ref), UpgradeHandPrompt (copy)
                local u29 = 0;

                while u28 do
                    u29 = u29 + 1;
                    task.spawn(function() -- Line: 298
                        -- upvalues: u29 (ref), TweenService (ref), UpgradeHandPrompt (ref)
                        if u29 % 5 == 0 then
                            task.spawn(function() -- Line: 300
                                -- upvalues: TweenService (ref), UpgradeHandPrompt (ref)
                                local v30 = TweenService:Create(UpgradeHandPrompt, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, true), {
                                    Position = UDim2.fromScale(0.5, 0.054)
                                });
                                v30:Play();
                                v30.Completed:Wait();
                                v30:Destroy();
                            end);
                        end;

                        for _, child in UpgradeHandPrompt:GetChildren() do
                            if child.Name == "Arrow" then
                                local u31 = child:Clone();
                                u31.Parent = UpgradeHandPrompt;
                                local Scale = u31.Size.X.Scale;
                                local Scale2 = u31.Size.Y.Scale;
                                local u32 = TweenService:Create(u31, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    TextTransparency = 1,
                                    Size = UDim2.fromScale(Scale * 2, Scale2 * 2)
                                });
                                u32:Play();
                                local u33 = nil;
                                u33 = u32.Completed:Connect(function() -- Line: 320
                                    -- upvalues: u32 (copy), u33 (ref), u31 (copy)
                                    u32:Destroy();
                                    u33:Disconnect();
                                    u31:Destroy();
                                end);
                            end;
                        end;
                    end);
                    task.wait(1);
                end;
            end);
        end;

        local u34 = nil;
        u34 = UpgradeHandPrompt.MouseButton1Click:Once(function() -- Line: 334
            -- upvalues: u28 (ref), u34 (ref), Player (ref), UpgradeHandPrompt (copy), Parent (ref), TweenService (ref), u1 (ref), u26 (copy), CreateCard (ref), u23 (ref), u5 (ref), ClearCards (ref), u22 (ref), AnimateCard (ref), ShowClose (ref), ShowSelectAll (ref)
            u28 = false;
            u34:Disconnect();

            if Player.Settings.HideVisuals.Value then
                UpgradeHandPrompt.Visible = false;
                Parent.Visible = true;
                Parent.TextLabel.TextTransparency = 0;
                Parent.ShowAll.Visible = false;
                Parent.ShowAll.Active = false;
                Parent.Discard.Visible = true;
                Parent.Discard.Active = true;
            else
                local v35 = TweenService:Create(UpgradeHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, -0.1)
                });
                task.delay(0.25, function() -- Line: 348
                    -- upvalues: Parent (ref)
                    Parent.Visible = true;
                end);
                v35:Play();
                v35.Completed:Wait();
                v35:Destroy();
                UpgradeHandPrompt.Visible = false;
                Parent.TextLabel.TextTransparency = 1;
                TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                u1:PlaySound("cards_appear");
            end;

            for i, v in u26 do
                local u36 = CreateCard(i, v);

                if Player.Settings.HideVisuals.Value then
                    local function OnClick() -- Line: 370
                        -- upvalues: u1 (ref), u23 (ref), v (copy), u5 (ref), i (copy), ClearCards (ref), Parent (ref)
                        if u1.UI.Prompt.Visible or u23 then
                            return;
                        end;

                        u1.NewPrompt({
                            Title = "Pick Upgrade",
                            Delay = 0,
                            Text = `Are you sure you want to pick this upgrade ({v.Upgrade})?`,
                            Options = { "Yes", "No" },

                            Callback = function(p37) -- Line: 381, Name: Callback
                                -- upvalues: u23 (ref), u5 (ref), i (ref), ClearCards (ref), Parent (ref)
                                if p37.Choice ~= 1 or u23 then
                                    return;
                                end;

                                u5:PickUpgrade(i);
                                ClearCards();
                                Parent.Discard.Visible = false;
                                Parent.Discard.Active = false;
                                Parent.TextLabel.TextTransparency = 1;
                                Parent.Visible = false;
                            end
                        });
                    end;

                    table.insert(u22, u36);
                    u36.MouseButton1Click:Connect(OnClick);
                else
                    local function v41() -- Line: 398
                        -- upvalues: u36 (copy), AnimateCard (ref), u1 (ref), u22 (ref), Parent (ref), ShowClose (ref), u23 (ref), v (copy), u5 (ref), i (copy), ClearCards (ref), TweenService (ref)
                        if u36:GetAttribute("Animated") then
                            local u38 = nil;
                            u38 = u36.MouseButton1Click:Connect(function() -- Line: 417
                                -- upvalues: u1 (ref), u23 (ref), v (ref), u5 (ref), i (ref), ClearCards (ref), Parent (ref), TweenService (ref), u38 (ref)
                                if u1.UI.Prompt.Visible then
                                    return;
                                end;

                                if u23 then
                                    return;
                                end;

                                u1.NewPrompt({
                                    Title = "Pick Upgrade",
                                    Delay = 0.45,
                                    Text = `Are you sure you want to pick this upgrade ({v.Upgrade})?`,
                                    Options = { "Yes", "No" },

                                    Callback = function(p39) -- Line: 428, Name: Callback
                                        -- upvalues: u5 (ref), i (ref), ClearCards (ref), Parent (ref), TweenService (ref), u38 (ref)
                                        if p39.Choice ~= 1 then
                                            return;
                                        end;

                                        u5:PickUpgrade(i);
                                        ClearCards();
                                        Parent.Discard.Visible = false;
                                        Parent.Discard.Active = false;
                                        TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            TextTransparency = 1
                                        }):Play();
                                        task.wait(1);
                                        Parent.Visible = false;
                                        u38:Disconnect();
                                    end
                                });
                            end);
                        else
                            AnimateCard(u36, u1);
                            local v40 = true;

                            for _, v2 in u22 do
                                if not v2:GetAttribute("Animated") then
                                    v40 = false;
                                    break;
                                end;
                            end;

                            if v40 then
                                Parent.ShowAll.Visible = false;
                                Parent.ShowAll.Active = false;
                                task.delay(1.5, ShowClose);
                            end;
                        end;
                    end;

                    table.insert(u22, u36);
                    u36.MouseButton1Click:Connect(v41);
                end;
            end;

            if not Player.Settings.HideVisuals.Value then
                task.delay(1, ShowSelectAll);
            end;
        end);
    end);
    u3.Signal:Connect(function(p42) -- Line: 462
        -- upvalues: u1 (copy), u2 (ref)
        local Action = p42.Action;

        if p42.Handler ~= "BoundlessTower" then
            return;
        end;

        if Action == "ShowBoundlessTowerSkipVote" then
            u1:ShowBoundlessTowerSkipVote(p42);

            return;
        end;

        if Action == "CloseBoundlessTowerSkipVote" and u2 then
            u2:Destroy();
            u2 = nil;
        end;
    end);
end;