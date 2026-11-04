 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Presentation = ChickenOrHero:WaitForChild("Presentation");
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local HudIcons = require(Presentation:WaitForChild("HudIcons"));
local ValleyHudView = require(Presentation:WaitForChild("ValleyHudView"));
local PrivateHostModel = require(Presentation:WaitForChild("PrivateHostModel"));
local v1;

if FFlags.awaitUIVersion() == "OldUIReskin" then
    v1 = ChickenOrHero:FindFirstChild("OldUIReskin");
else
    v1 = false;
end;

local u2 = v1 and require(v1:WaitForChild("Skin")) or nil;
local u3 = u2 and u2.Panels or require(Presentation:WaitForChild("ValleyPanels"));
local Color3_fromRGB_ret = Color3.fromRGB(65, 87, 68);
local Color3_fromRGB_ret2 = Color3.fromRGB(36, 56, 50);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 130, 136);

local function gold(p4) -- Line: 24
    -- upvalues: u3 (copy)
    local string_gsub_ret = string.gsub(p4, "[&<>\"\']", {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        ["\""] = "&quot;",
        ["\'"] = "&apos;"
    });

    return ("<font color=\"#%s\">%s</font>"):format(u3.Gold:ToHex(), string_gsub_ret);
end;

local u5 = u3.screen(LocalPlayer, "PrivateHost", 66);
u5.IgnoreGuiInset = true;
u5.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;

local function look(p6, p7, p8) -- Line: 41
    -- upvalues: u2 (copy)
    if u2 then
        u2.button(p6, p7);

        return;
    end;

    p6.BackgroundColor3 = p8;
end;

local v9 = {};
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = false;
local u17 = false;
local u18 = 0;

local function setOpen(p19) -- Line: 55
    -- upvalues: u16 (ref), HudNavigation (copy), u12 (ref), LocalPlayer (copy)
    if p19 == u16 then
        return;
    end;

    if p19 then
        HudNavigation.opening("HostPanel");
    end;

    u16 = p19;
    u12.Visible = p19;
    LocalPlayer:SetAttribute("HostPanelOpen", p19 or nil);
end;

local function placeLauncher() -- Line: 67
    -- upvalues: u10 (ref), u11 (ref)
    local Attribute = u10:GetAttribute("DrawerCenter");

    if type(Attribute) == "number" then
        u11.Position = UDim2.fromOffset(8, Attribute + (u10.Spectate.Visible and 178 or 128));
    end;
end;

local function showLauncher() -- Line: 77
    -- upvalues: LocalPlayer (copy), u11 (ref), u17 (ref), u16 (ref), u10 (ref)
    local v20 = LocalPlayer:GetAttribute("CreatorCameraActive") == true;
    u11.Visible = u17 and not u16 and (u10.AFKToggle.Visible or v20);
    u11.Active = u11.Visible;
    u11.Selectable = u11.Visible;
    local Attribute = u10:GetAttribute("DrawerCenter");

    if type(Attribute) == "number" then
        u11.Position = UDim2.fromOffset(8, Attribute + (u10.Spectate.Visible and 178 or 128));
    end;
end;

