 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local ParticipantDirectory = require(script.Parent.ParticipantDirectory);
local VerifiedName = require(script.Parent.VerifiedName);
local ChoiceView = require(script.Parent.ChoiceView);
local Color3_new_ret = Color3.new(1, 1, 1);
local u1 = {};
u1.__index = u1;

function u1.new(u2, p3, p4) -- Line: 12
    -- upvalues: ChoiceView (copy), Players (copy), u1 (copy), UserInputService (copy), GuiService (copy)
    ChoiceView.apply(u2);
    local u5 = setmetatable({
        key = nil,
        pendingUntil = 0,
        mode = "",
        gui = u2,
        player = Players.LocalPlayer,
        session = p3,
        action = p4,
        panel = u2.MainFrame.Choices,
        template = u2.Templates.ChoiceOption,
        buttons = {},
        callbacks = {},
        connections = {},
        lifetime = {}
    }, u1);
    table.insert(u5.lifetime, u5.panel.Random.Activated:Connect(function() -- Line: 16
        -- upvalues: u5 (copy)
        u5:roll();
    end));
    local lifetime = u5.lifetime;
    local PropertyChangedSignal = UserInputService:GetPropertyChangedSignal("PreferredInput");
    table.insert(lifetime, PropertyChangedSignal:Connect(function() -- Line: 17
        -- upvalues: u5 (copy), UserInputService (ref), GuiService (ref)
        if u5.panel.Visible and UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
            for _, v in u5.buttons do
                if v.Visible then
                    GuiService.SelectedObject = v;

                    return;
                end;
            end;
        end;
    end));
    table.insert(u5.lifetime, UserInputService.InputChanged:Connect(function(p6) -- Line: 22
        -- upvalues: u5 (copy)
        local press = u5.press;

        if not press then
            return;
        end;

        if (p6 == press.input or p6.UserInputType == Enum.UserInputType.MouseMovement and press.input.UserInputType == Enum.UserInputType.MouseButton1) and (Vector2.new(p6.Position.X, p6.Position.Y) - press.position).Magnitude > 10 then
            press.dragged = true;
        end;
    end));
    local lifetime2 = u5.lifetime;
    local PropertyChangedSignal2 = u5.panel.Search:GetPropertyChangedSignal("Text");
    table.insert(lifetime2, PropertyChangedSignal2:Connect(function() -- Line: 28
        -- upvalues: u5 (copy)
        u5:filter(true);
    end));
    table.insert(u5.lifetime, u5.panel.Reveal.Changed:Connect(function() -- Line: 29
        -- upvalues: ChoiceView (ref), u2 (copy), u5 (copy)
        ChoiceView.layout(u2, u5.mode);
    end));

    return u5;
end;

function u1.clear(p7) -- Line: 32
    -- upvalues: GuiService (copy)
    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(p7.panel) then
        GuiService.SelectedObject = nil;
    end;

    for _, v in p7.connections do
        v:Disconnect();
    end;

    table.clear(p7.connections);

    for _, child in p7.panel.PlayerPicker.Options:GetChildren() do
        if child:IsA("GuiButton") then
            child:Destroy();
        end;
    end;

    table.clear(p7.buttons);
    table.clear(p7.callbacks);
    p7.press = nil;
    p7.sent = nil;
end;

