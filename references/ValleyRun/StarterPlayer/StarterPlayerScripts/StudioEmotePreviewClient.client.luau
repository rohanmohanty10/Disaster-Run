 

 

if game.PlaceId ~= 130574217370467 then
    return;
end;

local GuiService = game:GetService("GuiService");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Emotes = ChickenOrHero:WaitForChild("Emotes");
local EmoteCatalog = require(Emotes:WaitForChild("EmoteCatalog"));
local EmoteEvent = Emotes:WaitForChild("EmoteEvent");
local ValleyPanels = require(ChickenOrHero.Presentation.ValleyPanels);
local u1 = ValleyPanels.screen(LocalPlayer, "StudioEmotePreview", 80);
u1:SetAttribute("TestOnlyUI", true);
u1.Enabled = LocalPlayer:GetAttribute("TestUIHidden") == false;
local u2 = {};

local function connect(p3, p4) -- Line: 20
    -- upvalues: u2 (copy)
    table.insert(u2, p3:Connect(p4));
end;

local u5 = ValleyPanels.make("Frame", u1, "PreviewControls", {
    AnchorPoint = Vector2.new(1, 1),
    Size = UDim2.fromOffset(330, 400),
    BackgroundColor3 = ValleyPanels.Ink
});
ValleyPanels.corner(u5, 12);
ValleyPanels.stroke(u5, ValleyPanels.Gold, 0.45);
local UIScale = Instance.new("UIScale");
UIScale.Parent = u5;
ValleyPanels.text(u5, "Title", "TEST EMOTES", 12, 8, 270, 20, 13, ValleyPanels.Gold).Font = Enum.Font.GothamBold;
local v6 = ValleyPanels.button(u5, "Close", "×", 290, 6, 28, 24);
v6.TextSize = 18;
local u7 = ValleyPanels.text(u5, "Status", "Pick an emote to play it on your character", 12, 31, 306, 22, 13, ValleyPanels.Paper);
local v8 = ValleyPanels.button(u5, "Stop", "STOP", 12, 59, 96, 30);
ValleyPanels.text(u5, "Legend", "♪ sound · ⚠ other group · ✕ no animation", 117, 59, 201, 30, 11, ValleyPanels.Muted).TextWrapped = true;
local u9 = ValleyPanels.button(u1, "Reopen", "TEST · EMOTES", 0, 0, 150, 30);
u9.AnchorPoint = Vector2.new(1, 1);
u9.TextSize = 12;
ValleyPanels.stroke(u9, ValleyPanels.Gold, 0.45);
local UIScale2 = Instance.new("UIScale");
UIScale2.Parent = u9;
local v10 = ValleyPanels.make("ScrollingFrame", u5, "AllEmotes", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    Position = UDim2.fromOffset(12, 98),
    Size = UDim2.fromOffset(306, 290),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
});
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Padding = UDim.new(0, 4);
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = v10;
local u11 = {};