function v9.buildHost(p21) -- Line: 85
    -- upvalues: u10 (ref), LocalPlayer (copy), u11 (ref), ValleyHudView (copy), HudIcons (copy), u2 (copy), u5 (copy), placeLauncher (copy), showLauncher (copy), u12 (ref), u13 (ref), u3 (copy), u15 (ref), u14 (ref), u16 (ref), HudNavigation (copy), UserInputService (copy)
    u10 = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ValleyHUD");
    local AFKToggle = u10:WaitForChild("AFKToggle");
    u11 = AFKToggle:Clone();
    u11.Name = "HostButton";

    for _, child in u11:GetChildren() do
        if child.Name == "Icon" or (child.Name == "StateDot" or string.match(child.Name, "^SkinIcon")) then
            child:Destroy();
        end;
    end;

    if ValleyHudView.awayLook then
        ValleyHudView.awayLook(u11, false);
    else
        u11.BackgroundColor3 = ValleyHudView.Ink;
    end;

    u11.Caption.TextColor3 = ValleyHudView.Paper;
    local v22 = HudIcons.draw(u11, "Settings", ValleyHudView.Paper);
    v22.Size = UDim2.fromOffset(22, 22);
    v22.Position = UDim2.fromOffset(11, 4);

    if u2 then
        u2.icon(v22, "gear");
    end;

    u11.Caption.Text = "HOST";
    u11.Visible = false;
    u11.Parent = u5;
    u11.Activated:Connect(p21);
    local Attribute = u10:GetAttribute("DrawerCenter");

    if type(Attribute) == "number" then
        u11.Position = UDim2.fromOffset(8, Attribute + (u10.Spectate.Visible and 178 or 128));
    end;

    u10:GetAttributeChangedSignal("DrawerCenter"):Connect(placeLauncher);
    AFKToggle:GetPropertyChangedSignal("Visible"):Connect(showLauncher);
    u10:WaitForChild("Spectate"):GetPropertyChangedSignal("Visible"):Connect(placeLauncher);
    local v23, v24, v25 = u3.panel(u5, "HostPanel", 470, 580);
    u12 = v23;
    u13 = v24;
    local v26 = u3.text(u13, "Title", "HOST", 24, 20, 300, 34, 22, u3.Gold);
    v26.Font = Enum.Font.GothamBold;
    u15 = u3.text(u13, "Status", "Your private server, your rules.", 24, 56, 422, 22, 13, u3.Muted);

    if u2 then
        u2.text(v26, "gold", {
            stroke = 1
        });
        u2.text(u15, "secondary", {
            stroke = 1
        });
    end;

    u14 = u3.make("ScrollingFrame", u13, "Rows", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        Position = UDim2.fromOffset(24, 88),
        Size = UDim2.fromOffset(422, 468),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y
    });

    if u2 then
        u2.scroll(u14);
    end;

    u3.make("UIListLayout", u14, "List", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    });
    v25.Activated:Connect(function() -- Line: 141
        -- upvalues: u16 (ref), u12 (ref), LocalPlayer (ref)
        if u16 == false then
            return;
        end;

        u16 = false;
        u12.Visible = false;
        LocalPlayer:SetAttribute("HostPanelOpen", nil);
    end);
    HudNavigation.register("HostPanel", function() -- Line: 144
        -- upvalues: u16 (ref), HudNavigation (ref), u12 (ref), LocalPlayer (ref)
        local v27 = not u16;

        if v27 == u16 then
            return;
        end;

        if v27 then
            HudNavigation.opening("HostPanel");
        end;

        u16 = v27;
        u12.Visible = v27;
        LocalPlayer:SetAttribute("HostPanelOpen", v27 or nil);
    end);
    HudNavigation.setAvailable("HostPanel", true);
    HudNavigation.Opening.Event:Connect(function(p28) -- Line: 148
        -- upvalues: u16 (ref), u12 (ref), LocalPlayer (ref)
        if p28 ~= "HostPanel" then
            if u16 == false then
                return;
            end;

            u16 = false;
            u12.Visible = false;
            LocalPlayer:SetAttribute("HostPanelOpen", nil);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p29) -- Line: 153
        -- upvalues: u16 (ref), u12 (ref), LocalPlayer (ref)
        if u16 and p29.KeyCode == Enum.KeyCode.Escape then
            if u16 == false then
                return;
            end;

            u16 = false;
            u12.Visible = false;
            LocalPlayer:SetAttribute("HostPanelOpen", nil);
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("HostPanelOpen"):Connect(showLauncher);
    LocalPlayer:GetAttributeChangedSignal("CreatorCameraActive"):Connect(showLauncher);
end;

function v9.setLauncherVisible(p30) -- Line: 162
    -- upvalues: u17 (ref), u16 (ref), u12 (ref), LocalPlayer (copy), u11 (ref), u10 (ref)
    u17 = p30;

    if not p30 and u16 ~= false then
        u16 = false;
        u12.Visible = false;
        LocalPlayer:SetAttribute("HostPanelOpen", nil);
    end;

    local v31 = LocalPlayer:GetAttribute("CreatorCameraActive") == true;
    u11.Visible = u17 and not u16 and (u10.AFKToggle.Visible or v31);
    u11.Active = u11.Visible;
    u11.Selectable = u11.Visible;
    local Attribute = u10:GetAttribute("DrawerCenter");

    if type(Attribute) == "number" then
        u11.Position = UDim2.fromOffset(8, Attribute + (u10.Spectate.Visible and 178 or 128));
    end;
end;

