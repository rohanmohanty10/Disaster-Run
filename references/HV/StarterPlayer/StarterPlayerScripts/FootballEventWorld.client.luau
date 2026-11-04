 

 

local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).TeamEventEnabled ~= true then
    return;
end;

local TeamEventConfig = require(ChickenOrHero:WaitForChild("Progression"):WaitForChild("TeamEventConfig"));
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local TeamEventCelebration = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("TeamEventCelebration"));
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local u1 = {};
ChickenOrHero.Weapons:WaitForChild("ArmoryEvent").OnClientEvent:Connect(function(p2, p3) -- Line: 19
    -- upvalues: u1 (ref)
    if p2 == "State" and (type(p3) == "table" and type(p3.owned) == "table") then
        u1 = p3.owned;
    end;
end);
local Game = ChickenOrHero:WaitForChild("Game");
local TeamEventRemote = Game:WaitForChild("TeamEventRemote");
local u4 = TeamEventConfig.Team.Football.Name .. " vs " .. TeamEventConfig.Team.Futbol.Name;
local u5 = true;
local u6 = {};

local function on(p7, p8) -- Line: 29
    -- upvalues: u6 (copy)
    table.insert(u6, p7:Connect(p8));
end;

local function short(p9) -- Line: 32
    local v10 = tonumber(p9) or 0;

    if v10 >= 1000000000 then
        return ("%.1fB"):format(v10 / 1000000000);
    end;

    if v10 >= 1000000 then
        return ("%.1fM"):format(v10 / 1000000);
    end;

    if v10 >= 10000 then
        return ("%.1fK"):format(v10 / 1000);
    end;

    local math_floor_ret = math.floor(v10);

    return tostring(math_floor_ret);
end;

local u11 = { "InMatch", "MatchSummaryVisible", "ScreenPresentationActive", "AdminRefreshActive", "FootballCutsceneActive", "FootballEventOpen", "Spectating", "StarterPackOpen", "LikeRewardOpen", "EventRsvpOpen", "CrateOpen", "SpinWheelOpen", "ArmoryOpen", "JourneyOpen", "CodesOpen", "SettingsOpen", "ServerBrowserOpen", "CombineOpen", "QuestsOpen", "UpdateLogOpen", "BalloonOfferOpen", "BundleOfferOpen", "EventKnivesOpen", "FairPlayNoticeOpen", "ConnectionQualityOpen", "HostPanelOpen", "AdminPanelOpen", "PrivateInviteOpen", "CreatorPanelOpen", "CreatorUIHidden", "EmoteWheelOpen", "AnnouncementComposerOpen", "AdminConsoleActive", "ChoiceSpotlightActive", "ReleaseCameraForUI", "ProUnlockActive" };
local u12 = nil;
local u13 = {};
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = {};
local u18 = nil;
local u19 = false;

local function recent(p20) -- Line: 105
    local v21;

    if type(p20) == "number" then
        v21 = workspace:GetServerTimeNow() - p20 < 21600;
    else
        v21 = false;
    end;

    return v21;
end;

local function permitted() -- Line: 109
    -- upvalues: LocalPlayer (copy), u11 (copy)
    if LocalPlayer:GetAttribute("ClientReady") ~= true then
        return false;
    end;

    for _, v in u11 do
        if LocalPlayer:GetAttribute(v) == true then
            return false;
        end;
    end;

    return true;
end;

local function has(p22, p23) -- Line: 121
    local v24;

    if type(p22) == "table" then
        v24 = p22[p23] == true and true or p22[tostring(p23)] == true;
    else
        v24 = false;
    end;

    return v24;
end;

local function myTeam() -- Line: 124
    -- upvalues: u15 (ref), LocalPlayer (copy), TeamEventConfig (copy)
    local v25;

    if u15 then
        v25 = u15.team;
    else
        v25 = LocalPlayer:GetAttribute("TeamEventTeam");
    end;

    if TeamEventConfig.Team[v25] then
        return v25;
    end;

    return nil;
end;

