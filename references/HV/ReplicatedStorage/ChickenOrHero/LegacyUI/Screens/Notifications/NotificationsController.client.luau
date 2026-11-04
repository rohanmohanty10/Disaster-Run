 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Colors = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("HudStyle")).Colors;
local Game = ChickenOrHero:WaitForChild("Game");
local Session = Game:WaitForChild("Session");
local GameAction = Game:WaitForChild("GameAction");
local script_Parent = script.Parent;
local u1, u2 = require(ChickenOrHero.Presentation:WaitForChild("NotificationLayout")).apply(script_Parent);
local MainFrame = script_Parent:WaitForChild("MainFrame");
local Frame = MainFrame:WaitForChild("NotificationsF"):WaitForChild("Frame");
local WhatsHappening = Frame:WaitForChild("WhatsHappening");
local Location = Frame:WaitForChild("Location");
local Hint = Frame:WaitForChild("Hint");
local Choices = MainFrame:WaitForChild("Choices");
local u3 = require(ChickenOrHero.Presentation:WaitForChild("ChoiceController")).new(script_Parent, Session, GameAction);
local u4 = require(ChickenOrHero.Presentation:WaitForChild("EscapeStreakController")).new(script_Parent, Session, LocalPlayer, Colors);
local u5 = require(ChickenOrHero.Presentation:WaitForChild("CrossingBalanceNotice")).new(script_Parent, LocalPlayer);
local u6 = true;
local u7 = nil;
local u8 = nil;
local u9 = 0;
local u10 = {
    MapVote = "MAP VOTE",
    RankedLoadout = "LOADOUT",
    Lobby = "LOBBY",
    Countdown = "STARTING",
    Prepare = "GET READY",
    SelectHero = "SELECTION",
    HeroChoice = "YOUR CHOICE",
    ChoiceReveal = "CHOICE",
    HeroRun = "HERO RUN",
    GroupRun = "CROSSING",
    FinalRun = "FINAL RUN",
    RunResolution = "COMPLETE",
    Results = "RESULTS",
    Intermission = "LOBBY BREAK"
};

