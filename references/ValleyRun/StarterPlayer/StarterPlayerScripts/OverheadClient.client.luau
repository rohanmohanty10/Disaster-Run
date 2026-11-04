 

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local OverheadConfig = require(Presentation:WaitForChild("OverheadConfig"));
local OverheadUI = Presentation:WaitForChild("UITemplates"):WaitForChild("OverheadUI");
local OverheadView = require(Presentation:WaitForChild("OverheadView"));
local VerifiedName = require(Presentation:WaitForChild("VerifiedName"));
local v1 = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots == true;
local PumpkinSmoke = require(Presentation.Parent:WaitForChild("Gear"):WaitForChild("PumpkinSmoke"));
local RankedConfig = require(Presentation.Parent:WaitForChild("Game"):WaitForChild("RankedConfig"));
local u2 = {};

local function clear(p3) -- Line: 15
    if p3.characterConnections then
        for _, v in p3.characterConnections do
            v:Disconnect();
        end;

        table.clear(p3.characterConnections);
    end;

    if p3.gui then
        p3.gui:Destroy();
        p3.gui = nil;
    end;
end;

local function clean(p4) -- Line: 22
    -- upvalues: u2 (copy), clear (copy)
    local v5 = u2[p4];

    if not v5 then
        return;
    end;

    u2[p4] = nil;

    for _, v in v5.connections do
        v:Disconnect();
    end;

    for _, v in v5.statConnections do
        v:Disconnect();
    end;

    clear(v5);
end;

