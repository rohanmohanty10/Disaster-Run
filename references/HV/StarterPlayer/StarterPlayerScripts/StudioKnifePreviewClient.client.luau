 

 

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");

if game.PlaceId ~= 130574217370467 then
    return;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Crates = ChickenOrHero:WaitForChild("Crates");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local SkinCatalog = require(Weapons:WaitForChild("SkinCatalog"));
local Models = Weapons:WaitForChild("Models");
local ValleyPanels = require(ChickenOrHero.Presentation.ValleyPanels);
local CrateEvent = Crates:WaitForChild("CrateEvent");
local u1 = ValleyPanels.screen(LocalPlayer, "StudioKnifePreview", 80);
u1:SetAttribute("TestOnlyUI", true);
u1.Enabled = LocalPlayer:GetAttribute("TestUIHidden") == false;
local u2 = {};

local function connect(p3, p4) -- Line: 19
    -- upvalues: u2 (copy)
    table.insert(u2, p3:Connect(p4));
end;

local u5 = ValleyPanels.make("Frame", u1, "PreviewControls", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -16, 1, -16),
    Size = UDim2.fromOffset(330, 400),
    BackgroundColor3 = ValleyPanels.Ink
});
ValleyPanels.corner(u5, 12);
ValleyPanels.stroke(u5, ValleyPanels.Gold, 0.45);
local UIScale = Instance.new("UIScale");
UIScale.Parent = u5;
local v6 = ValleyPanels.text(u5, "Title", "TEST KNIVES · F7 TOGGLES", 12, 8, 270, 20, 13, ValleyPanels.Gold);
local v7 = ValleyPanels.button(u5, "Close", "×", 290, 6, 28, 24);
v7.TextSize = 18;
local u8 = ValleyPanels.button(u1, "Reopen", "TEST · KNIVES", 0, 0, 150, 30);
u8.AnchorPoint = Vector2.new(1, 1);
u8.Position = UDim2.new(1, -16, 1, -16);
u8.TextSize = 12;
ValleyPanels.stroke(u8, ValleyPanels.Gold, 0.45);
local UIScale2 = Instance.new("UIScale");
UIScale2.Parent = u8;
v6.Font = Enum.Font.GothamBold;
local u9 = ValleyPanels.text(u5, "Skin", "Choose a knife to hold as a chaser", 12, 31, 306, 22, 13, ValleyPanels.Paper);
local u10 = ValleyPanels.button(u5, "Previous", "‹", 12, 59, 40, 30);
local u11 = ValleyPanels.button(u5, "Next", "NEXT KNIFE ›", 58, 59, 166, 30);
local u12 = ValleyPanels.button(u5, "Exit", "EXIT", 230, 59, 88, 30);
local u13 = ValleyPanels.button(u5, "Draw", "DRAW", 12, 96, 72, 30);
local u14 = ValleyPanels.button(u5, "Stab", "STAB", 90, 96, 72, 30);
local u15 = ValleyPanels.button(u5, "Dive", "DIVE", 168, 96, 72, 30);
local u16 = ValleyPanels.button(u5, "Idle", "IDLE", 246, 96, 72, 30);
local u17 = {
    { "Vowbreaker", ValleyPanels.button(u5, "Vowbreaker", "VOWBREAKER", 12, 134, 306, 30) }
};
local u18 = {};

for _, v in SkinCatalog.Order do
    local v19 = SkinCatalog.get(v);
    local v20 = Models:FindFirstChild(v);
    v20 = v20;
    local v21;

    if v20 then
        v21 = v20:FindFirstChild("Handle");
    else
        v21 = v20;
    end;

    local v22;

    if v20 then
        v22 = v20:FindFirstChild("Blade");
    else
        v22 = v20;
    end;

    local v23;

    if v20 then
        v23 = v20:FindFirstChild("StowedBlade");
    else
        v23 = v20;
    end;

    local v24;

    if v21 then
        v24 = v21:FindFirstChild("BladeWeld");
    end;

    if v19 and (v19.EquipReady ~= false and (v20 and (v20:IsA("Model") and (v21 and (v21:IsA("BasePart") and (v22 and (v22:IsA("BasePart") and (v23 and (v23:IsA("BasePart") and (v24 and (v24:IsA("JointInstance") and (typeof(v20:GetAttribute("GripC0")) == "CFrame" and (typeof(v20:GetAttribute("GripC1")) == "CFrame" and typeof(v20:GetAttribute("StowedOffset")) == "CFrame"))))))))))))) then
        table.insert(u18, v);
    end;
end;

local u25 = true;
local u26 = 0;
local u27 = (-1 / 0);

local function send(p28, p29) -- Line: 90
    -- upvalues: u27 (ref), CrateEvent (copy)
    if os.clock() - u27 < 0.55 then
        return;
    end;

    u27 = os.clock();
    CrateEvent:FireServer(p28, p29);
end;