local function update() -- Line: 43
    -- upvalues: u2 (copy), Session (copy), u3 (copy), u4 (copy), u5 (copy), Location (copy), u10 (copy), LocalPlayer (copy), Colors (copy), Hint (copy), Choices (copy), u8 (ref), u9 (ref), WhatsHappening (copy), u7 (ref), TweenService (copy)
    u2();
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v11 = Session:GetAttribute("Phase") or "Lobby";
    u3:update(v11);
    u4:update(v11);
    u5:update(v11);
    local v12 = Session:GetAttribute("RunNumber") or 0;
    Location.Text = v12 > 0 and (v11 ~= "Lobby" and (v11 ~= "Countdown" and (v11 ~= "MapVote" and (v11 ~= "RankedLoadout" and v11 ~= "Intermission")))) and ("ROUND %02d"):format(v12) or (u10[v11] or v11);
    local v13 = LocalPlayer:GetAttribute("GameRole") or "Lobby";
    local v14 = LocalPlayer:GetAttribute("RunState") or "Lobby";
    local v15 = LocalPlayer:GetAttribute("AFK") == true;
    local v16;

    if v13 == "Lobby" then
        v16 = LocalPlayer:GetAttribute("InMatch") ~= true;
    else
        v16 = false;
    end;

    if v16 then
        Location.Text = "LOBBY";
    end;

    Location.TextColor3 = v14 == "Safe" and Colors.Mint or v13 == "Catcher" and Colors.Red or ((v11 == "HeroChoice" or v11 == "HeroRun") and Colors.Gold or Colors.Text);
    local v17 = Session:GetAttribute("EndsAt") or 0;
    local math_ceil_ret = math.ceil(v17 - ServerTimeNow);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v18;

    if v15 then
        v18 = "AFK · Staying in lobby";
    elseif v14 == "Safe" then
        v18 = "Safe";
    elseif v14 == "Caught" then
        v18 = "Caught";
    elseif v13 == "Lobby" then
        v18 = v11 == "Intermission" and "Next match soon" or (v11 == "RankedLoadout" and "Pick your loadout" or "Waiting for players");
    else
        v18 = v13 == "Catcher" and "Chaser" or v13;
    end;

    Hint.Text = v18 .. (v17 > 0 and not (v15 or v16 and (v11 ~= "Countdown" and (v11 ~= "Intermission" and v11 ~= "RankedLoadout"))) and (("  ·  %d:%02d"):format(math.floor(math_max_ret / 60), math_max_ret % 60) or "") or "");
    Hint.TextColor3 = v17 > 0 and (math_max_ret <= 5 and Colors.Gold) or Colors.Text;
    local v19 = Session:GetAttribute("Notice") or "";
    local v20;

    if ServerTimeNow < (Session:GetAttribute("NoticeUntil") or 0) and v19 ~= "" then
        v20 = not Choices.Visible;
    else
        v20 = false;
    end;

    local v21 = v20 and v19 and v19 or (Session:GetAttribute("Announcement") or "Connecting to the match...");

    if v16 and v15 then
        v20 = false;
        v21 = "AFK enabled — you’ll sit out until you turn it off.";
    elseif v16 and (v11 ~= "Lobby" and (v11 ~= "Countdown" and (v11 ~= "MapVote" and (v11 ~= "RankedLoadout" and v11 ~= "Intermission")))) then
        local v22;

        if v11 == "Results" then
            v22 = false;
        else
            v22 = LocalPlayer:GetAttribute("LateJoinMode");
        end;

        v21 = (v22 == "AutoJoin" or v22 == "PlayButton" and LocalPlayer:GetAttribute("LateJoinQueued") == true) and "Match in progress — you’ll join as a Chaser next round." or (v22 == "PlayButton" and "Match in progress — press PLAY to join next round." or "Match in progress — you’ll join the next one.");
        v20 = false;
    end;

    local snapshot = u4.snapshot;

    if v11 == "Prepare" and (v12 == 1 and not (v16 or (not snapshot.eligible or u8 == snapshot.matchId))) then
        u8 = snapshot.matchId;
        local math_max_ret2 = math.max(0, v17 - ServerTimeNow);
        u9 = ServerTimeNow + math.min(4, math_max_ret2);
    end;

    local v23 = v11 == "Prepare" and (ServerTimeNow < u9 and not (v16 or v20)) and (v13 == "Catcher" and "Catch runners to break their escape streak." or "Get everyone across 3 times in a row to win.") or v21;
    local Attribute = Session:GetAttribute("QueuedAdminMode");

    if type(Attribute) == "string" and Attribute ~= "" then
        v23 = "Next mode: " .. (({
            CrossyRoad = "Crossy Roads",
            DonkeyKong = "Donkey Kong",
            FFACatchers = "FFA Chasers Only",
            BladeBall = "Huss Ball"
        })[Attribute] or Attribute) .. "!";
        v20 = false;
    end;

    WhatsHappening.Text = v23;
    WhatsHappening.TextColor3 = Attribute and Colors.Gold or (v20 and Colors.Mint or Colors.Text);

    if v23 ~= u7 then
        u7 = v23;
        WhatsHappening.TextTransparency = 0.35;
        TweenService:Create(WhatsHappening, TweenInfo.new(0.18), {
            TextTransparency = 0
        }):Play();
    end;
end;

script.Destroying:Connect(function() -- Line: 133
    -- upvalues: u6 (ref), u1 (copy), MainFrame (copy), u3 (copy), u4 (copy), u5 (copy)
    u6 = false;
    u1:Disconnect();

    if game.GuiService.SelectedObject and game.GuiService.SelectedObject:IsDescendantOf(MainFrame) then
        game.GuiService.SelectedObject = nil;
    end;

    u3:destroy();
    u4:destroy();
    u5:destroy();
end);

while u6 and script_Parent.Parent do
    update();
    task.wait(0.1);
end;