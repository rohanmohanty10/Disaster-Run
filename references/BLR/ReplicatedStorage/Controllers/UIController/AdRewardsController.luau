  

repeat
    wait();
until game.Players.LocalPlayer;

repeat
    wait();
until game.Players.LocalPlayer.Character;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdService = game:GetService("AdService");
game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
game:GetService("MarketplaceService");
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
print("[CLIENT] AdRewardsController module V2.2 loaded. IsClient =", RunService:IsClient(), "time =", os.time());

local function dbg(...) -- Line: 19
    print("[AdDebug]", ...);
end;

local AdRewardEvents = ReplicatedStorage:WaitForChild("AdRewardEvents");
local LogEvent = AdRewardEvents:WaitForChild("LogEvent");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Settings = script:WaitForChild("Settings");
local GetRewardList = AdRewardEvents:WaitForChild("GetRewardList");
local Knit = require(ReplicatedStorage.Packages.Knit);
local environment = require(ReplicatedStorage.Shared.environment);
local v1 = Knit.CreateController({
    Name = "AdRewardsController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = {};
local u20 = {};
local u21 = nil;
local u22 = {};
local u23 = {};
local u24 = nil;
local u25 = 1;
local u26 = 0;
local u27 = 0;
local u28 = false;
local u29 = false;
local ABCheck = AdRewardEvents:WaitForChild("ABCheck");
local ShowAd = AdRewardEvents:WaitForChild("ShowAd");
local _ = environment.env == "Main";
local u30 = {
    [577138119223026] = 606832124276088,
    [689601838035453] = 713684787246445
};

local function resolvePlacementId(p31) -- Line: 99
    -- upvalues: environment (copy), u30 (copy)
    local v32 = tonumber(p31);

    if not v32 then
        return p31;
    end;

    if environment.env == "Main" then
        return v32;
    end;

    return u30[v32] or v32;
end;

local u33 = false;
local u34 = false;
local u35 = false;
local u36 = {
    Enum.AdAvailabilityResult.PlayerIneligible,
    Enum.AdAvailabilityResult.DeviceIneligible,
    Enum.AdAvailabilityResult.PublisherIneligible,
    Enum.AdAvailabilityResult.ExperienceIneligible
};

local function isIneligible(p37) -- Line: 122
    -- upvalues: u36 (copy)
    for _, v in ipairs(u36) do
        if p37 == v then
            return true;
        end;
    end;

    return false;
end;

local function checkForAds() -- Line: 131
    -- upvalues: dbg (copy), u35 (ref), u33 (ref), u34 (ref), AdService (copy), u36 (copy)
    dbg("checkForAds() called — InAd:", u35, "AdReady:", u33);

    if workspace:GetAttribute("DisableAds") == true then
        u33 = false;
        u34 = false;
        dbg("DisableAds attribute is true → forcing AdReady/AdEligible false");

        return;
    end;

    if u35 or u33 then
        return;
    end;

    local success, result = pcall(function() -- Line: 146
        -- upvalues: AdService (ref)
        return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo);
    end);

    if not success then
        u33 = false;
        warn("[Ads] GetAdAvailabilityNowAsync failed: ", result);

        return;
    end;

    if result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable then
        u33 = true;
    else
        u33 = false;
    end;

    local AdAvailabilityResult = result.AdAvailabilityResult;
    local v38 = false;

    for _, v in ipairs(u36) do
        if AdAvailabilityResult == v then
            v38 = true;
            break;
        end;
    end;

    if v38 then
        u34 = false;

        return;
    end;

    u34 = true;
end;

local function PlayRewardedAd(p39) -- Line: 168
    -- upvalues: u35 (ref), u33 (ref), ShowAd (copy)
    if u35 then
        return false;
    end;

    u35 = true;
    u33 = false;

    if p39 then
        p39 = tonumber(p39);
    end;

    ShowAd:FireServer(p39);
end;

local function sendTelemetry(p40: string, p41: number?, p42: table?) -- Line: 183
    -- upvalues: LogEvent (copy)
    LogEvent:FireServer({
        eventName = p40,
        value = p41 or 0,
        fields = p42 or {}
    });
end;

local function updateSetText(p43) -- Line: 195
    local SetTextTarget = p43.SetTextTarget;

    if not SetTextTarget then
        return;
    end;

    local success, _ = pcall(function() -- Line: 201
        -- upvalues: SetTextTarget (copy)
        return SetTextTarget.Text;
    end);

    if not success then
        return;
    end;

    local v44 = p43.SetTextStart or "";
    local v45 = p43.SetTextEnd or "";
    local v46 = p43.SetTextAmountString or "";
    local u47;

    if p43.SetTextShowNumber == true then
        u47 = v44 .. v46 .. v45;
    else
        u47 = v44 .. v45;
    end;

    pcall(function() -- Line: 220
        -- upvalues: SetTextTarget (copy), u47 (ref)
        SetTextTarget.Text = u47;
    end);
end;

local function applyVisibilityToButton(p48: any, p49: boolean) -- Line: 225
    -- upvalues: updateSetText (copy), AdService (copy), LogEvent (copy)
    local Button = p48.Button;

    if not (Button and Button.Parent) then
        return;
    end;

    local Visible = Button.Visible;
    Button.Visible = p49;
    local MoveFrame = p48.MoveFrame;
    local OriginalPos = p48.OriginalPos;
    local TargetPos = p48.TargetPos;

    if MoveFrame and (OriginalPos and TargetPos) then
        if p49 then
            if MoveFrame.Position ~= TargetPos then
                MoveFrame.Position = TargetPos;
            end;
        elseif MoveFrame.Position ~= OriginalPos then
            MoveFrame.Position = OriginalPos;
        end;
    end;

    local HideTarget = p48.HideTarget;
    local HideTargetProp = p48.HideTargetProp;
    local HideAutoShowOnLoad = p48.HideAutoShowOnLoad;

    if HideTarget and HideTargetProp then
        if p49 then
            if pcall(function() -- Line: 258
                -- upvalues: HideTarget (copy), HideTargetProp (copy)
                HideTarget[HideTargetProp] = false;
            end) and HideAutoShowOnLoad then
                pcall(function() -- Line: 262
                    -- upvalues: HideTarget (copy), HideTargetProp (copy)
                    HideTarget[HideTargetProp] = true;
                end);
            end;
        else
            pcall(function() -- Line: 267
                -- upvalues: HideTarget (copy), HideTargetProp (copy)
                HideTarget[HideTargetProp] = false;
            end);
        end;
    end;

    updateSetText(p48);

    if not Visible and p49 then
        local AdPlacementId = p48.AdPlacementId;
        task.spawn(function() -- Line: 278
            -- upvalues: AdService (ref), Button (copy), AdPlacementId (copy)
            pcall(function() -- Line: 279
                -- upvalues: AdService (ref), Button (ref), AdPlacementId (ref)
                AdService:RegisterAdOpportunityAsync(Button, AdPlacementId);
            end);
        end);
        LogEvent:FireServer({
            eventName = "WatchAdToClaim_Impression",
            value = 1,
            fields = {
                source = "WatchAdToClaimButton",
                placementId = AdPlacementId
            } or {}
        });
    end;
end;

local function evaluatePlacementVisibility(p50: string) -- Line: 298
    -- upvalues: u22 (ref), u23 (ref), u34 (ref), u33 (ref), applyVisibilityToButton (copy)
    local v51 = u22[p50];

    if not v51 then
        return;
    end;

    local Config = v51.Config;

    if not Config then
        return;
    end;

    local v52 = u23[p50];
    local v53 = v52 and (v52.claimCount or 0) or 0;
    local v54;

    if v52 then
        v54 = v52.firstClaimAt or nil;
    else
        v54 = nil;
    end;

    local v55 = v52 and v52.lastClaimAt or nil;
    local v56 = tonumber(Config.Limit) or 0;
    local v57 = tonumber(Config.Cooldown) or 0;
    local v58 = tonumber(Config.DaysToReset) or 0;
    local os_time_ret = os.time();
    local v59 = u34 and u33 and true or false;

    if v56 > 0 and v56 <= (v58 > 0 and (v54 and v58 * 86400 <= os_time_ret - v54) and 0 or v53) then
        v59 = false;
    end;

    for _, v in ipairs(v51.buttons) do
        local v60;

        if v59 and (v55 and (v57 > 0 and os_time_ret - v55 < v57)) then
            v60 = false;
        else
            v60 = v59;
        end;

        applyVisibilityToButton(v, v60);
    end;
end;

local function evaluateAllPlacementButtons() -- Line: 349
    -- upvalues: u22 (ref), evaluatePlacementVisibility (copy)
    for i, _ in pairs(u22) do
        evaluatePlacementVisibility(i);
    end;
end;

local function connectclaimbutton(p61: userdata) -- Line: 359
    -- upvalues: environment (copy), u30 (copy), u22 (ref), applyVisibilityToButton (copy), u34 (ref), u33 (ref), u35 (ref), u24 (ref), ShowAd (copy)
    local Parent = p61.Parent;

    if not (Parent and Parent:IsA("GuiButton")) then
        warn("WatchAdToClaim parent is not a GuiButton:", p61:GetFullName());

        return;
    end;

    local Attribute = p61:GetAttribute("AdPlacementID");
    local u62 = tonumber(Attribute);

    if u62 then
        if environment.env ~= "Main" then
            u62 = u30[u62] or u62;
        end;
    else
        u62 = Attribute;
    end;

    if not u62 then
        warn("WatchAdToClaim missing AdPlacementID:", p61:GetFullName());
    end;

    local v63 = u62 or Parent:GetFullName();
    local u64 = tostring(v63);
    local v65 = p61:GetAttribute("Amount") or 0;
    local Attribute2 = p61:GetAttribute("ClaimString");
    local v66 = p61:GetAttribute("ItemName") or "";
    local v67 = p61:GetAttribute("Cooldown") or 0;
    local v68 = p61:GetAttribute("DaysToReset") or 0;
    local v69 = p61:GetAttribute("Limit") or 0;
    local v70 = tostring(v65);
    local MoveFrame = p61:FindFirstChild("MoveFrame");
    local v71 = nil;
    local v72 = nil;
    local v73 = nil;

    if MoveFrame and MoveFrame:IsA("ObjectValue") then
        local Value = MoveFrame.Value;

        if Value and Value:IsA("GuiObject") then
            local Attribute3 = MoveFrame:GetAttribute("Pos");

            if typeof(Attribute3) == "UDim2" then
                v73 = Value.Position;
                v72 = Attribute3;
                v71 = Value;
            else
                warn("MoveFrame on", p61:GetFullName(), "missing or invalid Pos attribute");
            end;
        end;
    end;

    local HideFrame = p61:FindFirstChild("HideFrame");
    local v74 = nil;
    local v75 = nil;
    local v76 = false;
    local v77;

    if HideFrame and HideFrame:IsA("ObjectValue") then
        local Value = HideFrame.Value;

        if Value then
            if Value:IsA("ScreenGui") then
                v74 = Value;
                v75 = "Enabled";
            elseif Value:IsA("GuiObject") then
                v74 = Value;
                v75 = "Visible";
            else
                warn("HideFrame on", p61:GetFullName(), "has unsupported Value type:", Value.ClassName);
            end;
        end;

        v77 = HideFrame:GetAttribute("AutoShowOnLoad");

        if typeof(v77) ~= "boolean" then
            v77 = v76;
        end;
    else
        v77 = v76;
    end;

    local SetText = p61:FindFirstChild("SetText");
    local v78 = nil;
    local v79 = nil;
    local v80 = nil;
    local v81 = false;
    local v82, v83;

    if SetText and SetText:IsA("ObjectValue") then
        v78 = SetText.Value or v78;
        local Attribute3 = SetText:GetAttribute("Start_Text");

        if typeof(Attribute3) == "string" then
            v79 = Attribute3;
        end;

        v82 = SetText:GetAttribute("End_Text");

        if typeof(v82) ~= "string" then
            v82 = v80;
        end;

        v83 = SetText:GetAttribute("Show_Number");

        if typeof(v83) ~= "boolean" then
            v83 = v81;
        end;
    else
        v83 = v81;
        v82 = v80;
    end;

    if not u22[u64] then
        u22[u64] = {
            buttons = {},
            Config = {
                AdPlacementID = u62,
                ClaimString = Attribute2,
                ItemName = v66,
                Amount = v65,
                Cooldown = v67,
                DaysToReset = v68,
                Limit = v69
            }
        };
    end;

    local u84 = {
        Button = Parent,
        AdPlacementId = u62,
        MoveFrame = v71,
        OriginalPos = v73,
        TargetPos = v72,
        HideTarget = v74,
        HideTargetProp = v75,
        HideAutoShowOnLoad = v77,
        SetTextTarget = v78,
        SetTextStart = v79,
        SetTextEnd = v82,
        SetTextShowNumber = v83,
        SetTextAmountString = v70
    };
    table.insert(u22[u64].buttons, u84);
    applyVisibilityToButton(u84, false);
    Parent.MouseButton1Down:Connect(function() -- Line: 489
        -- upvalues: u34 (ref), u33 (ref), u35 (ref), u24 (ref), u64 (copy), u22 (ref), applyVisibilityToButton (ref), u84 (copy), u62 (copy), ShowAd (ref)
        if not u34 then
            warn("[Ads] Player not eligible for ads (placement button)");

            return;
        end;

        if not u33 then
            warn("[Ads] Ad not ready yet (placement button)");

            return;
        end;

        if u35 then
            return;
        end;

        u24 = {
            placementKey = u64,
            config = u22[u64].Config
        };
        applyVisibilityToButton(u84, false);
        local v85 = u62;

        if u35 then
            return;
        end;

        u35 = true;
        u33 = false;

        if v85 then
            v85 = tonumber(v85);
        end;

        ShowAd:FireServer(v85);
    end);
end;

local function findclaimbuttons() -- Line: 514
    -- upvalues: u20 (copy), u22 (ref), u23 (ref), PlayerGui (copy), connectclaimbutton (copy), u2 (ref), evaluatePlacementVisibility (copy)
    table.clear(u20);
    u22 = {};
    u23 = {};
    local Descendants = PlayerGui:GetDescendants();

    for _, v in pairs(Descendants) do
        if v.Name == "WatchAdToClaim" and v:IsA("Configuration") then
            table.insert(u20, v);
        end;
    end;

    for _, v in pairs(u20) do
        connectclaimbutton(v);
    end;

    for i, v in pairs(u22) do
        local u86 = tonumber(v.Config.DaysToReset) or 0;
        print("Placement information: ", i, v, u86, u22);
        local success, result = pcall(function() -- Line: 537
            -- upvalues: u2 (ref), i (copy), u86 (copy)
            return u2:GetPlacementState(tonumber(i), u86);
        end);

        if success and result then
            u23[i] = {
                claimCount = result.claimCount or 0,
                firstClaimAt = result.firstClaimAt,
                lastClaimAt = result.lastClaimAt
            };
        else
            warn("(Client) Failed to get placement state for", i, result);
        end;
    end;

    for i, _ in pairs(u22) do
        evaluatePlacementVisibility(i);
    end;
end;

local function updatecardstate() -- Line: 559
    -- upvalues: u18 (ref), u19 (ref), u9 (ref), u25 (ref), u33 (ref), u11 (ref)
    if not u18 or #u18 == 0 then
        return;
    end;

    if #u19 == 0 then
        return;
    end;

    local v87 = u9 and u9:FindFirstChild("UIPageLayout");
    local v88 = #u19 < u25;

    for i, v in ipairs(u19) do
        v.Visible = true;

        if v88 then
            v.Box.UIScale.Scale = 0.9;
            v.Box.Locked.Visible = true;
            v.Box.AdWatchClaim.Visible = false;
            v.Box.lockedbutton.Visible = true;
            v.Glow.Visible = false;
            v.Box.notready.Visible = false;
        elseif i == u25 then
            v.Box.UIScale.Scale = 1.1;
            v.Box.Locked.Visible = false;
            v.Box.AdWatchClaim.Visible = true;
            v.Box.lockedbutton.Visible = false;
            v.Glow.Visible = true;

            if u33 == false then
                v.Box.AdWatchClaim.Visible = false;
                v.Box.notready.Visible = true;
            else
                v.Box.AdWatchClaim.Visible = true;
                v.Box.notready.Visible = false;
            end;
        else
            v.Box.UIScale.Scale = 0.9;
            v.Box.Locked.Visible = true;
            v.Box.AdWatchClaim.Visible = false;
            v.Box.lockedbutton.Visible = true;
            v.Glow.Visible = false;
            v.Box.notready.Visible = false;
        end;
    end;

    if v87 then
        if v88 and u11 then
            u11.Box.Visible = true;
            v87:JumpTo(u11);

            return;
        end;

        if not v88 and u19[u25] then
            u11.Box.Visible = false;
            v87:JumpTo(u19[u25]);
        end;
    end;
end;

local function setupProgressNotches() -- Line: 628
    -- upvalues: u28 (ref), u26 (ref), u16 (ref)
    if u28 then
        return;
    end;

    if u26 <= 0 then
        return;
    end;

    local UIListLayout = u16:WaitForChild("UIListLayout");
    UIListLayout.Padding = UDim.new(1 / u26, 0);
    local notch = UIListLayout:WaitForChild("notch");

    for i = 1, u26 do
        local v89 = notch:Clone();
        v89.Name = "notch_" .. i;
        v89.Parent = u16;
        v89.Visible = true;
        local _ = i;
    end;

    u28 = true;
end;

local function setInitialProgressVisual() -- Line: 648
    -- upvalues: u26 (ref), u14 (ref), u15 (ref), u27 (ref)
    if u26 <= 0 then
        u14.Size = UDim2.new(0, 0, 1, 0);
        u15.Text = "0";

        return;
    end;

    local math_clamp_ret = math.clamp(u27 / u26, 0, 1);
    u14.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    local math_max_ret = math.max(u26 - u27, 0);
    u15.Text = tostring(math_max_ret);
end;

local function tweenProgressVisual() -- Line: 662
    -- upvalues: u26 (ref), u27 (ref), TweenService (copy), u14 (ref), u15 (ref)
    if u26 <= 0 then
        return;
    end;

    local math_clamp_ret = math.clamp(u27 / u26, 0, 1);
    local UDim2_new_ret = UDim2.new(math_clamp_ret, 0, 1, 0);
    TweenService:Create(u14, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2_new_ret
    }):Play();
    local math_max_ret = math.max(u26 - u27, 0);
    u15.Text = tostring(math_max_ret);
