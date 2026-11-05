  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local u1 = Knit.GetService("InventoryService");
local Stack = require(PathShortcuts.ReplicatedModules.Classes.Stack);
local Promise = require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("LevelService");
Knit.GetService("StatService");
local PVEPackage = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("PVEPackage");
local LevelingInfo = require(PVEPackage:WaitForChild("LevelingInfo"));
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5) -- Line: 18
    -- upvalues: u3 (copy), Trove (copy)
    local u6 = setmetatable({}, u3);
    u6.UI = p4;
    u6.UIEngine = p5;
    u6.Trove = Trove.new();
    u6.Assets = p4.Assets;
    u6.Cache = {
        CurrentAbilityId = 0,
        InventorySlots = {},
        SelectedSlots = {}
    };
    u6.ContainerEntry = u6.Assets.Container;
    u6.InfoSection = u6.UI.InfoSection;
    u6.InventorySection = u6.UI.InventorySection;
    u6.LevelSection = u6.UI.LevelSection;
    u6.AutoButton = u6.UI.Auto;
    u6.RemoveButton = u6.UI.RemoveAuto;
    u6.ApplyButton = u6.UI.ApplyButton;
    u6.AbilityName = u6.InfoSection.AbilityName;
    u6.AbilityPrefix = u6.InfoSection.AbilityPrefix;
    u6.AbilityDescription = u6.InfoSection.AbilityDescription;
    u6.ItemSlots = u6.InventorySection.Items;
    u6.SelectedSlots = u6.InventorySection.SelectedItems;
    u6.CurrentLevel = u6.LevelSection.LevelCurrent;
    u6.FutureLevel = u6.LevelSection.LevelFuture;
    u6.TotalXPLabel = u6.LevelSection.TotalLabel;
    u6.ApplyButton.MouseButton1Click:Connect(function() -- Line: 53
        -- upvalues: u6 (copy)
        u6.UIEngine:PlaySound("Click");
        u6.UIEngine.NewPrompt({
            Title = "Consume XP?",
            Delay = 1.5,
            Text = `Are you sure you want to consume XP to level [{u6.AbilityName.Text}]`,
            Options = { "Yes", "No" },

            Callback = function(p7) -- Line: 63, Name: Callback
                -- upvalues: u6 (ref)
                if p7.Choice ~= 1 then
                    return;
                end;

                u6.UIEngine:PlaySound("Click");
                u6:ConsumeXPItems();
            end
        });
    end);
    u6.AutoButton.MouseButton1Click:Connect(function() -- Line: 70
        -- upvalues: u6 (copy)
        u6:AutoAdd();
        u6.UIEngine:PlaySound("Click");
    end);
    u6.RemoveButton.MouseButton1Click:Connect(function() -- Line: 74
        -- upvalues: u6 (copy)
        u6:AutoRemove();
        u6.UIEngine:PlaySound("Click");
    end);

    return u6;
end;

function u3.CreateContainer(p8, p9, p10, p11) -- Line: 81
    local _ = p9._ItemId;
    local v12 = p8.UIEngine.CreateInventorySlot(p10);
    v12.Parent = p11;

    return v12;
end;

function u3.AddSlot(u13, p14, p15, p16, p17) -- Line: 88
    -- upvalues: ItemData (copy), Stack (copy), Trove (copy)
    local _ = p15._UUID;
    local _ItemId = p15._ItemId;
    local v18 = ItemData.GetItemInfo(_ItemId);
    local v19 = p14[_ItemId];

    if not v18 then
        return;
    end;

    if v19 then
        local Stack2 = v19.Stack;
        local _ = v19.Trove;
        Stack2:Push(p15);
        v19.Container.Button.Amount.Text = Stack2:GetAmount();
    else
        local u20 = Stack.new();
        local v21 = Trove.new();
        local u22 = u13:CreateContainer(p15, v18, p16);
        v21:Add(u20);
        v21:Add(u22);
        v21:Connect(u22.Button.MouseButton1Down, function() -- Line: 105
            -- upvalues: u13 (copy), u20 (copy), u22 (copy)
            u13.UIEngine:PlaySound("Click");
            local v23 = u20:Peek();

            if u22.Parent ~= u13.ItemSlots then
                if u22.Parent == u13.SelectedSlots then
                    u13:RemoveSlot(u13.Cache.SelectedSlots, v23);
                    u13:AddSlot(u13.Cache.InventorySlots, v23, u13.ItemSlots);
                end;

                return;
            end;

            u13:RemoveSlot(u13.Cache.InventorySlots, v23);
            u13:AddSlot(u13.Cache.SelectedSlots, v23, u13.SelectedSlots);
        end);
        u20:Push(p15);
        p14[_ItemId] = {
            Container = u22,
            Trove = v21,
            Stack = u20,
            ItemObject = p15,
            ItemInfo = v18
        };
    end;

    if p17 ~= false then
        u13:UpdateLevelInfo();
    end;
