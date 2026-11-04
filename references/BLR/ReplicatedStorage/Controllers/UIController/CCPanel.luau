  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local TableUtil = require(ReplicatedStorage.Packages.TableUtil);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Flows = require(ReplicatedStorage.Shared.Flows);
require(ReplicatedStorage.Modules.Button);
local PlrStyles = require(ReplicatedStorage.Shared.PlrStyles);
require(ReplicatedStorage.Modules.UpdateGuisScale);
local environment = require(ReplicatedStorage.Shared.environment);
local MVPCutscenes = require(ReplicatedStorage.Shared.MVPCutscenes);
local Icon = require(ReplicatedStorage.Shared.TopbarPlus.Icon);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u1 = nil;
local u2 = Knit.CreateController({
    Name = "CCPanel"
});

local function isCustomServerOwner() -- Line: 28
    -- upvalues: environment (copy), LocalPlayer (copy)
    local v3;

    if environment.mode == "Custom" then
        v3 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;
    else
        v3 = false;
    end;

    return v3;
end;

local function canUsePrivatePanel() -- Line: 33
    -- upvalues: environment (copy), LocalPlayer (copy), u2 (copy)
    local v4;

    if environment.mode == "Custom" then
        v4 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;
    else
        v4 = false;
    end;

    if not v4 then
        if environment.env == "Dev" then
            v4 = LocalPlayer:GetAttribute("CanUseCCPanel") == true and true or u2.DevPrivatePanelGranted == true;
        else
            v4 = false;
        end;
    end;

    return v4;
end;

function u2.GetPanelMode(p5) -- Line: 41
    -- upvalues: environment (copy), LocalPlayer (copy), u2 (copy)
    if p5.PanelModeOverride == "Public" then
        return "Public";
    end;

    if p5.PanelModeOverride == "Custom" then
        local v6;

        if environment.mode == "Custom" then
            v6 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;
        else
            v6 = false;
        end;

        if not v6 then
            if environment.env == "Dev" then
                v6 = LocalPlayer:GetAttribute("CanUseCCPanel") == true and true or u2.DevPrivatePanelGranted == true;
            else
                v6 = false;
            end;
        end;

        if v6 then
            return "Custom";
        end;
    end;

    local v7;

    if environment.mode == "Custom" then
        v7 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;
    else
        v7 = false;
    end;

    if not v7 then
        if environment.env == "Dev" then
            v7 = LocalPlayer:GetAttribute("CanUseCCPanel") == true and true or u2.DevPrivatePanelGranted == true;
        else
            v7 = false;
        end;
    end;

    return v7 and "Custom" or "Public";
end;

function u2.IsPrivatePanel(p8) -- Line: 53
    return p8:GetPanelMode() == "Custom";
end;

function u2.Close(p9) -- Line: 57
    p9.Screen.Enabled = false;
    p9.Background.Visible = false;
    p9.TrollPanel.Visible = false;
    p9.PublicPanel.Visible = false;

    if p9.PanelIcon and p9.PanelIcon.isSelected then
        p9.PanelIcon:deselect();
    end;
end;

function u2.Open(p10) -- Line: 68
    p10.Screen.Enabled = true;
    p10.Background.Visible = false;
    p10.TrollPanel.Visible = false;
    p10.PublicPanel.Visible = true;
    p10:RenderMainPanel();

    if p10.PanelIcon and not p10.PanelIcon.isSelected then
        p10.PanelIcon:select();
    end;
end;

function u2.Toggle(p11) -- Line: 80
    if p11.Screen.Enabled then
        p11:Close();

        return;
    end;

    p11:Open();
end;

function u2.SetPanelMode(p12: table, p13: string) -- Line: 88
    -- upvalues: environment (copy), LocalPlayer (copy), u2 (copy), Popup (copy)
    if p13 == "auto" then
        p12.PanelModeOverride = nil;
    elseif p13 == "public" then
        p12.PanelModeOverride = "Public";
    else
        if p13 ~= "custom" then
            return;
        end;

        local v14;

        if environment.mode == "Custom" then
            v14 = workspace:GetAttribute("CustomServerOwnerId") == LocalPlayer.UserId;
        else
            v14 = false;
        end;

        if not v14 then
            if environment.env == "Dev" then
                v14 = LocalPlayer:GetAttribute("CanUseCCPanel") == true and true or u2.DevPrivatePanelGranted == true;
            else
                v14 = false;
            end;
        end;

        if not v14 then
            Popup.Popup(LocalPlayer, "You need content creator rank to use this");

            return;
        end;

        p12.PanelModeOverride = "Custom";
    end;

    p12:Open();
end;

