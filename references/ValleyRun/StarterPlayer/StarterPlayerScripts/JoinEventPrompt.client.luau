 

 

local SocialService = game:GetService("SocialService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local EventHostRemote = ChickenOrHero:WaitForChild("Admin"):WaitForChild("EventHostRemote");
local ArmoryEvent = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ArmoryEvent");
local StarterPackConfig = require(ChickenOrHero:WaitForChild("Gear"):WaitForChild("StarterPackConfig"));
local u1 = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("ShopConfig")).storeUniverse(game.GameId);
local Telemetry = require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Telemetry"));
local u2 = true;
local u3 = {};

local function connect(p4, p5) -- Line: 12
    -- upvalues: u3 (copy)
    table.insert(u3, p4:Connect(p5));
end;

local EventModel = script:WaitForChild("EventModel");
local Prompt = EventModel:WaitForChild("Prompt");
local ProximityPrompt = Prompt:WaitForChild("ProximityPrompt");
local Decal = Prompt:WaitForChild("Decal");
local TextLabel = EventModel:WaitForChild("Main"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel");
local TextLabel2 = EventModel:WaitForChild("Timer"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel");
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
local u10 = {};
local u11 = {};
local u12 = {};
local u13 = nil;
local u14 = false;
local u15 = (-1 / 0);
local os_clock_ret = os.clock();
local u16 = { "ArmoryOpen", "JourneyOpen", "EmoteWheelOpen", "SettingsOpen", "UpdateLogOpen", "ServerBrowserOpen", "LikeRewardOpen", "MapVoteOpen", "MatchSummaryVisible", "AdminConsoleActive", "AdminPanelOpen", "ScreenPresentationActive", "StarterPackOpen", "QuestsOpen", "CrateOpen", "SpinWheelOpen", "FootballEventOpen", "EventKnivesOpen" };

local function starterHasPriority() -- Line: 55
    -- upvalues: LocalPlayer (copy), StarterPackConfig (copy), u1 (copy), u12 (ref)
    local v17;

    if LocalPlayer:GetAttribute("StarterPackOpen") == true then
        v17 = true;
    else
        v17 = StarterPackConfig.Enabled;

        if v17 then
            if u1 == StarterPackConfig.UniverseId and u12.starterFirstMatch == true then
                v17 = not (u12.starterPurchased or u12.starterPresented) and (u12.starterOfferEndsAt or 0) > workspace:GetServerTimeNow();
            else
                v17 = false;
            end;
        end;
    end;

    return v17;
end;

local function canInvite(p18) -- Line: 67
    -- upvalues: u2 (ref), u13 (ref), u9 (ref), LocalPlayer (copy), os_clock_ret (ref), u12 (ref), starterHasPriority (copy), u16 (copy)
    if not (u2 and (u13 == p18 and not (u9 or (os.clock() >= p18.expiresAt or (LocalPlayer:GetAttribute("ClientReady") ~= true or (LocalPlayer:GetAttribute("InMatch") == true or (os.clock() - os_clock_ret < 2 or (u12.loaded ~= true or (u12.starterProgressPending == true or starterHasPriority()))))))))) then
        return false;
    end;

    for _, v in u16 do
        if LocalPlayer:GetAttribute(v) then
            return false;
        end;
    end;

    return true;
end;

local function hideModel() -- Line: 90
    -- upvalues: ProximityPrompt (copy), EventModel (copy)
    ProximityPrompt.Enabled = false;
    EventModel.Parent = script;
end;

local function startTimestamp(p19) -- Line: 95
    local StartTime = p19.StartTime;

    if type(StartTime) ~= "table" then
        return nil;
    end;

    local success, result = pcall(function() -- Line: 101
        -- upvalues: StartTime (copy)
        return DateTime.fromUniversalTime(StartTime.Year, StartTime.Month, StartTime.Day, StartTime.Hour, StartTime.Minute, StartTime.Second, StartTime.Millisecond or 0);
    end);

    return success and result.UnixTimestamp or nil;
end;

local function formatRemaining(p20) -- Line: 115
    local math_max_ret = math.max(0, p20);
    local math_floor_ret = math.floor(math_max_ret / 86400);
    local math_floor_ret2 = math.floor(math_max_ret % 86400 / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);

    if math_floor_ret > 0 then
        return string.format("%dd %dh %dm", math_floor_ret, math_floor_ret2, math_floor_ret3);
    end;

    if math_floor_ret2 > 0 then
        return string.format("%dh %dm", math_floor_ret2, math_floor_ret3);
    end;

    return string.format("%d:%02d", math_floor_ret3, math_max_ret % 60);
end;

local function updateTimer() -- Line: 128
    -- upvalues: u8 (ref), TextLabel2 (copy), formatRemaining (copy)
    if not u8 then
        return false;
    end;

    local v21 = u8 - DateTime.now().UnixTimestamp;
    local math_max_ret = math.max(0, v21);
    TextLabel2.Text = formatRemaining(math_max_ret);

    return math_max_ret == 0;
end;

local u22 = {};

local function warnSometimes(p23, p24) -- Line: 140
    -- upvalues: u22 (copy)
    local os_clock_ret2 = os.clock();

    if os_clock_ret2 - (u22[p23] or (-1 / 0)) >= 600 then
        u22[p23] = os_clock_ret2;
        warn("JoinEventPrompt: " .. p23 .. ":", p24);
    end;
end;

local function getNextEvent() -- Line: 148
    -- upvalues: SocialService (copy), u22 (copy)
    local success, result = pcall(function() -- Line: 149
        -- upvalues: SocialService (ref)
        return SocialService:GetUpcomingExperienceEventsAsync();
    end);

    if not success or type(result) ~= "table" then
        local os_clock_ret2 = os.clock();

        if os_clock_ret2 - (u22["failed to get upcoming events"] or (-1 / 0)) >= 600 then
            u22["failed to get upcoming events"] = os_clock_ret2;
            warn("JoinEventPrompt: failed to get upcoming events:", result);
        end;

        return nil;
    end;

    local UnixTimestamp = DateTime.now().UnixTimestamp;
    local v25 = nil;
    local v26 = nil;

    for _, v in ipairs(result) do
        local StartTime = v.StartTime;
        local v27;

        if type(StartTime) == "table" then
            local success2, result2 = pcall(function() -- Line: 101
                -- upvalues: StartTime (copy)
                return DateTime.fromUniversalTime(StartTime.Year, StartTime.Month, StartTime.Day, StartTime.Hour, StartTime.Minute, StartTime.Second, StartTime.Millisecond or 0);
            end);
            v27 = success2 and result2.UnixTimestamp or nil;
        else
            v27 = nil;
        end;

        if v.Id and (v27 and (UnixTimestamp < v27 and not (v.HasStarted or (v.HasEnded or v25 and v27 >= v25)))) then
            v26 = v;
            v25 = v27;
        end;
    end;

    return v26, v25;
end;

local function refreshEvent() -- Line: 172
    -- upvalues: getNextEvent (copy), u2 (ref), u6 (ref), u8 (ref), ProximityPrompt (copy), EventModel (copy), SocialService (copy), u22 (copy), u7 (ref), u10 (copy), TextLabel (copy), Decal (copy), u9 (ref), TextLabel2 (copy), formatRemaining (copy)
    local v28, v29 = getNextEvent();

    if not u2 then
        return;
    end;

    if not v28 then
        u6 = nil;
        u8 = nil;
        ProximityPrompt.Enabled = false;
        EventModel.Parent = script;

        return;
    end;

    local u30 = tostring(v28.Id);
    local success, result = pcall(function() -- Line: 185
        -- upvalues: SocialService (ref), u30 (copy)
        return SocialService:GetEventRsvpStatusAsync(u30);
    end);

    if not u2 then
        return;
    end;

    if not success then
        local os_clock_ret2 = os.clock();

        if os_clock_ret2 - (u22["failed to get RSVP status"] or (-1 / 0)) >= 600 then
            u22["failed to get RSVP status"] = os_clock_ret2;
            warn("JoinEventPrompt: failed to get RSVP status:", result);
        end;
    end;

    u6 = u30;
    u8 = v29;
    local v31 = v28.Title or v28.DisplayTitle;
    local v32 = (type(v31) ~= "string" or v31 == "") and "Next Event" or v31;
    u7 = v32;
    local v33 = u10[u30] or (result == Enum.RsvpStatus.Going and true or v28.UserRsvpStatus == Enum.RsvpStatus.Going);

    if v33 then
        u10[u30] = true;
    end;

    TextLabel.Text = (v33 and "Already Signed Up: " or "Sign Up: ") .. v32;
    local ThumbnailIds = v28.ThumbnailIds;
    local v34;

    if type(ThumbnailIds) == "table" then
        v34 = ThumbnailIds[1];
    else
        v34 = false;
    end;

    Decal.Texture = v34 and "rbxassetid://" .. tostring(v34) or "";
    EventModel.Parent = workspace;
    ProximityPrompt.Enabled = not v33 and not u9;

    if not u8 then
        return;
    end;

    local v35 = u8 - DateTime.now().UnixTimestamp;
    local math_max_ret = math.max(0, v35);
    TextLabel2.Text = formatRemaining(math_max_ret);
    local _ = math_max_ret == 0;
end;

local function promptEvent(u36) -- Line: 221
    -- upvalues: u2 (ref), u9 (ref), u10 (copy), u11 (copy), LocalPlayer (copy), ProximityPrompt (copy), SocialService (copy), Telemetry (copy), u6 (ref), TextLabel (copy), u7 (ref), EventModel (copy)
    if not u2 or (u9 or u10[u36]) then
        return;
    end;

    u9 = true;
    u11[u36] = true;
    LocalPlayer:SetAttribute("EventRsvpOpen", true);
    ProximityPrompt.Enabled = false;
    local success, result = pcall(function() -- Line: 229
        -- upvalues: SocialService (ref), u36 (copy)
        return SocialService:PromptRsvpToEventAsync(u36);
    end);
    u9 = false;
    LocalPlayer:SetAttribute("EventRsvpOpen", nil);
    Telemetry.track("event_rsvp", (not success or typeof(result) ~= "EnumItem") and "failed" or result.Name);

    if not u2 then
        return;
    end;

    if success and result == Enum.RsvpStatus.Going then
        u10[u36] = true;

        if u6 == u36 then
            TextLabel.Text = "Already Signed Up: " .. u7;
        end;
    elseif not success then
        warn("JoinEventPrompt: failed to open RSVP prompt:", result);
    end;

    if EventModel.Parent == workspace then
        local v37;

        if u6 == nil then
            v37 = false;
        else
            v37 = not u10[u6];
        end;

        ProximityPrompt.Enabled = v37;
    end;
end;

table.insert(u3, ProximityPrompt.Triggered:Connect(function() -- Line: 252
    -- upvalues: u9 (ref), ProximityPrompt (copy), u6 (ref), EventModel (copy), promptEvent (copy)
    if u9 or not (ProximityPrompt.Enabled and (u6 and EventModel.Parent == workspace)) then
        return;
    end;

    promptEvent(u6);
end));

local function tryInvite(p38) -- Line: 259
    -- upvalues: canInvite (copy), getNextEvent (copy), u13 (ref), u10 (copy), u11 (copy), SocialService (copy), promptEvent (copy)
    if not canInvite(p38) then
        return;
    end;

    local v39, v40 = getNextEvent();

    if not canInvite(p38) then
        return;
    end;

    if not v39 then
        u13 = nil;

        return;
    end;

    local u41 = tostring(v39.Id);

    if u10[u41] or (u11[u41] or v39.UserRsvpStatus == Enum.RsvpStatus.Going) then
        u13 = nil;

        return;
    end;

    local success, result = pcall(function() -- Line: 277
        -- upvalues: SocialService (ref), u41 (copy)
        return SocialService:GetEventRsvpStatusAsync(u41);
    end);

    if not canInvite(p38) then
        return;
    end;

    if not success then
        p38.attempts = p38.attempts + 1;
        p38.retryAt = os.clock() + 30;

        if p38.attempts >= 3 then
            u13 = nil;
        end;

        return;
    end;

    if result == Enum.RsvpStatus.Going then
        u10[u41] = true;
        u13 = nil;

        return;
    end;

    if v40 <= DateTime.now().UnixTimestamp then
        p38.retryAt = os.clock() + 5;

        return;
    end;

    u13 = nil;
    promptEvent(u41);
end;

table.insert(u3, ArmoryEvent.OnClientEvent:Connect(function(p42, p43) -- Line: 305
    -- upvalues: u12 (ref), u13 (ref), starterHasPriority (copy)
    if p42 == "State" and type(p43) == "table" then
        u12 = p43;

        if u13 and starterHasPriority() then
            u13 = nil;
        end;
    end;
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("StarterPackOpen");
table.insert(u3, AttributeChangedSignal:Connect(function() -- Line: 314
    -- upvalues: LocalPlayer (copy), u13 (ref)
    if LocalPlayer:GetAttribute("StarterPackOpen") then
        u13 = nil;
    end;
end));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u3, AttributeChangedSignal2:Connect(function() -- Line: 319
    -- upvalues: os_clock_ret (ref)
    os_clock_ret = os.clock();
end));
table.insert(u3, EventHostRemote.OnClientEvent:Connect(function(p44, p45) -- Line: 322
    -- upvalues: u15 (ref), starterHasPriority (copy), u9 (ref), u13 (ref), ArmoryEvent (copy)
    if p44 ~= "PromptEvent" or (type(p45) ~= "table" or (type(p45.issuedAt) ~= "number" or (p45.issuedAt ~= p45.issuedAt or (p45.issuedAt <= u15 or (workspace:GetServerTimeNow() - p45.issuedAt > 60 or p45.issuedAt > workspace:GetServerTimeNow() + 30))))) then
        return;
    end;

    u15 = p45.issuedAt;

    if starterHasPriority() or u9 then
        return;
    end;

    u13 = u13 or {
        retryAt = 0,
        attempts = 0,
        expiresAt = os.clock() + 1200
    };
    ArmoryEvent:FireServer("Get");
end));
script.Destroying:Connect(function() -- Line: 342
    -- upvalues: u2 (ref), u13 (ref), LocalPlayer (copy), u3 (copy), EventModel (copy)
    u2 = false;
    u13 = nil;
    LocalPlayer:SetAttribute("EventRsvpOpen", nil);

    for _, v in u3 do
        v:Disconnect();
    end;

    EventModel:Destroy();
end);
ProximityPrompt.Enabled = false;
EventModel.Parent = script;
ArmoryEvent:FireServer("Get");
local v46 = 0;

while true do
    if not (u2 and script.Parent) then
        return;
    end;

    if v46 <= os.clock() then
        refreshEvent();
        v46 = os.clock() + 60;
    else
        local v47;

        if u8 then
            local v48 = u8 - DateTime.now().UnixTimestamp;
            local math_max_ret = math.max(0, v48);
            TextLabel2.Text = formatRemaining(math_max_ret);
            v47 = math_max_ret == 0;
        else
            v47 = false;
        end;

        if v47 then
            refreshEvent();
            v46 = os.clock() + 60;
        end;
    end;

    if u13 then
        if os.clock() >= u13.expiresAt or starterHasPriority() then
            u13 = nil;
        elseif not (u14 or (os.clock() < u13.retryAt or not canInvite(u13))) then
            local u49 = u13;
            u14 = true;
            task.spawn(function() -- Line: 366
                -- upvalues: tryInvite (copy), u49 (copy), u14 (ref), u13 (ref)
                local v50, v51 = xpcall(function() -- Line: 367
                    -- upvalues: tryInvite (ref), u49 (ref)
                    tryInvite(u49);
                end, debug.traceback);
                u14 = false;

                if not v50 then
                    if u13 == u49 then
                        u13 = nil;
                    end;

                    warn("JoinEventPrompt: invitation failed:", v51);
                end;
            end);
        end;
    end;

    task.wait(1);
end;