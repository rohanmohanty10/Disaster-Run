  

game:GetService("LocalizationService");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("TextService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local l_script = script;
local Reference = require(l_script.Reference);
local Object = Reference.getObject();
local v1;

if Object then
    v1 = Object.Value;
else
    v1 = Object;
end;

if v1 and v1 ~= l_script then
    return require(v1);
end;

if not Object then
    Reference.addToReplicatedStorage();
end;

local GoodSignal = require(l_script.Packages.GoodSignal);
local Janitor = require(l_script.Packages.Janitor);
local Utility = require(l_script.Utility);
require(l_script.Attribute);
local Themes = require(l_script.Features.Themes);
local Gamepad = require(l_script.Features.Gamepad);
local Overflow = require(l_script.Features.Overflow);
local u2 = {};
u2.__index = u2;
local Themes2 = l_script.Features.Themes;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u3 = {};
local u4 = GoodSignal.new();
local Elements = l_script.Elements;
local u5 = 0;

if GuiService.TopbarInset.Height == 0 then
    GuiService:GetPropertyChangedSignal("TopbarInset"):Wait();
end;

u2.baseDisplayOrderChanged = GoodSignal.new();
u2.baseDisplayOrder = 10;
u2.baseTheme = require(Themes2.Default);
u2.isOldTopbar = GuiService.TopbarInset.Height == 36;
u2.iconsDictionary = u3;
u2.container = require(Elements.Container)(u2);
u2.topbarEnabled = true;
u2.iconAdded = GoodSignal.new();
u2.iconRemoved = GoodSignal.new();
u2.iconChanged = GoodSignal.new();

function u2.getIcons() -- Line: 112
    -- upvalues: u2 (copy)
    return u2.iconsDictionary;
end;

function u2.getIconByUID(p6) -- Line: 116
    -- upvalues: u2 (copy)
    local v7 = u2.iconsDictionary[p6];

    if v7 then
        return v7;
    end;
end;

function u2.getIcon(p8) -- Line: 123
    -- upvalues: u2 (copy), u3 (copy)
    local IconByUID = u2.getIconByUID(p8);

    if IconByUID then
        return IconByUID;
    end;

    for _, v in pairs(u3) do
        if v.name == p8 then
            return v;
        end;
    end;
end;

function u2.setTopbarEnabled(p9, p10) -- Line: 135
    -- upvalues: u2 (copy)
    if typeof(p9) ~= "boolean" then
        p9 = u2.topbarEnabled;
    end;

    if not p10 then
        u2.topbarEnabled = p9;
    end;

    for _, v in pairs(u2.container) do
        v.Enabled = p9;
    end;
end;

function u2.modifyBaseTheme(p11) -- Line: 147
    -- upvalues: Themes (copy), u2 (copy), u3 (copy)
    local Modifications = Themes.getModifications(p11);

    for _, v in pairs(Modifications) do
        local v12 = v;

        for _, v2 in pairs(u2.baseTheme) do
            Themes.merge(v2, v12);
        end;
    end;

    for _, v in pairs(u3) do
        v:setTheme(u2.baseTheme);
    end;
end;

function u2.setDisplayOrder(p13) -- Line: 159
    -- upvalues: u2 (copy)
    u2.baseDisplayOrder = p13;
    u2.baseDisplayOrderChanged:Fire(p13);
end;

task.defer(Gamepad.start, u2);
task.defer(Overflow.start, u2);

for _, v in pairs(u2.container) do
    v.Parent = PlayerGui;
end;

if u2.isOldTopbar then
    u2.modifyBaseTheme(require(Themes2.Classic));
end;

function u2.new() -- Line: 179
    -- upvalues: u2 (copy), Janitor (copy), Utility (copy), u3 (copy), GoodSignal (copy), l_script (copy), Elements (copy), u5 (ref), UserInputService (copy), u4 (copy), StarterGui (copy)
    local u14 = {};
    setmetatable(u14, u2);
    local v15 = Janitor.new();
    u14.janitor = v15;
    u14.themesJanitor = v15:add(Janitor.new());
    u14.singleClickJanitor = v15:add(Janitor.new());
    u14.captionJanitor = v15:add(Janitor.new());
    u14.joinJanitor = v15:add(Janitor.new());
    u14.menuJanitor = v15:add(Janitor.new());
    u14.dropdownJanitor = v15:add(Janitor.new());
    local u16 = Utility.generateUID();
    u3[u16] = u14;
    v15:add(function() -- Line: 196
        -- upvalues: u3 (ref), u16 (copy)
        u3[u16] = nil;
    end);
    u14.selected = v15:add(GoodSignal.new());
    u14.deselected = v15:add(GoodSignal.new());
    u14.toggled = v15:add(GoodSignal.new());
    u14.viewingStarted = v15:add(GoodSignal.new());
    u14.viewingEnded = v15:add(GoodSignal.new());
    u14.stateChanged = v15:add(GoodSignal.new());
    u14.notified = v15:add(GoodSignal.new());
    u14.noticeStarted = v15:add(GoodSignal.new());
    u14.noticeChanged = v15:add(GoodSignal.new());
    u14.endNotices = v15:add(GoodSignal.new());
    u14.toggleKeyAdded = v15:add(GoodSignal.new());
    u14.fakeToggleKeyChanged = v15:add(GoodSignal.new());
    u14.alignmentChanged = v15:add(GoodSignal.new());
    u14.updateSize = v15:add(GoodSignal.new());
    u14.resizingComplete = v15:add(GoodSignal.new());
    u14.joinedParent = v15:add(GoodSignal.new());
    u14.menuSet = v15:add(GoodSignal.new());
    u14.dropdownSet = v15:add(GoodSignal.new());
    u14.updateMenu = v15:add(GoodSignal.new());
    u14.startMenuUpdate = v15:add(GoodSignal.new());
    u14.childThemeModified = v15:add(GoodSignal.new());
    u14.indicatorSet = v15:add(GoodSignal.new());
    u14.dropdownChildAdded = v15:add(GoodSignal.new());
    u14.menuChildAdded = v15:add(GoodSignal.new());
    u14.iconModule = l_script;
    u14.UID = u16;
    u14.isEnabled = true;
    u14.isSelected = false;
    u14.isViewing = false;
    u14.joinedFrame = false;
    u14.parentIconUID = false;
    u14.deselectWhenOtherIconSelected = true;
    u14.totalNotices = 0;
    u14.activeState = "Deselected";
    u14.alignment = "";
    u14.originalAlignment = "";
    u14.appliedTheme = {};
    u14.appearance = {};
    u14.cachedInstances = {};
    u14.cachedNamesToInstances = {};
    u14.cachedCollectives = {};
    u14.bindedToggleKeys = {};
    u14.customBehaviours = {};
    u14.toggleItems = {};
    u14.bindedEvents = {};
    u14.notices = {};
    u14.menuIcons = {};
    u14.dropdownIcons = {};
    u14.childIconsDict = {};
    u14.isOldTopbar = u2.isOldTopbar;
    u14.creationTime = os.clock();
    u14.widget = v15:add(require(Elements.Widget)(u14, u2));
    u14:setAlignment();
    u5 = u5 + 1;
    u14:setOrder(u5);
    u14:setTheme(u2.baseTheme);
    local Instance = u14:getInstance("ClickRegion");

    local function handleToggle() -- Line: 271
        -- upvalues: u14 (copy)
        if u14.locked then
            return;
        end;

        if u14.isSelected then
            u14:deselect("User", u14);

            return;
        end;

        u14:select("User", u14);
    end;

    local u17 = false;
    local u18 = false;
    Instance.MouseButton1Click:Connect(function() -- Line: 283
        -- upvalues: u17 (ref), u18 (ref), u14 (copy)
        if u17 then
            return;
        end;

        u18 = true;
        task.delay(0.01, function() -- Line: 288
            -- upvalues: u18 (ref)
            u18 = false;
        end);

        if u14.locked then
            return;
        end;

        if u14.isSelected then
            u14:deselect("User", u14);

            return;
        end;

        u14:select("User", u14);
    end);
    Instance.TouchTap:Connect(function() -- Line: 293
        -- upvalues: u18 (ref), u17 (ref), u14 (copy)
        if u18 then
            return;
        end;

        u17 = true;
        task.delay(0.01, function() -- Line: 300
            -- upvalues: u17 (ref)
            u17 = false;
        end);

        if u14.locked then
            return;
        end;

        if u14.isSelected then
            u14:deselect("User", u14);

            return;
        end;

        u14:select("User", u14);
    end);
    v15:add(UserInputService.InputBegan:Connect(function(p19, p20) -- Line: 307
        -- upvalues: u14 (copy)
        if u14.locked then
            return;
        end;

        if u14.bindedToggleKeys[p19.KeyCode] and not p20 then
            if u14.locked then
                return;
            end;

            if u14.isSelected then
                u14:deselect("User", u14);

                return;
            end;

            u14:select("User", u14);
        end;
    end));

    local function viewingEnded() -- Line: 329
        -- upvalues: u14 (copy)
        if u14.locked then
            return;
        end;

        u14.isViewing = false;
        u14.viewingEnded:Fire(true);
        u14:setState(nil, "User", u14);
    end;

    u14.joinedParent:Connect(function() -- Line: 337
        -- upvalues: u14 (copy)
        if u14.isViewing then
            if u14.locked then
                return;
            end;

            u14.isViewing = false;
            u14.viewingEnded:Fire(true);
            u14:setState(nil, "User", u14);
        end;
    end);
    Instance.MouseEnter:Connect(function() -- Line: 342
        -- upvalues: UserInputService (ref), u14 (copy)
        local v21 = not UserInputService.KeyboardEnabled;

        if u14.locked then
            return;
        end;

        u14.isViewing = true;
        u14.viewingStarted:Fire(true);

        if not v21 then
            u14:setState("Viewing", "User", u14);
        end;
    end);
    local u22 = 0;
    v15:add(UserInputService.TouchEnded:Connect(viewingEnded));
    Instance.MouseLeave:Connect(viewingEnded);
    Instance.SelectionGained:Connect(function(p23) -- Line: 319, Name: viewingStarted
        -- upvalues: u14 (copy)
        if u14.locked then
            return;
        end;

        u14.isViewing = true;
        u14.viewingStarted:Fire(true);

        if not p23 then
            u14:setState("Viewing", "User", u14);
        end;
    end);
    Instance.SelectionLost:Connect(viewingEnded);
    Instance.MouseButton1Down:Connect(function() -- Line: 351
        -- upvalues: u14 (copy), UserInputService (ref), u22 (ref)
        if not u14.locked and UserInputService.TouchEnabled then
            u22 = u22 + 1;
            local u24 = u22;
            task.delay(0.2, function() -- Line: 355
                -- upvalues: u24 (copy), u22 (ref), u14 (ref)
                if u24 == u22 then
                    if u14.locked then
                        return;
                    end;

                    u14.isViewing = true;
                    u14.viewingStarted:Fire(true);
                    u14:setState("Viewing", "User", u14);
                end;
            end);
        end;
    end);
    Instance.MouseButton1Up:Connect(function() -- Line: 362
        -- upvalues: u22 (ref)
        u22 = u22 + 1;
    end);
    local Instance2 = u14:getInstance("IconOverlay");
    u14.viewingStarted:Connect(function() -- Line: 368
        -- upvalues: Instance2 (copy), u14 (copy)
        Instance2.Visible = not u14.overlayDisabled;
    end);
    u14.viewingEnded:Connect(function() -- Line: 371
        -- upvalues: Instance2 (copy)
        Instance2.Visible = false;
    end);
    v15:add(u4:Connect(function(p25) -- Line: 376
        -- upvalues: u14 (copy)
        if p25 ~= u14 and (u14.deselectWhenOtherIconSelected and p25.deselectWhenOtherIconSelected) then
            u14:deselect("AutoDeselect", p25);
        end;
    end));
    local debug_info_ret = debug.info(2, "s");
    local string_split_ret = string.split(debug_info_ret, ".");
    local l_game = game;
    local v26 = nil;

    for _, v in pairs(string_split_ret) do
        l_game = l_game:FindFirstChild(v);

        if not l_game then
            break;
        end;

        if l_game:IsA("ScreenGui") then
            v26 = l_game;
        end;
    end;

    if l_game and (v26 and v26.ResetOnSpawn == true) then
        Utility.localPlayerRespawned(function() -- Line: 401
            -- upvalues: u14 (copy)
            u14:destroy();
        end);
    end;

    u14:getInstance("NoticeLabel");
    u14.toggled:Connect(function(p27) -- Line: 408
        -- upvalues: u14 (copy), u2 (ref)
        u14.noticeChanged:Fire(u14.totalNotices);

        for i, _ in pairs(u14.childIconsDict) do
            local IconByUID = u2.getIconByUID(i);
            IconByUID.noticeChanged:Fire(IconByUID.totalNotices);

            if not p27 and IconByUID.isSelected then
                for _, _ in pairs(IconByUID.childIconsDict) do
                    IconByUID:deselect("HideParentFeature", u14);
                end;
            end;
        end;
    end);
    u14.selected:Connect(function() -- Line: 431
        -- upvalues: u14 (copy), StarterGui (ref)
        if #u14.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u14.alignment ~= "Right" then
                u14.chatWasPreviouslyActive = true;
                StarterGui:SetCore("ChatActive", false);
            end;

            if StarterGui:GetCoreGuiEnabled("PlayerList") and u14.alignment ~= "Left" then
                u14.playerlistWasPreviouslyActive = true;
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u14.deselected:Connect(function() -- Line: 444
        -- upvalues: u14 (copy), StarterGui (ref)
        if u14.chatWasPreviouslyActive then
            u14.chatWasPreviouslyActive = nil;
            StarterGui:SetCore("ChatActive", true);
        end;

        if u14.playerlistWasPreviouslyActive then
            u14.playerlistWasPreviouslyActive = nil;
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() -- Line: 459
        -- upvalues: u14 (copy)
        if u14.activeState == "Deselected" then
            u14.stateChanged:Fire("Deselected");
            u14:refresh();
        end;
    end);
    u2.iconAdded:Fire(u14);

    return u14;
end;

function u2.setName(p28, p29) -- Line: 475
    p28.widget.Name = p29;
    p28.name = p29;

    return p28;
end;

function u2.setState(p30, p31, p32, p33) -- Line: 481
    -- upvalues: Utility (copy), u4 (copy)
    local v34 = Utility.formatStateName(p31 or (p30.isSelected and "Selected" or "Deselected"));

    if p30.activeState == v34 then
        return;
    end;

    local isSelected = p30.isSelected;
    p30.activeState = v34;

    if v34 == "Deselected" then
        p30.isSelected = false;

        if isSelected then
            p30.toggled:Fire(false, p32, p33);
            p30.deselected:Fire(p32, p33);
        end;

        p30:_setToggleItemsVisible(false, p32, p33);
    elseif v34 == "Selected" then
        p30.isSelected = true;

        if not isSelected then
            p30.toggled:Fire(true, p32, p33);
            p30.selected:Fire(p32, p33);
            u4:Fire(p30, p32, p33);
        end;

        p30:_setToggleItemsVisible(true, p32, p33);
    end;

    p30.stateChanged:Fire(v34, p32, p33);
end;

function u2.getInstance(u35, u36) -- Line: 514
    -- upvalues: Themes (copy)
    local v37 = u35.cachedNamesToInstances[u36];

    if v37 then
        return v37;
    end;

    local function cacheInstance(u38, u39) -- Line: 522
        -- upvalues: u35 (copy)
        if not u35.cachedInstances[u39] then
            local Attribute = u39:GetAttribute("Collective");

            if Attribute then
                Attribute = u35.cachedCollectives[Attribute];
            end;

            if Attribute then
                table.insert(Attribute, u39);
            end;

            u35.cachedNamesToInstances[u38] = u39;
            u35.cachedInstances[u39] = true;
            u39.Destroying:Once(function() -- Line: 532
                -- upvalues: u35 (ref), u38 (copy), u39 (copy)
                u35.cachedNamesToInstances[u38] = nil;
                u35.cachedInstances[u39] = nil;
            end);
        end;
    end;

    local widget = u35.widget;
    cacheInstance("Widget", widget);

    if u36 == "Widget" then
        return widget;
    end;

    local u40 = nil;

    local function scanChildren(p41) -- Line: 545
        -- upvalues: u35 (copy), Themes (ref), scanChildren (copy), cacheInstance (copy), u36 (copy), u40 (ref)
        for _, child in pairs(p41:GetChildren()) do
            local Attribute = child:GetAttribute("WidgetUID");

            if not Attribute or Attribute == u35.UID then
                local v42 = Themes.getRealInstance(child) or child;
                scanChildren(v42);

                if v42:IsA("GuiBase") or (v42:IsA("UIBase") or v42:IsA("ValueBase")) then
                    local Name = v42.Name;
                    cacheInstance(Name, v42);

                    if Name == u36 then
                        u40 = v42;
                    end;
                end;
            end;
        end;
    end;

    scanChildren(widget);

    return u40;
end;

function u2.getCollective(p43, p44) -- Line: 575
    local v45 = p43.cachedCollectives[p44];

    if v45 then
        return v45;
    end;

    local v46 = {};

    for i, _ in pairs(p43.cachedInstances) do
        if i:GetAttribute("Collective") == p44 then
            table.insert(v46, i);
        end;
    end;

    p43.cachedCollectives[p44] = v46;

    return v46;
end;

function u2.getInstanceOrCollective(p47, p48) -- Line: 596
    local v49 = {};
    local Instance = p47:getInstance(p48);

    if Instance then
        table.insert(v49, Instance);
    end;

    if #v49 == 0 then
        v49 = p47:getCollective(p48);
    end;

    return v49;
end;

function u2.getStateGroup(p50, p51) -- Line: 610
    local v52 = p51 or p50.activeState;
    local v53 = p50.appearance[v52];

    if not v53 then
        v53 = {};
        p50.appearance[v52] = v53;
    end;

    return v53;
end;

function u2.refreshAppearance(p54, p55, p56) -- Line: 620
    -- upvalues: Themes (copy)
    Themes.refresh(p54, p55, p56);

    return p54;
end;

function u2.refresh(p57) -- Line: 625
    p57:refreshAppearance(p57.widget);
    p57.updateSize:Fire();

    return p57;
end;

function u2.updateParent(p58) -- Line: 631
    -- upvalues: u2 (copy)
    local IconByUID = u2.getIconByUID(p58.parentIconUID);

    if IconByUID then
        IconByUID.updateSize:Fire();
    end;
end;

function u2.setBehaviour(p59, p60, p61, p62, p63) -- Line: 638
    p59.customBehaviours[p60 .. "-" .. p61] = p62;

    if p63 then
        local InstanceOrCollective = p59:getInstanceOrCollective(p60);

        for _, v in pairs(InstanceOrCollective) do
            p59:refreshAppearance(v, p61);
        end;
    end;
end;

function u2.modifyTheme(p64, p65, p66) -- Line: 651
    -- upvalues: Themes (copy)
    return p64, Themes.modify(p64, p65, p66);
end;

function u2.modifyChildTheme(p67, p68, p69) -- Line: 656
    -- upvalues: u2 (copy)
    p67.childModifications = p68;
    p67.childModificationsUID = p69;

    for i, _ in pairs(p67.childIconsDict) do
        u2.getIconByUID(i):modifyTheme(p68, p69);
    end;

    p67.childThemeModified:Fire();

    return p67;
end;

function u2.removeModification(p70, p71) -- Line: 669
    -- upvalues: Themes (copy)
    Themes.remove(p70, p71);

    return p70;
end;

function u2.removeModificationWith(p72, p73, p74, p75) -- Line: 674
    -- upvalues: Themes (copy)
    Themes.removeWith(p72, p73, p74, p75);

    return p72;
end;

function u2.setTheme(p76, p77) -- Line: 679
    -- upvalues: Themes (copy)
    Themes.set(p76, p77);

    return p76;
end;

function u2.setEnabled(p78, p79) -- Line: 684
    p78.isEnabled = p79;
    p78.widget.Visible = p79;
    p78:updateParent();

    return p78;
end;

function u2.select(p80, p81, p82) -- Line: 691
    p80:setState("Selected", p81, p82);

    return p80;
end;

function u2.deselect(p83, p84, p85) -- Line: 696
    p83:setState("Deselected", p84, p85);

    return p83;
end;

function u2.notify(p86, p87, p88) -- Line: 701
    -- upvalues: Elements (copy), u2 (copy)
    if not p86.notice then
        p86.notice = require(Elements.Notice)(p86, u2);
    end;

    p86.noticeStarted:Fire(p87, p88);

    return p86;
end;

function u2.clearNotices(p89) -- Line: 715
    p89.endNotices:Fire();

    return p89;
end;

function u2.disableOverlay(p90, p91) -- Line: 720
    p90.overlayDisabled = p91;

    return p90;
end;

u2.disableStateOverlay = u2.disableOverlay;

function u2.setImage(p92, p93, p94) -- Line: 726
    p92:modifyTheme({
        "IconImage",
        "Image",
        p93,
        p94
    });

    return p92;
end;

function u2.setLabel(p95, p96, p97) -- Line: 731
    p95:modifyTheme({
        "IconLabel",
        "Text",
        p96,
        p97
    });

    return p95;
end;

function u2.setOrder(p98, p99, p100) -- Line: 736
    p98:modifyTheme({
        "Widget",
        "LayoutOrder",
        p99,
        p100
    });

    return p98;
end;

function u2.setCornerRadius(p101, p102, p103) -- Line: 741
    p101:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p102,
        p103
    });

    return p101;
