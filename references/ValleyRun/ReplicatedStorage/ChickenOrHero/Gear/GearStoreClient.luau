 

 

local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Palette = Skin.Palette;

local function readable(p1, p2, p3, p4) -- Line: 9
    -- upvalues: Skin (copy)
    p1.TextColor3 = p2;
    p1.Font = p3;
    Skin.textStroke(p1, p4);
end;

local u5 = setmetatable({}, {
    __mode = "k"
});

local function look(p6, p7) -- Line: 16
    -- upvalues: u5 (copy), Skin (copy)
    if u5[p6] ~= p7 then
        u5[p6] = p7;
        Skin.button(p6, p7);
    end;
end;

local GearCatalog = require(script.Parent.GearCatalog);

local function toast(u8) -- Line: 25
    task.spawn(function() -- Line: 26
        -- upvalues: u8 (copy)
        local success, result = pcall(function() -- Line: 27
            -- upvalues: u8 (ref)
            local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
            local Parent = script.Parent.Parent;
            local v9;

            if FFlags.awaitUIVersion() == "NewGui" then
                v9 = Parent:WaitForChild("Interface"):WaitForChild("Toasts", 5);
            else
                v9 = Parent:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
            end;

            require(v9).show(u8);
        end);

        if not success then
            warn("GearStoreClient toast: " .. tostring(result));
        end;
    end);
end;

local CurrencyTopUp = require(script.Parent.Parent.Weapons.CurrencyTopUp);
local Bundles = require(script.Parent.Parent.Weapons.Bundles);
local OfferRules = require(script.Parent.Parent.Weapons.OfferRules);

local function bundled(p10) -- Line: 45
    -- upvalues: GearCatalog (copy)
    return GearCatalog.bundleOnly(p10, workspace:GetServerTimeNow());
end;

local function bundleOf(p11) -- Line: 48
    -- upvalues: Bundles (copy), OfferRules (copy)
    local v12 = p11.Bundle and Bundles.get(p11.Bundle);
    local v13;

    if v12 == nil then
        v13 = false;
    else
        v13 = Bundles.isOnSale(v12) and OfferRules.active(v12, workspace:GetServerTimeNow());
    end;

    return v12, v13;
end;

local TutorialConfig = require(script.Parent.Parent.Game.TutorialConfig);

local function tutorialFree(p14, p15) -- Line: 55
    -- upvalues: TutorialConfig (copy)
    local v16;

    if p15 == TutorialConfig.Item then
        v16 = p14:GetAttribute("TutorialStep") == "BuyAdrenaline";
    else
        v16 = false;
    end;

    return v16;
end;

local TextService = game:GetService("TextService");
local u17 = {};
local u18 = 0;

local function fitSize(p19, p20, p21, p22, p23, p24) -- Line: 63
    -- upvalues: u17 (copy), u18 (ref), TextService (copy)
    local v25 = p19 .. "|" .. p21 .. "|" .. p22 .. "|" .. p23;

    if u17[v25] then
        return u17[v25];
    end;

    if u18 >= 256 then
        table.clear(u17);
        u18 = 0;
    end;

    local v26 = p21 * 0.9;
    local v27 = p22 * 0.9;

    for i = p23, p24 + 1, -1 do
        local v28 = TextService:GetTextSize(p19, i, p20, Vector2.new(v26, 10000)).Y <= v27;
        local v29;

        if v28 then
            v29 = i;

            for i2 in string.gmatch(p19, "%S+") do
                if v26 < TextService:GetTextSize(i2, v29, p20, Vector2.new(10000, 10000)).X then
                    v28 = false;
                    break;
                end;
            end;
        else
            v29 = i;
        end;

        if v28 then
            p24 = v29;
        end;
    end;

    u17[v25] = p24;
    u18 = u18 + 1;

    return p24;
end;

local u30 = {};
u30.__index = u30;
local utf8_char_ret = utf8.char(57346);

local function motion(p31, u32) -- Line: 96
    -- upvalues: TweenService (copy)
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = u32;
    local u33 = nil;

    local function animate(p34) -- Line: 100
        -- upvalues: u33 (ref), TweenService (ref), UIScale (copy)
        if u33 then
            u33:Cancel();
        end;

        u33 = TweenService:Create(UIScale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = p34
        });
        u33:Play();
    end;

    for _, v in {
        { u32.MouseEnter, 1.035 },
        { u32.MouseLeave, 1 },
        { u32.SelectionGained, 1.035 },
        { u32.SelectionLost, 1 },
        { u32.MouseButton1Down, 0.94 },
        { u32.MouseButton1Up, 1 }
    } do
        table.insert(p31.connections, v[1]:Connect(function() -- Line: 120
            -- upvalues: animate (copy), u32 (copy), v (copy)
            animate(u32.Active and v[2] or 1);
        end));
    end;
end;

