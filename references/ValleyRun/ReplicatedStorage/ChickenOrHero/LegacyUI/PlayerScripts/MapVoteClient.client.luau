 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local MapVoteState = Game:WaitForChild("MapVoteState");
local MapVoteEvent = Game:WaitForChild("MapVoteEvent");
local Session = Game:WaitForChild("Session");
local MapVoteConfig = require(Game:WaitForChild("MapVoteConfig"));
local MapVoteTiming = require(ChickenOrHero.Presentation:WaitForChild("MapVoteTiming"));
local HudNavigation = require(ChickenOrHero.Presentation:WaitForChild("HudNavigation"));
local u1 = require(ChickenOrHero.Presentation:WaitForChild("MapVoteView")).new(LocalPlayer:WaitForChild("PlayerGui"));
local u2 = {
    phase = "Closed"
};
local u3 = {};
local u4 = 0;
local u5 = nil;
local u6 = 0;
local u7 = false;
local u8 = false;
local u9 = false;
local u10 = false;
local u11 = false;
local u12 = { "StarterPackOpen", "LikeRewardOpen", "CreatorPanelOpen", "CreatorCameraActive", "CreatorUIHidden", "ScreenPresentationActive", "GlobalWheelOpen", "MatchSummaryVisible", "TutorialModalActive", "CursorHintOpen", "CursorHintPending", "BalloonOfferOpen", "ArmoryOpen", "JourneyOpen", "SettingsOpen", "UpdateLogOpen", "ServerBrowserOpen", "AdminConsoleActive", "AnnouncementComposerOpen", "EmoteWheelOpen", "FairPlayNoticeOpen", "ConnectionQualityOpen" };

local function eligible() -- Line: 22
    -- upvalues: LocalPlayer (copy)
    local v13;

    if LocalPlayer:GetAttribute("ClientReady") == true and LocalPlayer:GetAttribute("InitialLoadingComplete") == true then
        v13 = not (LocalPlayer:GetAttribute("AFK") or (LocalPlayer:GetAttribute("InMatch") or LocalPlayer:GetAttribute("TutorialSession")) or (LocalPlayer:GetAttribute("TutorialRouting") or LocalPlayer:GetAttribute("TutorialActive") or (LocalPlayer:GetAttribute("TutorialFinishing") or LocalPlayer:GetAttribute("AdminTransferring")))) and not LocalPlayer:GetAttribute("ServerBrowserTransferring");
    else
        v13 = false;
    end;

    return v13;
end;

local function modal(p14) -- Line: 27
    -- upvalues: u11 (ref), LocalPlayer (copy), HudNavigation (copy), GuiService (copy), u1 (copy)
    if p14 == u11 then
        return;
    end;

    u11 = p14;
    LocalPlayer:SetAttribute("MapVoteOpen", p14);

    if p14 then
        HudNavigation.opening("MapVote");

        return;
    end;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1.gui) then
        GuiService.SelectedObject = nil;
    end;
end;

