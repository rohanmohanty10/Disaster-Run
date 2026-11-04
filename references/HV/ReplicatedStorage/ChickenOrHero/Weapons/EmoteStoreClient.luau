 

 

local Players = game:GetService("Players");
local Parent = script.Parent.Parent;
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local ValleyToast = require(Parent.Presentation.ValleyToast);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local CharacterPreview = require(Parent.Interface.CharacterPreview);
local EmoteSound = require(Parent.Interface.EmoteSound);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;
u1.RARITY = {
    Common = Color3.fromRGB(175, 185, 192),
    Rare = Color3.fromRGB(92, 173, 238),
    Epic = Color3.fromRGB(183, 123, 244),
    Legendary = Color3.fromRGB(242, 191, 89)
};
u1.CRATE = Color3.fromRGB(255, 120, 200);
local InventoryInk = Theme.InventoryInk;
local u2 = (-1 / 0);

function u1.comingSoon() -- Line: 36
    -- upvalues: u2 (ref), ValleyToast (copy)
    if os.clock() - u2 >= 2 then
        u2 = os.clock();
        ValleyToast.show("Coming soon!");
    end;
end;

function u1.accent(p3) -- Line: 43
    -- upvalues: u1 (copy), EmoteCatalog (copy), Theme (copy)
    return u1.RARITY[EmoteCatalog.rarity(p3) or ""] or Theme.Purple;
end;

local function upper(p4) -- Line: 49
    return string.gsub(string.upper(p4), "\195([\160-\182\184-\190])", function(p5) -- Line: 50
        local v6 = string.byte(p5) - 32;

        return "\195" .. string.char(v6);
    end);
end;

function u1.source(p7) -- Line: 56
    -- upvalues: EmoteCatalog (copy)
    return not p7.Source and (p7.Free and "FREE FOR EVERYONE" or ((p7.Route == "Free" or p7.Route == "Premium") and "UNLOCK IN JOURNEY" or (EmoteCatalog.sold(p7.Id) and (EmoteCatalog.inCrate(p7.Id) and "DAILY SHOP  ·  EMOTE CRATE" or "DAILY SHOP") or "EMOTE CRATE"))) or string.gsub(string.upper(p7.Source), "\195([\160-\182\184-\190])", function(p8) -- Line: 50
        local v9 = string.byte(p8) - 32;

        return "\195" .. string.char(v9);
    end);
end;

function u1.soundButton(p10, p11) -- Line: 71
    -- upvalues: Panels (copy), Theme (copy), Skin (copy)
    local v12 = Panels.make("ImageButton", p10, "SoundButton", {
        BorderSizePixel = 0,
        AutoButtonColor = true,
        Image = "",
        Visible = false,
        ZIndex = 3,
        BackgroundColor3 = Theme.Ink:Lerp(p11, 0.18),
        Size = UDim2.fromOffset(36, 36)
    });
    Panels.corner(v12, 18);
    Panels.stroke(v12, p11, 0.4);
    Panels.make("ImageLabel", v12, "Icon", {
        BackgroundTransparency = 1,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        ImageColor3 = Theme.Paper,
        ScaleType = Enum.ScaleType.Fit
    });
    Skin.button(v12, "dark");
    v12.BackgroundTransparency = 0.15;

    return v12;
end;

function u1.setEnabled(p13, p14) -- Line: 99
    local v15 = p14 == true;

    if p13:GetAttribute("Enabled") ~= v15 then
        p13:SetAttribute("Enabled", v15);
        p13.Active = v15;
        p13.AutoButtonColor = v15;
        p13.TextTransparency = v15 and 0 or 0.45;
    end;
end;

local function label(p16, p17, p18, p19, p20, p21) -- Line: 110
    -- upvalues: Panels (copy), Skin (copy)
    local v22 = Panels.text(p16, p17, p18, 0, 0, 10, 10, p19, p20);
    v22.Font = p21 and Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v22, p19 >= 13 and 2 or 1.5);

    return v22;
end;

local function box(p23, p24, p25, p26, p27) -- Line: 117
    p23.Position = UDim2.fromOffset(p24, p25);
    p23.Size = UDim2.fromOffset(p26, p27);
end;

local function slotOf(p28, p29) -- Line: 122
    -- upvalues: EmoteCatalog (copy)
    for i = 1, EmoteCatalog.Slots do
        if p28[i] == p29 then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