function v9.open() -- Line: 170
    -- upvalues: u16 (ref), HudNavigation (copy), u12 (ref), LocalPlayer (copy)
    if u16 == true then
        return;
    end;

    HudNavigation.opening("HostPanel");
    u16 = true;
    u12.Visible = true;
    LocalPlayer:SetAttribute("HostPanelOpen", true);
end;

function v9.close() -- Line: 173
    -- upvalues: u16 (ref), u12 (ref), LocalPlayer (copy)
    if u16 == false then
        return;
    end;

    u16 = false;
    u12.Visible = false;
    LocalPlayer:SetAttribute("HostPanelOpen", nil);
end;

function v9.isOpen() -- Line: 176
    -- upvalues: u16 (ref)
    return u16;
end;

local function row(p32) -- Line: 180
    -- upvalues: u18 (ref), u3 (copy), u14 (ref)
    u18 = u18 + 1;

    return u3.make("Frame", u14, "Row" .. u18, {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -8, 0, p32 or 44),
        LayoutOrder = u18
    });
end;

local function rowLabel(p33, p34) -- Line: 190
    -- upvalues: u3 (copy), u2 (copy)
    local v35 = u3.text(p33, "Label", p34, 0, 5, 290, 34, 15, u3.Paper);

    if u2 then
        u2.text(v35, "primary", {
            stroke = 1
        });
    end;

    return v35;
end;

local function rowButton(p36, p37, p38, p39) -- Line: 198
    -- upvalues: u3 (copy), u2 (copy)
    local v40 = u3.button(p36, "Button", p37, 316, 3, 98, 38, p39);

    if u2 then
        u2.button(v40, p38);

        return v40;
    end;

    v40.BackgroundColor3 = p39;

    return v40;
end;

function v9.section(p41) -- Line: 204
    -- upvalues: row (copy), u3 (copy), u2 (copy)
    local v42 = row(28);
    local v43 = u3.text(v42, "Label", string.upper(p41), 0, 6, 410, 22, 13, u3.Gold);
    v43.Font = Enum.Font.GothamBold;

    if u2 then
        u2.text(v43, "gold", {
            stroke = 1
        });
    end;
end;

function v9.note(p44) -- Line: 213
    -- upvalues: row (copy), u3 (copy), u2 (copy)
    local u45 = row(26);
    local u46 = u3.text(u45, "Label", p44, 0, 2, 410, 22, 12, u3.Muted);
    u46.FontFace = Font.new(u46.FontFace.Family, Enum.FontWeight.Regular, Enum.FontStyle.Italic);

    if u2 then
        u2.text(u46, "muted", {
            stroke = 1
        });
    end;

    u45.Visible = p44 ~= "";

    return {
        set = function(p47) -- Line: 222, Name: set
            -- upvalues: u46 (copy), u45 (copy)
            u46.Text = p47;
            u45.Visible = p47 ~= "";
        end
    };
end;

function v9.picker(u48, p49) -- Line: 229
    -- upvalues: row (copy), rowLabel (copy), Color3_fromRGB_ret2 (copy), u3 (copy), u2 (copy), gold (copy)
    local v50 = row();
    local u51 = rowLabel(v50, u48);
    local v52 = Color3_fromRGB_ret2;
    local u53 = u3.button(v50, "Button", "NEXT", 316, 3, 98, 38, v52);

    if u2 then
        u2.button(u53, "secondary");
    else
        u53.BackgroundColor3 = v52;
    end;

    u53.Activated:Connect(p49);
    u51.RichText = true;

    return {
        set = function(p54, p55) -- Line: 237, Name: set
            -- upvalues: u51 (copy), u48 (copy), gold (ref), u53 (copy)
            u51.Text = u48 .. "  ·  " .. gold(p54);
            u53.Active = p55 ~= false;
            u53.AutoButtonColor = p55 ~= false;
            u53.TextTransparency = p55 == false and 0.5 or 0;
        end
    };
end;