function u2.SetupPanelIcon(u15) -- Line: 107
    -- upvalues: LocalPlayer (copy), Icon (copy)
    if u15.PanelIcon or not LocalPlayer:GetAttribute("CanUseCCPanel") then
        return;
    end;

    local v16 = Icon.new():setImage(4882429582):setLabel("CC Panel", "Deselected"):setLabel("CC Panel", "Selected"):setLabel("CC Panel", "Viewing"):bindToggleKey(Enum.KeyCode.F4);
    v16.selected:Connect(function() -- Line: 119
        -- upvalues: u15 (copy)
        u15:Open();
    end);
    v16.deselected:Connect(function() -- Line: 122
        -- upvalues: u15 (copy)
        u15:Close();
    end);
    u15.PanelIcon = v16;
end;

function u2.UpdatePanelIcon(p17) -- Line: 129
    -- upvalues: PlayerGui (copy), LocalPlayer (copy)
    local CCPanelQuickOpen = PlayerGui:FindFirstChild("CCPanelQuickOpen");

    if CCPanelQuickOpen then
        CCPanelQuickOpen:Destroy();
    end;

    if LocalPlayer:GetAttribute("CanUseCCPanel") then
        p17:SetupPanelIcon();

        return;
    end;

    if p17.PanelIcon then
        local PanelIcon = p17.PanelIcon;
        p17.PanelIcon = nil;
        PanelIcon:destroy();
    end;

    p17:Close();
end;

local function setActiveDropdown(p18: userdata) -- Line: 149
    -- upvalues: u1 (ref)
    local v19 = p18 == u1;

    if u1 then
        u1.Dropdown.Visible = false;
        u1 = nil;
    end;

    if v19 or not p18 then
        return;
    end;

    u1 = p18;
    p18.Dropdown.Visible = true;
end;

local function hookDropdown(u20: userdata, p21: table, u22: function) -- Line: 165
    -- upvalues: u1 (ref)
    u20.Hitbox.Activated:Connect(function() -- Line: 166
        -- upvalues: u20 (copy), u1 (ref)
        local v23 = u20;
        local v24 = v23 == u1;

        if u1 then
            u1.Dropdown.Visible = false;
            u1 = nil;
        end;

        if not v24 then
            if not v23 then
                return;
            end;

            u1 = v23;
            v23.Dropdown.Visible = true;
        end;
    end);
    local Container = u20.Dropdown.Container;
    local Template = Container.Template;
    Template.Parent = nil;

    for _, v in p21 do
        local v25 = Template:Clone();
        v25.Text = v;
        v25.Parent = Container;
        v25.Activated:Connect(function() -- Line: 180
            -- upvalues: u22 (copy), v (copy), u1 (ref)
            u22(v);
            local v26 = u1 == nil;

            if u1 then
                u1.Dropdown.Visible = false;
                u1 = nil;
            end;

            if v26 then
            end;
        end);
    end;
end;

function u2.SetupTrollPanel(u27) -- Line: 187
    -- upvalues: Players (copy)
    local Container = u27.TrollPanel.Players.Container;
    local Commands = u27.TrollPanel.Commands;
    local Template = Container.Template;
    Template.Parent = nil;
    local u28 = nil;
    local u29 = nil;

    local function setSelectedTrolledPlayer(p30: userdata, p31: userdata) -- Line: 200
        -- upvalues: u28 (ref), u29 (ref)
        if u28 then
            if u28.Parent then
                u28.BackgroundColor3 = Color3.new(1, 1, 1);
            end;

            u28 = nil;
            u29 = nil;
        end;

        if p30 == nil or p31 == nil then
            return;
        end;

        u29 = p30;
        u28 = p31;
        p31.BackgroundColor3 = Color3.new(1, 1, 0);
    end;

    local function executeCommand(p32) -- Line: 219
        -- upvalues: u29 (ref), u27 (copy), u28 (ref)
        if not (u29 and p32) then
            return;
        end;

        u27.Server:ExecuteCommand(p32, u29);

        if u28 then
            if u28.Parent then
                u28.BackgroundColor3 = Color3.new(1, 1, 1);
            end;

            u28 = nil;
            u29 = nil;
        end;
    end;

    local function setSelectedCommand(p33: string) -- Line: 228
        -- upvalues: u29 (ref), u27 (copy), u28 (ref)
        if not u29 then
            return;
        end;

        if u29 then
            if not p33 then
                return;
            end;

            u27.Server:ExecuteCommand(p33, u29);

            if u28 then
                if u28.Parent then
                    u28.BackgroundColor3 = Color3.new(1, 1, 1);
                end;

                u28 = nil;
                u29 = nil;
            end;
        end;
    end;

    local function updateActivePlayers() -- Line: 236
        -- upvalues: Players (ref), Container (copy), Template (copy), setSelectedTrolledPlayer (copy)
        local Players2 = Players:GetPlayers();

        for _, child in Container:GetChildren() do
            if child:IsA("ImageButton") then
                local v34 = child;
                local v35 = false;

                for _, v in Players2 do
                    if tostring(v.UserId) == v34.Name then
                        v35 = true;
                    end;
                end;

                if not v35 then
                    v34:Destroy();
                end;
            end;
        end;

        for _, v in Players2 do
            if not Container:FindFirstChild((tostring(v.UserId))) then
                local u36 = Template:Clone();
                u36.Name = tostring(v.UserId);
                u36.Icon.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(v.UserId) .. "&width=420&height=420&format=png";
                u36.Label.Text = "@" .. v.Name;
                u36.Parent = Container;
                u36.Activated:Connect(function() -- Line: 270
                    -- upvalues: setSelectedTrolledPlayer (ref), v (copy), u36 (copy)
                    setSelectedTrolledPlayer(v, u36);
                end);
            end;
        end;
    end;

    for _, child in Commands:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 281
                -- upvalues: child (copy), u29 (ref), u27 (copy), u28 (ref)
                local v37 = child.Name:lower();

                if u29 then
                    if not v37 then
                        return;
                    end;

                    u27.Server:ExecuteCommand(v37, u29);

                    if u28 then
                        if u28.Parent then
                            u28.BackgroundColor3 = Color3.new(1, 1, 1);
                        end;

                        u28 = nil;
                        u29 = nil;
                    end;
                end;
            end);
        end;
    end;

    updateActivePlayers();
    Players.PlayerAdded:Connect(updateActivePlayers);
    Players.PlayerRemoving:Connect(updateActivePlayers);