end;

function u3.RemoveSlot(p24, p25, p26, p27) -- Line: 137
    -- upvalues: ItemData (copy)
    local _ = p26._UUID;
    local _ItemId = p26._ItemId;
    ItemData.GetItemInfo(_ItemId);
    local v28 = p25[_ItemId];

    if v28 then
        local Stack2 = v28.Stack;
        local Trove2 = v28.Trove;
        local Container = v28.Container;
        Stack2:Pop();
        local v29 = Stack2:GetAmount();

        if v29 <= 0 then
            Trove2:Destroy();
            p25[_ItemId] = nil;
        else
            Container.Button.Amount.Text = v29 > 1 and v29 and v29 or "";
        end;
    end;

    if p27 ~= false then
        p24:UpdateLevelInfo();
    end;
end;

function u3.CleanSlots(p30, p31) -- Line: 162
    for _, v in pairs(p31) do
        v.Trove:Destroy();
    end;

    table.clear(p31);
end;

function u3.ClearSlots(p32) -- Line: 169
    p32:CleanSlots(p32.Cache.InventorySlots);
    p32:CleanSlots(p32.Cache.SelectedSlots);
end;

function u3.AutoAdd(p33) -- Line: 174
    for _, v in pairs(p33.Cache.InventorySlots) do
        local v34 = v.Stack:All();
        local v35 = table.clone(v34);

        for _, v2 in v35 do
            p33:RemoveSlot(p33.Cache.InventorySlots, v2, false);
            p33:AddSlot(p33.Cache.SelectedSlots, v2, p33.SelectedSlots, false);
        end;

        table.clear(v35);
    end;

    p33:UpdateLevelInfo();
end;

function u3.AutoRemove(p36) -- Line: 191
    for _, v in pairs(p36.Cache.SelectedSlots) do
        local v37 = v.Stack:All();
        local v38 = table.clone(v37);

        for _, v2 in v38 do
            p36:RemoveSlot(p36.Cache.SelectedSlots, v2);
            p36:AddSlot(p36.Cache.InventorySlots, v2, p36.ItemSlots, false);
        end;

        table.clear(v38);
    end;

    p36:UpdateLevelInfo();
end;

function u3.SetInfo(p39, p40) -- Line: 208
    p39.AbilityName.Text = p40.AbilityName;
    p39.AbilityPrefix.Text = p40.AbilityPrefix == nil and "Ability" or p40.AbilityPrefix;
    p39.AbilityPrefix.TextColor3 = p40.AbilityPrefixColor;
    p39.AbilityDescription.Text = p40.AbilityDescription;
end;

function u3.ShowLevelInfo(p41, p42, p43) -- Line: 215
    local _ = p43.CurrentLevel;
    local v44 = math.clamp(p43.CurrentXP / p43.RequiredXP, 0, 1);
    p42.Level.Text = p43.CurrentLevel;
    p42.Progress.BarText.Text = `{p43.CurrentXP} / {p43.RequiredXP}`;
    p42.Progress.Bar.Size = UDim2.new(v44, 0, 1, 0);
end;

function u3.UpdateLevelInfo(p45) -- Line: 226
    -- upvalues: LevelingInfo (copy)
    local CurrentLevelInfo = p45.CurrentLevelInfo;
    local v46 = p45:ComputeXPGain(CurrentLevelInfo);
    p45.CurrentLevelInfo = CurrentLevelInfo;

    if type(v46) ~= "table" then
        p45:ShowLevelInfo(p45.CurrentLevel, CurrentLevelInfo);
        p45:ShowLevelInfo(p45.FutureLevel, CurrentLevelInfo);
        p45.TotalXPLabel.Visible = true;
        p45.TotalXPLabel.Text = "MAX LEVEL REACHED";

        return;
    end;

    local LeftoverXP = v46.LeftoverXP;
    local LevelsAdded = v46.LevelsAdded;
    local TotalXP = v46.TotalXP;
    local v47 = LevelingInfo.GetMaxLevel(p45.AscensionRank);

    if v47 <= CurrentLevelInfo.CurrentLevel + LevelsAdded then
        p45.TotalXPLabel.Visible = true;
        p45.TotalXPLabel.Text = "MAX LEVEL REACHED";
        p45:ShowLevelInfo(p45.CurrentLevel, CurrentLevelInfo);
        p45:ShowLevelInfo(p45.FutureLevel, {
            CurrentXP = 0,
            CurrentLevel = v47,
            RequiredXP = CurrentLevelInfo.RequiredXP
        });

        return;
    end;

    p45.TotalXPLabel.Visible = false;

    if type(TotalXP) == "number" and TotalXP > 0 then
        p45.TotalXPLabel.Visible = true;
        p45.TotalXPLabel.Text = `+ {TotalXP} XP`;
    else
        p45.TotalXPLabel.Visible = false;
    end;

    p45:ShowLevelInfo(p45.CurrentLevel, CurrentLevelInfo);
    p45:ShowLevelInfo(p45.FutureLevel, {
        CurrentLevel = CurrentLevelInfo.CurrentLevel + LevelsAdded,
        CurrentXP = LeftoverXP,
        RequiredXP = CurrentLevelInfo.RequiredXP
    });
