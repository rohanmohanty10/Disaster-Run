  

 

return function(p1) -- Line: 1
    local Knit = p1.Knit;
    local TweenService = game:GetService("TweenService");
    local TraitHandler = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
    local Trove = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
    local Parent = script.Parent;
    local u2 = nil;
    local u3 = {};
    Knit.OnStart():andThen(function() -- Line: 10
        -- upvalues: u2 (ref), Knit (copy)
        u2 = Knit.GetService("TraitService");
        local v4 = u2:GetTraitsMetadata():expect();
        local _ = v4.RarityColors;
        local _ = v4.RarityIndices;
        local _ = v4.StatRanges;
    end);
    local u5 = {};

    function p1.CreateBossHud(p6, p7) -- Line: 20
        -- upvalues: u5 (copy), Parent (copy), TraitHandler (copy), u3 (copy), Trove (copy), TweenService (copy)
        local Model = p7.Model;

        if Model and not u5[Model] then
            local Ability = Model:WaitForChild("Data"):WaitForChild("Ability");
            local HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart");
            Model:WaitForChild("Head");
            local u8 = Parent.Assets.Hud:Clone();
            local Content = u8:WaitForChild("Content");

            if HumanoidRootPart:FindFirstChild("NpcHud") then
                HumanoidRootPart:FindFirstChild("NpcHud"):Destroy();
            end;

            local Humanoid = Model:WaitForChild("Humanoid");
            local HealthDisplay = Content.Health.HealthDisplay;
            local Percent = Content.Health.Percent;
            local BarDisplay = Content.Bar.BarDisplay;
            local Percent2 = Content.Bar.Percent;
            Content.BottomDisplay.Text = Humanoid.DisplayName;

            if Model:GetAttribute("NameColor") then
                Content.Display.Text = `<font color="{Model:GetAttribute("NameColor")}">{Humanoid.DisplayName}</font>`;
            else
                Content.Display.Text = Humanoid.DisplayName;
            end;

            u8.Visible = true;
            u8.Parent = Parent;

            if Ability:GetAttribute("AbilityLevel") then
                local Display = Content.Display;
                Display.Text = Display.Text .. `<font color="rgb(255, 225, 103)"> [ LVL {Ability:GetAttribute("AbilityLevel")} ]</font>`;
                local BottomDisplay = Content.BottomDisplay;
                BottomDisplay.Text = BottomDisplay.Text .. ` [ LVL {Ability:GetAttribute("AbilityLevel")} ]`;
            end;

            local v9 = Ability:GetAttribute("Trait") and TraitHandler.GetTraitData(Ability:GetAttribute("Trait"));

            if v9 then
                local v10 = u3[v9.Rarity] or Color3.fromRGB(255, 255, 255);
                local v11 = v10:Lerp(Color3.fromRGB(0, 0, 0), 0.5);

                if v9.Rarity == "Common" then
                    v11 = Color3.fromRGB(0, 0, 0);
                end;

                local Display = Content.Display;
                Display.Text = Display.Text .. ` • <stroke color="#{v11:ToHex()}"><font color="#{v10:ToHex()}">[ {Ability:GetAttribute("Trait"):upper()} ]</font></stroke>`;
                local BottomDisplay = Content.BottomDisplay;
                BottomDisplay.Text = BottomDisplay.Text .. ` • [ {Ability:GetAttribute("Trait"):upper()} ]`;
            end;

            local u12 = Trove.new();
            u12:AttachToInstance(Model);
            u12:Add(u8);
            u5[Model] = true;
            local _ = Humanoid.Health;
            local u13 = nil;
            u13 = Humanoid.HealthChanged:Connect(function(p14) -- Line: 77
                -- upvalues: TweenService (ref), Content (copy), Model (copy), u13 (ref), Humanoid (copy), Percent (copy), u8 (copy), HealthDisplay (copy)
                if p14 <= 0 then
                    TweenService:Create(Content, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        GroupTransparency = 1
                    }):Play();

                    return;
                end;

                if not Model.Parent then
                    u13:Disconnect();

                    return;
                end;

                local u15 = math.clamp(p14 / Humanoid.MaxHealth, 0, 1);
                TweenService:Create(Percent, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(u15, 1)
                }):Play();
                task.delay(0.8, function() -- Line: 113
                    -- upvalues: u8 (ref), TweenService (ref), Content (ref), u15 (copy)
                    if not u8.Parent then
                        return;
                    end;

                    TweenService:Create(Content.Health.Fade, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(u15, 1)
                    }):Play();
                end);
                HealthDisplay.Text = math.round(p14) .. " / " .. Humanoid.MaxHealth .. " HP";
            end);
            u12:Add(u13);
            HealthDisplay.Text = math.round(Humanoid.Health) .. " / " .. Humanoid.MaxHealth .. " HP";
            u12:Add(function() -- Line: 123
                -- upvalues: u5 (ref), Model (copy)
                u5[Model] = nil;
            end);
            u12:Connect(u8.Close.MouseButton1Click, function() -- Line: 127
                -- upvalues: u12 (copy)
                u12:Destroy();
            end);
            u12:Connect(Model:GetAttributeChangedSignal("BAR"), function(...) -- Line: 131
                -- upvalues: Model (copy), TweenService (ref), Percent2 (copy), Content (copy), BarDisplay (copy)
                local v16 = Model:GetAttribute("MaxBAR");
                local v17 = Model:GetAttribute("BAR") / v16;
                local u18 = math.clamp(v17, 0, 1);
                TweenService:Create(Percent2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(u18, 1)
                }):Play();
                task.delay(0.8, function() -- Line: 138
                    -- upvalues: Content (ref), TweenService (ref), u18 (copy)
                    if not Content:FindFirstChild("Bar") then
                        return;
                    end;

                    TweenService:Create(Content.Bar.Fade, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(u18, 1)
                    }):Play();
                end);
                BarDisplay.Text = `{math.floor(u18 * 100)}% BAR`;
            end);
        end;
    end;
end;