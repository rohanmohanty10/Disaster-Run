  

 

local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local StandsModule = require(PathShortcuts.StandsModule);
require(PathShortcuts.KnitPath.Trove);
local Knit = require(PathShortcuts.KnitPath.Knit);
local StatsHandler = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").StatsHandler);
local TraitHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Knit.GetService("InventoryService");
local u2 = Knit.GetService("MountService");
local u3 = Knit.GetService("KillEffectService");
local u4 = game.Players.LocalPlayer or {};
local u5 = table.find({ 110231579, 186015418, 4217348366 }, u4.UserId);
local u6 = game.GameId == 1782832995 and 1.5 or 0.5;
local u7 = {};
u7.__index = u7;

function u7.new(p8, p9, p10) -- Line: 24
    -- upvalues: u7 (copy)
    local v11 = {
        MetaData = p10,
        CurrencyString = p10.CurrencyString,
        PremiumCurrencyString = p10.PremiumCurrencyString,
        Button = script.Button,
        Buttons = p8.Buttons,
        Description = p8.Description,
        Name = p8.Label,
        Rarity = p8.Rarity,
        Trove = p9.new()
    };
    setmetatable(v11, u7);

    return v11;
end;

local u12 = {};

local function GetUUIDData(p13) -- Line: 40
    -- upvalues: u12 (copy)
    if type(p13) == "string" then
        local v14 = p13:split("/");
        local v15 = v14[1];
        local v16 = v14[2];
        local u17 = "";

        for i = 1, #v15 do
            u17 = u17 .. string.byte(v15:sub(i, i)) - 65;
        end;

        local u18 = u12[u17];
        pcall(function() -- Line: 55
            -- upvalues: u18 (ref), u17 (ref)
            if u18 then
                return;
            end;

            u18 = game.Players:GetNameFromUserIdAsync((tonumber(u17)));
        end);

        if not u12[u17] and u18 then
            u12[u17] = u18;
        end;

        return {
            UserId = u17,
            Time = v16,
            Creator = u18
        };
    end;
end;

function u7.ShowUUIDData(p19, p20) -- Line: 71
    -- upvalues: GetUUIDData (copy)
    local v21 = GetUUIDData(p19);

    if not v21 then
        return;
    end;

    if v21.Creator then
        p20.Text = p20.Text .. `Creator: {v21.Creator}\n`;
    end;

    if v21.Time then
        p20.Text = p20.Text .. `Date: {os.date("%x %X", v21.Time)}\n`;
    end;
end;