end;

local function initProgressUI(p90: number, p91: number) -- Line: 678
    -- upvalues: u26 (ref), u27 (ref), setupProgressNotches (copy), setInitialProgressVisual (copy)
    u26 = p90 or 0;
    u27 = p91 or 0;
    setupProgressNotches();
    setInitialProgressVisual();
end;

local function formatSecondsToHMS(p92: number) -- Line: 690
    local math_floor_ret = math.floor(p92 or 0);
    local math_max_ret = math.max(math_floor_ret, 0);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);

    return string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
end;

local function startEpochCountdown() -- Line: 698
    -- upvalues: u29 (ref), u4 (ref), u2 (ref), u17 (ref)
    if u29 then
        return;
    end;

    u29 = true;
    task.spawn(function() -- Line: 704
        -- upvalues: u4 (ref), u2 (ref), u17 (ref)
        while true do
            if not (u4 and u4.Parent) then
                return;
            end;

            local v93 = 0;
            local v94;

            if u2 then
                local v95;
                v95, v94 = pcall(function() -- Line: 712
                    -- upvalues: u2 (ref)
                    return u2:GetEpochTimeRemaining();
                end);

                if v95 then
                    if type(v94) ~= "number" then
                        v94 = v93;
                    end;
                else
                    v94 = v93;
                end;
            else
                v94 = v93;
            end;

            local os_time_ret = os.time();

            while true do
                if not (u4 and u4.Parent) then
                    return;
                end;

                local v96 = v94 - (os.time() - os_time_ret);
                local math_max_ret = math.max(v96, 0);

                if u17 then
                    local math_floor_ret = math.floor(math_max_ret or 0);
                    local math_max_ret2 = math.max(math_floor_ret, 0);
                    local math_floor_ret2 = math.floor(math_max_ret2 / 3600);
                    local math_floor_ret3 = math.floor(math_max_ret2 % 3600 / 60);
                    u17.Text = "Refresh In: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret2 % 60);
                end;

                if math_max_ret <= 0 then
                    break;
                end;

                task.wait(1);
            end;
        end;
    end);
