 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Session = script.Parent.Parent:WaitForChild("Game"):WaitForChild("Session");
local u1 = {};

local function globalPause(p2) -- Line: 8
    -- upvalues: Session (copy)
    local v3;

    if Session:GetAttribute("GlobalPaused") == true and Session:GetAttribute("PauseExemptUserId") ~= p2.UserId then
        v3 = Session:GetAttribute("PauseFreesEveryone") ~= true;
    else
        v3 = false;
    end;

    return v3;
end;

function u1.movementReason(p4) -- Line: 14
    -- upvalues: Session (copy)
    local v5;

    if Session:GetAttribute("GlobalPaused") == true and Session:GetAttribute("PauseExemptUserId") ~= p4.UserId then
        v5 = Session:GetAttribute("PauseFreesEveryone") ~= true;
    else
        v5 = false;
    end;

    return v5 and "GlobalPause" or (Session:GetAttribute("MapChanging") == true and "MapChange" or (p4:GetAttribute("Spectating") == true and "Spectating" or (p4:GetAttribute("AlbieTalking") == true and "AlbieTalk" or (p4:GetAttribute("EventIntroActive") == true and "EventIntro" or (p4:GetAttribute("ProUnlockActive") == true and "ProUnlock" or (p4:GetAttribute("CupTrailerActive") == true and "CupTrailer" or (p4:GetAttribute("PumpkinAltarActive") == true and "PumpkinAltar" or (p4:GetAttribute("GhostTraderActive") == true and "GhostTrader" or (p4:GetAttribute("FallenKingSpoilsOpen") == true and "FallenKingSpoils" or (p4:GetAttribute("FallenKingAltarOpen") == true and "FallenKingAltar" or (p4:GetAttribute("BundleShowcaseOpen") == true and "BundleShowcase" or (p4:GetAttribute("CutsceneActive") == true and "Cutscene" or nil))))))))))));
end;