function u7.CreateAbilityInfoTab(u22, u23, p24) -- Line: 84
    -- upvalues: ItemData (copy), u5 (copy), TraitHandler (copy), u7 (copy), u1 (copy), u6 (copy)
    local _ = u22.Trove;
    local _ = u22.Buttons;
    local Rarity = u22.Rarity;
    local Description = u22.Description;
    u22.Name.Text = tostring(u23.DisplayName or u23.Name);
    local v25 = ItemData.Rarities[u23.Rarity];
    Rarity.Text = v25.Name;
    Rarity.TextColor3 = v25.Color;

    if u23.Prefix then
        Rarity.Text = Rarity.Text .. " " .. (u23.Prefix.Name or "");
    end;

    if u23.Title then
        Rarity.Text = u23.Title;
    end;

    u22:DisplayTradeable(p24);

    if u5 then
        local Label = Description.Label;
        Label.Text = Label.Text .. `ItemId: {p24._ItemId}\n`;
    end;

    if p24._TraitInfo then
        local v26 = TraitHandler.GetTraitData(p24._TraitInfo.Trait);
        local v27 = "";

        if p24._TraitInfo.Hexed and v26.HexPrefix then
            v27 = v27 .. `{v26.HexPrefix} `;
        end;

        local Label = Description.Label;
        Label.Text = Label.Text .. `Trait: {v27 .. p24._TraitInfo.Trait}\n`;
    end;

    if #u23.Description > 0 then
        local Label = Description.Label;
        Label.Text = Label.Text .. "Description: " .. u23.Description .. "\n";
    end;

    local u28 = {
        ItemId = p24._ItemId,
        UUID = p24._UUID
    };
    u7.ShowUUIDData(p24._UUID, Description.Label);
    u22:DisplayButton("Equip", function() -- Line: 136
        -- upvalues: u23 (copy), u22 (copy), u28 (copy), u1 (ref)
        local v29 = string.format("Do you want to equip this ability?\n[%s]", u23.Name);
        u22.MetaData.NewPrompt({
            Title = u23.Name,
            Text = v29,
            Options = { "Equip", "Cancel" },

            Callback = function(p30) -- Line: 145, Name: Callback
                -- upvalues: u22 (ref), u28 (ref), u1 (ref)
                if p30.Choice ~= 1 then
                    return;
                end;

                u22:Clean();
                u28.Equip = true;
                u1.AbilityInventory:Fire(u28);
                u22.MetaData.ShowStoreAbilityTab(true);
            end
        });
    end);

    if not p24._Locked then
        u22:DisplayButton("Remove", function() -- Line: 156
            -- upvalues: u23 (copy), u22 (copy), u6 (ref), u28 (copy), u1 (ref)
            local v31 = string.format("Are you sure you want to remove this ability?\n[%s]", u23.Name);
            u22.MetaData.NewPrompt({
                Title = u23.Name,
                Text = v31,
                Options = { "Remove", "Cancel" },

                Callback = function(p32) -- Line: 165, Name: Callback
                    -- upvalues: u23 (ref), u22 (ref), u6 (ref), u28 (ref), u1 (ref)
                    if p32.Choice ~= 1 then
                        return;
                    end;

                    local v33 = string.format("NOTE: REMOVING AN ABILITY IS PERMANENT AND CANNOT BE UNDONE\n[%s]", u23.Name);
                    u22.MetaData.NewPrompt({
                        Title = u23.Name,
                        Text = v33,
                        Delay = u6,
                        Options = { "Remove", "Cancel" },

                        Callback = function(p34) -- Line: 176, Name: Callback
                            -- upvalues: u22 (ref), u28 (ref), u1 (ref)
                            if p34.Choice ~= 1 then
                                return;
                            end;

                            u22:Clean();
                            u28.Remove = true;
                            u1.AbilityInventory:Fire(u28);
                            u22.MetaData.ShowStoreAbilityTab(true);
                        end
                    });
                end
            });
        end);
    end;

    u22:DisplayLock(p24, u23);
end;

function u7.CreateSkinInfoTab(u35, u36, u37) -- Line: 192
    -- upvalues: ItemData (copy), StandsModule (copy), u5 (copy), u7 (copy), u1 (copy), u6 (copy)
    local _ = u35.Trove;
    local _ = u35.Buttons;
    local Rarity = u35.Rarity;
    local Description = u35.Description;
    u35.Name.Text = tostring(u36.DisplayName or u36.Name);
    local v38 = ItemData.Rarities[u36.Rarity];
    Rarity.Text = v38.Name;
    Rarity.TextColor3 = v38.Color;
    u35:DisplayTradeable(u37);
    u35:DisplayPrice(u36);

    if #u36.Description > 0 then
        local Label = Description.Label;
        Label.Text = Label.Text .. u36.Description .. "\n";
    end;

    local Label = Description.Label;
    local Text = Label.Text;
    local v39 = StandsModule[tonumber(u36.LinkedAbilityId)];
    Label.Text = Text .. "<font size=\"28\">" .. "Ability: " .. tostring(v39) .. "</font>\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {u37._ItemId}\n`;
    end;

    u7.ShowUUIDData(u37._UUID, Description.Label);
    u35:DisplayButton("Equip", function() -- Line: 218
        -- upvalues: u37 (copy), u36 (copy), u35 (copy), u1 (ref)
        local u40 = {
            EquipSkin = true,
            UUID = u37._UUID
        };
        local v41 = `Do you want to equip {u36.Name}?`;
        u35.MetaData.NewPrompt({
            Delay = 0.5,
            Title = u36.Name,
            Text = v41,
            Options = { "Equip", "Cancel" },

            Callback = function(p42) -- Line: 232, Name: Callback
                -- upvalues: u35 (ref), u1 (ref), u40 (copy)
                if p42.Choice ~= 1 then
                    return;
                end;

                u35:Clean();
                u1.SkinInventory:Fire(u40);
            end
        });
    end);
    u35:DisplayButton("Remove", function() -- Line: 240
        -- upvalues: u37 (copy), u36 (copy), u35 (copy), u6 (ref), u1 (ref)
        local u43 = {
            Remove = true,
            UUID = u37._UUID
        };
        local v44 = string.format("NOTE: REMOVING A SKIN IS PERMANENT AND CANNOT BE UNDONE\n[%s]", u36.Name);
        u35.MetaData.NewPrompt({
            Title = u36.Name,
            Text = v44,
            Delay = u6,
            Options = { "Remove", "Cancel" },

            Callback = function(p45) -- Line: 254, Name: Callback
                -- upvalues: u35 (ref), u1 (ref), u43 (copy)
                if p45.Choice ~= 1 then
                    return;
                end;

                u35:Clean();
                u1.SkinInventory:Fire(u43);
                u35.MetaData.ShowInventoryCapacity("SkinInventory");
            end
        });
    end);