local function cycle(p15, p16, p17) -- Line: 38
    -- upvalues: u2 (ref), LocalPlayer (copy), u1 (copy)
    if p16 ~= Enum.UserInputState.Begin or (u2.phase ~= "Voting" or (not u2.options or #u2.options == 0)) then
        return Enum.ContextActionResult.Pass;
    end;

    local options = u2.options;
    local v18 = u2.votes and u2.votes[tostring(LocalPlayer.UserId)];
    local v19 = 0;

    for i, v in options do
        if v.id == v18 then
            v19 = i;
            break;
        end;
    end;

    local v20 = p17.KeyCode == Enum.KeyCode.DPadLeft and -1 or 1;
    local v21;

    if v19 == 0 then
        if v20 > 0 then
            v21 = 1;
        else
            v21 = #options or (v19 - 1 + v20) % #options + 1;
        end;
    else
        v21 = (v19 - 1 + v20) % #options + 1;
    end;

    u1.onVote(options[v21].id);

    return Enum.ContextActionResult.Sink;
end;

local function bindVote(p22) -- Line: 47
    -- upvalues: u8 (ref), ContextActionService (copy), cycle (copy)
    if p22 == u8 then
        return;
    end;

    u8 = p22;

    if p22 then
        ContextActionService:BindAction("MapVoteGamepad", cycle, false, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight);

        return;
    end;

    ContextActionService:UnbindAction("MapVoteGamepad");
end;

local function render() -- Line: 51
    -- upvalues: u5 (ref), LocalPlayer (copy), u7 (ref), u6 (ref), MapVoteConfig (copy), u2 (ref), eligible (copy), Session (copy), u12 (copy), MapVoteTiming (copy), u9 (ref), u10 (ref), u11 (ref), HudNavigation (copy), GuiService (copy), u1 (copy), UserInputService (copy), u8 (ref), ContextActionService (copy), cycle (copy)
    local os_clock_ret = os.clock();

    if not (u5 or (LocalPlayer:GetAttribute("ClientReady") ~= true or (LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true or LocalPlayer:GetAttribute("ScreenPresentationActive")))) then
        u5 = os_clock_ret;
    end;

    local v23 = LocalPlayer:GetAttribute("MatchSummaryVisible") == true;

    if u7 and not v23 then
        u6 = os_clock_ret + (MapVoteConfig.AfterSummarySeconds or 0.5);
    end;

    u7 = v23;
    local v24;

    if u2.phase == "Voting" or u2.phase == "Result" then
        v24 = eligible();
    else
        v24 = false;
    end;

    local ValleyHUD = LocalPlayer.PlayerGui:FindFirstChild("ValleyHUD");

    if Session:GetAttribute("MapChanging") == true then
        ValleyHUD = true;
    elseif ValleyHUD then
        ValleyHUD = ValleyHUD:GetAttribute("DrawerOpen") == true;
    end;

    for _, v in u12 do
        if LocalPlayer:GetAttribute(v) == true then
            ValleyHUD = true;
            break;
        end;
    end;

    local v25 = MapVoteTiming.canPresent(os_clock_ret, u5, LocalPlayer:GetAttribute("MapVoteJoinedAt"), u2.openedAt, u6, MapVoteConfig);

    if v24 then
        local v26 = not ValleyHUD;

        if not v26 then
            v25 = v26;
        end;
    else
        v25 = v24;
    end;

    local v27 = (u2.endsAt or 0) - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v27);
    local math_max_ret = math.max(0, math_ceil_ret);

    if v25 and not u9 then
        u9 = true;
        u10 = MapVoteTiming.shouldExpand(u2.phase, math_max_ret);
    end;

    local v28 = v25 and u10 or false;

    if v28 ~= u11 then
        u11 = v28;
        LocalPlayer:SetAttribute("MapVoteOpen", v28);

        if v28 then
            HudNavigation.opening("MapVote");
        elseif GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1.gui) then
            GuiService.SelectedObject = nil;
        end;
    end;

    LocalPlayer:SetAttribute("MapVoteVisible", v25 == true);
    local v29;

    if v25 then
        v29 = u10;
    else
        v29 = v25;
    end;

    u1:setExpanded(v29);
    u1:setVisible(v25);
    u1.gamepad = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
    local v30 = v25 and u1.gamepad and u2.phase == "Voting";

    if v30 ~= u8 then
        u8 = v30;

        if v30 then
            ContextActionService:BindAction("MapVoteGamepad", cycle, false, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight);
        else
            ContextActionService:UnbindAction("MapVoteGamepad");
        end;
    end;

    if not v25 and (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1.gui)) then
        GuiService.SelectedObject = nil;
    end;

    if v24 then
        u1:render(u2, LocalPlayer.UserId);
        u1:clock(math_max_ret, Session:GetAttribute("GlobalPaused") == true);
    end;

    u1:layout();
end;

local function read() -- Line: 77
    -- upvalues: HttpService (copy), MapVoteState (copy), u2 (ref), u9 (ref), u10 (ref), render (copy)
    local success, result = pcall(HttpService.JSONDecode, HttpService, MapVoteState.Value);

    if success and type(result) == "table" then
        if result.token ~= u2.token then
            u9 = false;
            u10 = false;
        end;

        u2 = result;
        render();
    end;
end;

function u1.onVote(p31) -- Line: 84
    -- upvalues: eligible (copy), u2 (ref), Session (copy), MapVoteEvent (copy)
    if eligible() and (u2.phase == "Voting" and not Session:GetAttribute("GlobalPaused")) then
        MapVoteEvent:FireServer("Vote", p31, u2.token);
    end;
end;

table.insert(u3, u1.close.Activated:Connect(function() -- Line: 87
    -- upvalues: u10 (ref), u9 (ref), render (copy)
    u10 = not u10;
    u9 = true;
    render();
end));
table.insert(u3, UserInputService.InputBegan:Connect(function(p32, p33) -- Line: 88
    -- upvalues: u11 (ref), u10 (ref), render (copy)
    if not p33 and (u11 and (p32.KeyCode == Enum.KeyCode.Escape or p32.KeyCode == Enum.KeyCode.ButtonB)) then
        u10 = false;
        render();
    end;
end));
table.insert(u3, MapVoteState.Changed:Connect(read));
table.insert(u3, RunService.Heartbeat:Connect(function(p34) -- Line: 92
    -- upvalues: u4 (ref), render (copy)
    u4 = u4 + p34;

    if u4 >= 0.1 then
        u4 = 0;
        render();
    end;
end));
script.Destroying:Connect(function() -- Line: 93
    -- upvalues: u3 (copy), u8 (ref), ContextActionService (copy), u11 (ref), LocalPlayer (copy), GuiService (copy), u1 (copy)
    for _, v in u3 do
        v:Disconnect();
    end;

    if u8 ~= false then
        u8 = false;
        ContextActionService:UnbindAction("MapVoteGamepad");
    end;

    if u11 ~= false then
        u11 = false;
        LocalPlayer:SetAttribute("MapVoteOpen", false);

        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u1.gui) then
            GuiService.SelectedObject = nil;
        end;
    end;

    LocalPlayer:SetAttribute("MapVoteOpen", false);
    LocalPlayer:SetAttribute("MapVoteVisible", false);
    u1:destroy();
end);
local success, result = pcall(HttpService.JSONDecode, HttpService, MapVoteState.Value);

if success and type(result) == "table" then
    if result.token ~= u2.token then
        u9 = false;
        u10 = false;
    end;

    u2 = result;
    render();
end;