end;

local function populatecards() -- Line: 751
    -- upvalues: u4 (ref), u18 (ref), u10 (ref), u21 (ref), u9 (ref), u19 (ref), u34 (ref), u33 (ref), u35 (ref), ShowAd (copy), u12 (ref), u2 (ref), u25 (ref), u26 (ref), u27 (ref), setupProgressNotches (copy), setInitialProgressVisual (copy), updatecardstate (copy)
    if not u4 then
        return;
    end;

    if not u18 or #u18 == 0 then
        warn("(AdReward) RewardList is empty");

        return;
    end;

    local v97 = #u18;

    local function createnewcard(p98, p99, p100) -- Line: 761
        -- upvalues: u10 (ref), u21 (ref), u9 (ref)
        if not u10 then
            warn("[CLIENT] createnewcard: CardTemplate nil");

            return nil;
        end;

        if not u21 then
            warn("[CLIENT] createnewcard: AdRewardCard nil");

            return nil;
        end;

        local v101 = tostring(p99.type or "Default");
        local v102 = tostring(p99.itemId or "Reward_" .. p98);
        local v103 = u21:CreateCard(v102, p98, u10, v101, tostring(p99.name or v102), p99.amount, p99.rainbow == true);

        if not v103 then
            warn("[CLIENT] CreateCard returned nil for index", p98);

            return nil;
        end;

        v103.Parent = p100 or u9;
        v103.LayoutOrder = p98;
        v103.Visible = true;

        return v103;
    end;

    for _, v in ipairs(u19) do
        if v and v.Destroy then
            v:Destroy();
        end;
    end;

    u19 = {};

    for i, v in ipairs(u18) do
        local v104 = createnewcard(i, v);

        if v104 then
            local AdWatchClaim = v104:WaitForChild("Box"):WaitForChild("AdWatchClaim");
            AdWatchClaim.MouseButton1Click:Connect(function() -- Line: 816
                -- upvalues: AdWatchClaim (copy), u34 (ref), u33 (ref), u35 (ref), ShowAd (ref)
                AdWatchClaim.hover.Visible = false;

                if not u34 then
                    warn("[Ads] Player not eligible for ads");

                    return;
                end;

                if u33 then
                    if not u35 then
                        local v105 = nil;

                        if u35 then
                            return;
                        end;

                        u35 = true;
                        u33 = false;

                        if v105 then
                            v105 = tonumber(v105);
                        end;

                        ShowAd:FireServer(v105);
                    end;

                    return;
                end;

                warn("[Ads] Ad not ready yet");
            end);
            AdWatchClaim.MouseEnter:Connect(function() -- Line: 833
                -- upvalues: AdWatchClaim (copy)
                AdWatchClaim.hover.Visible = true;
            end);
            AdWatchClaim.MouseLeave:Connect(function() -- Line: 837
                -- upvalues: AdWatchClaim (copy)
                AdWatchClaim.hover.Visible = false;
            end);
            table.insert(u19, i, v104);

            if i == v97 and u12 then
                local v106 = createnewcard(i, v, u12);

                if v106 then
                    v106.Size = UDim2.new(0.85, 0, 0.9, 0);
                    v106.Position = UDim2.new(0.05, 0, 0.01, 0);
                end;
            end;
        else
            warn("Failed to create card for reward index", i);
        end;
    end;

    local success, result = pcall(function() -- Line: 852
        -- upvalues: u2 (ref)
        return u2:GetCurrentIndex();
    end);

    if success and result then
        u25 = result;
    else
        warn("[CLIENT] GetCurrentIndex failed:", result);
        u25 = 1;
    end;

    if u18 then
        local v107 = #u18;
        local math_clamp_ret = math.clamp(u25 - 1, 0, v107);
        u26 = v107 or 0;
        u27 = math_clamp_ret or 0;
        setupProgressNotches();
        setInitialProgressVisual();
    end;

    updatecardstate();
