  

 

return function(u1) -- Line: 1
    local Xtal = u1.Xtal;
    local SoundService = game:GetService("SoundService");
    local TextService = game:GetService("TextService");
    local TweenService = game:GetService("TweenService");
    u1.CurrencyString = "<s>u</s>S";
    u1.PremiumCurrencyString = "<s>u</s>P";
    u1.EventCurrencyString = "<s>u</s>E";
    u1.QuestCurrencyString = "<s>u</s>A";
    u1.uFragmentsString = "<s>u</s>F";
    u1.UCoinsString = "UCoins";
    u1.UShardsTextColor = Color3.fromRGB(75, 170, 255);
    u1.UPointsTextColor = Color3.fromRGB(255, 200, 100);
    u1.UCoinsTextColor = Color3.fromRGB(255, 255, 0);
    u1.UEventsTextColor = Color3.fromRGB(255, 85, 255);
    u1.QuestCurrencyTextColor = Color3.fromRGB(255, 0, 4);
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.KnitPath.Promise);
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    local Skins = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Skins);
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local StatsHandler = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").StatsHandler);
    local PathShortcuts2 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Trove = require(PathShortcuts2.KnitPath.Trove);
    local Knit = require(PathShortcuts2.KnitPath.Knit);
    local PromptHandler = require(u1.UI.Prompt.PromptHandler);
    task.spawn(function() -- Line: 34
        -- upvalues: SoundService (copy), u1 (copy)
        local SoundEffect = SoundService:WaitForChild("SoundEffect");

        local function UISoundChildAdded(p2) -- Line: 38
            -- upvalues: SoundEffect (copy)
            if p2:IsA("Sound") then
                p2.SoundGroup = SoundEffect;
            end;
        end;

        for _, descendant in u1.UI.Sounds:GetDescendants() do
            if descendant:IsA("Sound") then
                descendant.SoundGroup = SoundEffect;
            end;
        end;

        u1.UI.Sounds.DescendantAdded:Connect(UISoundChildAdded);

        for _, child in SoundService:WaitForChild("DialogueSounds"):GetChildren() do
            child.SoundGroup = SoundEffect;
        end;

        SoundService.DialogueSounds.ChildAdded:Connect(UISoundChildAdded);
    end);

    function u1.PlaySound(p3, p4) -- Line: 60
        -- upvalues: SoundService (copy)
        local v5 = p3.UI.Sounds:FindFirstChild(p4);
        local v6;

        if v5 and v5:IsA("Sound") then
            v6 = v5;
        else
            local v7 = string.split(p4, "/");
            local Sounds = p3.UI.Sounds;

            for i = 1, #v7 - 1 do
                if Sounds then
                    Sounds = Sounds:FindFirstChild(v7[i]);
                end;

                if not Sounds then
                    break;
                end;
            end;

            if Sounds then
                v6 = Sounds:FindFirstChild(v7[#v7]);

                if v6 then
                    if not v6:IsA("Sound") then
                        v6 = v5;
                    end;
                else
                    v6 = v5;
                end;
            else
                v6 = v5;
            end;
        end;

        if v6 and v6:IsA("Sound") then
            SoundService:PlayLocalSound(v6);
        end;
    end;

    function u1.PlayDirectSound(p8, p9) -- Line: 86
        local v10 = p8.UI.Sounds:FindFirstChild(p9);

        if v10 and v10:IsA("Sound") then
            v10:Play();
        end;
    end;

    function u1.StopDirectSound(p11, p12) -- Line: 93
        local v13 = p11.UI.Sounds:FindFirstChild(p12);

        if v13 then
            v13:Stop();
        end;
    end;

    function u1.NotifyBlackMarketNpcSpawn(p14) -- Line: 100
        p14:PlaySound("ug_bmspawn");
        p14:Notify("DEALER ARRIVED.", "A Black Market Dealer has spawned!", 3, { "Close" }, function(p15, p16, p17) -- Line: 104
        end);
    end;

    local function floorDecimal(p18, p19) -- Line: 108
        local v20 = p18 * math.pow(10, p19);

        return math.floor(v20) / math.pow(10, p19);
    end;

    function u1.AbbreviateNumber(p21, p22) -- Line: 112
        local v23 = tonumber(p22);

        if not v23 then
            return p22;
        end;

        local v24 = { "", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD", "QAD", "QID", "SXD", "SPD", "OCD", "NOD", "VG", "UVG" };
        local v25 = math.abs(v23);
        local v26;

        if v25 == 0 then
            v26 = 1;
        else
            local v27 = math.log10(v25) / 3;
            v26 = math.floor(v27) + 1;
        end;

        if #v24 < v26 then
            return p22;
        end;

        local v28 = math.floor(v23 / 10 ^ ((v26 - 1) * 3) * 10) / 10;

        return tostring(v28):gsub("%.0$", "") .. v24[v26];
    end;

    function u1.AddHoverCallbacks(u29, u30) -- Line: 136
        -- upvalues: Trove (copy), TweenService (copy)
        local Object = u30.Object;
        local u31 = u30.TweenSize or true;
        local u32 = u30.PlaySounds or true;
        local TweenPosition = u30.TweenPosition;
        local u33 = u30.TweenSizeMultiplier or 1.1;
        local v34 = Trove.new();
        v34:AttachToInstance(Object);
        local Scale = Object.Size.X.Scale;
        local Scale2 = Object.Size.Y.Scale;
        local Scale3 = Object.Position.X.Scale;
        local Scale4 = Object.Position.Y.Scale;
        v34:Connect(Object.MouseEnter, function() -- Line: 149
            -- upvalues: u32 (copy), u29 (copy), u31 (copy), TweenService (ref), Object (copy), Scale (copy), u33 (copy), Scale2 (copy), TweenPosition (copy), u30 (copy), Scale3 (copy), Scale4 (copy)
            local v35 = math.random(1, 3);

            if u32 then
                u29:PlaySound("hover" .. v35);
            end;

            if u31 then
                local u36 = TweenService:Create(Object, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(Scale * u33, Scale2 * u33)
                });
                u36:Play();
                task.spawn(function() -- Line: 159
                    -- upvalues: u36 (copy)
                    u36.Completed:Wait();
                    u36:Destroy();
                end);
            end;

            if TweenPosition then
                local v37 = u30.PositionOffset or Vector2.new(0, 0.02);
                local u38 = TweenService:Create(Object, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(Scale3 + v37.X, Scale4 + v37.Y)
                });
                u38:Play();
                task.spawn(function() -- Line: 171
                    -- upvalues: u38 (copy)
                    u38.Completed:Wait();
                    u38:Destroy();
                end);
            end;
        end);
        v34:Connect(Object.MouseLeave, function() -- Line: 178
            -- upvalues: u31 (copy), TweenService (ref), Object (copy), Scale (copy), Scale2 (copy), TweenPosition (copy), Scale3 (copy), Scale4 (copy)
            if u31 then
                local u39 = TweenService:Create(Object, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(Scale, Scale2)
                });
                u39:Play();
                task.spawn(function() -- Line: 184
                    -- upvalues: u39 (copy)
                    u39.Completed:Wait();
                    u39:Destroy();
                end);
            end;

            if TweenPosition then
                local u40 = TweenService:Create(Object, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(Scale3, Scale4)
                });
                u40:Play();
                task.spawn(function() -- Line: 194
                    -- upvalues: u40 (copy)
                    u40.Completed:Wait();
                    u40:Destroy();
                end);
            end;
        end);

        return v34;
    end;

    function u1.IsSpecialGamemode(p41) -- Line: 204
        return workspace:FindFirstChild("1v1Mode") and true or false;
    end;

    function u1.GetGamemode(p42) -- Line: 211
        -- upvalues: PathShortcuts2 (copy)
        return table.find(PathShortcuts2.GameModePlaces, game.PlaceId) and "Competitive" or "Main";
    end;

    function u1.GetItemText(p43, p44, p45) -- Line: 218
        -- upvalues: ItemData (copy), Stands (copy)
        local v46 = ItemData.GetItemInfo(p44);

        if not v46 then
            return "";
        end;

        local v47 = ItemData.Rarities[v46.Rarity];
        local v48 = v46.Name or "";

        if v47 then
            v48 = `<font color="#{v47.Color:ToHex()}">{v48}</font>`;

            if p45 then
                v48 = v48 .. ` ({v46.Type})`;

                if v46.Type == "Skin" then
                    v48 = v48 .. ` [{Stands[tonumber(v46.LinkedAbilityId)]}]`;
                end;
            end;
        end;

        return v48;
    end;

    local u49 = {
        ok = { "Ok" },
        choose = { "No", "Yes" },
        purchase = { "Cancel", "Purchase" },
        choose_currency = { "Cancel", "Buy with uS", "Buy with uP" },
        none = {}
    };

    local function DefaultCallback() -- Line: 259
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
    end;

    function u1.Prompt(p50, p51, p52, p53, p54) -- Line: 263
        -- upvalues: u49 (copy), DefaultCallback (copy)
        if typeof(p53) == "string" then
            p53 = u49[p53:lower()];
        end;

        local v55 = p53 or u49.ok;
        local v56 = nil;

        for i, v in ipairs(v55) do
            if v:find("<font") then
                v56 = v56 or {};
                table.insert(v56, i);
            end;
        end;

        p50.NewPrompt({
            Title = p51,
            Text = p52,
            Options = v55,

            Transform = function(p57) -- Line: 283, Name: Transform
                return nil, p57.Choice, p57.Name;
            end,

            Callback = p54 or DefaultCallback,
            RichText = v56
        });
    end;

    local u58 = nil;

    function u1.NewPrompt(p59, ...) -- Line: 304
        -- upvalues: u1 (copy), u58 (ref), TextService (copy), u49 (copy), DefaultCallback (copy), PromptHandler (copy), Trove (copy)
        if p59 == u1 then
            p59 = ...;
        end;

        if u58 and not u58:IsDestroyed() then
            u58:Destroy();
        end;

        local Text = p59.Text;
        local Options = p59.Options;
        local Callback = p59.Callback;
        local Delay = p59.Delay;
        local DescriptionFrame = u1.UI.Prompt.Frame.DescriptionFrame;
        local Description = DescriptionFrame.Description;
        local UIScale = u1.UI.Prompt.Frame.UIScale;
        u1.UI.Prompt.Frame.Label.Text = p59.Title or "";
        Description.Text = Text or "";

        if p59.RichTextTitle then
            u1.UI.Prompt.Frame.Label.RichText = true;
        else
            u1.UI.Prompt.Frame.Label.RichText = false;
        end;

        local v60 = TextService:GetTextSize(Description.Text, Description.TextSize, Description.Font, DescriptionFrame.AbsoluteSize);
        DescriptionFrame.CanvasSize = UDim2.fromOffset(0, v60.Y);
        DescriptionFrame.CanvasPosition = Vector2.zero;

        if type(Options) == "string" then
            Options = u49[Options:lower()];
        end;

        local v61 = Options or u49.ok;
        local v62 = Callback or DefaultCallback;
        local u63 = PromptHandler.new(u1, Trove);
        u58 = u63;

        for i, v in ipairs(v61) do
            local v64 = {
                Index = i,
                Option = v,
                Callback = v62,
                Transform = p59.Transform
            };
            local v65;

            if type(p59.RichText) == "table" then
                v65 = table.find(p59.RichText, i);
            else
                v65 = nil;
            end;

            v64.RichText = v65;
            v64.Delay = Delay;
            u63:AddOption(v64);
        end;

        UIScale.Scale = type(p59.TextScale) ~= "number" and 1 or p59.TextScale;

        if type(p59.PromptTime) == "number" then
            task.delay(p59.PromptTime, function() -- Line: 361
                -- upvalues: u63 (copy)
                if u63:IsDestroyed() then
                    return;
                end;

                u63:Destroy();
            end);
        end;

        u1.UI.Prompt.Visible = true;
    end;

    function u1.PromptActive() -- Line: 370
        -- upvalues: u1 (copy)
        return u1.UI.Prompt.Visible;
    end;

    function u1.DestroyPrompt(p66) -- Line: 374
        -- upvalues: u58 (ref)
        if u58 then
            u58:Destroy();
        end;
    end;

    function u1.ServerNewPrompt(p67, p68) -- Line: 380
        p67.NewPrompt(p68);
    end;

    function u1.PromptItems(p69, p70) -- Line: 384
        local v71 = "";

        for _, v in ipairs(p70) do
            v71 = v71 .. p69:GetItemText(v, true) .. "\n";
        end;

        p69.NewPrompt({
            Title = "You received the following Items",
            Text = v71
        });
    end;

    function u1.toHMS(p72) -- Line: 395
        return string.format("%02i:%02i:%02i", p72 / 3600, p72 / 60 % 60, p72 % 60);
    end;

    function u1.TextPrompt(u73, p74, u75) -- Line: 400
        -- upvalues: Xtal (copy)
        local ShoutPrompt = u73.UI.ShoutPrompt;
        u73:RemovePrompt();
        u73.PromptMaid = Xtal.new("Maid");
        local Frame = ShoutPrompt.Frame;
        Frame.Label.Text = p74 or "";

        local function Bind(u76, u77, u78) -- Line: 408
            -- upvalues: u73 (copy), u75 (copy), Frame (copy)
            u73.PromptMaid:GiveTask(u76.MouseButton1Down:Connect(function() -- Line: 409
                -- upvalues: u75 (ref), u76 (copy), u77 (copy), u78 (copy), Frame (ref), u73 (ref)
                local v79 = u75 and u75(u76, u77, u78, Frame.Input.TextBox.Text, Frame, u73.PromptMaid) or nil;

                if v79 == nil or v79 == true then
                    u73.PromptMaid:Destroy();
                end;
            end));
        end;

        local Cancel = Frame.Cancel;
        local u80 = 1;
        local u81 = "Cancel";
        u73.PromptMaid:GiveTask(Cancel.MouseButton1Down:Connect(function() -- Line: 409
            -- upvalues: u75 (copy), Cancel (copy), u80 (copy), u81 (copy), Frame (copy), u73 (copy)
            local v82 = u75 and u75(Cancel, u80, u81, Frame.Input.TextBox.Text, Frame, u73.PromptMaid) or nil;

            if v82 == nil or v82 == true then
                u73.PromptMaid:Destroy();
            end;
        end));
        local Confirm = Frame.Confirm;
        local u83 = 2;
        local u84 = "Confirm";
        u73.PromptMaid:GiveTask(Confirm.MouseButton1Down:Connect(function() -- Line: 409
            -- upvalues: u75 (copy), Confirm (copy), u83 (copy), u84 (copy), Frame (copy), u73 (copy)
            local v85 = u75 and u75(Confirm, u83, u84, Frame.Input.TextBox.Text, Frame, u73.PromptMaid) or nil;

            if v85 == nil or v85 == true then
                u73.PromptMaid:Destroy();
            end;
        end));
        ShoutPrompt.Visible = true;
        u73.PromptMaid:GiveTask(function() -- Line: 421
            -- upvalues: ShoutPrompt (copy)
            ShoutPrompt.Visible = false;
        end);

        return Frame, u73.PromptMaid;
    end;

    local function DefaultNotificationCallback(p86, p87, p88, p89, p90) -- Line: 428
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
    end;

    function u1.Notify(p91, p92, p93, p94, p95, p96) -- Line: 432
        -- upvalues: Xtal (copy), u49 (copy), DefaultCallback (copy)
        local Maid = Xtal.new("Maid");
        local u97 = true;
        local v98 = tostring(p93);
        local u99 = script.Notification:Clone();
        u99.Frame.Label.Text = p92 or "";
        u99.Frame.Description.Text = v98;
        u99.Frame.Description.TextScaled = #v98 >= 100;

        if typeof(p95) == "string" then
            p95 = u49[p95:lower()];
        end;

        local v100 = p95 or u49.ok;
        local u101 = p96 or DefaultCallback;

        local function _(u102, u103, u104) -- Line: 454
            -- upvalues: Maid (copy), u101 (ref), u99 (copy)
            Maid:GiveTask(u102.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), u102 (copy), u103 (copy), u104 (copy), u99 (ref), Maid (ref)
                local v105 = u101 and u101(u102, u103, u104, u99, Maid) or nil;

                if v105 == nil or v105 == true then
                    Maid:Destroy();
                end;
            end));
        end;

        if #v100 > 0 then
            p91:PlaySound("notify_info");
        end;

        if #v100 == 1 then
            u99.Frame.TripleButton1.Visible = false;
            u99.Frame.TripleButton2.Visible = false;
            u99.Frame.TripleButton3.Visible = false;
            u99.Frame.Button1.Visible = false;
            u99.Frame.Button2.Visible = false;
            u99.Frame.SingleButton.Visible = true;
            u99.Frame.SingleButton.TextLabel.Text = v100[1];
            local SingleButton = u99.Frame.SingleButton;
            local u106 = v100[1];
            local u107 = 1;
            Maid:GiveTask(SingleButton.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), SingleButton (copy), u107 (copy), u106 (copy), u99 (copy), Maid (copy)
                local v108 = u101 and u101(SingleButton, u107, u106, u99, Maid) or nil;

                if v108 == nil or v108 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v100 == 2 then
            u99.Frame.TripleButton1.Visible = false;
            u99.Frame.TripleButton2.Visible = false;
            u99.Frame.TripleButton3.Visible = false;
            u99.Frame.Button1.Visible = true;
            u99.Frame.Button2.Visible = true;
            u99.Frame.SingleButton.Visible = false;
            u99.Frame.Button1.TextLabel.Text = v100[1];
            u99.Frame.Button2.TextLabel.Text = v100[2];
            local Button1 = u99.Frame.Button1;
            local u109 = v100[1];
            local u110 = 1;
            Maid:GiveTask(Button1.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), Button1 (copy), u110 (copy), u109 (copy), u99 (copy), Maid (copy)
                local v111 = u101 and u101(Button1, u110, u109, u99, Maid) or nil;

                if v111 == nil or v111 == true then
                    Maid:Destroy();
                end;
            end));
            local Button2 = u99.Frame.Button2;
            local u112 = v100[2];
            local u113 = 2;
            Maid:GiveTask(Button2.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), Button2 (copy), u113 (copy), u112 (copy), u99 (copy), Maid (copy)
                local v114 = u101 and u101(Button2, u113, u112, u99, Maid) or nil;

                if v114 == nil or v114 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v100 == 3 then
            u99.Frame.TripleButton1.Visible = true;
            u99.Frame.TripleButton2.Visible = true;
            u99.Frame.TripleButton3.Visible = true;
            u99.Frame.Button1.Visible = false;
            u99.Frame.Button2.Visible = false;
            u99.Frame.SingleButton.Visible = false;
            u99.Frame.TripleButton1.TextLabel.Text = v100[1];
            u99.Frame.TripleButton2.TextLabel.Text = v100[2];
            u99.Frame.TripleButton3.TextLabel.Text = v100[3];
            local TripleButton1 = u99.Frame.TripleButton1;
            local u115 = v100[1];
            local u116 = 1;
            Maid:GiveTask(TripleButton1.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), TripleButton1 (copy), u116 (copy), u115 (copy), u99 (copy), Maid (copy)
                local v117 = u101 and u101(TripleButton1, u116, u115, u99, Maid) or nil;

                if v117 == nil or v117 == true then
                    Maid:Destroy();
                end;
            end));
            local TripleButton2 = u99.Frame.TripleButton2;
            local u118 = v100[2];
            local u119 = 2;
            Maid:GiveTask(TripleButton2.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), TripleButton2 (copy), u119 (copy), u118 (copy), u99 (copy), Maid (copy)
                local v120 = u101 and u101(TripleButton2, u119, u118, u99, Maid) or nil;

                if v120 == nil or v120 == true then
                    Maid:Destroy();
                end;
            end));
            local TripleButton3 = u99.Frame.TripleButton3;
            local u121 = v100[3];
            local u122 = 3;
            Maid:GiveTask(TripleButton3.MouseButton1Down:Connect(function() -- Line: 455
                -- upvalues: u101 (ref), TripleButton3 (copy), u122 (copy), u121 (copy), u99 (copy), Maid (copy)
                local v123 = u101 and u101(TripleButton3, u122, u121, u99, Maid) or nil;

                if v123 == nil or v123 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v100 == 0 then
            u99.Frame.TripleButton1.Visible = false;
            u99.Frame.TripleButton2.Visible = false;
            u99.Frame.TripleButton3.Visible = false;
            u99.Frame.Button1.Visible = false;
            u99.Frame.Button2.Visible = false;
            u99.Frame.SingleButton.Visible = false;
            local Description = u99.Frame.Description;
            Description.Size = Description.Size + UDim2.new(0, 0, 0, -22);
        end;

        u99.Parent = p91.UI.Notifications;
        u99.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true);
        Maid:GiveTask(function() -- Line: 519
            -- upvalues: u97 (ref), u99 (copy)
            u97 = false;
            u99.Frame:TweenPosition(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.3, true, function() -- Line: 521
                -- upvalues: u99 (ref)
                u99:Destroy();
            end);
        end);

        if p94 ~= -1 then
            task.delay(p94 or 5, function() -- Line: 527
                -- upvalues: u97 (ref), Maid (copy)
                if u97 then
                    Maid:Destroy();
                end;
            end);
        end;

        return u99, Maid;
    end;

    function u1.FloatingPrompt(p124, p125, p126, p127, p128, p129, p130) -- Line: 536
        -- upvalues: Xtal (copy), u49 (copy), DefaultCallback (copy)
        local Maid = Xtal.new("Maid");
        local u131 = true;
        local u132 = script.Notification:Clone();
        u132.Frame.Label.Text = p125 or "";
        u132.Frame.Description.Text = p126 or "";

        if typeof(p128) == "string" then
            p128 = u49[p128:lower()];
        end;

        local v133 = p128 or u49.ok;
        local u134 = p130 or DefaultCallback;

        local function _(u135, u136, u137) -- Line: 554
            -- upvalues: Maid (copy), u134 (ref), u132 (copy)
            Maid:GiveTask(u135.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), u135 (copy), u136 (copy), u137 (copy), u132 (ref), Maid (ref)
                local v138 = u134 and u134(u135, u136, u137, u132, Maid) or nil;

                if v138 == nil or v138 == true then
                    Maid:Destroy();
                end;
            end));
        end;

        local v139 = {
            Top = { UDim2.new(0.5, 0, 0, 0), Vector2.new(0.5, 0) },
            Right = { UDim2.new(1, 0, 0.5, 0), Vector2.new(1, 0.5) },
            Bottom = { UDim2.new(0.5, 0, 1, 0), Vector2.new(0.5, 1) },
            Left = { UDim2.new(0, 0, 0.5, 0), Vector2.new(0, 0.5) }
        };

        if #v133 == 1 then
            u132.Frame.TripleButton1.Visible = false;
            u132.Frame.TripleButton2.Visible = false;
            u132.Frame.TripleButton3.Visible = false;
            u132.Frame.Button1.Visible = false;
            u132.Frame.Button2.Visible = false;
            u132.Frame.SingleButton.Visible = true;
            u132.Frame.SingleButton.TextLabel.Text = v133[1];
            local SingleButton = u132.Frame.SingleButton;
            local u140 = v133[1];
            local u141 = 1;
            Maid:GiveTask(SingleButton.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), SingleButton (copy), u141 (copy), u140 (copy), u132 (copy), Maid (copy)
                local v142 = u134 and u134(SingleButton, u141, u140, u132, Maid) or nil;

                if v142 == nil or v142 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v133 == 2 then
            u132.Frame.TripleButton1.Visible = false;
            u132.Frame.TripleButton2.Visible = false;
            u132.Frame.TripleButton3.Visible = false;
            u132.Frame.Button1.Visible = true;
            u132.Frame.Button2.Visible = true;
            u132.Frame.SingleButton.Visible = false;
            u132.Frame.Button1.TextLabel.Text = v133[1];
            u132.Frame.Button2.TextLabel.Text = v133[2];
            local Button1 = u132.Frame.Button1;
            local u143 = v133[1];
            local u144 = 1;
            Maid:GiveTask(Button1.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), Button1 (copy), u144 (copy), u143 (copy), u132 (copy), Maid (copy)
                local v145 = u134 and u134(Button1, u144, u143, u132, Maid) or nil;

                if v145 == nil or v145 == true then
                    Maid:Destroy();
                end;
            end));
            local Button2 = u132.Frame.Button2;
            local u146 = v133[2];
            local u147 = 2;
            Maid:GiveTask(Button2.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), Button2 (copy), u147 (copy), u146 (copy), u132 (copy), Maid (copy)
                local v148 = u134 and u134(Button2, u147, u146, u132, Maid) or nil;

                if v148 == nil or v148 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v133 == 3 then
            u132.Frame.TripleButton1.Visible = true;
            u132.Frame.TripleButton2.Visible = true;
            u132.Frame.TripleButton3.Visible = true;
            u132.Frame.Button1.Visible = false;
            u132.Frame.Button2.Visible = false;
            u132.Frame.SingleButton.Visible = false;
            u132.Frame.TripleButton1.TextLabel.Text = v133[1];
            u132.Frame.TripleButton2.TextLabel.Text = v133[2];
            u132.Frame.TripleButton3.TextLabel.Text = v133[3];
            local TripleButton1 = u132.Frame.TripleButton1;
            local u149 = v133[1];
            local u150 = 1;
            Maid:GiveTask(TripleButton1.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), TripleButton1 (copy), u150 (copy), u149 (copy), u132 (copy), Maid (copy)
                local v151 = u134 and u134(TripleButton1, u150, u149, u132, Maid) or nil;

                if v151 == nil or v151 == true then
                    Maid:Destroy();
                end;
            end));
            local TripleButton2 = u132.Frame.TripleButton2;
            local u152 = v133[2];
            local u153 = 2;
            Maid:GiveTask(TripleButton2.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), TripleButton2 (copy), u153 (copy), u152 (copy), u132 (copy), Maid (copy)
                local v154 = u134 and u134(TripleButton2, u153, u152, u132, Maid) or nil;

                if v154 == nil or v154 == true then
                    Maid:Destroy();
                end;
            end));
            local TripleButton3 = u132.Frame.TripleButton3;
            local u155 = v133[3];
            local u156 = 3;
            Maid:GiveTask(TripleButton3.MouseButton1Down:Connect(function() -- Line: 555
                -- upvalues: u134 (ref), TripleButton3 (copy), u156 (copy), u155 (copy), u132 (copy), Maid (copy)
                local v157 = u134 and u134(TripleButton3, u156, u155, u132, Maid) or nil;

                if v157 == nil or v157 == true then
                    Maid:Destroy();
                end;
            end));
        elseif #v133 == 0 then
            u132.Frame.TripleButton1.Visible = false;
            u132.Frame.TripleButton2.Visible = false;
            u132.Frame.TripleButton3.Visible = false;
            u132.Frame.Button1.Visible = false;
            u132.Frame.Button2.Visible = false;
            u132.Frame.SingleButton.Visible = false;
            local Description = u132.Frame.Description;
            Description.Size = Description.Size + UDim2.new(0, 0, 0, -22);
        end;

        local v158 = p129 or "Top";
        u132.Parent = p124.UI.FloatingPrompts;
        u132.Position = v139[v158][1];
        u132.Frame.Position = UDim2.new(0, 0, 0, 0);
        u132.AnchorPoint = v139[v158][2];
        Maid:GiveTask(function() -- Line: 626
            -- upvalues: u131 (ref), u132 (copy)
            u131 = false;
            u132:Destroy();
        end);

        if p127 ~= -1 then
            task.delay(p127 or 5, function() -- Line: 635
                -- upvalues: u131 (ref), Maid (copy)
                if u131 then
                    Maid:Destroy();
                end;
            end);
        end;

        return u132, Maid;
    end;

    function u1.RemovePrompt(p159) -- Line: 644
        p159.UI.Prompt.Visible = false;

        if p159.PromptMaid then
            p159.PromptMaid:Destroy();
        end;
    end;

    local StandCache = game.ReplicatedStorage:WaitForChild("StandCache");

    function u1.RequestModel(p160, p161, p162) -- Line: 653
        -- upvalues: Knit (copy), StandCache (copy), Skins (copy)
        local v163 = Knit.GetService("RigService");

        if not StandCache:FindFirstChild(p161) then
            v163:RequestAbilityModel(tonumber(p161), (tostring(p162))):expect();
        end;

        local v164 = StandCache:WaitForChild(p161, 1);
        local v165;

        if p162 then
            v165 = Skins.Funcs.GetSkin(p161, p162);
        else
            v165 = p162;
        end;

        if v164 and (v165 and not v164:FindFirstChild(v165)) then
            v163:RequestAbilityModel(tonumber(p161), (tostring(p162))):expect();
        end;

        if v164 then
            if v165 == nil then
                return v164:WaitForChild("Model", 1);
            end;

            return v164:WaitForChild(v165, 1);
        end;
    end;

    local u166 = {};

    function u1.ClearDisplayIcon(p167, p168) -- Line: 672
        -- upvalues: u166 (copy)
        if u166[p168] then
            u166[p168]:Destroy();
            u166[p168] = nil;
        end;
    end;

    function u1.CreateDisplayIcon(p169, u170, p171, p172) -- Line: 679
        -- upvalues: Xtal (copy), u166 (copy), Skins (copy), StatsHandler (copy), Stands (copy)
        local u173 = p172 or {};
        p169:ClearDisplayIcon(u170);
        local Maid = Xtal.new("Maid");
        u166[u170] = Maid;

        if typeof(p171) ~= "number" and typeof(p171) ~= "string" then
            if typeof(p171) == "Instance" then
                local v174 = p171:GetAttribute("Ability");
                local v175 = p171:GetAttribute("Skin") or "Default";

                if v174 and v175 then
                    local v176 = tostring(v174);
                    local WorldModel = Instance.new("WorldModel");
                    local u177 = p171:Clone();
                    local u178 = nil;
                    local v179 = nil;
                    local u180 = u173.Rotation or 0;
                    local _ = u173.Rotation or 0;
                    local v181 = Skins.Funcs.GetSkin(v174, v175);
                    local u182 = Skins.Funcs.GetViewportSettings(v176, v181) or {};
                    local v183 = u182 and u182.Offset or CFrame.new(0, 0, 0);
                    local StandHumanoidRootPart = u177:FindFirstChild("StandHumanoidRootPart", true);

                    if StandHumanoidRootPart then
                        u178 = script.Character:Clone();
                        u178:PivotTo(CFrame.new(0, 0, 0) * v183);
                        u177:PivotTo(u178.HumanoidRootPart.CFrame);
                        u177.Name = "Stand";
                        u177.Parent = u178;
                        local Weld = Instance.new("Weld");
                        Weld.Part0 = u178.HumanoidRootPart;
                        Weld.Part1 = StandHumanoidRootPart;
                        Weld.Name = "Stand2Human";
                        Weld.C0 = CFrame.new();
                        Weld.Parent = Weld.Part0;
                        v179 = u178:WaitForChild("Humanoid", 3);
                        u178.Parent = WorldModel;
                    else
                        u177:PivotTo(CFrame.new(0, 0, 0) * v183);
                        u177.Parent = WorldModel;
                    end;

                    local v184 = StatsHandler.GetStats(Stands[v174]);
                    local v185 = {};
                    local v186 = {};

                    if v184 and v184.Stats then
                        local Summon = v184.Stats.Summon;

                        if Summon then
                            v185 = Summon.IgnoreParts or (Summon.LeaveParts or {});
                            v186 = Summon.CustomTransparency or {};
                        end;
                    end;

                    if not v185 and (u182 and u182.LeaveParts) then
                        v185 = u182.LeaveParts;
                    end;

                    if not (u182 and u182.Visible) then
                        for _, descendant in pairs(u177:GetDescendants()) do
                            if not table.find(v185, descendant.Name) and (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) then
                                local v187 = 0;

                                if v186[descendant.Name] then
                                    v187 = v186[descendant.Name].SummonTransparency or v187;
                                end;

                                descendant.Transparency = v187;
                            end;
                        end;
                    end;

                    if u182.TransparencyCallback then
                        local success, result = pcall(u182.TransparencyCallback, v181, u177);

                        if not success then
                            warn(result);
                        end;
                    end;

                    WorldModel.Parent = u170;
                    local Camera = Instance.new("Camera");
                    Camera.Parent = u170;

                    local function SetCameraCF() -- Line: 788
                        -- upvalues: u178 (ref), u177 (copy), u182 (copy), Camera (copy), u180 (copy)
                        local v191 = u182 and u182.Camera or function(p188, p189, p190) -- Line: 790
                            p188.CFrame = CFrame.Angles(0, math.rad(180 + p190), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                        end;

                        if typeof(v191) ~= "function" then
                            return;
                        end;

                        v191(Camera, u178 or u177, u180);
                    end;

                    if u182 and (u182.Pose and v179) then
                        local Animation = Instance.new("Animation");
                        Animation.AnimationId = "rbxassetid://" .. tostring(u182.Pose);
                        Animation.Parent = u178;
                        local u192 = v179:LoadAnimation(Animation);
                        u192:Play(0, 1, 0);
                        task.spawn(function() -- Line: 806
                            -- upvalues: u192 (copy), Camera (copy), SetCameraCF (copy), u173 (copy), WorldModel (copy), u177 (copy)
                            repeat
                                task.wait();
                            until not u192 or u192.Length ~= 0;

                            if Camera then
                                pcall(SetCameraCF);

                                if u173.Callback then
                                    u173.Callback(WorldModel, u177, Camera, true);
                                end;
                            end;
                        end);
                    elseif Camera then
                        pcall(SetCameraCF);

                        if u173.Callback then
                            u173.Callback(WorldModel, u177, Camera, false);
                        end;
                    end;

                    u170.CurrentCamera = Camera;
                    Maid:GiveTask(WorldModel);
                    Maid:GiveTask(Camera);

                    return WorldModel, u177, Camera;
                end;
            end;

            return;
        end;

        local v193 = tostring(p171);
        local v194 = u170:FindFirstChild("Icon") or (function() -- Line: 690
            -- upvalues: u170 (copy), Maid (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "TempIcon";
            ImageLabel.Size = UDim2.new(1, 0, 1, 0);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ScaleType = Enum.ScaleType.Crop;
            ImageLabel.Parent = u170;
            Maid:GiveTask(ImageLabel);

            return ImageLabel;
        end)();

        if typeof(v193) == "string" and v193:match("rbxassetid") then
            v194.Image = v193;

            return;
        end;

        v194.Image = "rbxthumb://type=Asset&id=" .. tostring(v193) .. "&w=420&h=420";
    end;

    function u1.GenerateIcon(p195, p196, p197) -- Line: 836
        local v198 = p197.Type == "Skin" and (p197.Skin and p195:RequestModel(p197.LinkedAbilityId, p197.LinkedSkinId));

        if v198 then
            return p195:CreateDisplayIcon(p196, v198);
        end;
    end;

    function u1.CreateBarText(p199, p200, p201, u202) -- Line: 845
        local u203 = p199.FusionComponents.BarText({
            Parent = p199.UI
        });
        u203.bar.Size = UDim2.new(1, 0, 1, 0);
        u203.Visible = true;
        game:GetService("TweenService"):Create(u203, TweenInfo.new((tonumber(0.2))), {
            Transparency = 0
        }):Play();
        u203.txt.Text = p201;
        local v204 = game:GetService("TweenService"):Create(u203.bar, TweenInfo.new(tonumber(p200) + 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 0, 1, 0)
        });
        v204:Play();
        v204.Completed:Connect(function() -- Line: 856
            -- upvalues: u203 (copy), u202 (copy)
            u203.txt.Text = u202;
            task.wait(0.5);
            u203:Destroy();
        end);
    end;

    local u205 = nil;
    local Stands2 = require(PathShortcuts2.ReplicatedModules.Stands);
    local RosterInfo = require(PathShortcuts2.ReplicatedStorage.ReplicatedModules.PVEPackage.RosterInfo);

    function u1.CheckAbilityCrafts(p206) -- Line: 867
        -- upvalues: u205 (ref), Knit (copy), Stands2 (copy), ItemData (copy), RosterInfo (copy)
        if not u205 then
            u205 = Knit.GetService("CraftingService");
        end;

        local LocalPlayer = game.Players.LocalPlayer;
        local v207 = u205:GetAllAbilityShards():expect();
        local v208 = {};

        for _, child in LocalPlayer.Backpack:GetChildren() do
            local v209 = child:GetAttribute("ItemId");

            if v209 then
                if not v208[v209] then
                    v208[v209] = 0;
                end;

                v208[v209] = v208[v209] + 1;
            end;
        end;

        local v210 = {};

        for i, _ in Stands2 do
            local v211 = `ABILITY_{i}`;
            local v212 = ItemData.GetItemInfo(v211);

            if v212 and v212.Name then
                local v213 = RosterInfo.RarityCache[v212.Name];

                if v213 then
                    v210[v211] = {
                        Shards = not (v207[v211] and v207[v211].Shards) and 0 or v207[v211].Shards,
                        ShardsRequired = RosterInfo.RarityRecipes[v213],
                        Rarity = v213
                    };
                end;
            end;
        end;

        return v210;
    end;

    u1.FunctionsLoaded = true;
end;