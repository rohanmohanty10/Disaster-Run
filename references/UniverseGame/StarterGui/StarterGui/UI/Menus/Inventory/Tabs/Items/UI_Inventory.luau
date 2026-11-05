  

 

return function(u1) -- Line: 1
    local _ = u1.Xtal;
    u1.Data:WaitForChild("Inventory");
    local Assets = script:FindFirstAncestor("Inventory").Assets;
    local _ = Assets.Container;
    local Lock = Assets.Lock;
    local Equipped = Assets.Equipped;
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Skins);
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.KnitPath.Promise);
    require(PathShortcuts.KnitPath.Signal);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local Stack = require(PathShortcuts.ReplicatedModules.Classes.Stack);
    local u2 = u1.Knit.GetService("InventoryService");
    local u3 = {};
    u1.Inventory = {
        Loaded = {}
    };
    local Ability = u1.Player.Data.Ability;
    local u4 = Ability:GetAttribute("UUID");
    local Settings = u1.Player:WaitForChild("Settings");
    local u6 = {
        Quantity = function(p5) -- Line: 32
            -- upvalues: u3 (copy)
            return (u3[p5] or 0) * -1;
        end
    };
    local u7 = "SkinInventory";
    local u8 = {};
    local u9 = nil;
    local u10 = {};

    for _, v in ItemData.Rarities do
        local Name = v.Name;

        u6[Name] = function(p11) -- Line: 41
            -- upvalues: ItemData (copy), Name (copy)
            local v12 = ItemData.GetItemInfo(p11);

            if not v12 then
                return 999999;
            end;

            local v13 = ItemData.GetRarityData(v12.Rarity);

            return v13 and (v13.Name == Name and -1000000 or (v13.Value or 999999)) or 999999;
        end;
    end;

    local u14 = "Rarity (Highest)";
    local u15 = 1;
    local u16 = { "A - Z", "Z - A", "Quantity", "Rarity (Highest)", "Rarity (Lowest)" };
    local u17 = table.clone(u16);

    local function GetSort(p18, p19) -- Line: 61
        -- upvalues: u14 (ref), u1 (copy), u6 (copy)
        local v20 = p19 or u14;
        local v21 = u1.GetInventorySort(v20) or u6[v20];

        if v21 then
            return v21(p18);
        end;
    end;

    local function AddLock(p22) -- Line: 71
        -- upvalues: Lock (copy)
        local v23 = Lock:Clone();
        v23.Visible = true;
        v23.Parent = p22.Button;
    end;

    local function RemoveLock(p24) -- Line: 77
        if not p24.Button:FindFirstChild("Lock") then
            return;
        end;

        p24.Button.Lock:Destroy();
    end;

    local function AddEquipped(p25) -- Line: 82
        -- upvalues: Equipped (copy)
        local v26 = Equipped:Clone();
        v26.Visible = true;
        v26.Parent = p25.Button;
    end;

    local function RemoveEquipped(p27) -- Line: 88
        if not p27.Button:FindFirstChild("Equipped") then
            return;
        end;

        p27.Button.Equipped:Destroy();
    end;

    local function CreateContainer(p28, p29) -- Line: 93
        -- upvalues: u1 (copy), u14 (ref), u6 (copy)
        local _ItemId = p28._ItemId;
        local v30 = u1.CreateInventorySlot(p29, {
            TraitInfo = p28._TraitInfo,
            UnusualInfo = p28._UnusualInfo,
            SerialNumber = p28._SerialNumber
        });
        local v31 = nil or u14;
        local v32 = u1.GetInventorySort(v31) or u6[v31];
        local v33;

        if v32 then
            v33 = v32(_ItemId);
        else
            v33 = nil;
        end;

        v30.LayoutOrder = v33 or 0;
        v30.Parent = script.Parent;

        return v30;
    end;

    local function ShouldAutoDelete(p34, p35) -- Line: 105
        -- upvalues: u4 (ref), ItemData (copy), Settings (copy)
        if p35.Type ~= "Skin" then
            return false;
        end;

        if p34._Locked then
            return false;
        end;

        if p34._UUID == u4 then
            return false;
        end;

        if p34._UnusualInfo ~= nil then
            return false;
        end;

        if p34._Premium ~= nil then
            return false;
        end;

        local v36 = ItemData.GetRarityData(p35.Rarity);

        if not v36 then
            return false;
        end;

        local v37 = Settings:FindFirstChild((`AutoDelete{v36.Name}`));

        return v37 and v37.Value == true and true or false;
    end;

    local function AutoDeleteItem(p38, p39) -- Line: 123
        -- upvalues: ItemData (copy), u2 (copy), u1 (copy)
        local _UUID = p38._UUID;
        local v40 = ItemData.GetRarityData(p39.Rarity);
        local v41 = v40 and v40.Color or Color3.fromRGB(255, 255, 255);
        local v42 = string.format("rgb(%d,%d,%d)", math.floor(v41.R * 255), math.floor(v41.G * 255), (math.floor(v41.B * 255)));
        u2.SkinInventory:Fire({
            Remove = true,
            AutoDelete = true,
            UUIDS = { _UUID }
        });
        u1:Notify("Inventory", `Removed Skin: <font color="{v42}">{p39.Name}</font>`, 7);
    end;

    local u43 = true;
    task.spawn(function() -- Line: 143
        -- upvalues: u1 (copy), u43 (ref)
        local StackInventoryItems = u1.Player:WaitForChild("Settings"):WaitForChild("StackInventoryItems", 2147483648);
        StackInventoryItems.Changed:Connect(function(p44) -- Line: 145
            -- upvalues: u43 (ref)
            u43 = p44;
        end);
        u43 = StackInventoryItems.Value;
    end);

    local function DetermineSlotKey(p45) -- Line: 151
        -- upvalues: u43 (ref), u7 (ref)
        if u43 ~= true then
            return p45._UUID or math.random();
        end;

        if u7 == "AbilityInventory" then
            return p45._UUID;
        end;

        if u7 == "SkinInventory" then
            if p45._UnusualInfo or p45._SerialNumber then
                return p45._UUID;
            end;

            if p45._Premium then
                return `{p45._ItemId}_Premium`;
            end;

            return p45._ItemId;
        end;

        if u7 == "ItemInventory" then
            if p45._Purity then
                return `{p45._ItemId}_{p45._Purity}`;
            end;

            return p45._ItemId;
        end;

        if u7 ~= "MountInventory" then
            return p45._ItemId;
        end;

        if p45._Premium then
            return `{p45._ItemId}_Premium`;
        end;

        return p45._ItemId;
    end;

    local function AddSlot(u46) -- Line: 167
        -- upvalues: ItemData (copy), DetermineSlotKey (copy), u8 (copy), u3 (copy), Stack (copy), Trove (copy), CreateContainer (copy), u1 (copy), u9 (ref), u10 (copy), Lock (copy), Ability (copy), u4 (ref), Equipped (copy)
        local _UUID = u46._UUID;
        local _ItemId = u46._ItemId;
        local u47 = ItemData.GetItemInfo(_ItemId);
        local v48 = DetermineSlotKey(u46);
        local v49 = u8[v48];

        if not u47 then
            return;
        end;

        if u3[_ItemId] then
            local v50 = u3;
            v50[_ItemId] = v50[_ItemId] + 1;
        else
            u3[_ItemId] = 1;
        end;

        if v49 then
            local Stack2 = v49.Stack;
            local _ = v49.Trove;
            Stack2:Push(u46);
            v49.Container.Button.Amount.Text = Stack2:GetAmount();

            return;
        end;

        local u51 = Stack.new();
        local v52 = Trove.new();
        local u53 = CreateContainer(u46, u47);
        v52:Add(u51);
        v52:Add(u53);
        v52:Connect(u53.Button.MouseButton1Down, function() -- Line: 187
            -- upvalues: u1 (ref), u9 (ref), u46 (copy), u10 (ref), _UUID (copy), u53 (copy), u47 (copy), u51 (copy)
            u1:PlaySound("Click");

            if not u9 then
                u1.InventorySignals.ItemSelected:Fire({
                    ItemInfo = u47,
                    ItemObject = u51:Peek(),
                    AmountLeft = u51:GetAmount(),
                    Stack = u51
                });

                return;
            end;

            if u46._Locked then
                return;
            end;

            if u10[_UUID] then
                u10[_UUID].BackgroundColor3 = Color3.fromRGB(50, 50, 50);
                u10[_UUID] = nil;

                return;
            end;

            u10[_UUID] = u53.Button;
            u10[_UUID].BackgroundColor3 = Color3.new(1, 0, 0);
        end);

        if u1.CanTooltipInventorySlot(u46) then
            u1.ConstructTooltipSlot(u53, {
                ItemId = _ItemId,
                TraitInfo = u46._TraitInfo,
                UnusualInfo = u46._UnusualInfo,
                SerialNumber = u46._SerialNumber,
                Purity = u46._Purity,
                Premium = u46._Premium,
                PremiumCrate = u46._PremiumCrate,
                Metadata = u46._Metadata
            }, v52);
        end;

        local _Locked = u46._Locked;

        if _Locked then
            local v54 = Lock:Clone();
            v54.Visible = true;
            v54.Parent = u53.Button;
        end;

        if Ability:GetAttribute("UUID") == _UUID then
            u4 = _UUID;
            local v55 = Equipped:Clone();
            v55.Visible = true;
            v55.Parent = u53.Button;
        end;

        u51:Push(u46);
        u8[v48] = {
            Container = u53,
            Trove = v52,
            Stack = u51,
            ItemObject = u46,
            RarityInfo = ItemData.Rarities[u47._Rarity],
            Locked = _Locked and true or false
        };
    end;

    local function RemoveSlot(p56) -- Line: 250
        -- upvalues: ItemData (copy), DetermineSlotKey (copy), u8 (copy), u3 (copy)
        local _ = p56._UUID;
        local _ItemId = p56._ItemId;
        ItemData.GetItemInfo(_ItemId);
        local v57 = DetermineSlotKey(p56);
        local v58 = u8[v57];

        if not v58 then
            return;
        end;

        local Stack2 = v58.Stack;
        local Trove2 = v58.Trove;
        local Container = v58.Container;
        Stack2:Pop();
        local v59 = Stack2:GetAmount();

        if v59 > 0 then
            Container.Button.Amount.Text = v59;
            u3[_ItemId] = v59;

            return;
        end;

        Trove2:Destroy();
        u8[v57] = nil;
        u3[_ItemId] = nil;
    end;

    function u1.LoadInventory(p60) -- Line: 271
        -- upvalues: u1 (copy), u2 (copy)
        local v61 = u1.Inventory[p60];

        if u1.__MockInventory then
            return u1.__MockInventory[p60];
        end;

        if not u1.Inventory.Loaded[p60] then
            u1.Inventory[p60] = u2:GetItems(p60):expect();
            u1.Inventory.Loaded[p60] = true;
            v61 = u1.Inventory[p60];
        end;

        return v61;
    end;

    function u1.ShowInventoryItems(p62) -- Line: 285
        -- upvalues: u1 (copy), u10 (copy), u7 (ref), u8 (copy), u3 (copy), ItemData (copy), u17 (ref), u16 (copy), u15 (ref), u14 (ref), AddSlot (copy)
        u1.SetMassDelete(nil);
        table.clear(u10);
        u7 = p62;
        local v63 = u1.LoadInventory(p62);

        if not v63 then
            return;
        end;

        for _, v in pairs(u8) do
            v.Trove:Destroy();
        end;

        table.clear(u8);
        table.clear(u3);
        local v64 = {};

        for _, v in pairs(v63) do
            local v65 = ItemData.GetItemInfo(v._ItemId);

            if v65 and v65.Rarity then
                local v66 = ItemData.GetRarityData(v65.Rarity);

                if v66 and not v64[v66.Name] then
                    v64[v66.Name] = v66.Value or 0;
                end;
            end;
        end;

        u17 = table.clone(u16);
        local v67 = {};

        for i, v in pairs(v64) do
            table.insert(v67, {
                Name = i,
                Value = v
            });
        end;

        table.sort(v67, function(p68, p69) -- Line: 319
            return p68.Value < p69.Value;
        end);

        for _, v in ipairs(v67) do
            table.insert(u17, v.Name);
        end;

        if u15 > #u17 then
            u15 = 1;
            u14 = u17[u15];
        end;

        for _, v in pairs(v63) do
            task.spawn(AddSlot, v);
        end;
    end;

    function u1.ShowAllInventoryItems() -- Line: 337
        -- upvalues: u8 (copy), u3 (copy), u7 (ref), u1 (copy), AddSlot (copy)
        local v70 = { "AbilityInventory", "SkinInventory", "ItemInventory" };

        for _, v in pairs(u8) do
            v.Trove:Destroy();
        end;

        table.clear(u8);
        table.clear(u3);

        for _, v in ipairs(v70) do
            u7 = v;
            local v71 = u1.LoadInventory(v) or {};

            for _, v2 in pairs(v71) do
                task.spawn(AddSlot, v2);
            end;
        end;
    end;

    function u1.SetMassDelete(p72) -- Line: 361
        -- upvalues: u9 (ref)
        u9 = p72;
    end;

    function u1.MassDelete() -- Line: 365
        -- upvalues: u10 (copy), u1 (copy), u2 (copy)
        local v73 = {};

        for i, _ in u10 do
            table.insert(v73, i);
        end;

        if #v73 > 100 then
            u1.NewPrompt({
                Title = "Amount Exceeded",
                Text = "Only a maximum of 100 skins can be deleted per mass delete",
                Delay = 0.5
            });

            return;
        end;

        u2.SkinInventory:Fire({
            Remove = true,
            UUIDS = v73
        });
        task.delay(0.5, u1.SetInventoryTab, u1, "SkinInventory");
    end;

    local function Search(p74) -- Line: 387
        -- upvalues: u8 (copy), ItemData (copy)
        if not p74 or p74 == "" then
            for _, v in pairs(u8) do
                v.Container.Visible = true;
            end;

            return;
        end;

        local v75 = string.match(p74, "^@([%w]+)");
        local u76 = string.find(p74, "!") ~= nil;
        local u77 = nil;
        local u78 = string.find(p74, "&") ~= nil;
        local u79 = nil;

        if u76 then
            local v80 = string.match(p74, "!%s*(%d+)");

            if v80 then
                u77 = tonumber(v80);
            end;
        end;

        if u78 then
            local v81 = string.match(p74, "&%s*([%w%s]+)");

            if v81 then
                u79 = string.lower(v81:match("^%s*(.-)%s*$"));
            end;
        end;

        for _, v in pairs(u8) do
            local ItemObject = v.ItemObject;
            local _ItemId = ItemObject._ItemId;
            local v82 = ItemData.GetItemInfo(_ItemId);

            if v82 and v82.Name then
                local u83 = ItemObject._UnusualInfo ~= nil;
                local _ = ItemObject._Premium == nil;
                local u84;

                if u83 then
                    u84 = ItemObject._UnusualInfo.UnusualHueId or nil;
                else
                    u84 = nil;
                end;

                local u85 = ItemObject._TraitInfo ~= nil;
                local u86 = u85 and (ItemObject._TraitInfo.Trait and string.lower(ItemObject._TraitInfo.Trait)) or nil;
                local v87;

                if u76 then
                    v87 = string.gsub(p74, "!%s*%d*", "");
                else
                    v87 = p74;
                end;

                if u78 then
                    v87 = string.gsub(v87, "&%s*[%w%s]*", "");
                end;

                local v88 = string.match(v87, "[%w%s]+");
                local v89;

                if v88 then
                    v89 = string.find(v82.Name:lower(), string.lower(v88));
                else
                    v89 = nil;
                end;

                local function MatchesTrait() -- Line: 434
                    -- upvalues: u78 (copy), u85 (copy), u79 (ref), u86 (copy)
                    if not u78 then
                        return true;
                    end;

                    if not u85 then
                        return false;
                    end;

                    if not u79 then
                        return true;
                    end;

                    local v90 = u86 and string.find(u86, u79) ~= nil;

                    return v90;
                end;

                local function MatchesUnusual() -- Line: 445
                    -- upvalues: u76 (copy), u83 (copy), u77 (ref), u84 (copy)
                    if not u76 then
                        return true;
                    end;

                    if u83 then
                        return not u77 and true or u84 == u77;
                    end;

                    return false;
                end;

                if v75 then
                    if string.find(_ItemId, "SKIN_") then
                        local v91 = string.match(_ItemId, "_([%d]+)_");

                        if v91 then
                            local v92 = ItemData.GetItemInfo((`ABILITY_{v91}`));
                            local v93 = string.match(p74, "^@[%w]+%s(.+)");
                            local v94 = string.find(string.lower(v92.Name), string.lower(v75));
                            local v95;

                            if v93 then
                                if u76 then
                                    v95 = string.gsub(v93, "!%s*%d*", "");
                                else
                                    v95 = v93;
                                end;

                                if u78 then
                                    v95 = string.gsub(v95, "&%s*[%w%s]*", "");
                                end;
                            else
                                v95 = v93;
                            end;

                            if v95 then
                                v95 = string.match(v95, "[%w%s]+");
                            end;

                            if v95 then
                                v95 = string.find(v82.Name:lower(), string.lower(v95));
                            end;

                            if v94 then
                                if v95 then
                                    local Container = v.Container;
                                    local v96;

                                    if u76 then
                                        if u83 then
                                            v96 = not u77 and true or u84 == u77;
                                        else
                                            v96 = false;
                                        end;
                                    else
                                        v96 = true;
                                    end;

                                    if v96 then
                                        if u78 then
                                            if u85 then
                                                if u79 then
                                                    if u86 then
                                                        u86 = string.find(u86, u79) ~= nil;
                                                    end;
                                                else
                                                    u86 = true;
                                                end;
                                            else
                                                u86 = false;
                                            end;
                                        else
                                            u86 = true;
                                        end;
                                    else
                                        u86 = v96;
                                    end;

                                    Container.Visible = u86;
                                elseif u77 or u79 then
                                    local Container = v.Container;
                                    local v97;

                                    if u76 then
                                        if u83 then
                                            v97 = not u77 and true or u84 == u77;
                                        else
                                            v97 = false;
                                        end;
                                    else
                                        v97 = true;
                                    end;

                                    if v97 then
                                        if u78 then
                                            if u85 then
                                                if u79 then
                                                    if u86 then
                                                        u86 = string.find(u86, u79) ~= nil;
                                                    end;
                                                else
                                                    u86 = true;
                                                end;
                                            else
                                                u86 = false;
                                            end;
                                        else
                                            u86 = true;
                                        end;
                                    else
                                        u86 = v97;
                                    end;

                                    Container.Visible = u86;
                                else
                                    v.Container.Visible = v93 and (v93:gsub(" ", "") == "!" or v93:gsub(" ", "") == "&") and (u83 or u85) and true or not (v93 or (u76 or u78));
                                end;
                            else
                                v.Container.Visible = false;
                            end;
                        end;
                    elseif v89 or u76 and u83 or u78 and u85 then
                        if u77 or u79 then
                            local Container = v.Container;
                            local v98;

                            if u76 then
                                if u83 then
                                    v98 = not u77 and true or u84 == u77;
                                else
                                    v98 = false;
                                end;
                            else
                                v98 = true;
                            end;

                            if v98 then
                                if u78 then
                                    if u85 then
                                        if u79 then
                                            if u86 then
                                                u86 = string.find(u86, u79) ~= nil;
                                            end;
                                        else
                                            u86 = true;
                                        end;
                                    else
                                        u86 = false;
                                    end;
                                else
                                    u86 = true;
                                end;

                                v98 = u86 and true;
                            end;

                            Container.Visible = v98;
                        else
                            local Container = v.Container;

                            if v89 then
                                local v99;

                                if u76 then
                                    if u83 then
                                        v99 = not u77 and true or u84 == u77;
                                    else
                                        v99 = false;
                                    end;
                                else
                                    v99 = true;
                                end;

                                if v99 then
                                    if u78 then
                                        if u85 then
                                            if u79 then
                                                if u86 then
                                                    u86 = string.find(u86, u79) ~= nil;
                                                end;
                                            else
                                                u86 = true;
                                            end;
                                        else
                                            u86 = false;
                                        end;
                                    else
                                        u86 = true;
                                    end;
                                else
                                    u86 = v99;
                                end;
                            else
                                u86 = u76 and u83 and u83 or u78 and u85;
                            end;

                            Container.Visible = u86;
                        end;
                    else
                        v.Container.Visible = false;
                    end;
                elseif v89 then
                    local Container = v.Container;
                    local v100;

                    if u76 then
                        if u83 then
                            v100 = not u77 and true or u84 == u77;
                        else
                            v100 = false;
                        end;
                    else
                        v100 = true;
                    end;

                    if v100 then
                        if u78 then
                            if u85 then
                                if u79 then
                                    if u86 then
                                        u86 = string.find(u86, u79) ~= nil;
                                    end;
                                else
                                    u86 = true;
                                end;
                            else
                                u86 = false;
                            end;
                        else
                            u86 = true;
                        end;
                    else
                        u86 = v100;
                    end;

                    Container.Visible = u86;
                elseif u77 or u79 then
                    local Container = v.Container;
                    local v101;

                    if u76 then
                        if u83 then
                            v101 = not u77 and true or u84 == u77;
                        else
                            v101 = false;
                        end;
                    else
                        v101 = true;
                    end;

                    if v101 then
                        if u78 then
                            if u85 then
                                if u79 then
                                    if u86 then
                                        u86 = string.find(u86, u79) ~= nil;
                                    end;
                                else
                                    u86 = true;
                                end;
                            else
                                u86 = false;
                            end;
                        else
                            u86 = true;
                        end;
                    else
                        u86 = v101;
                    end;

                    Container.Visible = u86;
                else
                    local v102 = p74:gsub(" ", "");
                    v.Container.Visible = (v102 == "!" and u83 or (v102 == "&" and u85 or (v102 == "!&" and (u83 and u85) or v102 == "&!" and (u83 and u85)))) and true or false;
                end;
            end;
        end;
    end;

    local Sorting = script.Parent.Parent.Parent.Sorting;
    local Order = Sorting:WaitForChild("Order");
    local Search2 = Sorting:WaitForChild("Search");
    Order.MouseButton1Down:Connect(function() -- Line: 577
        -- upvalues: u1 (copy), u15 (ref), u17 (ref), u14 (ref), Order (copy), u6 (copy), u16 (copy), u8 (copy), ItemData (copy)
        u1:PlaySound("Click");
        u15 = u15 + 1;

        if u15 > #u17 then
            u15 = 1;
        end;

        u14 = u17[u15];
        Order.Text = u14;
        local v103 = u6[u14] and not table.find(u16, u14);

        for _, v in pairs(u8) do
            if v.Container then
                local _ItemId = v.ItemObject._ItemId;
                local Container = v.Container;
                local v104 = u14 or u14;
                local v105 = u1.GetInventorySort(v104) or u6[v104];
                local v106;

                if v105 then
                    v106 = v105(_ItemId);
                else
                    v106 = nil;
                end;

                Container.LayoutOrder = v106;

                if v103 then
                    local v107 = ItemData.GetItemInfo(_ItemId);

                    if v107 then
                        local v108 = ItemData.GetRarityData(v107.Rarity);

                        if v108 then
                            v.Container.Visible = v108.Name == u14;
                        else
                            v.Container.Visible = false;
                        end;
                    else
                        v.Container.Visible = false;
                    end;
                else
                    v.Container.Visible = true;
                end;
            end;
        end;
    end);
    Search2.TextBox.FocusLost:Connect(function() -- Line: 611
        -- upvalues: Search (copy), Search2 (copy)
        Search(Search2.TextBox.Text);
    end);
    u2.ItemAdded:Connect(function(p109, p110) -- Line: 615
        -- upvalues: u1 (copy), ItemData (copy), ShouldAutoDelete (copy), AutoDeleteItem (copy), u7 (ref), AddSlot (copy), u8 (copy), Lock (copy)
        local _UUID = p109._UUID;

        if not u1.Inventory[p110] then
            u1.Inventory[p110] = {};
        end;

        u1.Inventory[p110][_UUID] = p109;

        if p110 == "SkinInventory" then
            local v111 = ItemData.GetItemInfo(p109._ItemId);

            if v111 and ShouldAutoDelete(p109, v111) then
                task.spawn(AutoDeleteItem, p109, v111);

                return;
            end;
        end;

        if u7 ~= p110 then
            return;
        end;

        AddSlot(p109);
        local v112 = u8[_UUID];

        if p109._Locked and not v112.Locked then
            local Container = v112.Container;
            local v113 = Lock:Clone();
            v113.Visible = true;
            v113.Parent = Container.Button;
            v112.Locked = true;
            v112.ItemObject._Locked = true;
        end;
    end);
    u2.ItemUpdated:Connect(function(p114, p115) -- Line: 644
        -- upvalues: u1 (copy), u7 (ref), RemoveSlot (copy), AddSlot (copy), u8 (copy), Lock (copy)
        local _UUID = p114._UUID;

        if not u1.Inventory[p115] then
            u1.Inventory[p115] = {};
        end;

        u1.Inventory[p115][_UUID] = p114;

        if u7 ~= p115 then
            return;
        end;

        RemoveSlot(p114);
        AddSlot(p114);
        local v116 = u8[_UUID];

        if v116 and (p114._Locked and not v116.Locked) then
            local Container = v116.Container;
            local v117 = Lock:Clone();
            v117.Visible = true;
            v117.Parent = Container.Button;
            v116.Locked = true;
            v116.ItemObject._Locked = true;
        end;
    end);
    u2.ItemRemoved:Connect(function(p118, p119) -- Line: 667
        -- upvalues: u1 (copy), RemoveSlot (copy)
        if u1.Inventory[p119] then
            u1.Inventory[p119][p118._UUID] = nil;
        end;

        RemoveSlot(p118);
    end);
    u2.ItemLocked:Connect(function(p120, p121) -- Line: 676
        -- upvalues: u8 (copy), Lock (copy)
        local v122 = u8[p120._UUID];

        if not v122 then
            return;
        end;

        if not p121 or v122.Locked then
            local Container = v122.Container;

            if Container.Button:FindFirstChild("Lock") then
                Container.Button.Lock:Destroy();
            end;

            v122.Locked = false;
            v122.ItemObject._Locked = false;

            return;
        end;

        local Container = v122.Container;
        local v123 = Lock:Clone();
        v123.Visible = true;
        v123.Parent = Container.Button;
        v122.Locked = true;
        v122.ItemObject._Locked = true;
    end);
    u2.ViewInventory:Connect(function(p124) -- Line: 691
        -- upvalues: u1 (copy)
        u1.__MockInventory = p124;
        u1:SetMenu("Inventory");
        u1.ShowInventoryItems(u1.LastInventoryTab or "AbilityInventory");
    end);
    Ability:GetAttributeChangedSignal("UUID"):Connect(function() -- Line: 697
        -- upvalues: u4 (ref), Ability (copy), u8 (copy), Equipped (copy)
        local v125 = u4;
        u4 = Ability:GetAttribute("UUID");
        local v126 = u8[u4];

        if v126 then
            local Container = v126.Container;
            local v127 = Equipped:Clone();
            v127.Visible = true;
            v127.Parent = Container.Button;
        end;

        local v128 = u8[v125];

        if v128 then
            local Container = v128.Container;

            if not Container.Button:FindFirstChild("Equipped") then
                return;
            end;

            Container.Button.Equipped:Destroy();
        end;
    end);
end;