function u1.new(p30) -- Line: 131
    -- upvalues: Panels (copy), u1 (copy), Theme (copy), InventoryInk (copy), Skin (copy), EmoteSound (copy), EmoteCatalog (copy)
    local v31 = Panels.make("Frame", p30.canvas, "Emotes", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false
    });
    local v32 = {
        open = false,
        retryAt = 0,
        store = p30,
        root = v31,
        remote = script.Parent:WaitForChild("ArmoryEvent"),
        cards = {},
        slots = {},
        connections = {}
    };
    local u33 = setmetatable(v32, u1);

    local function connect(p34, p35) -- Line: 143
        -- upvalues: u33 (copy)
        table.insert(u33.connections, p34:Connect(p35));
    end;

    local v36 = Panels.make("Frame", v31, "Overview", {});
    Theme.surface(v36, InventoryInk:Lerp(Theme.Purple, 0.05), Theme.Purple, 8, 0.66);
    Skin.card(v36, Theme.Purple);
    u33.left = v36;
    u33.viewport = Panels.make("ViewportFrame", v36, "Preview", {
        BackgroundTransparency = 1,
        LightDirection = Vector3.new(-1, -1, -1),
        Ambient = Color3.fromRGB(205, 210, 220),
        LightColor = Color3.new(1, 1, 1)
    });
    local v37 = Panels.text(v36, "Hint", "DRAG TO ROTATE", 0, 0, 10, 10, 11, Theme.Muted);
    v37.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v37, 1.5);
    u33.hint = v37;
    u33.hint.TextXAlignment = Enum.TextXAlignment.Center;
    u33.hint.Visible = false;
    local v38 = Panels.text(v36, "Source", "", 0, 0, 10, 10, 12, Theme.Purple);
    v38.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v38, 1.5);
    u33.sourceLabel = v38;
    local v39 = Panels.text(v36, "Title", "MY EMOTES", 0, 0, 10, 10, 28, Theme.Paper);
    v39.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v39, 2);
    u33.nameLabel = v39;
    u33.nameLabel.TextWrapped = false;
    u33.nameLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    local v40 = Panels.text(v36, "Line1", "", 0, 0, 10, 10, 15, Theme.Paper);
    v40.Font = Enum.Font.GothamMedium;
    Skin.textStroke(v40, 2);
    u33.line1 = v40;
    local v41 = Panels.text(v36, "Line2", "", 0, 0, 10, 10, 13, Theme.Muted);
    v41.Font = Enum.Font.GothamMedium;
    Skin.textStroke(v41, 2);
    u33.line2 = v41;
    u33.soundButton = u1.soundButton(v36, Theme.Purple);
    u33.sound = EmoteSound.new(u33.soundButton);

    for i = 1, EmoteCatalog.Slots do
        local v42 = Panels.button(v36, "Slot" .. i, tostring(i), 0, 0, 40, 40);
        Theme.button(v42, Theme.Purple, InventoryInk:Lerp(Theme.Purple, 0.1));
        Skin.button(v42, "dark");
        v42.TextSize = 17;
        u33.slots[i] = {
            button = v42
        };
        table.insert(u33.connections, v42.Activated:Connect(function() -- Line: 173
            -- upvalues: u33 (copy), i (copy)
            u33:equip(i);
        end));
        local _ = i;
    end;

    local v43 = Panels.make("ScrollingFrame", v31, "List", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Theme.Purple,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        CanvasSize = UDim2.new(),
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    });
    u33.list = v43;
    Skin.scroll(v43);
    local v44 = Panels.make("TextButton", v43, "GetEmotes", {
        Text = "",
        AutoButtonColor = true,
        BorderSizePixel = 0
    });
    Theme.surface(v44, InventoryInk:Lerp(u1.CRATE, 0.12), u1.CRATE, 8, 0.4);
    Skin.card(v44, u1.CRATE);
    local v45 = Panels.text(v44, "Plus", "+", 0, 0, 10, 10, 30, u1.CRATE);
    v45.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v45, 2);
    v45.TextXAlignment = Enum.TextXAlignment.Center;
    v45.Position = UDim2.fromOffset(6, 0);
    v45.Size = UDim2.new(0, 34, 1, 0);
    local v46 = Panels.text(v44, "NameLabel", "GET EMOTES", 0, 0, 10, 10, 15, Theme.Paper);
    v46.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v46, 2);
    v46.Position = UDim2.fromOffset(46, 12);
    v46.Size = UDim2.new(1, -54, 0, 20);
    v46.TextWrapped = false;
    local v47 = Panels.text(v44, "Status", "OPEN THE EMOTE CRATE", 0, 0, 10, 10, 10, u1.CRATE);
    v47.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v47, 1.5);
    v47.Position = UDim2.fromOffset(46, 35);
    v47.Size = UDim2.new(1, -54, 0, 14);
    v47.TextWrapped = false;
    v47.TextTruncate = Enum.TextTruncate.AtEnd;
    u33.getCard = v44;
    u33.getStatus = v47;
    table.insert(u33.connections, v44.Activated:Connect(function() -- Line: 207
        -- upvalues: u33 (copy), EmoteCatalog (ref), u1 (ref)
        if not u33.open then
            return;
        end;

        if EmoteCatalog.ComingSoon then
            u1.comingSoon();

            return;
        end;

        script.Parent.ArmoryNavigation:Fire("EmoteCrate");
    end));
    local v48 = Panels.text(v43, "EquippedHeading", "EQUIPPED  ·  YOUR EMOTE WHEEL", 0, 0, 10, 10, 12, Theme.Purple);
    v48.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v48, 1.5);
    u33.equippedHeading = v48;
    u33.equippedHeading.TextWrapped = false;

    return u33;