function u30.new(u35, p36) -- Line: 126
    -- upvalues: u30 (copy), Panels (copy), Skin (copy), GearCatalog (copy), TweenService (copy), Palette (copy), Bundles (copy), OfferRules (copy), CurrencyTopUp (copy), motion (copy), u5 (copy), TutorialConfig (copy), MarketplaceService (copy)
    local u37 = setmetatable({
        open = false,
        store = u35,
        cards = {},
        prices = {},
        connections = {},
        kind = p36,
        order = {}
    }, u30);
    local v38 = Panels.make("Frame", u35.root, "GearShop", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    });
    u37.root = v38;
    u37.heading = Panels.text(v38, "Heading", "BUILD YOUR LOADOUT", 0, 0, 600, 32, 27, Panels.Paper);
    u37.subtitle = Panels.text(v38, "Subtitle", "Equip 1 ability + 1 item. Abilities unlock forever; item packs give 3 charges.", 0, 38, 900, 26, 15, Panels.Muted);
    local subtitle = u37.subtitle;
    local GothamMedium = Enum.Font.GothamMedium;
    subtitle.TextColor3 = Panels.Muted;
    subtitle.Font = GothamMedium;
    Skin.textStroke(subtitle, 2);
    u37.abilityHeading = Panels.text(v38, "AbilitiesHeading", "ABILITIES  ·  PERMANENT UNLOCKS", 0, 78, 600, 24, 16, Panels.Gold);
    u37.itemHeading = Panels.text(v38, "ItemsHeading", "ITEMS  ·  3-CHARGE PACKS", 0, 78, 600, 24, 16, Panels.Gold);
    u37.release = Panels.text(v38, "Release", "COMING NEXT UPDATE", 0, 70, 900, 22, 12, Panels.Gold);

    for _, v in GearCatalog.Order do
        local u39 = GearCatalog.get(v);

        if u39.Kind == "Ability" == (p36 == "Ability") then
            if u35.pace then
                u35.pace();
            end;

            table.insert(u37.order, v);
            local v40 = Panels.make("Frame", v38, v, {
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.new(1, 1, 1)
            });
            Panels.corner(v40, 16);
            Panels.stroke(v40, u39.Accent, 0.72);
            local Outline = v40.Outline;
            local UIGradient = Instance.new("UIGradient");
            UIGradient.Color = ColorSequence.new(Color3.fromRGB(31, 48, 61), Color3.fromRGB(15, 27, 38));
            UIGradient.Rotation = 115;
            UIGradient.Parent = v40;
            Skin.card(v40, u39.Accent);
            local UIScale = Instance.new("UIScale");
            UIScale.Parent = v40;
            table.insert(u37.connections, v40.MouseEnter:Connect(function() -- Line: 174
                -- upvalues: TweenService (ref), Outline (copy)
                TweenService:Create(Outline, TweenInfo.new(0.18), {
                    Transparency = 0
                }):Play();
            end));
            table.insert(u37.connections, v40.MouseLeave:Connect(function() -- Line: 180
                -- upvalues: TweenService (ref), Outline (copy), u37 (copy), v (copy), GearCatalog (ref)
                TweenService:Create(Outline, TweenInfo.new(0.18), {
                    Transparency = (u37.store.state.equippedGear == v or GearCatalog.equippedForRole(u37.store.state, GearCatalog.get(v).UseRole) == v) and 0 or 0.4
                }):Play();
            end));
            Panels.make("Frame", v40, "Accent", {
                BorderSizePixel = 0,
                BackgroundColor3 = u39.Accent,
                Size = UDim2.new(1, -32, 0, 2),
                Position = UDim2.fromOffset(16, 15)
            });
            local v41 = Panels.text(v40, "Role", u39.Role, 18, 23, 220, 18, 10, u39.Accent);
            local v42 = u39.Accent:Lerp(Palette.text, 0.25);
            local GothamBold = Enum.Font.GothamBold;
            v41.TextColor3 = v42;
            v41.Font = GothamBold;
            Skin.textStroke(v41, 1.5);
            local v43 = Panels.make("ViewportFrame", v40, "Preview", {
                BackgroundTransparency = 1,
                LightDirection = Vector3.new(-1, -1, -1),
                Position = UDim2.fromOffset(18, 48),
                Size = UDim2.fromOffset(90, 88),
                Ambient = Color3.fromRGB(210, 218, 227),
                LightColor = Color3.new(1, 1, 1)
            });
            local v44 = Panels.make("ImageLabel", v40, "AbilityIcon", {
                BackgroundTransparency = 1,
                Position = v43.Position,
                Size = v43.Size,
                Image = u39.IconImage or "",
                ImageRectOffset = u39.IconRectOffset or Vector2.zero,
                ImageRectSize = u39.IconRectSize or Vector2.zero,
                Visible = u39.IconImage ~= nil,
                ScaleType = Enum.ScaleType.Fit
            });
            v43.Visible = not v44.Visible;
            local v45 = script.Parent.Assets:FindFirstChild(u39.Preview);
            local u46, v47;

            if v45 and not u39.IconImage then
                local WorldModel = Instance.new("WorldModel");
                WorldModel.Parent = v43;
                local Model = Instance.new("Model");
                Model.Parent = WorldModel;
                v45:Clone().Parent = Model;
                u46 = v;

                for _, descendant in Model:GetDescendants() do
                    if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) then
                        descendant:Destroy();
                    elseif descendant:IsA("BasePart") then
                        descendant.Anchored = true;
                        descendant.CanCollide = false;
                        descendant.CanTouch = false;
                        descendant.CanQuery = false;
                    end;
                end;

                local BoundingBox, v48 = Model:GetBoundingBox();
                Model:PivotTo(Model:GetPivot() - BoundingBox.Position);
                local Camera = Instance.new("Camera");
                Camera.Parent = v43;
                v43.CurrentCamera = Camera;
                Camera.FieldOfView = 35;
                local math_max_ret = math.max(v48.X, v48.Y, v48.Z, 0.5);
                Camera.CFrame = CFrame.lookAt(Vector3.new(math_max_ret * 0.9, math_max_ret * 0.55, math_max_ret * 1.9), Vector3.new(0, 0, 0));
                v47 = {
                    camera = Camera,
                    extent = math_max_ret,
                    phase = #u37.connections * 0.17
                };
            else
                u46 = v;
                v47 = nil;
            end;

            local v49 = Panels.make("Frame", v40, "Words", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            });
            v49:SetAttribute("SelfManagedText", true);
            local v50 = Panels.text(v49, "Title", u39.Name, 120, 48, 185, 90, 22, Panels.Paper);
            local GothamBlack = Enum.Font.GothamBlack;
            v50.TextColor3 = Palette.text;
            v50.Font = GothamBlack;
            Skin.textStroke(v50, 2);
            v50.TextYAlignment = Enum.TextYAlignment.Center;
            local v51 = Panels.text(v40, "Tag", u39.Tag, 120, 112, 185, 25, 10, u39.Accent);
            v51.Visible = false;
            local v52 = Panels.text(v49, "Description", u39.Description, 18, 146, 275, 72, 15, Panels.Muted);
            local GothamBold2 = Enum.Font.GothamBold;
            v52.TextColor3 = Palette.text;
            v52.Font = GothamBold2;
            Skin.textStroke(v52, 2);
            v52.TextYAlignment = Enum.TextYAlignment.Center;
            local v53 = Panels.text(v40, "Stock", "0 CHARGES OWNED", 18, 222, 275, 20, 11, u39.Accent);
            local v54 = u39.Accent:Lerp(Palette.text, 0.5);
            local GothamBold3 = Enum.Font.GothamBold;
            v53.TextColor3 = v54;
            v53.Font = GothamBold3;
            Skin.textStroke(v53, 1.5);
            local u55 = Panels.button(v40, "Coins", tostring(u39.Coins), 18, 244, 130, 42, Color3.fromRGB(81, 67, 39));
            local u56 = Panels.button(v40, "Robux", "CHECKING PRICE", 156, 244, 130, 42, Color3.fromRGB(36, 64, 71));
            local u57 = Panels.button(v40, "Gems", tostring(u39.Gems), 18, 292, 270, 38, Color3.fromRGB(43, 70, 65));

            for _, v2 in { u55, u56, u57 } do
                v2.TextSize = 18;
            end;

            table.insert(u37.connections, u57.Activated:Connect(function() -- Line: 270
                -- upvalues: u39 (copy), GearCatalog (ref), Bundles (ref), OfferRules (ref), u57 (copy), u46 (copy), u35 (copy), CurrencyTopUp (ref)
                if not GearCatalog.bundleOnly(u39, workspace:GetServerTimeNow()) then
                    if u39.Kind == "Ability" and u39.Free == true then
                        if u57.Active then
                            script.Parent.Parent.Weapons.ArmoryEvent:FireServer("EquipGear", u46);
                        end;

                        return;
                    end;

                    if u39.Kind == "Ability" and u57.Active then
                        local v58 = u35.state.gems or 0;

                        if v58 < u39.Gems then
                            CurrencyTopUp.prompt("gems", u39.Gems, v58);

                            return;
                        end;

                        u35:notice(u39.Kind == "Ability" and "Unlocking ability…" or "Adding 3 charges…");
                        script.Parent.Parent.Weapons.ArmoryEvent:FireServer("BuyGearGems", u46);
                    end;

                    return;
                end;

                local v59 = u39;
                local v60 = v59.Bundle and Bundles.get(v59.Bundle);
                local v61;

                if v60 == nil then
                    v61 = false;
                else
                    v61 = Bundles.isOnSale(v60) and OfferRules.active(v60, workspace:GetServerTimeNow());
                end;

                if u57.Active and v61 then
                    require(script.Parent.Parent.Weapons.BundlePanel).open(false, u39.Bundle);
                end;
            end));
            local u62 = Panels.button(v40, "Equip", "SELECT LOADOUT", 18, 298, 270, 32, Color3.fromRGB(31, 47, 59));
            u62.TextSize = 11;
            u37.cards[u46] = {
                root = v40,
                border = Outline,
                scale = UIScale,
                previewData = v47,
                icon = v44,
                role = v41,
                title = v50,
                tag = v51,
                desc = v52,
                stock = v53,
                coin = u55,
                robux = u56,
                gem = u57,
                equip = u62,
                preview = v43
            };

            for _, v2 in {
                u55,
                u56,
                u57,
                u62
            } do
                motion(u37, v2);
                v2.TextSize = 12;

                if u5[v2] ~= "secondary" then
                    u5[v2] = "secondary";
                    Skin.button(v2, "secondary");
                end;
            end;

            table.insert(u37.connections, u55.Activated:Connect(function() -- Line: 323
                -- upvalues: u39 (copy), u55 (copy), u35 (copy), u46 (copy), TutorialConfig (ref), CurrencyTopUp (ref)
                if not ((u39.Kind ~= "Ability" or u39.SoldFor == "coins") and u55.Active) then
                    return;
                end;

                local player = u35.player;
                local v63;

                if u46 == TutorialConfig.Item then
                    v63 = player:GetAttribute("TutorialStep") == "BuyAdrenaline";
                else
                    v63 = false;
                end;

                if v63 then
                    u35:notice("Adding 3 free charges…");
                    local TutorialEvent = script.Parent.Parent.Game:FindFirstChild("TutorialEvent");

                    if TutorialEvent then
                        TutorialEvent:FireServer("Adrenaline");
                    end;

                    return;
                end;

                local v64 = u35.state.coins or 0;

                if v64 < u39.Coins then
                    CurrencyTopUp.prompt("coins", u39.Coins, v64);

                    return;
                end;

                u35:notice(u39.Kind == "Ability" and "Unlocking ability…" or "Adding 3 charges…");
                script.Parent.Parent.Weapons.ArmoryEvent:FireServer("BuyGear", u46);
            end));
            table.insert(u37.connections, u62.Activated:Connect(function() -- Line: 347
                -- upvalues: u62 (copy), u46 (copy)
                if u62.Active then
                    script.Parent.Parent.Weapons.ArmoryEvent:FireServer("EquipGear", u46);
                end;
            end));
            table.insert(u37.connections, u56.Activated:Connect(function() -- Line: 355
                -- upvalues: u56 (copy), u35 (copy), MarketplaceService (ref), u39 (copy)
                if not u56.Active or u35.player:GetAttribute("InMatch") == true then
                    return;
                end;

                if not pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, u35.player, u39.ProductId) then
                    u35:notice("The purchase window could not open. Please try again.");
                end;
            end));
        end;
    end;

    if p36 == "Ability" then
        local u65 = {
            Runner = 1,
            Catcher = 2
        };
        table.sort(u37.order, function(p66, p67) -- Line: 368
            -- upvalues: GearCatalog (ref), u65 (copy)
            local v68 = GearCatalog.get(p66);
            local v69 = GearCatalog.get(p67);

            if v68.UseRole ~= v69.UseRole then
                return (u65[v68.UseRole] or 3) < (u65[v69.UseRole] or 3);
            end;

            if v68.Free == true ~= (v69.Free == true) then
                return v68.Free == true;
            end;

            if v68.Gems == v69.Gems then
                return v68.Name < v69.Name;
            end;

            return v68.Gems > v69.Gems;
        end);
    end;

    u37.teamHeadings = {
        Runner = Panels.text(v38, "RunnerHeading", "RUNNERS", 0, 0, 600, 24, 16, Panels.Gold),
        Catcher = Panels.text(v38, "ChaserHeading", "CHASERS", 0, 0, 600, 24, 16, Panels.Gold)
    };

    return u37;
