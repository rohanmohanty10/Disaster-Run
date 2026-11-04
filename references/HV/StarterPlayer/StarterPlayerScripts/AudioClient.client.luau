 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local u1;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u1 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u1 = nil;
end;

local Audio = ChickenOrHero:WaitForChild("Audio");
local GameAudio = SoundService:WaitForChild("GameAudio");
local u2 = require(Audio:WaitForChild("DefaultCharacterAudio")).start(LocalPlayer);
local AudioConfig = require(Audio:WaitForChild("AudioConfig"));
local AudioCatalog = require(Audio:WaitForChild("AudioCatalog"));
local u3 = require(Audio:WaitForChild("AudioPlayback")).new(GameAudio, AudioCatalog, AudioConfig);
local u4 = require(Audio:WaitForChild("DaggerAudio")).new(u3, AudioConfig);
local u5 = require(Audio:WaitForChild("MovementAudio")).new(u3, AudioConfig);
local u6 = require(Audio:WaitForChild("InterfaceAudio")).new(u3, LocalPlayer:WaitForChild("PlayerGui"));
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local u7 = require(Audio:WaitForChild("ThreatAudio")).new(u3, LocalPlayer, Session, AudioConfig.Danger);
local u8 = {
    RecapOpen = true,
    RecapTick = true,
    RecapComplete = true,
    RecapLevelUp = true
};
local l_require = require;
local Interface = ChickenOrHero:WaitForChild("Interface");
local success, result = pcall(l_require, Interface:WaitForChild("KnifeClipPreview"));

if not success then
    warn("Knife clip preview unavailable:", result);
    result = nil;
end;

local u15 = Audio:WaitForChild("PresentationCues").Event:Connect(function(p9, u10, p11) -- Line: 24
    -- upvalues: result (ref), u4 (copy), u3 (copy), LocalPlayer (copy), u8 (copy)
    if p9 == "KnifePreview" then
        local v12, v13;

        if result then
            v12, v13 = pcall(result.open, u10, p11, function(p14) -- Line: 30
                -- upvalues: u4 (ref), u10 (copy)
                u4:preview(u10, p14);
            end);

            if not v12 then
                warn("Knife clip preview failed:", v13);
            end;
        else
            v12 = false;
            v13 = false;
        end;

        if not (v12 and v13) then
            u4:preview(u10, p11);
        end;
    else
        if p9 == "ArmoryOpen" or p9 == "ArmoryClose" then
            u3:one(p9 == "ArmoryOpen" and "PanelOpen" or "PanelClose");

            return;
        end;

        if p9 == "ChoiceFocus" and LocalPlayer:GetAttribute("ChoiceSpotlightActive") == true then
            u3:one("ChoiceFocus");
            task.delay(type(u10) == "number" and (math.clamp(u10, 0.1, 0.6) or 0.3) or 0.3, function() -- Line: 37
                -- upvalues: u3 (ref), LocalPlayer (ref)
                if u3.alive and LocalPlayer:GetAttribute("ChoiceSpotlightActive") == true then
                    u3:one("ChoiceFocusResolve");
                end;
            end);

            return;
        end;

        if p9 == "GemCollect" then
            u3:one("GemCollect", nil, 1, type(u10) == "number" and (math.clamp(u10, 1, 1.3) or 1) or 1);

            return;
        end;

        if p9 == "RecapStop" then
            for i in u3.voices do
                if u8[i.key] then
                    u3:remove(i);
                end;
            end;

            return;
        end;

        if u8[p9] and LocalPlayer:GetAttribute("MatchSummaryVisible") == true then
            u3:one(p9, nil, 1, type(u10) == "number" and (math.clamp(u10, 0.8, 1.4) or 1) or 1);
        end;
    end;
end);
local u16 = Session:GetAttribute("Phase") or "Lobby";
local u17 = LocalPlayer:GetAttribute("GameRole") or "Lobby";
local u18 = Session:GetAttribute("SelectedUserId") or 0;
local u19 = Session:GetAttribute("NoticeUntil") or 0;
local u20 = "";
local u21 = nil;
local u22 = 0;
local u23 = 0;
local u24 = {
    Caught = true,
    ReachedSafety = true,
    CatchSuccess = true,
    Victory = true,
    Defeat = true,
    SpawnRefresh = true,
    LobbyReturn = true,
    HeroChosen = true,
    ChickenChosen = true,
    RunEnd = true
};
local u28 = Audio:WaitForChild("Events").OnClientEvent:Connect(function(p25, p26) -- Line: 54
    -- upvalues: u4 (copy), Players (copy), u1 (copy), AudioConfig (copy), u3 (copy), LocalPlayer (copy), u24 (copy)
    if p25 == "DaggerHit" then
        u4:hit(p26);

        return;
    end;

    if p25 == "CatchImpact" and type(p26) == "number" then
        local PlayerByUserId = Players:GetPlayerByUserId(p26);
        local v27;

        if PlayerByUserId then
            v27 = PlayerByUserId.Character;
        else
            v27 = PlayerByUserId;
        end;

        if not PlayerByUserId and u1 then
            v27 = u1.get(p26);

            if v27 then
                v27 = v27.Character;
            end;
        end;

        if v27 then
            v27 = v27:FindFirstChild("HumanoidRootPart");
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;

        if v27 and (workspace_CurrentCamera and (v27.Position - workspace_CurrentCamera.CFrame.Position).Magnitude <= AudioConfig.RemoteActionDistance) then
            if PlayerByUserId == LocalPlayer or not v27 then
                v27 = nil;
            end;

            u3:one(p25, v27, PlayerByUserId == LocalPlayer and 1 or 0.65);
        end;
    elseif u24[p25] then
        u3:one(p25);
    end;
end);

