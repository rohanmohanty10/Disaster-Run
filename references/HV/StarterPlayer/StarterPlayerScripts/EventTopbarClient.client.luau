 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local HudNavigation = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Icon = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("TopbarPlus"):WaitForChild("Icon"));
local JourneySeasons = require(ChickenOrHero:WaitForChild("Progression"):WaitForChild("JourneySeasons"));
local CandyCorn = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn"));

local function halloween() -- Line: 21
    -- upvalues: JourneySeasons (copy), CandyCorn (copy)
    local v1;

    if JourneySeasons.ActiveSeason == "season_2" then
        v1 = CandyCorn.active(workspace:GetServerTimeNow());
    else
        v1 = false;
    end;

    return v1;
end;

local u2 = Icon.new():setName("ValleyEvent"):align("Left"):setOrder(2):setImage("rbxassetid://106589565788535"):oneClick();
UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 28, Name: layout
    -- upvalues: u2 (copy), UserInputService (copy)
    u2:setLabel(UserInputService.PreferredInput == Enum.PreferredInput.Touch and "" or "EVENT");
end);
u2:setLabel(UserInputService.PreferredInput == Enum.PreferredInput.Touch and "" or "EVENT");
local BindableEvent = Instance.new("BindableEvent");
local u3 = true;
local u4 = false;
u2.noticeChanged:Connect(function() -- Line: 39
    -- upvalues: u2 (copy)
    task.defer(function() -- Line: 40
        -- upvalues: u2 (ref)
        local notice = u2.notice;
        local v5;

        if notice then
            v5 = notice:FindFirstChild("NoticeLabel");
        else
            v5 = notice;
        end;

        if v5 then
            notice.BackgroundColor3 = Color3.fromRGB(235, 45, 45);
            v5.Text = "!";
            v5.TextColor3 = Color3.new(1, 1, 1);
            v5.Font = Enum.Font.GothamBlack;
        end;
    end);
end);
u2.selected:Connect(function() -- Line: 52
    -- upvalues: u3 (ref), BindableEvent (copy), JourneySeasons (copy), CandyCorn (copy), HudNavigation (copy)
    if u3 then
        u3 = false;
        BindableEvent:Fire();
    end;

    local v6;

    if JourneySeasons.ActiveSeason == "season_2" then
        v6 = CandyCorn.active(workspace:GetServerTimeNow());
    else
        v6 = false;
    end;

    if v6 then
        HudNavigation.activate("Journey");

        return;
    end;

    local FootballEventOpen = HudNavigation.handlers.FootballEventOpen;

    if HudNavigation.available.FootballEvent == true and FootballEventOpen then
        FootballEventOpen();
    end;
end);
local u7 = nil;

local function refresh() -- Line: 71
    -- upvalues: JourneySeasons (copy), CandyCorn (copy), u7 (ref), u2 (copy), HudNavigation (copy), u3 (ref), u4 (ref), BindableEvent (copy)
    local v8;

    if JourneySeasons.ActiveSeason == "season_2" then
        v8 = CandyCorn.active(workspace:GetServerTimeNow());
    else
        v8 = false;
    end;

    if v8 ~= u7 then
        u7 = v8;
        u2:setImage(v8 and "rbxassetid://122172980164834" or "rbxassetid://106589565788535");
    end;

    local v9 = HudNavigation.available[v8 and "Journey" or "FootballEvent"] == true;
    u2:setEnabled(v9);

    if v9 and (u3 and not u4) then
        u4 = true;
        u2:notify(BindableEvent.Event);
    end;
end;

HudNavigation.Changed.Event:Connect(function(p10) -- Line: 84
    -- upvalues: refresh (copy)
    if p10 == "FootballEvent" or p10 == "Journey" then
        refresh();
    end;
end);
refresh();
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 92, Name: topbar
    -- upvalues: UserInputService (copy), Icon (copy), LocalPlayer (copy)
    local v11 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
    local setTopbarEnabled = Icon.setTopbarEnabled;

    if v11 then
        v11 = LocalPlayer:GetAttribute("InMatch") == true;
    end;

    setTopbarEnabled(not v11);
end);
local v12 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
local setTopbarEnabled = Icon.setTopbarEnabled;

if v12 then
    v12 = LocalPlayer:GetAttribute("InMatch") == true;
end;

setTopbarEnabled(not v12);

if u7 then
    local task_delay = task.delay;
    local v13 = CandyCorn.EndsAt - workspace:GetServerTimeNow();
    task_delay(math.max(0, v13) + 1, refresh);
end;