end;

function u1.addCard(u49, u50, u51) -- Line: 224
    -- upvalues: EmoteCatalog (copy), u1 (copy), Theme (copy), Panels (copy), InventoryInk (copy), Skin (copy)
    local u52;

    if u50 == "" then
        u52 = nil;
    else
        u52 = EmoteCatalog.get(u50) or nil;
    end;

    local v53 = u52 and u1.accent(u50) or Theme.Muted;
    local v54;

    if u51 then
        v54 = "Slot" .. u51 or u50;
    else
        v54 = u50;
    end;

    local v55 = Panels.make("TextButton", u49.list, v54, {
        Text = "",
        AutoButtonColor = true,
        BorderSizePixel = 0
    });
    Theme.surface(v55, InventoryInk:Lerp(v53, u52 and 0.1 or 0.03), v53, 8, u52 and 0.55 or 0.78);
    Skin.card(v55, u52 and v53 and v53 or nil);
    Panels.make("Frame", v55, "Accent", {
        BorderSizePixel = 0,
        BackgroundColor3 = v53,
        BackgroundTransparency = u52 and 0 or 0.6,
        Position = UDim2.fromOffset(0, 12),
        Size = UDim2.new(0, 3, 1, -24)
    });
    local v56;

    if u51 then
        local v57 = tostring(u51);
        local v58 = Panels.text(v55, "Number", v57, 0, 0, 10, 10, 20, u52 and v53 and v53 or Theme.Muted);
        v58.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(v58, 2);
        v58.TextXAlignment = Enum.TextXAlignment.Center;
        v58.Position = UDim2.fromOffset(8, 0);
        v58.Size = UDim2.new(0, 24, 1, 0);
        v56 = 38;
    else
        v56 = 14;
    end;

    local v59 = u52 and 15 or 12;
    local v60 = Panels.text(v55, "NameLabel", u52 and (u52.Name or "EMPTY  ·  TAP TO EQUIP HERE") or "EMPTY  ·  TAP TO EQUIP HERE", 0, 0, 10, 10, v59, u52 and Theme.Paper or Theme.Muted);
    v60.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
    Skin.textStroke(v60, v59 >= 13 and 2 or 1.5);
    v60.Position = UDim2.fromOffset(v56, u52 and 12 or 0);
    v60.Size = u52 and UDim2.new(1, -v56 - 8, 0, 20) or UDim2.new(1, -v56 - 8, 1, 0);
    v60.TextWrapped = not u52;
    v60.TextTruncate = u52 and Enum.TextTruncate.AtEnd or Enum.TextTruncate.None;

    if u52 then
        local v61 = u51 and "TAP TO UNEQUIP" or u1.source(u52);
        local v62 = Panels.text(v55, "Status", v61, 0, 0, 10, 10, 10, Theme.Muted);
        v62.Font = Enum.Font.GothamBold or Enum.Font.GothamMedium;
        Skin.textStroke(v62, 1.5);
        v62.Position = UDim2.fromOffset(v56, 35);
        v62.Size = UDim2.new(1, -v56 - 8, 0, 14);
        v62.TextWrapped = false;
        v62.TextTruncate = Enum.TextTruncate.AtEnd;
    end;

    v55.Activated:Connect(function() -- Line: 269
        -- upvalues: u52 (copy), u51 (copy), u49 (copy), u50 (copy)
        if u52 and u51 then
            u49:unequip(u51, u50);

            return;
        end;

        if u52 then
            u49:select(u50);

            return;
        end;

        if u51 then
            u49:equip(u51);
        end;
    end);
    local cards = u49.cards;
    local v63 = {
        id = u50,
        slot = u51,
        button = v55,
        border = v55:FindFirstChild("Border"),
        accent = v53,
        idle = u52 and 0.55 or 0.78
    };
    table.insert(cards, v63);
