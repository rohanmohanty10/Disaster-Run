  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = require(u1.Knit.Util.Trove).new();
    require(u1.Knit.Util.Timer);
    local Promise = require(u1.Knit.Util.Promise);
    local u3 = u1.Knit.GetService("LevelService");
    local v4 = u1.Knit.GetService("TraitService");
    require(u1.PathShortcuts.StandsModule.ReworkAbilities);
    local TraitHandler = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
    local RunService = game:GetService("RunService");
    local v5 = v4:GetTraitsMetadata():expect();
    local RarityColors = v5.RarityColors;
    local _ = v5.RarityIndices;
    local _ = v5.StatRanges;
    local TweenService = game:GetService("TweenService");

    local function SetVisible(p6) -- Line: 21
        -- upvalues: Parent (copy)
        Parent.Visible = p6;
    end;

    local function CheckAbility() -- Line: 25
        -- upvalues: Parent (copy)
        Parent.Visible = true;
    end;

    local function SetBar(p7, p8) -- Line: 29
        p7.Size = UDim2.new(p8, 0, 1, 0);
        p7.ImageLabel.Size = UDim2.new(1 + (1 - p8) * (p8 < 0.05 and 8 or 1), 0, 1, 0);
    end;

    local function TweenBar(p9, p10) -- Line: 34
        local v11 = {
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Sine,
            0.1,
            true
        };
        p9:TweenSize(UDim2.new(p10, 0, 1, 0), unpack(v11));
        p9.ImageLabel:TweenSize(UDim2.new(1 + (1 - p10) * (p10 < 0.05 and 8 or 1), 0, 1, 0), unpack(v11));
    end;

    function u1.FlashMeter(p12, p13) -- Line: 42
        -- upvalues: Parent (copy), TweenService (copy)
        local Character = p12.Character;

        if not Character then
            return;
        end;

        local u14 = Parent.Meter.Container.Bar.Flash:Clone();
        local v15 = p13 / (Character:GetAttribute("MaxMeter") or 100);
        u14.Size = UDim2.new(v15, 0, 1, 0);
        u14.ImageLabel.Size = UDim2.new(1 + (1 - v15) * (v15 < 0.05 and 8 or 1), 0, 1, 0);
        u14.Visible = true;
        u14.Parent = Parent.Meter.Container.Bar;
        TweenService:Create(u14.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true), {
            ImageTransparency = 0.5
        }):Play();
        task.delay(0.5, function() -- Line: 59
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);
    end;

    local function CharacterAdded(u16) -- Line: 64
        -- upvalues: u2 (copy), Parent (copy), TraitHandler (copy), RarityColors (copy), Promise (copy), u1 (copy), TweenBar (copy), TweenService (copy), u3 (copy), RunService (copy)
        u2:Clean();
        local Humanoid = u16:WaitForChild("Humanoid");
        local Ability = game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Ability");
        local Health = Humanoid.Health;
        local u17 = 0;
        local u18 = false;

        local function NameChanged() -- Line: 74
            -- upvalues: Ability (copy), Parent (ref), Humanoid (copy), u16 (copy), TraitHandler (ref), RarityColors (ref)
            local v19 = Ability:GetAttribute("Trait");
            local v20 = Ability:GetAttribute("AbilityLevel") or 0;
            Parent.Info.Label.Text = Humanoid.DisplayName ~= "" and Humanoid.DisplayName or u16.Name;
            local AbilityInfo = Parent.Info.AbilityInfo;
            AbilityInfo.Text = "";

            if v20 then
                AbilityInfo.Text = AbilityInfo.Text .. `<font color="rgb(255, 225, 103)"> [ LVL {v20} ]</font>`;
            end;

            if v19 then
                print(v19);
                local v21 = TraitHandler.GetTraitData(Ability:GetAttribute("Trait"));
                local v22 = "";

                if Ability:GetAttribute("HexedTrait") and v21.HexPrefix then
                    v22 = v22 .. `{v21.HexPrefix} `;
                end;

                if v21 then
                    local v23 = RarityColors[v21.Rarity] or Color3.fromRGB(255, 255, 255);
                    local v24 = v23:Lerp(Color3.fromRGB(0, 0, 0), 0.5);

                    if v21.Rarity == "Common" then
                        v24 = Color3.fromRGB(0, 0, 0);
                    end;

                    AbilityInfo.Text = AbilityInfo.Text .. ` • <stroke color="#{v24:ToHex()}"><font color="#{v23:ToHex()}">[ {v22:upper()}{v19:upper()} ]</font></stroke>`;
                end;
            end;
        end;

        local function IconChanged() -- Line: 104
            -- upvalues: Promise (ref), u1 (ref), Parent (ref)
            Promise.try(function() -- Line: 105
                -- upvalues: u1 (ref)
                return game.Players:GetUserThumbnailAsync(u1.Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180);
            end):andThen(function(p25) -- Line: 107
                -- upvalues: Parent (ref)
                Parent.Icon.Icon.Image = p25;
            end):catch(warn);
        end;

        local function CombatChanged() -- Line: 112
            -- upvalues: Parent (ref), u16 (copy)
            Parent.Info.CombatTag.Visible = u16:GetAttribute("InCombat") == true;
            Parent.Info.PVPTag.Visible = (u16:GetAttribute("PVPTag") or 0) > workspace:GetServerTimeNow();
            Parent.Info.SafezoneTag.Visible = u16:GetAttribute("InSafezone") == true;
            Parent.Info.PVPSafeTag.Visible = u16:GetAttribute("PVPSafe") == true;
        end;

        local function HealthChanged() -- Line: 119
            -- upvalues: u16 (copy), TweenBar (ref), Parent (ref), Humanoid (copy), Health (ref), u17 (ref), u18 (ref), TweenService (ref)
            local v26 = u16:GetAttribute("Recovery") or 0;
            local _ = u16:GetAttribute("MaxRecovery") or 100;
            TweenBar(Parent.Health.Container.Bar.Main, (math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)));
            TweenBar(Parent.Health.Container.Bar.Recovery, (math.clamp((Humanoid.Health + v26) / Humanoid.MaxHealth, 0, 1)));
            local v27 = u16:GetAttribute("Shield") or 0;

            if v27 > 0 then
                Parent.Health.Text.Value.Text = string.format("%.0f", Humanoid.Health) .. ` <font color="rgb(150, 120, 255)">({string.format("%.2f", v27)})</font>`;
            else
                Parent.Health.Text.Value.Text = string.format("%.0f", Humanoid.Health);
            end;

            if Humanoid.Health < Health then
                u17 = os.clock();

                if not u18 then
                    u18 = true;
                    local Damage = Parent.Health.Container.Bar.Damage;
                    local v28 = Health / Humanoid.MaxHealth;
                    Damage.Size = UDim2.new(v28, 0, 1, 0);
                    Damage.ImageLabel.Size = UDim2.new(1 + (1 - v28) * (v28 < 0.05 and 8 or 1), 0, 1, 0);
                    TweenService:Create(Parent.Health.Container.Bar.Damage.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ImageTransparency = 0.5
                    }):Play();
                    task.spawn(function() -- Line: 144
                        -- upvalues: u17 (ref), TweenService (ref), Parent (ref), u18 (ref)
                        while os.clock() - u17 <= 1.5 do
                            task.wait();
                        end;

                        TweenService:Create(Parent.Health.Container.Bar.Damage.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        }):Play();
                        u18 = false;
                    end);
                end;
            end;

            Health = Humanoid.Health;
        end;

        local function MeterChanged() -- Line: 161
            -- upvalues: u16 (copy), TweenBar (ref), Parent (ref)
            local v29 = u16:GetAttribute("Meter") or 0;
            local v30 = u16:GetAttribute("MaxMeter") or 100;
            local v31 = u16:GetAttribute("MeterLevel") or 1;
            TweenBar(Parent.Meter.Container.Bar.Main, (math.clamp(v29 / v30, 0, 1)));
            Parent.Meter.Text.Value.Text = string.format("%.0f", (math.floor(v29)));
            Parent.Meter.Text.Label.Text = string.format("HT.%d", v31);
        end;

        local function MeterColorChanged() -- Line: 172
            -- upvalues: u16 (copy), Parent (ref)
            local v32 = u16:GetAttribute("MeterColor") or Color3.fromRGB(0, 200, 255);
            Parent.Meter.Container.Background.ImageColor3 = v32;
            Parent.Meter.Container.Bar.Main.ImageLabel.ImageColor3 = v32;
            Parent.Meter.Container.Bar.Flash.ImageLabel.ImageColor3 = v32;
            Parent.Meter.Text.Label.UIGradient.Color = ColorSequence.new(v32, Color3.new(1, 1, 1));
            Parent.Meter.Text.Label.UIStroke.Color = v32;
            Parent.Meter.Text.Value.UIGradient.Color = ColorSequence.new(v32, Color3.new(1, 1, 1));
            Parent.Meter.Text.Value.UIStroke.Color = v32;
        end;

        local function ShieldChanged() -- Line: 185
            -- upvalues: u16 (copy), TweenBar (ref), Parent (ref), Humanoid (copy)
            local v33 = u16:GetAttribute("Shield") or 0;
            TweenBar(Parent.Health.Container.Bar.Shield, (math.clamp(v33 / Humanoid.MaxHealth, 0, 1)));

            if v33 > 0 then
                Parent.Health.Text.Value.Text = string.format("%.0f", Humanoid.Health) .. ` <font color="rgb(150, 120, 255)">({string.format("%.1f", v33)})</font>`;

                return;
            end;

            Parent.Health.Text.Value.Text = string.format("%.0f", Humanoid.Health);
        end;

        local NumberValue = Instance.new("NumberValue", script);
        local Circle = Parent.XP.Left.Circle;
        local Circle2 = Parent.XP.Right.Circle;
        task.spawn(function() -- Line: 200
            -- upvalues: u16 (copy), u3 (ref), Ability (copy), TweenService (ref), NumberValue (copy)
            while u16.Parent do
                local v34 = u3:GetAbilityPVEInfo(Ability.Value):expect() or {};
                local CurrentXP = v34.CurrentXP;
                local RequiredXP = v34.RequiredXP;

                if CurrentXP then
                    local v35 = math.clamp(CurrentXP / RequiredXP, 0, 1) * 100 * 2.6;
                    local v36 = math.clamp(v35, 0, 260);
                    TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Value = v36
                    }):Play();
                end;

                task.wait(0.25);
            end;
        end);
        task.spawn(function() -- Line: 218
            -- upvalues: u16 (copy), RunService (ref), Circle (copy), NumberValue (copy), Circle2 (copy)
            while u16.Parent do
                RunService.Heartbeat:Wait();
                Circle.UIGradient.Rotation = math.clamp(NumberValue.Value, 0, 180);
                Circle2.UIGradient.Rotation = math.clamp(NumberValue.Value - 180, 0, 80);
            end;
        end);
        NameChanged();
        IconChanged();
        u2:Connect(Humanoid:GetPropertyChangedSignal("DisplayName"), NameChanged);
        u2:Connect(Ability:GetAttributeChangedSignal("AbilityLevel"), NameChanged);
        u2:Connect(Ability:GetAttributeChangedSignal("Trait"), NameChanged);
        u2:Connect(Ability:GetAttributeChangedSignal("HexedTrait"), NameChanged);
        HealthChanged();
        u2:Connect(Humanoid:GetPropertyChangedSignal("Health"), HealthChanged);
        u2:Connect(Humanoid:GetPropertyChangedSignal("MaxHealth"), HealthChanged);
        u2:Connect(u16:GetAttributeChangedSignal("Recovery"), HealthChanged);
        u2:Connect(u16:GetAttributeChangedSignal("MaxRecovery"), HealthChanged);
        MeterChanged();
        u2:Connect(u16:GetAttributeChangedSignal("Meter"), MeterChanged);
        u2:Connect(u16:GetAttributeChangedSignal("MeterLevel"), MeterChanged);
        MeterColorChanged();
        u2:Connect(u16:GetAttributeChangedSignal("MeterColor"), MeterColorChanged);
        CombatChanged();
        u2:Connect(u16:GetAttributeChangedSignal("InCombat"), CombatChanged);
        u2:Connect(u16:GetAttributeChangedSignal("PVPTag"), CombatChanged);
        u2:Connect(u16:GetAttributeChangedSignal("InSafezone"), CombatChanged);
        u2:Connect(u16:GetAttributeChangedSignal("PVPSafe"), CombatChanged);
        ShieldChanged();
        u2:Connect(u16:GetAttributeChangedSignal("Shield"), ShieldChanged);
        u2:Connect(Humanoid:GetPropertyChangedSignal("MaxHealth"), ShieldChanged);
    end;

    if u1.Character then
        task.spawn(CharacterAdded, u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    Parent.Visible = true;
    u1.Player.Data.Ability.Changed:Connect(CheckAbility);
end;