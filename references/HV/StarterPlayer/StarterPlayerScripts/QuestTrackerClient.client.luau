 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local QuestEvent = ChickenOrHero:WaitForChild("Quests"):WaitForChild("QuestEvent");
local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local ValleyToast = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("ValleyToast"));
local CandyCorn = require(ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn"));
local MarketplaceService = game:GetService("MarketplaceService");
local Palette = Skin.Palette;
local utf8_char_ret = utf8.char(57346);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u1 = { "QuestTrackerHidden", "TutorialActive", "TutorialSession", "TutorialRouting", "TutorialFinishing" };

local function allowed() -- Line: 44
    -- upvalues: u1 (copy), LocalPlayer (copy)
    for _, v in u1 do
        if LocalPlayer:GetAttribute(v) == true then
            return false;
        end;
    end;

    return true;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "QuestTracker";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;
ScreenGui.DisplayOrder = 61;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui.Enabled = false;
ScreenGui:SetAttribute("SelfManagedText", true);

local function make(p2, p3, p4) -- Line: 72
    local Instance_new_ret = Instance.new(p2);

    for i, v in p4 do
        Instance_new_ret[i] = v;
    end;

    Instance_new_ret.Parent = p3;

    return Instance_new_ret;
end;

local v5 = {
    Name = "Holder",
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Size = UDim2.fromOffset(336, 82)
};
local Frame = Instance.new("Frame");

local function text(p6, p7) -- Line: 80
    -- upvalues: Palette (copy), Skin (copy)
    p7.BackgroundTransparency = 1;
    p7.Font = p7.Font or Enum.Font.GothamBold;
    p7.TextXAlignment = p7.TextXAlignment or Enum.TextXAlignment.Left;
    p7.TextColor3 = p7.TextColor3 or Palette.text;
    local TextLabel = Instance.new("TextLabel");

    for i, v in p7 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = p6;
    Skin.textStroke(TextLabel, 1);

    return TextLabel;
end;

local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = {};
local u13 = {};
local u14 = false;
local u15 = {};
local u16 = { { 0, "007bff" }, { 60, "007bff" }, { 120, "ffff00" }, { 180, "007bff" }, { 240, "007bff" }, { 300, "ffff00" } };
local u17 = 0;

for i, v in v5 do
    Frame[i] = v;
end;

Frame.Parent = ScreenGui;
local UIScale = Instance.new("UIScale");

for i, v in {
    Scale = 1
} do
    UIScale[i] = v;
end;

UIScale.Parent = Frame;
local v18 = {
    Name = "Panel",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Palette.surface
};
local Frame2 = Instance.new("Frame");

for i, v in v18 do
    Frame2[i] = v;
end;

Frame2.Parent = Frame;
Skin.panel(Frame2);
local v19 = {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 12),
    Size = UDim2.fromOffset(266, 24)
};
local Frame3 = Instance.new("Frame");

for i, v in v19 do
    Frame3[i] = v;
end;

Frame3.Parent = Frame2;
local v20 = {
    FillDirection = Enum.FillDirection.Horizontal,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
};
local UIListLayout = Instance.new("UIListLayout");

for i, v in v20 do
    UIListLayout[i] = v;
end;

UIListLayout.Parent = Frame3;
text(Frame3, {
    Name = "Title",
    Text = "DAILY QUESTS",
    TextSize = 17,
    LayoutOrder = 1,
    Font = Enum.Font.GothamBlack,
    AutomaticSize = Enum.AutomaticSize.X,
    Size = UDim2.fromOffset(0, 24)
});
local u21 = text(Frame3, {
    Name = "Done",
    Text = "0/3",
    TextSize = 12,
    LayoutOrder = 2,
    TextColor3 = Palette.textMuted,
    AutomaticSize = Enum.AutomaticSize.X,
    Size = UDim2.fromOffset(0, 24)
});
local v22 = {
    Name = "Hide",
    Text = ">",
    TextSize = 16,
    AutoButtonColor = true,
    Position = UDim2.fromOffset(292, 10),
    Size = UDim2.fromOffset(30, 28),
    Font = Enum.Font.GothamBlack,
    BackgroundColor3 = Palette.button
};
local TextButton = Instance.new("TextButton");

for i, v in v22 do
    TextButton[i] = v;
end;

TextButton.Parent = Frame2;
Skin.button(TextButton, "dark", {
    radius = UDim.new(0, 7)
});
local u23 = text(Frame2, {
    Name = "Resets",
    Text = "Resets in",
    TextSize = 12,
    TextColor3 = Palette.textMuted,
    Size = UDim2.fromOffset(120, 18)
});
local u24 = text(Frame2, {
    Name = "ResetsTime",
    Text = "",
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Right,
    Size = UDim2.fromOffset(120, 18)
});
local u25 = {};
local u26 = {};
local u27 = {};
local u28 = nil;