local function add(u6, u7, p8) -- Line: 29
    -- upvalues: clean (copy), OverheadConfig (copy), LocalPlayer (copy), u2 (copy), VerifiedName (copy), OverheadUI (copy), RankedConfig (copy), OverheadView (copy), clear (copy), PumpkinSmoke (copy)
    local u9 = p8 or u6;
    clean(u9);

    if not (OverheadConfig.Enabled and (u7 or (u6 ~= LocalPlayer or OverheadConfig.ShowOwnName))) then
        return;
    end;

    local u10 = {
        connections = {},
        statConnections = {}
    };
    u2[u9] = u10;

    local function update() -- Line: 34
        -- upvalues: u10 (copy), VerifiedName (ref), u6 (copy), OverheadUI (ref), RankedConfig (ref), OverheadView (ref)
        if not u10.gui then
            return;
        end;

        local Content = u10.gui.Content;
        Content.DisplayName.RichText = true;
        Content.DisplayName.Text = VerifiedName.player(u6);
        Content.Username.Visible = false;
        Content.AFK.Visible = u6:GetAttribute("AFK") == true;
        local Attribute = u6:GetAttribute("OverheadTitle");
        local SpecialRank = Content.SpecialRank;
        local v11;

        if type(Attribute) == "string" then
            v11 = Attribute ~= "";
        else
            v11 = false;
        end;

        SpecialRank.Visible = v11;
        Content.SpecialRank.Text = type(Attribute) == "string" and Attribute and Attribute or "";
        local Attribute2 = u6:GetAttribute("OverheadTitleColor");
        Content.SpecialRank.TextColor3 = typeof(Attribute2) == "Color3" and Attribute2 and Attribute2 or OverheadUI.Content.SpecialRank.TextColor3;
        local Attribute3 = u6:GetAttribute("JourneyTitle");
        local Attribute4 = u6:GetAttribute("JourneyTitleColor");
        local JourneyTitle = Content.JourneyTitle;
        local v12;

        if type(Attribute3) == "string" then
            v12 = Attribute3 ~= "";
        else
            v12 = false;
        end;

        JourneyTitle.Visible = v12;
        Content.JourneyTitle.Text = type(Attribute3) == "string" and Attribute3 and Attribute3 or "";
        Content.JourneyTitle.TextColor3 = typeof(Attribute4) == "Color3" and Attribute4 and Attribute4 or Color3.fromRGB(125, 205, 228);
        local leaderstats = u6:FindFirstChild("leaderstats");
        local v13;

        if leaderstats then
            v13 = leaderstats:FindFirstChild("Wins");
        else
            v13 = leaderstats;
        end;

        Content.Wins.Text = u6:GetAttribute("StatsLoaded") and (tostring(v13 and v13.Value or 0) .. " wins" or "— wins") or "— wins";

        if leaderstats then
            leaderstats = leaderstats:FindFirstChild("Level");
        end;

        local v14 = leaderstats and leaderstats.Value or u6:GetAttribute("Level");
        Content.Lvl.Text = u6:GetAttribute("StatsLoaded") and type(v14) == "number" and ("Lv. " .. tostring(v14) or "Lv. —") or "Lv. —";
        local v15 = RankedConfig.Tiers[u6:GetAttribute("RankTier") or 0];
        local RankIcon = Content:FindFirstChild("RankIcon");

        if RankIcon then
            local v16;

            if v15 == nil then
                v16 = false;
            else
                v16 = u6:GetAttribute("LookAsUserId") == nil;
            end;

            RankIcon.Visible = v16;
            RankIcon.Image = v15 and (u6:GetAttribute("RankChampion") and RankedConfig.ChampionIcon or (RankedConfig.TierIcons[v15.Name] or "")) or "";
        end;

        OverheadView.layout(u10.gui);
    end;

    u10.update = update;

    local function bindStat(p17) -- Line: 64
        -- upvalues: u10 (copy), update (copy)
        if (p17.Name == "Wins" or p17.Name == "Level") and (p17:IsA("IntValue") or p17:IsA("NumberValue")) then
            table.insert(u10.statConnections, p17.Changed:Connect(update));
            update();
        end;
    end;

    local function character(u18) -- Line: 77
        -- upvalues: clear (ref), u10 (copy), u7 (copy), u6 (copy), u2 (ref), u9 (ref), OverheadUI (ref), OverheadView (ref), LocalPlayer (ref), PumpkinSmoke (ref), update (copy)
        clear(u10);

        if (u7 or u6.Character) ~= u18 or u2[u9] ~= u10 then
            return;
        end;

        local u19 = OverheadUI:Clone();
        OverheadView.apply(u19);
        u19.Name = "PlayerOverhead_" .. (u7 and u7:GetAttribute("BotUserId") or u6.UserId);
        u19.Parent = LocalPlayer:WaitForChild("PlayerGui");
        u10.gui = u19;

        local function adorn() -- Line: 84
            -- upvalues: u10 (ref), u19 (copy), u18 (copy)
            if u10.gui ~= u19 then
                return;
            end;

            u19.Adornee = u18:FindFirstChild("Head") or u18:FindFirstChild("HumanoidRootPart");
            local v20 = u18:FindFirstChildOfClass("Humanoid");

            if v20 then
                v20.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                v20.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
            end;
        end;

        local function updateVisibility() -- Line: 93
            -- upvalues: u10 (ref), u19 (copy), u18 (copy), PumpkinSmoke (ref)
            if u10.gui == u19 then
                local v21;

                if u18:GetAttribute("Cloaked") == true or u18:GetAttribute("Ghosted") == true then
                    v21 = false;
                else
                    v21 = not PumpkinSmoke.hidden(u18);
                end;

                if u19:GetAttribute("Concealed") == not v21 and u19.Enabled == v21 then
                    return;
                end;

                u19:SetAttribute("Concealed", not v21);
                u19.Content.Visible = v21;
                u19.Enabled = v21;
            end;
        end;

        u10.characterConnections = {
            u19:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 103
                -- upvalues: u19 (copy), u18 (copy), PumpkinSmoke (ref), updateVisibility (copy)
                if u19.Enabled and (u18:GetAttribute("Cloaked") == true or (u18:GetAttribute("Ghosted") == true or PumpkinSmoke.hidden(u18))) then
                    updateVisibility();
                end;
            end),
            u18:GetAttributeChangedSignal("Cloaked"):Connect(updateVisibility),
            u18:GetAttributeChangedSignal("Smoked"):Connect(updateVisibility),
            LocalPlayer:GetAttributeChangedSignal("GameRole"):Connect(updateVisibility),
            PumpkinSmoke.Changed:Connect(updateVisibility),
            u18:GetAttributeChangedSignal("Ghosted"):Connect(updateVisibility),
            u18.ChildAdded:Connect(adorn),
            u18.ChildRemoved:Connect(adorn)
        };
        adorn();
        updateVisibility();
        update();
    end;

    local function statsAdded(p22) -- Line: 69
        -- upvalues: u10 (copy), bindStat (copy), update (copy)
        if p22.Name ~= "leaderstats" then
            return;
        end;

        for _, v in u10.statConnections do
            v:Disconnect();
        end;

        table.clear(u10.statConnections);

        for _, child in p22:GetChildren() do
            bindStat(child);
        end;

        table.insert(u10.statConnections, p22.ChildAdded:Connect(bindStat));
        table.insert(u10.statConnections, p22.ChildRemoved:Connect(update));
        update();
    end;

    for _, v in { "StatsLoaded", "Level", "OverheadTitle", "OverheadTitleColor", "JourneyTitle", "JourneyTitleColor", "AFK", "LookDisplayName", "LookVerified", "OutbreakInfected", "RankTier", "RankChampion" } do
        local connections = u10.connections;
        local AttributeChangedSignal = u6:GetAttributeChangedSignal(v);
        table.insert(connections, AttributeChangedSignal:Connect(update));
    end;

    local connections = u10.connections;
    local PropertyChangedSignal = u6:GetPropertyChangedSignal("DisplayName");
    table.insert(connections, PropertyChangedSignal:Connect(update));

    if typeof(u6) == "Instance" and u6:IsA("Player") then
        local connections2 = u10.connections;
        local PropertyChangedSignal2 = u6:GetPropertyChangedSignal("HasVerifiedBadge");
        table.insert(connections2, PropertyChangedSignal2:Connect(update));
    end;

    table.insert(u10.connections, u6.ChildAdded:Connect(statsAdded));

    if not u7 then
        table.insert(u10.connections, u6.CharacterAdded:Connect(character));
        table.insert(u10.connections, u6.CharacterRemoving:Connect(function() -- Line: 127
            -- upvalues: clear (ref), u10 (copy)
            clear(u10);
        end));
    end;

    local leaderstats = u6:FindFirstChild("leaderstats");

    if leaderstats then
        statsAdded(leaderstats);
    end;

    if u7 or u6.Character then
        task.spawn(character, u7 or u6.Character);
    end;
