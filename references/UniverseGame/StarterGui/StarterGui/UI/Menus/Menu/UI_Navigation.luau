  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local UserInputService = game:GetService("UserInputService");
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 4
        -- upvalues: UserInputService (copy)
        script.Parent.Mobile.Visible = UserInputService.TouchEnabled;
    end);
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    Core.OnStart():await();
    local v2 = Core.GetClientService("ConfigurationService"):GetFFlags():expect();
    local v3 = v2.new_inventory_enabled and "InventoryV2" or "Inventory";
    local u4 = PathShortcuts.LinkedPlaces[game.GameId].GameModePlace == game.PlaceId and {
        Products = "Products",
        Mobile = "MobileMenu",
        Quest = "Quests",
        Settings = "Settings",
        Ability = "Ability",
        Achievements = "Achievements",
        Menu = "Menu",
        Bank = v3
    } or {
        Products = "Products",
        Mobile = "MobileMenu",
        Quest = "Quests",
        Settings = "Settings",
        Trade = "TradeList",
        Ability = "Ability",
        Party = "PartyManagement",
        Achievements = "Achievements",
        Titles = "Titles",
        Rewards = "Rewards",
        DailyQuests = "DailyQuests",
        Menu = "Menu",
        Bank = v3
    };
    local u5 = {
        Bank = not v2.new_inventory_enabled and function() -- Line: 58
            -- upvalues: u1 (copy)
            u1:SetInventoryTab(u1.LastInventoryTab or "AbilityInventory");
        end or nil,

        Products = function() -- Line: 61, Name: Products
            -- upvalues: u1 (copy)
            u1:SetShopTab("Premium_Shop");
        end
    };
    local _ = game.PlaceId == 9690974327;

    local function OnClick(u6) -- Line: 70
        -- upvalues: u4 (ref), u5 (copy), u1 (copy)
        return function() -- Line: 71
            -- upvalues: u4 (ref), u6 (copy), u5 (ref), u1 (ref)
            local v7 = u4[u6.Name] or u6:GetAttribute("Menu");

            if v7 == "" then
                v7 = nil;
            end;

            if u5[u6.Name] then
                pcall(u5[u6.Name]);
            end;

            u1:PlaySound("Click");
            u1:SetMenu(v7);
        end;
    end;

    local v8 = table.find(PathShortcuts.LinkedPlaces[game.GameId], game.PlaceId);
    local v9 = {
        GameModePlace = {
            Party = true,
            Trade = true,
            Products = true,
            Bank = true
        }
    };

    for _, child in pairs(script.Parent:GetChildren()) do
        if v8 and v9[v8] then
            local v10 = false;

            for i, v in v9[v8] do
                if v and child.Name == i then
                    child:Destroy();
                    v10 = true;
                end;
            end;

            if not v10 then
                if child:IsA("TextButton") and u4[child.Name] then
                    child.MouseButton1Down:Connect(function() -- Line: 71
                        -- upvalues: u4 (ref), child (copy), u5 (copy), u1 (copy)
                        local v11 = u4[child.Name] or child:GetAttribute("Menu");

                        if v11 == "" then
                            v11 = nil;
                        end;

                        if u5[child.Name] then
                            pcall(u5[child.Name]);
                        end;

                        u1:PlaySound("Click");
                        u1:SetMenu(v11);
                    end);
                elseif child:IsA("TextButton") then
                    child.Visible = false;
                    child:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 119
                        -- upvalues: child (copy)
                        if not child.Visible then
                            return;
                        end;

                        child.Visible = false;
                    end);
                end;
            end;
        elseif child:IsA("TextButton") and u4[child.Name] then
            child.MouseButton1Down:Connect(function() -- Line: 71
                -- upvalues: u4 (ref), child (copy), u5 (copy), u1 (copy)
                local v11 = u4[child.Name] or child:GetAttribute("Menu");

                if v11 == "" then
                    v11 = nil;
                end;

                if u5[child.Name] then
                    pcall(u5[child.Name]);
                end;

                u1:PlaySound("Click");
                u1:SetMenu(v11);
            end);
        elseif child:IsA("TextButton") then
            child.Visible = false;
            child:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 119
                -- upvalues: child (copy)
                if not child.Visible then
                    return;
                end;

                child.Visible = false;
            end);
        end;
    end;
end;