local function priceOf(u29) -- Line: 128
    -- upvalues: u26 (copy), u27 (copy), MarketplaceService (copy), u9 (ref), u25 (copy)
    if u26[u29] == nil and not u27[u29] then
        u27[u29] = true;
        task.spawn(function() -- Line: 131
            -- upvalues: MarketplaceService (ref), u29 (copy), u26 (ref), u27 (ref), u9 (ref), u25 (ref)
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u29, Enum.InfoType.Product);
            local v30;

            if success and (type(result) == "table" and (result.IsForSale and type(result.PriceInRobux) == "number")) then
                v30 = result.PriceInRobux or false;
            else
                v30 = false;
            end;

            u26[u29] = v30;
            u27[u29] = nil;

            if u9 then
                for _, v in u25 do
                    v.refresh();
                end;
            end;
        end);
    end;

    return u26[u29];
end;

local function productButton(u31, u32, p33) -- Line: 144
    -- upvalues: Frame2 (copy), Palette (copy), Skin (copy), u9 (ref), u26 (copy), u27 (copy), MarketplaceService (copy), u25 (copy), u28 (ref), utf8_char_ret (copy), u8 (ref), QuestEvent (copy)
    local v34 = {
        TextSize = 11,
        AutoButtonColor = true,
        Name = u31,
        Size = UDim2.fromOffset(150, 30),
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = Palette.button,
        Text = u32
    };
    local TextButton2 = Instance.new("TextButton");

    for i, v in v34 do
        TextButton2[i] = v;
    end;

    TextButton2.Parent = Frame2;
    Skin.button(TextButton2, "secondary");
    local u40 = {
        button = TextButton2,
        x = p33,

        refresh = function() -- Line: 156, Name: refresh
            -- upvalues: u9 (ref), u31 (copy), u26 (ref), u27 (ref), MarketplaceService (ref), u25 (ref), TextButton2 (copy), u28 (ref), u32 (copy), utf8_char_ret (ref), Skin (ref)
            local v35 = u9 and u9.daily;
            local u36;

            if v35 then
                if u31 == "Refresh" then
                    u36 = v35.refreshProductId;
                else
                    u36 = v35.autoCompleteProductId;
                end;
            else
                u36 = v35;
            end;

            local v37 = u36 ~= nil;

            if u31 == "AutoComplete" and v35 then
                v37 = false;

                for _, v in v35.quests or {} do
                    if not v37 then
                        v37 = not v.complete and not v.claimed;
                    end;
                end;

                if v37 then
                    v37 = u36 ~= nil;
                end;
            end;

            if u36 then
                if u26[u36] == nil and not u27[u36] then
                    u27[u36] = true;
                    task.spawn(function() -- Line: 131
                        -- upvalues: MarketplaceService (ref), u36 (copy), u26 (ref), u27 (ref), u9 (ref), u25 (ref)
                        local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u36, Enum.InfoType.Product);
                        local v38;

                        if success and (type(result) == "table" and (result.IsForSale and type(result.PriceInRobux) == "number")) then
                            v38 = result.PriceInRobux or false;
                        else
                            v38 = false;
                        end;

                        u26[u36] = v38;
                        u27[u36] = nil;

                        if u9 then
                            for _, v in u25 do
                                v.refresh();
                            end;
                        end;
                    end);
                end;

                u36 = u26[u36];
            end;

            local v39;

            if u28 == u31 then
                v39 = "OPENING...";
            elseif type(u36) == "number" then
                v39 = u32 .. "  " .. utf8_char_ret .. " " .. u36;
            else
                v39 = u32;
            end;

            TextButton2.Text = v39;

            if v37 then
                if type(u36) == "number" then
                    v37 = u28 == nil;
                else
                    v37 = false;
                end;
            end;

            TextButton2.Active = v37;
            TextButton2.AutoButtonColor = v37;
            Skin.button(TextButton2, v37 and "robux" or "secondary");
        end
    };
    TextButton2.Activated:Connect(function() -- Line: 176
        -- upvalues: TextButton2 (copy), u28 (ref), u31 (copy), u8 (ref), QuestEvent (ref), u40 (copy)
        if not TextButton2.Active or u28 then
            return;
        end;

        u28 = u31;
        u8 = nil;
        QuestEvent:FireServer(u31 == "Refresh" and "PromptRefresh" or "PromptAutoComplete");
        u40.refresh();
        task.delay(8, function() -- Line: 184
            -- upvalues: u28 (ref), u31 (ref), u40 (ref)
            if u28 == u31 then
                u28 = nil;
                u40.refresh();
            end;
        end);
    end);
    u25[u31] = u40;

    return u40;
end;

