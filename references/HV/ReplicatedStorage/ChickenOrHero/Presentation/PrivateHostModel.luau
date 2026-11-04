 

 

local Players = game:GetService("Players");
local script_Parent = script.Parent;
local PrivateHostCatalog = require(script_Parent.Parent:WaitForChild("Game"):WaitForChild("PrivateHostCatalog"));
local HudNavigation = require(script_Parent:WaitForChild("HudNavigation"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function nameOf(p2) -- Line: 17
    -- upvalues: Players (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p2);

    return PlayerByUserId and PlayerByUserId.DisplayName or "Someone who left";
end;

local function cycle(p3, p4) -- Line: 23
    return p3[(table.find(p3, p4) or 0) % #p3 + 1];
end;

local function sorted(p5) -- Line: 28
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v6 = {};

    for _, v in Players:GetPlayers() do
        if p5 or v ~= LocalPlayer then
            table.insert(v6, v);
        end;
    end;

    table.sort(v6, function(p7, p8) -- Line: 35
        return p7.DisplayName:lower() < p8.DisplayName:lower();
    end);

    return v6;
end;

local function ids(p9, p10) -- Line: 41
    local v11 = { p10 };

    for _, v in p9 do
        table.insert(v11, v.UserId);
    end;

    return v11;
end;

function u1.host(u12) -- Line: 49
    -- upvalues: script_Parent (copy), HudNavigation (copy), PrivateHostCatalog (copy), sorted (copy), LocalPlayer (copy), Players (copy)
    local PrivateHostEvent = script_Parent:WaitForChild("PrivateHostEvent", 60);

    if not PrivateHostEvent then
        return;
    end;

    local u13 = nil;

    local function send(p14, p15, p16) -- Line: 59
        -- upvalues: PrivateHostEvent (copy)
        PrivateHostEvent:FireServer(p14, p15, p16);
    end;

    u12.buildHost(function() -- Line: 62
        -- upvalues: HudNavigation (ref)
        HudNavigation.activate("HostPanel");
    end);
    u12.section("Next matches");
    local u17 = u12.picker("Mode", function() -- Line: 67
        -- upvalues: u13 (ref), PrivateHostCatalog (ref), PrivateHostEvent (copy)
        if u13 then
            local Modes = PrivateHostCatalog.Modes;
            PrivateHostEvent:FireServer("SetMode", Modes[(table.find(Modes, u13.mode) or 0) % #Modes + 1], nil);
        end;
    end);
    local u19 = u12.picker("Map", function() -- Line: 72
        -- upvalues: u13 (ref), PrivateHostEvent (copy)
        if not (u13 and (u13.mode == "Normal" or u13.tournament and u13.tournament.running)) then
            return;
        end;

        local v18 = { false };

        for _, v in u13.maps do
            table.insert(v18, v.id);
        end;

        PrivateHostEvent:FireServer("SetMap", v18[(table.find(v18, u13.map) or 0) % #v18 + 1], nil);
    end);
    local u21 = u12.picker("Lead Chaser", function() -- Line: 83
        -- upvalues: u13 (ref), sorted (ref), PrivateHostEvent (copy)
        if u13 then
            local v20 = { 0 };

            for _, v in sorted(true) do
                table.insert(v20, v.UserId);
            end;

            PrivateHostEvent:FireServer("SetLead", v20[(table.find(v20, u13.lead) or 0) % #v20 + 1], nil);
        end;
    end);
    local u23 = u12.picker("Hero Pick", function() -- Line: 88
        -- upvalues: u13 (ref), sorted (ref), PrivateHostEvent (copy)
        if u13 then
            local v22 = { 0 };

            for _, v in sorted(true) do
                table.insert(v22, v.UserId);
            end;

            PrivateHostEvent:FireServer("SetStarter", v22[(table.find(v22, u13.starter) or 0) % #v22 + 1], nil);
        end;
    end);
    local Tournament = PrivateHostCatalog.Tournament;
    u12.section("Tournament");
    local u24 = u12.note("");

    local function tour() -- Line: 99
        -- upvalues: u13 (ref)
        return u13 and u13.tournament;
    end;

    local function stepper(p25, u26, u27, u28, u29) -- Line: 102
        -- upvalues: u12 (copy), u13 (ref), PrivateHostEvent (copy)
        return u12.stepper(p25, function(p30) -- Line: 103
            -- upvalues: u13 (ref), u26 (copy), u29 (copy), u27 (copy), u28 (copy), PrivateHostEvent (ref)
            local v31 = u13 and u13.tournament;

            if v31 and not v31.running then
                local v32 = u29(v31) + p30;
                PrivateHostEvent:FireServer("TourSet", u26, (math.clamp(v32, u27, u28)));
            end;
        end);
    end;

    local MaxMatches = Tournament.MaxMatches;

    local function u34(p33) -- Line: 110
        return p33.matches;
    end;

    local u35 = "matches";
    local u36 = 1;
    local u40 = u12.stepper("Matches", function(p37) -- Line: 103
        -- upvalues: u13 (ref), u35 (copy), u34 (copy), u36 (copy), MaxMatches (copy), PrivateHostEvent (copy)
        local v38 = u13 and u13.tournament;

        if v38 and not v38.running then
            local v39 = u34(v38) + p37;
            PrivateHostEvent:FireServer("TourSet", u35, (math.clamp(v39, u36, MaxMatches)));
        end;
    end);
    local MaxBasePoints = Tournament.MaxBasePoints;

    local function u42(p41) -- Line: 114
        return p41.basePoints;
    end;

    local u43 = "basePoints";
    local u44 = 0;
    local u48 = u12.stepper("Tier 0 · every runner", function(p45) -- Line: 103
        -- upvalues: u13 (ref), u43 (copy), u42 (copy), u44 (copy), MaxBasePoints (copy), PrivateHostEvent (copy)
        local v46 = u13 and u13.tournament;

        if v46 and not v46.running then
            local v47 = u42(v46) + p45;
            PrivateHostEvent:FireServer("TourSet", u43, (math.clamp(v47, u44, MaxBasePoints)));
        end;
    end);
    local u49 = {};
    local u50 = {};
    local u51 = nil;
    local u52 = false;
    local u53 = 0;

    for i = 1, Tournament.Tiers do
        local v54 = {};
        local v55 = ("Tier %d · runners"):format(i);
        local u56 = "top" .. i;
        local MaxTop = Tournament.MaxTop;

        local function u58(p57) -- Line: 120
            -- upvalues: i (copy)
            return p57.top[i];
        end;

        local u59 = 0;
        v54.top = u12.stepper(v55, function(p60) -- Line: 103
            -- upvalues: u13 (ref), u56 (copy), u58 (copy), u59 (copy), MaxTop (copy), PrivateHostEvent (copy)
            local v61 = u13 and u13.tournament;

            if v61 and not v61.running then
                local v62 = u58(v61) + p60;
                PrivateHostEvent:FireServer("TourSet", u56, (math.clamp(v62, u59, MaxTop)));
            end;
        end);
        local v63 = ("Tier %d · points"):format(i);
        local u64 = "points" .. i;
        local MaxPoints = Tournament.MaxPoints;

        local function u66(p65) -- Line: 123
            -- upvalues: i (copy)
            return p65.points[i];
        end;

        local u67 = 0;
        v54.points = u12.stepper(v63, function(p68) -- Line: 103
            -- upvalues: u13 (ref), u64 (copy), u66 (copy), u67 (copy), MaxPoints (copy), PrivateHostEvent (copy)
            local v69 = u13 and u13.tournament;

            if v69 and not v69.running then
                local v70 = u66(v69) + p68;
                PrivateHostEvent:FireServer("TourSet", u64, (math.clamp(v70, u67, MaxPoints)));
            end;
        end);
        u49[i] = v54;
        local _ = i;
    end;

    local MaxLmsPoints = Tournament.MaxLmsPoints;

    local function u72(p71) -- Line: 128
        return p71.lmsPoints;
    end;

    local u73 = "lmsPoints";
    local u74 = 0;
    local u78 = u12.stepper("LMS win points", function(p75) -- Line: 103
        -- upvalues: u13 (ref), u73 (copy), u72 (copy), u74 (copy), MaxLmsPoints (copy), PrivateHostEvent (copy)
        local v76 = u13 and u13.tournament;

        if v76 and not v76.running then
            local v77 = u72(v76) + p75;
            PrivateHostEvent:FireServer("TourSet", u73, (math.clamp(v77, u74, MaxLmsPoints)));
        end;
    end);
    local MaxCatchPoints = Tournament.MaxCatchPoints;

    local function u80(p79) -- Line: 131
        return p79.catchPoints;
    end;

    local u81 = "catchPoints";
    local u82 = 0;
    local u86 = u12.stepper("Points per catch", function(p83) -- Line: 103
        -- upvalues: u13 (ref), u81 (copy), u80 (copy), u82 (copy), MaxCatchPoints (copy), PrivateHostEvent (copy)
        local v84 = u13 and u13.tournament;

        if v84 and not v84.running then
            local v85 = u80(v84) + p83;
            PrivateHostEvent:FireServer("TourSet", u81, (math.clamp(v85, u82, MaxCatchPoints)));
        end;
    end);
    local MaxRevivePoints = Tournament.MaxRevivePoints;

    local function u88(p87) -- Line: 134
        return p87.revivePoints;
    end;

    local u89 = "revivePoints";
    local u90 = 0;
    local u94 = u12.stepper("Points per revive", function(p91) -- Line: 103
        -- upvalues: u13 (ref), u89 (copy), u88 (copy), u90 (copy), MaxRevivePoints (copy), PrivateHostEvent (copy)
        local v92 = u13 and u13.tournament;

        if v92 and not v92.running then
            local v93 = u88(v92) + p91;
            PrivateHostEvent:FireServer("TourSet", u89, (math.clamp(v93, u90, MaxRevivePoints)));
        end;
    end);
    local u96 = u12.picker("Abilities", function() -- Line: 137
        -- upvalues: u13 (ref), Tournament (copy), PrivateHostEvent (copy)
        local v95 = u13 and u13.tournament;

        if v95 and not v95.running then
            local Abilities = Tournament.Abilities;
            PrivateHostEvent:FireServer("TourSet", "abilities", Abilities[(table.find(Abilities, v95.abilities) or 0) % #Abilities + 1]);
        end;
    end);
    local u97 = u12.note("");
    local u99 = u12.action("Tournament", "START", function() -- Line: 145
        -- upvalues: u13 (ref), PrivateHostEvent (copy), u50 (copy), u51 (ref)
        local v98 = u13 and u13.tournament;

        if not v98 then
            return;
        end;

        if not v98.running then
            PrivateHostEvent:FireServer("TourStart", nil, nil);

            return;
        end;

        if u50.TourEnd and os.clock() < u50.TourEnd then
            u50.TourEnd = nil;
            PrivateHostEvent:FireServer("TourEnd", nil, nil);
        else
            u50.TourEnd = os.clock() + 3;
            task.delay(3, function() -- Line: 159
                -- upvalues: u51 (ref)
                u51();
            end);
        end;

        u51();
    end);
    local u100 = {};

    for i = 1, 5 do
        u100[i] = u12.note("");
        local _ = i;
    end;

    u12.section("Game");
    local u101 = u12.toggle("Freeze Game", function() -- Line: 171
        -- upvalues: u13 (ref), PrivateHostEvent (copy)
        if u13 then
            PrivateHostEvent:FireServer("Freeze", not u13.frozen, nil);
        end;
    end);
    local u102 = u12.action("End Match", "END", function() -- Line: 177
        -- upvalues: u50 (copy), PrivateHostEvent (copy), u51 (ref)
        if u50.EndMatch and os.clock() < u50.EndMatch then
            u50.EndMatch = nil;
            PrivateHostEvent:FireServer("EndMatch", nil, nil);
        else
            u50.EndMatch = os.clock() + 3;
            task.delay(3, function() -- Line: 183
                -- upvalues: u51 (ref)
                u51();
            end);
        end;

        u51();
    end, true);
    local u103 = u12.toggle("Fly + No Clip", function() -- Line: 190
        -- upvalues: u13 (ref), PrivateHostEvent (copy)
        if u13 then
            PrivateHostEvent:FireServer("Fly", not u13.flying, nil);
        end;
    end);
    local u104 = u12.action("Free Camera", "GO", function() -- Line: 196
        -- upvalues: u12 (copy), HudNavigation (ref)
        u12.close();
        HudNavigation.activate("CreatorCamera");
    end);

    local function renderCamera() -- Line: 200
        -- upvalues: u104 (copy), LocalPlayer (ref)
        u104.set(LocalPlayer:GetAttribute("CreatorCameraActive") == true and "STOP" or "GO", true);
    end;

    LocalPlayer:GetAttributeChangedSignal("CreatorCameraActive"):Connect(renderCamera);
    u104.set(LocalPlayer:GetAttribute("CreatorCameraActive") == true and "STOP" or "GO", true);
    u12.section("Players");
    local u106 = u12.picker("Player", function() -- Line: 207
        -- upvalues: sorted (ref), u53 (ref), u50 (copy), u51 (ref)
        local v105 = {};

        for _, v in sorted(false) do
            table.insert(v105, v.UserId);
        end;

        if #v105 > 0 then
            u53 = v105[(table.find(v105, u53) or 0) % #v105 + 1];
            table.clear(u50);
            u51();
        end;
    end);

    local function held(p107) -- Line: 218
        -- upvalues: u13 (ref)
        local v108;

        if u13 == nil then
            v108 = false;
        else
            v108 = table.find(u13.held, p107) ~= nil;
        end;

        return v108;
    end;

    local u111 = u12.toggle("Freeze Player", function() -- Line: 221
        -- upvalues: u53 (ref), u13 (ref), PrivateHostEvent (copy)
        if u53 ~= 0 then
            local v109 = u53;
            local v110;

            if u13 == nil then
                v110 = false;
            else
                v110 = table.find(u13.held, v109) ~= nil;
            end;

            PrivateHostEvent:FireServer("Hold", u53, not v110);
        end;
    end);

    local function confirmThen(p112) -- Line: 227
        -- upvalues: u53 (ref), u12 (copy), u50 (copy), PrivateHostEvent (copy), u51 (ref)
        if u53 == 0 then
            u12.status("Choose a player first.");

            return;
        end;

        if u50[p112] and os.clock() < u50[p112] then
            u50[p112] = nil;
            PrivateHostEvent:FireServer(p112, u53, nil);
        else
            u50[p112] = os.clock() + 3;
            task.delay(3, function() -- Line: 237
                -- upvalues: u51 (ref)
                u51();
            end);
        end;

        u51();
    end;

    local u113 = u12.action("Kick", "KICK", function() -- Line: 243
        -- upvalues: confirmThen (copy)
        confirmThen("Kick");
    end, true);
    local u114 = u12.action("Ban", "BAN", function() -- Line: 246
        -- upvalues: confirmThen (copy)
        confirmThen("Ban");
    end, true);
    u12.section("Banned players");
    local u115 = 0;

    local function banIds() -- Line: 253
        -- upvalues: u13 (ref)
        local v116 = {};

        for _, v in u13 and u13.bans or {} do
            table.insert(v116, v.userId);
        end;

        return v116;
    end;

    local u118 = u12.picker("Banned", function() -- Line: 260
        -- upvalues: banIds (copy), u115 (ref), u50 (copy), u51 (ref)
        local v117 = banIds();

        if #v117 > 0 then
            u115 = v117[(table.find(v117, u115) or 0) % #v117 + 1];
            u50.Unban = nil;
            u51();
        end;
    end);
    local u119 = u12.action("Unban", "UNBAN", function() -- Line: 268
        -- upvalues: u115 (ref), u12 (copy), u50 (copy), PrivateHostEvent (copy), u51 (ref)
        if u115 == 0 then
            u12.status("Nobody is banned.");

            return;
        end;

        if u50.Unban and os.clock() < u50.Unban then
            u50.Unban = nil;
            PrivateHostEvent:FireServer("Unban", u115, nil);
        else
            u50.Unban = os.clock() + 3;
            task.delay(3, function() -- Line: 278
                -- upvalues: u51 (ref)
                u51();
            end);
        end;

        u51();
    end);
    local u120 = u12.note("");
    u12.section("Invite");
    local u122 = u12.input("Roblox username", "SEND", function(p121) -- Line: 287
        -- upvalues: u52 (ref), PrivateHostEvent (copy)
        if type(p121) == "string" and p121:match("%S") then
            u52 = true;
            PrivateHostEvent:FireServer("Invite", p121, nil);
        end;
    end);
    u12.section("Host button");
    u12.action("Hide Host Button", "HIDE", function() -- Line: 295
        -- upvalues: LocalPlayer (ref), u12 (copy), HudNavigation (ref)
        LocalPlayer:SetAttribute("HostButtonHidden", true);
        u12.close();
        HudNavigation.Notice:Fire("Host button hidden. You can turn it back on in Settings.");
    end);
    u12.note("You can turn it back on in the settings menu.");
    local u123 = u12.note("");

    local function confirmText(p124, p125) -- Line: 303
        -- upvalues: u50 (copy)
        return u50[p124] and os.clock() < u50[p124] and "SURE?" or p125;
    end;

    u51 = function() -- Line: 306, Name: render
        -- upvalues: u13 (ref), u17 (copy), PrivateHostCatalog (ref), u19 (copy), u21 (copy), Players (ref), u23 (copy), u101 (copy), u102 (copy), u50 (copy), u103 (copy), u53 (ref), LocalPlayer (ref), sorted (ref), u106 (copy), u111 (copy), u113 (copy), u114 (copy), u115 (ref), u118 (copy), u119 (copy), u120 (copy), u123 (copy), u24 (copy), u40 (copy), u48 (copy), u49 (copy), u78 (copy), u86 (copy), u94 (copy), u96 (copy), Tournament (copy), u97 (copy), u99 (copy), u100 (copy)
        if not u13 then
            return;
        end;

        local tournament = u13.tournament;
        local v126;

        if tournament == nil then
            v126 = false;
        else
            v126 = tournament.running == true;
        end;

        u17.set(v126 and "Normal (tournament)" or (PrivateHostCatalog.ModeNames[u13.mode] or u13.mode), not v126);
        local v127;

        if u13.mode == "Normal" then
            v127 = false;
        else
            v127 = not v126;
        end;

        local v128 = "Players vote";

        for _, v in u13.maps do
            if v.id == u13.map then
                v128 = v.name;
            end;
        end;

        u19.set(v127 and "Map1 (event mode)" or v128, not v127);
        local set = u21.set;
        local v129;

        if u13.lead == 0 then
            v129 = "Random";
        else
            local PlayerByUserId = Players:GetPlayerByUserId(u13.lead);
            v129 = PlayerByUserId and PlayerByUserId.DisplayName or "Someone who left";
        end;

        set(v129);
        local set2 = u23.set;
        local v130;

        if u13.starter == 0 then
            v130 = "Lead chaser picks";
        else
            local PlayerByUserId = Players:GetPlayerByUserId(u13.starter);
            v130 = PlayerByUserId and PlayerByUserId.DisplayName or "Someone who left";
        end;

        set2(v130);
        u101.set(u13.frozen);
        u102.set(u50.EndMatch and os.clock() < u50.EndMatch and "SURE?" or "END", true);
        u103.set(u13.flying == true);

        if u53 ~= 0 and (u53 == LocalPlayer.UserId or not Players:GetPlayerByUserId(u53)) then
            u53 = 0;
        end;

        if u53 == 0 then
            local v131 = sorted(false)[1];
            u53 = v131 and v131.UserId or 0;
        end;

        local v132 = u53 ~= 0;
        local set3 = u106.set;
        local v133;

        if v132 then
            local PlayerByUserId = Players:GetPlayerByUserId(u53);
            v133 = PlayerByUserId and PlayerByUserId.DisplayName or "Someone who left" or "No other players";
        else
            v133 = "No other players";
        end;

        set3(v133, v132);
        local set4 = u111.set;
        local v134 = u53;
        local v135;

        if u13 == nil then
            v135 = false;
        else
            v135 = table.find(u13.held, v134) ~= nil;
        end;

        set4(v135, v132);
        u113.set(u50.Kick and os.clock() < u50.Kick and "SURE?" or "KICK", v132);
        u114.set(u50.Ban and os.clock() < u50.Ban and "SURE?" or "BAN", v132);
        local v136 = u13.bans or {};
        local v137 = nil;

        for _, v in v136 do
            if v.userId == u115 then
                v137 = v.name;
            end;
        end;

        if not v137 then
            u115 = v136[1] and (v136[1].userId or 0) or 0;
            v137 = v136[1] and v136[1].name;
        end;

        u118.set(v137 or "Nobody", #v136 > 1);
        u119.set(u50.Unban and os.clock() < u50.Unban and "SURE?" or "UNBAN", u115 ~= 0);
        u120.set(("%d of %d ban slots used. Bans cover all your private servers."):format(#v136, u13.banLimit or 0));
        u123.set(u13.rewardsOff and "Coins, gems and quests don\'t count in private servers." or "");

        if tournament then
            local v138 = not v126;
            local set5 = u24.set;
            local v139;

            if v126 then
                v139 = ("Running · match %d of %d. Settings are locked."):format(math.min(tournament.played + 1, tournament.matches), tournament.matches);
            else
                v139 = tournament.finalTop and "Finished! Top 5 below. Set up the next one, then START." or "Set it up, then START. No event modes, and 8 s max in the start safe zone.";
            end;

            set5(v139);
            u40.set(tostring(tournament.matches), v138);
            u48.set(("%d pts"):format(tournament.basePoints or 0), v138);

            for i, v in u49 do
                v.top.set(tournament.top[i] <= 0 and "Off" or ("Top %d"):format(tournament.top[i]), v138);
                v.points.set(("+%d pts"):format(tournament.points[i]), v138);
            end;

            u78.set(("+%d pts"):format(tournament.lmsPoints or 0), v138);
            u86.set(tostring(tournament.catchPoints), v138);
            u94.set(tostring(tournament.revivePoints or 0), v138);
            u96.set(Tournament.AbilityNames[tournament.abilities] or tournament.abilities, v138);
            u97.set((tournament.rules or "") .. " (tiers stack)");
            u99.set(v126 and (u50.TourEnd and os.clock() < u50.TourEnd and "SURE?" or "END") or "START", true);
            local v140;

            if v126 then
                v140 = tournament.standings;
            else
                v140 = tournament.finalTop or {};
            end;

            for i, v in u100 do
                local v141 = v140[i];
                v.set(v141 and (("%d. %s  ·  %d pts%s"):format(v141.rank, v141.name, v141.total, (not v126 or (v141.gained or 0) <= 0) and "" or ("  (+%d last match)"):format(v141.gained)) or "") or "");
            end;
        end;
    end;

    PrivateHostEvent.OnClientEvent:Connect(function(p142, p143) -- Line: 389
        -- upvalues: u13 (ref), u51 (ref), u12 (copy), u52 (ref), u122 (copy), HudNavigation (ref)
        if type(p143) ~= "table" then
            return;
        end;

        if p142 ~= "State" then
            if p142 == "Reply" and type(p143.message) == "string" then
                u12.status(p143.message);

                if u52 then
                    u52 = false;

                    if p143.ok then
                        u122.clear();
                    end;
                end;

                if not u12.isOpen() then
                    HudNavigation.Notice:Fire(p143.message);
                end;
            end;

            return;
        end;

        u13 = p143;
        u51();
    end);
    Players.PlayerAdded:Connect(function() -- Line: 409
        -- upvalues: u51 (ref)
        task.defer(u51);
    end);
    Players.PlayerRemoving:Connect(function() -- Line: 412
        -- upvalues: u51 (ref)
        task.defer(u51);
    end);

    local function launcher() -- Line: 415
        -- upvalues: LocalPlayer (ref), u12 (copy)
        local v144 = LocalPlayer:GetAttribute("HostButtonHidden") ~= true;
        u12.setLauncherVisible(v144);
    end;

    LocalPlayer:GetAttributeChangedSignal("HostButtonHidden"):Connect(launcher);
    local v145 = LocalPlayer:GetAttribute("HostButtonHidden") ~= true;
    u12.setLauncherVisible(v145);
    PrivateHostEvent:FireServer("Sync", nil, nil);
end;

function u1.invites(u146) -- Line: 424
    -- upvalues: script_Parent (copy), LocalPlayer (copy), HudNavigation (copy)
    local PrivateInviteEvent = script_Parent:WaitForChild("PrivateInviteEvent", 60);

    if not PrivateInviteEvent then
        return;
    end;

    local u147 = nil;
    PrivateInviteEvent.OnClientEvent:Connect(function(p148, u149) -- Line: 430
        -- upvalues: LocalPlayer (ref), u147 (ref), u146 (copy), PrivateInviteEvent (copy), HudNavigation (ref)
        if type(u149) ~= "table" then
            return;
        end;

        if p148 ~= "Invite" or (type(u149.id) ~= "string" or type(u149.fromName) ~= "string") then
            if p148 == "Result" and type(u149.message) == "string" then
                HudNavigation.Notice:Fire(u149.message);
            end;

            return;
        end;

        if LocalPlayer:GetAttribute("PrivateInvitesOff") == true then
            return;
        end;

        u147 = u149.id;
        u146.invite(u149, function() -- Line: 440
            -- upvalues: u147 (ref), PrivateInviteEvent (ref), u149 (copy)
            u147 = nil;
            PrivateInviteEvent:FireServer("Accept", u149.id);
        end, function() -- Line: 443
            -- upvalues: u147 (ref), PrivateInviteEvent (ref), u149 (copy)
            u147 = nil;
            PrivateInviteEvent:FireServer("Decline", u149.id);
        end);
        local v150 = type(u149.expiresAt) == "number" and (u149.expiresAt - workspace:GetServerTimeNow() or 30) or 30;
        task.delay(math.max(1, v150), function() -- Line: 448
            -- upvalues: u147 (ref), u149 (copy), u146 (ref)
            if u147 == u149.id then
                u147 = nil;
                u146.closeInvite();
            end;
        end);
    end);
end;

function u1.rewardsNotice() -- Line: 461
    -- upvalues: LocalPlayer (copy), HudNavigation (copy)
    while LocalPlayer:GetAttribute("ClientReady") ~= true do
        LocalPlayer:GetAttributeChangedSignal("ClientReady"):Wait();
    end;

    task.wait(3);

    if workspace:GetAttribute("PrivateServerRewardsOff") == true then
        HudNavigation.Notice:Fire("Private server: coins, gems and quests don\'t count here.");
    end;
end;

function u1.run(u151) -- Line: 471
    -- upvalues: u1 (copy), LocalPlayer (copy)
    task.spawn(u1.invites, u151);
    task.spawn(u1.rewardsNotice);
    local u152 = false;

    local function check() -- Line: 475
        -- upvalues: u152 (ref), LocalPlayer (ref), u1 (ref), u151 (copy)
        if u152 or workspace:GetAttribute("PrivateServerHostId") ~= LocalPlayer.UserId then
            return;
        end;

        u152 = true;
        task.spawn(u1.host, u151);
    end;

    workspace:GetAttributeChangedSignal("PrivateServerHostId"):Connect(check);

    if not u152 and workspace:GetAttribute("PrivateServerHostId") == LocalPlayer.UserId then
        u152 = true;
        task.spawn(u1.host, u151);
    end;
end;

return u1;