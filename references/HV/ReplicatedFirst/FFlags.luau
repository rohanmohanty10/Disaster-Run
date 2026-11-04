 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local u1 = {
    UIVersion = "OldUIReskin",
    UIExperiment = false,
    NoUI = false,
    IntermissionExperiment = false,
    SessionSummaries = true,
    LateJoinExperiment = false,
    LateJoinTestMode = false,
    RunnerBuffExperiment = true,
    RunnerBuffTestMode = false,
    TutorialExperiment = true,
    TutorialTestMode = false,
    ClientBots = true,
    LocalLocomotion = true,
    Chrono = true,
    LoadingScreenEnabled = false,
    HitModel = "Server929",
    GAEnabled = true,
    PrivateServerRewards = false,
    TestGameOverrides = false,
    GATesting = false,
    UISwitchCommand = false,
    StudioUIVersion = true,
    PrivateServerStudioPreview = false,
    ProServers = true,
    ProServerStudioPreview = false,
    Ranked = false,
    RankedStudioPreview = false,
    BotLobbyWins = false,
    EmotesEnabled = true,
    StarterAbilitiesEnabled = true,
    Map3Enabled = true,
    Map4Enabled = true,
    Map5Enabled = true,
    Map6Enabled = true,
    Map7Enabled = true,
    Haunt = true,
    LightsOut = true,
    ChaserStandIn = true,
    BotAutoNodes = true,
    BonkerDisplayTest = true,
    VowbreakerDisplayTest = true,
    GemCratesEverywhere = true,
    TeamEventEnabled = true,
    EventIntro = false,
    JourneyHalloween = true,
    EventIntroTestNoEvent = true,
    Albie = true,
    GiftingEnabled = true,
    KnifeInventoryLive = true,
    KnifeInventoryTest = true,
    CombineLive = true,
    CombineTest = true,
    SpinWheelMultiLive = true,
    SpinWheelMultiTest = true,
    PumpkinHuntLive = true,
    PumpkinHuntTest = true,
    PumpkinsLive = true,
    PumpkinsTest = true,
    SacrificeBoardsLive = true,
    SacrificeBoardsTest = true,
    CrateRollOverheadLive = true,
    CrateRollOverheadTest = true,
    PumpkinRollOverheadLive = true,
    PumpkinRollOverheadTest = true,
    SpinWheelKnifeOverheadLive = true,
    SpinWheelKnifeOverheadTest = true,
    ValleyNoAbilitiesLive = true,
    ValleyNoAbilitiesTest = true,
    HalloweenShopLive = true,
    HalloweenShopTest = true,
    GhostKeyTraderLive = true,
    GhostKeyTraderTest = true,
    CutscenesLive = true,
    CutscenesTest = true,
    FallenKingBossLive = true,
    FallenKingBossTest = true
};
local u2 = {
    oldui = "OldUI",
    olduireskin = "OldUIReskin",
    newgui = "NewGui",
    newui = "NewGui"
};

function u1.uiVersionOf(p3) -- Line: 194
    -- upvalues: u2 (copy)
    return u2[string.lower((string.gsub(tostring(p3), "[%s_%-]", "")))];
end;

local u4 = u2[string.lower((string.gsub(tostring(u1.UIVersion), "[%s_%-]", "")))];

if not u4 then
    warn((`FFlags.UIVersion "{u1.UIVersion}" is not OldUI, OldUIReskin or NewGui; using OldUI`));
    u4 = "OldUI";
end;

if RunService:IsStudio() and u1.StudioUIVersion then
    local v5;

    if u1.StudioUIVersion == true then
        v5 = u4;
    else
        v5 = u2[string.lower((string.gsub(tostring(u1.StudioUIVersion), "[%s_%-]", "")))];
    end;

    if v5 then
        u4 = v5;
    else
        warn((`FFlags.StudioUIVersion "{u1.StudioUIVersion}" is not true, OldUI, OldUIReskin or NewGui; ignored`));
    end;
end;

if u4 ~= "OldUIReskin" then
    warn((`FFlags: {u4} is no longer in the place; using OldUIReskin`));
    u4 = "OldUIReskin";
end;

u1.UISwitching = false;
u1.UIPerPlayer = false;
u1.UIVersion = u4;
u1.NewUI = not u1.UIPerPlayer and u4 == "NewGui";
local u6;

if RunService:IsClient() and RunService:IsRunning() then
    u6 = Players.LocalPlayer;
else
    u6 = nil;
end;

local u7 = nil;

local function settle(p8) -- Line: 236
    -- upvalues: u7 (ref)
    if not u7 then
        u7 = p8;
        warn((`Set as {p8} UI`));
    end;

    return u7;
end;

function u1.peekUIVersion() -- Line: 245
    -- upvalues: u7 (ref), u1 (copy), u6 (copy), u2 (copy), u4 (ref)
    if u7 then
        return u7;
    end;

    local v9;

    if u1.UIPerPlayer then
        v9 = u6;

        if v9 then
            local Attribute = u6:GetAttribute("UIVersion");
            v9 = u2[string.lower((string.gsub(tostring(Attribute), "[%s_%-]", "")))];
        end;
    else
        v9 = u4;
    end;

    if not (v9 and u6) then
        return v9 or nil;
    end;

    if not u7 then
        u7 = v9;
        warn((`Set as {v9} UI`));
    end;

    return u7;
end;

