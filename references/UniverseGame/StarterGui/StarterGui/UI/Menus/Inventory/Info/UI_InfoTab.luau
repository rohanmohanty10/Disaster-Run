  

 

return function(u1) -- Line: 1
    require(game.ReplicatedStorage.ReplicatedModules.ItemData);
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.StandsModule);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local _ = require(PathShortcuts.ReplicatedModules.Movesets).Movesets;
    local _ = game.ReplicatedStorage.Remotes.InventoryInfo;
    local u2 = u1.Knit.GetService("InventoryService");
    local InfoTabHandler = require(script.InfoTabHandler);
    local Parent = script.Parent;
    local Buttons = Parent.Buttons;
    local Description = Parent.Description;
    local _ = Parent.Label;
    local _ = Parent.Rarity;
    local u3 = InfoTabHandler.new(Parent, Trove, u1);
    local u4 = false;
    local u5 = false;
    local u6 = 0;
    local u7 = nil;
    local u8 = nil;

    function u1.SetInfoTab(p9) -- Line: 34
        -- upvalues: u3 (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), Parent (copy)
        u3:Clean();
        u4 = false;
        u5 = false;
        u6 = p9.AmountLeft or 0;
        u7 = p9.ItemInfo;
        u8 = p9.ItemObject;

        if u7.Type == "Ability" then
            u3:CreateAbilityInfoTab(u7, u8);
        elseif u7.Type == "Skin" then
            u3:CreateSkinInfoTab(u7, u8);
        elseif u7.Type == "Item" then
            u3:CreateItemInfoTab(u7, u8);
        elseif u7.Type == "Experience" then
            u3:CreateXPInfoTab(u7, u8);
        elseif u7.Type == "Mount" then
            u3:CreateMountInfoTab(u7, u8);
        elseif u7.Type == "Emote" then
            u3:CreateEmoteInfoTab(u7, u8);
        else
            u3[`Create{u7.Type}InfoTab`](u3, u7, u8);
        end;

        Parent.Visible = true;
    end;

    function u1.ShowAddItemsTab(p10) -- Line: 61
        -- upvalues: u3 (copy)
        u3:Clean();

        if not p10 then
            return;
        end;

        u3:CreateAddItemsTab();
    end;

    function u1.ShowStoreAbilityTab(p11) -- Line: 67
        -- upvalues: u3 (copy)
        u3:Clean();

        if not p11 then
            return;
        end;

        u3:CreateStoreAbilityTab();
    end;

    function u1.ShowUnequipSkinTab(p12) -- Line: 73
        -- upvalues: u3 (copy)
        u3:Clean();

        if not p12 then
            return;
        end;

        u3:CreateUnequipSkinTab();
    end;

    function u1.ShowInventoryCapacity(p13, p14, p15) -- Line: 79
        -- upvalues: u2 (copy), Description (copy), Parent (copy), u1 (copy)
        local v16 = u2:GetCapacity(p13):expect();

        if not v16 then
            return;
        end;

        Description.Label.Text = string.format("Current Capacity: %s\nMax Capacity: %s", v16.CurrentCapacity, v16.MaxCapacity);
        Parent.Visible = true;
        local v17 = v16.MaxCapacity - v16.CurrentCapacity;

        if v17 <= 5 and not p14 then
            u1:Notify("REACHING MAX CAPACITY", v17 == 0 and string.format("Your [%s] is full, additional stores won\'t be saved", p13) or string.format("You have [%s] remaining Capacity left in [%s]", v17, p13), p15 or 3);
        end;
    end;

    u1.InventorySignals.ItemSelected:Connect(function(p18) -- Line: 91
        -- upvalues: u1 (copy)
        if p18.BlackMarket then
            return;
        end;

        u1.SetInfoTab(p18);
    end);
    Buttons.Button.Visible = false;
end;