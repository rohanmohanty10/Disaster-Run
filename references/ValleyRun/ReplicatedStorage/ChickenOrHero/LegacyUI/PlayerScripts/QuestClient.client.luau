 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Palette = Skin.Palette;
local SkinCatalog = require(ChickenOrHero.Weapons:WaitForChild("SkinCatalog"));
local Icon = require(script.Parent.TopbarPlus.Icon);
Icon.highlightKey = false;
local QuestEvent = ChickenOrHero.Quests:WaitForChild("QuestEvent");
local QuestNotice = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("QuestNotice"));
local Icon2 = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn")).Icon;
local u1 = Panels.screen(LocalPlayer, "ValleyQuests", 74);
u1.IgnoreGuiInset = true;
u1.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;
local u2, v3, v4 = Panels.panel(u1, "QuestPanel", 560, 600);
local u5 = Icon.new():setName("ValleyQuests"):setLabel("QUESTS"):align("Left");

local function label(p6, p7, p8, p9, p10, p11, p12, p13, p14) -- Line: 30
    -- upvalues: Panels (copy)
    local v15 = Panels.text(p6, p7, p8, p9, p10, p11, p12, 16, p13);
    v15.TextScaled = true;
    v15.TextWrapped = false;
    v15.TextTruncate = Enum.TextTruncate.AtEnd;

    if p14 then
        v15.Font = Enum.Font.GothamBold;
    end;

    return v15;
end;

local u16 = Panels.text(v3, "Heading", "QUESTS", 22, 18, 445, 36, 16, Panels.Paper);
u16.TextScaled = true;
u16.TextWrapped = false;
u16.TextTruncate = Enum.TextTruncate.AtEnd;
u16.Font = Enum.Font.GothamBold;
local u17 = Panels.text(v3, "Timer", "Checking quests...", 22, 63, 516, 23, 16, Panels.Gold);
u17.TextScaled = true;
u17.TextWrapped = false;
u17.TextTruncate = Enum.TextTruncate.AtEnd;
u17.Font = Enum.Font.GothamBold;
local u18 = Panels.text(v3, "Subtitle", "", 22, 88, 516, 24, 16, Panels.Muted);
u18.TextScaled = true;
u18.TextWrapped = false;
u18.TextTruncate = Enum.TextTruncate.AtEnd;
local u19 = Panels.make("ScrollingFrame", v3, "QuestList", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ClipsDescendants = true,
    Position = UDim2.fromOffset(16, 123),
    Size = UDim2.fromOffset(528, 413),
    ScrollBarImageColor3 = Panels.Gold,
    CanvasSize = UDim2.fromOffset(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y
});
Skin.scroll(u19);
local u20 = Panels.text(v3, "Footer", "", 22, 551, 516, 25, 16, Panels.Muted);
u20.TextScaled = true;
u20.TextWrapped = false;
u20.TextTruncate = Enum.TextTruncate.AtEnd;
local u21 = nil;
local u22 = nil;
local u23 = 0;
local u24 = false;
local u25 = true;
local u26 = 1;
local u27 = nil;
local u28 = {};
local u29 = {};
local u30 = false;
local u31 = 0;
local u32 = nil;
local u33 = 0;
local u34 = nil;
local u35 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(190, 150, 255);
local u36 = nil;
local u37 = {};
local u38 = {};
local u39 = {};

local function connect(p40, p41) -- Line: 78
    -- upvalues: u37 (copy)
    local v42 = p40:Connect(p41);
    table.insert(u37, v42);

    return v42;
end;

local function refreshQuestIcon() -- Line: 84
    -- upvalues: UserInputService (copy), u5 (copy)
    local v43 = UserInputService.PreferredInput == Enum.PreferredInput.Touch;
    u5:setLabel(v43 and "" or "QUESTS");

    if v43 then
        u5:setImage("rbxassetid://109697384592866");

        return;
    end;

    u5:modifyTheme({ "IconImage", "Image", "" });
end;

local v44 = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(refreshQuestIcon);
table.insert(u37, v44);
refreshQuestIcon();
local BindableEvent = Instance.new("BindableEvent");
local u45 = false;

local function updateNotice() -- Line: 100
    -- upvalues: QuestNotice (copy), LocalPlayer (copy), u21 (ref), u45 (ref), u5 (copy), BindableEvent (copy)
    local v46 = QuestNotice.show(LocalPlayer, u21);

    if v46 == u45 then
        return;
    end;

    u45 = v46;

    if v46 then
        u5:notify(BindableEvent.Event);

        return;
    end;

    BindableEvent:Fire();
end;