productButton("Refresh", "REFRESH", 14);
productButton("AutoComplete", "AUTO COMPLETE", 172);
MarketplaceService.PromptProductPurchaseFinished:Connect(function(p41) -- Line: 196
    -- upvalues: LocalPlayer (copy), u28 (ref), u25 (copy), QuestEvent (copy)
    if p41 == LocalPlayer.UserId and u28 then
        u28 = nil;

        for _, v in u25 do
            v.refresh();
        end;

        QuestEvent:FireServer("Get");
    end;
end);
local v42 = {
    Name = "Tab",
    Text = "<",
    TextSize = 20,
    AutoButtonColor = true,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    Size = UDim2.fromOffset(34, 64),
    Font = Enum.Font.GothamBlack,
    BackgroundColor3 = Palette.button
};
local TextButton2 = Instance.new("TextButton");

for i, v in v42 do
    TextButton2[i] = v;
end;

TextButton2.Parent = Frame;
Skin.button(TextButton2, "dark", {
    radius = UDim.new(0, 8)
});

local function card(p43) -- Line: 218
    -- upvalues: u12 (copy), Frame2 (copy), Palette (copy), text (copy), Skin (copy), u16 (copy), u15 (copy), u8 (ref), QuestEvent (copy), u9 (ref), u10 (ref)
    local v44 = u12[p43];

    if v44 then
        return v44;
    end;

    local v45 = {
        Name = "Quest" .. p43,
        Size = UDim2.fromOffset(308, 66),
        BackgroundColor3 = Palette.row
    };
    local Frame4 = Instance.new("Frame");

    for i, v in v45 do
        Frame4[i] = v;
    end;

    Frame4.Parent = Frame2;
    local v46 = {
        Name = "Tick",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromOffset(20, 17),
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = Palette.greenDark
    };
    local Frame5 = Instance.new("Frame");

    for i, v in v46 do
        Frame5[i] = v;
    end;

    Frame5.Parent = Frame4;
    local v47 = {
        CornerRadius = UDim.new(1, 0)
    };
    local UICorner = Instance.new("UICorner");

    for i, v in v47 do
        UICorner[i] = v;
    end;

    UICorner.Parent = Frame5;
    local UIScale2 = Instance.new("UIScale");

    for i, v in {
        Scale = 1
    } do
        UIScale2[i] = v;
    end;

    UIScale2.Parent = Frame5;
    text(Frame5, {
        Text = "✓",
        TextSize = 12,
        Size = UDim2.fromScale(1, 1),
        Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Center
    });
    local v48 = text(Frame4, {
        Name = "Title",
        TextSize = 14,
        Position = UDim2.fromOffset(12, 7),
        Size = UDim2.fromOffset(224, 20),
        TextTruncate = Enum.TextTruncate.AtEnd
    });
    local v49 = text(Frame4, {
        Name = "Count",
        TextSize = 12,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 7),
        Size = UDim2.fromOffset(60, 20),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextColor3 = Palette.textSecondary
    });
    local v50 = {
        Name = "Track",
        Position = UDim2.fromOffset(12, 31),
        Size = UDim2.new(1, -24, 0, 9),
        BackgroundColor3 = Palette.track
    };
    local Frame6 = Instance.new("Frame");

    for i, v in v50 do
        Frame6[i] = v;
    end;

    Frame6.Parent = Frame4;
    local v51 = {
        Name = "Fill",
        Size = UDim2.fromScale(0, 1),
        BackgroundColor3 = Palette.xp
    };
    local Frame7 = Instance.new("Frame");

    for i, v in v51 do
        Frame7[i] = v;
    end;

    Frame7.Parent = Frame6;
    Skin.bar(Frame6, Frame7, "xp");
    local v52 = text(Frame4, {
        Name = "Reward",
        TextSize = 11,
        Position = UDim2.fromOffset(12, 45),
        Size = UDim2.new(1, -24, 0, 15),
        TextColor3 = Palette.gold
    });
    local v53 = {
        Name = "RewardIcon",
        BackgroundTransparency = 1,
        Visible = false,
        Position = UDim2.fromOffset(12, 44),
        Size = UDim2.fromOffset(16, 16),
        ScaleType = Enum.ScaleType.Fit
    };
    local ImageLabel = Instance.new("ImageLabel");

    for i, v in v53 do
        ImageLabel[i] = v;
    end;

    ImageLabel.Parent = Frame4;
    local v54 = {
        Name = "RewardWheel",
        BackgroundTransparency = 1,
        Visible = false,
        Position = UDim2.fromOffset(12, 44),
        Size = UDim2.fromOffset(16, 16)
    };
    local Frame8 = Instance.new("Frame");

    for i, v in v54 do
        Frame8[i] = v;
    end;

    Frame8.Parent = Frame4;

    for _, v in u16 do
        local v55 = {
            BackgroundTransparency = 1,
            Image = "rbxassetid://99047440408162",
            Size = UDim2.fromScale(1, 1),
            Rotation = v[1],
            ImageColor3 = Color3.fromHex(v[2])
        };
        local ImageLabel2 = Instance.new("ImageLabel");

        for i, v2 in v55 do
            ImageLabel2[i] = v2;
        end;

        ImageLabel2.Parent = Frame8;
    end;

    local v56 = {
        BackgroundTransparency = 1,
        Image = "rbxassetid://107716650960103",
        Size = UDim2.fromScale(1, 1),
        ImageColor3 = Color3.fromHex("1b1b1b")
    };
    local ImageLabel2 = Instance.new("ImageLabel");

    for i, v in v56 do
        ImageLabel2[i] = v;
    end;

    ImageLabel2.Parent = Frame8;
    local NumberValue = Instance.new("NumberValue");
    local v57 = {
        Name = "Claim",
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 5,
        Active = false,
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1)
    };
    local TextButton3 = Instance.new("TextButton");

    for i, v in v57 do
        TextButton3[i] = v;
    end;

    TextButton3.Parent = Frame4;
    local u58 = {
        frame = Frame4,
        title = v48,
        count = v49,
        track = Frame6,
        fill = Frame7,
        reward = v52,
        icon = ImageLabel,
        wheel = Frame8,
        tick = Frame5,
        tickScale = UIScale2,
        value = NumberValue,
        press = TextButton3
    };
    TextButton3.Activated:Connect(function() -- Line: 244
        -- upvalues: u58 (ref), u15 (ref), u8 (ref), QuestEvent (ref), u9 (ref), u10 (ref)
        if not (u58.claimable and (u58.id and (not u15[u58.id] or os.clock() - u15[u58.id] >= 5))) then
            return;
        end;

        u15[u58.id] = os.clock();
        u8 = nil;
        u58.reward.Text = "Claiming...";
        QuestEvent:FireServer("ClaimDaily", u58.id);
        task.delay(5, function() -- Line: 252
            -- upvalues: u9 (ref), u10 (ref)
            if u9 then
                u10(false);
            end;
        end);
    end);
    NumberValue.Changed:Connect(function(p59) -- Line: 258
        -- upvalues: u58 (ref)
        if u58.target then
            u58.count.Text = string.format("%d/%d", math.floor(p59 + 0.5), u58.target);
        end;
    end);
    u12[p43] = u58;

    return u58;
