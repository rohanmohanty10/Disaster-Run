  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
game:GetService("ContextActionService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require("../Menus/InventoryV2/Lib/Types");

return function(u1) -- Line: 21
    -- upvalues: ReplicatedStorage (copy), GuiService (copy), TweenService (copy), UserInputService (copy), LocalPlayer (copy)
    u1.Data:WaitForChild("Inventory");
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    Core.OnStart():await();
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Trove = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(ReplicatedStorage.ReplicatedModules.StatsHandler);
    require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("MountService");
    u1.Knit.GetService("KillEffectService");
    local u2 = u1.Knit.GetController("MoveInputController");
    local v3 = Core.GetClientService("ConfigurationService");
    local u4 = Core.GetClientService("ToolService");

    if not v3:GetFFlags():expect().new_backpack_enabled then
        script.Parent:Destroy();

        return;
    end;

    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    local u5 = Fusion.Value(true);
    local u6 = Fusion.Value({});
    local u7 = Fusion.Value(nil);
    local u8 = Fusion.Value(nil);
    local u9 = Fusion.Value(false);
    local u10 = Fusion.Value(false);
    local u11 = Fusion.Value(nil);
    local v12 = Fusion.Value(nil);
    local u13 = Fusion.Value(nil);
    task.wait(1);
    local Rarities = ItemData.Rarities;
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Main = Parent.Main;
    local Hotbar = Parent.Hotbar;
    local ScrollingFrame = Main.Content.Items.ScrollingFrame;
    local Content = ScrollingFrame.Content;
    local Indexing = Main.TopBar.Indexing;
    local v14 = require("../Menus/InventoryV2/Lib/DataSource");
    local v15 = require("../Menus/InventoryV2/Lib/VirtualGrid");
    require("../Menus/InventoryV2/Lib/ContextMenuController");
    require("../Menus/InventoryV2/Lib/Icons");
    require("../Menus/InventoryV2/Lib/Utility");
    local v16 = require("../Menus/InventoryV2/Components/Sorting");
    local u17 = TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local u18 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local u19 = {
        Default = Color3.fromRGB(30, 30, 30),
        Selected = Color3.fromRGB(255, 200, 50),
        DragTarget = Color3.fromRGB(126, 126, 255)
    };
    local _ = {
        Default = Color3.fromRGB(40, 40, 40),
        Highlight = Color3.fromRGB(80, 180, 80)
    };
    local _ = u1.MainToolTipScreen;
    local u20 = v14.new();
    local u21 = {};
    local u22 = {};

    local function GetHotbarMap() -- Line: 138
        -- upvalues: u6 (copy)
        local v23 = {};

        for i, v in u6:get() do
            if v and v.Identifier then
                v23[v.Identifier] = i;
            end;
        end;

        return v23;
    end;

    local function FindFirstEmptySlot(p24) -- Line: 148
        return not p24[1] and 1 or (not p24[2] and 2 or (not p24[3] and 3 or (not p24[4] and 4 or (not p24[5] and 5 or (not p24[6] and 6 or (not p24[7] and 7 or (not p24[8] and 8 or (not p24[9] and 9 or (not p24[10] and 10 or nil)))))))));
    end;

    local function PosOverUI(p25, p26) -- Line: 155
        local AbsolutePosition = p25.AbsolutePosition;
        local AbsoluteSize = p25.AbsoluteSize;
        local v27;

        if p26.X >= AbsolutePosition.X and (p26.X <= AbsolutePosition.X + AbsoluteSize.X and p26.Y >= AbsolutePosition.Y) then
            v27 = p26.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v27 = false;
        end;

        return v27;
    end;

    local function FindHotbarSlotAt(p28, p29) -- Line: 161
        -- upvalues: Hotbar (copy)
        local v30 = (1 / 0);
        local v31 = nil;

        for _, child in Hotbar.SlotHolder:GetChildren() do
            if child:IsA("GuiObject") and child ~= p29 then
                local AbsolutePosition = child.AbsolutePosition;
                local AbsoluteSize = child.AbsoluteSize;
                local v32;

                if p28.X >= AbsolutePosition.X and (p28.X <= AbsolutePosition.X + AbsoluteSize.X and p28.Y >= AbsolutePosition.Y) then
                    v32 = p28.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v32 = false;
                end;

                if v32 then
                    if child.AbsolutePosition.X + child.AbsoluteSize.X / 2 > p28.X then
                        return child, "left";
                    end;

                    return child, "right";
                end;

                local v33 = Hotbar;
                local AbsolutePosition2 = v33.AbsolutePosition;
                local AbsoluteSize2 = v33.AbsoluteSize;
                local v34;

                if p28.X >= AbsolutePosition2.X and (p28.X <= AbsolutePosition2.X + AbsoluteSize2.X and p28.Y >= AbsolutePosition2.Y) then
                    v34 = p28.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y;
                else
                    v34 = false;
                end;

                if v34 then
                    local v35 = math.abs(p28.X - (child.AbsolutePosition.X + child.AbsoluteSize.X / 2));

                    if v35 < v30 then
                        v31 = child;
                        v30 = v35;
                    end;
                end;
            end;
        end;

        if not v31 then
            return nil, nil;
        end;

        if v31.AbsolutePosition.X + v31.AbsoluteSize.X / 2 > p28.X then
            return v31, "left";
        end;

        return v31, "right";
    end;

    local function FindHotbarSlotAtStrict(p36, p37) -- Line: 192
        -- upvalues: Hotbar (copy)
        for _, child in Hotbar.SlotHolder:GetChildren() do
            if child:IsA("GuiObject") and child ~= p37 then
                local AbsolutePosition = child.AbsolutePosition;
                local AbsoluteSize = child.AbsoluteSize;
                local v38;

                if p36.X >= AbsolutePosition.X and (p36.X <= AbsolutePosition.X + AbsoluteSize.X and p36.Y >= AbsolutePosition.Y) then
                    v38 = p36.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v38 = false;
                end;

                if v38 then
                    return child;
                end;
            end;
        end;

        return nil;
    end;

    local function MakeDraggable(u39, u40) -- Line: 203
        -- upvalues: Fusion (copy), GuiService (ref), TweenService (ref), u17 (copy), u10 (copy), u9 (copy), u1 (copy), u18 (copy)
        if u39 == nil then
            return;
        end;

        local Container = u40.Container;
        local UIDragDetector = Instance.new("UIDragDetector");
        UIDragDetector.DragStyle = Enum.UIDragDetectorDragStyle.Scriptable;
        UIDragDetector.Parent = u39;
        local UIScale = Instance.new("UIScale");
        UIScale.Parent = u39;
        local u41 = nil;
        local zero = Vector2.zero;
        local zero2 = Vector2.zero;
        local u42 = false;
        local u43 = Fusion.Value(UDim2.fromScale(0, 0));

        local function CreateClone(p44) -- Line: 223
            -- upvalues: u41 (ref), u39 (copy), GuiService (ref), zero (ref), Container (copy), u43 (copy), Fusion (ref), TweenService (ref), u17 (ref), UIScale (copy)
            local CurrentCamera = workspace.CurrentCamera;

            if not CurrentCamera then
                return;
            end;

            u41 = u39:Clone();

            if u41 == nil then
                return;
            end;

            local v45 = u41:FindFirstChildOfClass("UIDragDetector");
            local v46 = u41:FindFirstChildOfClass("UIScale");

            if v45 then
                v45:Destroy();
            end;

            if v46 then
                v46:Destroy();
            end;

            if u41:IsA("GuiButton") then
                u41.Interactable = false;
            end;

            local v47, v48 = GuiService:GetGuiInset();
            local ViewportSize = CurrentCamera.ViewportSize;
            local v49 = math.clamp(p44.X - zero.X, v47.X, ViewportSize.X - v48.X - u39.AbsoluteSize.X);
            local v50 = math.clamp(p44.Y - zero.Y, -v47.Y, ViewportSize.Y - v48.Y - u39.AbsoluteSize.Y - v47.Y);
            u41.AnchorPoint = Vector2.zero;
            u41.Size = UDim2.fromOffset(u39.AbsoluteSize.X, u39.AbsoluteSize.Y);
            u41.ZIndex = 10;
            u41.Parent = Container;
            u43:set(UDim2.fromOffset(v49 - Container.AbsolutePosition.X, v50 - Container.AbsolutePosition.Y));
            Fusion.Hydrate(u41)({
                Position = Fusion.Spring(u43, 45, 0.95)
            });
            local UIScale2 = Instance.new("UIScale");
            UIScale2.Scale = 0.9;
            UIScale2.Parent = u41;
            TweenService:Create(UIScale2, u17, {
                Scale = 1.05
            }):Play();
            task.defer(function() -- Line: 278
                -- upvalues: UIScale (ref)
                UIScale.Scale = 0;
            end);
        end;

        UIDragDetector.DragStart:Connect(function(p51) -- Line: 281
            -- upvalues: zero (ref), u39 (copy), zero2 (ref), u42 (ref), u10 (ref)
            zero = p51 - u39.AbsolutePosition;
            zero2 = p51;
            u42 = false;
            u10:set(false);
        end);
        UIDragDetector.DragContinue:Connect(function(p52) -- Line: 288
            -- upvalues: u42 (ref), u9 (ref), zero2 (ref), CreateClone (copy), u10 (ref), u1 (ref), UIDragDetector (copy), u41 (ref), GuiService (ref), zero (ref), u43 (copy), Container (copy), u40 (copy)
            if not u42 then
                if not u9:get() then
                    return;
                end;

                if (p52 - zero2).Magnitude < 15 then
                    return;
                end;

                u42 = true;
                CreateClone(p52);
                u10:set(true);
                u1:PlaySound("Backpack/bp_drag_start");
            end;

            if not u9:get() then
                UIDragDetector.Enabled = false;
                task.defer(function() -- Line: 301
                    -- upvalues: UIDragDetector (ref)
                    UIDragDetector.Enabled = true;
                end);

                return;
            end;

            if not u41 then
                return;
            end;

            local CurrentCamera = workspace.CurrentCamera;

            if not CurrentCamera then
                return;
            end;

            local v53, v54 = GuiService:GetGuiInset();
            local ViewportSize = CurrentCamera.ViewportSize;
            local v55 = math.clamp(p52.X - zero.X, v53.X, ViewportSize.X - v54.X - u41.AbsoluteSize.X);
            local v56 = math.clamp(p52.Y - zero.Y, -v53.Y, ViewportSize.Y - v54.Y - u41.AbsoluteSize.Y - v53.Y);
            u43:set(UDim2.fromOffset(v55 - Container.AbsolutePosition.X, v56 - Container.AbsolutePosition.Y));

            if u40.OnMovement then
                u40.OnMovement(u41, p52 - v53);
            end;
        end);
        UIDragDetector.DragEnd:Connect(function(p57) -- Line: 342
            -- upvalues: u42 (ref), u40 (copy), u10 (ref), u41 (ref), u43 (copy), TweenService (ref), u18 (ref), UIScale (copy), GuiService (ref), u1 (ref)
            if not u42 then
                u42 = false;
                u40.OnReleased(false);

                return;
            end;

            u42 = false;
            u10:set(false);
            local u58 = u41;
            u41 = nil;

            if u58 then
                u43:set(u43:get() + UDim2.fromOffset(u58.AbsoluteSize.X / 2, u58.AbsoluteSize.Y / 2));
                local v59 = u58:FindFirstChildOfClass("UIScale");

                if v59 then
                    TweenService:Create(v59, u18, {
                        Scale = 0
                    }):Play();
                end;

                task.delay(u18.Time, function() -- Line: 361
                    -- upvalues: u58 (copy)
                    u58:Destroy();
                end);
            end;

            task.defer(function() -- Line: 364
                -- upvalues: UIScale (ref)
                UIScale.Scale = 1;
            end);
            local v60 = GuiService:GetGuiInset();
            u40.OnReleased(true, p57 - v60);
            u1:PlaySound("Backpack/bp_drag_drop");
        end);
    end;

    local function CompileItemFromTool(p61) -- Line: 372
        -- upvalues: ItemData (copy)
        if p61 then
            local v62 = ItemData.GetItemByName(p61.Name);
            local v63 = not v62 and {} or v62.ItemInfo;

            return {
                Identifier = p61:GetAttribute("UUID"),
                Rarity = v63.Rarity or 1,
                Name = v63.Name or p61.Name,
                CanSell = v63.BlackMarketSellable or false,
                Tags = {}
            };
        end;
    end;

    local function UpdateDropTarget(p64, ...) -- Line: 394
        -- upvalues: FindHotbarSlotAtStrict (copy), u8 (copy), Main (copy), Hotbar (copy)
        local v65 = FindHotbarSlotAtStrict(p64, ...);

        if v65 then
            u8:set(v65);

            return;
        end;

        local Content2 = Main.Content;
        local AbsolutePosition = Content2.AbsolutePosition;
        local AbsoluteSize = Content2.AbsoluteSize;
        local v66;

        if p64.X >= AbsolutePosition.X and (p64.X <= AbsolutePosition.X + AbsoluteSize.X and p64.Y >= AbsolutePosition.Y) then
            v66 = p64.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v66 = false;
        end;

        if v66 then
            u8:set(Main.Content);

            return;
        end;

        local Store = Main.Store;
        local AbsolutePosition2 = Store.AbsolutePosition;
        local AbsoluteSize2 = Store.AbsoluteSize;
        local v67;

        if p64.X >= AbsolutePosition2.X and (p64.X <= AbsolutePosition2.X + AbsoluteSize2.X and p64.Y >= AbsolutePosition2.Y) then
            v67 = p64.Y <= AbsolutePosition2.Y + AbsoluteSize2.Y;
        else
            v67 = false;
        end;

        if v67 then
            u8:set(Main.Store);

            return;
        end;

        local Discard = Main.Discard;
        local AbsolutePosition3 = Discard.AbsolutePosition;
        local AbsoluteSize3 = Discard.AbsoluteSize;
        local v68;

        if p64.X >= AbsolutePosition3.X and (p64.X <= AbsolutePosition3.X + AbsoluteSize3.X and p64.Y >= AbsolutePosition3.Y) then
            v68 = p64.Y <= AbsolutePosition3.Y + AbsoluteSize3.Y;
        else
            v68 = false;
        end;

        if v68 then
            u8:set(Main.Discard);

            return;
        end;

        local v69 = Hotbar;
        local AbsolutePosition4 = v69.AbsolutePosition;
        local AbsoluteSize4 = v69.AbsoluteSize;
        local v70;

        if p64.X >= AbsolutePosition4.X and (p64.X <= AbsolutePosition4.X + AbsoluteSize4.X and p64.Y >= AbsolutePosition4.Y) then
            v70 = p64.Y <= AbsolutePosition4.Y + AbsoluteSize4.Y;
        else
            v70 = false;
        end;

        if v70 then
            u8:set(Hotbar);

            return;
        end;

        u8:set(nil);
    end;

    local function DiscardItems(u71) -- Line: 422
        -- upvalues: ItemData (copy), u1 (copy), u4 (copy)
        if not u71 or typeof(u71) ~= "table" then
            return;
        end;

        local v72 = "";

        for i, v in u71 do
            local v73 = ItemData.GetItemByName(v.Name);
            local v74 = not v73 and {} or v73.ItemInfo;

            if v73 then
                v72 = v72 .. `{u1:GetItemText(v74.ItemId)}{u71[i + 1] and ", " or ""}`;
            end;
        end;

        if v72 == "" then
            u1:Notify("Discard Failed", "Item(s) are not discardable", 2);

            return;
        end;

        u1.NewPrompt({
            Title = "Discard Item(s)",
            Delay = 0.35,
            RichText = true,
            Text = `Are you sure you want to discard the following item(s)?:<br />{v72}<br />This will permanently remove them.`,
            Options = { "Confirm", "Cancel" },

            Callback = function(p75) -- Line: 451, Name: Callback
                -- upvalues: u4 (ref), u71 (copy), u1 (ref)
                if p75.Choice ~= 1 then
                    return;
                end;

                if u4:DiscardTools(u71):expect() == false then
                    u1:Notify("Discard Failed", "Failed to discard items", 2);
                end;
            end
        });
    end;

    local function StoreItems(p76) -- Line: 463
        -- upvalues: u4 (copy), u1 (copy)
        if not p76 or typeof(p76) ~= "table" then
            return;
        end;

        if u4:StoreTools(p76):expect() == false then
            u1:Notify("Stashing Failed", "Failed to stash the item(s). Inventory full or item can\'t be stored.", 2);
        end;
    end;

    local function TryMoveItem(p77, p78, p79) -- Line: 473
        -- upvalues: u9 (copy), u21 (ref), u6 (copy), FindFirstEmptySlot (copy), u7 (copy)
        if not (p79 or u9:get()) then
            return;
        end;

        if p78 == "Hotbar" then
            if u21[p77.Identifier] then
                return false;
            end;

            local v80 = table.clone(u6:get());
            local v81 = FindFirstEmptySlot(v80);

            if not v81 then
                return;
            end;

            v80[v81] = p77;
            u6:set(v80);

            return;
        end;

        if p78 == "Backpack" then
            if not u21[p77.Identifier] then
                return false;
            end;

            local v82 = table.clone(u6:get());
            local v83 = false;

            for i, v in ipairs(v82) do
                if v and v.Identifier == v.Identifier then
                    table.remove(v82, i);
                    v83 = true;
                    break;
                end;
            end;

            if v83 then
                if not v82[u7:get()] then
                    u7:set(nil);
                end;

                u6:set(v82);
            end;
        end;
    end;

    local u84 = {};
    local u85 = {
        Time = 0,
        Index = 0
    };
    Fusion.Hydrate(Hotbar.SlotHolder)({
        [Fusion.Children] = Fusion.ForPairs(u6, function(u86, u87) -- Line: 515
            -- upvalues: Assets (copy), Fusion (copy), u8 (copy), u19 (copy), u7 (copy), u1 (copy), Rarities (copy), MakeDraggable (copy), Main (copy), UpdateDropTarget (copy), u85 (copy), TryMoveItem (copy), FindHotbarSlotAt (copy), u6 (copy), u4 (copy), DiscardItems (copy), u84 (copy)
            local u88 = Assets.HotbarSlot:Clone();
            u88.Visible = true;
            u88.SlotTitle.Text = u87.Name;
            u88.LayoutOrder = u86;
            u88.AnchorPoint = Vector2.one * 0.5;
            local v89 = Fusion.Spring(Fusion.Value(u88.Size), 20, 0.85);
            local u90 = Fusion.Value(UDim.new(0, 0));
            local u91 = Fusion.Value(u88:FindFirstChild("UIStroke").Thickness);
            Fusion.Hydrate(u88:FindFirstChild("UIStroke"))({
                BorderOffset = Fusion.Spring(u90, 25, 0.9),
                Thickness = Fusion.Spring(u91, 30, 0.9)
            });
            Fusion.Hydrate(u88)({
                BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 533
                    -- upvalues: u8 (ref), u88 (copy), u19 (ref), u7 (ref), u86 (copy)
                    if u8:get() == u88 then
                        return u19.DragTarget;
                    end;

                    if u7:get() == u86 then
                        return u19.Selected;
                    end;

                    return u19.Default;
                end), 22, 0.85),
                BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 541
                    -- upvalues: u7 (ref), u86 (copy)
                    return u7:get() == u86 and 0.6 or 0.7;
                end), 22, 0.85),
                Size = v89,

                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 548
                    -- upvalues: u90 (copy), u91 (copy), u1 (ref)
                    u90:set(UDim.new(0.02, 0));
                    u91:set(0.035);
                    u1:PlaySound("Inventory/inv_hover");
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 553
                    -- upvalues: u90 (copy), u91 (copy)
                    u90:set(UDim.new(0, 0));
                    u91:set(0.02);
                end
            });
            Fusion.Hydrate(u88.SlotIndex)({
                Text = tostring(u86),
                TextColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 562
                    -- upvalues: u7 (ref), u86 (copy), u19 (ref)
                    if u7:get() == u86 then
                        return u19.Selected;
                    end;

                    return Color3.fromRGB(207, 213, 255);
                end), 22, 0.85)
            });
            local v92 = Rarities[u87.Rarity or 1];
            u88:FindFirstChildOfClass("UIStroke").Color = v92.Color;
            u88:FindFirstChild("BackgroundGradient").BackgroundColor3 = v92.Color;
            MakeDraggable(u88, {
                Container = Main,

                OnMovement = function(p93, p94) -- Line: 579, Name: OnMovement
                    -- upvalues: UpdateDropTarget (ref), u88 (copy)
                    UpdateDropTarget(p94, u88);
                end,

                OnReleased = function(p95, p96) -- Line: 583, Name: OnReleased
                    -- upvalues: u85 (ref), u87 (copy), TryMoveItem (ref), u7 (ref), u86 (copy), FindHotbarSlotAt (ref), u88 (copy), u6 (ref), u8 (ref), Main (ref), u4 (ref), u1 (ref), DiscardItems (ref)
                    if not p95 then
                        task.spawn(function() -- Line: 587
                            -- upvalues: u85 (ref), u87 (ref), TryMoveItem (ref), u7 (ref), u86 (ref)
                            if u85.Index == u87.Identifier and os.clock() - u85.Time < 0.35 then
                                TryMoveItem(u87, "Backpack");

                                return;
                            end;

                            local v97;

                            if u7:get() == u86 then
                                v97 = nil;
                            else
                                v97 = u86;
                            end;

                            u7:set(v97);
                        end);
                        u85.Index = u87.Identifier;
                        u85.Time = os.clock();

                        return;
                    end;

                    local v98, u99 = FindHotbarSlotAt(p96, u88);

                    if not v98 or v98.LayoutOrder == u86 then
                        local Content2 = Main.Content;
                        local AbsolutePosition = Content2.AbsolutePosition;
                        local AbsoluteSize = Content2.AbsoluteSize;
                        local v100;

                        if p96.X >= AbsolutePosition.X and (p96.X <= AbsolutePosition.X + AbsoluteSize.X and p96.Y >= AbsolutePosition.Y) then
                            v100 = p96.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                        else
                            v100 = false;
                        end;

                        if v100 then
                            if u7:get() == u86 then
                                u7:set(nil);
                            end;

                            local v101 = table.clone(u6:get());
                            table.remove(v101, u86);
                            u6:set(v101);
                        end;

                        if u8:get() == Main.Store then
                            local v102 = { u87.Ref };

                            if v102 and (typeof(v102) == "table" and u4:StoreTools(v102):expect() == false) then
                                u1:Notify("Stashing Failed", "Failed to stash the item(s). Inventory full or item can\'t be stored.", 2);
                            end;
                        elseif u8:get() == Main.Discard then
                            DiscardItems({ u87.Ref });
                        end;

                        u8:set(nil);

                        return;
                    end;

                    local v103 = table.clone(u6:get());
                    local v104 = v103[u86];
                    table.remove(v103, u86);
                    local LayoutOrder = v98.LayoutOrder;

                    if u86 < LayoutOrder then
                        LayoutOrder = LayoutOrder - 1;
                    end;

                    if u99 == "right" then
                        table.insert(v103, LayoutOrder + 1, v104);
                    else
                        table.insert(v103, LayoutOrder, v104);
                    end;

                    u6:set(v103);

                    if u7:get() == u86 then
                        task.defer(function() -- Line: 616
                            -- upvalues: u7 (ref), u99 (copy), LayoutOrder (ref)
                            local v105;

                            if u99 == "right" then
                                v105 = LayoutOrder + 1;
                            else
                                v105 = LayoutOrder;
                            end;

                            u7:set(v105);
                        end);
                    end;

                    u8:set(nil);
                end
            });

            if u84[u86] == nil or u84[u86].Identifier ~= u87.Identifier then
                v89:addVelocity(UDim2.fromScale(0.35, 0.35));
            end;

            u84[u86] = u87;

            return u86, u88;
        end, Fusion.cleanup)
    });

    local function MakeCell() -- Line: 654
        -- upvalues: Assets (copy), Fusion (copy), u1 (copy), MakeDraggable (copy), Main (copy), UpdateDropTarget (copy), u20 (copy), u85 (copy), u9 (copy), u21 (ref), u6 (copy), FindFirstEmptySlot (copy), u8 (copy), u4 (copy), DiscardItems (copy), Hotbar (copy), FindHotbarSlotAt (copy)
        local u106 = Assets.Slot:Clone();
        local u107 = Fusion.Value(UDim.new(0, 0));
        local u108 = Fusion.Value(u106:FindFirstChild("UIStroke").Thickness);
        Fusion.Hydrate(u106)({
            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 660
                -- upvalues: u107 (copy), u108 (copy), u1 (ref)
                u107:set(UDim.new(0.02, 0));
                u108:set(0.035);
                u1:PlaySound("Inventory/inv_hover");
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 665
                -- upvalues: u107 (copy), u108 (copy)
                u107:set(UDim.new(0, 0));
                u108:set(0.02);
            end
        });
        Fusion.Hydrate(u106:FindFirstChild("UIStroke"))({
            BorderOffset = Fusion.Spring(u107, 25, 0.9),
            Thickness = Fusion.Spring(u108, 30, 0.9)
        });
        MakeDraggable(u106, {
            Container = Main,

            OnMovement = function(p109, p110) -- Line: 678, Name: OnMovement
                -- upvalues: UpdateDropTarget (ref)
                UpdateDropTarget(p110);
            end,

            OnReleased = function(p111, p112) -- Line: 682, Name: OnReleased
                -- upvalues: u106 (copy), u20 (ref), u85 (ref), u9 (ref), u21 (ref), u6 (ref), FindFirstEmptySlot (ref), u8 (ref), Main (ref), u4 (ref), u1 (ref), DiscardItems (ref), Hotbar (ref), FindHotbarSlotAt (ref)
                if not p111 then
                    local u113 = u106:GetAttribute("Index");

                    if not u113 then
                        return;
                    end;

                    task.spawn(function() -- Line: 689
                        -- upvalues: u20 (ref), u113 (copy), u85 (ref), u9 (ref), u21 (ref), u6 (ref), FindFirstEmptySlot (ref)
                        local v114 = u20:GetItem(u20:GetIdAt(u113));

                        if u85.Index == u113 and os.clock() - u85.Time < 0.35 then
                            if not u9:get() then
                                return;
                            end;

                            if u21[v114.Identifier] then
                                return;
                            end;

                            local v115 = table.clone(u6:get());
                            local v116 = FindFirstEmptySlot(v115);

                            if not v116 then
                                return;
                            end;

                            v115[v116] = v114;
                            u6:set(v115);
                        end;
                    end);
                    u85.Index = u113;
                    u85.Time = os.clock();

                    return;
                end;

                local u117 = u8:get();
                u8:set(nil);
                task.spawn(function() -- Line: 706
                    -- upvalues: u106 (ref), u20 (ref), u117 (copy), Main (ref), u4 (ref), u1 (ref), DiscardItems (ref)
                    local v118 = u106:GetAttribute("Index");

                    if not v118 then
                        return;
                    end;

                    local v119 = u20:GetItem(u20:GetIdAt(v118));

                    if u117 == Main.Store then
                        local v120 = { v119.Ref };

                        if v120 then
                            if typeof(v120) ~= "table" then
                                return;
                            end;

                            if u4:StoreTools(v120):expect() == false then
                                u1:Notify("Stashing Failed", "Failed to stash the item(s). Inventory full or item can\'t be stored.", 2);
                            end;
                        end;
                    elseif u117 == Main.Discard then
                        DiscardItems({ v119.Ref });
                    end;
                end);
                local v121 = Hotbar;
                local AbsolutePosition = v121.AbsolutePosition;
                local AbsoluteSize = v121.AbsoluteSize;
                local v122;

                if p112.X >= AbsolutePosition.X and (p112.X <= AbsolutePosition.X + AbsoluteSize.X and p112.Y >= AbsolutePosition.Y) then
                    v122 = p112.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v122 = false;
                end;

                if not v122 then
                    return;
                end;

                local v123 = u106:GetAttribute("Index");

                if not v123 then
                    return;
                end;

                local v124 = u20:GetItem(u20:GetIdAt(v123));

                if not v124 then
                    return;
                end;

                local v125 = table.clone(u6:get());
                local v126, v127 = FindHotbarSlotAt(p112, nil);

                if v126 then
                    if u21[v124.Identifier] then
                        return;
                    end;

                    local LayoutOrder = v126.LayoutOrder;

                    if #v125 >= 10 then
                        v125[LayoutOrder] = v124;
                    elseif u117 == v126 then
                        v125[LayoutOrder] = v124;
                    elseif v127 == "right" then
                        table.insert(v125, LayoutOrder + 1, v124);
                    else
                        table.insert(v125, LayoutOrder, v124);
                    end;
                else
                    local v128 = FindFirstEmptySlot(v125);

                    if not v128 or u21[v124.Identifier] then
                        return;
                    end;

                    v125[v128] = v124;
                end;

                u6:set(v125);
            end
        });

        return u106;
    end;

    local u136 = v15.new(ScrollingFrame, Content, {
        paddingTop = 4,
        paddingLeft = 4,
        bufferRows = 1,
        cellSize = Vector2.new(74, 74),
        spacing = Vector2.new(8, 8),
        dataSource = u20,

        render = function(p129, p130, p131, p132) -- Line: 767, Name: render
            -- upvalues: Rarities (copy), u21 (ref)
            local v133 = p132 or {};
            local TextLabel = p129:FindFirstChild("TextLabel");

            if TextLabel then
                TextLabel.Text = v133.Name or "thing";
            end;

            local v134 = Rarities[v133.Rarity or 1];
            local v135 = u21[p130];

            if v135 then
                p129.SlotIndex.Visible = true;
                p129.SlotIndex.Text = tostring(v135);
                p129.BindStroke.Enabled = true;
            else
                p129.SlotIndex.Visible = false;
                p129.BindStroke.Enabled = false;
            end;

            p129:FindFirstChildOfClass("UIStroke").Color = v134.Color;
            p129:FindFirstChild("BackgroundGradient").BackgroundColor3 = v134.Color;
        end,

        makeCell = MakeCell
    });
    local u137 = Fusion.Spring(Fusion.Computed(function() -- Line: 794
        -- upvalues: u9 (copy)
        return u9:get() and UDim2.fromScale(1, 0.835) or UDim2.fromScale(1, 0);
    end), 25, 0.85);
    Fusion.Hydrate(Main)({
        Size = u137,
        Visible = Fusion.Computed(function() -- Line: 800
            -- upvalues: u137 (copy)
            return u137:get().Y.Scale >= 0.0001;
        end)
    });
    Fusion.Hydrate(Hotbar)({
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 806
            -- upvalues: u9 (copy)
            return u9:get() and UDim2.fromScale(1, 0.175) or UDim2.fromScale(1, 0.16);
        end), 20, 0.95)
    });
    Fusion.Hydrate(Hotbar.SlotHolder)({
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 812
            -- upvalues: u9 (copy)
            return u9:get() and 0.6 or 1;
        end), 20, 0.95)
    });
    Fusion.Hydrate(Main.Content.Highlight)({
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 821
            -- upvalues: u8 (copy), Main (copy)
            return u8:get() == Main.Content and 0.7 or 1;
        end), 22, 0.85)
    });
    Fusion.Hydrate(Hotbar.Highlight)({
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 830
            -- upvalues: u8 (copy), Hotbar (copy)
            return u8:get() == Hotbar and 0.7 or 1;
        end), 22, 0.85)
    });
    local u138 = Fusion.Computed(function() -- Line: 837
        -- upvalues: u8 (copy), Main (copy)
        return u8:get() == Main.Store;
    end);
    Fusion.Hydrate(Main.Store)({
        Visible = true,
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 843
            -- upvalues: u10 (copy), u138 (copy)
            return u10:get() and (u138:get() and 0.5 or 0.85) or 1;
        end), 22, 0.85)
    });
    Fusion.Hydrate(Main.Store.UIStroke)({
        Transparency = Fusion.Spring(Fusion.Computed(function() -- Line: 852
            -- upvalues: u10 (copy)
            return u10:get() and 0 or 1;
        end), 22, 1)
    });
    Fusion.Hydrate(Main.Store.ImageLabel)({
        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 860
            -- upvalues: u10 (copy)
            return u10:get() and 0 or 1;
        end), 22, 0.95)
    });
    local u139 = Fusion.Computed(function() -- Line: 867
        -- upvalues: u8 (copy), Main (copy)
        return u8:get() == Main.Discard;
    end);
    Fusion.Hydrate(Main.Discard)({
        Visible = true,
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 873
            -- upvalues: u10 (copy), u139 (copy)
            return u10:get() and (u139:get() and 0.5 or 0.85) or 1;
        end), 22, 0.85)
    });
    Fusion.Hydrate(Main.Discard.UIStroke)({
        Transparency = Fusion.Spring(Fusion.Computed(function() -- Line: 882
            -- upvalues: u10 (copy)
            return u10:get() and 0 or 1;
        end), 22, 1)
    });
    Fusion.Hydrate(Main.Discard.ImageLabel)({
        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 890
            -- upvalues: u10 (copy)
            return u10:get() and 0 or 1;
        end), 22, 0.95)
    });

    local function GetComparator(p140) -- Line: 899
        if not p140 then
            return function(p141, p142) -- Line: 901
                return (p141._SortPriority or 0) > (p142._SortPriority or 0);
            end;
        end;

        local Tiebreaker = p140.Tiebreaker;

        return function(p143, p144) -- Line: 909
            -- upvalues: Tiebreaker (copy)
            local v145 = p143._SortPriority or 0;
            local v146 = p144._SortPriority or 0;

            if v145 == v146 then
                return Tiebreaker(p143, p144);
            end;

            return v146 < v145;
        end;
    end;

    Fusion.Observer(u11):onChange(function() -- Line: 921, Name: UpdateSort
        -- upvalues: u11 (copy), u20 (copy)
        local v147 = u11:get();

        if v147 then
            u20:SetPriorityFn(v147.PriorityFn);
            local v148;

            if v147 then
                local Tiebreaker = v147.Tiebreaker;

                v148 = function(p149, p150) -- Line: 909
                    -- upvalues: Tiebreaker (copy)
                    local v151 = p149._SortPriority or 0;
                    local v152 = p150._SortPriority or 0;

                    if v151 == v152 then
                        return Tiebreaker(p149, p150);
                    end;

                    return v152 < v151;
                end;
            else
                v148 = function(p153, p154) -- Line: 901
                    return (p153._SortPriority or 0) > (p154._SortPriority or 0);
                end;
            end;

            u20:SetSort(v148);
        end;
    end);
    Fusion.Observer(u13):onChange(function() -- Line: 930
        -- upvalues: u20 (copy), u13 (copy)
        u20:SetSearch(u13:get());
    end);
    Fusion.Observer(u5):onChange(function() -- Line: 933
        -- upvalues: u5 (copy), u9 (copy)
        if not u5:get() and u9:get() then
            u9:set(false);
        end;
    end);
    Fusion.Observer(u8):onChange(function() -- Line: 938
        -- upvalues: u8 (copy), Main (copy), u1 (copy)
        local v155 = u8:get();

        if v155 == Main.Store or v155 == Main.Discard then
            u1:PlaySound("hover4");
        end;
    end);
    Fusion.Observer(u9):onChange(function() -- Line: 944
        -- upvalues: u1 (copy), u9 (copy)
        u1:PlaySound(u9:get() and "Backpack/bp_open" or "Backpack/bp_close");
    end);
    Fusion.Observer(u7):onChange(function() -- Line: 947
        -- upvalues: u7 (copy), u1 (copy)
        if u7:get() == nil then
            return;
        end;

        u1:PlaySound("Backpack/bp_equip");
    end);
    Fusion.Hydrate(Indexing.Search)({
        [Fusion.OnChange("Text")] = function() -- Line: 954
            -- upvalues: u13 (copy), Indexing (copy)
            u13:set(Indexing.Search.Text);
        end
    });
    v16(Indexing.Sort, {
        Enabled = u5,
        CurrentHotbarSlots = u6,
        ActiveHotbarSlot = u7,
        DropTarget = u8,
        BackpackOpen = u9,
        SearchQuery = u13,
        ActiveSort = u11,
        ActiveSortName = v12,
        UIEngine = u1
    });
    local u156 = {
        [Enum.KeyCode.One] = 1,
        [Enum.KeyCode.Two] = 2,
        [Enum.KeyCode.Three] = 3,
        [Enum.KeyCode.Four] = 4,
        [Enum.KeyCode.Five] = 5,
        [Enum.KeyCode.Six] = 6,
        [Enum.KeyCode.Seven] = 7,
        [Enum.KeyCode.Eight] = 8,
        [Enum.KeyCode.Nine] = 9,
        [Enum.KeyCode.Zero] = 10
    };
    UserInputService.InputBegan:Connect(function(p157, p158) -- Line: 971
        -- upvalues: u5 (copy), u9 (copy), u156 (copy), u6 (copy), u2 (copy), u7 (copy)
        if p158 then
            return;
        end;

        if p157.KeyCode == Enum.KeyCode.Backquote then
            if not u5:get() then
                return;
            end;

            u9:set(not u9:get());

            return;
        end;

        local v159 = u156[p157.KeyCode];

        if not (v159 and u6:get()[v159]) then
            return;
        end;

        local v160 = u2:GetEquippedMoves();

        if v160 then
            for i, v in v160 do
                if v.Keybind == p157.KeyCode.Name:upper() then
                    print("Overlap with", i);

                    return;
                end;
            end;
        end;

        if u7:get() == v159 then
            v159 = nil;
        end;

        u7:set(v159);
    end);
    local u161 = 0;
    local u162 = false;

    local function RequestViewingUpdate() -- Line: 1002
        -- upvalues: u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy), u22 (ref)
        local u163 = u161 + 1;
        u161 = u163;

        if u162 then
            return;
        end;

        u162 = true;
        task.delay(0.05, function() -- Line: 1012
            -- upvalues: u162 (ref), u163 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
            u162 = false;

            if u163 == u161 then
                u20:SetItems(u22);

                return;
            end;

            RequestViewingUpdate();
        end);
    end;

    local function CacheAdd(p164) -- Line: 1025
        -- upvalues: CompileItemFromTool (copy), u22 (ref), u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy)
        local v165 = CompileItemFromTool(p164);

        if not v165 then
            return;
        end;

        v165.Ref = p164;
        u22[v165.Identifier] = v165;
        local u166 = u161 + 1;
        u161 = u166;

        if u162 then
            return;
        end;

        u162 = true;
        task.delay(0.05, function() -- Line: 1012
            -- upvalues: u162 (ref), u166 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
            u162 = false;

            if u166 == u161 then
                u20:SetItems(u22);

                return;
            end;

            RequestViewingUpdate();
        end);
    end;

    local function CacheRemove(p167) -- Line: 1035
        -- upvalues: u22 (ref), u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy)
        if not u22[p167] then
            return;
        end;

        u22[p167] = nil;
        local u168 = u161 + 1;
        u161 = u168;

        if u162 then
            return;
        end;

        u162 = true;
        task.delay(0.05, function() -- Line: 1012
            -- upvalues: u162 (ref), u168 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
            u162 = false;

            if u168 == u161 then
                u20:SetItems(u22);

                return;
            end;

            RequestViewingUpdate();
        end);
    end;

    local u169 = false;

    local function TryAutoSlotMount(u170) -- Line: 1045
        -- upvalues: u169 (ref), u22 (ref), u6 (copy), FindFirstEmptySlot (copy), u21 (ref)
        if u170.Name ~= "Mount" then
            return;
        end;

        if u169 then
            return;
        end;

        task.defer(function() -- Line: 1049
            -- upvalues: u170 (copy), u22 (ref), u6 (ref), FindFirstEmptySlot (ref), u21 (ref), u169 (ref)
            local v171 = u22[u170:GetAttribute("UUID") or u170.Name];

            if not v171 then
                return;
            end;

            local v172 = table.clone(u6:get());
            local v173 = FindFirstEmptySlot(v172);

            if not v173 or u21[v171.Identifier] then
                return;
            end;

            v172[v173] = v171;
            u6:set(v172);
            u169 = true;
        end);
    end;

    local u174 = nil;

    local function IsToolDestroyed(u175) -- Line: 1067
        if u175.Parent then
            return false;
        end;

        local _, result = pcall(function() -- Line: 1069
            -- upvalues: u175 (copy)
            u175.Parent = u175;
        end);

        return string.match(result, "locked") and true or false;
    end;

    local function HandleToolLost(p176) -- Line: 1075
        -- upvalues: u174 (ref), u6 (copy), u7 (copy), u22 (ref), u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy)
        local v177 = p176:GetAttribute("UUID") or p176.Name;

        if u174 == p176 then
            u174 = nil;
        end;

        local v178 = table.clone(u6:get());
        local v179 = false;

        for i, v in ipairs(v178) do
            if v and v.Identifier == v177 then
                table.remove(v178, i);
                v179 = true;
                break;
            end;
        end;

        if v179 then
            if not v178[u7:get()] then
                u7:set(nil);
            end;

            u6:set(v178);
        end;

        if not u22[v177] then
            return;
        end;

        u22[v177] = nil;
        local u180 = u161 + 1;
        u161 = u180;

        if u162 then
            return;
        end;

        u162 = true;
        task.delay(0.05, function() -- Line: 1012
            -- upvalues: u162 (ref), u180 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
            u162 = false;

            if u180 == u161 then
                u20:SetItems(u22);

                return;
            end;

            RequestViewingUpdate();
        end);
    end;

    local function OnToolLost(u181) -- Line: 1104
        -- upvalues: LocalPlayer (ref), HandleToolLost (copy)
        if not u181:IsA("Tool") then
            return;
        end;

        task.defer(function() -- Line: 1106
            -- upvalues: u181 (copy), LocalPlayer (ref), HandleToolLost (ref)
            if u181.Parent == LocalPlayer.Backpack then
                return;
            end;

            if u181.Parent == LocalPlayer.Character then
                return;
            end;

            local u182 = u181;
            local v183;

            if u182.Parent then
                v183 = false;
            else
                local _, result = pcall(function() -- Line: 1069
                    -- upvalues: u182 (copy)
                    u182.Parent = u182;
                end);
                v183 = string.match(result, "locked") and true or false;
            end;

            if not v183 then
                return;
            end;

            HandleToolLost(u181);
        end);
    end;

    local function OnToolAdded(p184) -- Line: 1115
        -- upvalues: u22 (ref), CompileItemFromTool (copy), u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy), u6 (copy), FindFirstEmptySlot (copy), u21 (ref)
        if not p184:IsA("Tool") then
            return;
        end;

        if u22[p184:GetAttribute("UUID") or p184.Name] then
            return;
        end;

        local v185 = CompileItemFromTool(p184);

        if not v185 then
            return;
        end;

        v185.Ref = p184;
        u22[v185.Identifier] = v185;
        local u186 = u161 + 1;
        u161 = u186;

        if not u162 then
            u162 = true;
            task.delay(0.05, function() -- Line: 1012
                -- upvalues: u162 (ref), u186 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
                u162 = false;

                if u186 == u161 then
                    u20:SetItems(u22);

                    return;
                end;

                RequestViewingUpdate();
            end);
        end;

        local v187 = table.clone(u6:get());
        local v188 = FindFirstEmptySlot(v187);

        if v188 and not u21[v185.Identifier] then
            v187[v188] = v185;
            u6:set(v187);
        end;
    end;

    local u189 = Trove.new();

    local function ConnectCharacter(p190) -- Line: 1144
        -- upvalues: u189 (copy), OnToolAdded (copy), OnToolLost (copy), LocalPlayer (ref), CompileItemFromTool (copy), u22 (ref), u161 (ref), u162 (ref), RequestViewingUpdate (copy), u20 (copy), u169 (ref), u6 (copy), FindFirstEmptySlot (copy), u21 (ref), HandleToolLost (copy)
        u189:Clean();
        u189:Connect(p190.ChildAdded, OnToolAdded);
        u189:Connect(p190.ChildRemoved, OnToolLost);
        u189:Connect(LocalPlayer.Backpack.ChildAdded, function(u191) -- Line: 1149
            -- upvalues: CompileItemFromTool (ref), u22 (ref), u161 (ref), u162 (ref), RequestViewingUpdate (ref), u20 (ref), u169 (ref), u6 (ref), FindFirstEmptySlot (ref), u21 (ref)
            if not u191:IsA("Tool") then
                return;
            end;

            local v192 = CompileItemFromTool(u191);

            if v192 then
                v192.Ref = u191;
                u22[v192.Identifier] = v192;
                local u193 = u161 + 1;
                u161 = u193;

                if not u162 then
                    u162 = true;
                    task.delay(0.05, function() -- Line: 1012
                        -- upvalues: u162 (ref), u193 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
                        u162 = false;

                        if u193 == u161 then
                            u20:SetItems(u22);

                            return;
                        end;

                        RequestViewingUpdate();
                    end);
                end;
            end;

            if u191.Name ~= "Mount" then
                return;
            end;

            if u169 then
                return;
            end;

            task.defer(function() -- Line: 1049
                -- upvalues: u191 (copy), u22 (ref), u6 (ref), FindFirstEmptySlot (ref), u21 (ref), u169 (ref)
                local v194 = u22[u191:GetAttribute("UUID") or u191.Name];

                if not v194 then
                    return;
                end;

                local v195 = table.clone(u6:get());
                local v196 = FindFirstEmptySlot(v195);

                if not v196 or u21[v194.Identifier] then
                    return;
                end;

                v195[v196] = v194;
                u6:set(v195);
                u169 = true;
            end);
        end);
        u189:Connect(LocalPlayer.Backpack.ChildRemoved, function(u197) -- Line: 1154
            -- upvalues: LocalPlayer (ref), HandleToolLost (ref)
            if not u197:IsA("Tool") then
                return;
            end;

            task.defer(function() -- Line: 1156
                -- upvalues: u197 (copy), LocalPlayer (ref), HandleToolLost (ref)
                if u197.Parent == LocalPlayer.Character then
                    return;
                end;

                if u197.Parent == LocalPlayer.Backpack then
                    return;
                end;

                local u198 = u197;
                local v199;

                if u198.Parent then
                    v199 = false;
                else
                    local _, result = pcall(function() -- Line: 1069
                        -- upvalues: u198 (copy)
                        u198.Parent = u198;
                    end);
                    v199 = string.match(result, "locked") and true or false;
                end;

                if not v199 then
                    return;
                end;

                HandleToolLost(u197);
            end);
        end);
        u22 = {};

        for _, child in LocalPlayer.Backpack:GetChildren() do
            if child:IsA("Tool") then
                local v200 = CompileItemFromTool(child);

                if v200 then
                    v200.Ref = child;
                    u22[v200.Identifier] = v200;
                end;
            end;
        end;

        local u201 = u161 + 1;
        u161 = u201;

        if not u162 then
            u162 = true;
            task.delay(0.05, function() -- Line: 1012
                -- upvalues: u162 (ref), u201 (copy), u161 (ref), RequestViewingUpdate (ref), u20 (ref), u22 (ref)
                u162 = false;

                if u201 == u161 then
                    u20:SetItems(u22);

                    return;
                end;

                RequestViewingUpdate();
            end);
        end;

        for _, child in LocalPlayer.Backpack:GetChildren() do
            if child:IsA("Tool") and child.Name == "Mount" then
                if child.Name == "Mount" then
                    if not u169 then
                        task.defer(function() -- Line: 1049
                            -- upvalues: child (copy), u22 (ref), u6 (ref), FindFirstEmptySlot (ref), u21 (ref), u169 (ref)
                            local v202 = u22[child:GetAttribute("UUID") or child.Name];

                            if not v202 then
                                return;
                            end;

                            local v203 = table.clone(u6:get());
                            local v204 = FindFirstEmptySlot(v203);

                            if not v204 or u21[v202.Identifier] then
                                return;
                            end;

                            v203[v204] = v202;
                            u6:set(v203);
                            u169 = true;
                        end);
                    end;
                end;
            end;
        end;
    end;

    if LocalPlayer.Character then
        ConnectCharacter(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(ConnectCharacter);

    local function SyncEquip() -- Line: 1189
        -- upvalues: u6 (copy), u7 (copy), u174 (ref), LocalPlayer (ref)
        local v205 = u6:get()[u7:get()];
        local v206;

        if v205 then
            v206 = v205.Ref == u174;
        else
            v206 = v205;
        end;

        if u174 and not v206 then
            u174.Parent = LocalPlayer.Backpack;
            u174 = nil;
        end;

        if not v205 or (not v205.Ref or v206) then
            return;
        end;

        v205.Ref.Parent = LocalPlayer.Character;
        u174 = v205.Ref;
    end;

    Fusion.Observer(u7):onChange(SyncEquip);
    Fusion.Observer(u6):onChange(SyncEquip);
    Fusion.Observer(u6):onChange(function() -- Line: 1208
        -- upvalues: u21 (ref), GetHotbarMap (copy), u136 (copy)
        table.clear(u21);
        u21 = GetHotbarMap();
        u136:Render();
    end);
    Parent.Visible = true;

    function u1.SetBackpackEnabled(p207, p208) -- Line: 1218
        -- upvalues: u5 (copy)
        u5:set(p208);
    end;

    function u1.ToggleBackpack(p209, p210) -- Line: 1222
        -- upvalues: u9 (copy)
        if p210 == nil then
            p210 = not u9:get();
        end;

        u9:set(p210);
    end;

    debug.setmemorycategory("Backpack V2");
end;