function v9.stepper(u56, u57) -- Line: 247
    -- upvalues: row (copy), rowLabel (copy), u3 (copy), Color3_fromRGB_ret2 (copy), u2 (copy), gold (copy)
    local v58 = row();
    local u59 = rowLabel(v58, u56);
    u59.RichText = true;
    local u60 = {};

    for i, v in { -1, 1 } do
        local v61 = u3.button(v58, v < 0 and "Minus" or "Plus", v < 0 and "-" or "+", 316 + (i - 1) * 52, 3, 46, 38, Color3_fromRGB_ret2);
        local v62 = Color3_fromRGB_ret2;

        if u2 then
            u2.button(v61, "secondary");
        else
            v61.BackgroundColor3 = v62;
        end;

        v61.TextSize = 20;
        v61.Activated:Connect(function() -- Line: 256
            -- upvalues: u57 (copy), v (copy)
            u57(v);
        end);
        u60[i] = v61;
    end;

    return {
        set = function(p63, p64) -- Line: 262, Name: set
            -- upvalues: u59 (copy), u56 (copy), gold (ref), u60 (copy)
            u59.Text = u56 .. "  ·  " .. gold(p63);

            for _, v in u60 do
                v.Active = p64 ~= false;
                v.AutoButtonColor = p64 ~= false;
                v.TextTransparency = p64 == false and 0.5 or 0;
            end;
        end
    };
end;

function v9.toggle(p65, p66) -- Line: 273
    -- upvalues: row (copy), rowLabel (copy), Color3_fromRGB_ret2 (copy), u3 (copy), u2 (copy), Color3_fromRGB_ret (copy)
    local v67 = row();
    rowLabel(v67, p65);
    local v68 = Color3_fromRGB_ret2;
    local u69 = u3.button(v67, "Button", "OFF", 316, 3, 98, 38, v68);

    if u2 then
        u2.button(u69, "danger");
    else
        u69.BackgroundColor3 = v68;
    end;

    u69.Activated:Connect(p66);

    return {
        set = function(p70, p71) -- Line: 279, Name: set
            -- upvalues: u69 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), u2 (ref)
            local v72 = p70 == true;
            u69.Text = v72 and "ON" or "OFF";
            local v73 = u69;
            local v74 = v72 and "primary" or "danger";
            local v75 = v72 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

            if u2 then
                u2.button(v73, v74);
            else
                v73.BackgroundColor3 = v75;
            end;

            u69.Active = p71 ~= false;
            u69.TextTransparency = p71 == false and 0.5 or 0;
        end
    };
end;

function v9.action(p76, p77, p78, p79) -- Line: 289
    -- upvalues: row (copy), rowLabel (copy), Color3_fromRGB_ret2 (copy), u3 (copy), u2 (copy), Color3_fromRGB_ret3 (copy)
    local v80 = row();
    rowLabel(v80, p76);
    local v81 = p79 and "danger" or "secondary";
    local v82 = Color3_fromRGB_ret2;
    local u83 = u3.button(v80, "Button", p77, 316, 3, 98, 38, v82);

    if u2 then
        u2.button(u83, v81);
    else
        u83.BackgroundColor3 = v82;
    end;

    if p79 and not u2 then
        u83.TextColor3 = Color3_fromRGB_ret3;
    end;

    u83.Activated:Connect(p78);

    return {
        set = function(p84, p85) -- Line: 298, Name: set
            -- upvalues: u83 (copy)
            u83.Text = p84;
            u83.Active = p85 ~= false;
            u83.TextTransparency = p85 == false and 0.5 or 0;
        end
    };
end;