end;

local Actors = Presentation.Parent:WaitForChild("Bots"):WaitForChild("Actors");
local u23 = nil;
local u24 = {};
local u25 = {};

local function dropBotTag(p26) -- Line: 135
    -- upvalues: u25 (copy)
    local v27 = u25[p26];

    if not v27 then
        return;
    end;

    u25[p26] = nil;

    for _, v in v27.connections do
        v:Disconnect();
    end;

    v27.gui:Destroy();
end;

if v1 then
    local BotDirectory = require(Presentation.Parent.Bots:WaitForChild("BotDirectory"));

    local function botTag(u28, u29) -- Line: 145
        -- upvalues: u25 (copy), OverheadConfig (copy), OverheadUI (copy), OverheadView (copy), VerifiedName (copy), PumpkinSmoke (copy), LocalPlayer (copy)
        local v30 = u25[u28];

        if v30 and v30.character == u29 then
            return;
        end;

        local v31 = u25[u28];

        if v31 then
            u25[u28] = nil;

            for _, v in v31.connections do
                v:Disconnect();
            end;

            v31.gui:Destroy();
        end;

        local v32;

        if u29 then
            v32 = u29:FindFirstChild("Head") or u29:FindFirstChild("HumanoidRootPart");
        else
            v32 = u29;
        end;

        if not (v32 and OverheadConfig.Enabled) then
            return;
        end;

        local u33 = OverheadUI:Clone();
        OverheadView.apply(u33);
        u33.Name = "PlayerOverhead_" .. tostring(u28.UserId);
        u33.Adornee = v32;
        local u34 = {
            character = u29,
            gui = u33,
            connections = {}
        };
        u25[u28] = u34;
        local Content = u33.Content;

        local function v35() -- Line: 154
            -- upvalues: u25 (ref), u28 (copy), u34 (ref), Content (copy), VerifiedName (ref), OverheadView (ref), u33 (copy)
            if u25[u28] ~= u34 then
                return;
            end;

            local Attribute = u28:GetAttribute("DisplayName");
            Content.DisplayName.RichText = true;
            Content.DisplayName.Text = VerifiedName.format(type(Attribute) == "string" and Attribute and Attribute or u28.DisplayName, false, u28);
            Content.DisplayName.Visible = true;
            local Attribute2 = u28:GetAttribute("Level");
            local Attribute3 = u28:GetAttribute("Wins");
            Content.Lvl.Text = "Lv. " .. tostring(Attribute2 or "—");
            Content.Lvl.Visible = Attribute2 ~= nil;
            Content.Wins.Text = tostring(Attribute3 or 0) .. " wins";
            Content.Wins.Visible = Attribute3 ~= nil;
            Content.Username.Visible = false;
            Content.SpecialRank.Visible = false;
            Content.JourneyTitle.Visible = false;
            Content.AFK.Visible = false;
            OverheadView.layout(u33);
        end;

        local function visibility() -- Line: 167
            -- upvalues: u25 (ref), u28 (copy), u34 (ref), u29 (copy), PumpkinSmoke (ref), u33 (copy), Content (copy)
            if u25[u28] ~= u34 then
                return;
            end;

            local v36;

            if u29:GetAttribute("Cloaked") == true or u29:GetAttribute("Ghosted") == true then
                v36 = false;
            else
                v36 = not PumpkinSmoke.hidden(u29, u28:GetAttribute("GameRole"));
            end;

            if u33:GetAttribute("Concealed") == not v36 and u33.Enabled == v36 then
                return;
            end;

            u33:SetAttribute("Concealed", not v36);
            Content.Visible = v36;
            u33.Enabled = v36;
        end;

        u34.update = v35;

        for _, v in { "DisplayName", "Level", "Wins", "EquippedKnife" } do
            local connections = u34.connections;
            local AttributeChangedSignal = u28:GetAttributeChangedSignal(v);
            table.insert(connections, AttributeChangedSignal:Connect(v35));
        end;

        local connections = u34.connections;
        local AttributeChangedSignal = u29:GetAttributeChangedSignal("Cloaked");
        table.insert(connections, AttributeChangedSignal:Connect(visibility));
        local connections2 = u34.connections;
        local AttributeChangedSignal2 = u29:GetAttributeChangedSignal("Ghosted");
        table.insert(connections2, AttributeChangedSignal2:Connect(visibility));
        local connections3 = u34.connections;
        local AttributeChangedSignal3 = u29:GetAttributeChangedSignal("Smoked");
        table.insert(connections3, AttributeChangedSignal3:Connect(visibility));
        local connections4 = u34.connections;
        local AttributeChangedSignal4 = LocalPlayer:GetAttributeChangedSignal("GameRole");
        table.insert(connections4, AttributeChangedSignal4:Connect(visibility));
        table.insert(u34.connections, PumpkinSmoke.Changed:Connect(visibility));
        v35();
        visibility();
        u33.Parent = LocalPlayer:WaitForChild("PlayerGui");
    end;

    local function sync(p37) -- Line: 186
        -- upvalues: BotDirectory (copy), Players (copy), u2 (copy), add (copy), clean (copy), botTag (copy)
        local Character = p37.Character;

        if BotDirectory.get(p37.UserId) ~= p37 then
            Character = nil;
        end;

        if p37.OwnerUserId then
            local PlayerByUserId = Players:GetPlayerByUserId(p37.OwnerUserId);
            local v38 = u2[p37.record];

            if Character and PlayerByUserId then
                if not v38 or v38.character ~= Character then
                    add(PlayerByUserId, Character, p37.record);

                    if u2[p37.record] then
                        u2[p37.record].character = Character;
                    end;
                end;
            elseif v38 then
                clean(p37.record);
            end;
        else
            botTag(p37, Character);
        end;
    end;

    table.insert(u24, BotDirectory.Added:Connect(sync));
    table.insert(u24, BotDirectory.CharacterChanged:Connect(sync));
    table.insert(u24, BotDirectory.Removed:Connect(function(p39) -- Line: 204
        -- upvalues: clean (copy), u25 (copy)
        clean(p39.record);
        local v40 = u25[p39];

        if not v40 then
            return;
        end;

        u25[p39] = nil;

        for _, v in v40.connections do
            v:Disconnect();
        end;

        v40.gui:Destroy();
    end));

    for _, v in BotDirectory.list() do
        task.spawn(sync, v);
    end;
