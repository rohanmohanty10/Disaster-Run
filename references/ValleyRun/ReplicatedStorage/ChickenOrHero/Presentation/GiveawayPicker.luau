 

 

local ValleyPanels = require(script.Parent.ValleyPanels);
local ValleyTheme = require(script.Parent.ValleyTheme);
local SkinCatalog = require(script.Parent.Parent.Weapons.SkinCatalog);
local GiveawayRules = require(script.Parent.Parent.Admin.GiveawayRules);
local GiveawayView = require(script.Parent.GiveawayView);

return {
    new = function(u1, u2) -- Line: 7, Name: new
        -- upvalues: ValleyPanels (copy), ValleyTheme (copy), SkinCatalog (copy), GiveawayRules (copy), GiveawayView (copy)
        local u3 = ValleyPanels.screen(u1, "GiveawayPicker", 9900);
        u3.IgnoreGuiInset = true;
        u3.ScreenInsets = Enum.ScreenInsets.None;
        u3.ClipToDeviceSafeArea = false;
        local u4, u5, u6 = ValleyPanels.panel(u3, "Picker", 800, 580);
        ValleyTheme.surface(u5, ValleyTheme.Ink, ValleyTheme.Gold, 8, 0.4);
        ValleyPanels.text(u5, "Eyebrow", "OWNER TOOLS  /  GLOBAL GIVEAWAY", 24, 18, 690, 22, 12, ValleyTheme.Gold);
        ValleyPanels.text(u5, "Title", "Choose the prize. Let the wheel choose the player.", 24, 51, 685, 54, 24, ValleyTheme.Paper).Font = Enum.Font.GothamBold;
        local u7 = ValleyPanels.text(u5, "Help", "One winner in each running server. Existing owners skip dagger draws.", 24, 113, 752, 38, 14, ValleyTheme.Muted);
        local u8 = "Dagger";
        local u9 = SkinCatalog.Order[2] or SkinCatalog.Default;
        local u10 = false;
        local u11 = {};
        local u12 = ValleyPanels.make("ScrollingFrame", u5, "Daggers", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 5,
            Active = true,
            Position = UDim2.fromOffset(24, 207),
            Size = UDim2.fromOffset(440, 220),
            CanvasSize = UDim2.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarImageColor3 = ValleyTheme.Gold,
            ScrollingDirection = Enum.ScrollingDirection.Y
        });
        ValleyPanels.make("UIListLayout", u12, "Layout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder
        });
        local u13 = {};
        local u14 = ValleyPanels.make("ViewportFrame", u5, "Preview", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(487, 207),
            Size = UDim2.fromOffset(285, 220)
        });
        local u15 = ValleyPanels.make("TextBox", u5, "Amount", {
            Text = "1000",
            PlaceholderText = "Whole amount",
            ClearTextOnFocus = false,
            TextSize = 30,
            BorderSizePixel = 0,
            Visible = false,
            Position = UDim2.fromOffset(24, 229),
            Size = UDim2.fromOffset(440, 70),
            TextColor3 = ValleyTheme.Paper,
            Font = Enum.Font.GothamBold
        });
        ValleyTheme.surface(u15, ValleyTheme.InventoryInk, ValleyTheme.Gold, 6, 0.5);
        local u16 = ValleyPanels.text(u5, "Unit", "Exact amount. No XP multiplier or bowners coins.", 24, 316, 440, 64, 16, ValleyTheme.Muted);
        u16.Visible = false;
        local u17 = ValleyPanels.text(u5, "Status", "", 24, 438, 748, 56, 16, ValleyTheme.Gold);
        local u18 = ValleyPanels.button(u5, "PreviewButton", "PREVIEW HERE", 24, 508, 215, 46);
        ValleyTheme.button(u18, ValleyTheme.Blue);
        local u19 = ValleyPanels.button(u5, "Launch", "START GLOBAL WHEEL", 253, 508, 519, 46);
        ValleyTheme.button(u19, ValleyTheme.Gold);

        local function prize() -- Line: 27
            -- upvalues: u8 (ref), u9 (ref), u15 (copy)
            return u8 == "Dagger" and {
                kind = u8,
                skin = u9
            } or {
                kind = u8,
                amount = tonumber(u15.Text)
            };
        end;

        local function draw() -- Line: 28
            -- upvalues: u10 (ref), u19 (copy), u17 (copy), GiveawayRules (ref), prize (copy), u11 (copy), ValleyTheme (ref), u8 (ref), u13 (copy), u9 (ref), u12 (copy), u14 (copy), u15 (copy), u16 (copy), GiveawayView (ref)
            u10 = false;
            u19.Text = "START GLOBAL WHEEL";
            u17.Text = GiveawayRules.validPrize((prize())) and GiveawayRules.label((prize())) or "Enter a whole amount from 1 to 1,000,000.";

            for i, v in u11 do
                ValleyTheme.button(v, i == u8 and ValleyTheme.Gold or ValleyTheme.Border);
            end;

            for i, v in u13 do
                ValleyTheme.button(v, i == u9 and ValleyTheme.Gold or ValleyTheme.Border);
            end;

            u12.Visible = u8 == "Dagger";
            u14.Visible = u12.Visible;
            u15.Visible = not u12.Visible;
            u16.Visible = u15.Visible;

            if u12.Visible then
                GiveawayView.preview(u14, u9);
            end;
        end;

        local u20 = false;

        for i, v in { "Dagger", "Gems", "Coins", "XP" } do
            local v21 = ValleyPanels.button(u5, v, v:upper(), 24 + (i - 1) * 189, 159, 181, 38);
            u11[v] = v21;
            v21.Activated:Connect(function() -- Line: 37
                -- upvalues: u20 (ref), u8 (ref), v (copy), draw (copy)
                if not u20 then
                    u8 = v;
                    draw();
                end;
            end);
        end;

        for i, v in SkinCatalog.Order do
            local v22 = SkinCatalog.get(v);
            local v23 = ValleyPanels.button(u12, v, v22.Name, 0, 0, 425, 43);
            v23.LayoutOrder = i;
            v23.TextSize = 14;
            u13[v] = v23;
            v23.Activated:Connect(function() -- Line: 42
                -- upvalues: u20 (ref), u9 (ref), v (copy), draw (copy)
                if not u20 then
                    u9 = v;
                    draw();
                end;
            end);
        end;

        u15:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 44
            -- upvalues: u20 (ref), draw (copy)
            if not u20 then
                draw();
            end;
        end);

        local function visible(p24) -- Line: 45
            -- upvalues: u4 (copy), u1 (copy), u20 (ref), draw (copy)
            u4.Visible = p24;
            u1:SetAttribute("GiveawayPickerOpen", p24 or nil);

            if p24 then
                u20 = false;
                draw();
                local FocusedTextBox = game.UserInputService:GetFocusedTextBox();

                if FocusedTextBox then
                    FocusedTextBox:ReleaseFocus();
                end;
            end;
        end;

        u6.Activated:Connect(function() -- Line: 49
            -- upvalues: u4 (copy), u1 (copy)
            u4.Visible = false;
            u1:SetAttribute("GiveawayPickerOpen", nil);
        end);

        local function send(p25) -- Line: 50
            -- upvalues: u20 (ref), GiveawayRules (ref), prize (copy), u10 (ref), u19 (copy), u17 (copy), u2 (copy)
            if u20 or not GiveawayRules.validPrize((prize())) then
                return;
            end;

            if not (p25 or u10) then
                u10 = true;
                u19.Text = "CONFIRM · START IN ALL SERVERS";
                u17.Text = "Give " .. GiveawayRules.label((prize())) .. " to one eligible player per server? Matches pause during the spin.";

                return;
            end;

            u20 = true;
            u17.Text = "Starting…";
            u2:FireServer(p25 and "Preview" or "Launch", (prize()));
            task.delay(12, function() -- Line: 58
                -- upvalues: u20 (ref), u17 (ref), u10 (ref), u19 (ref)
                if u20 then
                    u20 = false;
                    u17.Text = "Still waiting for the server. Check before trying again.";
                    u10 = false;
                    u19.Text = "START GLOBAL WHEEL";
                end;
            end);
        end;

        u18.Activated:Connect(function() -- Line: 60
            -- upvalues: u20 (ref), GiveawayRules (ref), prize (copy), u17 (copy), u2 (copy), u10 (ref), u19 (copy)
            if not u20 then
                if not GiveawayRules.validPrize((prize())) then
                    return;
                end;

                u20 = true;
                u17.Text = "Starting…";
                u2:FireServer("Preview", (prize()));
                task.delay(12, function() -- Line: 58
                    -- upvalues: u20 (ref), u17 (ref), u10 (ref), u19 (ref)
                    if u20 then
                        u20 = false;
                        u17.Text = "Still waiting for the server. Check before trying again.";
                        u10 = false;
                        u19.Text = "START GLOBAL WHEEL";
                    end;
                end);
            end;
        end);
        u19.Activated:Connect(function() -- Line: 60
            -- upvalues: send (copy)
            send(false);
        end);

        local function layout() -- Line: 61
            -- upvalues: u3 (copy), u5 (copy), u7 (copy), u6 (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy)
            local AbsoluteSize = u3.AbsoluteSize;
            local v26 = AbsoluteSize.X < AbsoluteSize.Y;
            local v27 = not v26 and AbsoluteSize.Y < 520;
            local v28 = v26 and 540 or 800;
            local v29 = v26 and 680 or (v27 and 420 or 580);
            u5.Size = UDim2.fromOffset(v28, v29);
            u5.Scale.Scale = math.min(1.15, AbsoluteSize.X * 0.94 / v28, AbsoluteSize.Y * 0.92 / v29);
            u5.Title.Size = UDim2.fromOffset(v28 - 95, v26 and 72 or (v27 and 44 or 54));
            u5.Title.Position = UDim2.fromOffset(24, v27 and 36 or 51);
            u5.Title.TextSize = v26 and 22 or (v27 and 20 or 24);
            u5.Eyebrow.Position = UDim2.fromOffset(24, v27 and 10 or 18);
            u5.Eyebrow.Size = UDim2.fromOffset(v28 - 100, 22);
            u7.Position = UDim2.fromOffset(24, v26 and 126 or (v27 and 77 or 113));
            u7.Size = UDim2.fromOffset(v28 - 48, 38);
            u7.TextSize = v27 and 12 or 14;
            u6.Position = UDim2.fromOffset(v28 - 70, 12);
            u6.Size = UDim2.fromOffset(54, 48);

            for i, v in { "Dagger", "Gems", "Coins", "XP" } do
                local v30 = u11[v];
                v30.Position = UDim2.fromOffset(24 + (i - 1) * (v28 - 48) / 4, v26 and 178 or (v27 and 116 or 159));
                v30.Size = UDim2.fromOffset((v28 - 48) / 4 - 8, 34);
            end;

            local v31 = v26 and 230 or (v27 and 163 or 207);
            u12.Position = UDim2.fromOffset(24, v31);
            u12.Size = UDim2.fromOffset(v26 and 300 or 440, v26 and 280 or (v27 and 142 or 220));

            for _, v in u13 do
                v.Size = UDim2.fromOffset(v26 and 284 or 425, v26 and 60 or 48);
                v.TextSize = 16;
            end;

            u14.Position = UDim2.fromOffset(v26 and 340 or 487, v31);
            u14.Size = UDim2.fromOffset(v26 and 176 or 285, v27 and 145 or 220);
            u15.Position = UDim2.fromOffset(24, v31 + 10);
            u15.Size = UDim2.fromOffset(v26 and 300 or 440, 60);
            u16.Position = UDim2.fromOffset(24, v31 + 75);
            u16.Size = UDim2.fromOffset(v26 and 300 or 440, 60);
            u17.Position = UDim2.fromOffset(24, v29 - 137);
            u17.Size = UDim2.fromOffset(v28 - 48, 62);
            u17.TextSize = v27 and 13 or 16;
            u18.Position = UDim2.fromOffset(24, v29 - 66);
            u18.Size = UDim2.fromOffset(v26 and 155 or 215, 44);
            u19.Position = UDim2.fromOffset(v26 and 190 or 253, v29 - 66);
            u19.Size = UDim2.fromOffset(v26 and 326 or 519, 44);
            u19.TextSize = v26 and 11 or 14;
        end;

        u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout);
        layout();
        draw();

        return {
            open = function() -- Line: 82, Name: open
                -- upvalues: u1 (copy), u4 (copy), u20 (ref), draw (copy)
                if u1:GetAttribute("AdminTier") == "Owner" then
                    u4.Visible = true;
                    u1:SetAttribute("GiveawayPickerOpen", true);
                    u20 = false;
                    draw();
                    local FocusedTextBox = game.UserInputService:GetFocusedTextBox();

                    if FocusedTextBox then
                        FocusedTextBox:ReleaseFocus();
                    end;
                end;
            end,

            hide = function() -- Line: 83, Name: hide
                -- upvalues: u4 (copy), u1 (copy)
                u4.Visible = false;
                u1:SetAttribute("GiveawayPickerOpen", nil);
            end,

            reply = function(p32) -- Line: 84, Name: reply
                -- upvalues: u20 (ref), u10 (ref), u4 (copy), u1 (copy), u17 (copy), u19 (copy)
                u20 = false;
                u10 = false;

                if p32.ok then
                    u4.Visible = false;
                    u1:SetAttribute("GiveawayPickerOpen", nil);

                    return;
                end;

                u17.Text = p32.message;
                u19.Text = "START GLOBAL WHEEL";
            end,

            destroy = function() -- Line: 85, Name: destroy
                -- upvalues: u1 (copy), u3 (copy)
                u1:SetAttribute("GiveawayPickerOpen", nil);
                u3:Destroy();
            end
        };
    end
};