end;

local function rewardText(p60) -- Line: 268
    -- upvalues: u15 (copy)
    if p60.claimed then
        return "Claimed";
    end;

    if p60.complete and (u15[p60.id] and os.clock() - u15[p60.id] < 5) then
        return "Claiming...";
    end;

    local v61 = tonumber(p60.rewardAmount) or 0;
    local rewardCurrency = p60.rewardCurrency;
    local v62;

    if rewardCurrency == "coins" then
        v62 = "coins";
    elseif rewardCurrency == "gems" then
        v62 = "gems";
    elseif rewardCurrency == "spins" then
        v62 = v61 == 1 and "spin" or "spins";
    else
        v62 = rewardCurrency == "candyCorn" and "candy corn" or (rewardCurrency == "journeyXp" and "Journey XP" or tostring(rewardCurrency or ""));
    end;

    return string.format("%d %s", v61, v62);
end;

local function rewardColor(p63) -- Line: 285
    -- upvalues: Palette (copy)
    if p63.claimed then
        return Palette.textMuted;
    end;

    local rewardCurrency = p63.rewardCurrency;

    if rewardCurrency == "gems" then
        return Palette.gem;
    end;

    if rewardCurrency == "spins" then
        return Palette.runner;
    end;

    if rewardCurrency == "journeyXp" then
        return Palette.xpLight;
    end;

    return Palette.gold;
end;

local function rewardIcon(p64) -- Line: 293
    -- upvalues: Skin (copy), CandyCorn (copy)
    local rewardCurrency = p64.rewardCurrency;

    if rewardCurrency == "coins" then
        return Skin.Icons.coin;
    end;

    if rewardCurrency == "gems" then
        return Skin.Icons.gem;
    end;

    if rewardCurrency == "candyCorn" then
        return CandyCorn.Icon;
    end;

    if rewardCurrency == "journeyXp" then
        return Skin.Icons.journey;
    end;

    return rewardCurrency == "spins" and "wheel" or nil;
end;

local function duration(p65) -- Line: 302
    local math_floor_ret = math.floor(p65);
    local math_max_ret = math.max(0, math_floor_ret);
    local v66 = math_max_ret // 3600;
    local v67 = math_max_ret % 3600 // 60;

    if v66 > 0 then
        return string.format("%dh %dm", v66, v67);
    end;

    return string.format("%dm", (math.max(1, v67)));
end;