else
    u23 = Actors.ChildAdded:Connect(function(u41) -- Line: 207, Name: cloneAdded
        -- upvalues: Players (copy), Actors (copy), add (copy)
        local Attribute = u41:GetAttribute("CloneOwnerUserId");

        if not Attribute then
            return;
        end;

        task.spawn(function() -- Line: 210
            -- upvalues: u41 (copy), Players (ref), Attribute (copy), Actors (ref), add (ref)
            local Character = u41:WaitForChild("Character", 5);
            local PlayerByUserId = Players:GetPlayerByUserId(Attribute);

            if Character and (Character.Value and (u41.Parent == Actors and PlayerByUserId)) then
                add(PlayerByUserId, Character.Value, u41);
            end;
        end);
    end);

    for _, child in Actors:GetChildren() do
        local Attribute = child:GetAttribute("CloneOwnerUserId");

        if Attribute then
            task.spawn(function() -- Line: 210
                -- upvalues: child (copy), Players (copy), Attribute (copy), Actors (copy), add (copy)
                local Character = child:WaitForChild("Character", 5);
                local PlayerByUserId = Players:GetPlayerByUserId(Attribute);

                if Character and (Character.Value and (child.Parent == Actors and PlayerByUserId)) then
                    add(PlayerByUserId, Character.Value, child);
                end;
            end);
        end;
    end;