end;

function u2.align(p104, p105, p106) -- Line: 746
    -- upvalues: u2 (copy)
    local v107 = tostring(p105):lower();
    local v108 = (v107 == "mid" or v107 == "centre") and "center" or v107;
    local v109 = v108 ~= "left" and (v108 ~= "center" and v108 ~= "right") and "left" or v108;
    local v110 = v109 == "center" and u2.container.TopbarCentered or u2.container.TopbarStandard;
    local Holders = v110.Holders;
    local v111 = string.upper((string.sub(v109, 1, 1))) .. string.sub(v109, 2);

    if not p106 then
        p104.originalAlignment = v111;
    end;

    local joinedFrame = p104.joinedFrame;
    local v112 = Holders[v111];
    p104.screenGui = v110;
    p104.alignmentHolder = v112;

    if not p104.isDestroyed then
        p104.widget.Parent = joinedFrame or v112;
    end;

    p104.alignment = v111;
    p104.alignmentChanged:Fire(v111);
    u2.iconChanged:Fire(p104);

    return p104;
end;

u2.setAlignment = u2.align;

function u2.setLeft(p113) -- Line: 775
    p113:setAlignment("Left");

    return p113;
end;

function u2.setMid(p114) -- Line: 780
    p114:setAlignment("Center");

    return p114;