local function label(p12) -- Line: 65
    -- upvalues: EmoteCatalog (copy)
    local v13 = {};

    if EmoteCatalog.soundId(p12.id) then
        table.insert(v13, "♪");
    end;

    if EmoteCatalog.assetId(p12.id) then
        if p12.foreign then
            table.insert(v13, "⚠");
        end;
    else
        table.insert(v13, "✕");
    end;

    p12.button.Text = p12.name .. (#v13 <= 0 and "" or "  " .. table.concat(v13, " "));
end;

local u14 = (-1 / 0);
local u15 = true;

for i, v in EmoteCatalog.Entries do
    local v16 = ValleyPanels.button(v10, v.Id, v.Name, 0, 0, 294, 30);
    v16.LayoutOrder = i;
    local v17 = {
        id = v.Id,
        name = v.Name,
        button = v16
    };
    u11[v.Id] = v17;
    label(v17);
    table.insert(u2, v16.Activated:Connect(function() -- Line: 83
        -- upvalues: LocalPlayer (copy), u14 (ref), u7 (copy), v (copy), EmoteEvent (copy)
        if LocalPlayer:GetAttribute("InMatch") == true or os.clock() - u14 < 0.65 then
            return;
        end;

        u14 = os.clock();
        u7.Text = "Starting " .. v.Name .. "…";
        EmoteEvent:FireServer("TestPlay", v.Id);
    end));
end;

task.spawn(function() -- Line: 93
    -- upvalues: EmoteCatalog (copy), u11 (copy), u1 (copy), MarketplaceService (copy), label (copy)
    for _, v in EmoteCatalog.Entries do
        local v18 = u11[v.Id];
        local v19 = EmoteCatalog.assetId(v.Id);

        if v19 then
            v19 = tonumber(v19:match("%d+"));
        end;

        if v18 and (v19 and u1.Parent) then
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, v19, Enum.InfoType.Asset);

            if success and (type(result) == "table" and type(result.Creator) == "table") then
                v18.foreign = result.Creator.CreatorTargetId ~= game.CreatorId and true or result.AssetTypeId ~= Enum.AssetType.Animation.Value;
                label(v18);
            end;
        end;
    end;
end);
table.insert(u2, v8.Activated:Connect(function() -- Line: 108
    -- upvalues: EmoteEvent (copy), u7 (copy)
    EmoteEvent:FireServer("Stop");
    u7.Text = "Stopped";
end));
table.insert(u2, EmoteEvent.OnClientEvent:Connect(function(p20, p21) -- Line: 112
    -- upvalues: u15 (ref), u11 (copy), u7 (copy), EmoteCatalog (copy)
    if not u15 then
        return;
    end;

    if p20 == "Playing" and u11[p21] then
        u7.Text = "Playing " .. u11[p21].name .. (EmoteCatalog.soundId(p21) and " ♪" or "");

        return;
    end;

    if p20 == "State" and (type(p21) == "table" and type(p21.message) == "string") then
        u7.Text = p21.message;
    end;
end));

local function refresh() -- Line: 123
    -- upvalues: LocalPlayer (copy), u5 (copy), u15 (ref), u9 (copy), u11 (copy)
    local v22 = LocalPlayer:GetAttribute("InMatch") ~= true;
    u5.Visible = u15 and v22;
    u9.Visible = not u15 and v22;

    for _, v in u11 do
        v.button.Interactable = v22;
        v.button.TextTransparency = v22 and 0 or 0.55;
    end;
end;

local function setOpen(p23) -- Line: 132
    -- upvalues: u15 (ref), EmoteEvent (copy), refresh (copy)
    u15 = p23;

    if not p23 then
        EmoteEvent:FireServer("Stop");
    end;

    refresh();
end;

table.insert(u2, v6.Activated:Connect(function() -- Line: 139
    -- upvalues: u15 (ref), EmoteEvent (copy), refresh (copy)
    u15 = false;
    EmoteEvent:FireServer("Stop");
    refresh();
end));
table.insert(u2, u9.Activated:Connect(function() -- Line: 142
    -- upvalues: u15 (ref), refresh (copy)
    u15 = true;
    refresh();
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u2, AttributeChangedSignal:Connect(refresh));
local u24 = nil;

local function updateScale() -- Line: 149
    -- upvalues: GuiService (copy), UIScale (copy), UIScale2 (copy), u5 (copy), u9 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local v25 = (workspace_CurrentCamera.ViewportSize.Y * 0.47 - GuiService:GetGuiInset().Y - 48) / 400;
        local math_min_ret = math.min(v25, workspace_CurrentCamera.ViewportSize.X * 0.94 / 330);
        UIScale.Scale = math.clamp(math_min_ret, 0.5, 1);
        UIScale2.Scale = UIScale.Scale;
        local v26 = -16 - 340 * UIScale.Scale;
        u5.Position = UDim2.new(1, v26, 1, -16);
        u9.Position = UDim2.new(1, v26, 1, -16);
    end;
end;

local function bindCamera() -- Line: 160
    -- upvalues: u24 (ref), updateScale (copy)
    if u24 then
        u24:Disconnect();
        u24 = nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        u24 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale);
    end;

    updateScale();
end;

local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera");
table.insert(u2, PropertyChangedSignal:Connect(bindCamera));

if u24 then
    u24:Disconnect();
    u24 = nil;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;

if workspace_CurrentCamera then
    u24 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale);
end;

updateScale();
refresh();
script.Destroying:Connect(function() -- Line: 174
    -- upvalues: u24 (ref), u2 (copy), u1 (copy)
    if u24 then
        u24:Disconnect();
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    u1:Destroy();
end);