local v48 = u5.noticeChanged:Connect(function() -- Line: 113
    -- upvalues: u5 (copy)
    task.defer(function() -- Line: 114
        -- upvalues: u5 (ref)
        local notice = u5.notice;
        local v47;

        if notice then
            v47 = notice:FindFirstChild("NoticeLabel");
        else
            v47 = notice;
        end;

        if v47 then
            notice.BackgroundColor3 = Color3.fromRGB(235, 45, 45);
            v47.Text = "!";
            v47.TextColor3 = Color3.new(1, 1, 1);
            v47.Font = Enum.Font.GothamBlack;
        end;
    end);
end);
table.insert(u37, v48);

for _, v in { "SettingsLoaded", "QuestsSeen", "QuestsSeenKey" } do
    local v49 = LocalPlayer:GetAttributeChangedSignal(v):Connect(updateNotice);
    table.insert(u37, v49);
end;

local function action(p50, p51) -- Line: 129
    -- upvalues: QuestEvent (copy), u25 (ref), u36 (ref)
    QuestEvent:FireServer(p50, p51);
    task.delay(3, function() -- Line: 132
        -- upvalues: u25 (ref), u36 (ref)
        if u25 then
            u36();
        end;
    end);
end;

local function celebrate() -- Line: 139
    -- upvalues: TweenService (copy), u16 (copy), Panels (copy), u25 (ref), u1 (copy)
    TweenService:Create(u16, TweenInfo.new(0.18), {
        TextColor3 = Panels.Gold
    }):Play();
    task.delay(1.2, function() -- Line: 141
        -- upvalues: u25 (ref), TweenService (ref), u16 (ref), Panels (ref)
        if u25 then
            TweenService:Create(u16, TweenInfo.new(0.5), {
                TextColor3 = Panels.Paper
            }):Play();
        end;
    end);
    local GameAudio = game:GetService("SoundService"):FindFirstChild("GameAudio");

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("04_UI");
    end;

    if GameAudio then
        GameAudio = GameAudio:FindFirstChild("Notice");
    end;

    if GameAudio and GameAudio:IsA("Sound") then
        local v52 = GameAudio:Clone();
        v52.Volume = 0.35;
        v52.Looped = false;
        v52.Parent = u1;
        v52:Play();
        game:GetService("Debris"):AddItem(v52, 3);
    end;
end;

local function skipPrice(u53) -- Line: 159
    -- upvalues: u28 (copy), u39 (copy), u29 (copy), MarketplaceService (copy), u25 (ref), u21 (ref), u27 (ref)
    if not (u28[u53] ~= nil and (u28[u53] ~= false or os.clock() < (u39[u53] or 0)) or u29[u53]) then
        u29[u53] = true;
        task.spawn(function() -- Line: 167
            -- upvalues: MarketplaceService (ref), u53 (copy), u28 (ref), u29 (ref), u39 (ref), u25 (ref), u21 (ref), u27 (ref)
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u53, Enum.InfoType.Product);
            local v54;

            if success and (type(result) == "table" and (result.IsForSale and type(result.PriceInRobux) == "number")) then
                v54 = result.PriceInRobux or false;
            else
                v54 = false;
            end;

            u28[u53] = v54;
            u29[u53] = nil;
            u39[u53] = os.clock() + 30;

            if u25 and u21 then
                u27();
            end;
        end);
    end;

    return u28[u53];
end;

local function countdown(p55) -- Line: 185
    local math_floor_ret = math.floor(p55);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 86400);
    local math_floor_ret3 = math.floor(math_max_ret % 86400 / 3600);
    local math_floor_ret4 = math.floor(math_max_ret % 3600 / 60);

    if math_floor_ret2 > 0 then
        return string.format("%dd %dh %dm", math_floor_ret2, math_floor_ret3, math_floor_ret4);
    end;

    if math_floor_ret3 > 0 then
        return string.format("%dh %dm", math_floor_ret3, math_floor_ret4);
    end;

    return string.format("%dm %02ds", math_floor_ret4, math_max_ret % 60);
end;

local function updateTimer() -- Line: 199
    -- upvalues: u21 (ref), u17 (copy), countdown (copy), u24 (ref), u36 (ref), u34 (ref), u35 (ref)
    if not u21 then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    if u21.mode == "Daily" and u21.daily then
        u17.Text = "RESETS IN " .. countdown(u21.daily.resetsAt - ServerTimeNow);
    elseif u21.event then
        local event = u21.event;

        if event.phase == "Upcoming" then
            u17.Text = "STARTS IN " .. countdown(event.startsAt - ServerTimeNow);
        elseif event.phase == "Active" then
            u17.Text = "ENDS IN " .. countdown(event.endsAt - ServerTimeNow);
        else
            u17.Text = "THIS EVENT HAS ENDED";
        end;
    end;

    if u21.event and (u21.event.phase == "Upcoming" and u21.event.startsAt <= ServerTimeNow or u21.event.phase == "Active" and u21.event.endsAt <= ServerTimeNow) and not u24 then
        u36();
    end;

    if u34 and u35 then
        u34.Text = "NEW IN " .. countdown(u35 - ServerTimeNow);
    end;

    if not (u21.mode ~= "Daily" or not (u21.daily and (u21.daily.resetsAt <= ServerTimeNow or (u21.daily.spinResetsAt or (1 / 0)) <= ServerTimeNow)) or u24) then
        u36();
    end;