end;

local function bouncelooptween(u108) -- Line: 875
    -- upvalues: TweenService (copy)
    task.spawn(function() -- Line: 876
        -- upvalues: u108 (copy), TweenService (ref)
        local Position = u108.Position;

        while u108.Visible and u108.Parent do
            local v109 = TweenService:Create(u108, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = Position + UDim2.new(0, 0, -0.05, 0)
            });
            local v110 = TweenService:Create(u108, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = Position + UDim2.new(0, 0, 0.02, 0)
            });
            local v111 = TweenService:Create(u108, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = Position
            });
            v109:Play();
            v109.Completed:Wait();

            if not (u108.Visible and u108.Parent) then
                break;
            end;

            v110:Play();
            v110.Completed:Wait();

            if not (u108.Visible and u108.Parent) then
                break;
            end;

            v111:Play();
            v111.Completed:Wait();
            task.wait(2);
        end;
    end);
end;

local function convertshop() -- Line: 892
    -- upvalues: u4 (ref), u5 (ref), u6 (copy), u7 (ref), LocalPlayer (copy), TweenService (copy)
    u4.Visible = true;
    u5.CanvasSize = UDim2.new(4.8, 0, 0, 0);

    for _, v in pairs(u6) do
        if v then
            v.Position = v.Position - UDim2.new(0, 0, 0.05, 0);
        end;
    end;

    u7.Visible = true;

    local function updateShopOffsets() -- Line: 905
        -- upvalues: u5 (ref)
        local X = u5.AbsoluteCanvasSize.X;

        if u5:FindFirstChild("Cash") then
            u5.Cash:SetAttribute("Pos", X * 0.543);
        end;

        if u5:FindFirstChild("Passes") then
            u5.Passes:SetAttribute("Pos", X * 0.1);
        end;
    end;

    updateShopOffsets();
    u5:GetPropertyChangedSignal("CanvasSize"):Connect(function() -- Line: 919
        -- upvalues: updateShopOffsets (copy)
        updateShopOffsets();
    end);
    u5:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 923
        -- upvalues: updateShopOffsets (copy)
        task.defer(updateShopOffsets);
    end);
    local Shop = LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Shop");
    local u112 = Shop and Shop.Button:FindFirstChild("New");

    if u112 then
        u112.Visible = true;
        local u113 = nil;
        task.spawn(function() -- Line: 876
            -- upvalues: u112 (copy), TweenService (ref)
            local Position = u112.Position;

            while u112.Visible and u112.Parent do
                local v114 = TweenService:Create(u112, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Position + UDim2.new(0, 0, -0.05, 0)
                });
                local v115 = TweenService:Create(u112, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = Position + UDim2.new(0, 0, 0.02, 0)
                });
                local v116 = TweenService:Create(u112, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Position
                });
                v114:Play();
                v114.Completed:Wait();

                if not (u112.Visible and u112.Parent) then
                    break;
                end;

                v115:Play();
                v115.Completed:Wait();

                if not (u112.Visible and u112.Parent) then
                    break;
                end;

                v116:Play();
                v116.Completed:Wait();
                task.wait(2);
            end;
        end);
        u113 = Shop.Button.MouseButton1Down:Connect(function() -- Line: 938
            -- upvalues: u112 (copy), u113 (ref)
            u112.Visible = false;
            u113:Disconnect();
        end);
    end;

    local New = u7.Bttn:FindFirstChild("New");

    if New then
        New.Visible = true;
        task.spawn(function() -- Line: 876
            -- upvalues: New (copy), TweenService (ref)
            local Position = New.Position;

            while New.Visible and New.Parent do
                local v117 = TweenService:Create(New, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Position + UDim2.new(0, 0, -0.05, 0)
                });
                local v118 = TweenService:Create(New, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = Position + UDim2.new(0, 0, 0.02, 0)
                });
                local v119 = TweenService:Create(New, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = Position
                });
                v117:Play();
                v117.Completed:Wait();

                if not (New.Visible and New.Parent) then
                    break;
                end;

                v118:Play();
                v118.Completed:Wait();

                if not (New.Visible and New.Parent) then
                    break;
                end;

                v119:Play();
                v119.Completed:Wait();
                task.wait(2);
            end;
        end);
        local u120 = nil;
        u120 = u7.Bttn.MouseButton1Down:Connect(function() -- Line: 953
            -- upvalues: New (copy), u120 (ref)
            New.Visible = false;
            u120:Disconnect();
        end);
    end;