local function push(p26, p27) -- Line: 128
    -- upvalues: u13 (copy)
    for _, v in u13 do
        local v28;

        if v.kind == "Champion" and p26.kind == "Delivered" then
            v28 = true;
        elseif v.kind == "Delivered" then
            v28 = p26.kind == "Champion";
        else
            v28 = false;
        end;

        if (v.kind == p26.kind or v28) and v.team == p26.team then
            if p26.kind == "Champion" then
                local note = p26.note;
                v.kind = p26.kind;
                v.note = note;
            end;

            local v29 = v;

            for _, v2 in p26.levels or {} do
                if not table.find(v29.levels, v2) then
                    table.insert(v29.levels, v2);
                end;
            end;

            if v29.levels then
                table.sort(v29.levels);
            end;

            for _, v2 in p26.rewards or {} do
                table.insert(v29.rewards, v2);
            end;

            v29.reminder = v29.reminder and p26.reminder;

            return;
        end;
    end;

    table.insert(u13, p27 and 1 or #u13 + 1, p26);
end;

local function claimable(p30) -- Line: 156
    -- upvalues: u15 (ref), TeamEventConfig (copy)
    if not (u15 and (u15.claimsOpen == true and u15.wiped ~= true)) then
        return false;
    end;

    local v31 = tonumber(u15.points) or 0;

    for _, v in p30.levels do
        if p30.kind == "Personal" then
            local personal = u15.personal;
            local v32;

            if type(personal) == "table" then
                v32 = personal[v] == true and true or personal[tostring(v)] == true;
            else
                v32 = false;
            end;

            if not v32 and TeamEventConfig.PersonalLevels[v] <= v31 then
                return true;
            end;
        end;

        if p30.kind == "Team" then
            local teamClaims = u15.teamClaims;
            local v33;

            if type(teamClaims) == "table" then
                v33 = teamClaims[v] == true and true or teamClaims[tostring(v)] == true;
            else
                v33 = false;
            end;

            if not v33 and TeamEventConfig.Participation[v] <= v31 then
                return true;
            end;
        end;
    end;

    return false;
end;

local u34 = nil;

local function endInFrame() -- Line: 175
    -- upvalues: u34 (ref), LocalPlayer (copy)
    u34 = nil;
    task.delay(0.1, function() -- Line: 178
        -- upvalues: u34 (ref), LocalPlayer (ref)
        if not u34 then
            LocalPlayer:SetAttribute("TeamEventClaimInFrame", nil);
        end;
    end);
end;

local function present(u35, u36) -- Line: 184
    -- upvalues: u34 (ref), LocalPlayer (copy), TeamEventConfig (copy), u1 (ref), SkinCatalog (copy), claimable (copy), HudNavigation (copy), TeamEventRemote (copy), u16 (ref), u15 (ref), short (copy), TeamEventCelebration (copy)
    local v37 = {
        kind = u35.kind,
        team = u35.team,
        rewards = u35.rewards,
        note = u35.note,

        onClose = function() -- Line: 190, Name: onClose
            -- upvalues: u34 (ref), u35 (copy), LocalPlayer (ref), u36 (copy)
            if u34 and u34.entry == u35 then
                u34 = nil;
                task.delay(0.1, function() -- Line: 178
                    -- upvalues: u34 (ref), LocalPlayer (ref)
                    if not u34 then
                        LocalPlayer:SetAttribute("TeamEventClaimInFrame", nil);
                    end;
                end);
            end;

            u36();
        end
    };
    local levels = u35.levels;

    if levels then
        v37.levels = { levels[1], levels[#levels] };
        v37.rewards = {};

        for _, v in levels do
            local rewards = v37.rewards;
            local shown = TeamEventConfig.shown;
            local v38 = TeamEventConfig.reward(u35.kind, v, u35.team);
            table.insert(rewards, shown(v38, u1, SkinCatalog));
        end;

        if claimable(u35) then
            function v37.onClaim() -- Line: 205
                -- upvalues: HudNavigation (ref)
                HudNavigation.activate("FootballEvent");
            end;

            function v37.claimHere(u39) -- Line: 209
                -- upvalues: u35 (copy), u34 (ref), LocalPlayer (ref), TeamEventRemote (ref)
                local u40 = {
                    handle = u39,
                    entry = u35
                };
                u34 = u40;
                LocalPlayer:SetAttribute("TeamEventClaimInFrame", true);
                TeamEventRemote:FireServer("Claim", u35.kind);
                task.delay(10, function() -- Line: 214
                    -- upvalues: u34 (ref), u40 (copy), LocalPlayer (ref), u39 (copy)
                    if u34 == u40 then
                        u34 = nil;
                        task.delay(0.1, function() -- Line: 178
                            -- upvalues: u34 (ref), LocalPlayer (ref)
                            if not u34 then
                                LocalPlayer:SetAttribute("TeamEventClaimInFrame", nil);
                            end;
                        end);
                        u39:failed();
                    end;
                end);
            end;
        end;
    end;

    if u35.kind == "Team" then
        local v41 = TeamEventConfig.Participation[levels[1]];
        local v42 = u16 and u16.thresholds;
        local v43;

        if type(v42) == "table" then
            v43 = tonumber(v42[levels[#levels]]);
        else
            v43 = false;
        end;

        local v44;

        if u35.reminder then
            v44 = "YOUR TEAM REWARDS ARE WAITING!";
        elseif v37.onClaim or not (u15 and (u15.claimsOpen == true and (tonumber(u15.points) or 0) < v41)) then
            if v43 then
                v44 = short(v43) .. " TEAM POINTS!";
            else
                v44 = nil;
            end;
        else
            v44 = "EARN " .. v41 .. " POINTS OF YOUR OWN TO COLLECT IT!";
        end;

        v37.note = v44;
    end;

    return TeamEventCelebration.show(v37);
end;

local function pump() -- Line: 236
    -- upvalues: u5 (ref), permitted (copy), u12 (ref), u14 (ref), LocalPlayer (copy), push (copy), u13 (copy), pump (copy), present (copy)
    if not u5 then
        return;
    end;

    if not permitted() then
        u12 = nil;
        local v45 = u14;
        u14 = nil;

        if v45 and v45.handle then
            v45.handle:close(true);
        end;

        if v45 and (os.clock() - v45.at < 4 and LocalPlayer:GetAttribute("FootballEventOpen") ~= true) then
            push(v45.entry, true);
        end;

        return;
    end;

    u12 = u12 or os.clock();

    if u14 or #u13 == 0 then
        return;
    end;

    local v46 = u12 + 2 - os.clock();

    if v46 > 0 then
        task.delay(v46, pump);

        return;
    end;

    local table_remove_ret = table.remove(u13, 1);
    local u47 = {
        entry = table_remove_ret,
        at = os.clock()
    };
    u14 = u47;
    local success, result = pcall(present, table_remove_ret, function() -- Line: 265
        -- upvalues: u14 (ref), u47 (copy), pump (ref)
        if u14 == u47 then
            u14 = nil;
            task.delay(0.6, pump);
        end;
    end);
    u47.handle = success and result and result or nil;

    if not u47.handle then
        if u14 == u47 then
            u14 = nil;
        end;

        if not success then
            warn("FOOTBALL vs FÚTBOL celebration failed: " .. tostring(result));
        end;
    end;
end;

local function remind() -- Line: 282
    -- upvalues: u19 (ref), u15 (ref), u16 (ref), TeamEventConfig (copy), LocalPlayer (copy), push (copy)
    if u19 or not (u15 and (u16 and (u16.final == nil and (u15.claimsOpen == true and u15.wiped ~= true)))) then
        return;
    end;

    local _, v48 = TeamEventConfig.window();

    if v48 > 0 then
        local v49 = v48 + TeamEventConfig.SettleSeconds;
        local v50;

        if type(v49) == "number" then
            v50 = workspace:GetServerTimeNow() - v49 < 21600;
        else
            v50 = false;
        end;

        if not v50 then
            return;
        end;
    end;

    local v51;

    if u15 then
        v51 = u15.team;
    else
        v51 = LocalPlayer:GetAttribute("TeamEventTeam");
    end;

    if not TeamEventConfig.Team[v51] then
        v51 = nil;
    end;

    local v52;

    if v51 then
        if type(u16.teams) == "table" then
            v52 = u16.teams[v51];
        else
            v52 = false;
        end;
    else
        v52 = v51;
    end;

    if type(v52) ~= "table" then
        return;
    end;

    u19 = true;
    local v53 = tonumber(u15.points) or 0;
    local v54 = tonumber(v52.reached) or 0;
    local v55 = {};

    for i = 1, math.min(v54, #TeamEventConfig.TeamLevels) do
        local teamClaims = u15.teamClaims;
        local v56;

        if type(teamClaims) == "table" then
            v56 = teamClaims[i] == true and true or teamClaims[tostring(i)] == true;
        else
            v56 = false;
        end;

        local v57;

        if v56 or TeamEventConfig.Participation[i] > v53 then
            v57 = i;
        else
            table.insert(v55, i);
            v57 = i;
        end;
    end;

    if #v55 > 0 then
        push({
            kind = "Team",
            reminder = true,
            team = v51,
            levels = v55
        });
    end;
end;

local function celebrateSnapshot(p58) -- Line: 309
    -- upvalues: u16 (ref), u15 (ref), LocalPlayer (copy), TeamEventConfig (copy), u17 (copy), push (copy), TeamEventCelebration (copy), u4 (copy), remind (copy), pump (copy)
    local v59 = u16 == nil;
    local v60;

    if u16 == nil then
        v60 = false;
    else
        v60 = u16.final ~= nil;
    end;

    u16 = p58;
    local v61;

    if u15 then
        v61 = u15.team;
    else
        v61 = LocalPlayer:GetAttribute("TeamEventTeam");
    end;

    if not TeamEventConfig.Team[v61] then
        v61 = nil;
    end;

    for _, v in TeamEventConfig.Teams do
        local v62;

        if type(p58.teams) == "table" then
            v62 = p58.teams[v];
        else
            v62 = false;
        end;

        local v63;

        if type(v62) == "table" then
            v63 = v62.reached;
        else
            v63 = false;
        end;

        local v64 = tonumber(v63) or 0;
        local math_floor_ret = math.floor(v64);
        local math_clamp_ret = math.clamp(math_floor_ret, 0, #TeamEventConfig.TeamLevels);
        local v65 = u17[v];
        u17[v] = math.max(v65 or 0, math_clamp_ret);

        if v65 and v65 < math_clamp_ret then
            if v == v61 then
                local v66 = {};

                for i = v65 + 1, math_clamp_ret do
                    table.insert(v66, i);
                    local _ = i;
                end;

                push({
                    kind = "Team",
                    team = v,
                    levels = v66
                });
            else
                TeamEventCelebration.notice(("%s reached Level %d!"):format(TeamEventConfig.Team[v].Label, math_clamp_ret));
            end;
        end;
    end;

    local v67;

    if type(p58.final) == "table" then
        v67 = p58.final or nil;
    else
        v67 = nil;
    end;

    if v67 and not (v59 or v60) then
        local v68 = tonumber(v67.at);
        local v69;

        if type(v68) == "number" then
            v69 = workspace:GetServerTimeNow() - v68 < 21600;
        else
            v69 = false;
        end;

        if v69 then
            local champion = v67.champion;

            if v61 and (champion == v61 or champion == "Both") then
                push({
                    kind = "Champion",
                    team = v61,
                    rewards = {},
                    note = champion == "Both" and "IT\'S A TIE · BOTH TEAMS WIN!" or TeamEventConfig.Team[v61].Label .. " WINS " .. u4 .. "!"
                });
            elseif champion == "Both" or TeamEventConfig.Team[champion] then
                TeamEventCelebration.notice(champion == "Both" and "IT\'S A TIE · BOTH TEAMS WIN!" or TeamEventConfig.Team[champion].Label .. " WINS " .. u4 .. "!");
            end;
        end;
    end;

    remind();
    pump();
end;

local function celebrateState(p70, p71, p72) -- Line: 351
    -- upvalues: u15 (ref), u34 (ref), LocalPlayer (copy), TeamEventConfig (copy), u18 (ref), push (copy), remind (copy), pump (copy)
    if type(p70) ~= "table" then
        return;
    end;

    u15 = p70;

    if u34 and (type(p71) == "string" and (p71 ~= "auto" and p71 ~= "joined")) then
        local v73 = u34;
        u34 = nil;
        task.delay(0.1, function() -- Line: 178
            -- upvalues: u34 (ref), LocalPlayer (ref)
            if not u34 then
                LocalPlayer:SetAttribute("TeamEventClaimInFrame", nil);
            end;
        end);

        if p71 == "claimed" then
            v73.handle:reveal(p72);
        else
            v73.handle:failed();
        end;
    end;

    local v74;

    if u15 then
        v74 = u15.team;
    else
        v74 = LocalPlayer:GetAttribute("TeamEventTeam");
    end;

    if not TeamEventConfig.Team[v74] then
        v74 = nil;
    end;

    local v75 = TeamEventConfig.levelFor(p70.points, TeamEventConfig.PersonalLevels);

    if u18 and (u18 < v75 and v74) then
        local v76 = {};

        for i = u18 + 1, v75 do
            table.insert(v76, i);
            local _ = i;
        end;

        push({
            kind = "Personal",
            team = v74,
            levels = v76
        });
    end;

    u18 = v75;

    if p71 == "auto" and (type(p72) == "table" and next(p72)) then
        push({
            kind = "Delivered",
            team = v74,
            rewards = p72
        });
    end;

    remind();
    pump();
end;

local u77 = {};

local function signText() -- Line: 392
    -- upvalues: u16 (ref), TeamEventConfig (copy), u4 (copy), short (copy)
    local v78 = u16 and u16.teams;

    if type(v78) ~= "table" then
        return nil;
    end;

    local v79 = v78[TeamEventConfig.Teams[1]] or {};
    local v80 = v78[TeamEventConfig.Teams[2]] or {};
    local v81;

    if type(u16.final) == "table" then
        v81 = u16.final or nil;
    else
        v81 = nil;
    end;

    if v81 then
        local v82 = TeamEventConfig.Team[v81.champion];

        return not v82 and "BOTH TEAMS WIN!" or v82.Label .. " WINS!", ("AVERAGE %.1f vs %.1f"):format(tonumber(v79.average) or 0, tonumber(v80.average) or 0);
    end;

    if TeamEventConfig.phaseAt(workspace:GetServerTimeNow(), nil) == "Upcoming" then
        return nil;
    end;

    return u4, short(v79.points) .. " vs " .. short(v80.points);
end;

local function above(p83, p84) -- Line: 409
    if p83.Position.Y.Scale == p84.Position.Y.Scale then
        return p83.Position.Y.Offset < p84.Position.Y.Offset;
    end;

    return p83.Position.Y.Scale < p84.Position.Y.Scale;
end;

local function writeSign(p85) -- Line: 415
    -- upvalues: signText (copy), above (copy)
    local v86, v87 = signText();
    local v88 = {};

    for _, child in p85:GetChildren() do
        if child:IsA("TextLabel") then
            table.insert(v88, child);
        end;
    end;

    for _, v in v88 do
        v.AutoLocalize = false;
    end;

    if not v86 or #v88 < 2 then
        return;
    end;

    table.sort(v88, above);

    for i, v in { v86, v87 } do
        local v89 = v88[i];

        if v89.Text ~= v then
            v89.Text = v;
        end;
    end;
end;

local function dress(p90) -- Line: 438
    -- upvalues: writeSign (copy)
    if not p90:IsA("TextLabel") then
        return;
    end;

    if type(p90:GetAttribute("CountdownOffer")) == "string" and p90:GetAttribute("CountdownEnded") == nil then
        p90:SetAttribute("CountdownEnded", "EVENT ENDED");
    end;

    local Parent = p90.Parent;

    if Parent and (Parent.Name == "Sign" and Parent:IsA("LayerCollector")) then
        writeSign(Parent);
    end;
end;

local function dressPlace(p91) -- Line: 450
    -- upvalues: dress (copy)
    for _, descendant in p91:GetDescendants() do
        dress(descendant);
    end;
end;

local function dressPlaces() -- Line: 455
    -- upvalues: u77 (copy), dress (copy)
    for i in u77 do
        for _, descendant in i:GetDescendants() do
            dress(descendant);
        end;
    end;
end;

local function watchPlace(p92) -- Line: 460
    -- upvalues: u77 (copy), dress (copy)
    if u77[p92] or (not p92:IsA("Model") or string.sub(p92.Name, 1, 13) ~= "FootballEvent") then
        return;
    end;

    u77[p92] = p92.DescendantAdded:Connect(dress);

    for _, descendant in p92:GetDescendants() do
        dress(descendant);
    end;
end;

local function unwatchPlace(p93) -- Line: 467
    -- upvalues: u77 (copy)
    local v94 = u77[p93];

    if v94 then
        u77[p93] = nil;
        v94:Disconnect();
    end;
end;

local u95 = nil;

local function readSnapshot() -- Line: 477
    -- upvalues: HttpService (copy), u95 (ref), celebrateSnapshot (copy), u77 (copy), dress (copy)
    local success, result = pcall(HttpService.JSONDecode, HttpService, u95.Value);

    if success and type(result) == "table" then
        celebrateSnapshot(result);

        for i in u77 do
            for _, descendant in i:GetDescendants() do
                dress(descendant);
            end;
        end;
    end;
end;

table.insert(u6, TeamEventRemote.OnClientEvent:Connect(function(p96, p97, p98, p99) -- Line: 484
    -- upvalues: celebrateState (copy)
    if p96 == "State" then
        celebrateState(p97, p98, p99);
    end;
end));
local u100 = nil;

for _, v in { "ClientReady", table.unpack(u11) } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u6, AttributeChangedSignal:Connect(pump));
end;

table.insert(u6, workspace.ChildAdded:Connect(watchPlace));
table.insert(u6, workspace.ChildRemoved:Connect(unwatchPlace));
script.Destroying:Connect(function() -- Line: 494
    -- upvalues: u5 (ref), u6 (copy), u100 (ref), u77 (copy), u13 (copy), u14 (ref)
    u5 = false;

    for _, v in u6 do
        v:Disconnect();
    end;

    if u100 then
        u100:Disconnect();
    end;

    for _, v in u77 do
        v:Disconnect();
    end;

    table.clear(u77);
    table.clear(u13);
    local v101 = u14;
    u14 = nil;

    if v101 and v101.handle then
        v101.handle:close(true);
    end;
end);
TeamEventRemote:FireServer("Get");

for _, child in workspace:GetChildren() do
    if not u77[child] and child:IsA("Model") then
        if string.sub(child.Name, 1, 13) == "FootballEvent" then
            u77[child] = child.DescendantAdded:Connect(dress);

            for _, descendant in child:GetDescendants() do
                dress(descendant);
            end;
        end;
    end;
end;

while u5 do
    local TeamEvent = Game:FindFirstChild("TeamEvent");

    if TeamEvent then
        TeamEvent = TeamEvent:FindFirstChild("Snapshot");
    end;

    if TeamEvent ~= u95 then
        if u100 then
            u100:Disconnect();
            u100 = nil;
        end;

        u95 = TeamEvent;

        if TeamEvent then
            u100 = TeamEvent.Changed:Connect(readSnapshot);
            local success, result = pcall(HttpService.JSONDecode, HttpService, u95.Value);

            if success and type(result) == "table" then
                celebrateSnapshot(result);

                for i in u77 do
                    for _, descendant in i:GetDescendants() do
                        dress(descendant);
                    end;
                end;
            end;
        end;
    end;

    task.wait(1);
end;