local function updateState() -- Line: 66
    -- upvalues: Session (copy), LocalPlayer (copy), u16 (ref), AudioConfig (copy), u3 (copy), u20 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (ref)
    local v29 = Session:GetAttribute("Phase") or "Lobby";
    local v30 = LocalPlayer:GetAttribute("GameRole") or "Lobby";
    local v31;

    if v29 == "Countdown" and LocalPlayer:GetAttribute("AFK") ~= true then
        v31 = LocalPlayer:GetAttribute("ClientReady") == true;
    else
        v31 = false;
    end;

    if v29 ~= u16 then
        local v32 = AudioConfig.PhaseCues[v29];

        if v32 and (v30 ~= "Lobby" or v31) then
            u3:one(v32);
        end;

        u16 = v29;
        u20 = "";
    end;

    if v30 ~= u17 then
        if v30 == "Runner" then
            u3:one("RoleRunner");
        elseif v30 == "Catcher" then
            u3:one("RoleCatcher");
        end;

        u17 = v30;
    end;

    local v33 = Session:GetAttribute("SelectedUserId") or 0;

    if v33 ~= u18 then
        if v33 == LocalPlayer.UserId then
            u3:one("SelectedHero");
        end;

        u18 = v33;
    end;

    local v34 = Session:GetAttribute("NoticeUntil") or 0;

    if v34 ~= u19 then
        if workspace:GetServerTimeNow() < v34 and (Session:GetAttribute("NoticeSound") ~= false and Session:GetAttribute("GlobalPaused") ~= true) then
            u3:one("Notice");
        end;

        u19 = v34;
    end;

    local v35 = Session:GetAttribute("EndsAt") or 0;
    local v36 = v35 - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v36);
    local v37 = AudioConfig.CountdownPhases[v29];

    if v37 then
        if math_ceil_ret >= 1 then
            v37 = math_ceil_ret <= 3;
        else
            v37 = false;
        end;
    end;

    local v38 = AudioConfig.CrossingPhases[v29];

    if v38 then
        if math_ceil_ret >= 1 and math_ceil_ret <= 5 then
            v38 = LocalPlayer:GetAttribute("RunState") == "Active";
        else
            v38 = false;
        end;
    end;

    if not (v35 <= 0 or not (v37 or v38) or v30 == "Lobby" and not v31) then
        local v39 = v29 .. ":" .. tostring(v35) .. ":" .. math_ceil_ret;
        local v40 = v29 .. ":" .. math_ceil_ret;

        if v39 ~= u20 and Session:GetAttribute("GlobalPaused") == true then
            u20 = v39;
            u21 = v40;

            return;
        end;

        if v39 ~= u20 and v40 == u21 then
            u20 = v39;
            u21 = nil;

            return;
        end;

        if v39 ~= u20 then
            u20 = v39;
            u21 = nil;
            u3:one(v38 and "TimeWarning" or (math_ceil_ret == 1 and u3:template("CountdownFinal") and "CountdownFinal" or "CountdownTick"));
        end;
    end;
end;

local u42 = RunService.Heartbeat:Connect(function(p41) -- Line: 115
    -- upvalues: u22 (ref), u23 (ref), AudioConfig (copy), u3 (copy), u5 (copy), u4 (copy), u7 (copy), updateState (copy)
    u22 = u22 + p41;
    u23 = u23 + p41;

    if u22 >= AudioConfig.UpdateInterval then
        local math_min_ret = math.min(u22, 0.1);
        u22 = 0;
        u3:update();
        u5:update(math_min_ret);
        u4:update();
        u7:update(math_min_ret, workspace:GetServerTimeNow());
    end;

    if u23 >= 0.1 then
        u23 = 0;
        updateState();
    end;
end);
script.Destroying:Connect(function() -- Line: 123
    -- upvalues: u42 (copy), u28 (copy), u15 (copy), result (ref), u4 (copy), u7 (copy), u6 (copy), u5 (copy), u3 (copy), u2 (copy)
    u42:Disconnect();
    u28:Disconnect();
    u15:Disconnect();

    if result then
        result.close();
    end;

    u4:destroy();
    u7:destroy();
    u6:destroy();
    u5:destroy();
    u3:destroy();
    u2();
end);
updateState();