end;

function u2.SetupDropdowns(u38) -- Line: 291
    -- upvalues: Flows (copy), hookDropdown (copy), TableUtil (copy), PlrStyles (copy)
    local FlowDropdown = u38.Background.FlowDropdown;
    local StyleDropdown = u38.Background.StyleDropdown;
    local v39 = {};

    for i in Flows do
        table.insert(v39, i);
    end;

    table.sort(v39);
    hookDropdown(FlowDropdown, v39, function(p40: string) -- Line: 301
        -- upvalues: u38 (copy)
        u38.Server:SetFlow(p40);
    end);
    local v41 = TableUtil.Keys(PlrStyles);
    table.sort(v41);
    hookDropdown(StyleDropdown, v41, function(p42: string) -- Line: 307
        -- upvalues: u38 (copy)
        u38.Server:SetStyle(p42);
    end);
end;

function u2.CreateTemplateLibrary(p43) -- Line: 312
    if p43.Templates then
        return;
    end;

    local ScrollingFrame = p43.PublicPanel.ScrollingFrame;
    p43.ScrollingFrame = ScrollingFrame;
    p43.ListLayout = ScrollingFrame.UIListLayout;
    p43.Templates = {
        Button = ScrollingFrame.TemplateButton,
        SelectedButton = ScrollingFrame.TemplateButtonSelected,
        Divider = ScrollingFrame.DivTemplate,
        Header = ScrollingFrame.HeaderTemplate,
        ToggleOn = ScrollingFrame.ToggleOnTemplate,
        ToggleOff = ScrollingFrame.ToggleOffTemplate,
        Textbox = ScrollingFrame.TextboxTemplate
    };

    for _, v in pairs(p43.Templates) do
        v.Parent = nil;
    end;

    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0);
end;

function u2.ClearTemplateRows(u44) -- Line: 339
    for _, child in u44.ScrollingFrame:GetChildren() do
        if child ~= u44.ListLayout then
            child:Destroy();
        end;
    end;

    u44.NextLayoutOrder = 0;
    u44.ScrollingFrame.CanvasPosition = Vector2.zero;
    task.defer(function() -- Line: 348
        -- upvalues: u44 (copy)
        u44.ScrollingFrame.CanvasPosition = Vector2.zero;
    end);
end;

function u2.AddTemplateRow(p45: table, p46: userdata, p47: string, p48: number) -- Line: 355
    local v49 = p46:Clone();
    v49.Name = p47;
    v49.LayoutOrder = p45.NextLayoutOrder;
    v49.Size = UDim2.new(0.967, 0, 0, p48);
    v49.Visible = true;
    v49.Parent = p45.ScrollingFrame;
    p45.NextLayoutOrder = p45.NextLayoutOrder + 1;

    return v49;
end;

function u2.AddHeader(p50: table, p51: string) -- Line: 366
    local v52 = p50:AddTemplateRow(p50.Templates.Header, "Header_" .. p51, 34);
    v52.TextLabel.Text = p51;
    v52.TextLabel.TextScaled = true;

    return v52;
end;

function u2.AddDivider(p53) -- Line: 373
    return p53:AddTemplateRow(p53.Templates.Divider, "Divider_" .. tostring(p53.NextLayoutOrder), 3);
