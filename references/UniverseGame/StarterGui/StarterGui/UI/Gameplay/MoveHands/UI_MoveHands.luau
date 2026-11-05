  

 

return function(u1) -- Line: 2
    local Knit = u1.Knit;
    local _ = u1.PathShortcuts;
    local TweenService = game:GetService("TweenService");
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("StatsHandler"));
    local u2 = Knit.GetService("MoveService");
    local Parent = script.Parent;
    local Holder = Parent.Holder;
    local u3 = Parent.Assets.CardBase:Clone();
    local AnimateCard = require(script.AnimateCard);
    local u4 = nil;
    local u5 = false;
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

    local function CreateCard(p8, p9) -- Line: 36
        -- upvalues: Holder (copy), u6 (copy), u3 (copy), u7 (copy), TweenService (copy), u1 (copy)
        if Holder:FindFirstChild(p8) then
            Holder:FindFirstChild(p8):Destroy();
        end;

        local v10 = u6[p9.Rarity or "Common"];
        local MoveName = p9.MoveName;
        local u11 = u3:Clone();
        u11.Content.Title.Label.Text = MoveName;
        local v12 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v10) });
        local v13 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v10), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
        u11.Content.UIStroke.Color = v10;
        u11.Content.UIGradient.Color = v12;
        u11.Content.Rating.UIGradient.Color = v13;
        u11.Content.ModifiersTitle.UIGradient.Color = v13;

        for _, descendant in u11:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = v10;
            end;
        end;

        u11:SetAttribute("Rarity", p9.Rarity or "Common");
        u11.Content.Rating.Text = string.rep("★", u7[p9.Rarity or "Common"]);
        u11.Content.Description.Text = p9.Description;
        u11.Name = p8;
        u11.LayoutOrder = p8;
        u11.Parent = Holder;
        u11.Visible = true;
        u11.Content.Position = UDim2.fromScale(0.5, -4);
        u11:SetAttribute("Ready", false);
        local v14 = TweenInfo.new((p8 + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local u15 = TweenService:Create(u11.Content, v14, {
            Position = UDim2.fromScale(0.5, 0.5)
        });
        u15.Completed:Connect(function() -- Line: 77
            -- upvalues: u11 (copy), u15 (copy)
            u11:SetAttribute("Ready", true);
            u15:Destroy();
        end);
        u1:AddHoverCallbacks({
            TweenSize = true,
            PlaySounds = true,
            Object = u11.Content
        });
        u15:Play();

        return u11;
    end;

    local u16 = {};

    local function ClearCards() -- Line: 95
        -- upvalues: u5 (ref), u4 (ref), u1 (copy), u16 (copy), TweenService (copy)
        u5 = true;

        if u4 then
            u4:Destroy();
            u1:ResolveLock();
        end;

        for i, v in u16 do
            pcall(function() -- Line: 103
                -- upvalues: i (copy), TweenService (ref), v (copy)
                local v17 = TweenInfo.new((i + 5) / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                TweenService:Create(v.Content, v17, {
                    Position = UDim2.fromScale(0.5, -4)
                }):Play();
            end);
            task.delay(1, v.Destroy, v);
        end;

        u1:PlaySound("card_dismiss");
        table.clear(u16);
    end;

    local function ShowSelectAll() -- Line: 115
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = true;
        Parent.ShowAll.Active = true;
        Parent.Discard.Visible = false;
        Parent.Discard.Active = false;
    end;

    local function ShowClose() -- Line: 123
        -- upvalues: Parent (copy)
        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        Parent.Discard.Visible = true;
        Parent.Discard.Active = true;
    end;

    Parent.ShowAll.MouseButton1Click:Connect(function() -- Line: 131
        -- upvalues: u16 (copy), AnimateCard (copy), u1 (copy), Parent (copy), ShowClose (copy)
        for i, v in u16 do
            task.delay(i / 10, AnimateCard, v, u1);
        end;

        Parent.ShowAll.Visible = false;
        Parent.ShowAll.Active = false;
        task.delay(1.5, ShowClose);
    end);
    Parent.Discard.MouseButton1Click:Connect(function() -- Line: 141
        -- upvalues: u16 (copy), u1 (copy), u5 (ref), ClearCards (copy), u2 (copy), Parent (copy)
        for _, v in u16 do
            if not v:GetAttribute("Animated") then
                return;
            end;
        end;

        u1.NewPrompt({
            Title = "Discard Moves",
            Text = "Are you sure you want to discard these moves?",
            Delay = 0.45,
            Options = { "Yes", "No" },

            Callback = function(p18) -- Line: 153, Name: Callback
                -- upvalues: u5 (ref), ClearCards (ref), u2 (ref), Parent (ref)
                if p18.Choice ~= 1 then
                    return;
                end;

                if u5 then
                    return;
                end;

                ClearCards();
                u2:DiscardMoveHand():expect();
                Parent.Discard.Visible = false;
                Parent.Discard.Active = false;
                task.wait(1);
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
        Object = Parent.Parent.MoveHandPrompt
    });
    u2.MoveHand:Connect(function(u19, u20) -- Line: 187
        -- upvalues: Parent (copy), u5 (ref), u1 (copy), u4 (ref), TweenService (copy), CreateCard (copy), AnimateCard (copy), u16 (copy), ShowClose (copy), u2 (copy), ClearCards (copy), ShowSelectAll (copy)
        if Parent.Visible or Parent.Parent.MoveHandPrompt.Visible then
            return;
        end;

        if Parent.Parent.TraitHandPrompt.Visible then
            repeat
                task.wait();
            until not Parent.Parent.TraitHandPrompt.Visible;
        end;

        u5 = false;

        if not u1.MakeLockInstance then
            repeat
                task.wait();
            until u1.MakeLockInstance;
        end;

        u4 = u1:MakeLockInstance();
        u1:SetMenu(nil);
        u1:DestroyPrompt();
        local MoveHandPrompt = Parent.Parent.MoveHandPrompt;
        MoveHandPrompt.Visible = true;
        MoveHandPrompt.Position = UDim2.fromScale(0.5, -0.1);
        local v21 = TweenService:Create(MoveHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.05)
        });
        v21:Play();
        v21.Completed:Wait();
        v21:Destroy();
        local u22 = true;
        task.spawn(function() -- Line: 220
            -- upvalues: u22 (ref), TweenService (ref), MoveHandPrompt (copy)
            local v23 = 0;

            while u22 do
                v23 = v23 + 1;

                if v23 % 5 == 0 then
                    task.spawn(function() -- Line: 226
                        -- upvalues: TweenService (ref), MoveHandPrompt (ref)
                        local v24 = TweenService:Create(MoveHandPrompt, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, true), {
                            Position = UDim2.fromScale(0.5, 0.054)
                        });
                        v24:Play();
                        v24.Completed:Wait();
                        v24:Destroy();
                    end);
                end;

                for _, child in MoveHandPrompt:GetChildren() do
                    if child.Name == "Arrow" then
                        local u25 = child:Clone();
                        u25.Parent = MoveHandPrompt;
                        local Scale = u25.Size.X.Scale;
                        local Scale2 = u25.Size.Y.Scale;
                        local u26 = TweenService:Create(u25, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            TextTransparency = 1,
                            Size = UDim2.fromScale(Scale * 2, Scale2 * 2)
                        });
                        u26:Play();
                        local u27 = nil;
                        u27 = u26.Completed:Connect(function() -- Line: 246
                            -- upvalues: u26 (copy), u27 (ref), u25 (copy)
                            u26:Destroy();
                            u27:Disconnect();
                            u25:Destroy();
                        end);
                    end;
                end;

                task.wait(1);
            end;
        end);
        local u28 = nil;
        u28 = MoveHandPrompt.MouseButton1Click:Once(function() -- Line: 257
            -- upvalues: u22 (ref), u28 (ref), TweenService (ref), MoveHandPrompt (copy), Parent (ref), u1 (ref), u19 (copy), CreateCard (ref), AnimateCard (ref), u16 (ref), ShowClose (ref), u5 (ref), u2 (ref), u20 (copy), ClearCards (ref), ShowSelectAll (ref)
            u22 = false;
            u28:Disconnect();
            local v29 = TweenService:Create(MoveHandPrompt, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, -0.1)
            });
            v29:Play();
            v29.Completed:Wait();
            v29:Destroy();
            MoveHandPrompt.Visible = false;
            Parent.Visible = true;
            Parent.TextLabel.TextTransparency = 1;
            TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play();
            u1:PlaySound("cards_appear");

            for i, v in u19 do
                local u30 = CreateCard(i, v);

                local function OnClick() -- Line: 281
                    -- upvalues: u30 (copy), AnimateCard (ref), u1 (ref), u16 (ref), Parent (ref), ShowClose (ref), u5 (ref), v (copy), u2 (ref), u20 (ref), ClearCards (ref), TweenService (ref)
                    if u30:GetAttribute("Animated") then
                        local u31 = nil;
                        u31 = u30.MouseButton1Click:Connect(function() -- Line: 294
                            -- upvalues: u1 (ref), u5 (ref), v (ref), u2 (ref), u20 (ref), ClearCards (ref), Parent (ref), TweenService (ref), u31 (ref)
                            if u1.UI.Prompt.Visible then
                                return;
                            end;

                            if u5 then
                                return;
                            end;

                            u1.NewPrompt({
                                Title = "Pick Move",
                                Delay = 0.45,
                                Text = `Are you sure you want to pick this move ({v.MoveName})?`,
                                Options = { "Yes", "No" },

                                Callback = function(p32) -- Line: 305, Name: Callback
                                    -- upvalues: u5 (ref), u2 (ref), v (ref), u20 (ref), ClearCards (ref), Parent (ref), TweenService (ref), u31 (ref)
                                    if p32.Choice ~= 1 then
                                        return;
                                    end;

                                    if u5 then
                                        return;
                                    end;

                                    u2:UnlockMove(v.MoveName, true, u20);
                                    ClearCards();
                                    Parent.Discard.Visible = false;
                                    Parent.Discard.Active = false;
                                    TweenService:Create(Parent.TextLabel, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        TextTransparency = 1
                                    }):Play();
                                    task.wait(1);
                                    Parent.Visible = false;
                                    u31:Disconnect();
                                end
                            });
                        end);

                        return;
                    end;

                    AnimateCard(u30, u1);

                    for _, v2 in u16 do
                        if not v2:GetAttribute("Animated") then
                            return;
                        end;
                    end;

                    Parent.ShowAll.Visible = false;
                    Parent.ShowAll.Active = false;
                    task.delay(1.5, ShowClose);
                end;

                table.insert(u16, u30);
                u30.MouseButton1Click:Connect(OnClick);
            end;

            task.delay(1, ShowSelectAll);
        end);
    end);
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 338
        -- upvalues: Parent (copy), u2 (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        task.wait(0.5);
        u2:HasMoveHand(u1.Player.Data.Ability.Value):expect();
    end);
end;