end;

function u7.CreateItemInfoTab(u46, u47, u48, p49) -- Line: 265
    -- upvalues: ItemData (copy), u5 (copy), u7 (copy), u1 (copy), u6 (copy)
    local _ = u46.Trove;
    local _ = u46.Buttons;
    local Rarity = u46.Rarity;
    local Description = u46.Description;
    u46.Name.Text = tostring(u47.DisplayName or u47.Name);
    local v50 = ItemData.Rarities[u47.Rarity];
    Rarity.Text = v50.Name;
    Rarity.TextColor3 = v50.Color;
    u46:DisplayTradeable(u48);
    local Label = Description.Label;
    Label.Text = Label.Text .. u47.Description .. "\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {u48._ItemId}\n`;
    end;

    u7.ShowUUIDData(u48._UUID, Description.Label);
    local v51 = u47.Currency and "Consume" or (u47.CrateType and "Open" or u47.Tool and "Equip");

    if type(v51) == "string" then
        u46:DisplayButton(v51, function() -- Line: 291
            -- upvalues: u46 (copy), u48 (copy), u1 (ref)
            u46:Clean();
            u1.ItemInventory:Fire({
                ItemId = u48._ItemId,
                UUID = u48._UUID
            });
            u46.MetaData.ShowInventoryCapacity("ItemInventory");
            u46.MetaData.ShowAddItemsTab(true);
        end);
    end;

    u46:DisplayButton("Remove", function() -- Line: 303
        -- upvalues: u48 (copy), u47 (copy), u46 (copy), u6 (ref), u1 (ref)
        local u52 = {
            Remove = true,
            ItemId = u48._ItemId,
            UUID = u48._UUID
        };
        local v53 = `NOTE: REMOVING AN ITEM IS PERMANENT AND CANNOT BE UNDONE\n[{u47.Name}]`;
        u46.MetaData.NewPrompt({
            Title = u47.Name,
            Text = v53,
            Delay = u6,
            Options = { "Remove", "Cancel" },

            Callback = function(p54) -- Line: 318, Name: Callback
                -- upvalues: u46 (ref), u52 (copy), u1 (ref)
                if p54.Choice ~= 1 then
                    return;
                end;

                u46:Clean();
                u52.Remove = true;
                u1.ItemInventory:Fire(u52);
                u46.MetaData.ShowInventoryCapacity("ItemInventory");
                u46.MetaData.ShowAddItemsTab(true);
            end
        });
    end);
end;

function u7.CreateXPInfoTab(p55, p56, p57) -- Line: 331
    -- upvalues: ItemData (copy), u5 (copy), u7 (copy)
    local _ = p55.Trove;
    local _ = p55.Buttons;
    local Rarity = p55.Rarity;
    local Description = p55.Description;
    p55.Name.Text = tostring(p56.DisplayName or p56.Name);
    local v58 = ItemData.Rarities[p56.Rarity];
    Rarity.Text = v58.Name;
    Rarity.TextColor3 = v58.Color;
    p55:DisplayTradeable(p57);
    local Label = Description.Label;
    Label.Text = Label.Text .. p56.Description .. "\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {p57._ItemId}\n`;
    end;

    u7.ShowUUIDData(p57._UUID, Description.Label);
end;