function v9.input(p86, p87, u88) -- Line: 306
    -- upvalues: row (copy), u3 (copy), u2 (copy), Color3_fromRGB_ret (copy)
    local v89 = row();
    local u90 = u3.make("TextBox", v89, "Input", {
        BorderSizePixel = 0,
        Text = "",
        TextSize = 15,
        ClearTextOnFocus = false,
        Position = UDim2.fromOffset(0, 3),
        Size = UDim2.fromOffset(300, 38),
        BackgroundColor3 = Color3.fromRGB(36, 56, 70),
        PlaceholderText = p86,
        PlaceholderColor3 = u3.Muted,
        TextColor3 = u3.Paper,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    });
    u3.corner(u90, 8);
    u3.make("UIPadding", u90, "Padding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    });

    if u2 then
        u2.input(u90);
    end;

    local v91 = Color3_fromRGB_ret;
    local v92 = u3.button(v89, "Button", p87, 316, 3, 98, 38, v91);

    if u2 then
        u2.button(v92, "primary");
    else
        v92.BackgroundColor3 = v91;
    end;

    v92.Activated:Connect(function() -- Line: 328, Name: submit
        -- upvalues: u88 (copy), u90 (copy)
        u88(u90.Text);
    end);
    u90.FocusLost:Connect(function(p93) -- Line: 332
        -- upvalues: u88 (copy), u90 (copy)
        if p93 then
            u88(u90.Text);
        end;
    end);

    return {
        clear = function() -- Line: 338, Name: clear
            -- upvalues: u90 (copy)
            u90.Text = "";
        end
    };
end;

function v9.status(p94) -- Line: 344
    -- upvalues: u15 (ref)
    if u15 then
        u15.Text = p94;
    end;
end;

local u95 = nil;
local u96 = nil;
local u97 = nil;

local function answerWith(p98) -- Line: 352
    -- upvalues: u97 (ref), u95 (ref), LocalPlayer (copy)
    local v99 = u97;
    u97 = nil;

    if u95 then
        u95.Visible = false;
    end;

    LocalPlayer:SetAttribute("PrivateInviteOpen", nil);

    if v99 and p98 then
        v99[p98]();
    end;
end;

function v9.invite(p100, p101, p102) -- Line: 364
    -- upvalues: u95 (ref), u3 (copy), u5 (copy), u96 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u2 (copy), u97 (ref), LocalPlayer (copy)
    if not u95 then
        local v103, v104, v105 = u3.panel(u5, "PrivateInvite", 420, 236);
        u95 = v103;
        local v106 = u3.text(v104, "Title", "INVITE", 24, 20, 300, 34, 22, u3.Gold);
        v106.Font = Enum.Font.GothamBold;
        u96 = u3.text(v104, "Name", "", 24, 66, 372, 30, 20, u3.Paper);
        u96.Font = Enum.Font.GothamBold;
        local v107 = u3.text(v104, "Line", "invited you to their private server. Join them?", 24, 98, 372, 44, 15, u3.Muted);
        local v108 = u3.button(v104, "Join", "JOIN", 24, 160, 176, 46, Color3_fromRGB_ret);
        local v109 = u3.button(v104, "Decline", "DECLINE", 220, 160, 176, 46, Color3_fromRGB_ret2);
        local v110 = Color3_fromRGB_ret;

        if u2 then
            u2.button(v108, "primary");
        else
            v108.BackgroundColor3 = v110;
        end;

        local v111 = Color3_fromRGB_ret2;

        if u2 then
            u2.button(v109, "danger");
        else
            v109.BackgroundColor3 = v111;
        end;

        if u2 then
            u2.text(v106, "gold", {
                stroke = 1
            });
            u2.text(u96, "primary", {
                stroke = 1
            });
            u2.text(v107, "secondary", {
                stroke = 1
            });
        end;

        v108.Activated:Connect(function() -- Line: 382
            -- upvalues: u97 (ref), u95 (ref), LocalPlayer (ref)
            local v112 = u97;
            u97 = nil;

            if u95 then
                u95.Visible = false;
            end;

            LocalPlayer:SetAttribute("PrivateInviteOpen", nil);

            if v112 then
                v112.accept();
            end;
        end);
        v109.Activated:Connect(function() -- Line: 385
            -- upvalues: u97 (ref), u95 (ref), LocalPlayer (ref)
            local v113 = u97;
            u97 = nil;

            if u95 then
                u95.Visible = false;
            end;

            LocalPlayer:SetAttribute("PrivateInviteOpen", nil);

            if v113 then
                v113.decline();
            end;
        end);
        v105.Activated:Connect(function() -- Line: 388
            -- upvalues: u97 (ref), u95 (ref), LocalPlayer (ref)
            local v114 = u97;
            u97 = nil;

            if u95 then
                u95.Visible = false;
            end;

            LocalPlayer:SetAttribute("PrivateInviteOpen", nil);

            if v114 then
                v114.decline();
            end;
        end);
    end;

    u96.Text = p100.fromName;
    u97 = {
        accept = p101,
        decline = p102
    };
    u95.Visible = true;
    LocalPlayer:SetAttribute("PrivateInviteOpen", true);
end;

function v9.closeInvite() -- Line: 398
    -- upvalues: u97 (ref), u95 (ref), LocalPlayer (copy)
    u97 = nil;

    if u95 then
        u95.Visible = false;
    end;

    LocalPlayer:SetAttribute("PrivateInviteOpen", nil);
end;

PrivateHostModel.run(v9);