end;

function u2.AddButton(p54: table, p55: string, p56: string, p57: function, p58: boolean?) -- Line: 377
    local v59 = p54:AddTemplateRow(p58 and p54.Templates.SelectedButton or p54.Templates.Button, p55, 46);
    v59.TextLabel.Text = p56;
    v59.TextLabel.TextScaled = true;
    v59.Activated:Connect(p57);

    return v59;
end;

function u2.AddToggle(p60: table, p61: string, p62: string, u63: boolean, u64: function) -- Line: 386
    local v65 = p60:AddTemplateRow(u63 and p60.Templates.ToggleOn or p60.Templates.ToggleOff, p61, 42);
    v65.TextLabel.Text = p62;
    v65.TextLabel.TextScaled = true;
    local TemplateButton = v65.TemplateButton;
    TemplateButton.TextLabel.Text = u63 and "ON" or "OFF";
    TemplateButton.TextLabel.TextScaled = true;
    TemplateButton.Activated:Connect(function() -- Line: 395
        -- upvalues: u64 (copy), u63 (copy)
        u64(not u63);
    end);

    return v65;
end;

function u2.AddNumberInput(p66: table, p67: string, p68: string, u69: number, u70: function) -- Line: 402
    local v71 = p66:AddTemplateRow(p66.Templates.Textbox, p67, 42);
    v71.TextLabel.Text = p68;
    v71.TextLabel.TextScaled = true;
    v71.TemplateButton.Active = false;
    v71.TemplateButton.AutoButtonColor = false;
    local TextBox = v71.TextBox;
    TextBox.ClearTextOnFocus = false;
    TextBox.Text = tostring(u69);
    TextBox.FocusLost:Connect(function(p72: boolean) -- Line: 412
        -- upvalues: TextBox (copy), u69 (copy), u70 (copy)
        if not p72 then
            return;
        end;

        local v73 = tonumber(TextBox.Text);

        if v73 then
            u70(v73);

            return;
        end;

        TextBox.Text = tostring(u69);
    end);

    return v71;
end;

function u2.AddTextInput(p74: table, p75: string, p76: string, p77: string, u78: function) -- Line: 429
    local v79 = p74:AddTemplateRow(p74.Templates.Textbox, p75, 42);
    v79.TextLabel.Text = p76;
    v79.TextLabel.TextScaled = true;
    v79.TemplateButton.Active = false;
    v79.TemplateButton.AutoButtonColor = false;
    local TextBox = v79.TextBox;
    TextBox.ClearTextOnFocus = false;
    TextBox.PlaceholderText = "Username (optional)";
    TextBox.Text = p77;
    TextBox.FocusLost:Connect(function() -- Line: 440
        -- upvalues: u78 (copy), TextBox (copy)
        u78(TextBox.Text);
    end);

    return TextBox;
end;

function u2.ToggleFreecam(p80) -- Line: 447
    if not _G.Toggle then
        return;
    end;

    _G.ToggleFreecam();
    p80.FreecamActive = not p80.FreecamActive;

    if p80.FreecamActive and _G.CCFreecam then
        _G.CCFreecam.SetNavigationSpeed(p80.FreecamNavigationSpeed or 1);
        _G.CCFreecam.SetPositionLocked(p80.FreecamPositionLocked == true);
    end;

    if p80.FreecamExit then
        p80.FreecamExit.Enabled = p80.FreecamActive;
    end;
end;

function u2.SetFreecamNavigationSpeed(p81: table, p82: number) -- Line: 465
    p81.FreecamNavigationSpeed = math.clamp(p82, 0.01, 4);

    if _G.CCFreecam then
        _G.CCFreecam.SetNavigationSpeed(p81.FreecamNavigationSpeed);
    end;
end;

function u2.SetFreecamPositionLocked(p83: table, p84: boolean) -- Line: 472
    p83.FreecamPositionLocked = p84;

    if _G.CCFreecam then
        _G.CCFreecam.SetPositionLocked(p84);
    end;
end;

function u2.BindPublicAwakeningState(u85) -- Line: 479
    -- upvalues: LocalPlayer (copy)
    if u85.PublicAwakeningStateBound then
        return;
    end;

    u85.PublicAwakeningStateBound = true;
    task.spawn(function() -- Line: 485
        -- upvalues: LocalPlayer (ref), u85 (copy)
        LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("InAwakening"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 488
            -- upvalues: u85 (ref)
            if u85.Screen.Enabled and (u85.PublicPanel.Visible and u85:GetPanelMode() == "Public") then
                u85:RenderPublicPanel();
            end;
        end);
    end);
end;