function u7.CreateMountInfoTab(u59, u60, u61) -- Line: 354
    -- upvalues: ItemData (copy), u5 (copy), u2 (copy), u6 (copy), u1 (copy)
    local _ = u59.Trove;
    local _ = u59.Buttons;
    local Rarity = u59.Rarity;
    local Description = u59.Description;
    u59.Name.Text = `{u60.Name}`;
    local Color = ItemData.Rarities[u60.Rarity].Color;
    local v62 = ItemData.Rarities[u60.Rarity];
    Rarity.Text = v62.Name;
    Rarity.TextColor3 = v62.Color;
    u59:DisplayTradeable(u61);
    local Label = Description.Label;
    Label.Text = Label.Text .. u60.Description .. "\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {u61._ItemId}\n`;
    end;

    u59:DisplayButton("Equip", function() -- Line: 379
        -- upvalues: u60 (copy), u59 (copy), u2 (ref), u61 (copy)
        local v63 = `Do you want to equip this mount?\n{u60.Name}`;
        u59.MetaData.NewPrompt({
            Title = u60.Name,
            Text = v63,
            Options = { "Equip", "Cancel" },

            Callback = function(p64) -- Line: 388, Name: Callback
                -- upvalues: u2 (ref), u61 (ref)
                if p64.Choice ~= 1 then
                    return;
                end;

                u2:EquipMount(u61._ItemId);
            end
        });
    end);
    u59:DisplayButton("Remove", function() -- Line: 395
        -- upvalues: u61 (copy), Color (copy), u60 (copy), u59 (copy), u6 (ref), u1 (ref)
        local u65 = {
            Remove = true,
            ItemId = u61._ItemId,
            UUID = u61._UUID
        };
        local v66 = string.format(`<font color="#FF0000">NOTE: REMOVING A MOUNT IS PERMANENT AND CANNOT BE UNDONE</font>\n<font color="#{Color:ToHex()}">[%s]</font>`, u60.Name);
        u59.MetaData.NewPrompt({
            Title = "Remove Mount",
            Text = v66,
            Delay = u6,
            Options = { "Remove", "Cancel" },

            Callback = function(p67) -- Line: 411, Name: Callback
                -- upvalues: u59 (ref), u1 (ref), u65 (copy)
                if p67.Choice ~= 1 then
                    return;
                end;

                u59:Clean();
                u1.MountInventory:Fire(u65);
                u59.MetaData.ShowInventoryCapacity("MountInventory");
            end
        });
    end);
end;

function u7.CreateKillEffectInfoTab(u68, u69, u70) -- Line: 421
    -- upvalues: ItemData (copy), u5 (copy), u3 (copy), u4 (copy), u6 (copy), u1 (copy), EffectsHandler (copy)
    local _ = u68.Trove;
    local _ = u68.Buttons;
    local Rarity = u68.Rarity;
    local Description = u68.Description;
    u68.Name.Text = `{u69.Name}`;
    local v71 = ItemData.Rarities[u69.Rarity];
    local Color = v71.Color;
    Rarity.Text = v71.Name;
    Rarity.TextColor3 = Color;
    u68:DisplayTradeable(u70);
    local Label = Description.Label;
    Label.Text = Label.Text .. u69.Description .. "\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {u70._ItemId}\n`;
    end;

    u68:DisplayButton("Equip", function() -- Line: 443
        -- upvalues: Color (copy), u69 (copy), u68 (copy), u3 (ref), u70 (copy)
        local v72 = `Do you want to equip this kill effect?\n<font color="#{Color:ToHex()}">{u69.Name}</font>`;
        u68.MetaData.NewPrompt({
            Title = "Equip Kill Effect",
            RichText = true,
            Text = v72,
            Options = { "Equip", "Cancel" },

            Callback = function(p73) -- Line: 453, Name: Callback
                -- upvalues: u3 (ref), u70 (ref), u68 (ref), u69 (ref)
                if p73.Choice ~= 1 then
                    return;
                end;

                u3:EquipKillEffect(u70._ItemId);
                task.delay(0.05, function() -- Line: 458
                    -- upvalues: u68 (ref), u69 (ref), u70 (ref)
                    u68:Clean();
                    u68:CreateKillEffectInfoTab(u69, u70);
                end);
            end
        });
    end);
    local EquippedKillEffect = u4:FindFirstChild("Data"):FindFirstChild("EquippedKillEffect");

    if EquippedKillEffect and EquippedKillEffect.Value == u69.ItemId then
        u68:DisplayButton("Unequip", function() -- Line: 470
            -- upvalues: u4 (ref), u69 (copy), u3 (ref), u70 (copy), u68 (copy)
            if u4 and u4:FindFirstChild("Data") then
                local EquippedKillEffect2 = u4:FindFirstChild("Data"):FindFirstChild("EquippedKillEffect");

                if EquippedKillEffect2 and EquippedKillEffect2.Value == u69.ItemId then
                    u3:UnequipKillEffect(u70._ItemId);
                    task.delay(0.05, function() -- Line: 479
                        -- upvalues: u68 (ref), u69 (ref), u70 (ref)
                        u68:Clean();
                        u68:CreateKillEffectInfoTab(u69, u70);
                    end);
                end;
            end;
        end);
    end;

    u68:DisplayButton("Remove", function() -- Line: 488
        -- upvalues: u70 (copy), Color (copy), u69 (copy), u68 (copy), u6 (ref), u1 (ref)
        local u74 = {
            Remove = true,
            UUID = u70._UUID
        };
        local v75 = string.format(`<font color="#FF0000">NOTE: REMOVING A KILL EFFECT IS PERMANENT AND CANNOT BE UNDONE</font>\n<font color="#{Color:ToHex()}">[%s]</font>`, u69.Name);
        u68.MetaData.NewPrompt({
            Title = "Remove Item",
            RichText = true,
            Text = v75,
            Delay = u6,
            Options = { "Remove", "Cancel" },

            Callback = function(p76) -- Line: 503, Name: Callback
                -- upvalues: u68 (ref), u1 (ref), u74 (copy)
                if p76.Choice ~= 1 then
                    return;
                end;

                u68:Clean();
                u1.KillEffectInventory:Fire(u74);
                u68.MetaData.ShowInventoryCapacity("KillEffectInventory");
            end
        });
    end);
    u68:DisplayButton("Preview", function() -- Line: 512
        -- upvalues: EffectsHandler (ref), u70 (copy)
        EffectsHandler.CallEffect("PreviewKillEffect", u70._ItemId);
    end);