end;

function u30.listed(p70, p71) -- Line: 386
    -- upvalues: GearCatalog (copy), Bundles (copy), OfferRules (copy)
    local v72 = GearCatalog.get(p71);

    if not GearCatalog.bundleOnly(v72, workspace:GetServerTimeNow()) then
        return true;
    end;

    local v73 = p70.store.state and p70.store.state.abilities;

    if type(v73) == "table" and v73[p71] == true then
        return true;
    end;

    local v74 = v72.Bundle and Bundles.get(v72.Bundle);
    local v75;

    if v74 == nil then
        v75 = false;
    else
        v75 = Bundles.isOnSale(v74) and OfferRules.active(v74, workspace:GetServerTimeNow());
    end;

    return v75;
end;

function u30.sequence(p76) -- Line: 400
    -- upvalues: GearCatalog (copy)
    local u77 = {};
    local v78 = {};

    for i, v in p76.order do
        u77[v] = i;

        if p76:listed(v) then
            table.insert(v78, v);
        end;
    end;

    local u79 = {
        Runner = 1,
        Catcher = 2
    };
    local u80 = p76.kind == "Ability";
    table.sort(v78, function(p81, p82) -- Line: 410
        -- upvalues: GearCatalog (ref), u80 (copy), u79 (copy), u77 (copy)
        local v83 = GearCatalog.get(p81);
        local v84 = GearCatalog.get(p82);

        if u80 and v83.UseRole ~= v84.UseRole then
            return (u79[v83.UseRole] or 3) < (u79[v84.UseRole] or 3);
        end;

        if u80 and v83.Free == true ~= (v84.Free == true) then
            return v83.Free == true;
        end;

        local v85 = v84.Bundle ~= nil;

        if v83.Bundle ~= nil == v85 then
            return u77[p81] < u77[p82];
        end;

        return v85;
    end);

    return v78;
