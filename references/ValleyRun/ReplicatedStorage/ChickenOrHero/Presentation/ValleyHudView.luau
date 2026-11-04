 

 

local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local HudIcons = require(script.Parent.HudIcons);
local Theme = Skin.Theme;
local Palette = Skin.Palette;
local u1 = {
    Ink = Theme.Ink,
    Paper = Theme.Paper,
    Gold = Theme.Gold,
    Mint = Theme.Mint,
    Blue = Theme.Blue,
    Muted = Theme.Muted,
    Hover = Theme.Ink:Lerp(Color3.new(1, 1, 1), 0.08),
    Away = Theme.Ink:Lerp(Theme.Mint, 0.2),
    Order = { "Shop", "Inventory", "Journey", "Abilities", "Settings", "Codes" },
    Labels = {
        Shop = "SHOP",
        Inventory = "KNIVES",
        Spectate = "SPECTATE",
        Journey = "JOURNEY",
        Abilities = "ABILITIES",
        AFK = "AFK: Off",
        Settings = "SETTINGS",
        Codes = "CODES",
        Music = "MUSIC · ON",
        Servers = "SERVERS",
        Updates = "UPDATE LOG"
    }
};
u1.Colors = {
    Shop = u1.Gold,
    Inventory = u1.Mint,
    Spectate = u1.Blue,
    Journey = Palette.gem,
    Abilities = u1.Blue,
    AFK = u1.Paper,
    Settings = u1.Paper,
    Codes = u1.Gold,
    Music = u1.Mint,
    Servers = u1.Blue,
    Updates = u1.Gold
};

local function make(...) -- Line: 45
    -- upvalues: Panels (copy)
    return Panels.make(...);
end;

local UDim_new_ret = UDim.new(0, 8);
local UDim_new_ret2 = UDim.new(0, 12);
local UDim_new_ret3 = UDim.new(1, 0);
local Color3_new_ret = Color3.new(0, 0, 0);
local Color3_new_ret2 = Color3.new(1, 1, 1);

local function skinTile(p2, p3) -- Line: 55
    -- upvalues: u1 (copy), Skin (copy), UDim_new_ret (copy), HudIcons (copy), UDim_new_ret3 (copy)
    local v4 = u1.Colors[p3] or u1.Gold;
    Skin.button(p2, "dark", {
        radius = UDim_new_ret
    });
    local Icon = p2:FindFirstChild("Icon");

    if Icon then
        HudIcons.skin(Icon, p3);
    end;

    local Caption = p2:FindFirstChild("Caption");

    if Caption then
        Skin.text(Caption, "primary", {
            stroke = 1
        });
    end;

    for _, v in { "Accent", "StateDot" } do
        local v5 = p2:FindFirstChild(v);

        if v5 then
            v5.BackgroundColor3 = v4;
            v5.BorderSizePixel = 0;
            Skin.corner(v5, UDim_new_ret3);
        end;
    end;

    return p2;
end;

u1.skinTile = skinTile;

local function skinPanel(p6, p7) -- Line: 78
    -- upvalues: Skin (copy), UDim_new_ret2 (copy), u1 (copy), Palette (copy)
    if p6 then
        Skin.shade(p6);
    end;

    Skin.panel(p7, {
        radius = UDim_new_ret2
    });
    local TopRule = p7:FindFirstChild("TopRule");

    if TopRule then
        Skin.band(TopRule, {
            color = u1.Gold
        });
    end;

    local Rule = p7:FindFirstChild("Rule");

    if Rule then
        Skin.band(Rule, {
            color = Palette.neutral
        });
        Rule.BackgroundTransparency = 0;
    end;

    local Eyebrow = p7:FindFirstChild("Eyebrow");

    if Eyebrow then
        Skin.text(Eyebrow, "gold", {
            stroke = 1
        });
    end;

    local Heading = p7:FindFirstChild("Heading");

    if Heading then
        Skin.text(Heading, "primary");
    end;

    local Close = p7:FindFirstChild("Close");

    if Close then
        Skin.button(Close, "close");
    end;

    return p7;
end;

local u8 = setmetatable({}, {
    __mode = "k"
});

function u1.toggle(p9, p10) -- Line: 108
    -- upvalues: u8 (copy), Skin (copy), UDim_new_ret (copy)
    local v11 = p10 == true;

    if u8[p9] == v11 then
        return;
    end;

    u8[p9] = v11;
    Skin.button(p9, v11 and "primary" or "danger", {
        radius = UDim_new_ret
    });
end;

local u12 = setmetatable({}, {
    __mode = "k"
});

function u1.awayLook(p13, p14) -- Line: 118
    -- upvalues: u1 (copy), u12 (copy), Skin (copy)
    local v15 = p14 == true;
    p13.BackgroundColor3 = v15 and u1.Away or u1.Ink;

    if u12[p13] ~= v15 then
        u12[p13] = v15;
        Skin.select(p13, v15, u1.Mint);
    end;
end;

local u16 = setmetatable({}, {
    __mode = "k"
});

function u1.musicIcon(p17, p18) -- Line: 128
    -- upvalues: u16 (copy), HudIcons (copy)
    local v19 = p18 == true;

    if u16[p17] == v19 then
        return;
    end;

    u16[p17] = v19;
    local Icon = p17:FindFirstChild("Icon");

    if Icon then
        HudIcons.skin(Icon, v19 and "MusicOff" or "Music");
    end;
end;