function u2.RenderPublicPanel(u86) -- Line: 496
    u86:ClearTemplateRows();
    u86.PublicPanel.HeaderText.TextLabel.Text = "Public CC Panel";
    u86:AddHeader("Awakening");
    u86:AddButton("FullAwakeningBar", "Full Awakening Bar", function() -- Line: 501
        -- upvalues: u86 (copy)
        u86.Server:PublicInstantAwakening();
    end);
    u86:AddButton("SecretAwakening", "Secret Awakening", function() -- Line: 504
        -- upvalues: u86 (copy)
        u86.Server:PublicSecretAwakening();
    end, true);
    u86:AddDivider();
    u86:AddHeader("Flow");
    u86:AddButton("FullFlow", "Full Flow", function() -- Line: 510
        -- upvalues: u86 (copy)
        u86.Server:FullFlow();
    end);
end;

function u2.RenderSelectionPanel(u87: table, u88: string) -- Line: 515
    -- upvalues: TableUtil (copy), PlrStyles (copy), Flows (copy)
    u87:ClearTemplateRows();
    u87.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u87:AddButton("Back", "Back", function() -- Line: 518
        -- upvalues: u87 (copy)
        u87:RenderMainPanel();
    end);

    local function addChoice(u89: string) -- Line: 522
        -- upvalues: u87 (copy), u88 (copy)
        u87:AddButton(u88 .. "_" .. u89, u89, function() -- Line: 523
            -- upvalues: u88 (ref), u87 (ref), u89 (copy)
            if u88 == "Style" then
                u87.Server:SetStyle(u89);
            else
                u87.Server:SetFlow(u89);
            end;

            u87:RenderMainPanel();
        end);
    end;

    local v90 = u88 == "Style" and TableUtil.Keys(PlrStyles) or TableUtil.Keys(Flows);
    table.sort(v90);

    if u88 ~= "Style" then
        u87:AddHeader("Select Flow");

        for _, v in ipairs(v90) do
            u87:AddButton(u88 .. "_" .. v, v, function() -- Line: 523
                -- upvalues: u88 (copy), u87 (copy), v (copy)
                if u88 == "Style" then
                    u87.Server:SetStyle(v);
                else
                    u87.Server:SetFlow(v);
                end;

                u87:RenderMainPanel();
            end);
        end;

        return;
    end;

    local v91 = {};
    local v92 = {};

    for _, v in ipairs(v90) do
        if v:sub(1, 4) == "NEL " then
            table.insert(v92, v);
        else
            table.insert(v91, v);
        end;
    end;

    u87:AddHeader("Styles");

    for _, v in ipairs(v91) do
        u87:AddButton(u88 .. "_" .. v, v, function() -- Line: 523
            -- upvalues: u88 (copy), u87 (copy), v (copy)
            if u88 == "Style" then
                u87.Server:SetStyle(v);
            else
                u87.Server:SetFlow(v);
            end;

            u87:RenderMainPanel();
        end);
    end;

    if #v92 > 0 then
        u87:AddDivider();
        u87:AddHeader("NEL Styles");

        for _, v in ipairs(v92) do
            u87:AddButton(u88 .. "_" .. v, v, function() -- Line: 523
                -- upvalues: u88 (copy), u87 (copy), v (copy)
                if u88 == "Style" then
                    u87.Server:SetStyle(v);
                else
                    u87.Server:SetFlow(v);
                end;

                u87:RenderMainPanel();
            end);
        end;
    end;
end;

function u2.RenderTrollTargets(u93) -- Line: 568
    -- upvalues: Players (copy)
    u93:ClearTemplateRows();
    u93.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u93:AddButton("Back", "Back", function() -- Line: 571
        -- upvalues: u93 (copy)
        u93:RenderMainPanel();
    end);
    u93:AddHeader("Choose a Player");
    local Players2 = Players:GetPlayers();
    table.sort(Players2, function(p94, p95) -- Line: 577
        return p94.Name:lower() < p95.Name:lower();
    end);

    for _, v in ipairs(Players2) do
        u93:AddButton("Target_" .. tostring(v.UserId), "@" .. v.Name, function() -- Line: 582
            -- upvalues: u93 (copy), v (copy)
            u93:RenderTrollCommands(v);
        end);
    end;
end;

function u2.RenderTrollCommands(u96: table, u97: userdata) -- Line: 588
    u96:ClearTemplateRows();
    u96.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u96:AddButton("Back", "Back", function() -- Line: 591
        -- upvalues: u96 (copy)
        u96:RenderTrollTargets();
    end);
    u96:AddHeader("Trolling @" .. u97.Name);

    for _, v in ipairs({ {
            Name = "Inverse",
            Text = "Inverse Controls"
        }, {
            Name = "Invisible",
            Text = "Invisible"
        }, {
            Name = "Fling",
            Text = "Fling"
        }, {
            Name = "Freeze",
            Text = "Freeze"
        }, {
            Name = "Blind",
            Text = "Blind Screen"
        }, {
            Name = "Size",
            Text = "Scale x1.5"
        } }) do
        u96:AddButton(v.Name, v.Text, function() -- Line: 606
            -- upvalues: u96 (copy), v (copy), u97 (copy)
            u96.Server:ExecuteCommand(v.Name:lower(), u97);
        end);
    end;