function u1.reason(p6) -- Line: 68
    -- upvalues: Session (copy), GuiService (copy), UserInputService (copy)
    if p6:GetAttribute("BundleShowcaseOpen") == true then
        return "BundleShowcase";
    end;

    if p6:GetAttribute("AlbieTalking") == true then
        return "AlbieTalk";
    end;

    if p6:GetAttribute("EventIntroActive") == true then
        return "EventIntro";
    end;

    if p6:GetAttribute("ProUnlockActive") == true then
        return "ProUnlock";
    end;

    if p6:GetAttribute("CupTrailerActive") == true then
        return "CupTrailer";
    end;

    if p6:GetAttribute("CutsceneActive") == true then
        return "Cutscene";
    end;

    if p6:GetAttribute("AdminPanelOpen") == true then
        return "AdminPanel";
    end;

    if p6:GetAttribute("HostPanelOpen") == true then
        return "HostPanel";
    end;

    if p6:GetAttribute("TournamentResultsOpen") == true then
        return "TournamentResults";
    end;

    if p6:GetAttribute("CombineOpen") == true then
        return "Combine";
    end;

    if p6:GetAttribute("PumpkinSacrificeOpen") == true then
        return "PumpkinSacrifice";
    end;

    if p6:GetAttribute("PumpkinsOpen") == true then
        return "Pumpkins";
    end;

    if p6:GetAttribute("GhostTraderActive") == true then
        return "GhostTrader";
    end;

    if p6:GetAttribute("FallenKingSpoilsOpen") == true then
        return "FallenKingSpoils";
    end;

    if p6:GetAttribute("BossDownedUntil") ~= nil then
        return "BossDowned";
    end;

    if p6:GetAttribute("FallenKingAltarOpen") == true then
        return "FallenKingAltar";
    end;

    if p6:GetAttribute("HalloweenShopOpen") == true then
        return "HalloweenShop";
    end;

    if p6:GetAttribute("OutbreakOpen") == true then
        return "Outbreak";
    end;

    if p6:GetAttribute("OutbreakNoticeOpen") == true then
        return "OutbreakNotice";
    end;

    if p6:GetAttribute("FallenKingOpen") == true then
        return "FallenKing";
    end;

    if p6:GetAttribute("PrivateInviteOpen") == true then
        return "PrivateInvite";
    end;

    if p6:GetAttribute("CrateOpen") == true then
        return "Crates";
    end;

    if p6:GetAttribute("StarterPackOpen") == true then
        return "StarterPack";
    end;

    if p6:GetAttribute("RankedLoadoutOpen") == true then
        return "RankedLoadout";
    end;

    if p6:GetAttribute("LikeRewardOpen") == true and p6:GetAttribute("InMatch") ~= true then
        return "LikeReward";
    end;

    if p6:GetAttribute("CreatorPanelOpen") == true then
        return "CreatorPanel";
    end;

    local v7;

    if Session:GetAttribute("GlobalPaused") == true and Session:GetAttribute("PauseExemptUserId") ~= p6.UserId then
        v7 = Session:GetAttribute("PauseFreesEveryone") ~= true;
    else
        v7 = false;
    end;

    if v7 or (p6:GetAttribute("GlobalWheelOpen") or p6:GetAttribute("GiveawayPickerOpen")) then
        return "GlobalWheel";
    end;

    if p6:GetAttribute("MapVoteOpen") == true then
        return "MapVote";
    end;

    if Session:GetAttribute("MapChanging") == true then
        return "MapChange";
    end;

    if p6:GetAttribute("EmoteWheelOpen") == true then
        return "Emotes";
    end;

    if p6:GetAttribute("AnnouncementComposerOpen") == true then
        return "AnnouncementComposer";
    end;

    if p6:GetAttribute("SettingsOpen") == true then
        return "Settings";
    end;

    if p6:GetAttribute("UpdateLogOpen") == true then
        return "UpdateLog";
    end;

    if p6:GetAttribute("Spectating") == true then
        return "Spectating";
    end;

    if p6:GetAttribute("FairPlayNoticeOpen") == true then
        return "FairPlayNotice";
    end;

    if p6:GetAttribute("ConnectionQualityOpen") == true and p6:GetAttribute("InMatch") ~= true then
        return "ConnectionQuality";
    end;

    if p6:GetAttribute("JourneyOpen") == true then
        return "Journey";
    end;

    if p6:GetAttribute("BalloonOfferOpen") == true and p6:GetAttribute("InMatch") ~= true then
        return "BalloonOffer";
    end;

    if p6:GetAttribute("ArmoryOpen") == true then
        return "Armory";
    end;

    if p6:GetAttribute("ServerBrowserOpen") == true and p6:GetAttribute("InMatch") ~= true then
        return "ServerBrowser";
    end;

    if p6:GetAttribute("AdminRefreshActive") == true then
        return "AdminRefresh";
    end;

    if p6:GetAttribute("AdminConsoleActive") == true then
        return "AdminConsole";
    end;

    if GuiService.MenuIsOpen then
        return "RobloxMenu";
    end;

    if UserInputService:GetFocusedTextBox() then
        return "TextInput";
    end;

    if p6:GetAttribute("ScreenPresentationActive") == true then
        return "ScreenTransition";
    end;

    if p6:GetAttribute("InMatch") == true then
        local Attribute = Session:GetAttribute("Phase");
        local v8;

        if Attribute == "SelectHero" and Session:GetAttribute("LeadUserId") == p6.UserId then
            v8 = true;
        elseif Attribute == "HeroChoice" then
            v8 = Session:GetAttribute("SelectedUserId") == p6.UserId;
        else
            v8 = false;
        end;

        if v8 and p6:GetAttribute("ReleaseCameraForUI") == true then
            return "Choice";
        end;

        if p6:GetAttribute("ChoiceSpotlightActive") == true and (Attribute == "SelectHero" or (Attribute == "HeroChoice" or Attribute == "ChoiceReveal")) then
            return "ChoiceCamera";
        end;
    end;

    return nil;
end;

local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local u9 = {};
local u10 = nil;

local function watchGui(p11) -- Line: 241
    -- upvalues: u10 (ref), u9 (copy)
    if u10 == p11 then
        return;
    end;

    u10 = p11;
    table.clear(u9);

    local function track(p12) -- Line: 247
        -- upvalues: u9 (ref)
        if p12:IsA("GuiButton") then
            u9[p12] = true;
        end;
    end;

    for _, descendant in p11:GetDescendants() do
        if descendant:IsA("GuiButton") then
            u9[descendant] = true;
        end;
    end;

    p11.DescendantAdded:Connect(track);
    p11.DescendantRemoving:Connect(function(p13) -- Line: 256
        -- upvalues: u9 (ref)
        u9[p13] = nil;
    end);
end;

function u1.cursorReason(p14) -- Line: 260
    -- upvalues: u1 (copy), FFlags (copy), watchGui (copy), u9 (copy)
    local v15 = u1.reason(p14);

    if v15 then
        return v15;
    end;

    if p14:GetAttribute("ReleaseCursorForControls") == true then
        return "CursorControls";
    end;

    local v16 = FFlags.peekUIVersion();

    if v16 == nil or v16 == "NewGui" then
        return nil;
    end;

    local v17 = p14:FindFirstChildOfClass("PlayerGui");

    if not v17 then
        return nil;
    end;

    watchGui(v17);

    for i in u9 do
        if i.Modal then
            local v18 = i;
            local v19 = true;

            while v18 and v18 ~= v17 do
                if v18:IsA("GuiObject") and not v18.Visible or v18:IsA("LayerCollector") and not v18.Enabled then
                    v19 = false;
                    break;
                end;

                v18 = v18.Parent;
            end;

            if v19 and v18 == v17 then
                return "InteractiveMenu";
            end;
        end;
    end;

    return nil;
end;

return u1;