local u20 = { "MusicLabel", "EmoteLabel", "MuteLabel", "EmoteSoundsLabel", "HintsLabel", "ChatNotificationsLabel", "DisableBotsLabel", "ShowHitboxesLabel", "PrivateInvitesLabel", "BoardRankLabel", "HostButtonLabel" };
local u21 = { "Zero", "Max", "Footer", "BotsNote" };
local u22 = { "Mute", "EmoteSounds", "Hints", "ChatNotifications", "DisableBots", "ShowHitboxes", "PrivateInvites", "BoardRank", "HostButton" };

local function skinSettings(p23) -- Line: 159
    -- upvalues: Skin (copy), u20 (copy), u21 (copy), u22 (copy), u1 (copy), Color3_new_ret2 (copy), UDim_new_ret3 (copy), Palette (copy)
    local Rows = p23:FindFirstChild("Rows");

    if Rows then
        Skin.scroll(Rows);
    end;

    for _, v in u20 do
        local v24 = p23:FindFirstChild(v, true);

        if v24 then
            Skin.text(v24, "primary", {
                stroke = 1
            });
        end;
    end;

    for _, v in u21 do
        local v25 = p23:FindFirstChild(v, true);

        if v25 then
            Skin.text(v25, "secondary", {
                stroke = 1
            });
        end;
    end;

    for _, v in { "Volume", "EmoteVolume" } do
        local v26 = p23:FindFirstChild(v, true);

        if v26 then
            Skin.text(v26, "green", {
                stroke = 1
            });
        end;
    end;

    for _, v in u22 do
        local v27 = p23:FindFirstChild(v, true);

        if v27 then
            u1.toggle(v27, v27.Text == "ON");
        end;
    end;

    for _, v in { "MusicSlider", "EmoteSlider" } do
        local v28 = p23:FindFirstChild(v, true);
        local v29;

        if v28 then
            v29 = v28:FindFirstChild("Track");
        else
            v29 = v28;
        end;

        if v29 then
            Skin.bar(v29, v28:FindFirstChild("Fill"), "blue");
            local Knob = v28:FindFirstChild("Knob");

            if Knob then
                Knob.BackgroundColor3 = Color3_new_ret2;
                Knob.BorderSizePixel = 0;
                Skin.corner(Knob, UDim_new_ret3);
                Skin.outline(Knob, 2);
                Skin.ring(Knob, Palette.knobRing, 1.5);
            end;
        end;
    end;
end;

local function skinTimer(p30, p31) -- Line: 205
    -- upvalues: Skin (copy), Color3_new_ret (copy)
    if p30 and p30:IsA("TextLabel") then
        Skin.text(p30, p31, {
            stroke = false
        });
        local v32 = Skin.textStroke(p30, 1.5);

        if v32 then
            v32.Color = Color3_new_ret;
        end;
    end;
end;

local u33 = setmetatable({}, {
    __mode = "k"
});

function u1.skin(p34) -- Line: 216
    -- upvalues: u33 (copy), Skin (copy), UDim_new_ret (copy), skinTile (copy), UDim_new_ret2 (copy), u1 (copy), Color3_new_ret2 (copy), Color3_new_ret (copy), skinTimer (copy), skinPanel (copy), skinSettings (copy)
    if u33[p34] then
        return p34;
    end;

    u33[p34] = true;
    local Wallet = p34:FindFirstChild("Wallet");

    if Wallet then
        for _, v in { "Coins", "Gems" } do
            local v35 = Wallet:FindFirstChild(v);

            if v35 then
                Skin.pill(v35, v == "Coins" and "coins" or "gems", {
                    icon = v35:FindFirstChild("Icon"),
                    amount = v35:FindFirstChild("Value"),
                    radius = UDim_new_ret
                });
                local Label = v35:FindFirstChild("Label");

                if Label then
                    Skin.text(Label, "secondary", {
                        stroke = 1
                    });
                end;
            end;
        end;
    end;

    for _, v in { "Servers", "Updates", "Spectate", "AFKToggle" } do
        local v36 = p34:FindFirstChild(v);

        if v36 then
            skinTile(v36, v == "AFKToggle" and "AFK" or v);
        end;
    end;

    local DrawerClip = p34:FindFirstChild("DrawerClip");

    if DrawerClip then
        DrawerClip = DrawerClip:FindFirstChild("Panel");
    end;

    if DrawerClip then
        Skin.panel(DrawerClip, {
            radius = UDim_new_ret2
        });
    end;

    local Navigation = p34:FindFirstChild("Navigation");

    if Navigation then
        DrawerClip = Navigation;
    elseif DrawerClip then
        DrawerClip = DrawerClip:FindFirstChild("Navigation");
    end;

    if DrawerClip then
        for _, v in u1.Order do
            local v37 = DrawerClip:FindFirstChild(v);

            if v37 then
                skinTile(v37, v);
            end;
        end;

        local Music = DrawerClip:FindFirstChild("Music");

        if Music then
            skinTile(Music, "Music");
        end;

        local CursorHint = DrawerClip:FindFirstChild("CursorHint");

        if CursorHint then
            Skin.text(CursorHint, "secondary", {
                stroke = 1
            });
        end;
    end;

    local MenuToggle = p34:FindFirstChild("MenuToggle");

    if MenuToggle then
        Skin.button(MenuToggle, "dark", {
            radius = UDim_new_ret
        });
        local Arrow = MenuToggle:FindFirstChild("Arrow");

        if Arrow then
            Skin.text(Arrow, "gold", {
                stroke = 1.5
            });
        end;

        local Label = MenuToggle:FindFirstChild("Label");

        if Label then
            Skin.text(Label, "primary", {
                stroke = 1
            });
        end;
    end;

    local Notice = p34:FindFirstChild("Notice");

    if Notice then
        Notice.TextColor3 = Color3_new_ret2;
        Notice.TextStrokeColor3 = Color3_new_ret;
    end;

    skinTimer(p34:FindFirstChild("2xCoinsTimer"), "gold");
    skinTimer(p34:FindFirstChild("2xGemsTimer"), "gem");

    for _, v in { "Settings", "Updates" } do
        local v38 = p34:FindFirstChild(v .. "Shade");
        local v39;

        if v38 then
            v39 = v38:FindFirstChild("Panel");
        else
            v39 = v38;
        end;

        if v39 then
            skinPanel(v38, v39);
        end;
    end;

    local v40 = p34:FindFirstChild("SettingsShade") and p34.SettingsShade:FindFirstChild("Panel");

    if v40 then
        skinSettings(v40);
    end;

    local v41 = p34:FindFirstChild("UpdatesShade") and p34.UpdatesShade:FindFirstChild("Panel");

    if v41 then
        v41 = v41:FindFirstChild("Entries");
    end;

    if v41 then
        Skin.scroll(v41);
    end;

    return p34;