local function ordered() -- Line: 308
    -- upvalues: u9 (ref)
    local v68 = u9 and (u9.daily and u9.daily.quests) or {};
    local v69 = {};

    for _, v in v68 do
        if v.kind ~= "Spin" then
            table.insert(v69, v);
        end;
    end;

    for _, v in v68 do
        if v.kind == "Spin" then
            table.insert(v69, v);
        end;
    end;

    return v69;
end;

local function refreshTimer() -- Line: 323
    -- upvalues: u9 (ref), u24 (copy), u17 (ref), ordered (copy), u12 (copy), rewardText (copy)
    local v70 = u9 and u9.daily;

    if not v70 then
        return;
    end;

    local v71 = (v70.resetsAt or 0) - (os.time() + u17);
    local math_floor_ret = math.floor(v71);
    local math_max_ret = math.max(0, math_floor_ret);
    local v72 = math_max_ret // 3600;
    local v73 = math_max_ret % 3600 // 60;
    local v74;

    if v72 > 0 then
        v74 = string.format("%dh %dm", v72, v73);
    else
        v74 = string.format("%dm", (math.max(1, v73)));
    end;

    u24.Text = v74;

    for i, v in ordered() do
        local v75 = u12[i];

        if v75 and (v.kind == "Spin" and not v.claimed) then
            local reward = v75.reward;
            local v76 = rewardText(v);
            local v77 = (v.resetsAt or 0) - (os.time() + u17);
            local math_floor_ret2 = math.floor(v77);
            local math_max_ret2 = math.max(0, math_floor_ret2);
            local v78 = math_max_ret2 // 3600;
            local v79 = math_max_ret2 % 3600 // 60;
            local v80;

            if v78 > 0 then
                v80 = string.format("%dh %dm", v78, v79);
            else
                v80 = string.format("%dm", (math.max(1, v79)));
            end;

            reward.Text = v76 .. "  ·  new quest in " .. v80;
        end;
    end;
end;

