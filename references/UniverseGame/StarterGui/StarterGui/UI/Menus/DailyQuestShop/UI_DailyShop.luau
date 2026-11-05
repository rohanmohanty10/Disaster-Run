  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
local DailyQuestShop = require(ReplicatedStorage.ReplicatedModules.DailyQuestShop);
require(ReplicatedStorage.ClientLibrary.ObserveTag);
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local Parent = script.Parent;
local Assets = Parent.Assets;
local Shop = Parent.Shop;
ReplicatedStorage.Remotes:WaitForChild("ClientUIOutput");
local u1 = {
    ItemInventory = "Item",
    MountInventory = "Mount",
    AbilityInventory = "Ability",
    SkinInventory = "Skin"
};

return function(u2) -- Line: 26
    -- upvalues: Parent (copy), CollectionService (copy), DailyQuestShop (copy), ItemData (copy), Assets (copy), u1 (copy), Shop (copy)
    local Knit = u2.Knit;
    Knit.OnStart():await();
    local u3 = Knit.GetService("PlayerDataService");
    local u4 = Knit.GetService("InventoryService");
    local u5 = Knit.GetService("ShopService");

    function u2.OpenDailyQuestShop(p6) -- Line: 35
        -- upvalues: Parent (ref)
        Parent.Visible = true;
    end;

    local DailyQuestCurrency = u2.Player:WaitForChild("Data"):WaitForChild("DailyQuestCurrency");

    local function ShiftColors(p7) -- Line: 42
        -- upvalues: DailyQuestCurrency (copy)
        local v8 = DailyQuestCurrency.Value >= tonumber(p7.Purchase.Text);
        local Seperator = p7.Seperator;
        local v9;

        if v8 then
            v9 = Color3.fromHex("#b5ffb4");
        else
            v9 = Color3.fromHex("#ffb7b7");
        end;

        Seperator.BackgroundColor3 = v9;
        local Holder = p7.Holder;
        local v10;

        if v8 then
            v10 = Color3.fromRGB(138, 255, 138);
        else
            v10 = Color3.fromRGB(255, 106, 106);
        end;

        Holder.BackgroundColor3 = v10;
        local UIGradient = p7.Holder.UIStroke.UIGradient;
        local new = ColorSequence.new;
        local v11 = {};
        local new2 = ColorSequenceKeypoint.new;
        local v12;

        if v8 then
            v12 = Color3.fromHex("#b5ffb4");
        else
            v12 = Color3.fromHex("#ffb7b7");
        end;

        local v13 = new2(0, v12);
        local new3 = ColorSequenceKeypoint.new;
        local v14;

        if v8 then
            v14 = Color3.fromHex("#54ff5a");
        else
            v14 = Color3.fromHex("#ff5050");
        end;

        v11[1], v11[2] = v13, new3(1, v14);
        UIGradient.Color = new(v11);
        local UIGradient2 = p7.Purchase.UIGradient;
        local new4 = ColorSequence.new;
        local v15 = {};
        local v16 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
        local new5 = ColorSequenceKeypoint.new;
        local v17;

        if v8 then
            v17 = Color3.fromHex("#79ff84");
        else
            v17 = Color3.fromHex("#ff7d7d");
        end;

        v15[1], v15[2] = v16, new5(1, v17);
        UIGradient2.Color = new4(v15);
        local UIGradient3 = p7.Purchase.UIStroke.UIGradient;
        local new6 = ColorSequence.new;
        local v18 = {};
        local new7 = ColorSequenceKeypoint.new;
        local v19;

        if v8 then
            v19 = Color3.fromHex("#b5ffb4");
        else
            v19 = Color3.fromHex("#ffb7b7");
        end;

        local v20 = new7(0, v19);
        local new8 = ColorSequenceKeypoint.new;
        local v21;

        if v8 then
            v21 = Color3.fromHex("#54ff5a");
        else
            v21 = Color3.fromHex("#ff5050");
        end;

        v18[1], v18[2] = v20, new8(1, v21);
        UIGradient3.Color = new6(v18);
        local UIGradient4 = p7.Icon.UIGradient;
        local new9 = ColorSequence.new;
        local v22 = {};
        local v23 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
        local new10 = ColorSequenceKeypoint.new;
        local v24;

        if v8 then
            v24 = Color3.fromHex("#79ff84");
        else
            v24 = Color3.fromHex("#ff7d7d");
        end;

        v22[1], v22[2] = v23, new10(1, v24);
        UIGradient4.Color = new9(v22);
        local UIGradient5 = p7.Icon.UIStroke.UIGradient;
        local new11 = ColorSequence.new;
        local v25 = {};
        local new12 = ColorSequenceKeypoint.new;
        local v26;

        if v8 then
            v26 = Color3.fromHex("#b5ffb4");
        else
            v26 = Color3.fromHex("#ffb7b7");
        end;

        local v27 = new12(0, v26);
        local new13 = ColorSequenceKeypoint.new;
        local v28;

        if v8 then
            v28 = Color3.fromHex("#54ff5a");
        else
            v28 = Color3.fromHex("#ff5050");
        end;

        v25[1], v25[2] = v27, new13(1, v28);
        UIGradient5.Color = new11(v25);
    end;

    DailyQuestCurrency:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 75
        -- upvalues: Parent (ref), DailyQuestCurrency (copy), CollectionService (ref), ShiftColors (copy)
        Parent.Window.Text = `Daily Quest Shop, Gems: {DailyQuestCurrency.Value}`;

        for _, v in CollectionService:GetTagged("DailyQuestShopItem") do
            ShiftColors(v);
        end;
    end);
    Parent.Window.Text = `Daily Quest Shop, Gems : {DailyQuestCurrency.Value}`;

    for _, v in DailyQuestShop do
        local Title = v.Title;
        local Description = v.Description;

        if (Title == nil or Description == nil) and typeof(v.Reward) == "table" then
            local v29 = ItemData.GetItemInfo(v.Reward.ItemId);

            if Title == nil then
                if v29 and v29.Name then
                    Title = v29.Name;
                else
                    Title = v.Id;
                end;
            end;

            if Description == nil then
                if v29 and v29.Description then
                    Description = v29.Description;
                else
                    Description = "No Description";
                end;
            end;
        end;

        local v30 = Assets.Template:Clone();
        v30.Name = v.Id;
        v30.NameLabel.Text = Title;
        v30.Description.Text = Description;
        v30.Purchase.Text = `{v.Gems or "No Price"}`;
        v30.Icon.Image = `rbxassetid://{v.Icon or 44358116}`;
        v30.LayoutOrder = v.Gems or 999;
        v30.Visible = true;
        ShiftColors(v30);
        v30.Purchase.MouseButton1Click:Connect(function() -- Line: 119
            -- upvalues: DailyQuestCurrency (copy), v (copy), u2 (copy), u3 (copy), u1 (ref), u4 (copy), u5 (copy), Title (ref)
            local Value = DailyQuestCurrency.Value;
            local v31 = Value - v.Gems;

            if v31 < 0 then
                local v32 = v.Gems - Value;
                u2:PlaySound("error_sfx1");
                u2:ServerNewPrompt({
                    Title = "Not enough Gems",
                    Text = `Need {v32} more Gem{v32 == 1 and "" or "s"} to purchase this item`
                });

                return;
            end;

            if table.find({ "ItemInventory", "MountInventory", "AbilityInventory", "SkinInventory" }, v.Reward) and u3:GetDailyStorage(v.Reward):expect() >= v.MaxSlots then
                u2:ServerNewPrompt({
                    Title = "Purchase Failed",
                    Text = `You are already at the max capacity for {u1[v.Reward]} slot spaces`
                });

                return;
            end;

            if type(v.Reward) == "table" and (v.Reward.ItemId and (v.Reward.Inventory and not u4:HasCapacityForAmount(v.Reward.Inventory, 1):expect())) then
                u2:ServerNewPrompt({
                    Title = "Purchase Failed",
                    Text = `Your {u1[v.Reward.Inventory]} Inventory is full`
                });

                return;
            end;

            u2:ServerNewPrompt({
                Title = "Confirm Purchase",
                Delay = 1,
                Text = `Note that this costs {v.Gems} Gem{v.Gems == 1 and "" or "s"}, After this purchase you will have {v31 == 0 and "<font color=\'#ff5050\'>no</font>" or v31} Gem{v31 == 1 and "" or "s"} left after this`,
                Options = { "Yes", "No" },

                Callback = function(p33) -- Line: 162, Name: Callback
                    -- upvalues: u5 (ref), v (ref), u2 (ref), u3 (ref), Title (ref), u1 (ref)
                    if p33.Choice ~= 1 then
                        return;
                    end;

                    u5:BuyDailyQuestShop(v.Id):andThen(function(p34) -- Line: 165
                        -- upvalues: u2 (ref), v (ref), u3 (ref), Title (ref), u1 (ref)
                        if not p34 then
                            return;
                        end;

                        u2:PlaySound("ucoin_gain");

                        if not table.find({ "ItemInventory", "MountInventory", "AbilityInventory", "SkinInventory" }, v.Reward) then
                            if type(v.Reward) ~= "table" or not v.Reward.SubPower then
                                u2:ServerNewPrompt({
                                    Title = "Item Purchased",
                                    Text = `Purchased {Title}`
                                });
                            end;

                            return;
                        end;

                        local v35 = u3:GetDailyStorage(v.Reward):expect();
                        u2:ServerNewPrompt({
                            Title = "Item Purchased",
                            Text = `Purchased {Title}, You have {v.MaxSlots - v35 == 0 and "<font color=\'#ff5050\'>no</font>" or v.MaxSlots - v35} {u1[v.Reward]} slot space{v35 == 1 and "" or "s"} left`
                        });
                    end);
                end
            });
        end);
        v30:AddTag("DailyQuestShopItem");
        v30.Parent = Shop;
    end;
end;