end;

function u2.RenderMVPPreviewList(u98) -- Line: 612
    -- upvalues: TableUtil (copy), MVPCutscenes (copy)
    u98:ClearTemplateRows();
    u98.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u98:AddButton("Back", "Back", function() -- Line: 615
        -- upvalues: u98 (copy)
        u98:RenderMainPanel();
    end);
    u98:AddHeader("MVP Cutscene Preview");
    local v99 = TableUtil.Keys(MVPCutscenes);
    table.sort(v99, function(p100, p101) -- Line: 621
        -- upvalues: MVPCutscenes (ref)
        local v102 = MVPCutscenes[p101].Display or p101;

        return (MVPCutscenes[p100].Display or p100):lower() < v102:lower();
    end);

    for _, v in ipairs(v99) do
        u98:AddButton("MVP_" .. v, MVPCutscenes[v].Display or v, function() -- Line: 629
            -- upvalues: u98 (copy), v (copy)
            u98:RenderMVPPreviewSetup(v);
        end);
    end;
end;

function u2.RenderMVPPreviewSetup(u103: table, u104: string) -- Line: 635
    -- upvalues: MVPCutscenes (copy), Knit (copy)
    local v105 = MVPCutscenes[u104];

    if not v105 then
        u103:RenderMVPPreviewList();

        return;
    end;

    u103:ClearTemplateRows();
    u103.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u103:AddButton("Back", "Back", function() -- Line: 644
        -- upvalues: u103 (copy)
        u103:RenderMVPPreviewList();
    end);
    u103:AddHeader(v105.Display or u104);
    u103:AddHeader("Cast (blank = default dummy)");
    u103.MVPPreviewCast = u103.MVPPreviewCast or {};
    local u106 = u103.MVPPreviewCast[u104];

    if not u106 then
        u106 = {
            MainUsername = "",
            TeammateUsernames = { "", "", "", "" }
        };
        u103.MVPPreviewCast[u104] = u106;
    end;

    local u108 = u103:AddTextInput("MVPMainActor", "Main Actor", u106.MainUsername or "", function(p107) -- Line: 660
        -- upvalues: u106 (ref)
        u106.MainUsername = p107;
    end);
    local u109 = {};

    for i = 1, 4 do
        u109[i] = u103:AddTextInput("MVPGuest" .. i, "Guest " .. i, u106.TeammateUsernames[i] or "", function(p110) -- Line: 665
            -- upvalues: u106 (ref), i (copy)
            u106.TeammateUsernames[i] = p110;
        end);
        local _ = i;
    end;

    u103:AddButton("RunMVPPreview", "Run Preview", function() -- Line: 670
        -- upvalues: u106 (ref), u108 (copy), u109 (copy), u103 (copy), Knit (ref), u104 (copy)
        u106.MainUsername = u108.Text;

        for i, v in ipairs(u109) do
            u106.TeammateUsernames[i] = v.Text;
        end;

        u103:Close();
        Knit.GetController("Packs"):PreviewMVP(u104, u106);
    end, true);
end;

