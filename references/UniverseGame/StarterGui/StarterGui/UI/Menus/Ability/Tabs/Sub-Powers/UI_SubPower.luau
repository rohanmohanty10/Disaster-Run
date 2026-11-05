  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Section = Parent.Section;
    local Weight = Section.Weight;
    local Equipped = Section.Equipped;
    local Unlocked = Section.Unlocked;
    local PowerEntry = Assets.PowerEntry;
    local u2 = p1.Knit.GetService("SubPowerService");

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local SubPowers = require(game:GetService("ReplicatedStorage").ReplicatedModules.SubPowers);
    local Fusion = require(game:GetService("ReplicatedStorage").ClientLibrary.Fusion);
    local v3 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    local u4 = Color3.fromRGB(88, 255, 158);
    local u5 = Color3.fromRGB(255, 83, 83);
    local u6 = {
        CurrentWeight = Fusion.Value(0),
        MaxWeight = Fusion.Value(0),
        EquippedSubPowers = Fusion.Value({}),
        UnlockedSubPowers = Fusion.Value({})
    };
    ({}).UnlockedDataCache = {};

    local function ComputeWeight() -- Line: 36
        -- upvalues: u6 (copy), SubPowers (copy)
        local v7 = 0;

        for i in u6.EquippedSubPowers:get() do
            if SubPowers[i] then
                v7 = v7 + (SubPowers[i].Weight or 3);
            end;
        end;

        return v7;
    end;

    local function UpdateWeight() -- Line: 50
        -- upvalues: u6 (copy), ComputeWeight (copy)
        u6.CurrentWeight:set((ComputeWeight()));
    end;

    local function UpdateData() -- Line: 54
        -- upvalues: u2 (copy), u6 (copy), ComputeWeight (copy)
        local v8 = u2:GetSubPowerData():expect();

        if v8 and typeof(v8) == "table" then
            u6.MaxWeight:set(v8.MaxWeight);
            u6.UnlockedSubPowers:set(v8.Unlocked);
            local v9 = {};

            for i, _ in v8.Equipped do
                v9[i] = v8.Unlocked[i];
            end;

            u6.EquippedSubPowers:set(v9);
        end;

        u6.CurrentWeight:set((ComputeWeight()));
        task.wait();
    end;

    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(UpdateData);
    u2.SubPowerEquipped:Connect(function(p10, p11, p12) -- Line: 77
        -- upvalues: u6 (copy), ComputeWeight (copy)
        local v13 = u6.UnlockedSubPowers:get();
        local v14 = {};

        for i, _ in p11 do
            v14[i] = v13[i];
        end;

        u6.EquippedSubPowers:set(v14);
        u6.CurrentWeight:set((ComputeWeight()));
    end);
    u2.SubPowerUnlocked:Connect(function(p15, p16, p17) -- Line: 89
        -- upvalues: u6 (copy), ComputeWeight (copy)
        u6.UnlockedSubPowers:set(p16);
        u6.CurrentWeight:set((ComputeWeight()));
    end);
    u2.SubPowerUpdated:Connect(function(p18, p19) -- Line: 94
        -- upvalues: u6 (copy)
        local u20 = u6.UnlockedSubPowers:get();
        u20[p18] = p19;
        u6.UnlockedSubPowers:set(u20);
        task.defer(function() -- Line: 100
            -- upvalues: u6 (ref), u20 (copy)
            local v21 = {};

            for i, _ in u6.EquippedSubPowers:get() do
                v21[i] = u20[i];
            end;

            u6.EquippedSubPowers:set(v21);
        end);
    end);
    UpdateData();

    local function CreateEntry(p22, p23) -- Line: 118
        -- upvalues: PowerEntry (copy), SubPowers (copy), Fusion (copy)
        local v24 = PowerEntry:Clone();
        local Holder = v24.Holder;
        Holder.Title.Text = p22;
        Holder.Visible = true;
        local v25 = SubPowers[p22].Weight or 3;
        local Stats = Holder.Stats;
        local Points = Stats.Points;
        local Stage = Stats.Stage;
        local Points2 = p23.Points;
        Stats.Weight.Text = v25;
        Points.Text = string.format("%.2f / %s", Points2.Amount, Points2.Cap);
        Stage.Text = p23.Stage or 1;
        local u26 = Fusion.Value(0.8);
        Fusion.Hydrate(Holder)({
            BackgroundTransparency = Fusion.Spring(u26, 25, 0.9),

            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 143
                -- upvalues: u26 (copy)
                u26:set(0.5);
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 147
                -- upvalues: u26 (copy)
                u26:set(0.8);
            end
        });
        v24.LayoutOrder = v25;

        return v24;
    end;

    local v31 = Fusion.ForPairs(u6.EquippedSubPowers, function(u27, p28) -- Line: 156
        -- upvalues: SubPowers (copy), CreateEntry (copy), Fusion (copy), u2 (copy)
        if not (p28 and SubPowers[u27]) then
            warn("no data found for", u27);

            return u27, nil;
        end;

        local v29 = CreateEntry(u27, p28);
        v29.Holder.UIStroke.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 108, 221));

        return u27, Fusion.Hydrate(v29)({
            Name = u27,
            Visible = true,

            [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 171
                -- upvalues: u2 (ref), u27 (copy)
                u2:UnequipSubPower(u27):andThen(function(p30) -- Line: 173
                    local _ = typeof(p30) == "string";
                end);
            end
        });
    end, Fusion.cleanup);
    local v36 = Fusion.ForPairs(u6.UnlockedSubPowers, function(u32, p33) -- Line: 185
        -- upvalues: SubPowers (copy), CreateEntry (copy), Fusion (copy), Equipped (copy), u2 (copy)
        if p33 and SubPowers[u32] then
            local v34 = CreateEntry(u32, p33);

            return u32, Fusion.Hydrate(v34)({
                Name = u32,
                Visible = true,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 197
                    -- upvalues: Equipped (ref), u32 (copy), u2 (ref)
                    if Equipped:FindFirstChild(u32) then
                        print("already equipped");

                        return;
                    end;

                    u2:EquipSubPower(u32):andThen(function(p35) -- Line: 203
                        local _ = typeof(p35) == "string";
                    end);
                end
            });
        end;

        warn("no data found for", u32);

        return u32, nil;
    end, Fusion.cleanup);
    Fusion.Hydrate(Weight.Bar)({
        Size = Fusion.Tween(Fusion.Computed(function() -- Line: 213
            -- upvalues: u6 (copy)
            local v37 = u6.CurrentWeight:get() / u6.MaxWeight:get();
            local v38 = math.clamp(v37, 0, 1);

            return UDim2.fromScale(v38, 1);
        end), v3),
        BackgroundColor3 = Fusion.Tween(Fusion.Computed(function() -- Line: 217
            -- upvalues: u6 (copy), u4 (copy), u5 (copy)
            local v39 = u6.CurrentWeight:get() / u6.MaxWeight:get();

            return u4:Lerp(u5, (math.clamp(v39, 0, 1)));
        end), v3)
    });
    Fusion.Hydrate(Weight.Max)({
        Text = Fusion.Computed(function() -- Line: 223
            -- upvalues: u6 (copy)
            local v40 = u6.MaxWeight:get();

            return math.ceil(v40);
        end)
    });
    Fusion.Hydrate(Weight.Current)({
        Text = Fusion.Computed(function() -- Line: 228
            -- upvalues: u6 (copy)
            local v41 = u6.CurrentWeight:get();

            return math.ceil(v41);
        end),
        TextColor3 = Fusion.Tween(Fusion.Computed(function() -- Line: 231
            -- upvalues: u6 (copy), u4 (copy), u5 (copy)
            local v42 = u6.CurrentWeight:get() / u6.MaxWeight:get();

            return u4:Lerp(u5, (math.clamp(v42, 0, 1)));
        end), v3)
    });
    Fusion.Hydrate(Equipped)({
        [Fusion.Children] = { v31 }
    });
    Fusion.Hydrate(Unlocked)({
        [Fusion.Children] = { v36 }
    });
end;