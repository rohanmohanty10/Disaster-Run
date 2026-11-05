  

 

return function(u1) -- Line: 1
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Knit = u1.Knit;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
    local u2 = Knit.GetService("ShopService");
    local u3 = Knit.GetService("SubPowerService");
    u1.Util.Tooltip.GetFromParent(u1.UI:FindFirstChild("Screen"));
    require(script.UpgradeInfo);
    local u4 = nil;
    local Parent = script.Parent;
    local Currencies = Parent.Currencies;

    local function AttemptRerollFunction(u5, u6) -- Line: 26
        -- upvalues: LocalPlayer (copy), u1 (copy), u3 (copy)
        local u7 = 100;

        if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
            u7 = u7 / 2;
        end;

        return function() -- Line: 33
            -- upvalues: u5 (copy), u6 (copy), u1 (ref), u7 (ref), u3 (ref)
            if u5 == "BuyColorReroll" and typeof(u6) == "number" then
                u1.NewPrompt({
                    Title = "Purchase Color Reroll",
                    Delay = 0.5,
                    Text = `Do you really want to purchase <font color="rgb(255, 67, 214)">{u6 == 1 and "1 Color Reroll" or "10 Color Rerolls"}</font>`,
                    RichText = { 2 },
                    Options = { "Cancel", `<font color="rgb(255,200,100)">{tostring(u7 * u6)} {u1.PremiumCurrencyString}</font>` },

                    Callback = function(p8) -- Line: 44, Name: Callback
                        -- upvalues: u1 (ref), u3 (ref), u6 (ref)
                        u1:PlaySound("Click");

                        if p8.Choice == 1 then
                            return;
                        end;

                        local v9 = u3:BuyReroll(u6):expect();

                        if v9 then
                            if typeof(v9) == "string" and v9 == "NotEnough" then
                                u1.NewPrompt({
                                    Title = "Purchase Failed",
                                    Text = "Not enough uPoints"
                                });
                            end;
                        else
                            print(v9);
                        end;
                    end
                });

                return;
            end;

            if u5 == "RerollColor" and typeof(u6) == "string" then
                u1.NewPrompt({
                    Title = "Reroll Haki Color",
                    Text = "Do you want to reroll your current haki color?",
                    Delay = 0.5,
                    RichText = { 2 },
                    Options = { "No", "Yes" },

                    Callback = function(p10) -- Line: 73, Name: Callback
                        -- upvalues: u1 (ref), u3 (ref), u6 (ref)
                        u1:PlaySound("Click");

                        if p10.Choice == 1 then
                            return;
                        end;

                        local v11 = u3:RollColor(u6 .. " Haki"):expect();

                        if v11 then
                            if typeof(v11) == "string" then
                                warn(v11);

                                if v11 == "failed" then
                                    u1.NewPrompt({
                                        Title = "Upgrade Failed",
                                        Text = "Unable to reroll the color of your haki at this time, this may be because you don\'t have an ability that is eligible for the abilities it offers."
                                    });
                                end;
                            end;
                        else
                            print(v11);
                        end;
                    end
                });
            end;
        end;
    end;

    local function ManageHakiPanel(p12) -- Line: 97
        -- upvalues: LocalPlayer (copy), u1 (copy), u3 (copy)
        if not p12 then
            return;
        end;

        local u13 = tostring(p12.Name);
        local MouseButton1Click = p12:FindFirstChild("RerollColor").MouseButton1Click;
        local u14 = 100;

        if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
            u14 = u14 / 2;
        end;

        local u15 = "RerollColor";
        MouseButton1Click:Connect(function() -- Line: 33
            -- upvalues: u15 (copy), u13 (copy), u1 (ref), u14 (ref), u3 (ref)
            if u15 == "BuyColorReroll" and typeof(u13) == "number" then
                u1.NewPrompt({
                    Title = "Purchase Color Reroll",
                    Delay = 0.5,
                    Text = `Do you really want to purchase <font color="rgb(255, 67, 214)">{u13 == 1 and "1 Color Reroll" or "10 Color Rerolls"}</font>`,
                    RichText = { 2 },
                    Options = { "Cancel", `<font color="rgb(255,200,100)">{tostring(u14 * u13)} {u1.PremiumCurrencyString}</font>` },

                    Callback = function(p16) -- Line: 44, Name: Callback
                        -- upvalues: u1 (ref), u3 (ref), u13 (ref)
                        u1:PlaySound("Click");

                        if p16.Choice == 1 then
                            return;
                        end;

                        local v17 = u3:BuyReroll(u13):expect();

                        if v17 then
                            if typeof(v17) == "string" and v17 == "NotEnough" then
                                u1.NewPrompt({
                                    Title = "Purchase Failed",
                                    Text = "Not enough uPoints"
                                });
                            end;
                        else
                            print(v17);
                        end;
                    end
                });

                return;
            end;

            if u15 == "RerollColor" and typeof(u13) == "string" then
                u1.NewPrompt({
                    Title = "Reroll Haki Color",
                    Text = "Do you want to reroll your current haki color?",
                    Delay = 0.5,
                    RichText = { 2 },
                    Options = { "No", "Yes" },

                    Callback = function(p18) -- Line: 73, Name: Callback
                        -- upvalues: u1 (ref), u3 (ref), u13 (ref)
                        u1:PlaySound("Click");

                        if p18.Choice == 1 then
                            return;
                        end;

                        local v19 = u3:RollColor(u13 .. " Haki"):expect();

                        if v19 then
                            if typeof(v19) == "string" then
                                warn(v19);

                                if v19 == "failed" then
                                    u1.NewPrompt({
                                        Title = "Upgrade Failed",
                                        Text = "Unable to reroll the color of your haki at this time, this may be because you don\'t have an ability that is eligible for the abilities it offers."
                                    });
                                end;
                            end;
                        else
                            print(v19);
                        end;
                    end
                });
            end;
        end);
    end;

    local function UpdateLocked() -- Line: 105
        -- upvalues: u3 (copy), Parent (copy)
        local v20 = u3:GetUnlockedHakis():expect();
        local v21 = { "Busoshoku", "Haoshoku", "Kenbunshoku" };

        if v20 and typeof(v20) == "table" then
            for i = 1, #v21 do
                if Parent.Holder:FindFirstChild(v21[i]) then
                    if v20[v21[i]] then
                        Parent.Holder:FindFirstChild(v21[i]).Locked.Visible = false;

                        for _, child in Parent.Holder:FindFirstChild(v21[i]):GetChildren() do
                            if child:IsA("TextButton") then
                                child.Interactable = true;
                            end;
                        end;
                    else
                        Parent.Holder:FindFirstChild(v21[i]).Locked.Visible = true;

                        for _, child in Parent.Holder:FindFirstChild(v21[i]):GetChildren() do
                            if child:IsA("TextButton") then
                                child.Interactable = false;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local function UpdateHakiInfo() -- Line: 132
        -- upvalues: u3 (copy), u4 (ref), Parent (copy)
        local v22 = u3:GetHakiInfo():expect();
        u4 = v22;

        for _, v in { "Busoshoku", "Haoshoku", "Kenbunshoku" } do
            local v23 = Parent.Holder:FindFirstChild(v);

            if v23 then
                if v22[v] then
                    local Color = v22[v].Color;

                    if not Color or Color == "000000" then
                        if v == "Kenbunshoku" then
                            Color = Color3.fromRGB(55, 202, 255):ToHex();
                        elseif v == "Haoshoku" then
                            Color = Color3.fromRGB(255, 0, 0):ToHex();
                        else
                            Color = Color3.fromRGB(0, 0, 0):ToHex();
                        end;
                    end;

                    v23.ColorLabel.Text = `<font color="#{Color}">[ {string.upper(Color)} ]</font>`;
                else
                    v23.ColorLabel.Text = "[ Haki Color ]";
                end;
            end;
        end;
    end;

    UpdateLocked();

    local function UpdateCurrencies() -- Line: 16
        -- upvalues: u2 (copy), u1 (copy), Currencies (copy)
        local v24 = u1:AbbreviateNumber((u2:GetCurrencyType("UPoints"):expect()));
        Currencies.PremiumCurrency.Text = `{v24} {u1.PremiumCurrencyString}`;
        Currencies.Rerolls.Text = `{u2:GetCurrencyType("ColorRerolls"):expect()} Color Rerolls`;
    end;

    for _, child in Parent.Holder:GetChildren() do
        if child:IsA("Frame") then
            if child then
                local u25 = tostring(child.Name);
                local MouseButton1Click = child:FindFirstChild("RerollColor").MouseButton1Click;
                local u26 = 100;

                if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
                    u26 = u26 / 2;
                end;

                local u27 = "RerollColor";
                MouseButton1Click:Connect(function() -- Line: 33
                    -- upvalues: u27 (copy), u25 (copy), u1 (copy), u26 (ref), u3 (copy)
                    if u27 == "BuyColorReroll" and typeof(u25) == "number" then
                        u1.NewPrompt({
                            Title = "Purchase Color Reroll",
                            Delay = 0.5,
                            Text = `Do you really want to purchase <font color="rgb(255, 67, 214)">{u25 == 1 and "1 Color Reroll" or "10 Color Rerolls"}</font>`,
                            RichText = { 2 },
                            Options = { "Cancel", `<font color="rgb(255,200,100)">{tostring(u26 * u25)} {u1.PremiumCurrencyString}</font>` },

                            Callback = function(p28) -- Line: 44, Name: Callback
                                -- upvalues: u1 (ref), u3 (ref), u25 (ref)
                                u1:PlaySound("Click");

                                if p28.Choice == 1 then
                                    return;
                                end;

                                local v29 = u3:BuyReroll(u25):expect();

                                if v29 then
                                    if typeof(v29) == "string" and v29 == "NotEnough" then
                                        u1.NewPrompt({
                                            Title = "Purchase Failed",
                                            Text = "Not enough uPoints"
                                        });
                                    end;
                                else
                                    print(v29);
                                end;
                            end
                        });

                        return;
                    end;

                    if u27 == "RerollColor" and typeof(u25) == "string" then
                        u1.NewPrompt({
                            Title = "Reroll Haki Color",
                            Text = "Do you want to reroll your current haki color?",
                            Delay = 0.5,
                            RichText = { 2 },
                            Options = { "No", "Yes" },

                            Callback = function(p30) -- Line: 73, Name: Callback
                                -- upvalues: u1 (ref), u3 (ref), u25 (ref)
                                u1:PlaySound("Click");

                                if p30.Choice == 1 then
                                    return;
                                end;

                                local v31 = u3:RollColor(u25 .. " Haki"):expect();

                                if v31 then
                                    if typeof(v31) == "string" then
                                        warn(v31);

                                        if v31 == "failed" then
                                            u1.NewPrompt({
                                                Title = "Upgrade Failed",
                                                Text = "Unable to reroll the color of your haki at this time, this may be because you don\'t have an ability that is eligible for the abilities it offers."
                                            });
                                        end;
                                    end;
                                else
                                    print(v31);
                                end;
                            end
                        });
                    end;
                end);
            end;
        end;
    end;

    Parent.Buy.Price.Text = `100 {u1.PremiumCurrencyString}`;
    pcall(function() -- Line: 172
        -- upvalues: LocalPlayer (copy), Parent (copy), u1 (copy)
        if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
            Parent.Buy.Price.Text = `50 {u1.PremiumCurrencyString}`;
        end;
    end);

    function u1.ShowHakiUI(p32) -- Line: 178
        -- upvalues: UpdateCurrencies (copy), Parent (copy)
        UpdateCurrencies();
        Parent.Visible = true;
    end;

    u1.CurrencyUpdated:Connect(function(p33) -- Line: 183
        -- upvalues: UpdateCurrencies (copy)
        if p33 ~= "Changed" then
            return;
        end;

        UpdateCurrencies();
    end);
    Parent.Close.MouseButton1Click:Connect(function() -- Line: 188
        -- upvalues: Parent (copy)
        Parent.Visible = false;
    end);
    Parent.Buy.MouseButton1Click:Connect(function() -- Line: 192
        -- upvalues: u1 (copy), LocalPlayer (copy), u3 (copy)
        u1.NewPrompt({
            Title = "Purchase Color Reroll",
            Text = "Purchase how many <font color=\"rgb(255, 67, 214)\">Color Rerolls\"</font>",
            RichText = true,
            Delay = 0.5,
            Options = { "Cancel", "x1", "x10" },

            Callback = function(p34) -- Line: 203, Name: Callback
                -- upvalues: u1 (ref), LocalPlayer (ref), u3 (ref)
                u1:PlaySound("Click");

                if p34.Choice == 1 then
                    return;
                end;

                local u35 = p34.Choice == 2 and 1 or 10;
                local u36 = 100;

                if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
                    u36 = u36 / 2;
                end;

                local u37 = "BuyColorReroll";
                (function() -- Line: 33
                    -- upvalues: u37 (copy), u35 (copy), u1 (ref), u36 (ref), u3 (ref)
                    if u37 == "BuyColorReroll" and typeof(u35) == "number" then
                        u1.NewPrompt({
                            Title = "Purchase Color Reroll",
                            Delay = 0.5,
                            Text = `Do you really want to purchase <font color="rgb(255, 67, 214)">{u35 == 1 and "1 Color Reroll" or "10 Color Rerolls"}</font>`,
                            RichText = { 2 },
                            Options = { "Cancel", `<font color="rgb(255,200,100)">{tostring(u36 * u35)} {u1.PremiumCurrencyString}</font>` },

                            Callback = function(p38) -- Line: 44, Name: Callback
                                -- upvalues: u1 (ref), u3 (ref), u35 (ref)
                                u1:PlaySound("Click");

                                if p38.Choice == 1 then
                                    return;
                                end;

                                local v39 = u3:BuyReroll(u35):expect();

                                if v39 then
                                    if typeof(v39) == "string" and v39 == "NotEnough" then
                                        u1.NewPrompt({
                                            Title = "Purchase Failed",
                                            Text = "Not enough uPoints"
                                        });
                                    end;
                                else
                                    print(v39);
                                end;
                            end
                        });

                        return;
                    end;

                    if u37 == "RerollColor" and typeof(u35) == "string" then
                        u1.NewPrompt({
                            Title = "Reroll Haki Color",
                            Text = "Do you want to reroll your current haki color?",
                            Delay = 0.5,
                            RichText = { 2 },
                            Options = { "No", "Yes" },

                            Callback = function(p40) -- Line: 73, Name: Callback
                                -- upvalues: u1 (ref), u3 (ref), u35 (ref)
                                u1:PlaySound("Click");

                                if p40.Choice == 1 then
                                    return;
                                end;

                                local v41 = u3:RollColor(u35 .. " Haki"):expect();

                                if v41 then
                                    if typeof(v41) == "string" then
                                        warn(v41);

                                        if v41 == "failed" then
                                            u1.NewPrompt({
                                                Title = "Upgrade Failed",
                                                Text = "Unable to reroll the color of your haki at this time, this may be because you don\'t have an ability that is eligible for the abilities it offers."
                                            });
                                        end;
                                    end;
                                else
                                    print(v41);
                                end;
                            end
                        });
                    end;
                end)();
            end
        });
    end);
    task.spawn(function() -- Line: 214
        -- upvalues: Parent (copy), UpdateHakiInfo (copy), UpdateLocked (copy)
        while true do
            while Parent.Visible == true do
                UpdateHakiInfo();
                UpdateLocked();
                task.wait(0.25);
            end;

            Parent.Changed:Wait();
        end;
    end);
end;