end;

local function InitRewardAdListener() -- Line: 964
    -- upvalues: ShowAd (copy), u35 (ref), u33 (ref), u24 (ref), u2 (ref), u23 (ref), LogEvent (copy), evaluatePlacementVisibility (copy), u26 (ref), u25 (ref), u27 (ref), tweenProgressVisual (copy), updatecardstate (copy), checkForAds (copy), u22 (ref)
    ShowAd.OnClientEvent:Connect(function(p121, p122) -- Line: 965
        -- upvalues: u35 (ref), u33 (ref), u24 (ref), u2 (ref), u23 (ref), LogEvent (ref), evaluatePlacementVisibility (ref), u26 (ref), u25 (ref), u27 (ref), tweenProgressVisual (ref), updatecardstate (ref), checkForAds (ref), u22 (ref)
        u35 = false;
        u33 = false;
        local v123 = u24;
        u24 = nil;

        if v123 then
            local placementKey = v123.placementKey;
            local config = v123.config;

            if p121 and p122 == Enum.ShowAdResult.ShowCompleted then
                local success, result = pcall(function() -- Line: 977
                    -- upvalues: u2 (ref), placementKey (copy), config (copy)
                    return u2:ClaimPlacementReward(tonumber(placementKey), config.ClaimString, config.ItemName, config.Amount, config.DaysToReset, config.Limit, config.Cooldown);
                end);

                if success and result then
                    u23[placementKey] = {
                        claimCount = result.claimCount or 0,
                        firstClaimAt = result.firstClaimAt,
                        lastClaimAt = result.lastClaimAt
                    };
                    local v124 = result.claimCount or 0;
                    local v125 = tonumber(placementKey) or 0;

                    if v124 > 0 then
                        LogEvent:FireServer({
                            eventName = "WatchAdToClaim_Claim",
                            value = 1,
                            fields = {
                                placementId = v125,
                                claimDepth = v124,
                                claimDepthLabel = string.format("Claim_%d", v124)
                            } or {}
                        });
                    end;

                    evaluatePlacementVisibility(placementKey);
                    local v126 = tonumber(config.Cooldown) or 0;

                    if v126 > 0 then
                        task.delay(v126, function() -- Line: 1016
                            -- upvalues: evaluatePlacementVisibility (ref), placementKey (copy)
                            evaluatePlacementVisibility(placementKey);
                        end);
                    end;
                else
                    warn("(Client) ClaimPlacementReward failed for", placementKey, result);
                end;
            end;
        elseif p121 and p122 == Enum.ShowAdResult.ShowCompleted then
            local v127 = nil;
            local v128 = nil;
            local v129 = nil;
            local v130, v131, v132, v133 = pcall(function() -- Line: 1028
                -- upvalues: u2 (ref)
                return u2:ClaimNextReward();
            end);

            if v130 then
                v129 = v133;
                v128 = v132;
                v127 = v131;
            else
                warn("[CLIENT] ERROR calling ClaimNextReward:", v131);
            end;

            if v127 and v128 then
                LogEvent:FireServer({
                    eventName = "AdRewardShop_Claim",
                    value = 1,
                    fields = {
                        claimDepth = v127,
                        claimDepthLabel = string.format("Claim_%d", v127),
                        itemId = v128,
                        totalRewards = u26
                    } or {}
                });
                u25 = v129 or v127;

                if u26 > 0 and u27 < u26 then
                    u27 = math.clamp(u27 + 1, 0, u26);
                    tweenProgressVisual();
                end;

                updatecardstate();
            else
                warn("(Client) Ad reward claim failed; claimIndex =", v127, "itemId =", v128, "nextIndex =", v129);
            end;
        end;

        task.spawn(function() -- Line: 1073
            -- upvalues: checkForAds (ref), u22 (ref), evaluatePlacementVisibility (ref), updatecardstate (ref)
            checkForAds();

            for i, _ in pairs(u22) do
                evaluatePlacementVisibility(i);
            end;

            updatecardstate();
        end);
    end);