local v30 = ValleyPanels.make("ScrollingFrame", u5, "AllKnives", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    Position = UDim2.fromOffset(12, 174),
    Size = UDim2.fromOffset(306, 214),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
});
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Padding = UDim.new(0, 4);
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = v30;
local u31 = {};

for i, v in u18 do
    local v32 = ValleyPanels.button(v30, v, SkinCatalog.get(v).Name, 0, 0, 294, 30);
    v32.LayoutOrder = i;
    u31[v] = v32;
    table.insert(u2, v32.Activated:Connect(function() -- Line: 111
        -- upvalues: LocalPlayer (copy), v (copy), u27 (ref), CrateEvent (copy)
        if LocalPlayer:GetAttribute("InMatch") ~= true then
            if os.clock() - u27 < 0.55 then
                return;
            end;

            u27 = os.clock();
            CrateEvent:FireServer("PreviewSkin", v);
        end;
    end));
end;

local function cycle(p33) -- Line: 115
    -- upvalues: u18 (copy), LocalPlayer (copy), u26 (ref), u27 (ref), CrateEvent (copy)
    if #u18 == 0 then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("StudioKnifePreview");
    u26 = table.find(u18, Attribute) or u26;
    u26 = (u26 - 1 + p33) % #u18 + 1;
    local v34 = u18[u26];

    if os.clock() - u27 < 0.55 then
        return;
    end;

    u27 = os.clock();
    CrateEvent:FireServer("PreviewSkin", v34);
end;

table.insert(u2, u10.Activated:Connect(function() -- Line: 124
    -- upvalues: u18 (copy), LocalPlayer (copy), u26 (ref), u27 (ref), CrateEvent (copy)
    if #u18 == 0 then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("StudioKnifePreview");
    u26 = table.find(u18, Attribute) or u26;
    u26 = (u26 - 1 + -1) % #u18 + 1;
    local v35 = u18[u26];

    if os.clock() - u27 < 0.55 then
        return;
    end;

    u27 = os.clock();
    CrateEvent:FireServer("PreviewSkin", v35);
end));
table.insert(u2, u11.Activated:Connect(function() -- Line: 127
    -- upvalues: u18 (copy), LocalPlayer (copy), u26 (ref), u27 (ref), CrateEvent (copy)
    if #u18 == 0 then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("StudioKnifePreview");
    u26 = table.find(u18, Attribute) or u26;
    u26 = (u26 - 1 + 1) % #u18 + 1;
    local v36 = u18[u26];

    if os.clock() - u27 < 0.55 then
        return;
    end;

    u27 = os.clock();
    CrateEvent:FireServer("PreviewSkin", v36);
end));
table.insert(u2, u12.Activated:Connect(function() -- Line: 130
    -- upvalues: u27 (ref), CrateEvent (copy)
    if os.clock() - u27 < 0.55 then
        return;
    end;

    u27 = os.clock();
    CrateEvent:FireServer("StopPreview", "");
end));

for _, v in u17 do
    table.insert(u2, v[2].Activated:Connect(function() -- Line: 134
        -- upvalues: v (copy), u27 (ref), CrateEvent (copy)
        local v37 = v[1];

        if os.clock() - u27 < 0.55 then
            return;
        end;

        u27 = os.clock();
        CrateEvent:FireServer("PreviewSkin", v37);
    end));
end;

for i, v in {
    [u13] = "Draw",
    [u14] = "Stab",
    [u15] = "Dive",
    [u16] = "Idle"
} do
    table.insert(u2, i.Activated:Connect(function() -- Line: 139
        -- upvalues: v (copy), u27 (ref), CrateEvent (copy)
        if os.clock() - u27 < 0.55 then
            return;
        end;

        u27 = os.clock();
        CrateEvent:FireServer("PreviewAction", v);
    end));
end;

local function refresh() -- Line: 143
    -- upvalues: LocalPlayer (copy), u5 (copy), u25 (ref), u8 (copy), u31 (copy), u10 (copy), u11 (copy), SkinCatalog (copy), u9 (copy), u18 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u12 (copy), ValleyPanels (copy), u17 (copy)
    local v38 = LocalPlayer:GetAttribute("InMatch") ~= true;
    u5.Visible = u25 and v38;
    u8.Visible = not u25 and v38;

    for _, v in u31 do
        v.Interactable = v38;
        v.TextTransparency = v38 and 0 or 0.55;
    end;

    u10.Interactable = v38;
    u11.Interactable = v38;
    local Attribute = LocalPlayer:GetAttribute("StudioKnifePreview");
    local v39 = SkinCatalog.get(Attribute);
    local v40;

    if v39 then
        local v41 = table.find(u18, Attribute) or 0;
        v40 = tostring(v41) .. "/" .. #u18 .. " · " .. v39.Name or "Choose a knife to hold as a chaser";
    else
        v40 = "Choose a knife to hold as a chaser";
    end;

    u9.Text = v40;

    for _, v in {
        u13,
        u14,
        u15,
        u16,
        u12
    } do
        local v42;

        if v38 then
            v42 = Attribute ~= nil;
        else
            v42 = v38;
        end;

        v.Interactable = v42;
        v.TextTransparency = Attribute and 0 or 0.55;
    end;

    local v43;

    if Attribute == nil then
        v43 = false;
    else
        v43 = LocalPlayer:GetAttribute("StudioKnifeAction") == "Idle";
    end;

    local v44;

    if v43 then
        v44 = ValleyPanels.Gold;
    else
        v44 = Color3.fromRGB(36, 56, 70);
    end;

    u16.BackgroundColor3 = v44;
    local v45;

    if v43 then
        v45 = ValleyPanels.Ink;
    else
        v45 = ValleyPanels.Paper;
    end;

    u16.TextColor3 = v45;

    for _, v in u17 do
        v[2].BackgroundColor3 = Attribute == v[1] and ValleyPanels.Gold or Color3.fromRGB(36, 56, 70);
        v[2].TextColor3 = Attribute == v[1] and ValleyPanels.Ink or ValleyPanels.Paper;
    end;
