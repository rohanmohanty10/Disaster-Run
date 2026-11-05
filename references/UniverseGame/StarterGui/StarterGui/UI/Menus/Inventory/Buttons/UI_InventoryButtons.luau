  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local InventoryButton = p1.FusionComponents.InventoryButton;
    InventoryButton(p1, {
        Name = "Items",
        Image = "rbxassetid://7305775896",
        InventoryType = "ItemInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, 8, 1, 8)
    });
    InventoryButton(p1, {
        Name = "Skins",
        Image = "http://www.roblox.com/asset/?id=8053195983",
        InventoryType = "SkinInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, -8, 1, -8)
    });
    InventoryButton(p1, {
        Name = "Stands",
        Image = "http://www.roblox.com/asset/?id=8053175710",
        InventoryType = "AbilityInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, 8, 1, 8)
    });
    InventoryButton(p1, {
        Name = "Mounts",
        Image = "http://www.roblox.com/asset/?id=17655110127",
        InventoryType = "MountInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, 8, 1, 8)
    });
    InventoryButton(p1, {
        Name = "Kill Effects",
        Image = "http://www.roblox.com/asset/?id=15057897409",
        InventoryType = "KillEffectInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, -8, 1, -8)
    });
    InventoryButton(p1, {
        Name = "Emotes",
        Image = "http://www.roblox.com/asset/?id=8053195983",
        InventoryType = "EmoteInventory",
        Parent = Parent,
        ImageSize = UDim2.new(1, -8, 1, -8)
    });
end;