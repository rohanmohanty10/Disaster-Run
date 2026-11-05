  

 

return function(p1) -- Line: 1
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Promise = require(PathShortcuts.KnitPath.Promise);
    require(PathShortcuts.KnitPath.Trove);
    local Items = script.Parent.Tabs.Items;
    p1.LastInventoryTab = nil;

    function p1.SetInventoryTab(p2, p3) -- Line: 8
        -- upvalues: Promise (copy), Items (copy)
        if p3 == "Back" and p2.LastInventoryTab then
            p3 = p2.LastInventoryTab;
        end;

        if p3 == "Menu" then
            script.Parent.Back.Text = "Menu";
        else
            script.Parent.Back.Text = "Back";
        end;

        if p3 then
            Promise.try(p2.ShowInventoryCapacity, p3):catch(warn):finallyCall(p2.ShowInventoryItems, p3):catch(warn);
        end;

        if p3 == "All" then
            Promise.try(p2.ShowAllInventoryItems):catch(warn);
        end;

        if p3 == "ItemInventory" then
            p2.ShowAddItemsTab(true);
        elseif p3 == "AbilityInventory" then
            p2.ShowStoreAbilityTab(true);
        elseif p3 == "SkinInventory" then
            p2.ShowUnequipSkinTab(true);
        else
            p2.ShowAddItemsTab(false);
            p2.ShowStoreAbilityTab(false);
            p2.ShowUnequipSkinTab(false);
        end;

        Items.Visible = true;
        p2.LastInventoryTab = p3;
    end;
end;