end;

function u1.rebuild(p64, p65, p66) -- Line: 288
    for _, v in p64.cards do
        v.button:Destroy();
    end;

    table.clear(p64.cards);

    for _, v in p65 do
        p64:addCard(v);
    end;

    for i, v in p66 do
        p64:addCard(v, i);
    end;

    p64.painted = nil;
    p64:layoutList();
end;

function u1.layoutList(p67) -- Line: 303
    local listWidth = p67.listWidth;

    if not listWidth then
        return;
    end;

    local v68 = listWidth - 12;
    local math_floor_ret = math.floor((v68 + 10) / 178);
    local math_max_ret = math.max(1, math_floor_ret);
    local v69 = (v68 - (math_max_ret - 1) * 10) / math_max_ret;
    local getCard = p67.getCard;
    getCard.Position = UDim2.fromOffset(0, 2);
    getCard.Size = UDim2.fromOffset(v69, 62);
    local v70 = 1;

    for _, v in p67.cards do
        if not v.slot then
            local button = v.button;
            local v71 = math.floor(v70 / math_max_ret) * 72 + 2;
            button.Position = UDim2.fromOffset(v70 % math_max_ret * (v69 + 10), v71);
            button.Size = UDim2.fromOffset(v69, 62);
            v70 = v70 + 1;
        end;
    end;

    local v72 = math.ceil(v70 / math_max_ret) * 72 + 2 + 6;
    local equippedHeading = p67.equippedHeading;
    equippedHeading.Position = UDim2.fromOffset(0, v72);
    equippedHeading.Size = UDim2.fromOffset(v68, 18);
    local v73 = v72 + 28;
    local v74 = 0;

    for _, v in p67.cards do
        if v.slot then
            local button = v.button;
            local v75 = v73 + math.floor(v74 / math_max_ret) * 72;
            button.Position = UDim2.fromOffset(v74 % math_max_ret * (v69 + 10), v75);
            button.Size = UDim2.fromOffset(v69, 62);
            v74 = v74 + 1;
        end;
    end;

    local v76 = v73 + (math.ceil(v74 / math_max_ret) * 72 + 2);
    p67.list.CanvasSize = UDim2.fromOffset(0, v76);
end;

function u1.play(p77) -- Line: 336
    local preview = p77.preview;

    if not preview then
        return;
    end;

    if p77.selected then
        preview:play(p77.selected);
    else
        preview:stop();
    end;

    p77.hint.Visible = preview.model ~= nil;
end;

function u1.select(p78, p79) -- Line: 349
    -- upvalues: EmoteCatalog (copy)
    if p79 == p78.selected or not EmoteCatalog.get(p79) then
        return;
    end;

    p78.selected = p79;
    p78:play();
    p78:refresh();
end;

function u1.unequip(p80, p81, p82) -- Line: 359
    -- upvalues: EmoteCatalog (copy), u1 (copy), LocalPlayer (copy)
    if not p80.open then
        return;
    end;

    if EmoteCatalog.ComingSoon then
        u1.comingSoon();

        return;
    end;

    local v83 = p80.store.state or {};

    if v83.loaded ~= true or (v83.pending or LocalPlayer:GetAttribute("InMatch") == true) then
        return;
    end;

    p80:select(p82);
    p80.remote:FireServer("EquipEmote", "", p81);
end;

function u1.equip(p84, p85) -- Line: 376
    -- upvalues: EmoteCatalog (copy), u1 (copy), LocalPlayer (copy)
    if not p84.open then
        return;
    end;

    if EmoteCatalog.ComingSoon then
        u1.comingSoon();

        return;
    end;

    local v86 = p84.store.state or {};
    local selected = p84.selected;

    if not (selected and (v86.emotes and (v86.emotes[selected] and (v86.loaded == true and (not v86.pending and LocalPlayer:GetAttribute("InMatch") ~= true))))) then
        return;
    end;

    p84.remote:FireServer("EquipEmote", (v86.emoteSlots or {})[p85] == selected and "" or selected, p85);
end;

