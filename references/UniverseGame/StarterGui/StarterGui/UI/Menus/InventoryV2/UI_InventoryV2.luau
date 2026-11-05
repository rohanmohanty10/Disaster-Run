  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
game:GetService("ContextActionService");
local Players = game:GetService("Players");
require("./Lib/Types");
local u1 = {
    Abilities = {
        InventoryType = "AbilityInventory",
        Index = 1,
        Color = Color3.fromRGB(255, 139, 139)
    },
    Skins = {
        InventoryType = "SkinInventory",
        Index = 2,
        Color = Color3.fromRGB(191, 162, 255)
    },
    Items = {
        InventoryType = "ItemInventory",
        Index = 3,
        Color = Color3.fromRGB(255, 164, 213)
    },
    Mounts = {
        InventoryType = "MountInventory",
        Index = 4,
        Color = Color3.fromRGB(161, 210, 255)
    },
    Emotes = {
        InventoryType = "EmoteInventory",
        Index = 5,
        Color = Color3.fromRGB(255, 247, 164)
    },
    ["Kill Effects"] = {
        InventoryType = "KillEffectInventory",
        Index = 6,
        Color = Color3.fromRGB(164, 255, 200)
    }
};
local LocalPlayer = Players.LocalPlayer;

return function(u2) -- Line: 57
    -- upvalues: ReplicatedStorage (copy), u1 (copy), GuiService (copy), UserInputService (copy), LocalPlayer (copy)
    u2.Data:WaitForChild("Inventory");
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    Core.OnStart():await();
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(ReplicatedStorage.ReplicatedModules.StatsHandler);
    require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
    require(ReplicatedStorage.ReplicatedModules.PVEPackage.TraitHandler);
    local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    require(ReplicatedStorage.ReplicatedModules.AbilityNameToId);
    local Stands = require(ReplicatedStorage.ReplicatedModules.Stands);
    require(ReplicatedStorage.ReplicatedRoot.Libraries.Skins);
    local u3 = u2.Knit.GetService("InventoryService");
    local u4 = u2.Knit.GetService("MountService");
    local u5 = u2.Knit.GetService("KillEffectService");
    Core.GetClientService("RigPreviewService");

    if not Core.GetClientService("ConfigurationService"):GetFFlags():expect().new_inventory_enabled then
        return;
    end;

    local u6 = Fusion.Value(false);
    local u7 = Fusion.Value(nil);
    local u8 = Fusion.Value(false);
    local u9 = Fusion.Value(false);
    local u10 = Fusion.Value(nil);
    local u11 = Fusion.Value({});
    local u12 = Fusion.Value(false);
    local u13 = Fusion.Value(0);
    local u14 = Fusion.Value({});
    local u15 = Fusion.Value(nil);
    local u16 = Fusion.Value({});
    local u17 = Fusion.Value(nil);
    local v18 = Fusion.Value(nil);
    local u19 = Fusion.Value(nil);
    local u21 = Fusion.Computed(function() -- Line: 111
        -- upvalues: u10 (copy), u1 (ref)
        local v20 = u10:get();

        if v20 then
            for i, v in u1 do
                if v.InventoryType == v20 then
                    return i;
                end;
            end;
        end;

        return v20;
    end);
    local v22 = {
        SearchQuery = u7,
        TabPanelOpen = u8,
        InfoPanelOpen = u9,
        CurrentInventoryType = u10,
        SelectedItems = u11,
        ViewingInventory = u14,
        ActiveFilters = u16,
        ActiveSort = u17,
        ActiveSortName = v18,
        FocusedItem = u19,
        FocusedItemActions = nil,
        CurrentTabName = u21,
        UIEngine = u2
    };
    task.wait(1);
    local Rarities = ItemData.Rarities;
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local InventoryHolder = Parent.InventoryHolder;
    local Main = InventoryHolder.Main;
    local TopBar = Main.TopBar;
    local Content = Main.Content;
    local TabPanel = Main.TabPanel;
    local Holder = TabPanel.Holder;
    local Items = Content.Items;
    local Info = Content.Panel.Info;
    local Indexing = TopBar.Indexing;
    local v23 = require("./Lib/DataSource");
    local v24 = require("./Lib/VirtualGrid");
    local v25 = require("./Lib/ContextMenuController");
    require("./Lib/Icons");
    local u26 = require("./Lib/Utility");
    local v27 = require("./Components/Sorting");
    local v28 = require("./Components/Filters");
    local v29 = require("./Components/InfoPanel");
    local v30 = require("./Components/ImageButton");
    local u31 = 0;
    local u32 = nil;
    local u33 = nil;
    local u34 = false;
    local u35 = 0;
    local u36 = {};
    local u37 = {};
    local MainToolTipScreen = u2.MainToolTipScreen;
    local u38 = v23.new();
    local u39 = v25.new(InventoryHolder.ContextMenu, InventoryHolder, u2);

    local function ComputePointerPosition(p40) -- Line: 202
        -- upvalues: GuiService (ref), UserInputService (ref)
        local v41 = GuiService:GetGuiInset();

        if p40 and (p40.UserInputType == Enum.UserInputType.Touch or (p40.UserInputType == Enum.UserInputType.MouseButton1 or p40.UserInputType == Enum.UserInputType.MouseButton2)) then
            return Vector2.new(p40.Position.X, p40.Position.Y) + v41;
        end;

        return UserInputService:GetMouseLocation() + v41;
    end;

    local function CompileRawItem(p42) -- Line: 214
        -- upvalues: u26 (copy), Stands (copy)
        local v43 = {
            Identifier = p42._UUID,
            Rarity = p42._Rarity,
            Name = p42._DisplayName,
            Premium = p42._Premium,
            UnusualInfo = p42._UnusualInfo,
            ItemId = p42._ItemId,
            Serial = p42._SerialNumber,
            Tradeable = p42._Tradeable,
            Locked = p42._Locked,
            Type = p42._ItemType,
            Tags = {}
        };
        local _TraitInfo = p42._TraitInfo;

        if _TraitInfo then
            v43.Trait = {
                Rarity = u26.GetTraitRarityIndex(_TraitInfo.Trait),
                Name = _TraitInfo.Trait,
                Hex = _TraitInfo.Hexed,
                Stats = _TraitInfo.StatBonuses or nil
            };
            table.insert(v43.Tags, _TraitInfo.Trait);
        end;

        if p42._AbilityId then
            table.insert(v43.Tags, Stands[p42._AbilityId]);
        end;

        return v43;
    end;

    local function GetInventoryItems(p44) -- Line: 248
        -- upvalues: u36 (copy), u3 (copy), CompileRawItem (copy)
        if u36[p44] then
            return u36[p44];
        end;

        local v45 = u3:GetItems(p44):expect();

        if not v45 then
            return {};
        end;

        u36[p44] = {};

        for _, v in v45 do
            u36[p44][v._UUID] = CompileRawItem(v);
        end;

        return u36[p44];
    end;

    local function BundleByInventory(p46) -- Line: 267
        -- upvalues: ItemData (copy)
        local v47 = {};

        for i in p46 do
            local Type = ItemData.GetItemInfo(i.ItemId).Type;

            if Type then
                if not v47[Type] then
                    v47[Type] = {};
                end;

                v47[Type][i.Identifier] = true;
            end;
        end;

        return v47;
    end;

    local function UpdateViewingInventory(p48) -- Line: 285
        -- upvalues: u14 (copy)
        u14:set(p48);
    end;

    local function UpdateEquipped(p49) -- Line: 289
        -- upvalues: u37 (copy), u3 (copy), LocalPlayer (ref), u5 (copy), u4 (copy)
        if u37[p49] == nil then
            u37[p49] = {};
        end;

        if p49 == "SkinInventory" then
            u37[p49] = u3:GetEquippedSkins(true):expect();

            return;
        end;

        if p49 == "AbilityInventory" then
            u37[p49] = {
                [LocalPlayer.Data.Ability:GetAttribute("UUID")] = true
            };

            return;
        end;

        if p49 ~= "KillEffectInventory" then
            if p49 == "MountInventory" then
                local EquippedMount = LocalPlayer.Data.EquippedMount;
                local v50;

                if EquippedMount:GetAttribute("UUID") then
                    v50 = EquippedMount:GetAttribute("UUID");
                else
                    v50 = u4:GetEquippedMountItem():expect();
                end;

                if v50 then
                    u37[p49] = {
                        [v50] = true
                    };

                    return;
                end;

                u37[p49] = {};
            end;

            return;
        end;

        local EquippedKillEffect = LocalPlayer.Data.EquippedKillEffect;
        local v51;

        if EquippedKillEffect:GetAttribute("UUID") then
            v51 = EquippedKillEffect:GetAttribute("UUID");
        else
            v51 = u5:GetEquippedKillEffectItem():expect();
        end;

        if v51 then
            u37[p49] = {
                [v51] = true
            };

            return;
        end;

        u37[p49] = {};
    end;

    local function SetInventoryTab(p52) -- Line: 319
        -- upvalues: u35 (ref), u21 (copy), u1 (ref), u10 (copy), UpdateEquipped (copy), GetInventoryItems (copy), u14 (copy), u3 (copy), u15 (copy), u19 (copy)
        if os.clock() - u35 < 0.3 then
            return false;
        end;

        if u21:get() == p52 then
            return false;
        end;

        if not u1[p52] then
            return false;
        end;

        local InventoryType = u1[p52].InventoryType;
        u10:set(InventoryType);
        task.spawn(function() -- Line: 330
            -- upvalues: UpdateEquipped (ref), InventoryType (copy), GetInventoryItems (ref), u14 (ref), u3 (ref), u15 (ref), u19 (ref)
            UpdateEquipped(InventoryType);
            u14:set((GetInventoryItems(InventoryType)));
            u15:set(u3:GetCapacity(InventoryType):expect() or nil);
            u19:set(nil);
        end);
        u35 = os.clock();
    end;

    local function UpdateCell(p53, p54, p55, p56) -- Line: 347
        -- upvalues: Rarities (copy), u34 (ref), u11 (copy), u37 (copy)
        local TextLabel = p53.TextLabel;
        local Charms = p53.Charms;

        if p56.Trait then
            TextLabel.Text = p56.Trait.Name .. " " .. (p56.Name or "thing");
        else
            TextLabel.Text = p56.Name or "thing";
        end;

        local Color = Rarities[p56.Rarity or 1].Color;
        Charms.Premium.Visible = p56.Premium ~= nil;
        Charms.Serial.Visible = p56.Serial ~= nil;
        Charms.Favourite.Visible = p56.Locked == true;
        p53.UIStroke.Color = Color;
        p53.BackgroundGradient.BackgroundColor3 = Color;

        if p56.UnusualInfo then
            Charms.Unusual.Visible = true;
            local UnusualHueId = p56.UnusualInfo.UnusualHueId;
            local Unusual = Charms.Unusual;
            local v57;

            if UnusualHueId == 0 or UnusualHueId == (1 / 0) then
                v57 = Color3.new(1, 1, 1);
            else
                v57 = Color3.fromHSV(UnusualHueId * 5 / 360, 1, 1);
            end;

            Unusual.ImageColor3 = v57;
        else
            Charms.Unusual.Visible = false;
        end;

        if u34 then
            local v58 = u11:get();
            p53.Selection.Visible = true;
            p53.Selection.Mark.Visible = v58[p56] ~= nil;
        elseif p53.Selection.Visible then
            p53.Selection.Visible = false;
        end;

        local v59 = p56.Type .. "Inventory";

        if u37[v59] and u37[v59][p56.Identifier] then
            p53.BackgroundColor3 = Color3.fromRGB(135, 135, 135);
            p53.EquipStroke.Enabled = true;

            return;
        end;

        p53.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
        p53.EquipStroke.Enabled = false;
    end;

    local function GetActionsForItem(u60, p61, p62) -- Line: 397
        -- upvalues: ItemData (copy), u3 (copy), u39 (copy), u19 (copy), u2 (copy), u37 (copy), u4 (copy), u5 (copy), Parent (copy), EffectsHandler (copy)
        local v63;

        if u60 then
            v63 = p61 or ItemData.GetItemInfo(u60.ItemId);
        else
            v63 = nil;
        end;

        local Type = u60.Type;

        if not (Type and u60) then
            return {};
        end;

        local v64 = {};
        local v65;

        if u60.Locked then
            v65 = {
                Label = "Unfavorite",
                IconName = "Unfavourite",
                Order = 4,

                Callback = function() -- Line: 407, Name: Callback
                    -- upvalues: u3 (ref), u60 (copy), Type (copy), u39 (ref)
                    u3.ItemLocked:Fire(false, u60.Identifier, Type);
                    u39:Hide();
                end,

                Color = Color3.fromRGB(255, 255, 43)
            };
        else
            v65 = {
                Label = "Favorite",
                IconName = "Favourite",
                Order = 4,

                Callback = function() -- Line: 416, Name: Callback
                    -- upvalues: u3 (ref), u60 (copy), Type (copy), u39 (ref)
                    u3.ItemLocked:Fire(true, u60.Identifier, Type);
                    u39:Hide();
                end,

                Color = Color3.fromRGB(255, 255, 43)
            };
        end;

        v64[1], v64[2], v64[3] = v65, {
    Kind = "Divider",
    Order = 10,

    Callback = function() -- Line: 425, Name: Callback
        -- upvalues: u19 (ref), u60 (copy), u39 (ref)
        u19:set(u60);
        u39:Hide();
    end
}, not u60.Locked and {
    Label = "Delete",
    IconName = "Delete",
    Order = 11,

    Callback = function() -- Line: 434, Name: Callback
        -- upvalues: u60 (copy), u39 (ref), u2 (ref), Type (copy), u3 (ref)
        local u66 = {
            Remove = true,
            ItemId = u60.ItemId,
            UUID = u60.Identifier
        };
        u39:Hide();
        u2.NewPrompt({
            Title = "Delete Item",
            Delay = 0.45,
            RichText = true,
            Text = `Are you sure you want to delete {u2:GetItemText(u60.ItemId)} from your inventory?`,
            Options = { "Delete", "Cancel" },

            Callback = function(p67) -- Line: 450, Name: Callback
                -- upvalues: Type (ref), u3 (ref), u66 (copy)
                if p67.Choice ~= 1 then
                    return;
                end;

                local v68 = Type == "Ability" and "AbilityInventory" or (Type == "Skin" and "SkinInventory" or (Type == "Mount" and "MountInventory" or (Type == "KillEffect" and "KillEffectInventory" or (Type == "Item" and "ItemInventory" or (Type == "Emote" and "EmoteInventory" or nil)))));

                if v68 then
                    u3[v68]:Fire(u66);
                end;
            end
        });
    end,

    Color = Color3.fromRGB(255, 119, 119)
} or nil;

        if u60 and (Type and (Type == "Ability" or (Type == "Skin" or (Type == "Mount" or (Type == "KillEffect" or Type == "Item"))))) then
            local u69 = u37[Type .. "Inventory"] and u37[Type .. "Inventory"][u60.Identifier] and true or false;

            if (not u69 or Type ~= "Ability" and Type ~= "Mount") and (Type ~= "Item" or not u60.Locked) then
                local v70 = {
                    Order = 1
                };
                local v71;

                if Type == "Item" then
                    v71 = v63.Currency and "Consume" or (v63.CrateType and "Open" or v63.Tool and "Equip");
                else
                    v71 = u69 and "Unequip" or "Equip";
                end;

                v70.Label = v71;
                v70.IconName = u69 and "Unequip" or "Equip";

                function v70.Callback() -- Line: 482
                    -- upvalues: u60 (copy), u39 (ref), Type (copy), u3 (ref), u69 (copy), u4 (ref), u5 (ref), u2 (ref)
                    local v72 = {
                        ItemId = u60.ItemId,
                        UUID = u60.Identifier
                    };
                    u39:Hide();
                    local v73 = true;

                    if Type == "Ability" then
                        v72.Equip = true;
                        u3.AbilityInventory:Fire(v72);
                    elseif Type == "Skin" then
                        v72.EquipSkin = not u69;
                        u3.SkinInventory:Fire(v72);
                    elseif Type == "Mount" then
                        u4:EquipMount(v72.ItemId, v72.UUID);
                    elseif Type == "KillEffect" then
                        if u69 then
                            v73 = u5:UnequipKillEffect(v72.ItemId, v72.UUID);
                        else
                            v73 = u5:EquipKillEffect(v72.ItemId, v72.UUID);
                        end;
                    elseif Type == "Item" then
                        u3.ItemInventory:Fire(v72);
                    end;

                    if not v73 then
                        return;
                    end;

                    u2:Notify(`Item {u69 and "Unequipped" or "Equipped"}`, `{u69 and "Unequipped" or "Equipped"} {Type}: {u2:GetItemText(v72.ItemId)}`, 3);
                end;

                table.insert(v64, v70);
            end;
        elseif u60 and Type == "Emote" then
            table.insert(v64, {
                Label = "Bind",
                IconName = "Equip",
                Order = 1,

                Callback = function() -- Line: 521, Name: Callback
                    -- upvalues: u2 (ref), Parent (ref), u60 (copy)
                    u2._ReturnMenu = Parent.Name;
                    u2:SetBindingEmote(u60.ItemId);
                    u2:ShowEmoteWheel();
                    u2:SetMenu(false, {
                        Manual = true
                    });
                end
            });
        end;

        if u60 and Type == "KillEffect" then
            table.insert(v64, {
                Label = "Preview",
                IconName = "Sparkles",
                Order = 2,

                Callback = function() -- Line: 560, Name: Callback
                    -- upvalues: u39 (ref), EffectsHandler (ref), u60 (copy)
                    u39:Hide();
                    EffectsHandler.CallEffect("PreviewKillEffect", u60.ItemId);
                end
            });
        end;

        return v64;
    end;

    local function DetermineContextMenu(u74, p75) -- Line: 571
        -- upvalues: u12 (copy), u11 (copy), u13 (copy), BundleByInventory (copy), u39 (copy), u2 (copy), u3 (copy), u19 (copy), u36 (copy), GetActionsForItem (copy)
        local _ = u74.Type;

        if not u12:get() then
            local v76 = GetActionsForItem(u74, p75, true);
            table.insert(v76, {
                Label = "Focus",
                IconName = "Info",
                Order = 3,

                Callback = function() -- Line: 696, Name: Callback
                    -- upvalues: u19 (ref), u74 (copy), u39 (ref)
                    u19:set(u74);
                    u39:Hide();
                end
            });
            local v78 = {
                Label = "Select",
                IconName = "Select",
                Order = 5,

                Callback = function() -- Line: 706, Name: Callback
                    -- upvalues: u11 (ref), u74 (copy), u13 (ref), u12 (ref), u39 (ref)
                    local v77 = u11:get();

                    if v77[u74] then
                        v77[u74] = nil;
                        u13:set(u13:get() - 1);
                    else
                        v77[u74] = true;
                        u13:set(u13:get() + 1);
                    end;

                    u11:set(v77);
                    u12:set(true);
                    u39:Hide();
                end,

                Color = Color3.fromRGB(255, 222, 155)
            };
            table.insert(v76, v78);

            return v76;
        end;

        local u79 = u11:get();
        local u80 = u13:get();
        local u81 = BundleByInventory(u79);
        local v84 = {
            u80 > 0 and u80 <= 25 and {
                IconName = "Favourite",
                Order = 1,
                Label = `Un/Favorite ({u80}) Items`,

                Callback = function() -- Line: 586, Name: Callback
                    -- upvalues: u39 (ref), u2 (ref), u80 (copy), u79 (copy), u3 (ref), u11 (ref), u13 (ref)
                    u39:Hide();
                    u2.NewPrompt({
                        Title = "Bulk Favorite",
                        Delay = 0.35,
                        Text = string.format("Are you sure you want to favorite/unfavorite the (%s) selected items?", u80),
                        Options = { "Confirm", "Cancel" },

                        Callback = function(p82) -- Line: 596, Name: Callback
                            -- upvalues: u79 (ref), u3 (ref), u11 (ref), u13 (ref)
                            if p82.Choice ~= 1 then
                                return;
                            end;

                            for i in u79 do
                                if i.Locked ~= nil then
                                    u3.ItemLocked:Fire(not i.Locked, i.Identifier, i.Type);
                                end;
                            end;

                            table.clear(u79);
                            u11:set(u79);
                            u13:set(0);
                        end
                    });
                end,

                Color = Color3.fromRGB(255, 255, 43)
            } or nil,
            {
                Label = "Stop Selecting",
                IconName = "StopSelect",
                Order = 2,

                Callback = function() -- Line: 617, Name: Callback
                    -- upvalues: u12 (ref), u11 (ref), u39 (ref)
                    u12:set(false);
                    u11:set({});
                    u39:Hide();
                end,

                Color = Color3.fromRGB(255, 222, 155)
            },
            u80 > 0 and {
                Kind = "Divider",
                Order = 10,

                Callback = function() -- Line: 628, Name: Callback
                    -- upvalues: u19 (ref), u74 (copy), u39 (ref)
                    u19:set(u74);
                    u39:Hide();
                end
            } or nil,
            u80 > 0 and {
                IconName = "Delete",
                Order = 12,
                Label = `Delete ({u80}) Items`,

                Callback = function() -- Line: 637, Name: Callback
                    -- upvalues: u39 (ref), u2 (ref), u80 (copy), u3 (ref), u81 (copy), u79 (copy), u11 (ref), u13 (ref)
                    u39:Hide();
                    u2.NewPrompt({
                        Title = "Bulk Delete",
                        Delay = 0.75,
                        Text = string.format("Are you sure you want to delete the (%s) selected items?\nFavorites will not be deleted.", u80),
                        Options = { "Confirm", "Cancel" },

                        Callback = function(p83) -- Line: 647, Name: Callback
                            -- upvalues: u3 (ref), u81 (ref), u79 (ref), u11 (ref), u13 (ref)
                            if p83.Choice ~= 1 then
                                return;
                            end;

                            print(u3:BulkDeleteItems(u81):expect());
                            table.clear(u79);
                            u11:set(u79);
                            u13:set(0);
                        end
                    });
                end,

                Color = Color3.fromRGB(255, 119, 119)
            } or nil
        };

        if u81.Item and (u80 <= 50 and u36.ItemInventory) then
            local v86 = {
                IconName = "Equip",
                Order = 0,
                Label = `Equip ({u80}) Items`,

                Callback = function() -- Line: 668, Name: Callback
                    -- upvalues: u81 (copy), u36 (ref), u3 (ref), u39 (ref)
                    for i in u81.Item do
                        local v85 = u36.ItemInventory[i];

                        if v85 then
                            u3.ItemInventory:Fire({
                                ItemId = v85.ItemId,
                                UUID = v85.Identifier
                            });
                        end;
                    end;

                    u39:Hide();
                end
            };
            table.insert(v84, v86);
        end;

        return v84;
    end;

    local function ToggleCellSelection(p87, p88, p89, p90) -- Line: 728
        -- upvalues: u34 (ref), u38 (copy), u11 (copy), u13 (copy), u2 (copy), UpdateCell (copy)
        if not u34 then
            return;
        end;

        local v91 = u38:GetItem(u38:GetIdAt(p89));
        local v92 = u11:get();

        if v92[v91] then
            v92[v91] = nil;
            u13:set(u13:get() - 1);
        else
            v92[v91] = true;
            u13:set(u13:get() + 1);
            u2:PlaySound("Inventory/inv_multi_add");
        end;

        u11:set(v92);
        UpdateCell(p87, u38:GetIdAt(p89), p89, v91);
    end;

    local function MakeCell() -- Line: 748
        -- upvalues: Assets (copy), Fusion (copy), u8 (copy), u38 (copy), u2 (copy), u26 (copy), MainToolTipScreen (copy), u32 (ref), u34 (ref), u31 (ref), ToggleCellSelection (copy), u33 (ref), u12 (copy), UserInputService (ref), u39 (copy), ComputePointerPosition (copy), DetermineContextMenu (copy), u19 (copy)
        local u93 = Assets.Slot:Clone();
        Instance.new("UIScale").Parent = u93;
        local u94 = Fusion.Value(false);
        local v95 = Fusion.Computed(function() -- Line: 756
            -- upvalues: u94 (copy)
            return u94:get() and UDim.new(0.02, 0) or UDim.new(0, 0);
        end);
        local v96 = Fusion.Computed(function() -- Line: 759
            -- upvalues: u94 (copy)
            return u94:get() and 0.035 or 0.02;
        end);
        local u97 = nil;
        Fusion.Hydrate(u93)({
            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 766
                -- upvalues: u94 (copy), u8 (ref), u93 (copy), u38 (ref), u2 (ref), u26 (ref), u97 (ref), MainToolTipScreen (ref)
                u94:set(true);

                if u8:get() then
                    return;
                end;

                local v98 = u38:GetItem(u38:GetIdAt((u93:GetAttribute("Index"))));
                u2:PlaySound("Inventory/inv_hover");

                if u26.CanTooltipInventorySlot(v98) then
                    u97 = u93:GetAttributeChangedSignal("Index"):Connect(function() -- Line: 779
                        -- upvalues: u93 (ref), u38 (ref), u26 (ref), MainToolTipScreen (ref)
                        local v99 = u38:GetItem(u38:GetIdAt((u93:GetAttribute("Index"))));

                        if not u26.CanTooltipInventorySlot(v99) then
                            MainToolTipScreen:Hide();

                            return;
                        end;

                        u26.UpdateTooltip(MainToolTipScreen, v99);
                        MainToolTipScreen:Show();
                    end);
                    u26.UpdateTooltip(MainToolTipScreen, v98);
                    MainToolTipScreen:Show();
                end;
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 795
                -- upvalues: u94 (copy), MainToolTipScreen (ref), u97 (ref), u32 (ref)
                u94:set(false);
                MainToolTipScreen:Hide();

                if u97 ~= nil then
                    u97:Disconnect();
                    u97 = nil;
                end;

                if u32 then
                    task.defer(function() -- Line: 805
                        -- upvalues: u32 (ref)
                        u32 = nil;
                    end);
                end;
            end,

            [Fusion.OnEvent("InputBegan")] = function(p100, p101) -- Line: 810
                -- upvalues: u34 (ref), u93 (copy), u31 (ref), u32 (ref), u38 (ref), ToggleCellSelection (ref), u33 (ref), u12 (ref), u2 (ref), UserInputService (ref)
                if not u34 and p101 then
                    return;
                end;

                if p100.UserInputType ~= Enum.UserInputType.MouseButton1 and p100.UserInputType ~= Enum.UserInputType.Touch then
                    if u34 and (p100.UserInputType == Enum.UserInputType.MouseMovement and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                        local v102 = u93:GetAttribute("Index");
                        local v103 = u38:GetItem(u38:GetIdAt(v102));
                        ToggleCellSelection(u93, u38:GetIdAt(v102), v102, v103);
                    end;

                    return;
                end;

                local u104 = u93:GetAttribute("Index");

                if u34 then
                    if p100.UserInputType == Enum.UserInputType.Touch then
                        u31 = os.clock();
                        u32 = u104;
                    end;

                    local v105 = u38:GetItem(u38:GetIdAt(u104));
                    ToggleCellSelection(u93, u38:GetIdAt(u104), u104, v105);

                    return;
                end;

                u31 = os.clock();
                u32 = u104;
                u33 = task.delay(1.15, function() -- Line: 826
                    -- upvalues: u12 (ref), u2 (ref), u38 (ref), u104 (copy), ToggleCellSelection (ref), u93 (ref), u32 (ref), u33 (ref)
                    u12:set(true);
                    u2:PlaySound("Inventory/inv_multi");
                    local v106 = u38:GetItem(u38:GetIdAt(u104));
                    ToggleCellSelection(u93, u38:GetIdAt(u104), u104, v106);
                    u32 = nil;
                    u33 = nil;
                end);
            end,

            [Fusion.OnEvent("InputEnded")] = function(p107, p108) -- Line: 883
                -- upvalues: u93 (copy), u33 (ref), u31 (ref), u38 (ref), u39 (ref), ComputePointerPosition (ref), DetermineContextMenu (ref), u2 (ref)
                if p107.UserInputType ~= Enum.UserInputType.MouseButton1 and p107.UserInputType ~= Enum.UserInputType.Touch then
                    if p107.UserInputType == Enum.UserInputType.MouseButton2 then
                        local v109 = u38:GetItem(u38:GetIdAt((u93:GetAttribute("Index"))));
                        u39:Show(ComputePointerPosition(p107), (DetermineContextMenu(v109)));
                        u2:PlaySound("Inventory/inv_context");
                    end;

                    return;
                end;

                u93:GetAttribute("Index");

                if u33 then
                    pcall(task.cancel, u33);
                    u33 = nil;
                end;

                u31 = 0;
            end,

            [Fusion.OnEvent("Activated")] = function(p110) -- Line: 899
                -- upvalues: u93 (copy), u31 (ref), u38 (ref), u19 (ref), u39 (ref), ComputePointerPosition (ref), DetermineContextMenu (ref), u2 (ref)
                local v111 = u93:GetAttribute("Index");
                local v112 = os.clock() - u31;
                local v113 = u38:GetItem(u38:GetIdAt(v111));
                local v114 = u19:get();

                if v112 >= 1.15 then
                    return;
                end;

                if v112 >= 0.35 and p110.UserInputType == Enum.UserInputType.Touch then
                    u39:Show(ComputePointerPosition(p110), (DetermineContextMenu(v113)));
                    u2:PlaySound("Inventory/inv_context");

                    return;
                end;

                u2:PlaySound("Inventory/inv_click");

                if not v114 or v114.Identifier ~= v113.Identifier then
                    u19:set(v113);
                end;
            end
        });
        Fusion.Hydrate(u93:FindFirstChild("UIStroke"))({
            BorderOffset = Fusion.Spring(v95, 25, 0.9),
            Thickness = Fusion.Spring(v96, 30, 0.9)
        });

        return u93;
    end;

    local function GetComparator(p115) -- Line: 930
        if not p115 then
            return function(p116, p117) -- Line: 932
                return (p116._SortPriority or 0) > (p117._SortPriority or 0);
            end;
        end;

        local Tiebreaker = p115.Tiebreaker;

        return function(p118, p119) -- Line: 940
            -- upvalues: Tiebreaker (copy)
            local v120 = p118._SortPriority or 0;
            local v121 = p119._SortPriority or 0;

            if v120 == v121 then
                return Tiebreaker(p118, p119);
            end;

            return v121 < v120;
        end;
    end;

    local function UpdateSort() -- Line: 952
        -- upvalues: u17 (copy), u38 (copy)
        local v122 = u17:get();

        if v122 then
            u38:SetPriorityFn(v122.PriorityFn);
            local v123;

            if v122 then
                local Tiebreaker = v122.Tiebreaker;

                v123 = function(p124, p125) -- Line: 940
                    -- upvalues: Tiebreaker (copy)
                    local v126 = p124._SortPriority or 0;
                    local v127 = p125._SortPriority or 0;

                    if v126 == v127 then
                        return Tiebreaker(p124, p125);
                    end;

                    return v127 < v126;
                end;
            else
                v123 = function(p128, p129) -- Line: 932
                    return (p128._SortPriority or 0) > (p129._SortPriority or 0);
                end;
            end;

            u38:SetSort(v123);
        end;
    end;

    local u130 = v24.new(Items.ScrollingFrame, Items.ScrollingFrame.Content, {
        paddingTop = 5,
        paddingLeft = 5,
        bufferRows = 1,
        cellSize = Vector2.new(100, 100),
        spacing = Vector2.new(10, 10),
        dataSource = u38,
        render = UpdateCell,
        makeCell = MakeCell
    });
    local v131 = u17:get();

    if v131 then
        u38:SetPriorityFn(v131.PriorityFn);
        local v132;

        if v131 then
            local Tiebreaker = v131.Tiebreaker;

            v132 = function(p133, p134) -- Line: 940
                -- upvalues: Tiebreaker (copy)
                local v135 = p133._SortPriority or 0;
                local v136 = p134._SortPriority or 0;

                if v135 == v136 then
                    return Tiebreaker(p133, p134);
                end;

                return v136 < v135;
            end;
        else
            v132 = function(p137, p138) -- Line: 932
                return (p137._SortPriority or 0) > (p138._SortPriority or 0);
            end;
        end;

        u38:SetSort(v132);
    end;

    SetInventoryTab("Skins");
    v22.FocusedItemActions = Fusion.Computed(function() -- Line: 978
        -- upvalues: u19 (copy), GetActionsForItem (copy)
        local v139 = u19:get();

        return not v139 and {} or GetActionsForItem(v139);
    end);
    Fusion.Observer(u7):onChange(function() -- Line: 984
        -- upvalues: u38 (copy), u7 (copy)
        u38:SetSearch(u7:get());
    end);
    Fusion.Observer(u14):onChange(function() -- Line: 987
        -- upvalues: u38 (copy), u14 (copy)
        u38:SetItems(u14:get());
    end);
    Fusion.Observer(u16):onChange(function() -- Line: 990
        -- upvalues: u38 (copy), u16 (copy)
        u38:SetFilters(u16:get());
    end);
    Fusion.Observer(u9):onChange(function() -- Line: 993
        -- upvalues: u2 (copy)
        u2:PlaySound("Inventory/inv_sidebar");
    end);
    Fusion.Observer(u8):onChange(function() -- Line: 996
        -- upvalues: u2 (copy)
        u2:PlaySound("Inventory/inv_sidebar");
    end);
    Fusion.Observer(u17):onChange(UpdateSort);
    Fusion.Observer(u12):onChange(function() -- Line: 1000
        -- upvalues: u34 (ref), u12 (copy), u130 (copy), u13 (copy)
        u34 = u12:get();
        u130:Render();

        if not u34 then
            u13:set(0);
        end;
    end);
    Fusion.Observer(u6):onChange(function() -- Line: 1008
        -- upvalues: u6 (copy), u12 (copy), u11 (copy)
        if not u6:get() and u12:get() then
            u12:set(false);
            u11:set({});
        end;
    end);
    Fusion.Hydrate(Indexing.Search)({
        [Fusion.OnChange("Text")] = function() -- Line: 1018
            -- upvalues: u7 (copy), Indexing (copy)
            u7:set(Indexing.Search.Text);
        end
    });
    Fusion.Hydrate(TopBar.TabsButton)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1026
            -- upvalues: u8 (copy), u2 (copy)
            u8:set(not u8:get());
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(TopBar.PanelButton)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1033
            -- upvalues: u9 (copy), u2 (copy)
            u9:set(not u9:get());
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(Holder.Top.Close)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1040
            -- upvalues: u8 (copy), u2 (copy)
            u8:set(false);
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(Holder.Top.Menu)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1047
            -- upvalues: u8 (copy), u2 (copy)
            u8:set(false);
            u2:SetMenu("Menu");
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(Holder.Top.Exit)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1055
            -- upvalues: u8 (copy), u2 (copy)
            u8:set(false);
            u2:SetMenu(nil);
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(TabPanel)({
        Visible = true,
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 1063
            -- upvalues: u8 (copy)
            return u8:get() and UDim2.fromScale(0, 0) or UDim2.fromScale(-0.6, 0);
        end), 25, 1)
    });
    Fusion.Hydrate(Items.SelectCount)({
        Visible = true,
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 1072
            -- upvalues: u12 (copy)
            return u12:get() and UDim2.new(1, -1, 1, 0) or UDim2.new(1, -1, 1.05, 0);
        end), 25, 0.95),
        Text = Fusion.Computed(function() -- Line: 1076
            -- upvalues: u13 (copy)
            return `{u13:get()} selected`;
        end)
    });
    Fusion.Hydrate(Items.SelectCount.CancelButton)({
        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1084
            -- upvalues: u12 (copy), u11 (copy), u2 (copy)
            u12:set(false);
            u11:set({});
            u2:PlaySound("Inventory/inv_click");
        end
    });
    Fusion.Hydrate(Holder.TabList)({
        [Fusion.Children] = Fusion.ForPairs(u1, function(u140, p141) -- Line: 1092
            -- upvalues: Assets (copy), Fusion (copy), SetInventoryTab (copy), u8 (copy), u2 (copy), u21 (copy)
            local v142 = Assets.TabButton:Clone();
            local u143 = Fusion.Value(false);
            Fusion.Hydrate(v142)({
                BackgroundColor3 = p141.Color,

                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 1098
                    -- upvalues: SetInventoryTab (ref), u140 (copy), u8 (ref), u2 (ref)
                    SetInventoryTab(u140);
                    u8:set(false);
                    u2:PlaySound("Inventory/inv_click");
                end,

                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 1104
                    -- upvalues: u143 (copy)
                    u143:set(true);
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 1108
                    -- upvalues: u143 (copy)
                    u143:set(false);
                end,

                LayoutOrder = p141.Index,
                Visible = true
            });
            Fusion.Hydrate(v142.Label)({
                Text = u140,
                TextColor3 = p141.Color
            });
            Fusion.Hydrate(v142.Frame)({
                BackgroundColor3 = p141.Color
            });
            Fusion.Hydrate(v142.Icon)({
                ImageColor3 = p141.Color
            });
            Fusion.Hydrate(v142.UIGradient)({
                Offset = Fusion.Spring(Fusion.Computed(function() -- Line: 1130
                    -- upvalues: u21 (ref), u140 (copy), u143 (copy)
                    if u21:get() == u140 then
                        return Vector2.new(0, 0);
                    end;

                    return Vector2.new(u143:get() and -0.5 or -1, 0);
                end), 30, 0.9)
            });

            return u140, v142;
        end, Fusion.cleanup)
    });
    local u144 = Fusion.Spring(Fusion.Computed(function() -- Line: 1139
        -- upvalues: u6 (copy)
        return u6:get() and 0 or 1;
    end), 25, 0.95);
    Fusion.Hydrate(Main)({
        GroupTransparency = u144
    });
    Fusion.Hydrate(InventoryHolder)({
        Visible = Fusion.Computed(function() -- Line: 1148
            -- upvalues: u144 (copy)
            return u144:get() < 0.99;
        end),
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 1151
            -- upvalues: u6 (copy)
            return u6:get() and UDim2.fromScale(0.5, 0.5) or UDim2.fromScale(0.5, 0.525);
        end), 20, 0.9)
    });
    Fusion.Hydrate(Indexing.Search)({
        BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 1158
            -- upvalues: u7 (copy)
            local v145 = u7:get();

            if v145 and #v145 > 0 then
                return Color3.fromRGB(56, 68, 124);
            end;

            return Color3.fromRGB(21, 27, 42);
        end), 25, 0.95)
    });
    Fusion.Hydrate(Content.Items.ItemCount)({
        Text = Fusion.Computed(function() -- Line: 1166
            -- upvalues: u15 (copy)
            local v146 = u15:get();

            return not v146 and "..." or string.format("%s / %s Items", v146.CurrentCapacity, v146.MaxCapacity);
        end),
        Visible = Fusion.Computed(function() -- Line: 1172
            -- upvalues: u15 (copy)
            return u15:get() ~= nil;
        end)
    });
    local v154 = {
        Unusual = { Color3.fromRGB(79, 188, 255), function(p147) -- Line: 1179
                return p147.UnusualInfo ~= nil;
            end },
        Premium = { Color3.fromRGB(255, 232, 116), function(p148) -- Line: 1182
                return p148.Premium or false;
            end },
        Serial = { Color3.fromRGB(255, 131, 89), function(p149) -- Line: 1185
                return p149.Serial ~= nil;
            end },
        Favorite = { Color3.fromRGB(255, 255, 43), function(p150) -- Line: 1188
                return p150.Locked == true;
            end },
        Trait = { Color3.fromRGB(171, 255, 213), function(p151) -- Line: 1191
                return p151.Trait ~= nil;
            end },
        Equipped = { Color3.fromRGB(255, 208, 89), function(p152) -- Line: 1194
                -- upvalues: u37 (copy)
                local v153 = p152.Type .. "Inventory";

                return u37[v153] and u37[v153][p152.Identifier];
            end }
    };
    v27(Indexing.Sort, v22);
    v28(Indexing.Filters, v22, v154);
    v29(Info, v22);

    for _, v in Main:QueryDescendants("ImageButton") do
        if v.Image ~= "" then
            v30(v, v22);
        end;
    end;

    local u155 = {};
    local u156 = {};

    local function RequestViewingUpdate(u157) -- Line: 1215
        -- upvalues: u155 (copy), u156 (copy), RequestViewingUpdate (copy), u10 (copy), UpdateEquipped (copy), u36 (copy), u14 (copy), u3 (copy), u15 (copy)
        local u158 = (u155[u157] or 0) + 1;
        u155[u157] = u158;

        if u156[u157] then
            return;
        end;

        u156[u157] = true;
        task.delay(0.05, function() -- Line: 1225
            -- upvalues: u156 (ref), u157 (copy), u158 (copy), u155 (ref), RequestViewingUpdate (ref), u10 (ref), UpdateEquipped (ref), u36 (ref), u14 (ref), u3 (ref), u15 (ref)
            u156[u157] = false;

            if u158 ~= u155[u157] then
                RequestViewingUpdate(u157);

                return;
            end;

            if u10:get() ~= u157 then
                return;
            end;

            UpdateEquipped(u157);
            local v159 = u36[u157];

            if v159 then
                u14:set(v159);
            end;

            u15:set(u3:GetCapacity(u157):expect() or nil);
        end);
    end;

    u3.ItemAdded:Connect(function(p160, u161) -- Line: 1249
        -- upvalues: u36 (copy), CompileRawItem (copy), u155 (copy), u156 (copy), RequestViewingUpdate (copy), u10 (copy), UpdateEquipped (copy), u14 (copy), u3 (copy), u15 (copy)
        local v162 = u36[u161];

        if v162 then
            v162[p160._UUID] = CompileRawItem(p160);
            local u163 = (u155[u161] or 0) + 1;
            u155[u161] = u163;

            if u156[u161] then
                return;
            end;

            u156[u161] = true;
            task.delay(0.05, function() -- Line: 1225
                -- upvalues: u156 (ref), u161 (copy), u163 (copy), u155 (ref), RequestViewingUpdate (ref), u10 (ref), UpdateEquipped (ref), u36 (ref), u14 (ref), u3 (ref), u15 (ref)
                u156[u161] = false;

                if u163 ~= u155[u161] then
                    RequestViewingUpdate(u161);

                    return;
                end;

                if u10:get() ~= u161 then
                    return;
                end;

                UpdateEquipped(u161);
                local v164 = u36[u161];

                if v164 then
                    u14:set(v164);
                end;

                u15:set(u3:GetCapacity(u161):expect() or nil);
            end);
        end;
    end);
    u3.ItemUpdated:Connect(function(p165, u166) -- Line: 1261
        -- upvalues: u36 (copy), CompileRawItem (copy), u155 (copy), u156 (copy), RequestViewingUpdate (copy), u10 (copy), UpdateEquipped (copy), u14 (copy), u3 (copy), u15 (copy)
        local v167 = u36[u166];

        if v167 then
            local _UUID = p165._UUID;

            if not v167[_UUID] then
                return;
            end;

            v167[_UUID] = CompileRawItem(p165);
            local u168 = (u155[u166] or 0) + 1;
            u155[u166] = u168;

            if u156[u166] then
                return;
            end;

            u156[u166] = true;
            task.delay(0.05, function() -- Line: 1225
                -- upvalues: u156 (ref), u166 (copy), u168 (copy), u155 (ref), RequestViewingUpdate (ref), u10 (ref), UpdateEquipped (ref), u36 (ref), u14 (ref), u3 (ref), u15 (ref)
                u156[u166] = false;

                if u168 ~= u155[u166] then
                    RequestViewingUpdate(u166);

                    return;
                end;

                if u10:get() ~= u166 then
                    return;
                end;

                UpdateEquipped(u166);
                local v169 = u36[u166];

                if v169 then
                    u14:set(v169);
                end;

                u15:set(u3:GetCapacity(u166):expect() or nil);
            end);
        end;
    end);
    u3.ItemRemoved:Connect(function(p170, u171) -- Line: 1277
        -- upvalues: u36 (copy), u19 (copy), u9 (copy), u37 (copy), u155 (copy), u156 (copy), RequestViewingUpdate (copy), u10 (copy), UpdateEquipped (copy), u14 (copy), u3 (copy), u15 (copy)
        local v172 = u36[u171];

        if v172 then
            local _UUID = p170._UUID;

            if not v172[_UUID] then
                warn("Item wasn\'t stored");

                return;
            end;

            v172[_UUID] = nil;
            local v173 = u19:get();

            if v173 and v173.Identifier == _UUID then
                u19:set(nil);
                u9:set(false);
            end;

            if u37[u171] and u37[u171][_UUID] then
                u37[u171][_UUID] = nil;
            end;

            local u174 = (u155[u171] or 0) + 1;
            u155[u171] = u174;

            if u156[u171] then
                return;
            end;

            u156[u171] = true;
            task.delay(0.05, function() -- Line: 1225
                -- upvalues: u156 (ref), u171 (copy), u174 (copy), u155 (ref), RequestViewingUpdate (ref), u10 (ref), UpdateEquipped (ref), u36 (ref), u14 (ref), u3 (ref), u15 (ref)
                u156[u171] = false;

                if u174 ~= u155[u171] then
                    RequestViewingUpdate(u171);

                    return;
                end;

                if u10:get() ~= u171 then
                    return;
                end;

                UpdateEquipped(u171);
                local v175 = u36[u171];

                if v175 then
                    u14:set(v175);
                end;

                u15:set(u3:GetCapacity(u171):expect() or nil);
            end);
        end;
    end);
    u3.ItemLocked:Connect(function(p176, p177, u178) -- Line: 1304
        -- upvalues: u36 (copy), CompileRawItem (copy), u19 (copy), u155 (copy), u156 (copy), RequestViewingUpdate (copy), u10 (copy), UpdateEquipped (copy), u14 (copy), u3 (copy), u15 (copy)
        local v179 = u36[u178];

        if v179 then
            local _UUID = p176._UUID;

            if not v179[_UUID] then
                return;
            end;

            v179[_UUID] = CompileRawItem(p176);
            local v180 = u19:get();

            if v180 and (v179[_UUID] and v180.Identifier == _UUID) then
                u19:set(v179[_UUID]);
            end;

            local u181 = (u155[u178] or 0) + 1;
            u155[u178] = u181;

            if u156[u178] then
                return;
            end;

            u156[u178] = true;
            task.delay(0.05, function() -- Line: 1225
                -- upvalues: u156 (ref), u178 (copy), u181 (copy), u155 (ref), RequestViewingUpdate (ref), u10 (ref), UpdateEquipped (ref), u36 (ref), u14 (ref), u3 (ref), u15 (ref)
                u156[u178] = false;

                if u181 ~= u155[u178] then
                    RequestViewingUpdate(u178);

                    return;
                end;

                if u10:get() ~= u178 then
                    return;
                end;

                UpdateEquipped(u178);
                local v182 = u36[u178];

                if v182 then
                    u14:set(v182);
                end;

                u15:set(u3:GetCapacity(u178):expect() or nil);
            end);
        end;
    end);
    u3.ViewInventory:Connect(function(p183) -- Line: 1323
        print(p183);
    end);
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1327
        -- upvalues: u6 (copy), Parent (copy), u2 (copy)
        u6:set(Parent.Visible);
        u2:PlaySound(u6:get() and "Inventory/inv_open" or "Inventory/inv_close");
    end);
    UserInputService.InputBegan:Connect(function(p184, p185) -- Line: 1332
        -- upvalues: Parent (copy), Indexing (copy), u8 (copy)
        if p185 then
            return;
        end;

        if p184.KeyCode == Enum.KeyCode.K and Parent.Visible then
            Indexing.Search:CaptureFocus();

            return;
        end;

        if p184.KeyCode == Enum.KeyCode.Tab and Parent.Visible then
            u8:set(not u8:get());
        end;
    end);
    task.spawn(function() -- Line: 1344
        -- upvalues: LocalPlayer (ref), UpdateEquipped (copy), u130 (copy), u19 (copy), u3 (copy), u37 (copy)
        local Data = LocalPlayer:WaitForChild("Data");

        local function GetEquippedValue(u186, u187) -- Line: 1346
            -- upvalues: UpdateEquipped (ref), u130 (ref), u19 (ref), Data (copy)
            UpdateEquipped(u186 .. "Inventory");
            task.defer(u130.Render, u130);
            task.defer(function() -- Line: 1351
                -- upvalues: u19 (ref), u187 (copy), Data (ref), u186 (copy)
                local v188 = u19:get();
                local v189;

                if u187 then
                    v189 = Data[u187];
                else
                    v189 = Data[u186];
                end;

                local v190 = v189:GetAttribute("UUID");

                if not v188 or (not v188 or v188.Type ~= u186) then
                    return;
                end;

                if v188.Identifier == v190 or v190 == nil then
                    u19:set(v188);
                end;
            end);
        end;

        u3.SkinStateChanged:Connect(function(p191) -- Line: 1368
            -- upvalues: u37 (ref), u3 (ref), u130 (ref), u19 (ref), Data (copy)
            task.wait();

            if u37.SkinInventory == nil then
                u37.SkinInventory = {};
            end;

            u37.SkinInventory = u3:GetEquippedSkins(true):expect();
            task.defer(u130.Render, u130);
            local u192 = nil;
            local u193 = "Skin";
            task.defer(function() -- Line: 1351
                -- upvalues: u19 (ref), u192 (copy), Data (ref), u193 (copy)
                local v194 = u19:get();
                local v195;

                if u192 then
                    v195 = Data[u192];
                else
                    v195 = Data[u193];
                end;

                local v196 = v195:GetAttribute("UUID");

                if not v194 or (not v194 or v194.Type ~= u193) then
                    return;
                end;

                if v194.Identifier == v196 or v196 == nil then
                    u19:set(v194);
                end;
            end);
        end);
        Data.Ability:GetAttributeChangedSignal("UUID"):Connect(function() -- Line: 1373
            -- upvalues: u37 (ref), LocalPlayer (ref), u130 (ref), u19 (ref), Data (copy)
            if u37.AbilityInventory == nil then
                u37.AbilityInventory = {};
            end;

            u37.AbilityInventory = {
                [LocalPlayer.Data.Ability:GetAttribute("UUID")] = true
            };
            task.defer(u130.Render, u130);
            local u197 = nil;
            local u198 = "Ability";
            task.defer(function() -- Line: 1351
                -- upvalues: u19 (ref), u197 (copy), Data (ref), u198 (copy)
                local v199 = u19:get();
                local v200;

                if u197 then
                    v200 = Data[u197];
                else
                    v200 = Data[u198];
                end;

                local v201 = v200:GetAttribute("UUID");

                if not v199 or (not v199 or v199.Type ~= u198) then
                    return;
                end;

                if v199.Identifier == v201 or v201 == nil then
                    u19:set(v199);
                end;
            end);
        end);
        Data.EquippedKillEffect:GetAttributeChangedSignal("UUID"):Connect(function() -- Line: 1377
            -- upvalues: UpdateEquipped (ref), u130 (ref), u19 (ref), Data (copy)
            UpdateEquipped("KillEffectInventory");
            task.defer(u130.Render, u130);
            local u202 = "EquippedKillEffect";
            local u203 = "KillEffect";
            task.defer(function() -- Line: 1351
                -- upvalues: u19 (ref), u202 (copy), Data (ref), u203 (copy)
                local v204 = u19:get();
                local v205;

                if u202 then
                    v205 = Data[u202];
                else
                    v205 = Data[u203];
                end;

                local v206 = v205:GetAttribute("UUID");

                if not v204 or (not v204 or v204.Type ~= u203) then
                    return;
                end;

                if v204.Identifier == v206 or v206 == nil then
                    u19:set(v204);
                end;
            end);
        end);
        Data.EquippedMount:GetAttributeChangedSignal("UUID"):Connect(function() -- Line: 1381
            -- upvalues: UpdateEquipped (ref), u130 (ref), u19 (ref), Data (copy)
            UpdateEquipped("MountInventory");
            task.defer(u130.Render, u130);
            local u207 = "EquippedMount";
            local u208 = "Mount";
            task.defer(function() -- Line: 1351
                -- upvalues: u19 (ref), u207 (copy), Data (ref), u208 (copy)
                local v209 = u19:get();
                local v210;

                if u207 then
                    v210 = Data[u207];
                else
                    v210 = Data[u208];
                end;

                local v211 = v210:GetAttribute("UUID");

                if not v209 or (not v209 or v209.Type ~= u208) then
                    return;
                end;

                if v209.Identifier == v211 or v211 == nil then
                    u19:set(v209);
                end;
            end);
        end);
    end);
    debug.setmemorycategory("Inventory V2");
end;