end;

function u7.CreateEmoteInfoTab(p77, p78, u79) -- Line: 517
    -- upvalues: ItemData (copy), u5 (copy)
    local _ = p77.Trove;
    local _ = p77.Buttons;
    local Rarity = p77.Rarity;
    local Description = p77.Description;
    local MetaData = p77.MetaData;
    p77.Name.Text = `{p78.Name}`;
    local v80 = ItemData.Rarities[p78.Rarity];
    local Color = v80.Color;
    Rarity.Text = v80.Name;
    Rarity.TextColor3 = Color;
    p77:DisplayTradeable(u79);
    local Label = Description.Label;
    Label.Text = Label.Text .. p78.Description .. "\n";

    if u5 then
        local Label2 = Description.Label;
        Label2.Text = Label2.Text .. `ItemId: {u79._ItemId}\n`;
    end;

    p77:DisplayButton("Equip", function() -- Line: 540
        -- upvalues: MetaData (copy), u79 (copy)
        MetaData._ReturnMenu = "Inventory";
        MetaData:SetBindingEmote(u79._ItemId);
        MetaData:ShowEmoteWheel();
        MetaData:SetMenu(false, {
            Manual = true
        });
    end);
end;

function u7.CreateAddItemsTab(u81) -- Line: 579
    -- upvalues: u1 (copy)
    u81.MetaData.ShowInventoryCapacity("ItemInventory", true);
    u81:DisplayButton("Add To Item Inventory", function() -- Line: 581
        -- upvalues: u81 (copy), u1 (ref)
        u81:Clean();
        local v82 = u1:GetCapacity("ItemInventory"):expect() or {};

        if v82.MaxCapacity - v82.CurrentCapacity <= 0 then
            u81.MetaData:Notify("MAX CAPACITY", "Your item won\'t be stored due to inventory being full", 3);

            return;
        end;

        u1.ItemInventory:Fire({
            AddItems = true
        });
        task.delay(0.1, function() -- Line: 592
            -- upvalues: u81 (ref)
            u81:CreateAddItemsTab();
        end);
    end);
end;

function u7.CreateStoreAbilityTab(p83) -- Line: 598
    p83.MetaData.ShowInventoryCapacity("AbilityInventory", true);
end;