function u1.refresh(p87) -- Line: 400
    -- upvalues: EmoteCatalog (copy)
    if not p87.open then
        return;
    end;

    local v88 = p87.store.state or {};
    local v89 = v88.emotes or {};
    local v90 = v88.emoteSlots or {};
    local v91 = {};
    local v92 = {};

    for _, v in EmoteCatalog.Entries do
        if v89[v.Id] then
            local Id = v.Id;
            local v93 = v;
            local v94 = nil;

            for i = 1, EmoteCatalog.Slots do
                if v90[i] == Id then
                    v94 = i;
                    break;
                end;

                local _ = i;
            end;

            if not v94 then
                table.insert(v91, v93.Id);
            end;
        end;
    end;

    for i = 1, EmoteCatalog.Slots do
        local v95 = v90[i];
        v92[i] = (type(v95) ~= "string" or not (v89[v95] and (EmoteCatalog.get(v95) and v95))) and "" or v95;
        local _ = i;
    end;

    local v96 = table.concat(v92, ",") .. "|" .. table.concat(v91, ",");

    if v96 ~= p87.signature then
        p87.signature = v96;
        p87:rebuild(v91, v92);
    end;

    if not (p87.selected and v89[p87.selected]) then
        local v97 = nil;

        for _, v in v92 do
            if v ~= "" then
                v97 = v;
                break;
            end;
        end;

        p87.selected = v97 or v91[1];
        p87:play();
    end;

    p87:paint(v88, v90);
end;

function u1.paint(p98, p99, p100) -- Line: 436
    -- upvalues: Skin (copy), EmoteCatalog (copy), u1 (copy), LocalPlayer (copy)
    local selected = p98.selected;

    if p98.painted ~= selected then
        p98.painted = selected;

        for _, v in p98.cards do
            if v.border then
                local v101;

                if selected == nil then
                    v101 = false;
                else
                    v101 = v.id == selected;
                end;

                Skin.select(v.button, v101);
            end;
        end;
    end;

    local v102;

    if selected then
        v102 = EmoteCatalog.get(selected);
    else
        v102 = selected;
    end;

    p98.sound:set(v102 and selected and selected or nil);
    local v103 = p99.loaded == true;
    local ComingSoon = EmoteCatalog.ComingSoon;
    local v104 = type(p99.freeCrates) == "table" and (tonumber(p99.freeCrates.Emote) or 0) or 0;
    p98.getStatus.Text = v104 <= 0 and "OPEN THE EMOTE CRATE" or ("FREE: %d  ·  OPEN THE EMOTE CRATE"):format(v104);

    if v102 then
        local v105 = nil;

        for i = 1, EmoteCatalog.Slots do
            if p100[i] == selected then
                v105 = i;
                break;
            end;

            local _ = i;
        end;

        local v106 = u1.accent(selected);
        p98.nameLabel.Text = v102.Name;
        p98.sourceLabel.Text = u1.source(v102);
        p98.sourceLabel.TextColor3 = v106;
        p98.line1.Text = ComingSoon and "Emotes are coming soon." or (v103 and (v105 and string.format("In slot %d. Pick another slot to move it.", v105) or "Pick a slot below to equip it.") or "Loading your emotes…");
        p98.line2.Text = "Loops until you move." .. (EmoteCatalog.soundId(selected) and " Has a sound." or "") .. ((ComingSoon or EmoteCatalog.available(selected)) and "" or " Animation coming soon.");
    else
        p98.nameLabel.Text = v103 and "NO EMOTES YET" or "MY EMOTES";
        p98.sourceLabel.Text = "";
        p98.line1.Text = v103 and "Open the Emote Crate to get your first emote." or "Loading your emotes…";
        p98.line2.Text = "";
    end;

    local v107;

    if v102 == nil then
        v107 = false;
    else
        v107 = p98.open and (v103 and not (p99.pending or ComingSoon)) and LocalPlayer:GetAttribute("InMatch") ~= true;
    end;

    for i, v in p98.slots do
        local v108;

        if v102 == nil then
            v108 = false;
        else
            v108 = p100[i] == selected;
        end;

        if v.holds ~= v108 then
            v.holds = v108;
            Skin.button(v.button, v108 and "primary" or "dark");
        end;

        u1.setEnabled(v.button, v107);

        if ComingSoon then
            v.button.Active = true;
        end;
    end;
end;