end;

local function boot(u134, u135) -- Line: 1085
    -- upvalues: dbg (copy), PlayerGui (copy), u3 (ref), u5 (ref), u4 (ref), u17 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u6 (copy), u7 (ref), u21 (ref), Knit (copy), u2 (ref), checkForAds (copy), Settings (copy), convertshop (copy), findclaimbuttons (copy), u22 (ref), evaluatePlacementVisibility (copy), updatecardstate (copy), GetRewardList (copy), u18 (ref), populatecards (copy), u29 (ref), ShowAd (copy), u35 (ref), u33 (ref), u24 (ref), u23 (ref), LogEvent (copy), u26 (ref), u25 (ref), u27 (ref), tweenProgressVisual (copy)
    print("[CLIENT] AdRewardsController.boot() starting at", os.time());
    dbg("boot args — showevent:", u134, "showshop:", u135);
    task.wait(1);
    dbg("boot post task.wait(1) — fetching playerGui children");
    local TESTBUTTON = PlayerGui:WaitForChild("TESTBUTTON");
    local TextButton = TESTBUTTON:WaitForChild("TextButton");
    local TextButton2 = TESTBUTTON:WaitForChild("TextButton2");
    local TextButton3 = TESTBUTTON:WaitForChild("TextButton3");
    u3 = PlayerGui:FindFirstChild("Shop");
    local v136 = u3 and u3:FindFirstChild("BG");
    dbg("ShopUI:", u3, "BG:", v136);

    if not (u3 and v136) then
        warn("(AdReward) No Shop UI Found — BAILING");

        return;
    end;

    u5 = v136:WaitForChild("ShopUI"):WaitForChild("Inside");
    u4 = u5:FindFirstChild("Rewards");
    dbg("RewardUI:", u4);

    if not u4 then
        warn("(AdReward) No Reward UI Found — BAILING");

        return;
    end;

    u17 = u4:FindFirstChild("CountdownTimer");
    u8 = u4:WaitForChild("Box");
    u9 = u8:WaitForChild("CardContainer");
    u10 = u9.UIPageLayout:WaitForChild("CardTemplate");
    u11 = u9:FindFirstChild("EndCard");
    local FinalTier = u8:FindFirstChild("FinalTier");

    if FinalTier then
        u12 = FinalTier:FindFirstChild("Free");
    end;

    u13 = u4:WaitForChild("Progress");
    u14 = u13:WaitForChild("Fill");
    u15 = u13:WaitForChild("Counter"):WaitForChild("count");
    u16 = u13:WaitForChild("barnotches");
    u6[1] = v136:FindFirstChild("PacksTabFrame");
    u6[2] = v136:FindFirstChild("PassesTabFrame");
    u6[3] = v136:FindFirstChild("CashTabFrame");
    u7 = v136:FindFirstChild("RewardsTabFrame");
    dbg("RewardButton:", u7);

    if not u7 then
        warn("(AdReward) No Reward Button Found — BAILING");

        return;
    end;

    u21 = Knit.GetController("AdRewardCard");
    local success, result = pcall(function() -- Line: 1145
        -- upvalues: Knit (ref)
        return Knit.GetService("AdRewardsService");
    end);
    task.spawn(function() -- Line: 1149
        -- upvalues: dbg (ref), success (copy), result (copy), u2 (ref), checkForAds (ref), Settings (ref), u135 (copy), u134 (copy), convertshop (ref), findclaimbuttons (ref), u22 (ref), evaluatePlacementVisibility (ref), updatecardstate (ref), GetRewardList (ref), u18 (ref), populatecards (ref), u17 (ref), u29 (ref), u4 (ref)
        dbg("Deferred boot task started, waiting 28s");
        wait(28);
        dbg("28s elapsed; AdRewardsService okSvc =", success);

        if success then
            u2 = result;
        else
            warn("[CLIENT] Knit.GetService(\'AdRewardsService\') threw:", result);
        end;

        checkForAds();
        dbg("Show_Shop attr:", Settings:GetAttribute("Show_Shop"), "showshop param:", u135);
        dbg("Show_Event_Buttons attr:", Settings:GetAttribute("Show_Event_Buttons"), "showevent param:", u134);

        if Settings:GetAttribute("Show_Shop") == true and u135 == true then
            dbg("Calling convertshop()");
            convertshop();
            dbg("convertshop() returned");
        else
            dbg("Skipping convertshop — gate failed");
        end;

        if Settings:GetAttribute("Show_Event_Buttons") == true and u134 == true then
            print("Checking for claim buttons");
            dbg("Calling findclaimbuttons()");
            findclaimbuttons();
            dbg("findclaimbuttons() returned");
        else
            dbg("Skipping findclaimbuttons — gate failed");
        end;

        task.spawn(function() -- Line: 1185
            -- upvalues: checkForAds (ref), u22 (ref), evaluatePlacementVisibility (ref), updatecardstate (ref)
            while true do
                task.wait(30);
                checkForAds();

                for i, _ in pairs(u22) do
                    evaluatePlacementVisibility(i);
                end;

                updatecardstate();
            end;
        end);

        if Settings:GetAttribute("Show_Shop") == true then
            local success2, result2 = pcall(function() -- Line: 1195
                -- upvalues: GetRewardList (ref)
                return GetRewardList:InvokeServer();
            end);

            if success2 and result2 then
                u18 = result2;
                populatecards();
            else
                warn("(AdReward) Failed to fetch RewardList from GetRewardListEvent:", result2);
            end;
        end;

        if u2 and u17 then
            if u29 then
                return;
            end;

            u29 = true;
            task.spawn(function() -- Line: 704
                -- upvalues: u4 (ref), u2 (ref), u17 (ref)
                while true do
                    if not (u4 and u4.Parent) then
                        return;
                    end;

                    local v137 = 0;
                    local v138;

                    if u2 then
                        local v139;
                        v139, v138 = pcall(function() -- Line: 712
                            -- upvalues: u2 (ref)
                            return u2:GetEpochTimeRemaining();
                        end);

                        if v139 then
                            if type(v138) ~= "number" then
                                v138 = v137;
                            end;
                        else
                            v138 = v137;
                        end;
                    else
                        v138 = v137;
                    end;

                    local os_time_ret = os.time();

                    while true do
                        if not (u4 and u4.Parent) then
                            return;
                        end;

                        local v140 = v138 - (os.time() - os_time_ret);
                        local math_max_ret = math.max(v140, 0);

                        if u17 then
                            local math_floor_ret = math.floor(math_max_ret or 0);
                            local math_max_ret2 = math.max(math_floor_ret, 0);
                            local math_floor_ret2 = math.floor(math_max_ret2 / 3600);
                            local math_floor_ret3 = math.floor(math_max_ret2 % 3600 / 60);
                            u17.Text = "Refresh In: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret2 % 60);
                        end;

                        if math_max_ret <= 0 then
                            break;
                        end;

                        task.wait(1);
                    end;
                end;
            end);
        end;
    end);
    ShowAd.OnClientEvent:Connect(function(p141, p142) -- Line: 965
        -- upvalues: u35 (ref), u33 (ref), u24 (ref), u2 (ref), u23 (ref), LogEvent (ref), evaluatePlacementVisibility (ref), u26 (ref), u25 (ref), u27 (ref), tweenProgressVisual (ref), updatecardstate (ref), checkForAds (ref), u22 (ref)
        u35 = false;
        u33 = false;
        local v143 = u24;
        u24 = nil;

        if v143 then
            local placementKey = v143.placementKey;
            local config = v143.config;

            if p141 and p142 == Enum.ShowAdResult.ShowCompleted then
                local success2, result2 = pcall(function() -- Line: 977
                    -- upvalues: u2 (ref), placementKey (copy), config (copy)
                    return u2:ClaimPlacementReward(tonumber(placementKey), config.ClaimString, config.ItemName, config.Amount, config.DaysToReset, config.Limit, config.Cooldown);
                end);

                if success2 and result2 then
                    u23[placementKey] = {
                        claimCount = result2.claimCount or 0,
                        firstClaimAt = result2.firstClaimAt,
                        lastClaimAt = result2.lastClaimAt
                    };
                    local v144 = result2.claimCount or 0;
                    local v145 = tonumber(placementKey) or 0;

                    if v144 > 0 then
                        LogEvent:FireServer({
                            eventName = "WatchAdToClaim_Claim",
                            value = 1,
                            fields = {
                                placementId = v145,
                                claimDepth = v144,
                                claimDepthLabel = string.format("Claim_%d", v144)
                            } or {}
                        });
                    end;

                    evaluatePlacementVisibility(placementKey);
                    local v146 = tonumber(config.Cooldown) or 0;

                    if v146 > 0 then
                        task.delay(v146, function() -- Line: 1016
                            -- upvalues: evaluatePlacementVisibility (ref), placementKey (copy)
                            evaluatePlacementVisibility(placementKey);
                        end);
                    end;
                else
                    warn("(Client) ClaimPlacementReward failed for", placementKey, result2);
                end;
            end;
        elseif p141 and p142 == Enum.ShowAdResult.ShowCompleted then
            local v147 = nil;
            local v148 = nil;
            local v149 = nil;
            local v150, v151, v152, v153 = pcall(function() -- Line: 1028
                -- upvalues: u2 (ref)
                return u2:ClaimNextReward();
            end);

            if v150 then
                v149 = v153;
                v148 = v152;
                v147 = v151;
            else
                warn("[CLIENT] ERROR calling ClaimNextReward:", v151);
            end;

            if v147 and v148 then
                LogEvent:FireServer({
                    eventName = "AdRewardShop_Claim",
                    value = 1,
                    fields = {
                        claimDepth = v147,
                        claimDepthLabel = string.format("Claim_%d", v147),
                        itemId = v148,
                        totalRewards = u26
                    } or {}
                });
                u25 = v149 or v147;

                if u26 > 0 and u27 < u26 then
                    u27 = math.clamp(u27 + 1, 0, u26);
                    tweenProgressVisual();
                end;

                updatecardstate();
            else
                warn("(Client) Ad reward claim failed; claimIndex =", v147, "itemId =", v148, "nextIndex =", v149);
            end;
        end;

        task.spawn(function() -- Line: 1073
            -- upvalues: checkForAds (ref), u22 (ref), evaluatePlacementVisibility (ref), updatecardstate (ref)
            checkForAds();

            for i, _ in pairs(u22) do
                evaluatePlacementVisibility(i);
            end;

            updatecardstate();
        end);
    end);
    TextButton.MouseButton1Click:Connect(function() -- Line: 1214
        -- upvalues: u35 (ref), u33 (ref), ShowAd (ref)
        if not u35 then
            local v154 = nil;

            if u35 then
                return;
            end;

            u35 = true;
            u33 = false;

            if v154 then
                v154 = tonumber(v154);
            end;

            ShowAd:FireServer(v154);
        end;
    end);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 1220
        -- upvalues: convertshop (ref)
        convertshop();
    end);
    TextButton3.MouseButton1Click:Connect(function() -- Line: 1224
        -- upvalues: u2 (ref)
        if not u2 then
            warn("[CLIENT] AdRewardsService is nil when trying to AwardSpecialCurrency");

            return;
        end;

        local success2, result2 = pcall(function() -- Line: 1229
            -- upvalues: u2 (ref)
            return u2:AwardSpecialCurrency("EventTokens", 1);
        end);

        if not success2 then
            warn("[CLIENT] ERROR calling AwardSpecialCurrency:", result2);
        end;
    end);
end;

function v1.KnitStart(p155) -- Line: 1238
    -- upvalues: dbg (copy), ABCheck (copy), boot (copy)
    dbg("KnitStart called", "time:", os.time());
    local v156 = script:FindFirstChild("ServiceActive") and script.ServiceActive.Value;
    local v157 = ABCheck:InvokeServer("AB_rewarded_video_ad_Bluelock_Event");
    local v158 = ABCheck:InvokeServer("AB_rewarded_video_ad_Bluelock_RewardShop");
    print("[Ad Rewards Client] AB ALLOWED: ", v157, v158);
    dbg("AB results — showevent:", v157, "showshop:", v158);
    dbg("ServiceActive value:", v156);

    if v156 ~= true or not (v157 or v158) then
        dbg("BOOT SKIPPED — serviceActive:", v156, "showevent:", v157, "showshop:", v158);
        print("Shop V.2 disabled (ServiceActive false or missing)");

        return;
    end;

    print("(Client) Ad Service Test Booted Successfully");
    dbg("Calling boot()");
    boot(v157, v158);
    dbg("boot() returned synchronously (deferred work continues in background)");
end;

return v1;