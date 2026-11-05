  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 15
    -- upvalues: ReplicatedStorage (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local u2 = u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("ShopService");
    local u3 = Core.GetClientService("LabService");
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Refining = Parent.Refining;
    local Info = Parent.Info;
    local Actions = Parent.Actions;
    local _ = Info.Requirements;
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(PathShortcuts.KnitPath.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local ReputationInfo = require(ReplicatedStorage.ReplicatedModules.PVEPackage.LabData.ReputationInfo);
    local ResearchData = ReputationInfo.ResearchData;
    local RefiningData = ReputationInfo.RefiningData;
    local u4 = Fusion.Value({});
    local u5 = Fusion.Value({});
    local u6 = Fusion.Value(nil);
    local u7 = Fusion.Value(nil);
    local u8 = Fusion.Value("All");
    local u9 = Color3.fromRGB(255, 106, 106);
    local u10 = Color3.fromRGB(138, 255, 138);
    local u11 = {};

    local function CreateRequirementEntry(p12, p13, p14) -- Line: 74
        -- upvalues: u1 (copy), Assets (copy)
        local v15 = u1:GetItemText(p12);

        if v15 then
            local v16 = `<font color="{p14 <= p13 and "#82ff4c" or "#ff4040"}">{p13}</font> / {p14}`;
            local v17 = Assets.RequirementEntry:Clone();
            v17.NameLabel.Text = v15;
            v17.AmountLabel.Text = v16;
            v17.Visible = true;

            return v17;
        end;
    end;

    local function FormatProjectText(p18) -- Line: 91
        -- upvalues: u1 (copy)
        return string.gsub(p18, "{.+}", function(p19) -- Line: 92
            -- upvalues: u1 (ref)
            local v20 = string.sub(p19, 2, #p19 - 1);

            return `<b>{u1:GetItemText(v20) or v20}</b>`;
        end);
    end;

    local function UpdateResearched() -- Line: 100
        -- upvalues: u3 (copy), u5 (copy)
        u5:set((u3:GetUnlockedResearch():expect()));
    end;

    local function UpdateCounts() -- Line: 105
        -- upvalues: u2 (copy), u4 (copy)
        local v21 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v21) == "table" then
            u4:set(v21);
        end;
    end;

    local function Show() -- Line: 127
        -- upvalues: Parent (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy)
        if Parent.Visible then
            return;
        end;

        u5:set((u3:GetUnlockedResearch():expect()));
        local v22 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v22) == "table" then
            u4:set(v22);
        end;

        Parent.Visible = true;
    end;

    local function CreateItemEntry(p23) -- Line: 54
        -- upvalues: u11 (copy), Assets (copy), ItemData (copy)
        local v24 = u11[p23];

        if v24 then
            local v25 = Assets.Item:Clone();
            local v26 = ItemData.GetRarityData(v24.Rarity or 0);
            v25.NameLabel.Text = v24.Name or p23;
            v25.Name = v24.Name or p23;
            v25.Holder.Image.ImageColor3 = v26.Color;
            v25.Holder.BackgroundColor3 = v26.Color;
            v25.Holder.UIStroke.Color = v26.Color;
            v25.Visible = true;

            return v25;
        end;
    end;

    local function AttempFabricate() -- Line: 112
        -- upvalues: u6 (copy), u3 (copy), u2 (copy), u4 (copy), u1 (copy)
        local v27 = u6:get();

        if not v27 then
            return;
        end;

        local v28 = u3:AttemptFabricate(v27):expect();
        print(v28);

        if v28 == true then
            local v29 = u2:GetItemCounts("ItemInventory"):expect();

            if typeof(v29) == "table" then
                u4:set(v29);
            end;

            u1:PlaySound("Lab/RefineSuccess");
        end;
    end;

    local function Hide() -- Line: 136
        -- upvalues: Parent (copy), u6 (copy), u1 (copy)
        if not Parent.Visible then
            return;
        end;

        Parent.Visible = false;
        u6:set(nil);
        u1:PlaySound("Click");
    end;

    for i in RefiningData do
        local v30 = ItemData.GetItemInfo(i);

        if v30 then
            u11[i] = v30;
        end;
    end;

    Fusion.Hydrate(Refining)({
        [Fusion.Children] = Fusion.ForPairs(RefiningData, function(u31, u32) -- Line: 156
            -- upvalues: CreateItemEntry (copy), Fusion (copy), u5 (copy), u7 (copy), u8 (copy), u11 (copy), u6 (copy)
            local u33 = CreateItemEntry(u31);

            if not u33 then
                warn("No item data found for", u31);

                return u31, nil;
            end;

            local u34 = Fusion.Value(UDim2.fromScale(0.9, 0.9));
            local u35 = string.lower(string.sub(u33.Name, 1, 1) or "z");
            local u37 = Fusion.Computed(function() -- Line: 167
                -- upvalues: u32 (copy), u5 (ref)
                if not u32.Dependencies or #u32.Dependencies < 1 then
                    return true;
                end;

                local v36 = u5:get();

                for i = 1, #u32.Dependencies do
                    if not v36[u32.Dependencies[i]] then
                        return false;
                    end;
                end;

                return true;
            end);
            local v42 = Fusion.Computed(function() -- Line: 183
                -- upvalues: u7 (ref), u8 (ref), u37 (copy), u33 (copy)
                local v38 = u7:get();
                local v39 = u8:get();
                local v40 = true;

                if v39 ~= "All" then
                    local v41 = u37:get();

                    if v39 == "Unlocked" then
                        v40 = v41;
                    elseif v39 == "Locked" then
                        v40 = not v41;
                    end;
                end;

                if v38 and not string.find(string.lower(u33.Name), string.lower(v38)) then
                    v40 = false;
                end;

                return v40;
            end);
            local u43 = u11[u31].Rarity or 1;
            Fusion.Hydrate(u33)({
                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 210
                    -- upvalues: u34 (copy)
                    u34:set(UDim2.fromScale(0.95, 0.95));
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 213
                    -- upvalues: u34 (copy)
                    u34:set(UDim2.fromScale(0.9, 0.9));
                end,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 216
                    -- upvalues: u6 (ref), u31 (copy)
                    u6:set(u31);
                end,

                LayoutOrder = Fusion.Computed(function() -- Line: 220
                    -- upvalues: u37 (copy), u35 (copy), u43 (copy)
                    return (u37:get() and 1 or 10000) + string.byte(u35) - u43 * 100;
                end),
                Visible = v42
            });
            Fusion.Hydrate(u33.Holder)({
                Size = Fusion.Spring(u34, 30, 0.75)
            });
            Fusion.Hydrate(u33.Darken)({
                Visible = Fusion.Computed(function() -- Line: 232
                    -- upvalues: u37 (copy)
                    return not u37:get();
                end)
            });

            return u31, u33;
        end, Fusion.cleanup)
    });
    Fusion.Hydrate(Actions.Search)({
        [Fusion.OnChange("Text")] = function() -- Line: 243
            -- upvalues: Actions (copy), u7 (copy)
            local Text = Actions.Search.Text;

            if #Text > 0 then
                u7:set(Text);

                return;
            end;

            u7:set(nil);
        end
    });

    for _, child in Actions.Filter:GetChildren() do
        if child:IsA("GuiButton") then
            Fusion.Hydrate(child)({
                Size = Fusion.Spring(Fusion.Computed(function() -- Line: 262
                    -- upvalues: u8 (copy), child (copy)
                    return u8:get() == child.Name and UDim2.fromScale(0.5, 1) or UDim2.fromScale(0.3, 1);
                end), 27.5, 0.75),
                BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 266
                    -- upvalues: u8 (copy), child (copy)
                    return u8:get() == child.Name and Color3.fromRGB(23, 23, 23) or Color3.fromRGB(50, 50, 50);
                end), 27.5, 0.75),

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 270
                    -- upvalues: u8 (copy), child (copy)
                    u8:set(child.Name);
                end
            });
        end;
    end;

    local u47 = Fusion.Computed(function() -- Line: 277
        -- upvalues: u6 (copy), RefiningData (copy), u5 (copy)
        local v44 = u6:get();

        if not v44 then
            return false;
        end;

        local v45 = RefiningData[v44];

        if not v45 then
            return false;
        end;

        if not v45.Dependencies or #v45.Dependencies < 1 then
            return true;
        end;

        local v46 = u5:get();

        for i = 1, #v45.Dependencies do
            if not v46[v45.Dependencies[i]] then
                return false;
            end;
        end;

        return true;
    end);
    Fusion.Hydrate(Info.NameLabel)({
        Text = Fusion.Computed(function() -- Line: 302
            -- upvalues: u6 (copy), u11 (copy)
            local v48 = u6:get();

            return not v48 and "None" or (u11[v48].Name or v48);
        end),
        TextColor3 = Fusion.Computed(function() -- Line: 309
            -- upvalues: u6 (copy), u11 (copy), ItemData (copy)
            local v49 = u6:get();

            if v49 then
                return ItemData.GetRarityData(u11[v49].Rarity or 1).Color;
            end;

            return Color3.new(1, 1, 1);
        end)
    });
    Fusion.Hydrate(Info.DescriptionLabel)({
        Text = Fusion.Computed(function() -- Line: 319
            -- upvalues: u6 (copy), u11 (copy), u1 (copy)
            local v50 = u6:get();

            if not v50 then
                return "";
            end;

            local v51 = u11[v50];

            return v51.Description and string.gsub(v51.Description, "{.+}", function(p52) -- Line: 92
                -- upvalues: u1 (ref)
                local v53 = string.sub(p52, 2, #p52 - 1);

                return `<b>{u1:GetItemText(v53) or v53}</b>`;
            end) or "";
        end)
    });
    Fusion.Hydrate(Info.DependencyLabel)({
        Visible = Fusion.Computed(function() -- Line: 328
            -- upvalues: u6 (copy), u47 (copy)
            local v54 = u6:get();
            local v55 = u47:get();

            if v54 then
                v54 = not v55;
            end;

            return v54;
        end),
        Text = Fusion.Computed(function() -- Line: 334
            -- upvalues: u6 (copy), RefiningData (copy), u5 (copy), ResearchData (copy), u10 (copy), u9 (copy)
            local v56 = RefiningData[u6:get()];
            local v57 = v56 and v56.Dependencies and #v56.Dependencies or 0;

            if v57 < 1 then
                return "";
            end;

            local v58 = u5:get();
            local v59 = "REQUIRES RESEARCH:<br />[";

            for i = 1, v57 do
                local v60 = ResearchData[v56.Dependencies[i]];
                local v61;

                if v58[v56.Dependencies[i]] then
                    v61 = u10;
                else
                    v61 = u9;
                end;

                v59 = v59 .. `<b><font color="#{v61:ToHex()}">{v60.DisplayName or "???"}</font></b>{i == v57 and "]" or ", "}`;
            end;

            return v59;
        end),
        Interactable = Fusion.Computed(function() -- Line: 355
            -- upvalues: u47 (copy)
            return not u47:get();
        end)
    });
    Fusion.Hydrate(Info.Fabricate)({
        Visible = Fusion.Computed(function() -- Line: 362
            -- upvalues: u47 (copy)
            return u47:get();
        end),
        [Fusion.OnEvent("MouseButton1Click")] = AttempFabricate
    });
    Fusion.Hydrate(Info.Requirements)({
        Visible = Fusion.Computed(function() -- Line: 368
            -- upvalues: u6 (copy)
            return u6:get() ~= nil;
        end),
        [Fusion.Children] = Fusion.Computed(function() -- Line: 372
            -- upvalues: u6 (copy), RefiningData (copy), u4 (copy), Fusion (copy), u1 (copy), Assets (copy)
            local v62 = RefiningData[u6:get()];

            if v62 and v62.Requirements then
                local u63 = u4:get();

                return Fusion.ForPairs(v62.Requirements, function(p64, p65) -- Line: 380
                    -- upvalues: u63 (copy), u1 (ref), Assets (ref)
                    local v66 = u63[p64] or 0;
                    local v67 = u1:GetItemText(p64);
                    local v68;

                    if v67 then
                        local v69 = `<font color="{p65 <= v66 and "#82ff4c" or "#ff4040"}">{v66}</font> / {p65}`;
                        v68 = Assets.RequirementEntry:Clone();
                        v68.NameLabel.Text = v67;
                        v68.AmountLabel.Text = v69;
                        v68.Visible = true;
                    else
                        v68 = nil;
                    end;

                    return p64, v68;
                end, Fusion.cleanup);
            end;
        end)
    });
    Fusion.Hydrate(Parent.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = Hide
    });

    function u1.ShowLabRefining(p70) -- Line: 391
        -- upvalues: Parent (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy)
        if Parent.Visible then
            return;
        end;

        u5:set((u3:GetUnlockedResearch():expect()));
        local v71 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v71) == "table" then
            u4:set(v71);
        end;

        Parent.Visible = true;
    end;

    u2.ItemAdded:Connect(function(p72, p73) -- Line: 395
        -- upvalues: Parent (copy), u2 (copy), u4 (copy)
        if p73 ~= "ItemInventory" then
            return;
        end;

        if not Parent.Visible then
            return;
        end;

        u2:GetItemCounts(p73):expect();
        local v74 = u2:GetItemCounts("ItemInventory"):expect();

        if typeof(v74) == "table" then
            u4:set(v74);
        end;
    end);
end;