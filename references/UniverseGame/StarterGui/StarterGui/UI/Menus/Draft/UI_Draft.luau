  

 

return function(p1) -- Line: 1
    print("UI DRAFT UI DRAFT");
    local Players = game:GetService("Players");
    local Trove = require(p1.KnitPath.Trove);
    local ReplicatedModules = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules");
    local TeleportService = game:GetService("TeleportService");
    local ItemData = require(ReplicatedModules:WaitForChild("ItemData"));
    require(ReplicatedModules:WaitForChild("Stands"));
    local StatsHandler = require(ReplicatedModules:WaitForChild("StatsHandler"));
    local TraitHandler = require(ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    local WhitelistHandler = require(ReplicatedModules.Handlers.WhitelistHandler);
    local Knit = p1.Knit;
    local Parent = script.Parent;
    p1._DraftGui = Parent;
    local u2 = nil;
    Knit.OnStart():await();
    local u3 = Knit.GetService("MoveService");
    local u4 = Knit.GetService("InventoryService");
    local u5 = Knit.GetService("DraftService");
    local u6 = Knit.GetService("LeaderboardService");
    local u7 = Knit.GetService("GameModeService");
    local TimeIndicator = Parent.TimeIndicator;
    Parent.TimeIndicator.Visible = false;

    function p1.GetSeasonText(p8) -- Line: 41
        -- upvalues: u6 (copy)
        local v9 = u6:GetSeasonTimeRemainingString():expect();
        local v10 = u6:GetSeason():expect();
        local v11 = string.match(v10, "%d+");
        local v12 = Random.new((tonumber(v11))):NextInteger(0, 360);
        local v13 = Color3.fromHSV(v12 / 360, 0.5, 0.7);
        local v14 = string.match(v9, "%(Resets at: ([^%)]+)%)");
        local v15 = `<font color="rgb({math.floor(v13.R * 255)},{math.floor(v13.G * 255)},{math.floor(v13.B * 255)})">{v11}</font>`;

        if v14 then
            return `Season {v15} (Resets at: {v14})`;
        end;

        return `Season {v15}`;
    end;

    function p1.FetchDraftAbilities(p16) -- Line: 60
        -- upvalues: u5 (copy)
        local v17 = u5:GetAbilities():expect();
        print(v17);

        return v17;
    end;

    function p1.GetCRAbilities(p18) -- Line: 66
        -- upvalues: u2 (ref), WhitelistHandler (copy)
        if not u2 then
            u2 = WhitelistHandler.GetCRAbilities();
            print((`[BAN PHASE] Cached {#u2} CR Abilities`));
        end;

        return u2;
    end;

    local u19 = {};

    function p1.FetchPlayerIcons(p20) -- Line: 75
        -- upvalues: Players (copy), u19 (copy)
        local v21 = {};

        for _, v in Players:GetPlayers() do
            local v22 = {
                Player = v
            };

            if not u19[v] then
                local success, result = pcall(function() -- Line: 83
                    -- upvalues: Players (ref), v (copy)
                    return Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
                end);

                if not success then
                    warn("Error fetching thumbnail, ", result);
                    result = false;
                end;

                u19[v] = result;
            end;

            v22.Icon = u19[v];
            v22.Ready = v:GetAttribute("DraftSubmitted") and true or false;
            table.insert(v21, v22);
        end;

        return v21;
    end;

    function p1.FetchMoveset(p23, p24) -- Line: 104
        -- upvalues: StatsHandler (copy)
        return StatsHandler.GetStats(p24).Moveset;
    end;

    function p1.FetchMoveInformation(p25, p26) -- Line: 111
        -- upvalues: u3 (copy)
        return u3:GetMovesInfo():expect()[p26];
    end;

    function p1.ConnectDraftAbilitySelected(u27, u28, p29, u30) -- Line: 116
        -- upvalues: ItemData (copy), u5 (copy)
        return p29.MouseButton1Click:Connect(function() -- Line: 117
            -- upvalues: u27 (copy), u28 (copy), u30 (copy), ItemData (ref), u5 (ref)
            if u27.PromptActive() then
                return;
            end;

            u27._CurrentAbility = u28;
            u27._CurrentUUID = u30;

            if u27.PromptActive() then
                return;
            end;

            local v31 = u27.Phase == "Banning" and "Ban" or "Select";

            if u27.Phase ~= "Banning" or u30 then
                u27.NewPrompt({
                    Delay = 0.25,
                    Title = `{v31} Ability: {u27._CurrentAbility}`,
                    Text = `Are you sure you want to {v31:lower()} this ability?`,
                    Options = { "Yes", "No" },

                    Callback = function(p32) -- Line: 173, Name: Callback
                        -- upvalues: u27 (ref), u5 (ref)
                        if p32.Choice ~= 1 then
                            return;
                        end;

                        u27:PlaySound("Click");
                        warn(u27._CurrentUUID);
                        local v33 = u5:SelectAbility(u27._CurrentUUID):expect();

                        if v33 and typeof(v33) == "string" then
                            u27.NewPrompt({
                                Title = "Error",
                                Text = `{v33}`,
                                Options = { "Ok" }
                            });
                        end;
                    end
                });

                return;
            end;

            local u34 = nil;

            for i, v in ItemData.Abilities do
                if v.Name == u28 then
                    u34 = i;
                    break;
                end;
            end;

            if u34 then
                u27.NewPrompt({
                    Text = "Are you sure you want to ban this ability?",
                    Delay = 0.25,
                    Title = `Ban Ability: {u28}`,
                    Options = { "Yes", "No" },

                    Callback = function(p35) -- Line: 148, Name: Callback
                        -- upvalues: u27 (ref), u5 (ref), u34 (ref)
                        if p35.Choice ~= 1 then
                            return;
                        end;

                        u27:PlaySound("Click");
                        local v36 = u5:BanByItemId(u34):expect();

                        if v36 and typeof(v36) == "string" then
                            u27.NewPrompt({
                                Title = "Error",
                                Text = `{v36}`,
                                Options = { "Ok" }
                            });
                        end;
                    end
                });

                return;
            end;

            warn((`Could not find ItemId for {u28}`));
        end);
    end;

    local u37 = {
        Color3.fromRGB(255, 83, 83),
        Color3.fromRGB(120, 152, 255),
        Color3.fromRGB(119, 255, 135),
        Color3.fromRGB(255, 221, 117)
    };

    function p1.DrawPlayerIcons(p38) -- Line: 199
        -- upvalues: Parent (copy), u37 (copy)
        local PlayerEntry = Parent.Assets:FindFirstChild("PlayerEntry");

        for _, child in Parent.Holder.PlayerArea.Holder:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for _, v in p38:FetchPlayerIcons() do
            warn("DRAWING ENTRY FOR ", v.Player);
            local v39 = v.Player:GetAttribute("DraftAbility");
            local v40 = PlayerEntry:Clone();

            if v39 then
                (" (%*)"):format(v39);
            end;

            v40.Name = v.Player.Name;
            v40.NameLabel.Text = v.Player.Name:upper();
            v40.StatusLabel.Text = v.Ready and "READY" or "NOT READY";

            if v.Ready then
                v40.StatusLabel.TextColor3 = Color3.fromRGB(90, 255, 90);
            end;

            v40.Img.Image = v.Icon or "rbxthumb://type=AvatarHeadShot&id=5089042927&w=420&h=420";
            v40.Visible = true;
            v40.Parent = Parent.Holder.PlayerArea.Holder;

            if v.Player and v.Player:GetAttribute("TeamIndex") then
                local v41 = v.Player:GetAttribute("TeamIndex");
                local v42 = u37[v41];

                if v42 then
                    v40.Background.BackgroundColor3 = v42;
                    v40.Background.Visible = true;
                    v40.LayoutOrder = v41;
                end;
            end;

            warn("ENTRY PARENT: ", v40.Parent);
        end;
    end;

    local u43 = nil;

    function p1.GetAbilityNameToIdCache(p44) -- Line: 244
        -- upvalues: u43 (ref), ItemData (copy)
        if not u43 then
            u43 = {};

            for i, v in ItemData.Abilities do
                if v.Name then
                    u43[v.Name] = i;
                end;
            end;

            print((`[CACHE] Built ability name lookup with {#u43} entries`));
        end;

        return u43;
    end;

    function p1.DrawDraftAbilityButtons(p45, p46) -- Line: 257
        -- upvalues: Parent (copy), u4 (copy)
        print(p46);

        for _, child in Parent.Holder.AbilityArea.Items:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        if p45.Phase ~= "Banning" then
            print("[DRAFT PHASE] Showing owned abilities from inventory");

            for _, v in u4:GetItems("AbilityInventory"):expect() do
                p45:MakeDraftAbilityButton(v);
            end;

            return;
        end;

        local v47 = p45:GetCRAbilities();

        if not v47 then
            warn("No CR abilities found!");

            return;
        end;

        print((`[BAN PHASE] Showing {#v47} abilities from CR whitelist`));
        local v48 = u4:GetItems("AbilityInventory"):expect();

        for _, v in v47 do
            if p45.Phase ~= "Banning" then
                break;
            end;

            p45:MakeDraftAbilityButtonFromName(v, v48);
        end;

        print((`[BAN PHASE] Finished loading all {#v47} abilities`));
    end;

    local u49 = u5:GetBlacklist():expect();

    function p1.MakeDraftAbilityButton(u50, u51) -- Line: 291
        -- upvalues: ItemData (copy), u49 (copy), Parent (copy), TraitHandler (copy), Trove (copy)
        local v52;

        if u51 then
            local v53 = ItemData.GetItemInfo(u51._ItemId);

            if not v53 then
                return;
            end;

            v52 = v53.Name;
        else
            v52 = nil;
        end;

        if not (v52 and table.find(u49, v52)) then
            local v54 = ItemData.GetItemInfo(u51._ItemId);
            local u55 = Parent.Assets.Container:Clone();
            u55.Name = v52;
            u55.Button.Label.Text = v52:upper();
            u55.Visible = true;
            u55.Parent = Parent.Holder.AbilityArea.Items;
            local v56 = ItemData.Rarities[v54.Rarity];

            if v56 then
                u55.Button.UIStroke.UIGradient.Enabled = false;
                u55.Button.UIStroke.RarityGradient.Enabled = true;
                u55.Button.UIStroke.Color = v56.Color or Color3.new(1, 1, 1);
                u55.LayoutOrder = 1 - v54.Rarity;
            else
                u55.Button.UIStroke.UIGradient.Enabled = true;
                u55.Button.UIStroke.RarityGradient.Enabled = false;
                u55.Button.UIStroke.Color = Color3.new(1, 1, 1);
            end;

            if u51 and u51._TraitInfo then
                local _TraitInfo = u51._TraitInfo;
                local v57 = "";
                local v58 = TraitHandler.GetTraitData(_TraitInfo.Trait);

                if _TraitInfo.Hexed and v58.HexPrefix then
                    v57 = v57 .. `{v58.HexPrefix} `;
                end;

                u55.Button.Label.Text = `{v57 .. _TraitInfo.Trait} {v52}`:upper();
            end;

            if table.find(u50.Bans, u51._ItemId) then
                u55.Button.Label.TextColor3 = Color3.fromRGB(255, 0, 0);
                u55.Button.Label.Text = `{u55.Button.Label.Text} [BANNED]`;
                u55.LayoutOrder = 100000;
            end;

            local v59 = Trove.new();
            v59:AttachToInstance(u55);
            local v60;

            if u51 then
                v60 = u51._UUID;
            else
                v60 = nil;
            end;

            v59:Add(u50:ConnectDraftAbilitySelected(v52, u55.Button, v60));

            if u51 and u50.CanTooltipInventorySlot(u51) then
                local success, result = pcall(function() -- Line: 348
                    -- upvalues: u50 (copy), u55 (copy), u51 (copy), Trove (ref)
                    u50.ConstructTooltipSlot(u55, {
                        ItemId = u51._ItemId,
                        TraitInfo = u51._TraitInfo,
                        UnusualInfo = u51._UnusualInfo,
                        SerialNumber = u51._SerialNumber,
                        Purity = u51._Purity
                    }, Trove.new());
                end);

                if not success then
                    warn((`Failed to construct tooltip for {v52}: {result}`));
                end;
            end;

            return u55;
        end;
    end;

    function p1.MakeDraftAbilityButtonFromName(u61, p62, p63) -- Line: 366
        -- upvalues: u49 (copy), ItemData (copy), Parent (copy), Trove (copy)
        if table.find(u49, p62) then
            return;
        end;

        local v64 = u61:GetAbilityNameToIdCache()[p62];

        if not v64 then
            return;
        end;

        local u65 = ItemData.GetItemInfo(v64);

        if not u65 then
            return;
        end;

        local v66 = Parent.Assets.Container:Clone();
        v66.Name = u65.Name;
        local Button = v66:WaitForChild("Button", 10);
        Button.Label.Text = u65.Name:upper();
        v66.Visible = true;
        v66.Parent = Parent.Holder.AbilityArea.Items;
        local v67 = ItemData.Rarities[u65.Rarity];

        if v67 then
            Button.UIStroke.UIGradient.Enabled = false;
            Button.UIStroke.RarityGradient.Enabled = true;
            Button.UIStroke.Color = v67.Color or Color3.new(1, 1, 1);
            v66.LayoutOrder = 1 - u65.Rarity;
        else
            Button.UIStroke.UIGradient.Enabled = true;
            Button.UIStroke.RarityGradient.Enabled = false;
            Button.UIStroke.Color = Color3.new(1, 1, 1);
        end;

        if table.find(u61.Bans, v64) then
            Button.Label.TextColor3 = Color3.fromRGB(255, 0, 0);
            Button.Label.Text = `{u65.Name:upper()} [BANNED]`;
            v66.LayoutOrder = 100000;
        end;

        local v68 = Trove.new();
        v68:AttachToInstance(v66);
        local u69 = nil;

        if p63 then
            for i, v in p63 do
                if v._ItemId == v64 then
                    u69 = i;
                    break;
                end;
            end;
        end;

        local success, result = pcall(function() -- Line: 423
            -- upvalues: u61 (copy), u65 (copy), Button (copy), u69 (ref)
            return u61:ConnectDraftAbilitySelected(u65.Name, Button, u69);
        end);

        if success and result then
            v68:Add(result);
        else
            warn((`Failed to connect draft ability selected for {u65.Name}: {result}`));
        end;

        return v66;
    end;

    function p1.ConnectSelectAbilityButton(u70, p71) -- Line: 436
        -- upvalues: u5 (copy)
        return p71.MouseButton1Click:Connect(function() -- Line: 437
            -- upvalues: u70 (copy), u5 (ref)
            if u70.PromptActive() then
                return;
            end;

            u70.NewPrompt({
                Text = "Are you sure you want to select this ability?",
                Delay = 0.25,
                Title = `Select Ability: {u70._CurrentAbility}`,
                Options = { "Yes", "No" },

                Callback = function(p72) -- Line: 447, Name: Callback
                    -- upvalues: u70 (ref), u5 (ref)
                    if p72.Choice ~= 1 then
                        return;
                    end;

                    u70:PlaySound("Click");
                    warn(u70._CurrentUUID);
                    u5.Select:Fire(u70._CurrentUUID);
                end
            });
        end);
    end;

    function p1.UpdateBanStatus(p73) -- Line: 457
        -- upvalues: u5 (copy), u7 (copy), Parent (copy)
        if p73.Phase ~= "Banning" then
            return;
        end;

        local v74, v75, v76, v77 = u5:GetBanProgress():expect();
        local v78 = u7:GetActiveGameData():expect();
        Parent.Title.Text = string.gsub("<b>UG:</b>  {NAME}", "{NAME}", v78.DisplayName) .. ` <font color="{v75 <= v74 and "#00ff00" or "#ff4141"}">[YOUR BANS: {v74}/{v75}]</font>` .. ` <font color="{v77 <= v76 and "#00ff00" or "#ffaa00"}">[TOTAL: {v76}/{v77}]</font>`;
    end;

    function p1.InitializeDraftUI(u79) -- Line: 475
        -- upvalues: u5 (copy), TeleportService (copy), Players (copy), u7 (copy), Parent (copy), TimeIndicator (copy)
        print("init bt");

        if u79._DraftInited then
            return;
        end;

        if u79.PathShortcuts.LinkedPlaces[game.GameId].GameModePlace ~= game.PlaceId then
            return;
        end;

        u79._DraftInited = true;
        local u80 = u79:FetchDraftAbilities();
        print("BEFORE EVENT THING");
        pcall(function() -- Line: 491
            -- upvalues: u79 (copy)
            u79.UI.Menus.Currencies.Visible = false;
            u79.UI.Menus.ServerInfo.Visible = false;
        end);
        u5.GhostMatchPrompt:Connect(function(p81, p82) -- Line: 496
            -- upvalues: u79 (copy), TeleportService (ref), Players (ref)
            u79.NewPrompt({
                Title = "Insufficient Players",
                Text = `This match requires {p81} players but only has {p82}. Would you like to return to the matchmaking lobby?`,
                Options = { "No", "Yes" },

                Callback = function(p83) -- Line: 504, Name: Callback
                    -- upvalues: u79 (ref), TeleportService (ref), Players (ref)
                    if p83.Choice == 1 then
                        return true;
                    end;

                    local v84 = p83.Choice == 2 and u79.PathShortcuts.LinkedPlaces[game.GameId].GameModeLobby;

                    if v84 then
                        TeleportService:Teleport(v84, Players.LocalPlayer);
                    end;
                end
            });
        end);
        u5.BanUpdate:Connect(function(p85, p86, p87) -- Line: 519
            -- upvalues: u79 (copy), u80 (copy)
            if u79.Phase ~= "Banning" then
                return;
            end;

            print((`{p87} banned an ability (ItemId: {p86})`));
            local v88 = {};

            for _, v in p85 do
                if type(v) == "table" then
                    for _, v2 in v do
                        if not table.find(v88, v2) then
                            table.insert(v88, v2);
                        end;
                    end;
                end;
            end;

            u79.Bans = v88;
            u79:UpdateBanStatus();
            u79:DrawDraftAbilityButtons(u80);
        end);
        u5.Show:Connect(function(u89, u90, u91) -- Line: 541
            -- upvalues: u79 (copy), u5 (ref), u80 (copy), u7 (ref), Parent (ref), TimeIndicator (ref)
            print("GOT1");
            u79.Phase = u91;
            u79.UI:SetAttribute("DraftEnabled", u89 or nil);
            u79:SetMenu(u89 and "Draft" or nil);
            print("SETTING DRAFTENABLED", u89);
            pcall(function() -- Line: 548
                -- upvalues: u79 (ref)
                u79.UI.Menus.Currencies.Visible = false;
                u79.UI.Menus.ServerInfo.Visible = false;
            end);
            task.spawn(function() -- Line: 553
                -- upvalues: u89 (copy), u5 (ref), u79 (ref), u80 (ref), u91 (copy)
                if not u89 then
                    return;
                end;

                local v92 = u5:GetAbilityBans():expect();
                local v93 = {};

                if v92 then
                    for _, v in v92 do
                        if type(v) == "table" then
                            for _, v2 in v do
                                if not table.find(v93, v2) then
                                    table.insert(v93, v2);
                                end;
                            end;
                        elseif not table.find(v93, v) then
                            table.insert(v93, v);
                        end;
                    end;
                end;

                u79.Bans = v93;
                u79:DrawDraftAbilityButtons(u80);

                if u91 == "Banning" then
                    u79:UpdateBanStatus();
                end;
            end);

            if u91 == "Banning" then
                u79:UpdateBanStatus();
            else
                local v94 = u7:GetActiveGameData():expect();
                Parent.Title.Text = string.gsub("<b>UG:</b>  {NAME}", "{NAME}", v94.DisplayName);
            end;

            if u90 then
                if u79.TimerTask then
                    task.cancel(u79.TimerTask);
                    u79.TimerTask = nil;
                end;

                u79.TimerTask = task.defer(function() -- Line: 595
                    -- upvalues: u90 (ref), TimeIndicator (ref)
                    print("START VOTE TIMER");
                    u90 = math.round(u90);
                    TimeIndicator.Text = `{u90}s Remaining`;
                    TimeIndicator.Visible = true;
                    local v95 = 0;

                    while v95 < u90 do
                        v95 = v95 + task.wait(1);
                        local v96 = math.round(u90 - v95);
                        TimeIndicator.Text = `{math.max(0, v96)}s Remaining`;
                    end;
                end);
            end;
        end);
        u79:DrawPlayerIcons();

        local function HandlePlayer(p97) -- Line: 615
            -- upvalues: u79 (copy)
            p97:GetAttributeChangedSignal("DraftSubmitted"):Connect(function() -- Line: 616
                -- upvalues: u79 (ref)
                u79:DrawPlayerIcons();
            end);
        end;

        for _, v in Players:GetPlayers() do
            v:GetAttributeChangedSignal("DraftSubmitted"):Connect(function() -- Line: 616
                -- upvalues: u79 (copy)
                u79:DrawPlayerIcons();
            end);
        end;

        Players.PlayerAdded:Connect(function(p98) -- Line: 624
            -- upvalues: u79 (copy)
            p98:GetAttributeChangedSignal("DraftSubmitted"):Connect(function() -- Line: 616
                -- upvalues: u79 (ref)
                u79:DrawPlayerIcons();
            end);
        end);
        Parent.SeasonIndicator.Text = u79:GetSeasonText();
        task.spawn(function() -- Line: 630
            -- upvalues: u7 (ref), Parent (ref)
            local v99 = u7:GetActiveGameData():expect();
            Parent.Title.Text = string.gsub(Parent.Title.Text, "{NAME}", v99.DisplayName);
        end);
        task.spawn(function() -- Line: 635
            -- upvalues: Parent (ref)
            Parent.Holder.AbilityArea.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 636
                -- upvalues: Parent (ref)
                local Text = Parent.Holder.AbilityArea.SearchBox.Text;

                if Text:gsub("%s", "") == "" then
                    for _, child in ipairs(Parent.Holder.AbilityArea.Items:GetChildren()) do
                        if child:IsA("Frame") then
                            child.Visible = true;
                        end;
                    end;

                    return;
                end;

                for _, child in ipairs(Parent.Holder.AbilityArea.Items:GetChildren()) do
                    if child:IsA("Frame") then
                        if child.Name:lower():find(Text:lower()) then
                            child.Visible = true;
                        else
                            child.Visible = false;
                        end;
                    end;
                end;
            end);
        end);
    end;

    p1:InitializeDraftUI();
end;