u10 = function(p81) -- Line: 338, Name: draw
    -- upvalues: ordered (copy), card (copy), u13 (copy), u15 (copy), rewardText (copy), Palette (copy), Skin (copy), CandyCorn (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), u12 (copy), u21 (copy), u25 (copy), u9 (ref), u23 (copy), u24 (copy), Frame (copy), refreshTimer (copy)
    local v82 = ordered();
    local v83 = 0;

    for i, v in v82 do
        local u84 = card(i);
        u84.frame.Visible = true;
        u84.frame.Position = UDim2.fromOffset(14, 48 + (i - 1) * 74);
        local v85 = tonumber(v.unit) or 1;
        local math_max_ret = math.max(1, v85);
        local math_floor_ret = math.floor((v.target or 1) / math_max_ret);
        local math_max_ret2 = math.max(1, math_floor_ret);
        local math_floor_ret2 = math.floor((v.progress or 0) / math_max_ret);
        local math_min_ret = math.min(math_max_ret2, math_floor_ret2);
        local v86 = v.complete == true and true or v.claimed == true;

        if v86 then
            v83 = v83 + 1;
        end;

        local v87 = u13[v.id];
        local v88;

        if p81 and (v87 and u84.id == v.id) then
            v88 = v87.progress;
        else
            v88 = math_min_ret;
        end;

        local v89;

        if v87 == nil then
            v89 = false;
        else
            v89 = v87.complete;
        end;

        u84.id = v.id;
        u84.target = math_max_ret2;
        u84.title.Text = v.text or "";
        u84.title.Position = UDim2.fromOffset(v86 and 34 or 12, 7);
        local reward = u84.reward;
        local v90;

        if v.complete and not (v.claimed or u15[v.id]) then
            v90 = "TAP TO CLAIM  ·  " .. rewardText(v);
        else
            v90 = rewardText(v);
        end;

        reward.Text = v90;
        local v91;

        if v.complete and not v.claimed then
            v91 = Palette.green;
        elseif v.claimed then
            v91 = Palette.textMuted;
        else
            local rewardCurrency = v.rewardCurrency;

            if rewardCurrency == "gems" then
                v91 = Palette.gem;
            elseif rewardCurrency == "spins" then
                v91 = Palette.runner;
            elseif rewardCurrency == "journeyXp" then
                v91 = Palette.xpLight;
            else
                v91 = Palette.gold;
            end;
        end;

        u84.reward.TextColor3 = v91;
        local v92;

        if v.complete == true then
            v92 = not v.claimed;
        else
            v92 = false;
        end;

        u84.claimable = v92;
        u84.press.Active = u84.claimable;
        u84.press.AutoButtonColor = u84.claimable;
        local v93 = not v.claimed;

        if v93 then
            local rewardCurrency = v.rewardCurrency;

            if rewardCurrency == "coins" then
                v93 = Skin.Icons.coin;
            elseif rewardCurrency == "gems" then
                v93 = Skin.Icons.gem;
            elseif rewardCurrency == "candyCorn" then
                v93 = CandyCorn.Icon;
            elseif rewardCurrency == "journeyXp" then
                v93 = Skin.Icons.journey;
            else
                v93 = rewardCurrency == "spins" and "wheel" or nil;
            end;
        end;

        u84.wheel.Visible = v93 == "wheel";
        local v94;

        if v93 == nil or v93 == false then
            v94 = false;
        else
            v94 = v93 ~= "wheel";
        end;

        u84.icon.Visible = v94;

        if u84.icon.Visible then
            u84.icon.Image = v93;
        end;

        u84.reward.Position = UDim2.fromOffset(v93 and 32 or 12, 45);
        local v95;

        if v86 then
            v95 = Palette.green;
        else
            v95 = nil;
        end;

        Skin.card(u84.frame, v95, {
            radius = UDim.new(0, 9)
        });

        if not v86 then
            u84.frame.BackgroundColor3 = Palette.row;
        end;

        Skin.bar(u84.track, u84.fill, v86 and "green" or "xp");
        local v96;

        if v86 then
            v96 = Palette.green;
        else
            v96 = Palette.textSecondary;
        end;

        u84.count.TextColor3 = v96;
        u84.tick.Visible = v86;
        local v97 = math_min_ret / math_max_ret2;

        if p81 and v88 ~= math_min_ret then
            u84.fill.Size = UDim2.fromScale(v88 / math_max_ret2, 1);
            u84.value.Value = v88;
            TweenService:Create(u84.fill, TweenInfo_new_ret2, {
                Size = UDim2.fromScale(v97, 1)
            }):Play();
            TweenService:Create(u84.value, TweenInfo_new_ret2, {
                Value = math_min_ret
            }):Play();
        else
            u84.fill.Size = UDim2.fromScale(v97, 1);
            u84.value.Value = math_min_ret;
            u84.count.Text = string.format("%d/%d", math_min_ret, math_max_ret2);
        end;

        if v86 and (p81 and not v89) then
            u84.tickScale.Scale = 0;
            task.delay(TweenInfo_new_ret2.Time * 0.8, function() -- Line: 391
                -- upvalues: TweenService (ref), u84 (copy), TweenInfo_new_ret3 (ref)
                TweenService:Create(u84.tickScale, TweenInfo_new_ret3, {
                    Scale = 1
                }):Play();
            end);
        else
            u84.tickScale.Scale = 1;
        end;

        u13[v.id] = {
            progress = math_min_ret,
            complete = v86
        };
    end;

    for i = #v82 + 1, #u12 do
        u12[i].frame.Visible = false;
        local _ = i;
    end;

    u21.Text = string.format("%d/%d", v83, #v82);
    local v98 = #v82 * 74 + 48 - 8;
    local v99 = false;

    for _, v in u25 do
        v.button.Position = UDim2.fromOffset(v.x, v98 + 10);
        v.refresh();

        if not v99 then
            v99 = (u9 and u9.daily and (u9.daily.refreshProductId or u9.daily.autoCompleteProductId)) ~= nil;
        end;
    end;

    for _, v in u25 do
        v.button.Visible = v99;
    end;

    if v99 then
        v98 = v98 + 40;
    end;

    u23.Position = UDim2.fromOffset(14, v98 + 9);
    u24.Position = UDim2.fromOffset(202, v98 + 9);
    Frame.Size = UDim2.fromOffset(336, v98 + 34);
    refreshTimer();
end;

local function setOpen(p100, p101) -- Line: 423
    -- upvalues: u11 (ref), Frame2 (copy), TextButton2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    u11 = p100;
    local v102;

    if p100 then
        v102 = UDim2.new(0, 0, 0, 0);
    else
        v102 = UDim2.new(0, 476, 0, 0);
    end;

    local v103;

    if p100 then
        v103 = UDim2.new(1, 174, 0, 0);
    else
        v103 = UDim2.new(1, 0, 0, 0);
    end;

    if p101 then
        Frame2.Position = v102;
        TextButton2.Position = v103;
    else
        TweenService:Create(Frame2, TweenInfo_new_ret, {
            Position = v102
        }):Play();
        TweenService:Create(TextButton2, TweenInfo_new_ret, {
            Position = v103
        }):Play();
    end;

    Frame2.Interactable = p100;
    TextButton2.Interactable = not p100;
end;

local function show(p104) -- Line: 439
    -- upvalues: u9 (ref), u10 (ref), u11 (ref), setOpen (copy)
    if u9 then
        u10(p104);
    end;

    if not u11 then
        setOpen(true);
    end;
end;

local u105 = nil;

local function reveal(p106) -- Line: 450
    -- upvalues: LocalPlayer (copy), Frame (copy), u105 (ref), u9 (ref), u10 (ref), u11 (ref), setOpen (copy), u8 (ref)
    if LocalPlayer:GetAttribute("QuestTrackerClosed") == true then
        return;
    end;

    if not Frame.Visible then
        u105 = u105 or p106;

        return;
    end;

    if u9 then
        u10(p106);
    end;

    if not u11 then
        setOpen(true);
    end;

    u8 = os.clock() + 4;
end;

TextButton.Activated:Connect(function() -- Line: 462, Name: putAway
    -- upvalues: u8 (ref), setOpen (copy), LocalPlayer (copy)
    u8 = nil;
    setOpen(false);
    LocalPlayer:SetAttribute("QuestTrackerClosed", true);
end);
TextButton2.Activated:Connect(function() -- Line: 468
    -- upvalues: u8 (ref), u11 (ref), setOpen (copy), LocalPlayer (copy), u9 (ref), u10 (ref)
    u8 = nil;

    if not u11 then
        if u9 then
            u10(true);
        end;

        if not u11 then
            setOpen(true);
        end;

        return;
    end;

    u8 = nil;
    setOpen(false);
    LocalPlayer:SetAttribute("QuestTrackerClosed", true);
end);
task.spawn(function() -- Line: 476
    -- upvalues: u8 (ref), Frame (copy), setOpen (copy), ScreenGui (copy), refreshTimer (copy)
    local v107 = 0;

    while true do
        task.wait(0.25);

        if u8 and not Frame.Visible then
            u8 = os.clock() + 4;
        elseif u8 and u8 <= os.clock() then
            u8 = nil;
            setOpen(false);
        end;

        v107 = v107 + 1;

        if v107 >= 120 then
            v107 = 0;

            if ScreenGui.Enabled then
                refreshTimer();
            end;
        end;
    end;
end);
local u108 = {};

local function anchorTo(p109) -- Line: 499
    -- upvalues: u108 (copy), UIScale (copy), ScreenGui (copy), Frame (copy), u105 (ref), LocalPlayer (copy), u9 (ref), u10 (ref), u11 (ref), setOpen (copy), u8 (ref)
    for _, v in u108 do
        v:Disconnect();
    end;

    table.clear(u108);
    local Updates = p109:WaitForChild("Updates", 10);

    if not (Updates and Updates:IsA("GuiObject")) then
        return;
    end;

    local function place() -- Line: 508
        -- upvalues: Updates (copy), UIScale (ref), ScreenGui (ref), Frame (ref)
        local math_max_ret = math.max(0.4, Updates.AbsoluteSize.X / 164);
        UIScale.Scale = math_max_ret;
        Frame.Position = UDim2.fromOffset(Updates.AbsolutePosition.X + Updates.AbsoluteSize.X - ScreenGui.AbsolutePosition.X, Updates.AbsolutePosition.Y + Updates.AbsoluteSize.Y - ScreenGui.AbsolutePosition.Y + math_max_ret * 8);
    end;

    local PropertyChangedSignal = Updates:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(u108, PropertyChangedSignal:Connect(place));
    local PropertyChangedSignal2 = Updates:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u108, PropertyChangedSignal2:Connect(place));
    local PropertyChangedSignal3 = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u108, PropertyChangedSignal3:Connect(place));
    local PropertyChangedSignal4 = Updates:GetPropertyChangedSignal("Visible");
    table.insert(u108, PropertyChangedSignal4:Connect(function() -- Line: 518
        -- upvalues: Frame (ref), Updates (copy), u105 (ref), LocalPlayer (ref), u9 (ref), u10 (ref), u11 (ref), setOpen (ref), u8 (ref)
        Frame.Visible = Updates.Visible;

        if Frame.Visible and u105 ~= nil then
            local v110 = u105;
            u105 = nil;

            if LocalPlayer:GetAttribute("QuestTrackerClosed") == true then
                return;
            end;

            if not Frame.Visible then
                u105 = u105 or v110;

                return;
            end;

            if u9 then
                u10(v110);
            end;

            if not u11 then
                setOpen(true);
            end;

            u8 = os.clock() + 4;
        end;
    end));
    Frame.Visible = Updates.Visible;
    place();