end;

function u30.refresh(p86) -- Line: 426
    -- upvalues: GearCatalog (copy), RunService (copy), Bundles (copy), OfferRules (copy), utf8_char_ret (copy), Palette (copy), TutorialConfig (copy), u5 (copy), Skin (copy)
    local state = p86.store.state;

    if p86.kind == "Item" and (state and (state ~= p86.soulChecked and (state.loaded == true and not (state.pending or (state.equippedGear ~= "RescueKit" or (GearCatalog.equippedForRole(state, "Runner") ~= "SoulReap" or p86.store.player:GetAttribute("InMatch") == true)))))) then
        p86.soulChecked = state;
        script.Parent.Parent.Weapons.ArmoryEvent:FireServer("EquipGear", "RescueKit");
        local u87 = "Soul Reap is equipped: no self-revive, so your Rescue Kit was taken off.";
        task.spawn(function() -- Line: 26
            -- upvalues: u87 (copy)
            local success, result = pcall(function() -- Line: 27
                -- upvalues: u87 (ref)
                local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
                local Parent = script.Parent.Parent;
                local v88;

                if FFlags.awaitUIVersion() == "NewGui" then
                    v88 = Parent:WaitForChild("Interface"):WaitForChild("Toasts", 5);
                else
                    v88 = Parent:WaitForChild("Presentation"):WaitForChild("ValleyToast", 5);
                end;

                require(v88).show(u87);
            end);

            if not success then
                warn("GearStoreClient toast: " .. tostring(result));
            end;
        end);
    end;

    if table.concat(p86:sequence(), ",") ~= p86.listing and p86.store.layoutWidth then
        p86.store:layout(p86.store.layoutWidth, p86.store.layoutPortrait);
    end;

    local open = p86.open;

    if open then
        if state.loaded == true then
            open = not state.pending and p86.store.player:GetAttribute("InMatch") ~= true;
        else
            open = false;
        end;
    end;

    local v89 = GearCatalog.SalesEnabled or RunService:IsStudio();
    p86.release.Visible = not GearCatalog.SalesEnabled;

    for i, v in p86.cards do
        local v90 = GearCatalog.get(i);
        local v91 = state.gear and (state.gear[i] or 0) or 0;
        local v92 = v90.Kind == "Ability";
        local v93;

        if v92 and (state.abilities and state.abilities[i] == true) then
            v93 = true;
        else
            v93 = not v92 and v91 > 0;
        end;

        local v94 = (v92 and GearCatalog.equippedForRole(state, v90.UseRole) or state.equippedGear) == i;
        local v95 = v92 and not v93 or not v92 and v91 + GearCatalog.PackSize <= GearCatalog.MaxInventory;
        local v96 = v90.Bundle and Bundles.get(v90.Bundle);
        local v97;

        if v96 == nil then
            v97 = false;
        else
            v97 = Bundles.isOnSale(v96) and OfferRules.active(v96, workspace:GetServerTimeNow());
        end;

        local v98 = not v93 and GearCatalog.locked(v90);
        local v99;

        if v92 then
            v99 = v90.SoldFor == "coins";
        else
            v99 = v92;
        end;

        local v100;

        if v92 then
            v100 = v90.RewardOnly == true;
        else
            v100 = v92;
        end;

        local stock = v.stock;
        local v101;

        if v92 then
            if v93 then
                v101 = "UNLOCKED  ·  REUSABLE ABILITY";
            elseif v100 then
                v101 = v90.UnlockText or "REWARD ONLY";
            elseif v98 then
                v101 = v90.UnlockText or "LOCKED";
            else
                v101 = GearCatalog.bundleOnly(v90, workspace:GetServerTimeNow()) and (v96 and "ONLY IN THE " .. v96.Title) or "PERMANENT UNLOCK  ·  NO CHARGES";
            end;
        else
            v101 = tostring(v91) .. " CHARGES OWNED  ·  +3 PER PACK";
        end;

        stock.Text = v101;
        v.coin.Text = not state.loaded and "LOADING…" or (not v89 and "COMING SOON" or tostring(v90.Coins));
        v.coin.Visible = not v92 or v99;
        local v102;

        if v92 and not v99 then
            v102 = v99;
        elseif open then
            if v89 then
                if v95 then
                    v102 = not v98;
                else
                    v102 = v95;
                end;
            else
                v102 = v89;
            end;
        else
            v102 = open;
        end;

        v.coin.Active = v102;
        v.gem.Text = tostring(v90.Gems);
        local v103;

        if v92 then
            v103 = not v99;
        else
            v103 = v92;
        end;

        v.gem.Visible = v103;
        local v104 = v92 and not v99;

        if v104 then
            if open then
                if v89 then
                    v104 = v95;
                else
                    v104 = v89;
                end;
            else
                v104 = open;
            end;
        end;

        v.gem.Active = v104;
        local v105 = p86.prices[i];
        local v106;

        if type(v105) == "table" then
            v106 = v105.PriceInRobux;
        else
            v106 = false;
        end;

        local v107;

        if type(v106) == "number" and v106 == v106 then
            v107 = v106 >= 0;
        else
            v107 = false;
        end;

        local robux = v.robux;
        local v108 = v107 and utf8_char_ret .. " " .. tostring(v106) .. (v105.IsForSale and "" or " · SOON");

        if not v108 then
            if type(v105) == "table" then
                v108 = v105.IsForSale == false and "ROBUX · SOON" or "PRICE UNAVAILABLE";
            else
                v108 = v105 == false and "UNAVAILABLE" or "CHECKING PRICE";
            end;
        end;

        robux.Text = v108;
        local v109 = open and (not v98 and GearCatalog.SalesEnabled);

        if v109 then
            if v95 then
                if game.GameId == 10764627709 then
                    if v107 then
                        v107 = v105.IsForSale == true;
                    end;
                else
                    v107 = false;
                end;
            else
                v107 = v95;
            end;
        else
            v107 = v109;
        end;

        v.robux.Active = v107;
        v.border.Transparency = v94 and 0 or 0.4;
        v.border.Color = v94 and Palette.green or v90.Accent;
        local v110;

        if v94 then
            v110 = v92 and "ABILITY EQUIPPED  ✓" or "ITEM EQUIPPED  ✓";
        elseif v93 then
            v110 = v92 and "EQUIP ABILITY" or "EQUIP ITEM";
        else
            v110 = v92 and "UNLOCK TO EQUIP" or "NO CHARGES OWNED";
        end;

        v.equip.Text = v110;
        v.equip.Active = open and v93;

        if v100 and not v93 then
            v.robux.Visible = false;
            v.robux.Active = false;
            v.gem.Text = v90.RewardText or "REWARD ONLY";
            v.gem.Active = false;
        end;

        if GearCatalog.bundleOnly(v90, workspace:GetServerTimeNow()) then
            v.robux.Visible = false;
            v.robux.Active = false;
            v.gem.Text = v93 and "OWNED" or (v97 and "GET IN BUNDLE" or "BUNDLE ENDED");
            local v111 = not v93;

            if v111 then
                if v97 then
                    v97 = open;
                end;
            else
                v97 = v111;
            end;

            v.gem.Active = v97;
        end;

        if not v92 then
            local player = p86.store.player;
            local v112;

            if i == TutorialConfig.Item then
                v112 = player:GetAttribute("TutorialStep") == "BuyAdrenaline";
            else
                v112 = false;
            end;

            if v112 then
                v.coin.Text = "FREE";
                v.coin.Active = open;
            end;
        end;

        if v92 and v93 then
            v.coin.Text = "OWNED";
            v.gem.Text = "OWNED";
            v.robux.Text = "OWNED";
        end;

        if v92 and v90.Free == true then
            local Attribute = p86.store.player:GetAttribute("TutorialStep");
            local v113 = not v94;

            if v113 then
                if Attribute == "RunnerAbility" and i == TutorialConfig.RunnerAbility then
                    v113 = true;
                elseif Attribute == "ChaserAbility" then
                    v113 = i == TutorialConfig.ChaserAbility;
                else
                    v113 = false;
                end;
            end;

            v.gem.Text = "FREE";
            v.gem.Visible = v113;
            v.gem.Active = v113 and open;
            v.robux.Visible = false;
            v.robux.Active = false;
            v.equip.Visible = not v113;
        end;

        local v114 = v;

        for _, v2 in {
            v.coin,
            v.robux,
            v.gem,
            v.equip
        } do
            v2.AutoButtonColor = v2.Active;
            v2.TextTransparency = v2.Active and 0 or 0.35;
        end;

        local coin = v114.coin;
        local v115 = v114.coin.Active and "buy-coins" or "secondary";

        if u5[coin] ~= v115 then
            u5[coin] = v115;
            Skin.button(coin, v115);
        end;

        local gem = v114.gem;
        local v116 = (v114.gem.Active or v92 and v90.Free == true) and (GearCatalog.bundleOnly(v90, workspace:GetServerTimeNow()) and "buy-robux" or (v90.Free == true and "buy-coins" or "buy-gems")) or "secondary";

        if u5[gem] ~= v116 then
            u5[gem] = v116;
            Skin.button(gem, v116);
        end;

        if v92 and v90.Free == true then
            v114.gem.TextTransparency = 0;
        end;

        Skin.price(v114.coin, v114.coin.Text == tostring(v90.Coins) and "coins" or nil, {
            dim = not v114.coin.Active
        });
        Skin.price(v114.gem, v114.gem.Text == tostring(v90.Gems) and "gems" or nil, {
            dim = not v114.gem.Active
        });
        local robux2 = v114.robux;
        local v117 = v114.robux.Active and "buy-robux" or "secondary";

        if u5[robux2] ~= v117 then
            u5[robux2] = v117;
            Skin.button(robux2, v117);
        end;

        local equip = v114.equip;
        local v118 = v94 and "primary" or (v93 and "dark" or "secondary");

        if u5[equip] ~= v118 then
            u5[equip] = v118;
            Skin.button(equip, v118);
        end;
    end;