end;

local function clearCards() -- Line: 236
    -- upvalues: u38 (copy), u19 (copy), u34 (ref), u35 (ref)
    for _, v in u38 do
        v:Disconnect();
    end;

    table.clear(u38);

    for _, child in u19:GetChildren() do
        child:Destroy();
    end;

    u34 = nil;
    u35 = nil;
end;

local function preview(p56, p57) -- Line: 247
    -- upvalues: SkinCatalog (copy), ChickenOrHero (copy), Panels (copy), u38 (copy)
    local v58 = SkinCatalog.get(p57);

    if v58 then
        v58 = ChickenOrHero.Weapons.Models:FindFirstChild(v58.Model);
    end;

    local v59;

    if v58 then
        v59 = v58:FindFirstChild("Blade");
    else
        v59 = v58;
    end;

    if not (v59 and v59:IsA("BasePart")) then
        return;
    end;

    local u60 = Panels.make("ViewportFrame", p56, "WeaponPreview", {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Active = false,
        Position = UDim2.fromScale(0.08, 0.02),
        Size = UDim2.fromScale(0.84, 0.62),
        Ambient = Color3.fromRGB(200, 210, 225),
        LightColor = Color3.new(1, 1, 1)
    });
    local v61 = Panels.make("WorldModel", u60, "Display", {});
    local v62 = Panels.make("Model", v61, "Knife", {});
    local v63 = v59:Clone();
    v63.Transparency = 0;
    v63.CFrame = v58:GetAttribute("PreviewRotation") or CFrame.identity;
    v63.Anchored = true;
    v63.CanCollide = false;
    v63.Parent = v62;

    for _, descendant in v63:GetDescendants() do
        if descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) then
            descendant:Destroy();
        end;
    end;

    local _, u64 = v62:GetBoundingBox();
    local u65 = Panels.make("Camera", u60, "PreviewCamera", {
        FieldOfView = 35
    });
    u60.CurrentCamera = u65;

    local function fit() -- Line: 279
        -- upvalues: u60 (copy), u64 (copy), u65 (copy)
        local AbsoluteSize = u60.AbsoluteSize;
        local Y = u64.Y;
        local v66 = u64.X / math.max(0.1, AbsoluteSize.Y > 0 and AbsoluteSize.X / AbsoluteSize.Y or 1);
        local math_max_ret = math.max(Y, v66);
        local math_rad_ret = math.rad(u65.FieldOfView / 2);
        local v67 = math_max_ret / (math.tan(math_rad_ret) * 2) + u64.Z / 2;
        u65.CFrame = CFrame.lookAt(Vector3.new(0, 0, v67 * 1.12), Vector3.new(0, 0, 0));
    end;

    local PropertyChangedSignal = u60:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u38, PropertyChangedSignal:Connect(fit));
    fit();
end;