end;

function u1.afkMark(p42, p43) -- Line: 306
    -- upvalues: HudIcons (copy)
    HudIcons.mark(p42:FindFirstChild("Icon"), p43);
end;

local u44 = {
    AFK = true,
    Spectate = true
};

function u1.tile(p45, p46, p47) -- Line: 311
    -- upvalues: Panels (copy), u1 (copy), u44 (copy), Palette (copy), HudIcons (copy), make (copy), skinTile (copy)
    local v48 = Panels.button(p45, p46, "", 0, 0, p47 and 208 or 100, p47 and 34 or 58, u1.Ink);

    if u44[p46] then
        v48:SetAttribute("SelfManagedText", true);
    end;

    v48.BackgroundTransparency = 0.12;
    v48.AutoButtonColor = false;
    v48.Corner.CornerRadius = UDim.new(0, 5);
    Panels.stroke(v48, Palette.neutral, 0.62);
    local v49 = u1.Colors[p46] or u1.Gold;
    local v50 = HudIcons.draw(v48, p46, v49);
    v50.Position = UDim2.fromOffset(p47 and 11 or 12, p47 and 5 or 9);

    if p47 then
        v50.Size = UDim2.fromOffset(24, 24);
    end;

    local v51 = Panels.text(v48, "Caption", u1.Labels[p46], p47 and 44 or 11, p47 and 6 or 38, p47 and 150 or 84, 20, 14, u1.Paper);
    v51.Font = Enum.Font.GothamBold;
    v51.TextWrapped = false;

    if u44[p46] then
        v51.TextScaled = true;
    end;

    make("Frame", v48, "Accent", {
        BorderSizePixel = 0,
        BackgroundTransparency = 0.18,
        Position = UDim2.new(0, 11, 1, -2),
        Size = UDim2.fromOffset(p47 and 186 or 78, 2),
        BackgroundColor3 = v49
    });
    make("Frame", v48, "StateDot", {
        BorderSizePixel = 0,
        Visible = false,
        Position = UDim2.new(1, -13, 0, 10),
        Size = UDim2.fromOffset(4, 4),
        BackgroundColor3 = v49
    });
    skinTile(v48, p46);

    return v48;
end;

local function panel(p52, p53, p54, p55, p56, p57) -- Line: 361
    -- upvalues: make (copy), Panels (copy), u1 (copy), skinPanel (copy)
    local v58 = make("Frame", p52, p53 .. "Shade", {
        BackgroundTransparency = 0.38,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new()
    });
    Panels.fullscreenShade(p52, v58);
    local v59 = make("Frame", v58, "Panel", {
        BorderSizePixel = 0,
        Active = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(p54, p55),
        BackgroundColor3 = u1.Ink
    });
    Panels.corner(v59, 8);
    Panels.stroke(v59, u1.Gold, 0.55);
    make("UIScale", v59, "Scale", {});
    make("Frame", v59, "TopRule", {
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 3),
        BackgroundColor3 = u1.Gold
    });
    Panels.text(v59, "Eyebrow", p57, 24, 20, p54 - 110, 18, 11, u1.Gold);
    Panels.text(v59, "Heading", p56, 24, 44, p54 - 90, 36, 28, u1.Paper).Font = Enum.Font.GothamBold;
    local v60 = Panels.button(v59, "Close", "×", p54 - 64, 20, 42, 42, u1.Ink);
    v60.Modal = true;
    v60.TextSize = 27;
    make("Frame", v59, "Rule", {
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(24, 96),
        Size = UDim2.new(1, -48, 0, 1),
        BackgroundColor3 = u1.Gold
    });
    skinPanel(v58, v59);

    return v59;
end;

local u61 = {
    EmoteLabel = true,
    EmoteVolume = true,
    EmoteSlider = true
};

local function ensureEmoteSlider(p62, p63, p64, p65) -- Line: 402
    -- upvalues: Panels (copy), u1 (copy), make (copy)
    if p62:FindFirstChild("EmoteSlider") then
        return;
    end;

    Panels.text(p62, "EmoteLabel", "EMOTE VOLUME", 24, 214 - p63, 300, 24, 14, u1.Paper).Font = Enum.Font.GothamBold;
    Panels.text(p62, "EmoteVolume", "100%", 379, 214 - p63, 84, 24, 14, u1.Mint).TextXAlignment = Enum.TextXAlignment.Right;
    local v66 = make("TextButton", p62, "EmoteSlider", {
        Text = "",
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Position = UDim2.fromOffset(24, 244 - p63),
        Size = UDim2.fromOffset(442, 44)
    });
    make("Frame", v66, "Track", {
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, -3),
        Size = UDim2.new(1, 0, 0, 6),
        BackgroundColor3 = p64
    });
    Panels.corner(v66.Track, 3);
    make("Frame", v66, "Fill", {
        BorderSizePixel = 0,
        Position = v66.Track.Position,
        Size = v66.Track.Size,
        BackgroundColor3 = p65
    });
    Panels.corner(v66.Fill, 3);
    local v67 = make("Frame", v66, "Knob", {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = u1.Paper
    });
    Panels.corner(v67, 10);