end;

Frame.Position = UDim2.new(1, -14, 0, 58);
u11 = false;
local UDim2_new_ret = UDim2.new(0, 476, 0, 0);
local UDim2_new_ret2 = UDim2.new(1, 0, 0, 0);
Frame2.Position = UDim2_new_ret;
TextButton2.Position = UDim2_new_ret2;
Frame2.Interactable = false;
TextButton2.Interactable = true;
ScreenGui.Parent = PlayerGui;
task.spawn(function() -- Line: 532
    -- upvalues: PlayerGui (copy), anchorTo (copy)
    local ValleyHUD = PlayerGui:WaitForChild("ValleyHUD", 60);

    if ValleyHUD then
        anchorTo(ValleyHUD);
    end;

    PlayerGui.ChildAdded:Connect(function(p111) -- Line: 537
        -- upvalues: anchorTo (ref)
        if p111.Name == "ValleyHUD" and p111:IsA("ScreenGui") then
            anchorTo(p111);
        end;
    end);
end);
local u112 = false;
local u113 = true;
QuestEvent.OnClientEvent:Connect(function(p114, p115) -- Line: 547
    -- upvalues: ValleyToast (copy), u9 (ref), u28 (ref), u17 (ref), u14 (ref), ScreenGui (copy), u1 (copy), LocalPlayer (copy), u112 (ref), u113 (ref), Frame (copy), u105 (ref), u10 (ref), u11 (ref), setOpen (copy), u8 (ref)
    if type(p115) ~= "table" then
        return;
    end;

    if p114 == "Toast" then
        if type(p115.text) == "string" then
            ValleyToast.show("✓ QUEST COMPLETE  ·  " .. p115.text, 3);
        end;

        return;
    end;

    if p114 ~= "State" then
        return;
    end;

    u9 = p115;

    if u28 and type(p115.message) == "string" then
        u28 = nil;
    end;

    if type(p115.serverNow) == "number" then
        u17 = p115.serverNow - os.time();
    end;

    local v116;

    if p115.loaded == true and p115.mode == "Daily" then
        v116 = type(p115.daily) == "table";
    else
        v116 = false;
    end;

    u14 = v116;
    local v117 = u14;

    if v117 then
        v117 = true;

        for _, v in u1 do
            if LocalPlayer:GetAttribute(v) == true then
                v117 = false;
                break;
            end;
        end;
    end;

    ScreenGui.Enabled = v117;

    if not ScreenGui.Enabled then
        return;
    end;

    if LocalPlayer:GetAttribute("InMatch") == true or not (u112 or u113) then
        if u11 then
            u10(true);

            if u8 then
                u8 = os.clock() + 4;
            end;
        end;

        return;
    end;

    local v118 = not u113;

    if LocalPlayer:GetAttribute("QuestTrackerClosed") ~= true then
        if Frame.Visible then
            if u9 then
                u10(v118);
            end;

            if not u11 then
                setOpen(true);
            end;

            u8 = os.clock() + 4;
        else
            u105 = u105 or v118;
        end;
    end;

    u113 = false;
end);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 584
    -- upvalues: LocalPlayer (copy), u112 (ref), u105 (ref), u8 (ref), u11 (ref), setOpen (copy), u9 (ref), ScreenGui (copy), Frame (copy), u10 (ref)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u112 = false;
        u105 = nil;

        if u8 then
            u8 = nil;
        end;

        if u11 then
            setOpen(false);
        end;
    elseif u9 then
        u112 = true;

        if ScreenGui.Enabled and LocalPlayer:GetAttribute("QuestTrackerClosed") ~= true then
            if Frame.Visible then
                if u9 then
                    u10(true);
                end;

                if not u11 then
                    setOpen(true);
                end;

                u8 = os.clock() + 4;
            else
                u105 = u105 or true;
            end;
        end;

        task.delay(10, function() -- Line: 601
            -- upvalues: u112 (ref)
            u112 = false;
        end);
    end;