end;

function u2.setRight(p115) -- Line: 785
    p115:setAlignment("Right");

    return p115;
end;

function u2.setWidth(p116, p117, p118) -- Line: 790
    p116:modifyTheme({
        "Widget",
        "Size",
        UDim2.fromOffset(p117, p116.widget.Size.Y.Offset),
        p118
    });
    p116:modifyTheme({
        "Widget",
        "DesiredWidth",
        p117,
        p118
    });

    return p116;
end;

function u2.setImageScale(p119, p120, p121) -- Line: 800
    p119:modifyTheme({
        "IconImageScale",
        "Value",
        p120,
        p121
    });

    return p119;
end;

function u2.setImageRatio(p122, p123, p124) -- Line: 805
    p122:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p123,
        p124
    });

    return p122;
end;

function u2.setTextSize(p125, p126, p127) -- Line: 810
    p125:modifyTheme({
        "IconLabel",
        "TextSize",
        p126,
        p127
    });

    return p125;
end;

function u2.setTextFont(p128, p129, p130, p131, p132) -- Line: 815
    local v133 = p130 or Enum.FontWeight.Regular;
    local v134 = p131 or Enum.FontStyle.Normal;
    local v135 = nil;
    local v136 = typeof(p129);

    if v136 == "number" then
        v135 = Font.fromId(p129, v133, v134);
    elseif v136 == "EnumItem" then
        v135 = Font.fromEnum(p129);
    elseif v136 == "string" and not p129:match("rbxasset") then
        v135 = Font.fromName(p129, v133, v134);
    end;

    p128:modifyTheme({
        "IconLabel",
        "FontFace",
        v135 or Font.new(p129, v133, v134),
        p132
    });

    return p128;