function u2.RenderPrivatePanel(u111) -- Line: 681
    u111:ClearTemplateRows();
    u111.PublicPanel.HeaderText.TextLabel.Text = "Custom Server CC Panel";
    u111:AddHeader("Player");
    u111:AddButton("Style", "Select Style", function() -- Line: 686
        -- upvalues: u111 (copy)
        u111:RenderSelectionPanel("Style");
    end);
    u111:AddButton("Flow", "Select Flow", function() -- Line: 689
        -- upvalues: u111 (copy)
        u111:RenderSelectionPanel("Flow");
    end);
    u111:AddDivider();
    u111:AddHeader("Match");
    u111:AddButton("FullFlow", "Full Flow", function() -- Line: 695
        -- upvalues: u111 (copy)
        u111.Server:FullFlow();
    end);
    u111:AddButton("FullAwakeningBar", "Full Awakening Bar", function() -- Line: 698
        -- upvalues: u111 (copy)
        u111.Server:InstantAwakening();
    end);
    u111:AddButton("SecretAwakening", "Secret Awakening", function() -- Line: 701
        -- upvalues: u111 (copy)
        u111.Server:SecretAwakening();
    end, true);
    u111:AddDivider();
    u111:AddHeader("Character");
    u111:AddNumberInput("Speed", "Player Speed", 23, function(p112) -- Line: 707
        -- upvalues: u111 (copy)
        u111.Server:SetSpeed(p112);
    end);
    u111:AddButton("ResetSpeed", "Reset Speed", function() -- Line: 710
        -- upvalues: u111 (copy)
        u111.Server:SetSpeed(23);
        u111:RenderMainPanel();
    end);
    u111:AddNumberInput("Size", "Player Size", 1, function(p113) -- Line: 714
        -- upvalues: u111 (copy)
        u111.Server:SetSize(p113);
    end);
    u111:AddButton("ResetSize", "Reset Size", function() -- Line: 717
        -- upvalues: u111 (copy)
        u111.Server:SetSize(1);
        u111:RenderMainPanel();
    end);
    u111:AddToggle("NoCooldowns", "No Cooldowns", u111.NoCooldowns == true, function(p114) -- Line: 721
        -- upvalues: u111 (copy)
        u111.NoCooldowns = p114;
        u111.Server:ToggleCooldowns(p114);
        u111:RenderMainPanel();
    end);
    u111:AddDivider();
    u111:AddHeader("Camera");
    u111:AddButton("Freecam", "Toggle Freecam", function() -- Line: 729
        -- upvalues: u111 (copy)
        u111:ToggleFreecam();
    end, u111.FreecamActive);
    u111:AddNumberInput("CameraSpeed", "Camera Speed", u111.FreecamNavigationSpeed or 1, function(p115) -- Line: 732
        -- upvalues: u111 (copy)
        u111:SetFreecamNavigationSpeed(p115);
    end);
    u111:AddToggle("CameraPositionLocked", "Lock Camera Position", u111.FreecamPositionLocked == true, function(p116) -- Line: 735
        -- upvalues: u111 (copy)
        u111:SetFreecamPositionLocked(p116);
        u111:RenderMainPanel();
    end);
    u111:AddDivider();
    u111:AddHeader("Creator Tools");
    u111:AddButton("MVPPreview", "MVP Cutscene Preview", function() -- Line: 742
        -- upvalues: u111 (copy)
        u111:RenderMVPPreviewList();
    end);
    u111:AddButton("Trolling", "Troll Players", function() -- Line: 745
        -- upvalues: u111 (copy)
        u111:RenderTrollTargets();
    end);
end;

function u2.RenderMainPanel(p117) -- Line: 750
    if p117:IsPrivatePanel() then
        p117:RenderPrivatePanel();

        return;
    end;

    p117:RenderPublicPanel();
end;

function u2.SetupPublicPanel(u118) -- Line: 758
    u118:CreateTemplateLibrary();

    if not u118.PublicCloseBound then
        u118.PublicCloseBound = true;
        u118.PublicPanel.CloseButton.Activated:Connect(function() -- Line: 763
            -- upvalues: u118 (copy)
            u118:Close();
        end);
    end;

    u118:RenderMainPanel();
end;

function u2.SetupPrivateExtras(u119) -- Line: 771
    local InputVals = u119.Background.InputVals;
    local InstantAwakening = InputVals:FindFirstChild("InstantAwakening");

    if not InstantAwakening or InputVals:FindFirstChild("SecretAwakening") then
        return;
    end;

    local v120 = InstantAwakening:Clone();
    v120.Name = "SecretAwakening";
    v120.LayoutOrder = 12;
    v120.Label.Text = "Secret Awakening";
    v120.Box.Text = "GIVE";
    v120.Parent = InputVals;
    v120.Box.Activated:Connect(function() -- Line: 784
        -- upvalues: u119 (copy)
        u119.Server:SecretAwakening();
    end);
    InputVals.Size = UDim2.new(0.9, 0, 0.36, 0);
end;

function u2.SetupTrollExtras(p121) -- Line: 791
    local Commands = p121.TrollPanel.Commands;

    if Commands:FindFirstChild("Fling") then
        return;
    end;

    local Inverse = Commands.Inverse;

    for i, v in ipairs({ {
            Name = "Inverse",
            Text = "Inverse"
        }, {
            Name = "Invisible",
            Text = "Invisible"
        }, {
            Name = "Fling",
            Text = "Fling"
        }, {
            Name = "Freeze",
            Text = "Freeze"
        }, {
            Name = "Blind",
            Text = "Blind"
        }, {
            Name = "Size",
            Text = "Scale x1.5"
        } }) do
        local v122 = Commands:FindFirstChild(v.Name);

        if not v122 then
            v122 = Inverse:Clone();
            v122.Name = v.Name;
            v122.Parent = Commands;
        end;

        v122.LayoutOrder = i;
        v122.Size = UDim2.new(1, 0, 0.13, 0);
        v122.Label.Text = v.Text;
        v122.Visible = true;
    end;
end;