end;

local function shiftForEmote(p68, p69) -- Line: 435
    -- upvalues: u61 (copy)
    for _, child in p68:GetChildren() do
        if child:IsA("GuiObject") and not (u61[child.Name] or (child.Position.Y.Offset + p69 < 220 or child:GetAttribute("EmoteShiftedY") == child.Position.Y.Offset)) then
            child.Position = child.Position + UDim2.fromOffset(0, 82);
            child:SetAttribute("EmoteShiftedY", child.Position.Y.Offset);
        end;
    end;
end;

function u1.ensureDrawer(p70) -- Line: 446
    -- upvalues: u1 (copy), ensureEmoteSlider (copy), Palette (copy), Panels (copy), make (copy)
    local v71 = p70:FindFirstChild("Navigation") or p70:FindFirstChild("DrawerClip") and p70.DrawerClip.Panel:FindFirstChild("Navigation");

    if v71 then
        for i, v in u1.Order do
            if not v71:FindFirstChild(v) then
                u1.tile(v71, v).Position = UDim2.fromOffset((i - 1) % 2 * 108, math.floor((i - 1) / 2) * 66);
            end;
        end;
    end;

    local v72 = p70:FindFirstChild("SettingsShade") and p70.SettingsShade:FindFirstChild("Panel");

    if v72 then
        local Rows = v72:FindFirstChild("Rows");
        ensureEmoteSlider(Rows or v72, Rows and 100 or 0, Palette.track, u1.Mint);
    end;

    if v72 and not v72:FindFirstChild("ChatNotifications", true) then
        Panels.text(v72, "ChatNotificationsLabel", "Chat notifications", 24, 341, 280, 34, 15, u1.Paper);
        Panels.button(v72, "ChatNotifications", "ON", 368, 341, 98, 38, Palette.button);
    end;

    if v72 and not v72:FindFirstChild("EmoteSounds", true) then
        Panels.text(v72, "EmoteSoundsLabel", "Mute others\' emotes", 24, 286, 280, 34, 15, u1.Paper);
        Panels.button(v72, "EmoteSounds", "OFF", 368, 284, 98, 38, Palette.button);
    end;

    if v72 and not v72:FindFirstChild("DisableBots", true) then
        Panels.text(v72, "DisableBotsLabel", "Disable bots", 24, 341, 280, 34, 15, u1.Paper).Visible = false;
        Panels.button(v72, "DisableBots", "OFF", 368, 341, 98, 38, Palette.button).Visible = false;
        Panels.text(v72, "BotsNote", "Lobby: immediate. Matches: next match.", 24, 385, 442, 30, 11, u1.Paper).Visible = false;
    end;

    if v72 and not v72:FindFirstChild("ShowHitboxes", true) then
        Panels.text(v72, "ShowHitboxesLabel", "Show hitboxes", 24, 423, 280, 34, 15, u1.Paper).Visible = false;
        Panels.button(v72, "ShowHitboxes", "OFF", 368, 423, 98, 38, Palette.button).Visible = false;
    end;

    if v72 and not v72:FindFirstChild("PrivateInvites", true) then
        Panels.text(v72, "PrivateInvitesLabel", "Private server invites", 24, 461, 280, 34, 15, u1.Paper);
        Panels.button(v72, "PrivateInvites", "ON", 368, 461, 98, 38, Palette.button);
    end;

    if v72 and not v72:FindFirstChild("HostButton", true) then
        Panels.text(v72, "HostButtonLabel", "Show host button", 24, 521, 280, 34, 15, u1.Paper).Visible = false;
        Panels.button(v72, "HostButton", "ON", 368, 521, 98, 38, Palette.button).Visible = false;
    end;

    if v72 and not v72:FindFirstChild("BoardRank", true) then
        Panels.text(v72, "BoardRankLabel", "Show my leaderboard rank", 24, 521, 280, 34, 15, u1.Paper);
        Panels.button(v72, "BoardRank", "ON", 368, 521, 98, 38, Palette.button);
    end;

    if v72 and not v72:FindFirstChild("Rows") then
        local v73 = make("ScrollingFrame", v72, "Rows", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 5,
            Selectable = false,
            Position = UDim2.fromOffset(0, 100),
            Size = UDim2.new(1, 0, 1, -100),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.None,
            CanvasSize = UDim2.fromOffset(0, 0)
        });

        for _, child in v72:GetChildren() do
            if child ~= v73 and (child:IsA("GuiObject") and child.Position.Y.Offset >= 100) then
                child.Position = child.Position - UDim2.fromOffset(0, 100);
                child.Parent = v73;
            end;
        end;
    end;

    if not p70:FindFirstChild("AFKToggle") then
        local v74 = u1.tile(p70, "AFK", true);
        v74.Name = "AFKToggle";
        v74.Visible = false;
    end;

    if not p70:FindFirstChild("Spectate") then
        u1.tile(p70, "Spectate", true).Visible = false;
    end;

    local v75 = p70:FindFirstChild("Navigation") or p70:FindFirstChild("DrawerClip") and p70.DrawerClip.Panel:FindFirstChild("Navigation");

    if v75 and v75:FindFirstChild("Spectate") then
        v75.Spectate:Destroy();
    end;

    if v75 and v75:FindFirstChild("AFK") then
        v75.AFK:Destroy();
    end;

    for _, v in { "SettingsShade", "UpdatesShade" } do
        local v76 = p70:FindFirstChild(v);

        if v76 then
            Panels.fullscreenShade(p70, v76);
        end;
    end;

    if p70:FindFirstChild("DrawerClip") then
        u1.skin(p70);

        return;
    end;

    local v77 = make("Frame", make("Frame", p70, "DrawerClip", {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Active = false,
        Size = UDim2.fromScale(1, 1)
    }), "Panel", {
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Visible = false,
        BackgroundColor3 = u1.Ink
    });
    Panels.corner(v77, 8);
    Panels.stroke(v77, u1.Gold, 0.75);
    p70.Navigation.Parent = v77;
    local v78 = Panels.button(p70, "MenuToggle", "", 8, 100, 52, 58, u1.Ink);
    v78.BackgroundTransparency = 0.08;
    v78.AutoButtonColor = false;
    v78.ZIndex = 3;
    v78.Corner.CornerRadius = UDim.new(0, 5);
    Panels.stroke(v78, u1.Gold, 0.5);
    local v79 = Panels.text(v78, "Arrow", "›", 0, 1, 52, 34, 28, u1.Gold);
    v79.TextXAlignment = Enum.TextXAlignment.Center;
    v79.Font = Enum.Font.GothamBold;
    v79.ZIndex = 4;
    local v80 = Panels.text(v78, "Label", "MENU", 0, 35, 52, 17, 10, u1.Paper);
    v80.TextXAlignment = Enum.TextXAlignment.Center;
    v80.Font = Enum.Font.GothamBold;
    v80.ZIndex = 4;
    make("NumberValue", p70, "DrawerReveal", {
        Value = 0
    });
    u1.skin(p70);