end;

function u2.bindToggleItem(p137, p138) -- Line: 836
    if not (p138:IsA("GuiObject") or p138:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;

    p137.toggleItems[p138] = true;
    p137:_updateSelectionInstances();

    return p137;
end;

function u2.unbindToggleItem(p139, p140) -- Line: 845
    p139.toggleItems[p140] = nil;
    p139:_updateSelectionInstances();

    return p139;
end;

function u2._updateSelectionInstances(p141) -- Line: 851
    for i, _ in pairs(p141.toggleItems) do
        local v142 = {};

        for _, descendant in pairs(i:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(v142, descendant);
            end;
        end;

        p141.toggleItems[i] = v142;
    end;
end;

function u2._setToggleItemsVisible(p143, p144, p145, p146) -- Line: 865
    for i, _ in pairs(p143.toggleItems) do
        if not (p146 and (p146 ~= p143 and p146.toggleItems[i] ~= nil)) then
            i[i:IsA("LayerCollector") and "Enabled" or "Visible"] = p144;
        end;
    end;
end;

function u2.bindEvent(u147, p148, u149) -- Line: 877
    local v150 = u147[p148];
    local v151;

    if v150 then
        if typeof(v150) == "table" then
            v151 = v150.Connect;
        else
            v151 = false;
        end;
    else
        v151 = v150;
    end;

    assert(v151, "argument[1] must be a valid topbarplus icon event name!");
    local v152 = typeof(u149) == "function";
    assert(v152, "argument[2] must be a function!");
    u147.bindedEvents[p148] = v150:Connect(function(...) -- Line: 881
        -- upvalues: u149 (copy), u147 (copy)
        u149(u147, ...);
    end);

    return u147;
end;

function u2.unbindEvent(p153, p154) -- Line: 887
    local v155 = p153.bindedEvents[p154];

    if v155 then
        v155:Disconnect();
        p153.bindedEvents[p154] = nil;
    end;

    return p153;
end;

function u2.bindToggleKey(p156, p157) -- Line: 896
    local v158 = typeof(p157) == "EnumItem";
    assert(v158, "argument[1] must be a KeyCode EnumItem!");
    p156.bindedToggleKeys[p157] = true;
    p156.toggleKeyAdded:Fire(p157);
    p156:setCaption("_hotkey_");

    return p156;
end;

function u2.unbindToggleKey(p159, p160) -- Line: 904
    local v161 = typeof(p160) == "EnumItem";
    assert(v161, "argument[1] must be a KeyCode EnumItem!");
    p159.bindedToggleKeys[p160] = nil;

    return p159;
end;

function u2.call(u162, u163, ...) -- Line: 910
    local table_pack_ret = table.pack(...);
    task.spawn(function() -- Line: 912
        -- upvalues: u163 (copy), u162 (copy), table_pack_ret (copy)
        u163(u162, table.unpack(table_pack_ret));
    end);

    return u162;
end;

function u2.addToJanitor(p164, p165) -- Line: 918
    p164.janitor:add(p165);

    return p164;
end;

function u2.lock(p166) -- Line: 923
    p166:getInstance("ClickRegion").Visible = false;
    p166.locked = true;

    return p166;
end;

function u2.unlock(p167) -- Line: 931
    p167:getInstance("ClickRegion").Visible = true;
    p167.locked = false;

    return p167;
end;

function u2.debounce(p168, p169) -- Line: 938
    p168:lock();
    task.wait(p169);
    p168:unlock();

    return p168;
end;

function u2.autoDeselect(p170, p171) -- Line: 945
    p170.deselectWhenOtherIconSelected = p171 == nil and true or p171;

    return p170;
end;

function u2.oneClick(u172, p173) -- Line: 955
    local singleClickJanitor = u172.singleClickJanitor;
    singleClickJanitor:clean();

    if p173 or p173 == nil then
        singleClickJanitor:add(u172.selected:Connect(function() -- Line: 961
            -- upvalues: u172 (copy)
            u172:deselect("OneClick", u172);
        end));
    end;

    u172.oneClickEnabled = true;

    return u172;
end;

function u2.setCaption(p174, p175) -- Line: 969
    -- upvalues: Elements (copy)
    if p175 == "_hotkey_" and p174.captionText then
        return p174;
    end;

    local captionJanitor = p174.captionJanitor;
    p174.captionJanitor:clean();

    if not p175 or p175 == "" then
        p174.caption = nil;
        p174.captionText = nil;

        return p174;
    end;

    local v176 = captionJanitor:add(require(Elements.Caption)(p174));
    v176:SetAttribute("CaptionText", p175);
    p174.caption = v176;
    p174.captionText = p175;

    return p174;
end;

function u2.setCaptionHint(p177, p178) -- Line: 987
    local v179 = typeof(p178) == "EnumItem";
    assert(v179, "argument[1] must be a KeyCode EnumItem!");
    p177.fakeToggleKey = p178;
    p177.fakeToggleKeyChanged:Fire(p178);
    p177:setCaption("_hotkey_");

    return p177;
end;

function u2.leave(p180) -- Line: 995
    p180.joinJanitor:clean();

    return p180;
end;

function u2.joinMenu(p181, p182) -- Line: 1001
    -- upvalues: Utility (copy)
    Utility.joinFeature(p181, p182, p182.menuIcons, p182:getInstance("Menu"));
    p182.menuChildAdded:Fire(p181);

    return p181;
end;

function u2.setMenu(p183, p184) -- Line: 1007
    p183.menuSet:Fire(p184);

    return p183;
end;

function u2.setFrozenMenu(p185, p186) -- Line: 1012
    p185:freezeMenu(p186);
    p185:setMenu(p186);
end;

function u2.freezeMenu(u187) -- Line: 1017
    u187:select("FrozenMenu", u187);
    u187:bindEvent("deselected", function(p188) -- Line: 1021
        -- upvalues: u187 (copy)
        p188:select("FrozenMenu", u187);
    end);
    u187:modifyTheme({ "IconSpot", "Visible", false });
end;

function u2.joinDropdown(p189, p190) -- Line: 1027
    -- upvalues: Utility (copy)
    p190:getDropdown();
    Utility.joinFeature(p189, p190, p190.dropdownIcons, p190:getInstance("DropdownScroller"));
    p190.dropdownChildAdded:Fire(p189);

    return p189;
end;

function u2.getDropdown(p191) -- Line: 1034
    -- upvalues: Elements (copy)
    local dropdown = p191.dropdown;

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p191);
        p191.dropdown = dropdown;
        p191:clipOutside(dropdown);
    end;

    return dropdown;
end;

function u2.setDropdown(p192, p193) -- Line: 1044
    p192:getDropdown();
    p192.dropdownSet:Fire(p193);

    return p192;
end;

function u2.clipOutside(p194, p195) -- Line: 1050
    -- upvalues: Utility (copy)
    local v196 = Utility.clipOutside(p194, p195);
    p194:refreshAppearance(p195);

    return p194, v196;
end;

function u2.setIndicator(p197, p198) -- Line: 1061
    -- upvalues: Elements (copy), u2 (copy)
    if not p197.indicator then
        p197.indicator = p197.janitor:add(require(Elements.Indicator)(p197, u2));
    end;

    p197.indicatorSet:Fire(p198);
end;

function u2.destroy(p199) -- Line: 1076
    -- upvalues: u2 (copy)
    if p199.isDestroyed then
        return;
    end;

    p199:clearNotices();

    if p199.parentIconUID then
        p199:leave();
    end;

    p199.isDestroyed = true;
    p199.janitor:clean();
    u2.iconRemoved:Fire(p199);
end;

u2.Destroy = u2.destroy;

return u2;