function u1.setOpen(p109, p110) -- Line: 496
    -- upvalues: CharacterPreview (copy)
    local v111 = p110 == true;

    if v111 == p109.open then
        return;
    end;

    p109.open = v111;
    p109.root.Visible = v111;

    if v111 then
        p109.preview = CharacterPreview.new(p109.viewport);
        local selected = p109.selected;
        p109:refresh();

        if p109.selected == selected then
            p109:play();
        end;
    else
        p109.sound:stop();

        if p109.preview then
            p109.preview:destroy();
            p109.preview = nil;
        end;

        p109.hint.Visible = false;
    end;
end;

function u1.layout(p112, p113, p114, p115, p116, p117) -- Line: 521
    p112.root.Position = p113;
    p112.root.Size = p114;
    local v118 = p117 and p115 - 8;

    if not v118 then
        local math_min_ret = math.min(420, p115 * 0.4);
        v118 = math.floor(math_min_ret);
    end;

    local v119;

    if p117 then
        local math_min_ret = math.min(440, p116 * 0.6);
        v119 = math.floor(math_min_ret) or p116;
    else
        v119 = p116;
    end;

    local left = p112.left;
    left.Position = UDim2.fromOffset(0, 0);
    left.Size = UDim2.fromOffset(v118, v119);
    local math_max_ret = math.max(100, v119 - 176);
    local viewport = p112.viewport;
    viewport.Position = UDim2.fromOffset(12, 12);
    viewport.Size = UDim2.fromOffset(v118 - 24, math_max_ret);
    local hint = p112.hint;
    hint.Position = UDim2.fromOffset(12, math_max_ret + 12 - 20);
    hint.Size = UDim2.fromOffset(v118 - 24, 16);
    local v120 = math_max_ret + 12 + 10;
    local sourceLabel = p112.sourceLabel;
    sourceLabel.Position = UDim2.fromOffset(16, v120);
    sourceLabel.Size = UDim2.fromOffset(v118 - 84, 16);
    local soundButton = p112.soundButton;
    soundButton.Position = UDim2.fromOffset(v118 - 16 - 38, v120 + 2);
    soundButton.Size = UDim2.fromOffset(38, 38);
    local v121 = v120 + 18;
    local nameLabel = p112.nameLabel;
    nameLabel.Position = UDim2.fromOffset(16, v121);
    nameLabel.Size = UDim2.fromOffset(v118 - 84, 32);
    p112.nameLabel.TextSize = p117 and 26 or 28;
    local v122 = v121 + 36;
    local line1 = p112.line1;
    line1.Position = UDim2.fromOffset(16, v122);
    line1.Size = UDim2.fromOffset(v118 - 32, 20);
    local v123 = v122 + 22;
    local line2 = p112.line2;
    line2.Position = UDim2.fromOffset(16, v123);
    line2.Size = UDim2.fromOffset(v118 - 32, 18);
    local v124 = v123 + 26;
    local v125 = (v118 - 32 - 30) / 6;

    for i, v in p112.slots do
        local button = v.button;
        button.Position = UDim2.fromOffset(16 + (i - 1) * (v125 + 6), v124);
        button.Size = UDim2.fromOffset(v125, 40);
    end;

    if p117 then
        local list = p112.list;
        local math_max_ret2 = math.max(60, p116 - v119 - 14);
        list.Position = UDim2.fromOffset(0, v119 + 14);
        list.Size = UDim2.fromOffset(p115, math_max_ret2);
        p112.listWidth = p115;
    else
        local list = p112.list;
        list.Position = UDim2.fromOffset(v118 + 20, 0);
        list.Size = UDim2.fromOffset(p115 - v118 - 20, p116);
        p112.listWidth = p115 - v118 - 20;
    end;

    p112:layoutList();
end;

function u1.step(p126, p127) -- Line: 555
    -- upvalues: LocalPlayer (copy)
    local preview = p126.preview;

    if not preview then
        return;
    end;

    if preview.model then
        if preview.source ~= LocalPlayer.Character or preview.knife ~= LocalPlayer:GetAttribute("EquippedKnife") then
            p126:play();
        end;
    elseif p126.selected and os.clock() >= p126.retryAt then
        p126.retryAt = os.clock() + 1;
        p126:play();
    end;

    preview:step(p127);
end;

function u1.destroy(p128) -- Line: 572
    p128.open = false;

    for _, v in p128.connections do
        v:Disconnect();
    end;

    table.clear(p128.connections);
    p128.sound:destroy();

    if p128.preview then
        p128.preview:destroy();
        p128.preview = nil;
    end;

    table.clear(p128.cards);
    p128.root:Destroy();
end;

return u1;