local function dailyCard(u68, p69) -- Line: 291
    -- upvalues: Panels (copy), u19 (copy), Skin (copy), Palette (copy), Color3_fromRGB_ret (copy), Icon2 (copy), u35 (ref), u34 (ref), u21 (ref), QuestEvent (copy), u25 (ref), u36 (ref)
    local v70 = Panels.make("Frame", u19, u68.id, {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, (p69 - 1) * 105),
        Size = UDim2.fromOffset(512, 97),
        BackgroundColor3 = Color3.fromRGB(25, 39, 53)
    });
    Panels.corner(v70, 10);
    Panels.stroke(v70, u68.claimed and Panels.Muted or (u68.complete and Panels.Gold or Panels.Blue), 0.55);
    local v71;

    if u68.complete and not u68.claimed then
        v71 = Palette.green or nil;
    else
        v71 = nil;
    end;

    Skin.card(v70, v71);
    local v72 = Panels.text(v70, "Title", u68.text, 14, 11, 305, 24, 16, Panels.Paper);
    v72.TextScaled = true;
    v72.TextWrapped = false;
    v72.TextTruncate = Enum.TextTruncate.AtEnd;
    v72.Font = Enum.Font.GothamBold;
    local v73 = u68.kind == "Spin";
    local v74 = v73 and "+" .. u68.rewardAmount .. (u68.rewardAmount == 1 and " SPIN" or " SPINS") or (u68.rewardCurrency == "gems" and "◆ " .. u68.rewardAmount .. " GEMS" or u68.rewardCurrency == "candyCorn" and u68.rewardAmount .. " CANDY" or (u68.rewardCurrency == "journeyXp" and "+" .. u68.rewardAmount .. " XP" or "◉ " .. u68.rewardAmount .. " COINS"));
    local v75 = v73 and Color3_fromRGB_ret or (u68.rewardCurrency == "gems" and Panels.Gem or u68.rewardCurrency == "candyCorn" and Color3.fromRGB(255, 176, 70) or (u68.rewardCurrency == "journeyXp" and Color3.fromRGB(196, 157, 255) or Panels.Gold));
    local u76 = Panels.text(v70, "Reward", v74, 326, 11, 170, 22, 16, v75);
    u76.TextScaled = true;
    u76.TextWrapped = false;
    u76.TextTruncate = Enum.TextTruncate.AtEnd;
    u76.Font = Enum.Font.GothamBold;
    u76.TextXAlignment = Enum.TextXAlignment.Right;

    if not v73 and u68.rewardCurrency == "candyCorn" then
        local u77 = Panels.make("ImageLabel", u76, "Icon", {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Image = Icon2,
            ScaleType = Enum.ScaleType.Fit
        });

        local function place() -- Line: 334
            -- upvalues: u76 (copy), u77 (copy)
            local X = u76.AbsoluteSize.X;
            local v78 = u76.TextBounds / (X <= 0 and 1 or X / u76.Size.X.Offset);
            local math_floor_ret = math.floor(v78.Y * 1.2);
            local math_clamp_ret = math.clamp(math_floor_ret, 14, 26);
            u77.Size = UDim2.fromOffset(math_clamp_ret, math_clamp_ret);
            u77.Position = UDim2.new(1, -v78.X - 5, 0.5, 0);
        end;

        u76:GetPropertyChangedSignal("TextBounds"):Connect(place);
        u76:GetPropertyChangedSignal("AbsoluteSize"):Connect(place);
        place();
    end;

    local string_format_ret = string.format("%d / %d", u68.progress // (u68.unit or 1), u68.target // (u68.unit or 1));
    local v79 = Panels.text(v70, "Progress", string_format_ret, 14, 44, 112, 19, 16, Panels.Muted);
    v79.TextScaled = true;
    v79.TextWrapped = false;
    v79.TextTruncate = Enum.TextTruncate.AtEnd;

    if v73 then
        u35 = u68.resetsAt;
        local v80 = Panels.text(v70, "NewIn", "", 130, 44, 224, 19, 16, Color3_fromRGB_ret);
        v80.TextScaled = true;
        v80.TextWrapped = false;
        v80.TextTruncate = Enum.TextTruncate.AtEnd;
        v80.Font = Enum.Font.GothamBold;
        u34 = v80;
    end;

    local v81 = Panels.make("Frame", v70, "ProgressTrack", {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(14, 72),
        Size = UDim2.fromOffset(340, 9),
        BackgroundColor3 = Color3.fromRGB(55, 69, 77)
    });
    Panels.corner(v81, 4);
    local v82 = Panels.make("Frame", v81, "Fill", {
        BorderSizePixel = 0,
        Size = UDim2.fromScale(math.clamp(u68.progress / u68.target, 0, 1), 1),
        BackgroundColor3 = Panels.Gold
    });
    Panels.corner(v82, 4);
    Skin.bar(v81, v82, "green");
    local u83 = Panels.button(v70, "Claim", u68.claimed and "CLAIMED" or (u68.complete and "CLAIM" or "IN PROGRESS"), 373, 47, 123, 38, u68.complete and not u68.claimed and Color3.fromRGB(78, 118, 91) or Color3.fromRGB(49, 65, 73));
    u83.TextScaled = true;
    u83.Active = u68.complete and not u68.claimed and u21.loaded;
    Skin.button(u83, u83.Active and "primary" or (u68.claimed and "dark" or "secondary"));

    if u83.Active then
        u83.Activated:Connect(function() -- Line: 383
            -- upvalues: u83 (copy), u68 (copy), QuestEvent (ref), u25 (ref), u36 (ref)
            if not u83.Active then
                return;
            end;

            u83.Active = false;
            u83.Text = "CLAIMING...";
            QuestEvent:FireServer("ClaimDaily", u68.id);
            task.delay(3, function() -- Line: 132
                -- upvalues: u25 (ref), u36 (ref)
                if u25 then
                    u36();
                end;
            end);
        end);
    end;
end;

local function productButton(u84, p85, p86, p87, p88) -- Line: 396
    -- upvalues: u19 (copy), Panels (copy), skipPrice (copy), u32 (ref), u21 (ref), Skin (copy), u33 (ref), QuestEvent (copy), u25 (ref), u36 (ref), u27 (ref)
    local v89 = Panels.text(u19, u84 .. "Label", p87, p86, 322, 252, 18, 16, Panels.Paper);
    v89.TextScaled = true;
    v89.TextWrapped = false;
    v89.TextTruncate = Enum.TextTruncate.AtEnd;
    v89.Font = Enum.Font.GothamBold;
    v89.TextXAlignment = Enum.TextXAlignment.Center;
    local v90 = skipPrice(p85);
    local v91 = type(v90) == "number" and utf8.char(57346) .. " " .. v90 or (v90 == false and "UNAVAILABLE" or "...");
    local u92 = Panels.button(u19, u84, u32 == u84 and "OPENING..." or v91, p86, 344, 252, 38, Color3.fromRGB(105, 72, 133));
    u92.TextScaled = true;
    u92.TextSize = 18;
    local v93;

    if type(v90) == "number" then
        v93 = p88 and u21.loaded and u32 == nil;
    else
        v93 = false;
    end;

    u92.Active = v93;
    u92.AutoButtonColor = u92.Active;
    Skin.button(u92, u92.Active and "robux" or "secondary");
    u92.Activated:Connect(function() -- Line: 418
        -- upvalues: u92 (copy), u32 (ref), u84 (copy), u33 (ref), QuestEvent (ref), u25 (ref), u36 (ref), u27 (ref)
        if not u92.Active or u32 then
            return;
        end;

        u32 = u84;
        u33 = u33 + 1;
        local u94 = u33;
        u92.Active = false;
        u92.Text = "OPENING...";
        QuestEvent:FireServer(u84 == "Refresh" and "PromptRefresh" or "PromptAutoComplete", nil);
        task.delay(3, function() -- Line: 132
            -- upvalues: u25 (ref), u36 (ref)
            if u25 then
                u36();
            end;
        end);
        task.delay(8, function() -- Line: 428
            -- upvalues: u25 (ref), u33 (ref), u94 (copy), u32 (ref), u36 (ref), u27 (ref)
            if u25 and u33 == u94 then
                u32 = nil;
                u36();
                u27();
            end;
        end);
    end);
end;

local function dailyProducts(p95) -- Line: 438
    -- upvalues: productButton (copy)
    local v96 = false;

    for _, v in p95.quests do
        if not v96 then
            v96 = not v.complete and not v.claimed;
        end;
    end;

    if p95.refreshProductId then
        productButton("Refresh", p95.refreshProductId, 0, "Refresh Quests", true);
    end;

    if p95.autoCompleteProductId then
        productButton("AutoComplete", p95.autoCompleteProductId, 260, "Auto Complete Quests", v96);
    end;
end;

local function eventDetail(u97) -- Line: 451
    -- upvalues: Panels (copy), u19 (copy), Skin (copy), Palette (copy), u21 (ref), skipPrice (copy), u30 (ref), u31 (ref), QuestEvent (copy), u25 (ref), u36 (ref), u27 (ref)
    local v98 = Panels.make("Frame", u19, "SelectedWeapon", {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 140),
        Size = UDim2.fromOffset(512, 268),
        BackgroundColor3 = Color3.fromRGB(25, 39, 53)
    });
    Panels.corner(v98, 10);
    Panels.stroke(v98, u97.claimable and Panels.Gold or Panels.Blue, 0.55);
    Skin.card(v98, u97.claimable and Palette.gold or nil);
    local v99 = Panels.text(v98, "Name", u97.name, 14, 10, 310, 27, 16, Panels.Paper);
    v99.TextScaled = true;
    v99.TextWrapped = false;
    v99.TextTruncate = Enum.TextTruncate.AtEnd;
    v99.Font = Enum.Font.GothamBold;
    local v100 = Panels.text(v98, "Status", u97.claimed and "UNLOCKED" or (u97.locked and "LOCKED" or (u97.claimable and "READY TO CLAIM" or "IN PROGRESS")), 333, 12, 164, 23, 16, u97.claimable and Panels.Gold or Panels.Muted);
    v100.TextScaled = true;
    v100.TextWrapped = false;
    v100.TextTruncate = Enum.TextTruncate.AtEnd;
    v100.Font = Enum.Font.GothamBold;
    v100.TextXAlignment = Enum.TextXAlignment.Right;
    local bonus = u97.bonus;
    local v101 = "+" .. bonus.Amount .. " " .. string.upper(bonus.Currency) .. " PER MATCH WHILE EQUIPPED";
    local v102 = Panels.text(v98, "Bonus", v101, 14, 42, 480, 22, 16, Panels.Gold);
    v102.TextScaled = true;
    v102.TextWrapped = false;
    v102.TextTruncate = Enum.TextTruncate.AtEnd;
    v102.Font = Enum.Font.GothamBold;

    for i, v in u97.quests do
        local v103 = 70 + (i - 1) * 48;
        local v104 = v.complete and Panels.Gold or (u97.locked and Panels.Muted or Panels.Paper);
        local complete = v.complete;
        local v105 = Panels.text(v98, "Quest" .. i, (v.complete and "✓ " or "• ") .. v.text, 14, v103, 480, 23, 16, v104);
        v105.TextScaled = true;
        v105.TextWrapped = false;
        v105.TextTruncate = Enum.TextTruncate.AtEnd;

        if complete then
            v105.Font = Enum.Font.GothamBold;
        end;

        local string_format_ret = string.format("%d/%d", v.progress // (v.unit or 1), v.target // (v.unit or 1));

        if v.alternateTarget then
            string_format_ret = string.format("%d/%d OR %d/%d", v.progress, v.target, v.alternateProgress or 0, v.alternateTarget);
        end;

        local v106 = Panels.text(v98, "Count" .. i, string_format_ret, 370, v103 + 24, 126, 17, 16, v104);
        v106.TextScaled = true;
        v106.TextWrapped = false;
        v106.TextTruncate = Enum.TextTruncate.AtEnd;
        v106.Font = Enum.Font.GothamBold;
        v106.TextXAlignment = Enum.TextXAlignment.Right;
        local v107 = Panels.make("Frame", v98, "QuestTrack" .. i, {
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(14, v103 + 29),
            Size = UDim2.fromOffset(340, 7),
            BackgroundColor3 = Color3.fromRGB(55, 69, 77)
        });
        Panels.corner(v107, 4);
        local v108 = v.progress / v.target;

        if v.alternateTarget then
            v108 = math.max(v108, (v.alternateProgress or 0) / v.alternateTarget);
        end;

        local v109 = Panels.make("Frame", v107, "Fill", {
            BorderSizePixel = 0,
            Size = UDim2.fromScale(math.clamp(v108, 0, 1), 1),
            BackgroundColor3 = Panels.Gold
        });
        Panels.corner(v109, 4);
        Skin.bar(v107, v109, "green");
    end;

    local v110 = u97.claimed and "OWNED" or (u97.locked and "UNLOCK PREVIOUS" or (u97.claimable and "CLAIM KNIFE" or "COMPLETE QUESTS"));
    local skipProductId = u21.event.skipProductId;
    local u111 = (u21.event.skipCredits or 0) > 0;
    local v112;

    if skipProductId or u111 then
        v112 = u21.loaded and u21.event.claimsEnabled and not (u97.claimed or u97.locked) and not u97.claimable;
    else
        v112 = u111;
    end;

    local v113 = v112 and not u111 and skipPrice(skipProductId);

    if v112 then
        local v114 = type(v113) == "number" and utf8.char(57346) .. " " .. v113 or (v113 == false and "UNAVAILABLE" or "...");
        local u115 = Panels.button(v98, "SkipQuests", u111 and "USE SAVED SKIP" or "SKIP " .. v114, 14, 224, 238, 34, Color3.fromRGB(105, 72, 133));
        u115.TextScaled = true;
        u115.TextSize = 18;
        Skin.button(u115, "robux");
        local v116;

        if u111 or type(v113) == "number" then
            v116 = not u30;
        else
            v116 = false;
        end;

        u115.Active = v116;
        u115.Activated:Connect(function() -- Line: 557
            -- upvalues: u115 (copy), u30 (ref), u111 (copy), u31 (ref), u97 (copy), QuestEvent (ref), u25 (ref), u36 (ref), u27 (ref)
            if not u115.Active then
                return;
            end;

            u30 = not u111;
            u31 = u31 + 1;
            local u117 = u31;
            u115.Active = false;
            u115.Text = "OPENING...";
            QuestEvent:FireServer(u111 and "RedeemSkipCredit" or "PromptSkip", u97.id);
            task.delay(3, function() -- Line: 132
                -- upvalues: u25 (ref), u36 (ref)
                if u25 then
                    u36();
                end;
            end);
            task.delay(8, function() -- Line: 567
                -- upvalues: u25 (ref), u31 (ref), u117 (copy), u30 (ref), u36 (ref), u27 (ref)
                if u25 and u31 == u117 then
                    u30 = false;
                    u36();
                    u27();
                end;
            end);
        end);
    end;

    local u118 = Panels.button(v98, "Claim", v110, v112 and 260 or 14, 224, v112 and 238 or 484, 34, u97.claimable and Color3.fromRGB(78, 118, 91) or Color3.fromRGB(49, 65, 73));
    u118.TextScaled = true;
    u118.Active = u97.claimable and u21.loaded and u21.event.claimsEnabled;
    Skin.button(u118, u118.Active and "primary" or (u97.claimed and "dark" or "secondary"));

    if u118.Active then
        u118.Activated:Connect(function() -- Line: 592
            -- upvalues: u118 (copy), u97 (copy), QuestEvent (ref), u25 (ref), u36 (ref)
            if not u118.Active then
                return;
            end;

            u118.Active = false;
            u118.Text = "CLAIMING...";
            QuestEvent:FireServer("ClaimEvent", u97.id);
            task.delay(3, function() -- Line: 132
                -- upvalues: u25 (ref), u36 (ref)
                if u25 then
                    u36();
                end;
            end);
        end);
    end;
end;

local function eventCards() -- Line: 603
    -- upvalues: u21 (ref), u26 (ref), Panels (copy), u19 (copy), Skin (copy), preview (copy), u27 (ref), eventDetail (copy)
    local weapons = u21.event.weapons;
    u26 = math.clamp(u26, 1, #weapons);

    for i, v in weapons do
        local v119 = i == u26;
        local v120 = Panels.make("TextButton", u19, v.id, {
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = true,
            Position = UDim2.fromOffset((i - 1) * 172, 0),
            Size = UDim2.fromOffset(164, 130),
            BackgroundColor3 = v119 and Color3.fromRGB(44, 65, 76) or Color3.fromRGB(25, 39, 53)
        });
        Panels.corner(v120, 10);
        Panels.stroke(v120, v119 and Panels.Gold or (v.claimed and Panels.Muted or Panels.Blue), 0.55);
        Skin.slot(v120, v119 and "selected" or (v.claimed and "equipped" or nil));
        preview(v120, v.id);
        local v121 = Panels.text(v120, "Name", v.name, 8, 84, 148, 19, 16, Panels.Paper);
        v121.TextScaled = true;
        v121.TextWrapped = false;
        v121.TextTruncate = Enum.TextTruncate.AtEnd;
        v121.Font = Enum.Font.GothamBold;
        v121.TextWrapped = true;
        v121.TextTruncate = Enum.TextTruncate.None;
        v121.TextXAlignment = Enum.TextXAlignment.Center;
        local u122 = i;
        local v123 = v;
        local v124 = 0;

        for _, v2 in v.quests do
            if v2.complete then
                v124 = v124 + 1;
            end;
        end;

        local v125 = v123.claimed and "OWNED" or (v123.locked and "LOCKED" or string.format("%d / 3 QUESTS", v124));
        local v126 = Panels.text(v120, "Status", v125, 8, 108, 148, 15, 16, v123.claimed and Panels.Gold or Panels.Muted);
        v126.TextScaled = true;
        v126.TextWrapped = false;
        v126.TextTruncate = Enum.TextTruncate.AtEnd;
        v126.Font = Enum.Font.GothamBold;
        v126.TextXAlignment = Enum.TextXAlignment.Center;
        v120.Activated:Connect(function() -- Line: 636
            -- upvalues: u26 (ref), u122 (copy), u27 (ref)
            u26 = u122;
            u27();
        end);
    end;

    eventDetail(weapons[u26]);
end;

u27 = function() -- Line: 644
    -- upvalues: u21 (ref), clearCards (copy), u22 (ref), u16 (copy), u18 (copy), u19 (copy), dailyCard (copy), dailyProducts (copy), u20 (copy), eventCards (copy), updateTimer (copy)
    if not u21 then
        return;
    end;

    clearCards();
    u22 = u21.mode;

    if u21.mode == "Daily" and u21.daily then
        u16.Text = "QUESTS";
        u18.Text = "Two daily quests, plus a spin quest that changes every 2 hours.";
        u19.ScrollingEnabled = true;
        u19.CanvasSize = UDim2.fromOffset(0, 390);

        for i, v in u21.daily.quests do
            dailyCard(v, i);
        end;

        dailyProducts(u21.daily);
        u20.Text = u21.message or (u21.loaded and "Daily quests reset at 00:00 UTC." or "Loading your quest progress...");
    else
        u16.Text = "QUESTS";
        u18.Text = "Earn the three knives in order during this limited event.";
        u19.ScrollingEnabled = false;
        u19.CanvasSize = UDim2.fromOffset(0, 413);
        eventCards();
        u20.Text = u21.message or (u21.loaded and "Complete all three quests, then claim each knife." or "Loading your collection...");
    end;

    updateTimer();
end;

u36 = function() -- Line: 673
    -- upvalues: u24 (ref), QuestEvent (copy), u25 (ref)
    if u24 then
        return;
    end;

    u24 = true;
    QuestEvent:FireServer("Get");
    task.delay(4, function() -- Line: 679
        -- upvalues: u25 (ref), u24 (ref)
        if u25 then
            u24 = false;
        end;
    end);
end;

u5:bindEvent("selected", function() -- Line: 686
    -- upvalues: ChickenOrHero (copy), u2 (copy), QuestNotice (copy), LocalPlayer (copy), u21 (ref), u36 (ref)
    require(ChickenOrHero.Presentation.HudNavigation).opening("Quests");
    u2.Visible = true;
    QuestNotice.seen(LocalPlayer, u21);
    u36();
end);
u5:bindEvent("deselected", function() -- Line: 692
    -- upvalues: u2 (copy)
    u2.Visible = false;
end);
local v127 = LocalPlayer:GetAttributeChangedSignal("QuestOpenRequestedAt"):Connect(function() -- Line: 695
    -- upvalues: u5 (copy)
    u5:select();
end);
table.insert(u37, v127);
local v128 = v4.Activated:Connect(function() -- Line: 698
    -- upvalues: u5 (copy)
    u5:deselect();
end);
table.insert(u37, v128);
local v138 = QuestEvent.OnClientEvent:Connect(function(p129, p130) -- Line: 701
    -- upvalues: u21 (ref), u30 (ref), u31 (ref), u32 (ref), u33 (ref), u26 (ref), u23 (ref), u24 (ref), u2 (copy), u22 (ref), u27 (ref), celebrate (copy), QuestNotice (copy), LocalPlayer (copy), u45 (ref), u5 (copy), BindableEvent (copy)
    if p129 ~= "State" or type(p130) ~= "table" then
        return;
    end;

    local v131 = u21;
    u21 = p130;

    if u21.message then
        u30 = false;
        u31 = u31 + 1;
        u32 = nil;
        u33 = u33 + 1;
    end;

    local v132 = false;

    if v131 and (v131.loaded and u21.loaded) then
        for i, v in u21.event.weapons do
            local v133 = v131.event.weapons[i];

            if v.claimed and (v133 and not v133.claimed) then
                v132 = true;
            end;
        end;

        if v131.daily and (u21.daily and v131.daily.day == u21.daily.day) then
            for i, v in u21.daily.quests do
                local v134 = v131.daily.quests[i];

                if v.claimed and (v134 and not v134.claimed) then
                    v132 = true;
                end;
            end;
        end;
    end;

    if v131 and (v131.mode == "Event" and u21.mode == "Event") then
        local v135 = v131.event.weapons[u26];
        local v136 = u21.event.weapons[u26];

        if v135 and (v136 and (not v135.claimed and v136.claimed)) then
            u26 = math.min(u26 + 1, #u21.event.weapons);
        end;
    end;

    u23 = os.clock();
    u24 = false;

    if u2.Visible or u22 ~= u21.mode then
        u27();
    end;

    if v132 then
        celebrate();
    end;

    if u2.Visible then
        QuestNotice.seen(LocalPlayer, u21);
    end;

    local v137 = QuestNotice.show(LocalPlayer, u21);

    if v137 == u45 then
        return;
    end;

    u45 = v137;

    if v137 then
        u5:notify(BindableEvent.Event);

        return;
    end;

    BindableEvent:Fire();
end);
table.insert(u37, v138);
local v142 = MarketplaceService.PromptProductPurchaseFinished:Connect(function(p139, p140) -- Line: 750
    -- upvalues: u21 (ref), LocalPlayer (copy), u32 (ref), u33 (ref), u2 (copy), u36 (ref), u27 (ref), u30 (ref), u31 (ref)
    local v141 = u21 and u21.daily;

    if p139 == LocalPlayer.UserId and (v141 and (p140 == v141.refreshProductId or p140 == v141.autoCompleteProductId)) then
        u32 = nil;
        u33 = u33 + 1;

        if u2.Visible then
            u36();
            u27();
        end;
    end;

    if p139 == LocalPlayer.UserId and (u21 and (u21.event and p140 == u21.event.skipProductId)) then
        u30 = false;
        u31 = u31 + 1;

        if u2.Visible then
            u36();
            u27();
        end;
    end;
end);
table.insert(u37, v142);

local function tick() -- Line: 774
    -- upvalues: u25 (ref), u2 (copy), updateTimer (copy), u21 (ref), u23 (ref), u36 (ref), u24 (ref), tick (copy)
    if not u25 then
        return;
    end;

    if u2.Visible then
        updateTimer();

        if u21 and (not u21.loaded and os.clock() - u23 > 2) then
            u36();
        end;
    elseif os.clock() - u23 > (u21 and u21.loaded and 90 or 5) and not u24 then
        u36();
    end;

    task.delay(1, tick);
end;

task.delay(1, tick);
script.Destroying:Connect(function() -- Line: 793
    -- upvalues: u25 (ref), u37 (copy), clearCards (copy), BindableEvent (copy), u5 (copy), u1 (copy)
    u25 = false;

    for _, v in u37 do
        v:Disconnect();
    end;

    table.clear(u37);
    clearCards();
    BindableEvent:Destroy();
    u5:destroy();
    u1:Destroy();
end);