function u7.CreateUnequipSkinTab(u84) -- Line: 602
    -- upvalues: u4 (copy), u1 (copy), u6 (copy)
    u84.MetaData.ShowInventoryCapacity("SkinInventory", true);
    u84:DisplayButton("Unequip Current Skin", function() -- Line: 604
        -- upvalues: u4 (ref), u1 (ref)
        if u4.Data.Skin.Value == "0" then
            return;
        end;

        u1.SkinInventory:Fire({
            EquipSkin = false,
            AbilityId = u4.Data.Ability.Value
        });
    end);
    u84:DisplayButton("Mass Delete", function() -- Line: 612
        -- upvalues: u84 (copy), u6 (ref)
        u84:Clean();
        u84.MetaData.SetMassDelete(true);
        u84:DisplayButton("Delete", function() -- Line: 615
            -- upvalues: u84 (ref), u6 (ref)
            u84.MetaData.NewPrompt({
                Title = "Mass Delete",
                Text = "Are you sure you want to delete these skins?",
                Delay = u6,
                Options = { "Yes", "No" },

                Callback = function(p85) -- Line: 624, Name: Callback
                    -- upvalues: u84 (ref)
                    u84.MetaData.SetMassDelete(nil);

                    if p85.Choice ~= 1 then
                        return;
                    end;

                    u84:Clean();
                    u84.MetaData.MassDelete();
                end
            });
        end);
    end);
end;

function u7.DisplayTradeable(p86, p87) -- Line: 635
    local v88 = p87._Tradeable and "<font size=\"28\"><font color=\"rgb(0, 255, 0)\">Tradeable</font></font>" or (p87._Tradeable == false and "<font size=\"28\"><font color=\"rgb(255, 0, 0)\">Not Tradeable</font></font>" or "");

    if #v88 <= 0 then
        return;
    end;

    local Label = p86.Description.Label;
    Label.Text = Label.Text .. v88 .. "\n";
end;

function u7.DisplayButton(p89, p90, p91) -- Line: 647
    local v92 = p89.Trove:Clone(p89.Button);
    v92.TextLabel.Text = p90;
    v92.MouseButton1Click:Connect(p91);
    v92.Visible = true;
    v92.Parent = p89.Buttons;
end;

function u7.DisplayLock(u93, u94, u95) -- Line: 656
    -- upvalues: u6 (copy), u1 (copy)
    local _Locked = u94._Locked;
    u93:DisplayButton(_Locked and "Unlock" or "Lock", function() -- Line: 658
        -- upvalues: _Locked (copy), u95 (copy), u93 (copy), u6 (ref), u1 (ref), u94 (copy)
        local v96 = string.format("Are you sure you want to %s this item?", _Locked and "unlock" or "lock");
        local v97 = string.format("%s [%s]", _Locked and "Unlock" or "Lock", u95.Name);
        u93.MetaData.NewPrompt({
            Title = v97,
            Text = v96,
            Delay = u6,
            Options = { "Yes", "No" },

            Callback = function(p98) -- Line: 669, Name: Callback
                -- upvalues: u93 (ref), u1 (ref), _Locked (ref), u94 (ref)
                if p98.Choice ~= 1 then
                    return;
                end;

                u93:Clean();
                u93.MetaData.ShowInventoryCapacity("AbilityInventory");
                u1.ItemLocked:Fire(not _Locked, u94._UUID);
            end
        });
    end);
end;

function u7.DisplayPrice(p99, p100) -- Line: 679
    local Description = p99.Description;
    local v101 = "";

    if p100.Price then
        v101 = v101 .. "<font size=\"28\"><font color=\"rgb(75,170,255)\">" .. tostring(p100.Price) .. " " .. p99.CurrencyString .. "</font></font>";
    end;

    if p100.PremiumPrice then
        if p100.Price then
            v101 = v101 .. "<font size=\"28\">/</font>";
        end;

        v101 = v101 .. "<font size=\"28\"><font color=\"rgb(255,200,100)\">" .. tostring(p100.PremiumPrice) .. " " .. p99.PremiumCurrencyString .. "</font></font>";
    end;

    if #v101 <= 0 then
        return;
    end;

    local Label = Description.Label;
    Label.Text = Label.Text .. v101 .. "\n";
end;

function u7.DisplayMoveset(p102, p103) -- Line: 693
    -- upvalues: StatsHandler (copy)
    local Description = p102.Description;
    local v104 = StatsHandler.GetStats(p103.Name);

    if not v104 then
        return;
    end;

    for i, v in pairs(v104.Moveset.Moves) do
        local Label = Description.Label;
        Label.Text = Label.Text .. string.format("[ %s ] = %s\n", i, v);
    end;
end;

function u7.Clean(p105) -- Line: 702
    p105.Name.Text = "";
    p105.Rarity.Text = "";
    p105.Description.Label.Text = "";
    p105.Trove:Clean();
end;

return u7;