end;

local u42 = Actors.ChildRemoved:Connect(clean);
local OutbreakConfig = require(Presentation.Parent:WaitForChild("Game"):WaitForChild("OutbreakConfig"));

for _, v in { OutbreakConfig.startsAt(), OutbreakConfig.endsAt() } do
    local v43 = v - workspace:GetServerTimeNow();

    if v43 > 0 then
        task.delay(v43 + 0.5, function() -- Line: 224
            -- upvalues: u2 (copy), u25 (copy)
            for _, v2 in u2 do
                if v2.update then
                    v2.update();
                end;
            end;

            for _, v2 in u25 do
                if v2.update then
                    v2.update();
                end;
            end;
        end);
    end;
end;

local u44 = Players.PlayerAdded:Connect(add);
local u45 = Players.PlayerRemoving:Connect(clean);

for _, v in Players:GetPlayers() do
    add(v);
end;

script.Destroying:Connect(function() -- Line: 233
    -- upvalues: u44 (copy), u45 (copy), u42 (copy), u23 (ref), u24 (copy), u25 (copy), u2 (copy), clean (copy)
    u44:Disconnect();
    u45:Disconnect();
    u42:Disconnect();

    if u23 then
        u23:Disconnect();
    end;

    for _, v in u24 do
        v:Disconnect();
    end;

    for i in u25 do
        local v46 = u25[i];

        if v46 then
            u25[i] = nil;

            for _, v in v46.connections do
                v:Disconnect();
            end;

            v46.gui:Destroy();
        end;
    end;

    for i in u2 do
        clean(i);
    end;
end);