end;

local function setOpen(p46) -- Line: 172
    -- upvalues: u25 (ref), CrateEvent (copy), refresh (copy)
    u25 = p46;

    if not p46 then
        CrateEvent:FireServer("StopPreview", "");
    end;

    refresh();
end;

table.insert(u2, v7.Activated:Connect(function() -- Line: 177
    -- upvalues: u25 (ref), CrateEvent (copy), refresh (copy)
    u25 = false;
    CrateEvent:FireServer("StopPreview", "");
    refresh();
end));
table.insert(u2, u8.Activated:Connect(function() -- Line: 178
    -- upvalues: u25 (ref), refresh (copy)
    u25 = true;
    refresh();
end));
table.insert(u2, UserInputService.InputBegan:Connect(function(p47) -- Line: 179
    -- upvalues: UserInputService (copy), u25 (ref), CrateEvent (copy), refresh (copy)
    if UserInputService:GetFocusedTextBox() or p47.KeyCode ~= Enum.KeyCode.F7 then
        return;
    end;

    local v48 = not u25;
    u25 = v48;

    if not v48 then
        CrateEvent:FireServer("StopPreview", "");
    end;

    refresh();
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("StudioKnifePreview");
table.insert(u2, AttributeChangedSignal:Connect(refresh));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("StudioKnifeAction");
table.insert(u2, AttributeChangedSignal2:Connect(refresh));
local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u2, AttributeChangedSignal3:Connect(refresh));
local u49 = nil;

local function updateScale() -- Line: 187
    -- upvalues: GuiService (copy), UIScale (copy), UIScale2 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local v50 = (workspace_CurrentCamera.ViewportSize.Y * 0.47 - GuiService:GetGuiInset().Y - 48) / 400;
        local math_min_ret = math.min(v50, workspace_CurrentCamera.ViewportSize.X * 0.94 / 330);
        UIScale.Scale = math.clamp(math_min_ret, 0.5, 1);
        UIScale2.Scale = UIScale.Scale;
    end;
end;

local function bindCamera() -- Line: 196
    -- upvalues: u49 (ref), updateScale (copy), GuiService (copy), UIScale (copy), UIScale2 (copy)
    if u49 then
        u49:Disconnect();
        u49 = nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        u49 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale);
    end;

    local workspace_CurrentCamera2 = workspace.CurrentCamera;

    if workspace_CurrentCamera2 then
        local v51 = (workspace_CurrentCamera2.ViewportSize.Y * 0.47 - GuiService:GetGuiInset().Y - 48) / 400;
        local math_min_ret = math.min(v51, workspace_CurrentCamera2.ViewportSize.X * 0.94 / 330);
        UIScale.Scale = math.clamp(math_min_ret, 0.5, 1);
        UIScale2.Scale = UIScale.Scale;
    end;
end;

local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera");
table.insert(u2, PropertyChangedSignal:Connect(bindCamera));

if u49 then
    u49:Disconnect();
    u49 = nil;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;

if workspace_CurrentCamera then
    u49 = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale);
end;

local workspace_CurrentCamera2 = workspace.CurrentCamera;

if workspace_CurrentCamera2 then
    local v52 = (workspace_CurrentCamera2.ViewportSize.Y * 0.47 - GuiService:GetGuiInset().Y - 48) / 400;
    local math_min_ret = math.min(v52, workspace_CurrentCamera2.ViewportSize.X * 0.94 / 330);
    UIScale.Scale = math.clamp(math_min_ret, 0.5, 1);
    UIScale2.Scale = UIScale.Scale;
end;

refresh();
script.Destroying:Connect(function() -- Line: 210
    -- upvalues: u49 (ref), u2 (copy), u1 (copy)
    if u49 then
        u49:Disconnect();
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    u1:Destroy();
end);