end;

function u1.positionDrawer(p81) -- Line: 577
    local v82 = p81:GetAttribute("DrawerWidth") or 220;
    local v83 = p81:GetAttribute("DrawerTop") or 90;
    p81.DrawerClip.Panel.Position = UDim2.fromOffset(-v82 - 4 + (v82 + 72) * p81.DrawerReveal.Value, v83);
    p81.MenuToggle.Position = UDim2.fromOffset(8, (p81:GetAttribute("DrawerCenter") or 180) - 22);
end;

function u1.build(p84) -- Line: 584
    -- upvalues: make (copy), u1 (copy), Panels (copy), Palette (copy), HudIcons (copy), panel (copy)
    local v85 = make("ScreenGui", p84, "ValleyHUD", {
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 62,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    });
    local v86 = make("Frame", v85, "Navigation", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(208, 232)
    });
    make("UIScale", v86, "Scale", {});

    for i, v in u1.Order do
        u1.tile(v86, v).Position = UDim2.fromOffset((i - 1) % 2 * 108, math.floor((i - 1) / 2) * 66);
    end;

    u1.tile(v86, "Music", true).Position = UDim2.fromOffset(0, 198);
    Panels.text(v86, "CursorHint", "ALT  ·  CURSOR", 0, 239, 208, 16, 10, Palette.textSecondary).TextXAlignment = Enum.TextXAlignment.Center;
    local v87 = make("Frame", v85, "Wallet", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(220, 100),
        AnchorPoint = Vector2.new(0, 1)
    });
    make("UIScale", v87, "Scale", {});

    for i, v in { "Coins", "Gems" } do
        local v88 = make("Frame", v87, v, {
            BackgroundTransparency = 0.24,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(0, (i - 1) * 50),
            Size = UDim2.fromOffset(220, 44),
            BackgroundColor3 = u1.Ink
        });
        Panels.corner(v88, 5);
        Panels.stroke(v88, v == "Coins" and u1.Gold or u1.Mint, 0.72);
        HudIcons.draw(v88, v, v == "Coins" and u1.Gold or u1.Mint).Position = UDim2.fromOffset(10, 10);
        local v89 = Panels.text(v88, "Value", "—", 45, 3, 166, 26, 23, v == "Coins" and u1.Gold or u1.Mint);
        v89.Font = Enum.Font.GothamBold;
        v89.TextScaled = true;
        v89.TextWrapped = false;
        make("UITextSizeConstraint", v89, "TextLimits", {
            MinTextSize = 11,
            MaxTextSize = 23
        });
        Panels.text(v88, "Label", v:upper(), 46, 27, 165, 12, 9, Palette.textSecondary);
    end;

    local v90 = u1.tile(v85, "Servers", true);
    v90.AnchorPoint = Vector2.new(0.2, 0);
    v90.Position = UDim2.fromScale(0.652729392, 0.016025955);
    make("UIScale", v90, "Scale", {});
    local v91 = u1.tile(v85, "Updates", true);
    v91.AnchorPoint = Vector2.new(1, 0);
    make("UIScale", v91, "Scale", {});
    local v92 = Panels.text(v85, "Notice", "", 0, 0, 208, 34, 13, u1.Paper);
    v92.BackgroundTransparency = 1;
    v92.Font = Enum.Font.GothamMedium;
    v92.TextStrokeColor3 = u1.Ink;
    v92.TextStrokeTransparency = 0.4;
    v92.Visible = false;
    local v93 = panel(v85, "Settings", 490, 378, "SETTINGS", "VALLEY RUN  /  MAKE YOURSELF AT HOME");
    Panels.text(v93, "MusicLabel", "MUSIC VOLUME", 24, 117, 300, 24, 14, u1.Paper).Font = Enum.Font.GothamBold;
    Panels.text(v93, "Volume", "100%", 379, 117, 84, 24, 14, u1.Mint).TextXAlignment = Enum.TextXAlignment.Right;
    local v94 = make("TextButton", v93, "MusicSlider", {
        Text = "",
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Position = UDim2.fromOffset(24, 152),
        Size = UDim2.fromOffset(442, 44)
    });
    make("Frame", v94, "Track", {
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, -3),
        Size = UDim2.new(1, 0, 0, 6),
        BackgroundColor3 = Palette.track
    });
    Panels.corner(v94.Track, 3);
    make("Frame", v94, "Fill", {
        BorderSizePixel = 0,
        Position = v94.Track.Position,
        Size = v94.Track.Size,
        BackgroundColor3 = u1.Mint
    });
    Panels.corner(v94.Fill, 3);
    local v95 = make("Frame", v94, "Knob", {
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = u1.Paper
    });
    Panels.corner(v95, 10);
    Panels.text(v93, "Zero", "0", 24, 194, 40, 16, 10, u1.Paper);
    Panels.text(v93, "Max", "100", 426, 194, 40, 16, 10, u1.Paper).TextXAlignment = Enum.TextXAlignment.Right;
    Panels.text(v93, "MuteLabel", "Mute music", 24, 226, 260, 34, 15, u1.Paper);
    Panels.button(v93, "Mute", "OFF", 368, 224, 98, 38, Palette.button);
    Panels.text(v93, "HintsLabel", "Spectator control hints", 24, 286, 320, 34, 15, u1.Paper);
    Panels.button(v93, "Hints", "ON", 368, 284, 98, 38, Palette.button);
    Panels.text(v93, "Footer", "Sound effects stay on.", 24, 341, 440, 18, 11, Palette.textSecondary);
    local v96 = make("ScrollingFrame", panel(v85, "Updates", 590, 542, "FIELD NOTES", "VALLEY RUN  /  UPDATE LOG"), "Entries", {
        ScrollBarThickness = 4,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        ClipsDescendants = true,
        Position = UDim2.fromOffset(24, 113),
        Size = UDim2.new(1, -48, 1, -133),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarImageColor3 = u1.Gold
    });
    make("UIListLayout", v96, "List", {
        Padding = UDim.new(0.025, 0),
        SortOrder = Enum.SortOrder.LayoutOrder
    });
    make("UIPadding", v96, "Padding", {
        PaddingBottom = UDim.new(0.02, 0),
        PaddingRight = UDim.new(0.02, 0)
    });
    u1.ensureDrawer(v85);

    return v85;
