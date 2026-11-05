  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 20
    -- upvalues: ReplicatedStorage (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);

    if Core.Flags.DisableLab then
        return;
    end;

    Core.OnStart():await();
    local u2 = u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("ShopService");
    local u3 = Core.GetClientService("LabService");
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Research = Parent.Research;
    local Info = Parent.Info;
    local _ = Info.Requirements;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(PathShortcuts.KnitPath.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local ReputationInfo = require(ReplicatedStorage.ReplicatedModules.PVEPackage.LabData.ReputationInfo);
    local ResearchData = ReputationInfo.ResearchData;
    local u4 = Fusion.Value({});
    local u5 = Fusion.Value({});
    local u6 = Fusion.Value(nil);
    local u7 = Fusion.Value(1);
    local u8 = Color3.fromRGB(255, 106, 106);
    local u9 = Color3.fromRGB(138, 255, 138);

    local function CreateRankSection(p10) -- Line: 61
        -- upvalues: ReputationInfo (copy), Assets (copy)
        local v11 = ReputationInfo.Ranks[p10];

        if v11 then
            local v12 = Assets.RankEntry:Clone();
            v12.Name = v11;
            v12.LayoutOrder = p10;
            v12.Rank.Text = v11;
            v12.Rank.TextColor3 = ReputationInfo.RankColors[p10];
            v12.Bar.BackgroundColor3 = ReputationInfo.RankColors[p10];

            return v12;
        end;
    end;

    local function CreateResearchEntry(p13) -- Line: 76
        -- upvalues: ResearchData (copy), Assets (copy)
        local v14 = ResearchData[p13];

        if v14 then
            local v15 = Assets.ResearchProject:Clone();
            v15.NameLabel.Text = v14.DisplayName or p13;
            v15.Visible = true;

            return v15;
        end;
    end;

    local function CreateRequirementEntry(p16, p17, p18) -- Line: 90
        -- upvalues: u1 (copy), Assets (copy)
        local v19 = u1:GetItemText(p16);

        if v19 then
            local v20 = `<font color="{p18 <= p17 and "#82ff4c" or "#ff4040"}">{p17}</font> / {p18}`;
            local v21 = Assets.RequirementEntry:Clone();
            v21.NameLabel.Text = v19;
            v21.AmountLabel.Text = v20;
            v21.Visible = true;

            return v21;
        end;
    end;

    local function FormatProjectText(p22) -- Line: 107
        -- upvalues: u1 (copy)
        return string.gsub(p22, "{(.-)}", function(p23) -- Line: 108
            -- upvalues: u1 (ref)
            return `<b>{u1:GetItemText(p23) or p23}</b>`;
        end);
    end;

    local function UpdateResearched() -- Line: 116
        -- upvalues: u3 (copy), u5 (copy)
        u5:set((u3:GetUnlockedResearch():expect()));
    end;

    local function UpdateCounts() -- Line: 121
        -- upvalues: u2 (copy), u4 (copy)
        local v24 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v24) == "table" then
            u4:set(v24);
        end;
    end;

    local function UpdateInfo(p25) -- Line: 128
        -- upvalues: u7 (copy)
        if typeof(p25) == "table" then
            u7:set(p25.Rank);
        end;
    end;

    local function Show() -- Line: 149
        -- upvalues: Parent (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        u5:set((u3:GetUnlockedResearch():expect()));
        local v26 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v26) == "table" then
            u4:set(v26);
        end;

        Parent.Visible = true;
        u1:ShowReputationProgress(1);
    end;

    local v27 = {};

    local function Hide() -- Line: 160
        -- upvalues: Parent (copy), u6 (copy), u1 (copy)
        if not Parent.Visible then
            return;
        end;

        Parent.Visible = false;
        u6:set(nil);
        u1:PlaySound("Click");
        u1:ShowReputationProgress(-1);
    end;

    local function AttempResearch() -- Line: 134
        -- upvalues: u6 (copy), u3 (copy), u2 (copy), u4 (copy), u5 (copy)
        local v28 = u6:get();

        if not v28 then
            return;
        end;

        local v29 = u3:AttemptResearch(v28):expect();
        print(v29);
        local _ = v29 == true;
        local v30 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v30) == "table" then
            u4:set(v30);
        end;

        u5:set((u3:GetUnlockedResearch():expect()));
    end;

    for i, v in ResearchData do
        if v.Rank then
            local v31 = v27[v.Rank];

            if v31 then
                table.insert(v31[2], i);
            else
                local Rank = v.Rank;
                local v32 = ReputationInfo.Ranks[Rank];
                local v33;

                if v32 then
                    v33 = Assets.RankEntry:Clone();
                    v33.Name = v32;
                    v33.LayoutOrder = Rank;
                    v33.Rank.Text = v32;
                    v33.Rank.TextColor3 = ReputationInfo.RankColors[Rank];
                    v33.Bar.BackgroundColor3 = ReputationInfo.RankColors[Rank];
                else
                    v33 = nil;
                end;

                v33.Parent = Research;
                v33.Visible = true;
                v27[v.Rank] = {
                    v33,
                    { i }
                };
            end;
        end;
    end;

    for i, v in v27 do
        local u34 = v[1];
        local v35 = v[2];
        task.delay(2, function() -- Line: 193
            -- upvalues: u7 (copy), i (copy), u34 (copy)
            if u7:get() < i then
                u34.Items.Visible = false;
            end;
        end);
        Fusion.Hydrate(u34.Items)({
            [Fusion.Children] = Fusion.ForValues(v35, function(u36) -- Line: 200
                -- upvalues: ResearchData (copy), Assets (copy), Fusion (copy), u5 (copy), u6 (copy), u9 (copy), u8 (copy)
                local _ = ResearchData[u36];
                local v37 = ResearchData[u36];
                local v38;

                if v37 then
                    v38 = Assets.ResearchProject:Clone();
                    v38.NameLabel.Text = v37.DisplayName or u36;
                    v38.Visible = true;
                else
                    v38 = nil;
                end;

                local u39 = Fusion.Value(UDim2.fromScale(0.9, 0.9));
                local u40 = Fusion.Computed(function() -- Line: 206
                    -- upvalues: u5 (ref), u36 (copy)
                    return u5:get()[u36] ~= nil;
                end);
                Fusion.Hydrate(v38)({
                    [Fusion.OnEvent("MouseEnter")] = function() -- Line: 212
                        -- upvalues: u39 (copy)
                        u39:set(UDim2.fromScale(0.95, 0.95));
                    end,

                    [Fusion.OnEvent("MouseLeave")] = function() -- Line: 215
                        -- upvalues: u39 (copy)
                        u39:set(UDim2.fromScale(0.9, 0.9));
                    end,

                    [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 218
                        -- upvalues: u6 (ref), u36 (copy)
                        u6:set(u36);
                    end,

                    LayoutOrder = Fusion.Computed(function() -- Line: 222
                        -- upvalues: u40 (copy)
                        return u40:get() and 10 or 1;
                    end)
                });
                Fusion.Hydrate(v38.Holder)({
                    BackgroundColor3 = Fusion.Computed(function() -- Line: 228
                        -- upvalues: u40 (copy), u9 (ref), u8 (ref)
                        return u40:get() and u9 or u8;
                    end)
                });
                Fusion.Hydrate(v38.Holder.UIStroke)({
                    Color = Fusion.Computed(function() -- Line: 234
                        -- upvalues: u40 (copy), u9 (ref), u8 (ref)
                        return u40:get() and u9 or u8;
                    end)
                });
                Fusion.Hydrate(v38.Holder.Image)({
                    ImageColor3 = Fusion.Computed(function() -- Line: 240
                        -- upvalues: u40 (copy), u9 (ref), u8 (ref)
                        return u40:get() and u9 or u8;
                    end)
                });
                Fusion.Hydrate(v38.Holder)({
                    Size = Fusion.Spring(u39, 30, 0.75)
                });

                return v38;
            end, Fusion.cleanup)
        });
        Fusion.Hydrate(u34.Rank)({
            [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 254
                -- upvalues: u34 (copy)
                u34.Items.Visible = not u34.Items.Visible;
            end
        });
        Fusion.Hydrate(u34.LockFrame)({
            Visible = Fusion.Computed(function() -- Line: 260
                -- upvalues: u7 (copy), i (copy)
                return u7:get() < i;
            end)
        });
    end;

    local u43 = Fusion.Computed(function() -- Line: 267
        -- upvalues: u6 (copy), u5 (copy)
        local v41 = u6:get();

        if not v41 then
            return false;
        end;

        local v42 = u5:get();

        return v42 and v42[v41] and true or false;
    end);
    Fusion.Hydrate(Info.NameLabel)({
        Text = Fusion.Computed(function() -- Line: 280
            -- upvalues: u6 (copy), ResearchData (copy)
            local v44 = u6:get();

            return not v44 and "None" or (ResearchData[v44].DisplayName or v44);
        end)
    });
    Fusion.Hydrate(Info.DescriptionLabel)({
        Text = Fusion.Computed(function() -- Line: 289
            -- upvalues: u6 (copy), ResearchData (copy), u1 (copy)
            local v45 = u6:get();

            if not v45 then
                return "";
            end;

            local v46 = ResearchData[v45];

            return v46.Description and string.gsub(v46.Description, "{(.-)}", function(p47) -- Line: 108
                -- upvalues: u1 (ref)
                return `<b>{u1:GetItemText(p47) or p47}</b>`;
            end) or "";
        end)
    });
    Fusion.Hydrate(Info.Unlock)({
        Visible = Fusion.Computed(function() -- Line: 298
            -- upvalues: u6 (copy), ResearchData (copy)
            local v48 = u6:get();
            local v49 = ResearchData[v48];
            local v50;

            if v48 == nil or v49 == nil then
                v50 = false;
            else
                v50 = v49.Requirements ~= nil;
            end;

            return v50;
        end),
        Text = Fusion.Computed(function() -- Line: 304
            -- upvalues: u43 (copy)
            return u43:get() and "Unlocked" or "Unlock";
        end),
        Interactable = Fusion.Computed(function() -- Line: 308
            -- upvalues: u43 (copy)
            return not u43:get();
        end),
        [Fusion.OnEvent("MouseButton1Click")] = AttempResearch
    });
    Fusion.Hydrate(Info.Requirements)({
        Visible = Fusion.Computed(function() -- Line: 315
            -- upvalues: u43 (copy)
            return not u43:get();
        end),
        [Fusion.Children] = Fusion.Computed(function() -- Line: 319
            -- upvalues: u6 (copy), ResearchData (copy), u4 (copy), Fusion (copy), u1 (copy), Assets (copy)
            local v51 = ResearchData[u6:get()];

            if v51 and v51.Requirements then
                local u52 = u4:get();

                return Fusion.ForPairs(v51.Requirements, function(p53, p54) -- Line: 327
                    -- upvalues: u52 (copy), u1 (ref), Assets (ref)
                    local v55 = u52[p53] or 0;
                    local v56 = u1:GetItemText(p53);
                    local v57;

                    if v56 then
                        local v58 = `<font color="{p54 <= v55 and "#82ff4c" or "#ff4040"}">{v55}</font> / {p54}`;
                        v57 = Assets.RequirementEntry:Clone();
                        v57.NameLabel.Text = v56;
                        v57.AmountLabel.Text = v58;
                        v57.Visible = true;
                    else
                        v57 = nil;
                    end;

                    return p53, v57;
                end, Fusion.cleanup);
            end;
        end)
    });
    Fusion.Hydrate(Parent.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = Hide
    });

    function u1.ShowLabResearch(p59) -- Line: 337
        -- upvalues: Parent (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy), u1 (copy)
        if Parent.Visible then
            return;
        end;

        u5:set((u3:GetUnlockedResearch():expect()));
        local v60 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v60) == "table" then
            u4:set(v60);
        end;

        Parent.Visible = true;
        u1:ShowReputationProgress(1);
    end;

    u3.ReputationUpdated:Connect(function(p61) -- Line: 341
        -- upvalues: u7 (copy)
        if typeof(p61) == "table" then
            u7:set(p61.Rank);
        end;
    end);
    local v62 = u3:GetReputationInfo():expect();

    if typeof(v62) == "table" then
        u7:set(v62.Rank);
    end;
end;