end;

function u30.setOpen(u119, p120) -- Line: 553
    -- upvalues: TweenService (copy), GearCatalog (copy), MarketplaceService (copy)
    local open = u119.open;
    u119.open = p120;

    if p120 and not open then
        for i, v in u119.order do
            local v121 = u119.cards[v];
            v121.scale.Scale = 0.96;
            TweenService:Create(v121.scale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, math.min(i - 1, 5) * 0.035), {
                Scale = 1
            }):Play();
            u119.prices[v] = nil;

            if GearCatalog.get(v).ProductId then
                task.spawn(function() -- Line: 577
                    -- upvalues: MarketplaceService (ref), GearCatalog (ref), v (copy), u119 (copy)
                    local GetProductInfoAsync = MarketplaceService.GetProductInfoAsync;
                    local ProductId = GearCatalog.get(v).ProductId;
                    local success, result = pcall(GetProductInfoAsync, MarketplaceService, ProductId, Enum.InfoType.Product);

                    if u119.destroyed then
                        return;
                    end;

                    u119.prices[v] = success and result and result or false;
                    u119:refresh();
                end);
            end;
        end;
    end;

    u119:refresh();
end;

function u30.layout(p122, p123, p124, p125) -- Line: 594
    -- upvalues: GearCatalog (copy), fitSize (copy)
    local v126 = p122.kind == "Ability";
    local v127 = p124 and 1 or (v126 and p123 >= 900 and 4 or (p123 >= 940 and 3 or 2));
    local v128 = (p123 - 8 - 14 * (v127 - 1)) / v127;
    local v129 = p122:sequence();
    p122.listing = table.concat(v129, ",");
    local v130 = {};

    for _, v in v129 do
        v130[v] = true;
    end;

    for i, v in p122.cards do
        v.root.Visible = v130[i] == true;
    end;

    local v131 = v126 and p124 and 58 or 32;
    local v132 = not v126 and 112 or v131 + 16;
    local v133 = v132 + math.ceil(#v129 / v127) * 366;
    p122.heading.Text = v126 and "CHOOSE YOUR ABILITIES: 1 Runner and 1 Chaser" or "STOCK UP ON ITEMS";
    p122.subtitle.Text = "Equip one item. Each pack adds 3 charges.";
    p122.subtitle.Visible = not v126;
    p122.abilityHeading.Visible = false;
    p122.itemHeading.Visible = not v126;
    p122.abilityHeading.Size = UDim2.fromOffset(p123 - 8, 24);
    p122.itemHeading.Position = UDim2.fromOffset(0, 78);
    p122.itemHeading.Size = UDim2.fromOffset(p123 - 8, 24);
    p122.root.Position = UDim2.fromOffset(0, p125);
    p122.root.Size = UDim2.fromOffset(p123, v133);
    p122.heading.Size = UDim2.fromOffset(p123 - 8, v131);
    p122.heading.TextSize = p124 and 23 or 27;
    p122.subtitle.Size = UDim2.fromOffset(p123 - 8, 36);
    p122.subtitle.TextSize = p124 and 13 or 15;

    for _, v in p122.teamHeadings do
        v.Visible = false;
    end;

    local v134 = nil;
    local v135 = 0;

    for i, v in v129 do
        local v136 = p122.cards[v];
        local v137 = GearCatalog.get(v);
        local v138 = i - 1;

        if v126 then
            if v137.UseRole == v134 then
                v138 = v135;
            else
                if v134 then
                    v132 = v132 + (math.ceil(v135 / v127) * 366 + 18);
                end;

                v134 = v137.UseRole;
                local v139 = p122.teamHeadings[v134];
                v139.Visible = true;
                v139.Position = UDim2.fromOffset(0, v132);
                v139.Size = UDim2.fromOffset(p123 - 8, 24);
                v132 = v132 + 36;
                v138 = 0;
            end;

            v135 = v138 + 1;
        end;

        v136.root.Position = UDim2.fromOffset(v138 % v127 * (v128 + 14), v132 + math.floor(v138 / v127) * 366);
        v136.root.Size = UDim2.fromOffset(v128, 352);
        v136.role.Size = UDim2.fromOffset(v128 - 36, 18);
        local v140;

        if v126 then
            v140 = v127 == 4;
        else
            v140 = v126;
        end;

        local v141 = v140 and 76 or 90;
        local v142 = v140 and 104 or 120;
        v136.preview.Position = UDim2.fromOffset(v140 and 16 or 18, 48);
        v136.preview.Size = UDim2.fromOffset(v141, v141);
        v136.icon.Position = v136.preview.Position;
        v136.icon.Size = v136.preview.Size;
        v136.title.Position = UDim2.fromOffset(v142, 48);
        v136.title.Size = UDim2.fromOffset(v128 - v142 - 18, v141);
        local v143 = 48 + v141 + 6;
        v136.desc.Position = UDim2.fromOffset(18, v143);
        v136.desc.Size = UDim2.fromOffset(v128 - 36, 228 - v143);
        v136.stock.Position = UDim2.fromOffset(18, 232);
        v136.stock.Size = UDim2.fromOffset(v128 - 36, 20);
        local v144;

        if v126 then
            v144 = v137.SoldFor == "coins";
        else
            v144 = v126;
        end;

        local v145 = (GearCatalog.bundleOnly(v137, workspace:GetServerTimeNow()) or (v137.RewardOnly == true or v137.Free == true and v126)) and { v136.gem } or (v126 and not v144 and { v136.gem, v136.robux } or { v136.coin, v136.robux });
        v136.coin.Visible = not v126 or v144;
        local v146;

        if v126 then
            v146 = not v144;
        else
            v146 = v126;
        end;

        v136.gem.Visible = v146;
        local v147 = (v128 - 36 - (#v145 - 1) * 6) / #v145;

        for i2, v2 in v145 do
            v2.Position = UDim2.fromOffset(18 + (i2 - 1) * (v147 + 6), 258);
            v2.Size = UDim2.fromOffset(v147, 38);
            v2.TextSize = 11;
        end;

        v136.equip.Position = UDim2.fromOffset(18, 308);
        v136.equip.Size = UDim2.fromOffset(v128 - 36, 30);
    end;

    local v148;

    if v126 then
        v148 = v127 == 4;
    else
        v148 = v126;
    end;

    for _, v in v129 do
        local v149 = p122.cards[v];
        local v150 = GearCatalog.get(v);
        v149.title.TextScaled = false;
        v149.title.TextSize = fitSize(v150.Name, Enum.Font.GothamBlack, v149.title.Size.X.Offset, v149.title.Size.Y.Offset, v148 and 30 or 34, 14);
        v149.desc.TextScaled = false;
        v149.desc.TextSize = fitSize(v150.Description, Enum.Font.GothamBold, v149.desc.Size.X.Offset, v149.desc.Size.Y.Offset, 40, 12);
    end;

    if v126 then
        v133 = v132 + math.ceil(v135 / v127) * 366;
        p122.root.Size = UDim2.fromOffset(p123, v133);
    end;

    return p125 + v133 + 18;
end;

function u30.step(p151, p152) -- Line: 700
    if not p151.open then
        return;
    end;

    p151.elapsed = (p151.elapsed or 0) + math.min(p152, 0.1);

    for _, v in p151.cards do
        local previewData = v.previewData;

        if previewData then
            local v153 = p151.elapsed * 0.28 + previewData.phase;
            local camera = previewData.camera;
            local CFrame_lookAt = CFrame.lookAt;
            local v154 = math.sin(v153) * previewData.extent * 2;
            local v155 = previewData.extent * (math.sin(p151.elapsed * 1.6 + previewData.phase) * 0.06 + 0.45);
            local v156 = math.cos(v153) * previewData.extent * 2;
            camera.CFrame = CFrame_lookAt(Vector3.new(v154, v155, v156), Vector3.new(0, 0, 0));
        end;
    end;
end;

function u30.destroy(p157) -- Line: 720
    p157.destroyed = true;

    for _, v in p157.connections do
        v:Disconnect();
    end;
end;

return u30;