end;

function u3._ComputeXPGain(p48, p49, p50) -- Line: 274
    -- upvalues: LevelingInfo (copy)
    local v51 = LevelingInfo.GetMaxLevel(p48.AscensionRank);

    if v51 <= p50.CurrentLevel then
        return "MaxLevel";
    end;

    if type(p49) ~= "table" then
        return "Invalid Items";
    end;

    local ExperienceMaterials = LevelingInfo.ExperienceMaterials;
    local v52 = 0;

    for _, v in ipairs(p49) do
        local v53 = ExperienceMaterials[v];

        if v53 then
            v52 = v52 + v53;
        end;
    end;

    local v54 = LevelingInfo.CalculateLevelsFromXP(p50.CurrentLevel, v51, p50.CurrentXP, v52);

    return {
        TotalXP = math.round(v52),
        LevelsAdded = v54.LevelsAdded,
        LeftoverXP = math.round(v54.LeftoverXP)
    };
end;

function u3.ComputeXPGain(p55, p56) -- Line: 301
    local v57 = {};

    for _, v in p55.Cache.SelectedSlots do
        local v58 = v.Stack:All();

        for i = 1, #v58 do
            if v58[i] and (v58[i]._UUID and v58[i]._ItemId) then
                table.insert(v57, v58[i]._ItemId);
            end;
        end;
    end;

    local v59 = p55:_ComputeXPGain(v57, p56);
    table.clear(v57);

    return v59;
end;

function RoundToTen(p60)
    return math.floor(p60 / 10) * 10;
end;

function u3.ConsumeXPItems(p61) -- Line: 329
    -- upvalues: u2 (copy), LevelingInfo (copy)
    local SelectedSlots = p61.Cache.SelectedSlots;
    local v62 = u2:GetAbilityPVEInfo(p61.Cache.CurrentAbilityId):expect() or {};
    p61.CurrentLevelInfo = v62;
    local v63 = {};

    for _, v in SelectedSlots do
        local v64 = v.Stack:All();

        for i = 1, #v64 do
            if v64[i] and v64[i]._UUID then
                table.insert(v63, v64[i]._UUID);
            end;
        end;
    end;

    local CurrentLevel = v62.CurrentLevel;
    local v65, v66 = u2:ConsumeXPItems(p61.Cache.CurrentAbilityId, v63):expect();
    table.clear(v63);
    p61:Load(p61.Cache.CurrentAbilityId);
    p61.UIEngine.NewPrompt({
        Title = "Level Details",
        Text = v65
    });
    local v67 = LevelingInfo.GetMaxLevel(p61.AscensionRank);

    if v66 then
        if v66[1] ~= v67 and RoundToTen(CurrentLevel) == RoundToTen(v66[1]) then
            script.One:Play();

            return v66;
        end;

        if v66[1] ~= v67 and RoundToTen(CurrentLevel) ~= RoundToTen(v66[1]) then
            script.Ten:Play();

            return v66;
        end;

        if v66[1] == v67 then
            script.Max:Play();
        end;
    end;

    return v66;
end;

function u3.Load(u68, p69) -- Line: 371
    -- upvalues: u2 (copy), ItemData (copy), u1 (copy), Promise (copy)
    u68.Trove:Clean();
    local v70 = u2:GetAbilityPVEInfo(p69):expect() or {};
    local v71 = ItemData.GetItemInfo((`ABILITY_{p69}`));
    u68.PVEInfo = v70;
    u68.AscensionRank = v70.AscensionRank;
    u68.CurrentLevelInfo = v70;
    local v72 = {
        AbilityName = v71.Name
    };
    local v73;

    if typeof(v71.Prefix) == "table" then
        v73 = v71.Prefix.Name;
    else
        v73 = v71.Prefix;
    end;

    v72.AbilityPrefix = v73;
    v72.AbilityPrefixColor = ItemData.Rarities[v71.Rarity].Color;
    v72.AbilityDescription = v71.Description;
    u68:SetInfo(v72);
    u68.Cache.CurrentAbilityId = p69;
    u68.Trove:Add(function() -- Line: 390
        -- upvalues: u68 (copy)
        u68:ClearSlots();
    end);
    local v74 = u1:GetItems("XPInventory"):expect() or {};

    for _, v in pairs(v74) do
        Promise.try(u68.AddSlot, u68, u68.Cache.InventorySlots, v, u68.ItemSlots, false):catch(warn);
    end;

    u68:UpdateLevelInfo();
end;

return u3;