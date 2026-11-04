 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

if LocalPlayer:GetAttribute("ContentTeam") ~= true then
    local v1 = os.clock() + 60;

    while LocalPlayer:GetAttribute("ContentTeam") ~= true and os.clock() < v1 do
        LocalPlayer:GetAttributeChangedSignal("ContentTeam"):Wait();
    end;

    if LocalPlayer:GetAttribute("ContentTeam") ~= true then
        return;
    end;
end;

local Game = ChickenOrHero:WaitForChild("Game");
local ContentTeamRemote = Game:WaitForChild("ContentTeamRemote", 30);

if not ContentTeamRemote then
    return;
end;

local ValleyPanels = require(ChickenOrHero.Presentation.ValleyPanels);
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local SkinCatalog = require(ChickenOrHero.Weapons.SkinCatalog);
local GearCatalog = require(ChickenOrHero.Gear.GearCatalog);
local EmoteCatalog = require(ChickenOrHero.Emotes.EmoteCatalog);
local PrivateHostCatalog = require(Game.PrivateHostCatalog);
local CrateEvent = ChickenOrHero.Crates.CrateEvent;
local GearEvent = ChickenOrHero.Gear.GearEvent;
local EmoteEvent = ChickenOrHero.Emotes.EmoteEvent;
local v2 = ValleyPanels.screen(LocalPlayer, "ContentTeamPanel", 70);
local u3 = ValleyPanels.make("Frame", v2, "Panel", {
    BorderSizePixel = 0,
    Visible = false,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -16, 0.5, 0),
    Size = UDim2.fromOffset(380, 520),
    BackgroundColor3 = ValleyPanels.Ink
});
ValleyPanels.corner(u3, 12);
ValleyPanels.stroke(u3, ValleyPanels.Gold, 0.4);
ValleyPanels.cursorWhileVisible(u3);
local u4 = ValleyPanels.make("UIScale", u3, "Scale", {});
ValleyPanels.text(u3, "Title", "CONTENT · PRIVATE SERVER", 14, 10, 300, 22, 14, ValleyPanels.Gold).Font = Enum.Font.GothamBold;
local v5 = ValleyPanels.button(u3, "Close", "×", 338, 8, 30, 26);
v5.TextSize = 18;
local u6 = ValleyPanels.text(u3, "Status", "Nothing here is saved.", 14, 486, 352, 26, 12, ValleyPanels.Muted);
u6.TextWrapped = true;
local v7 = { "MATCH", "LOOK", "KNIVES", "ABILITIES", "EMOTES" };
local math_floor_ret = math.floor(336 / #v7);
local u8 = {};
local u9 = {};
local u10 = {
    map = false,
    mode = "Normal",
    starter = 0,
    lead = 0,
    frozen = false,
    held = false,
    maps = {}
};

for i, v in v7 do
    local v11 = ValleyPanels.button(u3, "Tab" .. v, v, 14 + (i - 1) * (math_floor_ret + 4), 38, math_floor_ret, 26);
    v11.TextSize = 10;
    u8[v] = v11;
    local v12 = ValleyPanels.make("ScrollingFrame", u3, v, {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        Visible = false,
        Position = UDim2.fromOffset(14, 72),
        Size = UDim2.fromOffset(352, 408),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new()
    });
    ValleyPanels.make("UIListLayout", v12, "Layout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    });
    u9[v] = v12;
end;

local u13 = nil;

local function showTab(p14) -- Line: 85
    -- upvalues: u13 (ref), u9 (copy), u8 (copy), ValleyPanels (copy)
    u13 = p14;

    for i, v in u9 do
        v.Visible = i == p14;
        local v15;

        if i == p14 then
            v15 = ValleyPanels.Gold;
        else
            v15 = ValleyPanels.Ink;
        end;

        u8[i].BackgroundColor3 = v15;
        local v16;

        if i == p14 then
            v16 = ValleyPanels.Ink;
        else
            v16 = ValleyPanels.Paper;
        end;

        u8[i].TextColor3 = v16;
    end;
end;

for i, v in u8 do
    v.Activated:Connect(function() -- Line: 94
        -- upvalues: showTab (copy), i (copy)
        showTab(i);
    end);
end;

local u17 = {};

local function nextOrder(p18) -- Line: 101
    -- upvalues: u17 (copy)
    u17[p18] = (u17[p18] or 0) + 1;

    return u17[p18];
end;

local function row(p19, p20, p21) -- Line: 105
    -- upvalues: ValleyPanels (copy), u17 (copy)
    local v22 = ValleyPanels.button(p19, "Row", p20, 0, 0, 344, 30);
    v22.TextSize = 12;
    u17[p19] = (u17[p19] or 0) + 1;
    v22.LayoutOrder = u17[p19];
    v22.Activated:Connect(p21);

    return v22;
end;

local function label(p23, p24) -- Line: 112
    -- upvalues: ValleyPanels (copy), u17 (copy)
    local v25 = ValleyPanels.text(p23, "Label", p24, 0, 0, 344, 0, 11, ValleyPanels.Muted);
    u17[p23] = (u17[p23] or 0) + 1;
    v25.LayoutOrder = u17[p23];
    v25.TextWrapped = true;
    v25.AutomaticSize = Enum.AutomaticSize.Y;

    return v25;
end;

local function input(p26, p27, p28, u29) -- Line: 120
    -- upvalues: ValleyPanels (copy), u17 (copy)
    local v30 = ValleyPanels.make("Frame", p26, "Input", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(344, 30)
    });
    u17[p26] = (u17[p26] or 0) + 1;
    v30.LayoutOrder = u17[p26];
    local u31 = ValleyPanels.make("TextBox", v30, "Box", {
        BorderSizePixel = 0,
        Text = "",
        TextSize = 12,
        ClearTextOnFocus = false,
        Size = UDim2.fromOffset(218, 30),
        BackgroundColor3 = Color3.fromRGB(28, 31, 40),
        PlaceholderText = p27,
        TextColor3 = ValleyPanels.Paper,
        PlaceholderColor3 = ValleyPanels.Muted,
        Font = Enum.Font.Gotham
    });
    ValleyPanels.corner(u31, 6);
    local v32 = ValleyPanels.button(v30, "Go", p28, 224, 0, 120, 30);
    v32.TextSize = 11;
    v32.Activated:Connect(function() -- Line: 138
        -- upvalues: u29 (copy), u31 (copy)
        u29(u31.Text);
    end);

    return u31;
end;

local function grid(p33, p34, u35) -- Line: 144
    -- upvalues: ValleyPanels (copy), u17 (copy)
    local v36 = ValleyPanels.make("Frame", p33, "Grid", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(344, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    });
    u17[p33] = (u17[p33] or 0) + 1;
    v36.LayoutOrder = u17[p33];
    ValleyPanels.make("UIGridLayout", v36, "Layout", {
        CellSize = UDim2.fromOffset(169, 28),
        CellPadding = UDim2.fromOffset(6, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    });

    for i, v in p34 do
        local v37 = ValleyPanels.button(v36, v.id, v.name, 0, 0, 10, 10);
        v37.TextSize = 11;
        v37.TextTruncate = Enum.TextTruncate.AtEnd;
        v37.LayoutOrder = i;
        v37.Activated:Connect(function() -- Line: 161
            -- upvalues: u35 (copy), v (copy)
            u35(v);
        end);
    end;
end;

local function say(p38) -- Line: 166
    -- upvalues: u6 (copy)
    u6.Text = p38;
end;

local function send(p39, p40) -- Line: 169
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer(p39, p40);
end;

local MATCH = u9.MATCH;
local v41 = ValleyPanels.text(MATCH, "Label", "Same as the owner\'s HOST tools, for everyone on the content team. Bots stay on.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[MATCH] = (u17[MATCH] or 0) + 1;
v41.LayoutOrder = u17[MATCH];
v41.TextWrapped = true;
v41.AutomaticSize = Enum.AutomaticSize.Y;

local function v42() -- Line: 176
    -- upvalues: u10 (ref), ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Hold", not u10.held);
end;

local u43 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u43.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u43.LayoutOrder = u17[MATCH];
u43.Activated:Connect(v42);

local function v44() -- Line: 179
    -- upvalues: u10 (ref), ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Freeze", not u10.frozen);
end;

local u45 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u45.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u45.LayoutOrder = u17[MATCH];
u45.Activated:Connect(v44);
local v46 = ValleyPanels.button(MATCH, "Row", "START NEXT MATCH NOW", 0, 0, 344, 30);
v46.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
v46.LayoutOrder = u17[MATCH];
v46.Activated:Connect(function() -- Line: 182
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("StartNow", nil);
end);
local u47 = nil;
local u48 = nil;

local function v49() -- Line: 189
    -- upvalues: u47 (ref), u48 (ref), ContentTeamRemote (copy)
    if u47 and os.clock() - u47 < 3 then
        u47 = nil;
        u48.Text = "END MATCH (NO WIN)";
        ContentTeamRemote:FireServer("EndMatch", nil);

        return;
    end;

    u47 = os.clock();
    u48.Text = "PRESS AGAIN TO END THE MATCH";
    task.delay(3, function() -- Line: 198
        -- upvalues: u47 (ref), u48 (ref)
        if u47 and os.clock() - u47 >= 2.9 then
            u47 = nil;
            u48.Text = "END MATCH (NO WIN)";
        end;
    end);
end;

local v50 = ValleyPanels.button(MATCH, "Row", "END MATCH (NO WIN)", 0, 0, 344, 30);
v50.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
v50.LayoutOrder = u17[MATCH];
v50.Activated:Connect(v49);
u48 = v50;

local function v52() -- Line: 205
    -- upvalues: u10 (ref), ContentTeamRemote (copy)
    local v51 = { false };

    for _, v in u10.maps do
        table.insert(v51, v.id);
    end;

    ContentTeamRemote:FireServer("SetMap", v51[(table.find(v51, u10.map) or 1) % #v51 + 1]);
end;

local u53 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u53.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u53.LayoutOrder = u17[MATCH];
u53.Activated:Connect(v52);

local function v54() -- Line: 213
    -- upvalues: PrivateHostCatalog (copy), u10 (ref), ContentTeamRemote (copy)
    local Modes = PrivateHostCatalog.Modes;
    ContentTeamRemote:FireServer("SetMode", Modes[(table.find(Modes, u10.mode) or 1) % #Modes + 1]);
end;

local u55 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u55.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u55.LayoutOrder = u17[MATCH];
u55.Activated:Connect(v54);

local function v56() -- Line: 218
    -- upvalues: u10 (ref), LocalPlayer (copy), ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Starter", u10.starter ~= LocalPlayer.UserId);
end;

local u57 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u57.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u57.LayoutOrder = u17[MATCH];
u57.Activated:Connect(v56);

local function v58() -- Line: 221
    -- upvalues: u10 (ref), LocalPlayer (copy), ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Lead", u10.lead ~= LocalPlayer.UserId);
end;

local u59 = ValleyPanels.button(MATCH, "Row", "", 0, 0, 344, 30);
u59.TextSize = 12;
u17[MATCH] = (u17[MATCH] or 0) + 1;
u59.LayoutOrder = u17[MATCH];
u59.Activated:Connect(v58);

local function paint() -- Line: 224
    -- upvalues: u43 (copy), u10 (ref), u45 (copy), u53 (copy), u55 (copy), PrivateHostCatalog (copy), u57 (copy), LocalPlayer (copy), u59 (copy)
    u43.Text = "HOLD MATCHES: " .. (u10.held and "ON" or "OFF");
    u45.Text = "FREEZE GAME: " .. (u10.frozen and "ON" or "OFF");
    local v60 = "PLAYERS VOTE";

    for _, v in u10.maps do
        if v.id == u10.map then
            v60 = string.upper(v.name);
        end;
    end;

    u53.Text = "MAP: " .. v60 .. "  ›";
    u55.Text = "MODE: " .. string.upper(PrivateHostCatalog.ModeNames[u10.mode] or u10.mode) .. "  ›";
    u57.Text = "CHICKEN OR HERO PICK: " .. (u10.starter == LocalPlayer.UserId and "ME" or (u10.starter == 0 and "RANDOM" or "SOMEONE ELSE"));
    u59.Text = "LEAD CHASER: " .. (u10.lead == LocalPlayer.UserId and "ME" or (u10.lead == 0 and "RANDOM" or "SOMEONE ELSE"));
end;

paint();
local LOOK = u9.LOOK;
local v61 = ValleyPanels.button(LOOK, "Row", "FREE CAMERA  (F6)", 0, 0, 344, 30);
v61.TextSize = 12;
u17[LOOK] = (u17[LOOK] or 0) + 1;
v61.LayoutOrder = u17[LOOK];
v61.Activated:Connect(function() -- Line: 242
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("CreatorCamera");
end);
local v62 = ValleyPanels.text(LOOK, "Label", "F8 hides the screen\'s UI for a clean shot; Esc brings it back.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[LOOK] = (u17[LOOK] or 0) + 1;
v62.LayoutOrder = u17[LOOK];
v62.TextWrapped = true;
v62.AutomaticSize = Enum.AutomaticSize.Y;
local u63 = nil;
local u64 = nil;

local function v65() -- Line: 248
    -- upvalues: u63 (ref), LocalPlayer (copy), u64 (ref)
    if u63 then
        LocalPlayer.CameraMaxZoomDistance = u63;
        u63 = nil;
        u64.Text = "ZOOM: NORMAL";

        return;
    end;

    u63 = LocalPlayer.CameraMaxZoomDistance;
    LocalPlayer.CameraMaxZoomDistance = 60;
    u64.Text = "ZOOM: FAR (" .. 60 .. " STUDS)";
end;

local v66 = ValleyPanels.button(LOOK, "Row", "ZOOM: NORMAL", 0, 0, 344, 30);
v66.TextSize = 12;
u17[LOOK] = (u17[LOOK] or 0) + 1;
v66.LayoutOrder = u17[LOOK];
v66.Activated:Connect(v65);
u64 = v66;
local v67 = ValleyPanels.button(LOOK, "Row", "BECOME DAVID (LOOK AND NAME)", 0, 0, 344, 30);
v67.TextSize = 12;
u17[LOOK] = (u17[LOOK] or 0) + 1;
v67.LayoutOrder = u17[LOOK];
v67.Activated:Connect(function() -- Line: 259
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Look", "david");
end);
input(LOOK, "Username or UserId", "LOOK LIKE", function(p68) -- Line: 262
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Look", p68);
end);
input(LOOK, "Name over your head", "SET NAME", function(p69) -- Line: 265
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Name", p69);
end);
local v70 = ValleyPanels.button(LOOK, "Row", "RESET MY LOOK AND NAME", 0, 0, 344, 30);
v70.TextSize = 12;
u17[LOOK] = (u17[LOOK] or 0) + 1;
v70.LayoutOrder = u17[LOOK];
v70.Activated:Connect(function() -- Line: 268
    -- upvalues: ContentTeamRemote (copy)
    ContentTeamRemote:FireServer("Reset", nil);
end);
local v71 = ValleyPanels.text(LOOK, "Label", "Only you change; everyone sees it. Gone when you leave.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[LOOK] = (u17[LOOK] or 0) + 1;
v71.LayoutOrder = u17[LOOK];
v71.TextWrapped = true;
v71.AutomaticSize = Enum.AutomaticSize.Y;
local KNIVES = u9.KNIVES;
local v72 = ValleyPanels.text(KNIVES, "Label", "Hold any knife, in the lobby and in matches. DRAW / STAB / DIVE show it off.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[KNIVES] = (u17[KNIVES] or 0) + 1;
v72.LayoutOrder = u17[KNIVES];
v72.TextWrapped = true;
v72.AutomaticSize = Enum.AutomaticSize.Y;
local v73 = ValleyPanels.make("Frame", KNIVES, "Actions", {
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(344, 30)
});
u17[KNIVES] = (u17[KNIVES] or 0) + 1;
v73.LayoutOrder = u17[KNIVES];

for i, v in { "Draw", "Stab", "Dive" } do
    local v74 = ValleyPanels.button(v73, v, string.upper(v), (i - 1) * 116, 0, 110, 30);
    v74.TextSize = 12;
    v74.Activated:Connect(function() -- Line: 282
        -- upvalues: CrateEvent (copy), v (copy)
        CrateEvent:FireServer("PreviewAction", v);
    end);
end;

local v75 = ValleyPanels.button(KNIVES, "Row", "BACK TO MY OWN KNIFE", 0, 0, 344, 30);
v75.TextSize = 12;
u17[KNIVES] = (u17[KNIVES] or 0) + 1;
v75.LayoutOrder = u17[KNIVES];
v75.Activated:Connect(function() -- Line: 286
    -- upvalues: CrateEvent (copy), u6 (copy)
    CrateEvent:FireServer("StopPreview", "");
    u6.Text = "Back to your own knife.";
end);
local v76 = {};

for _, v in SkinCatalog.Order do
    local v77 = SkinCatalog.get(v);

    if v77 and v77.EquipReady ~= false then
        table.insert(v76, {
            id = v,
            name = v77.Name
        });
    end;
end;

grid(KNIVES, v76, function(p78) -- Line: 297
    -- upvalues: CrateEvent (copy), u6 (copy)
    CrateEvent:FireServer("PreviewSkin", p78.id);
    u6.Text = "Holding " .. p78.name .. ".";
end);
local ABILITIES = u9.ABILITIES;
local v79 = ValleyPanels.text(ABILITIES, "Label", "Use them with your normal ability and item keys in a match. Nothing is spent.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[ABILITIES] = (u17[ABILITIES] or 0) + 1;
v79.LayoutOrder = u17[ABILITIES];
v79.TextWrapped = true;
v79.AutomaticSize = Enum.AutomaticSize.Y;
local v80 = ValleyPanels.button(ABILITIES, "Row", "BACK TO MY OWN ABILITY", 0, 0, 344, 30);
v80.TextSize = 12;
u17[ABILITIES] = (u17[ABILITIES] or 0) + 1;
v80.LayoutOrder = u17[ABILITIES];
v80.Activated:Connect(function() -- Line: 305
    -- upvalues: GearEvent (copy)
    GearEvent:FireServer("StudioClearAbility");
end);
local v81 = ValleyPanels.button(ABILITIES, "Row", "RESET COOLDOWNS", 0, 0, 344, 30);
v81.TextSize = 12;
u17[ABILITIES] = (u17[ABILITIES] or 0) + 1;
v81.LayoutOrder = u17[ABILITIES];
v81.Activated:Connect(function() -- Line: 308
    -- upvalues: GearEvent (copy)
    GearEvent:FireServer("StudioResetAbility");
end);
local v82 = {};
local v83 = {};

for _, v in GearCatalog.Order do
    local v84 = GearCatalog.get(v);

    if v84 then
        local v85;

        if v84.Kind == "Ability" then
            v85 = v83;
        else
            v85 = v82;
        end;

        table.insert(v85, {
            id = v,
            name = (v84.Kind == "Ability" and (v84.UseRole == "Runner" and "R · " or "C · ") or "") .. v84.Name
        });
    end;
end;

grid(ABILITIES, v83, function(p86) -- Line: 321
    -- upvalues: GearEvent (copy), u6 (copy)
    GearEvent:FireServer("StudioEquipAbility", p86.id);
    u6.Text = "Ability: " .. p86.name .. ".";
end);
local v87 = ValleyPanels.text(ABILITIES, "Label", "ITEMS", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[ABILITIES] = (u17[ABILITIES] or 0) + 1;
v87.LayoutOrder = u17[ABILITIES];
v87.TextWrapped = true;
v87.AutomaticSize = Enum.AutomaticSize.Y;
local v88 = ValleyPanels.button(ABILITIES, "Row", "BACK TO MY OWN ITEM", 0, 0, 344, 30);
v88.TextSize = 12;
u17[ABILITIES] = (u17[ABILITIES] or 0) + 1;
v88.LayoutOrder = u17[ABILITIES];
v88.Activated:Connect(function() -- Line: 326
    -- upvalues: GearEvent (copy)
    GearEvent:FireServer("StudioEquipItem", "");
end);
grid(ABILITIES, v82, function(p89) -- Line: 329
    -- upvalues: GearEvent (copy), u6 (copy)
    GearEvent:FireServer("StudioEquipItem", p89.id);
    u6.Text = "Item: " .. p89.name .. ".";
end);
local EMOTES = u9.EMOTES;
local v90 = ValleyPanels.text(EMOTES, "Label", "Plays on you straight away, wherever emotes can play.", 0, 0, 344, 0, 11, ValleyPanels.Muted);
u17[EMOTES] = (u17[EMOTES] or 0) + 1;
v90.LayoutOrder = u17[EMOTES];
v90.TextWrapped = true;
v90.AutomaticSize = Enum.AutomaticSize.Y;
local v91 = ValleyPanels.button(EMOTES, "Row", "STOP", 0, 0, 344, 30);
v91.TextSize = 12;
u17[EMOTES] = (u17[EMOTES] or 0) + 1;
v91.LayoutOrder = u17[EMOTES];
v91.Activated:Connect(function() -- Line: 337
    -- upvalues: EmoteEvent (copy)
    EmoteEvent:FireServer("Stop");
end);
local v92 = {};

for _, v in EmoteCatalog.Entries do
    if EmoteCatalog.assetId(v.Id) then
        table.insert(v92, {
            id = v.Id,
            name = v.Name
        });
    end;
end;

grid(EMOTES, v92, function(p93) -- Line: 346
    -- upvalues: EmoteEvent (copy), u6 (copy)
    EmoteEvent:FireServer("TestPlay", p93.id);
    u6.Text = "Emote: " .. p93.name .. ".";
end);

local function fit() -- Line: 352
    -- upvalues: u4 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v94 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    local math_min_ret = math.min((v94.Y - 40) / 520, (v94.X - 40) / 380);
    u4.Scale = math.clamp(math_min_ret, 0.55, 1);
end;

local function setOpen(p95) -- Line: 357
    -- upvalues: u3 (copy), HudNavigation (copy), u4 (copy), ContentTeamRemote (copy)
    u3.Visible = p95;

    if p95 then
        HudNavigation.opening("ContentTeam");
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v96 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
        local math_min_ret = math.min((v96.Y - 40) / 520, (v96.X - 40) / 380);
        u4.Scale = math.clamp(math_min_ret, 0.55, 1);
        ContentTeamRemote:FireServer("Sync", nil);
    end;
end;

local function addButton(p97, p98, p99) -- Line: 367
    -- upvalues: ValleyPanels (copy), u3 (copy), HudNavigation (copy), u4 (copy), ContentTeamRemote (copy)
    if p97:FindFirstChild("ContentTeamButton") then
        return;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Name = "ContentTeamButton";
    TextButton.AnchorPoint = Vector2.new(1, 0.5);
    TextButton.Position = p98;
    TextButton.Size = p99;
    TextButton.BackgroundColor3 = ValleyPanels.Gold;
    TextButton.BorderSizePixel = 0;
    TextButton.Font = Enum.Font.GothamBlack;
    TextButton.Text = "CONTENT";
    TextButton.TextColor3 = ValleyPanels.Ink;
    TextButton.TextScaled = true;
    TextButton.ZIndex = 10;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.3, 0);
    UICorner.Parent = TextButton;
    local UIPadding = Instance.new("UIPadding");
    local UDim_new_ret = UDim.new(0.1, 0);
    local UDim_new_ret2 = UDim.new(0.1, 0);
    UIPadding.PaddingLeft = UDim_new_ret;
    UIPadding.PaddingRight = UDim_new_ret2;
    local UDim_new_ret3 = UDim.new(0.22, 0);
    local UDim_new_ret4 = UDim.new(0.22, 0);
    UIPadding.PaddingTop = UDim_new_ret3;
    UIPadding.PaddingBottom = UDim_new_ret4;
    UIPadding.Parent = TextButton;
    TextButton.Activated:Connect(function() -- Line: 390
        -- upvalues: u3 (ref), HudNavigation (ref), u4 (ref), ContentTeamRemote (ref)
        u3.Visible = true;
        HudNavigation.opening("ContentTeam");
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v100 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
        local math_min_ret = math.min((v100.Y - 40) / 520, (v100.X - 40) / 380);
        u4.Scale = math.clamp(math_min_ret, 0.55, 1);
        ContentTeamRemote:FireServer("Sync", nil);
    end);
    TextButton.Parent = p97;
end;

local function attach() -- Line: 395
    -- upvalues: LocalPlayer (copy), addButton (copy)
    local v101 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v101 then
        return;
    end;

    local ValleyHUD = v101:FindFirstChild("ValleyHUD");

    if ValleyHUD then
        ValleyHUD = ValleyHUD:FindFirstChild("SettingsShade");
    end;

    if ValleyHUD then
        ValleyHUD = ValleyHUD:FindFirstChild("Panel");
    end;

    if ValleyHUD then
        addButton(ValleyHUD, UDim2.fromOffset(418, 41), UDim2.fromOffset(120, 36));
    end;

    local UI = v101:FindFirstChild("UI");
    local v102;

    if UI then
        v102 = UI:FindFirstChild("HolderFrame");
    else
        v102 = UI;
    end;

    if v102 then
        v102 = v102:FindFirstChild("Settings");
    end;

    if v102 then
        v102 = v102:FindFirstChild("Header");
    end;

    if v102 then
        addButton(v102, UDim2.fromScale(0.88, 0.5), UDim2.fromScale(0.24, 0.62));
    end;

    local PrivateHost = v101:FindFirstChild("PrivateHost");

    if PrivateHost then
        PrivateHost = PrivateHost:FindFirstChild("HostPanelShade");
    end;

    if PrivateHost then
        PrivateHost = PrivateHost:FindFirstChild("HostPanel");
    end;

    if PrivateHost then
        addButton(PrivateHost, UDim2.fromOffset(398, 36), UDim2.fromOffset(120, 36));
    end;

    if UI then
        UI = UI:FindFirstChild("HolderFrame");
    end;

    if UI then
        UI = UI:FindFirstChild("HostPanel");
    end;

    if UI then
        UI = UI:FindFirstChild("Header");
    end;

    if UI then
        addButton(UI, UDim2.fromScale(0.88, 0.5), UDim2.fromScale(0.24, 0.62));
    end;
end;

attach();
local u103 = {
    ValleyHUD = true,
    UI = true,
    PrivateHost = true,
    HostPanel = true,
    HostPanelShade = true,
    SettingsShade = true
};
local u104 = false;
LocalPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(function(p105) -- Line: 434
    -- upvalues: u103 (copy), u104 (ref), attach (copy)
    if u103[p105.Name] and not u104 then
        u104 = true;
        task.delay(0.5, function() -- Line: 437
            -- upvalues: u104 (ref), attach (ref)
            u104 = false;
            attach();
        end);
    end;
end);
task.spawn(function() -- Line: 443
    -- upvalues: attach (copy)
    for i = 1, 30 do
        task.wait(2);
        attach();
        local _ = i;
    end;
end);
v5.Activated:Connect(function() -- Line: 449
    -- upvalues: u3 (copy)
    u3.Visible = false;
end);
showTab("MATCH");
ContentTeamRemote.OnClientEvent:Connect(function(p106, p107, p108, p109) -- Line: 453
    -- upvalues: u10 (ref), paint (copy), u6 (copy), ValleyPanels (copy)
    if p106 ~= "State" or type(p107) ~= "table" then
        return;
    end;

    u10 = p107;
    paint();

    if type(p108) == "string" then
        local v110;

        if p109 then
            v110 = ValleyPanels.Paper;
        else
            v110 = Color3.fromRGB(255, 120, 120);
        end;

        u6.TextColor3 = v110;
        u6.Text = p108;
    end;
end);
ContentTeamRemote:FireServer("Sync", nil);