function u1.filter(p8, p9) -- Line: 38
    -- upvalues: GuiService (copy), UserInputService (copy)
    if p8.mode ~= "select" then
        return;
    end;

    local v10 = p8.panel.Search.Text:lower():gsub("^%s+", ""):gsub("%s+$", "");
    local v11 = {};

    for _, v in p8.buttons do
        local v12 = v10 == "" and true or (v:GetAttribute("SearchText") or ""):find(v10, 1, true) ~= nil;
        v.Visible = v12;

        if v12 then
            table.insert(v11, v);
        end;
    end;

    local Options = p8.panel.PlayerPicker.Options;

    if p9 then
        Options.CanvasPosition = Vector2.zero;
        p8.press = nil;
    end;

    p8.panel.PlayerPicker.Empty.Visible = #v11 == 0;
    p8.panel.Count.Text = (#v11 == #p8.buttons and ("%d runners"):format(#v11) or ("%d of %d runners"):format(#v11, #p8.buttons)) .. " · Scroll to browse";
    local v13 = p8.panel:GetAttribute("PickerColumns") or 2;

    for i, v in v11 do
        v.NextSelectionUp = v11[math.max(1, i - v13)];
        v.NextSelectionDown = v11[math.min(#v11, i + v13)];
        v.NextSelectionLeft = v11[math.max(1, i - 1)];
        v.NextSelectionRight = v11[math.min(#v11, i + 1)];
    end;

    if GuiService.SelectedObject and (GuiService.SelectedObject:IsDescendantOf(Options) and not GuiService.SelectedObject.Visible) then
        GuiService.SelectedObject = UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and v11[1] or nil;
    end;
end;

function u1.choose(p14, p15) -- Line: 62
    -- upvalues: ChoiceView (copy)
    if not p14.panel.Visible or os.clock() < p14.pendingUntil then
        return;
    end;

    p14.pendingUntil = os.clock() + 0.8;

    if p14.sent and (p14.sent.Parent and p14.mode == "select") then
        ChoiceView.selected(p14.sent, false);
    end;

    p14.sent = p15;

    if p14.mode == "select" then
        ChoiceView.selected(p15, true);
    end;

    p14.panel.Status.Text = "Choice sent…";
    p14.panel.Search:ReleaseFocus();
    local v16 = p14.callbacks[p15];

    if v16 then
        v16();
    end;
end;

function u1.roll(u17) -- Line: 72
    if u17.mode ~= "select" or (#u17.buttons == 0 or os.clock() < u17.pendingUntil) then
        return;
    end;

    local u18 = u17.buttons[math.random(1, #u17.buttons)];

    if not u18.Visible then
        u17.panel.Search.Text = "";
        u17:filter(false);
    end;

    u17:choose(u18);
    task.delay(0.1, function() -- Line: 77
        -- upvalues: u18 (copy), u17 (copy)
        if u18.Parent and u18.Visible then
            local Options = u17.panel.PlayerPicker.Options;
            Options.CanvasPosition = Vector2.new(0, (math.max(0, u18.AbsolutePosition.Y - Options.AbsolutePosition.Y + Options.CanvasPosition.Y - Options.AbsoluteSize.Y * 0.35)));
        end;
    end);
end;

function u1.bind(u19, u20, p21) -- Line: 85
    -- upvalues: TweenService (copy), Color3_new_ret (copy)
    table.insert(u19.buttons, u20);
    u19.callbacks[u20] = p21;
    local BackgroundColor3 = u20.BackgroundColor3;
    local Color = u20.Border.Color;

    local function hover(p22) -- Line: 89
        -- upvalues: u19 (copy), u20 (copy), TweenService (ref), BackgroundColor3 (copy), Color3_new_ret (ref), Color (copy)
        if u19.sent == u20 then
            return;
        end;

        TweenService:Create(u20, TweenInfo.new(0.12), {
            BackgroundColor3 = p22 and BackgroundColor3:Lerp(Color3.new(1, 1, 1), 0.07) or BackgroundColor3
        }):Play();
        u20.Border.Color = p22 and Color3_new_ret or Color;
        u20.Border.Transparency = 0;
    end;

    for _, v in { u20.MouseEnter, u20.SelectionGained } do
        table.insert(u19.connections, v:Connect(function() -- Line: 94
            -- upvalues: hover (copy)
            hover(true);
        end));
    end;

    for _, v in { u20.MouseLeave, u20.SelectionLost } do
        table.insert(u19.connections, v:Connect(function() -- Line: 95
            -- upvalues: u19 (copy), u20 (copy), TweenService (ref), BackgroundColor3 (copy), Color (copy)
            if u19.sent == u20 then
                return;
            end;

            TweenService:Create(u20, TweenInfo.new(0.12), {
                BackgroundColor3 = BackgroundColor3
            }):Play();
            u20.Border.Color = Color;
            u20.Border.Transparency = 0;
        end));
    end;

    table.insert(u19.connections, u20.InputBegan:Connect(function(p23) -- Line: 96
        -- upvalues: u19 (copy), u20 (copy)
        if p23.UserInputType == Enum.UserInputType.Touch or p23.UserInputType == Enum.UserInputType.MouseButton1 then
            u19.press = {
                dragged = false,
                input = p23,
                button = u20,
                position = Vector2.new(p23.Position.X, p23.Position.Y),
                canvas = u19.panel.PlayerPicker.Options.CanvasPosition.Y
            };
        end;
    end));
    table.insert(u19.connections, u20.Activated:Connect(function(p24) -- Line: 102
        -- upvalues: u19 (copy), u20 (copy)
        if not (u19.panel.Visible and (u20.Visible and os.clock() >= u19.pendingUntil)) then
            return;
        end;

        local press = u19.press;

        if p24 and (p24.UserInputType == Enum.UserInputType.Touch or p24.UserInputType == Enum.UserInputType.MouseButton1) and (press and (press.button == u20 and (press.dragged or math.abs(u19.panel.PlayerPicker.Options.CanvasPosition.Y - press.canvas) > 6))) then
            return;
        end;

        u19:choose(u20);
    end));
end;

function u1.update(u25, p26) -- Line: 110
    -- upvalues: ParticipantDirectory (copy), ChoiceView (copy), VerifiedName (copy), UserInputService (copy), GuiService (copy), TweenService (copy)
    local session = u25.session;
    local player = u25.player;
    local panel = u25.panel;
    local v27 = p26 == "SelectHero" and session:GetAttribute("LeadUserId") == player.UserId and "select" or (p26 == "HeroChoice" and session:GetAttribute("SelectedUserId") == player.UserId and "choice" or "");
    u25.gui.DisplayOrder = v27 == "" and 10 or 78;
    player:SetAttribute("ReleaseCameraForUI", v27 ~= "" and true or nil);
    local v28 = {};

    if v27 == "select" then
        for _, v in ParticipantDirectory.list() do
            if v ~= player and v:GetAttribute("GameRole") == "Runner" then
                table.insert(v28, v);
            end;
        end;
    end;

    table.sort(v28, function(p29, p30) -- Line: 121
        local v31 = p29.DisplayName:lower();
        local v32 = p30.DisplayName:lower();

        if v31 == v32 then
            return p29.UserId < p30.UserId;
        end;

        return v31 < v32;
    end);
    local v33 = {};

    for _, v in v28 do
        local v34 = tostring(v.UserId) .. ":" .. v.DisplayName;
        table.insert(v33, v34);
    end;

    local v35 = v27 .. ":" .. table.concat(v33, ",") .. ":" .. tostring(session:GetAttribute("RunNumber")) .. ":" .. tostring(session:GetAttribute("LeadUserId"));

    if u25.key ~= v35 then
        local v36 = u25.mode ~= v27;
        u25:clear();
        u25.key = v35;
        u25.mode = v27;
        u25.pendingUntil = 0;
        panel.PlayerPicker.Visible = v27 == "select";
        panel.RunnerChoice.Visible = v27 == "choice";
        panel.Visible = v27 ~= "";
        panel:SetAttribute("Mode", v27);

        if v36 then
            panel.Search:ReleaseFocus();
            panel.Search.Text = "";
        end;

        ChoiceView.layout(u25.gui, v27);

        if v27 == "select" then
            panel.Title.Text = "Choose a runner";
            panel.Hint.Text = "Who will face Chicken or Hero? Tap their card.";
            local Options = panel.PlayerPicker.Options;

            if v36 then
                Options.CanvasPosition = Vector2.zero;
            end;

            for i, v in v28 do
                local v37 = u25.template:Clone();
                v37.Name = "Player_" .. v.UserId;
                v37.LayoutOrder = i;
                v37.Visible = true;
                local v38;

                if type(v) == "table" then
                    v38 = v.IsBot;
                else
                    v38 = false;
                end;

                v37.Title.RichText = true;
                v37.Title.Text = VerifiedName.player(v);
                v37.Description.Text = v38 and "" or "@" .. v.Name;
                v37.Description.Visible = not v38;
                v37:SetAttribute("SearchText", (v.DisplayName .. " " .. v.Name):lower());
                local v39;

                if v38 then
                    v39 = v:GetAttribute("AvatarUserId") or 0;
                else
                    v39 = v.UserId;
                end;

                v37.Avatar.Image = v39 > 0 and (("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(v39) or "") or "";
                v37.Avatar.Fallback.Visible = v39 <= 0;
                v37.Avatar.Fallback.Text = v.DisplayName:sub(1, 1):upper();
                v37.Parent = Options;
                u25:bind(v37, function() -- Line: 147
                    -- upvalues: u25 (copy), v (copy)
                    u25.action:FireServer("SelectHero", v.UserId);
                end);
            end;

            u25:filter(false);
        elseif v27 == "choice" then
            panel.Title.Text = "Chicken or Hero?";
            local v40 = nil;

            for _, v in ParticipantDirectory.list() do
                if v.UserId == session:GetAttribute("LeadUserId") then
                    v40 = v;
                    break;
                end;
            end;

            panel.Hint.RichText = true;
            panel.Hint.Text = (v40 and VerifiedName.player(v40) or "The Chaser") .. " challenged you. Choose your crossing.";

            for _, v in { "Chicken", "Hero" } do
                u25:bind(panel.RunnerChoice.Options[v], function() -- Line: 155
                    -- upvalues: u25 (copy), v (copy)
                    u25.action:FireServer("HeroChoice", v);
                end);
            end;

            u25.buttons[1].NextSelectionRight = u25.buttons[2];
            u25.buttons[1].NextSelectionDown = u25.buttons[2];
            u25.buttons[2].NextSelectionLeft = u25.buttons[1];
            u25.buttons[2].NextSelectionUp = u25.buttons[1];
        end;

        if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
            for _, v in u25.buttons do
                if v.Visible then
                    GuiService.SelectedObject = v;
                    break;
                end;
            end;
        end;

        if panel.Visible and v36 then
            panel.Reveal.Value = 0.98;
            TweenService:Create(panel.Reveal, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end;
    end;

    if v27 ~= "" then
        ChoiceView.layout(u25.gui, v27);

        if u25.columns ~= panel:GetAttribute("PickerColumns") then
            u25.columns = panel:GetAttribute("PickerColumns");
            u25:filter(false);
        end;

        if os.clock() >= u25.pendingUntil then
            if u25.sent and (u25.sent.Parent and v27 == "select") then
                ChoiceView.selected(u25.sent, false);
                u25.sent = nil;
            end;

            local v41 = (session:GetAttribute("EndsAt") or 0) - workspace:GetServerTimeNow();
            local math_ceil_ret = math.ceil(v41);
            local math_max_ret = math.max(0, math_ceil_ret);
            panel.Status.Text = v27 == "select" and #v28 == 0 and "Waiting for runners…" or ("%ds remaining"):format(math_max_ret);
        end;
    end;
end;

function u1.destroy(p42) -- Line: 176
    p42:clear();

    for _, v in p42.lifetime do
        v:Disconnect();
    end;

    p42.gui.DisplayOrder = 10;
    p42.panel.Search:ReleaseFocus();
    p42.panel.Visible = false;
    p42.player:SetAttribute("ReleaseCameraForUI", nil);
end;

return u1;