function u2.GuiStart(u123) -- Line: 822
    -- upvalues: LocalPlayer (copy)
    u123.NoCooldowns = false;
    u123:SetupPublicPanel();
    u123:BindPublicAwakeningState();
    u123:UpdatePanelIcon();
    LocalPlayer:GetAttributeChangedSignal("CanUseCCPanel"):Connect(function() -- Line: 827
        -- upvalues: u123 (copy)
        u123:UpdatePanelIcon();
    end);
    u123:Close();
end;

function u2.KnitStart(u124) -- Line: 833
    -- upvalues: Knit (copy), LocalPlayer (copy), Popup (copy)
    Knit.OnStart():andThenCall(u124.GuiStart, u124);
    u124.Server.OpenPrivatePanel:Connect(function() -- Line: 837
        -- upvalues: u124 (copy)
        u124.DevPrivatePanelGranted = true;
        u124.PanelModeOverride = "Custom";
        u124:Open();
    end);
    local TextChatService = game:GetService("TextChatService");
    local TextChatCommand = Instance.new("TextChatCommand");
    TextChatCommand.Parent = TextChatService:WaitForChild("TextChatCommands");
    TextChatCommand.PrimaryAlias = "/ccpanel";
    TextChatCommand.SecondaryAlias = "/ccp";
    TextChatCommand.AutocompleteVisible = true;
    TextChatCommand.Triggered:Connect(function(p125: any, p126: string) -- Line: 850
        -- upvalues: LocalPlayer (ref), Popup (ref), u124 (copy)
        if not LocalPlayer:GetAttribute("CanUseCCPanel") then
            Popup.Popup(LocalPlayer, "You need content creator rank to use this");

            return;
        end;

        local string_lower_ret = string.lower(p126 or "");
        local string_gsub_ret = string.gsub(string_lower_ret, "^%s*/ccpanel%s*", "");
        local string_gsub_ret2 = string.gsub(string_gsub_ret, "^%s*/ccp%s*", "");
        local v127 = string.match(string_gsub_ret2, "^%s*(.-)%s*$") or "";

        if v127 == "" then
            u124:Open();

            return;
        end;

        if v127 == "public" then
            u124:SetPanelMode("public");

            return;
        end;

        if v127 == "custom" or v127 == "private" then
            u124:SetPanelMode("custom");

            return;
        end;

        if v127 == "auto" then
            u124:SetPanelMode("auto");

            return;
        end;

        Popup.Popup(LocalPlayer, "Use /ccpanel public, /ccpanel custom, or /ccpanel auto.");
    end);
end;

function u2.KnitInit(u128) -- Line: 875
    -- upvalues: PlayerGui (copy), Knit (copy), LocalPlayer (copy)
    u128.Screen = PlayerGui:WaitForChild("CCPanel");
    u128.Screen.DisplayOrder = 9999;
    u128.Screen.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    u128.Background = u128.Screen.BG;
    u128.TrollPanel = u128.Screen.Troll;
    u128.PublicPanel = u128.Screen:WaitForChild("CCPanel");
    u128.Server = Knit.GetService("CCPanelService");
    u128.CustomServer = Knit.GetService("CustomServerService");
    u128.PanelModeOverride = nil;
    u128.DevPrivatePanelGranted = false;
    u128.FreecamActive = false;
    u128.FreecamNavigationSpeed = 1;
    u128.FreecamPositionLocked = false;
    u128.FreecamExit = PlayerGui:WaitForChild("FreecamExit", 5);

    if u128.FreecamExit then
        u128.FreecamExit.Enabled = false;
        local Exit = u128.FreecamExit:FindFirstChild("Exit");

        if Exit then
            Exit.Activated:Connect(function() -- Line: 894
                -- upvalues: u128 (copy)
                if u128.FreecamActive and _G.ToggleFreecam then
                    _G.ToggleFreecam();
                end;

                u128.FreecamActive = false;
                u128.FreecamExit.Enabled = false;
            end);
        end;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "CCBlindOverlay";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 500;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Visible = false;
    Frame.Parent = ScreenGui;
    u128.Server.ScreenBlind:Connect(function(p129) -- Line: 918
        -- upvalues: Frame (copy)
        Frame.Visible = p129 == true;
    end);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 922
        -- upvalues: Frame (copy)
        Frame.Visible = false;
    end);
    local u130 = false;
    local u131 = nil;
    u128.Server.ControlsInversed:Connect(function() -- Line: 928
        -- upvalues: LocalPlayer (ref), u130 (ref), u131 (ref)
        local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");
        local Controls = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls();
        u130 = not u130;

        if not u130 then
            if u131 then
                Controls.moveFunction = u131;
                u131 = nil;
            end;

            return;
        end;

        u131 = Controls.moveFunction;

        function Controls.moveFunction(p132, p133) -- Line: 936
            -- upvalues: LocalPlayer (ref)
            LocalPlayer:Move(-p133, true);
        end;
    end);
end;

return u2;