end);

for _, v in u1 do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(function() -- Line: 608
        -- upvalues: u14 (ref), u1 (copy), LocalPlayer (copy), ScreenGui (copy), Frame (copy), u105 (ref), u9 (ref), u10 (ref), u11 (ref), setOpen (copy), u8 (ref)
        local v119 = u14;

        if v119 then
            v119 = true;

            for _, v2 in u1 do
                if LocalPlayer:GetAttribute(v2) == true then
                    v119 = false;
                    break;
                end;
            end;
        end;

        if v119 ~= ScreenGui.Enabled then
            ScreenGui.Enabled = v119;

            if v119 and LocalPlayer:GetAttribute("InMatch") ~= true then
                if LocalPlayer:GetAttribute("QuestTrackerClosed") == true then
                    return;
                end;

                if not Frame.Visible then
                    u105 = u105 or false;

                    return;
                end;

                if u9 then
                    u10(false);
                end;

                if not u11 then
                    setOpen(true);
                end;

                u8 = os.clock() + 4;
            end;
        end;
    end);
end;

LocalPlayer:GetAttributeChangedSignal("QuestTrackerClosed"):Connect(function() -- Line: 620
    -- upvalues: LocalPlayer (copy), u11 (ref), u8 (ref), setOpen (copy)
    if LocalPlayer:GetAttribute("QuestTrackerClosed") == true and (u11 and u8) then
        u8 = nil;
        setOpen(false);
    end;
end);
QuestEvent:FireServer("Get");