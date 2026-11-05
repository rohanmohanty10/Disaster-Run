  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 10
    -- upvalues: ReplicatedStorage (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);

    if Core.Flags.DisableLab then
        return;
    end;

    Core.OnStart():await();
    u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("ShopService");
    local u2 = Core.GetClientService("LabService");
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Rewards = Parent.Rewards;
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(PathShortcuts.KnitPath.Trove);
    local ReputationInfo = require(ReplicatedStorage.ReplicatedModules.PVEPackage.LabData.ReputationInfo);
    local u3 = Fusion.Value(1);
    local u4 = Fusion.Value(0);
    local u5 = Fusion.Value({});

    local function FormatRewards(p6) -- Line: 37
        -- upvalues: ItemData (copy), u1 (copy)
        return string.gsub(p6, "{(.-)}", function(p7) -- Line: 38
            -- upvalues: ItemData (ref), u1 (ref)
            if not string.find(p7, "TITLE_") then
                local v8 = ItemData.GetItemInfo(p7);

                if v8 then
                    v8 = v8.Type;
                end;

                return `<b>{u1:GetItemText(p7) or p7}</b>` .. ` <i>({v8 or "?"})</i>`;
            end;

            local v9 = ItemData.GetTitle(p7);

            if not v9 then
                return p7 .. " <i>(Title)</i>";
            end;

            local Font = v9.Font;

            return `<b><font color="#{v9.Color and (v9.Color:ToHex() or "FFFFFF") or "FFFFFF"}" {not Font and "" or `face="{Font.Name}"`}>{v9.Name}</font></b>` .. " <i>(Title)</i>";
        end);
    end;

    local function CreateReward(p10) -- Line: 60
        -- upvalues: ReputationInfo (copy), Assets (copy), ItemData (copy), u1 (copy)
        local v11 = ReputationInfo.Ranks[p10];

        if not v11 then
            warn("No rank for", p10);

            return nil;
        end;

        local v12 = Assets.Reward:Clone();
        v12.Title.Text = v11;
        local v13 = ReputationInfo.RankRewards[p10] or {};
        local v14 = "";

        for i = 1, #v13 do
            v14 = v14 .. `- {v13[i]}\n`;
        end;

        v12.Info.Text = string.gsub(v14, "{(.-)}", function(p15) -- Line: 38
            -- upvalues: ItemData (ref), u1 (ref)
            if not string.find(p15, "TITLE_") then
                local v16 = ItemData.GetItemInfo(p15);

                if v16 then
                    v16 = v16.Type;
                end;

                return `<b>{u1:GetItemText(p15) or p15}</b>` .. ` <i>({v16 or "?"})</i>`;
            end;

            local v17 = ItemData.GetTitle(p15);

            if not v17 then
                return p15 .. " <i>(Title)</i>";
            end;

            local Font = v17.Font;

            return `<b><font color="#{v17.Color and (v17.Color:ToHex() or "FFFFFF") or "FFFFFF"}" {not Font and "" or `face="{Font.Name}"`}>{v17.Name}</font></b>` .. " <i>(Title)</i>";
        end);
        v12.LayoutOrder = p10;
        v12.Title.TextColor3 = ReputationInfo.RankColors[p10] or Color3.fromRGB(255, 182, 133);

        if ReputationInfo.Ranks[p10 + 1] then
            v12.Bar.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, ReputationInfo.RankColors[p10]), ColorSequenceKeypoint.new(1, ReputationInfo.RankColors[p10 + 1]) });
            v12.Bar.Ball.BackgroundColor3 = ReputationInfo.RankColors[p10 + 1];

            return v12;
        end;

        v12.Bar.UIGradient.Color = ColorSequence.new(ReputationInfo.RankColors[p10]);
        v12.Bar.Ball.BackgroundColor3 = ReputationInfo.RankColors[p10];

        return v12;
    end;

    local function UpdateInfo(p18) -- Line: 92
        -- upvalues: u3 (copy), u4 (copy)
        if typeof(p18) == "table" then
            u3:set(p18.Rank);
            u4:set(p18.Amount);
        end;
    end;

    local function UpdateClaimed() -- Line: 99
        -- upvalues: u2 (copy), u5 (copy)
        local v19 = u2:GetClaimedRewards():expect();

        if typeof(v19) == "table" then
            u5:set(v19);
        end;
    end;

    local function ClaimReward(p20) -- Line: 106
        -- upvalues: u2 (copy), u1 (copy), u5 (copy)
        local v21 = u2:ClaimRankReward(p20):expect();

        if v21 == true then
            u1:PlaySound("xp_gain");
        end;

        print(v21);
        local v22 = u2:GetClaimedRewards():expect();

        if typeof(v22) == "table" then
            u5:set(v22);
        end;
    end;

    Fusion.Hydrate(Rewards)({
        [Fusion.Children] = Fusion.ForPairs(ReputationInfo.Ranks, function(u23, u24) -- Line: 119
            -- upvalues: CreateReward (copy), Fusion (copy), u5 (copy), u1 (copy), u2 (copy), u3 (copy)
            local v25 = CreateReward(u23);
            v25.Visible = true;
            local u26 = UDim2.fromScale(1, 0.225);
            local u27 = Fusion.Value(false);
            local v28 = Fusion.Computed(function() -- Line: 125
                -- upvalues: u27 (copy), u26 (copy)
                if u27:get() then
                    return u26 + UDim2.fromScale(0, 0.025);
                end;

                return u26;
            end);
            local u29 = Fusion.Computed(function() -- Line: 129
                -- upvalues: u5 (ref), u24 (copy)
                return u5:get()[u24];
            end);
            Fusion.Hydrate(v25)({
                Size = Fusion.Spring(v28, 15, 0.95),

                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 138
                    -- upvalues: u1 (ref), u27 (copy)
                    u1:PlaySound("hover3");
                    u27:set(true);
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 142
                    -- upvalues: u27 (copy)
                    u27:set(false);
                end,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 145
                    -- upvalues: u23 (copy), u2 (ref), u1 (ref), u5 (ref)
                    local v30 = u2:ClaimRankReward(u23):expect();

                    if v30 == true then
                        u1:PlaySound("xp_gain");
                    end;

                    print(v30);
                    local v31 = u2:GetClaimedRewards():expect();

                    if typeof(v31) == "table" then
                        u5:set(v31);
                    end;
                end
            });
            Fusion.Hydrate(v25.BG)({
                Visible = Fusion.Computed(function() -- Line: 153
                    -- upvalues: u3 (ref), u23 (copy), u29 (copy)
                    local v32 = u3:get();
                    local v33;

                    if v32 < u23 then
                        v33 = true;
                    elseif u23 <= v32 then
                        v33 = not u29:get();
                    else
                        v33 = false;
                    end;

                    return v33;
                end),
                ZIndex = Fusion.Computed(function() -- Line: 157
                    -- upvalues: u3 (ref), u23 (copy), u29 (copy)
                    local v34 = u3:get();

                    return v34 < u23 and 1 or (u23 <= v34 and not u29:get() and -1 or 1);
                end),
                BackgroundColor3 = Fusion.Computed(function() -- Line: 161
                    -- upvalues: u3 (ref), u23 (copy), u29 (copy)
                    local v35 = u3:get();

                    if v35 < u23 then
                        return Color3.new();
                    end;

                    if u23 <= v35 and not u29:get() then
                        return Color3.fromRGB(54, 199, 66);
                    end;

                    return Color3.new();
                end),
                BackgroundTransparency = Fusion.Computed(function() -- Line: 165
                    -- upvalues: u3 (ref), u23 (copy), u29 (copy)
                    local v36 = u3:get();

                    return v36 < u23 and 0.25 or (u23 <= v36 and not u29:get() and 0.8 or 0.25);
                end)
            });
            Fusion.Hydrate(v25.BG.TextLabel)({
                Visible = Fusion.Computed(function() -- Line: 172
                    return true;
                end),
                Text = Fusion.Computed(function() -- Line: 176
                    -- upvalues: u3 (ref), u23 (copy), u29 (copy)
                    local v37 = u3:get();

                    return v37 < u23 and "Locked" or (u23 <= v37 and not u29:get() and "Claim" or "Locked");
                end),
                TextTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 180
                    -- upvalues: u3 (ref), u27 (copy)
                    u3:get();

                    return u27:get() and 0 or 1;
                end), 25, 0.8)
            });
            Fusion.Hydrate(v25.Bar)({
                Size = Fusion.Spring(Fusion.Computed(function() -- Line: 187
                    -- upvalues: u3 (ref), u23 (copy)
                    return u23 <= u3:get() and UDim2.fromScale(0.02, 1) or UDim2.fromScale(0.02, 0);
                end), 15, 0.9)
            });
            Fusion.Hydrate(v25.Bar.Ball)({
                Visible = Fusion.Computed(function() -- Line: 194
                    -- upvalues: u3 (ref), u23 (copy)
                    return u23 <= u3:get();
                end)
            });

            return u23, v25;
        end, Fusion.cleanup)
    });
    Fusion.Hydrate(Parent.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 213, Name: Hide
            -- upvalues: Parent (copy), u1 (copy)
            if not Parent.Visible then
                return;
            end;

            Parent.Visible = false;
            u1:PlaySound("Click");
            u1:ShowReputationProgress(-1);
        end
    });
    u2.ShowRankRewards:Connect(function() -- Line: 205, Name: Show
        -- upvalues: Parent (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        Parent.Visible = true;
        u1:ShowReputationProgress(1);
    end);
    u2.ReputationUpdated:Connect(function(p38) -- Line: 227
        -- upvalues: u3 (copy), u4 (copy)
        if typeof(p38) == "table" then
            u3:set(p38.Rank);
            u4:set(p38.Amount);
        end;
    end);
    local v39 = u2:GetReputationInfo():expect();

    if typeof(v39) == "table" then
        u3:set(v39.Rank);
        u4:set(v39.Amount);
    end;

    local v40 = u2:GetClaimedRewards():expect();

    if typeof(v40) == "table" then
        u5:set(v40);
    end;
end;