end;

function u1.layout(p97) -- Line: 698
    -- upvalues: u1 (copy), shiftForEmote (copy)
    u1.ensureDrawer(p97);
    local AbsoluteSize = p97.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return;
    end;

    local v98 = AbsoluteSize.Y < 500;
    local TouchEnabled = game:GetService("UserInputService").TouchEnabled;
    local v99 = AbsoluteSize.X < AbsoluteSize.Y;
    local math_min_ret = math.min(AbsoluteSize.X / 1380, AbsoluteSize.Y / 760);
    local math_clamp_ret = math.clamp(math_min_ret, v98 and 0.74 or 0.82, 1.15);
    local Navigation = p97.DrawerClip.Panel.Navigation;

    for i, v in u1.Order do
        local v100 = Navigation[v];
        v100.Size = UDim2.fromOffset(100, v98 and 49 or 58);
        v100.Position = UDim2.fromOffset((i - 1) % 2 * 108, math.floor((i - 1) / 2) * (v98 and 55 or 66));
        v100.Icon.Position = UDim2.fromOffset(12, v98 and 4 or 9);
        v100.Caption.Position = UDim2.fromOffset(11, v98 and 28 or 38);
        v100.Accent.Size = UDim2.fromOffset(78, 2);
    end;

    local v101 = math.ceil(#u1.Order / 2) * (v98 and 55 or 66);
    Navigation.Music.Position = UDim2.fromOffset(0, v101);
    Navigation.Size = UDim2.fromOffset(208, v101 + 34);
    Navigation.Scale.Scale = math_clamp_ret;
    Navigation.Position = UDim2.fromOffset(12, 12);
    local v102 = Navigation.Size.X.Offset * math_clamp_ret + 24;
    local v103 = (Navigation.Size.Y.Offset + (TouchEnabled and 0 or 25)) * math_clamp_ret + 24;
    local v104 = AbsoluteSize.Y * 0.38 - 22;
    local math_max_ret = math.max(12, AbsoluteSize.Y - 290);
    local v105 = math.clamp(v104, 12, math_max_ret) + 22;
    p97.MenuToggle.Size = UDim2.fromOffset(44, 44);
    p97.MenuToggle.Arrow.Position = UDim2.fromOffset(0, 0);
    p97.MenuToggle.Arrow.Size = UDim2.fromOffset(44, 28);
    p97.MenuToggle.Arrow.TextSize = 24;
    p97.MenuToggle.Label.Position = UDim2.fromOffset(0, 28);
    p97.MenuToggle.Label.Size = UDim2.fromOffset(44, 14);
    p97.MenuToggle.Label.TextSize = 8;
    local math_min_ret2 = math.min(v105 - v103 * 0.5, AbsoluteSize.Y - v103 - 16);
    local math_max_ret2 = math.max(58, math_min_ret2);
    p97.DrawerClip.Panel.Size = UDim2.fromOffset(v102, v103);
    p97:SetAttribute("DrawerWidth", v102);
    p97:SetAttribute("DrawerTop", math_max_ret2);
    p97:SetAttribute("DrawerCenter", v105);
    u1.positionDrawer(p97);
    local AFKToggle = p97.AFKToggle;
    AFKToggle.Size = UDim2.fromOffset(44, 44);
    AFKToggle.Position = UDim2.fromOffset(8, v105 + 78);
    AFKToggle.Icon.Size = UDim2.fromOffset(22, 22);
    AFKToggle.Icon.Position = UDim2.fromOffset(11, 4);
    AFKToggle.Caption.Position = UDim2.fromOffset(0, 28);
    AFKToggle.Caption.Size = UDim2.fromOffset(44, 14);
    AFKToggle.Caption.TextSize = 8;
    AFKToggle.Caption.TextXAlignment = Enum.TextXAlignment.Center;
    AFKToggle.Accent.Visible = false;
    AFKToggle.BackgroundTransparency = 0.25;
    local Spectate = p97.Spectate;
    Spectate.Size = UDim2.fromOffset(44, 44);
    Spectate.Position = UDim2.fromOffset(8, v105 + 128);
    Spectate.Icon.Size = UDim2.fromOffset(22, 22);
    Spectate.Icon.Position = UDim2.fromOffset(11, 4);
    Spectate.Caption.Position = UDim2.fromOffset(0, 28);
    Spectate.Caption.Size = UDim2.fromOffset(44, 14);
    Spectate.Caption.TextSize = 8;
    Spectate.Caption.TextXAlignment = Enum.TextXAlignment.Center;
    Spectate.Accent.Visible = false;
    Spectate.BackgroundTransparency = 0.25;
    Navigation.CursorHint.Position = UDim2.fromOffset(0, v101 + 41);
    p97.Wallet.Scale.Scale = math_clamp_ret;
    p97.Wallet.Position = UDim2.new(0, 14, 1, -14);

    if v98 then
        p97.Wallet.Size = UDim2.fromOffset(285, 44);

        for i, v in { "Coins", "Gems" } do
            local v106 = p97.Wallet[v];
            v106.Position = UDim2.fromOffset((i - 1) * 146, 0);
            v106.Size = UDim2.fromOffset(139, 44);
            v106.Value.Size = UDim2.fromOffset(88, 26);
            v106.Value.TextSize = 19;
            v106.Label.Size = UDim2.fromOffset(88, 12);
        end;
    else
        p97.Wallet.Size = UDim2.fromOffset(220, 100);

        for i, v in { "Coins", "Gems" } do
            local v107 = p97.Wallet[v];
            v107.Position = UDim2.fromOffset(0, (i - 1) * 50);
            v107.Size = UDim2.fromOffset(220, 44);
            v107.Value.Size = UDim2.fromOffset(166, 26);
            v107.Value.TextSize = 23;
            v107.Label.Size = UDim2.fromOffset(165, 12);
        end;
    end;

    if TouchEnabled and v98 then
        p97.Wallet.Scale.Scale = math.min(math_clamp_ret, 0.66);
        p97.Wallet.Size = UDim2.fromOffset(139, 90);

        for i, v in { "Coins", "Gems" } do
            p97.Wallet[v].Position = UDim2.fromOffset(0, (i - 1) * 46);
        end;

        p97.Wallet.Position = UDim2.new(0, AFKToggle.Position.X.Offset, 1, -6);
    elseif TouchEnabled then
        p97.Wallet.Position = UDim2.new(0, AFKToggle.Position.X.Offset, 1, v98 and -32 or -14);

        if not v98 then
            p97.Wallet.Size = UDim2.fromOffset(180, 100);

            for _, v in { "Coins", "Gems" } do
                local v108 = p97.Wallet[v];
                v108.Size = UDim2.fromOffset(180, 44);
                v108.Value.Size = UDim2.fromOffset(126, 26);
                v108.Label.Size = UDim2.fromOffset(125, 12);
            end;
        end;
    end;

    if v98 then
        math_clamp_ret = math_clamp_ret * 0.75;
    end;

    for _, v in { "Servers", "Updates" } do
        local v109 = p97[v];
        v109.Size = UDim2.fromOffset(164, 38);
        v109.Scale.Scale = math_clamp_ret;
        v109.AnchorPoint = Vector2.new(1, 0);
        v109.Caption.Size = UDim2.new(1, -48, 1, -10);
        v109.Accent.Size = UDim2.new(1, -22, 0, 2);
    end;

    p97.Updates.Position = UDim2.new(1, -14, 0, 10);
    p97.Servers.Position = UDim2.new(1, -14 - math_clamp_ret * 172, 0, 10);

    if AbsoluteSize.X < 600 then
        p97.Servers.Position = UDim2.new(1, -14, 0, 10);
        p97.Updates.Position = UDim2.new(1, -14, 0, math_clamp_ret * 46 + 10);
    end;

    p97.Notice.Position = UDim2.fromOffset(80, (math.max(4, math_max_ret2 - 39)));
    p97.Notice.Size = UDim2.fromOffset(v102 - 24, 34);
    p97.Notice.TextSize = v98 and 12 or 13;
    local Panel = p97.SettingsShade.Panel;
    local v110 = Panel:FindFirstChild("Rows") or Panel;
    local u111 = v110 == Panel and 0 or 100;

    local function place(p112, p113, p114) -- Line: 838
        -- upvalues: u111 (copy)
        p112.Position = UDim2.fromOffset(p113, p114 - u111);
    end;

    local v115 = v99 and 430 or 490;
    local Attribute = workspace:GetAttribute("PrivateServerSettingsOwnerId");
    local v116;

    if type(Attribute) == "number" and Attribute > 0 then
        v116 = Attribute == game.Players.LocalPlayer.UserId;
    else
        v116 = false;
    end;

    v110.DisableBots.Visible = v116;
    v110.DisableBotsLabel.Visible = v116;
    v110.BotsNote.Visible = v116;
    v110.EmoteSounds.Position = UDim2.fromOffset(v115 - 122, 284 - u111);
    v110.EmoteSoundsLabel.Position = UDim2.fromOffset(24, 286 - u111);
    v110.EmoteSoundsLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.HintsLabel.Position = UDim2.fromOffset(24, 346 - u111);
    v110.ChatNotificationsLabel.Position = UDim2.fromOffset(24, 401 - u111);
    v110.ChatNotifications.Position = UDim2.fromOffset(v115 - 122, 401 - u111);
    v110.ChatNotificationsLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.PrivateInvites.Position = UDim2.fromOffset(v115 - 122, 461 - u111);
    v110.PrivateInvitesLabel.Position = UDim2.fromOffset(24, 461 - u111);
    v110.PrivateInvitesLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.BoardRank.Position = UDim2.fromOffset(v115 - 122, 521 - u111);
    v110.BoardRankLabel.Position = UDim2.fromOffset(24, 521 - u111);
    v110.BoardRankLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.DisableBots.Position = UDim2.fromOffset(v115 - 122, 581 - u111);
    v110.DisableBotsLabel.Position = UDim2.fromOffset(24, 581 - u111);
    v110.BotsNote.Position = UDim2.fromOffset(24, 625 - u111);
    v110.DisableBotsLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.BotsNote.Size = UDim2.fromOffset(v115 - 48, 30);
    v110.ShowHitboxes.Visible = v116;
    v110.ShowHitboxesLabel.Visible = v116;
    v110.ShowHitboxes.Position = UDim2.fromOffset(v115 - 122, 663 - u111);
    v110.ShowHitboxesLabel.Position = UDim2.fromOffset(24, 663 - u111);
    v110.ShowHitboxesLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    local Attribute2 = workspace:GetAttribute("PrivateServerHostId");
    local v117;

    if type(Attribute2) == "number" and Attribute2 > 0 then
        v117 = Attribute2 == game.Players.LocalPlayer.UserId;
    else
        v117 = false;
    end;

    local v118 = v116 and 717 or 581;
    v110.HostButton.Visible = v117;
    v110.HostButtonLabel.Visible = v117;
    v110.HostButton.Position = UDim2.fromOffset(v115 - 122, v118 - u111);
    v110.HostButtonLabel.Position = UDim2.fromOffset(24, v118 - u111);
    v110.HostButtonLabel.Size = UDim2.fromOffset(v115 - 160, 34);

    if v117 then
        v118 = v118 + 60;
    end;

    v110.Footer.Position = UDim2.fromOffset(24, v118 - u111);
    local v119 = v118 + 37;
    Panel.Close.Position = UDim2.fromOffset(v115 - 64, 20);
    v110.Volume.Position = UDim2.fromOffset(v115 - 111, 117 - u111);
    v110.MusicSlider.Size = UDim2.fromOffset(v115 - 48, 44);
    v110.Max.Position = UDim2.fromOffset(v115 - 64, 194 - u111);
    v110.Mute.Position = UDim2.fromOffset(v115 - 122, 224 - u111);
    v110.Hints.Position = UDim2.fromOffset(v115 - 122, 344 - u111);
    v110.HintsLabel.Size = UDim2.fromOffset(v115 - 160, 34);
    v110.Footer.Size = UDim2.fromOffset(v115 - 48, 18);

    if v110:FindFirstChild("EmoteSlider") then
        v110.EmoteVolume.Position = UDim2.fromOffset(v115 - 111, 214 - u111);
        v110.EmoteSlider.Size = UDim2.fromOffset(v115 - 48, 44);
        shiftForEmote(v110, u111);
        v119 = v119 + 82;
    end;

    local Panel2 = p97.UpdatesShade.Panel;
    Panel2.Scale.Scale = 1;
    Panel2.Size = UDim2.fromScale(v99 and 0.92 or (TouchEnabled and 0.88 or 0.42), v99 and 0.78 or (TouchEnabled and 0.86 or 0.68));
    Panel2.Eyebrow.Position = UDim2.fromScale(0.045, 0.035);
    Panel2.Eyebrow.Size = UDim2.fromScale(0.75, 0.035);
    Panel2.Eyebrow.TextScaled = true;
    Panel2.Heading.Position = UDim2.fromScale(0.045, 0.085);
    Panel2.Heading.Size = UDim2.fromScale(0.78, 0.07);
    Panel2.Heading.TextScaled = true;
    Panel2.Close.Position = UDim2.fromScale(0.88, 0.035);
    Panel2.Close.Size = UDim2.fromScale(0.08, 0.075);
    Panel2.Close.TextScaled = true;
    Panel2.Rule.Position = UDim2.fromScale(0.045, 0.175);
    Panel2.Rule.Size = UDim2.fromScale(0.91, 0.002);
    Panel2.TopRule.Size = UDim2.fromScale(1, 0.006);
    Panel2.Entries.Position = UDim2.fromScale(0.045, 0.2);
    Panel2.Entries.Size = UDim2.fromScale(0.91, 0.76);
    Panel2.Entries.ScrollBarThickness = 0;
    local v120;

    if v110 == Panel then
        v120 = v119;
    else
        v120 = math.min(v119, 470);
    end;

    local v121 = AbsoluteSize.X * 0.94 / v115;
    local math_max_ret3 = math.max(0.75, AbsoluteSize.Y * 0.9 / v120);
    local math_min_ret3 = math.min(1.1, v121, math_max_ret3);
    Panel.Scale.Scale = math_min_ret3;
    local v122;

    if v110 == Panel then
        v122 = v119;
    else
        v122 = math.min(v120, AbsoluteSize.Y * 0.9 / math_min_ret3);
    end;

    Panel.Size = UDim2.fromOffset(v115, v122);

    if v110 ~= Panel then
        v110.CanvasSize = UDim2.fromOffset(0, v119 - u111);
    end;
end;

return u1;