function u1.awaitUIVersion() -- Line: 256
    -- upvalues: u1 (copy), u6 (copy), u4 (ref), u7 (ref)
    local v10 = u1.peekUIVersion();

    if v10 or not u6 then
        return v10 or u4;
    end;

    local v11 = os.clock() + 10;
    local v12;

    repeat
        task.wait(0.05);
        v12 = u1.peekUIVersion();
    until v12 or v11 <= os.clock();

    if v12 or u7 then
        return v12 or u7;
    end;

    warn("FFlags: the server never stamped this player\'s UIVersion, so this device uses FFlags.UIVersion");
    local v13 = u4;

    if not u7 then
        u7 = v13;
        warn((`Set as {v13} UI`));
    end;

    return u7;
end;

local v14 = ({
    server929 = "Server929",
    claims = "Claims"
})[string.lower((string.gsub(tostring(u1.HitModel), "[%s_%-]", "")))];

if not v14 then
    warn((`FFlags.HitModel "{u1.HitModel}" is not Server929 or Claims; using Server929`));
    v14 = "Server929";
end;

u1.HitModel = v14;
u1.ServerHits = v14 == "Server929";
u1.LiveFlagsApply = game.GameId == 10764627709 and true or not u1.TestGameOverrides;
local v15;

if game.GameId == 10764627709 then
    v15 = u1.KnifeInventoryLive;
else
    v15 = u1.KnifeInventoryTest;
end;

if type(v15) ~= "boolean" then
    warn((`FFlags.KnifeInventory is {tostring(v15)}, not true or false; using false`));
end;

u1.KnifeInventory = v15 == true;
local v16 = false;
local v17;

if game.GameId == 10764627709 then
    v17 = u1.CombineLive;
else
    v17 = u1.CombineTest;
end;

if v17 == true then
    v16 = u1.KnifeInventory;
end;

u1.Combine = v16;
local v18;

if game.GameId == 10764627709 then
    v18 = u1.SpinWheelMultiLive;
else
    v18 = u1.SpinWheelMultiTest;
end;

u1.SpinWheelMulti = v18 == true;
local v19 = false;
local v20;

if game.GameId == 10764627709 then
    v20 = u1.PumpkinHuntLive;
else
    v20 = u1.PumpkinHuntTest;
end;

if v20 == true then
    v19 = u1.Map5Enabled == true;
end;

u1.PumpkinHunt = v19;
local v21;

if game.GameId == 10764627709 then
    v21 = u1.PumpkinsLive;
else
    v21 = u1.PumpkinsTest;
end;

u1.Pumpkins = v21 == true;
local v22 = false;
local v23;

if game.GameId == 10764627709 then
    v23 = u1.SacrificeBoardsLive;
else
    v23 = u1.SacrificeBoardsTest;
end;

if v23 == true then
    v22 = u1.PumpkinHunt;
end;

u1.SacrificeBoards = v22;
local v24;

if game.GameId == 10764627709 then
    v24 = u1.CrateRollOverheadLive;
else
    v24 = u1.CrateRollOverheadTest;
end;

u1.CrateRollOverhead = v24 == true;
local v25 = false;
local v26;

if game.GameId == 10764627709 then
    v26 = u1.PumpkinRollOverheadLive;
else
    v26 = u1.PumpkinRollOverheadTest;
end;

if v26 == true then
    v25 = u1.Pumpkins;
end;

u1.PumpkinRollOverhead = v25;
local v27;

if game.GameId == 10764627709 then
    v27 = u1.SpinWheelKnifeOverheadLive;
else
    v27 = u1.SpinWheelKnifeOverheadTest;
end;

u1.SpinWheelKnifeOverhead = v27 == true;
local v28;

if game.GameId == 10764627709 then
    v28 = u1.ValleyNoAbilitiesLive;
else
    v28 = u1.ValleyNoAbilitiesTest;
end;

u1.ValleyNoAbilities = v28 == true;
local v29;

if game.GameId == 10764627709 then
    v29 = u1.HalloweenShopLive;
else
    v29 = u1.HalloweenShopTest;
end;

u1.HalloweenShop = v29 == true;
local v30;

if game.GameId == 10764627709 then
    v30 = u1.GhostKeyTraderLive;
else
    v30 = u1.GhostKeyTraderTest;
end;

u1.GhostKeyTrader = v30 == true;
local v31;

if game.GameId == 10764627709 then
    v31 = u1.CutscenesLive;
else
    v31 = u1.CutscenesTest;
end;

u1.Cutscenes = v31 == true;
local v32;

if game.GameId == 10764627709 then
    v32 = u1.FallenKingBossLive;
else
    v32 = u1.FallenKingBossTest;
end;

u1.FallenKingBoss = v32 == true;
local v33;

if u1.ProServerStudioPreview == true then
    v33 = RunService:IsStudio();

    if v33 then
        if game.PlaceId == 130574217370467 then
            v33 = game.GameId ~= 10764627709;
        else
            v33 = false;
        end;
    end;
else
    v33 = false;
end;

u1.ProServerStudioPreview = v33;
local v34;

if u1.RankedStudioPreview == true then
    v34 = RunService:IsStudio();

    if v34 then
        if game.PlaceId == 130574217370467 then
            v34 = game.GameId ~= 10764627709;
        else
            v34 = false;
        end;
    end;
else
    v34 = false;
end;

u1.RankedStudioPreview = v34;
local v35;

if u1.PrivateServerStudioPreview == true then
    v35 = RunService:IsStudio() and RunService:IsServer();

    if v35 then
        if game.PlaceId == 130574217370467 and game.GameId ~= 10764627709 then
            v35 = game.PrivateServerId == "";
        else
            v35 = false;
        end;
    end;
else
    v35 = false;
end;

u1.PrivateServerStudioPreview = v35;
local v36;

if u1.NoUI == true then
    v36 = true;
elseif u1.NoUI == "Test" then
    v36 = game.PlaceId == 130574217370467;
else
    v36 = false;
end;

u1.NoUI = v36;

return table.freeze(u1);