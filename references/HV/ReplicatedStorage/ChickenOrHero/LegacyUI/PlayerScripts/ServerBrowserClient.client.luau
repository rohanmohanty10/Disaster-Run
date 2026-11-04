 

 

local HudNavigation = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ServerBrowser = PlayerGui:WaitForChild("ServerBrowser");
local ServerBrowserShade = PlayerGui:WaitForChild("ServerBrowserShade");
local Panel = ServerBrowser.Panel;
local ServerBrowserView = require(game.ReplicatedStorage.ChickenOrHero.Presentation:WaitForChild("ServerBrowserView"));
ServerBrowserView.apply(ServerBrowser);
local u1 = ServerBrowser:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 17
    -- upvalues: ServerBrowserView (copy), ServerBrowser (copy)
    ServerBrowserView.layout(ServerBrowser);
end);
ServerBrowserView.layout(ServerBrowser);
ServerBrowser.Open.Text = UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled and "SERVERS · B" or "SERVERS";
local ServerBrowserEvent = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ServerBrowserEvent");
local u2 = false;
local u3 = false;
local u4 = false;
local u5 = (-1 / 0);
local u6 = 0;
local u7 = {};
local u8 = {};
local u9 = true;
local u10 = nil;
local u11 = false;
local u12 = "ALL";
local u13 = 1;
local u14 = 1;
local u15 = {};
local u16 = nil;
local u17 = {
    rows = {}
};

local function ping() -- Line: 41
    -- upvalues: LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 42
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetNetworkPing() * 1000;
    end);

    return success and (result == result and (result > 0 and math.floor(result + 0.5))) or nil;
end;

local function updatePing() -- Line: 47
    -- upvalues: u9 (ref), u2 (ref), ServerBrowser (copy), Panel (copy), LocalPlayer (copy), u16 (ref)
    if not (u9 and (u2 and (ServerBrowser.Enabled and Panel.Visible))) then
        return;
    end;

    local success, result = pcall(function() -- Line: 42
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetNetworkPing() * 1000;
    end);
    local v18 = success and (result == result and (result > 0 and math.floor(result + 0.5))) or nil;
    Panel.Connection.Text = v18 and ("YOUR CONNECTION  ·  " .. v18 .. " ms" or "YOUR CONNECTION  ·  measuring…") or "YOUR CONNECTION  ·  measuring…";

    if u16 and u16.Parent then
        u16.Ping.Text = v18 and v18 .. " ms · you" or "Measuring…";
    end;
end;

local function clearRows() -- Line: 58
    -- upvalues: u8 (copy), u7 (copy), u16 (ref)
    for _, v in u8 do
        v:Disconnect();
    end;

    table.clear(u8);

    for _, v in u7 do
        v:Destroy();
    end;

    table.clear(u7);
    u16 = nil;
end;

local function status(p19) -- Line: 69
    -- upvalues: Panel (copy)
    Panel.Status.Text = p19 or "Switch servers between matches.";
end;

local function render() -- Line: 72
    -- upvalues: GuiService (copy), Panel (copy), clearRows (copy), u17 (ref), u12 (ref), u11 (ref), u14 (ref), u13 (ref), ServerBrowser (copy), u16 (ref), u3 (ref), ServerBrowserView (copy), u8 (copy), ServerBrowserEvent (copy), render (copy), u9 (ref), LocalPlayer (copy), u7 (copy), u2 (ref)
    local SelectedObject = GuiService.SelectedObject;

    if SelectedObject and SelectedObject:IsDescendantOf(Panel.List) then
        GuiService.SelectedObject = Panel.Close;
    end;

    clearRows();
    local v20 = {};

    for _, v in u17.rows or {} do
        local v21 = v.location and (v.location.countryCode or "UNKNOWN") or "UNKNOWN";

        if (v.current or v.updatedAt and os.time() - v.updatedAt <= 60) and (u12 == "ALL" or u12 == v21) then
            table.insert(v20, v);
        end;
    end;

    table.sort(v20, function(p22, p23) -- Line: 88
        -- upvalues: u11 (ref)
        if p22.current ~= p23.current then
            return p22.current == true;
        end;

        if p22.full ~= p23.full then
            return not p22.full;
        end;

        if u11 and p22.averagePing ~= p23.averagePing then
            return (p22.averagePing or (1 / 0)) < (p23.averagePing or (1 / 0));
        end;

        if p22.players == p23.players then
            return p22.id < p23.id;
        end;

        return p22.players > p23.players;
    end);
    Panel.Empty.Visible = #v20 == 0;
    Panel.Empty.Text = u12 == "ALL" and "No servers to show yet.\nTry refreshing in a moment." or "No available servers in this country.\nChoose ALL or refresh.";
    Panel.Count.Text = string.format("%d %s", #v20, #v20 == 1 and "SERVER" or "SERVERS");
    local math_ceil_ret = math.ceil(#v20 / 50);
    u14 = math.max(1, math_ceil_ret);
    u13 = math.clamp(u13, 1, u14);
    Panel.PageLabel.Text = ("PAGE %d / %d"):format(u13, u14);

    for _, v in {
        { Panel.PreviousPage, u13 > 1 },
        { Panel.NextPage, u13 < u14 }
    } do
        v[1].Active = v[2];
        v[1].Selectable = v[2];
        v[1].AutoButtonColor = v[2];
        v[1].TextTransparency = v[2] and 0 or 0.55;
    end;

    for i = (u13 - 1) * 50 + 1, math.min(u13 * 50, #v20) do
        local u24 = v20[i];
        local u25 = ServerBrowser.Templates.ServerRow:Clone();
        u25.Name = "Server_" .. i;
        u25.LayoutOrder = i;
        u25.Visible = true;
        local location = u24.location;
        u25.Title.Text = (u24.current and "YOUR SERVER · " or "") .. (location and (location.country or "Region unknown") or "Region unknown");
        u25.Details.Text = ("%d / %d players  ·  %s"):format(u24.players, u24.capacity, u24.phase);
        local v26;

        if location then
            v26 = location.subdivision;
        else
            v26 = location;
        end;

        local v27;

        if location then
            if not (v26 and (v26 ~= "" and v26)) then
                v26 = location.country;
            end;

            v27 = v26 .. " · approx." or (u24.region or "Location unavailable");
        else
            v27 = u24.region or "Location unavailable";
        end;

        u25.Region.Text = v27;
        u25.Ping.Text = u24.averagePing and (u24.averagePing .. " ms avg" or "Ping unavailable") or "Ping unavailable";

        if u24.current then
            u16 = u25;
        end;

        u25.Join.Text = u24.current and "HERE" or (u24.full and "FULL" or "JOIN");
        u25.Join.Active = not (u3 or (u24.current or u24.full)) and not u17.studio;
        u25.Join.Selectable = u25.Join.Active;
        u25.Join.AutoButtonColor = u25.Join.Active;
        u25.Join.BackgroundTransparency = u25.Join.Active and 0.08 or 0.7;
        u25.Join.TextTransparency = u25.Join.Active and 0 or 0.45;
        ServerBrowserView.styleRow(u25, u24);
        table.insert(u8, u25.Join.Activated:Connect(function() -- Line: 142
            -- upvalues: u25 (copy), u3 (ref), Panel (ref), ServerBrowserEvent (ref), u24 (copy), render (ref), u9 (ref), LocalPlayer (ref)
            if not u25.Join.Active or u3 then
                return;
            end;

            u3 = true;
            Panel.Status.Text = "Preparing to switch servers…";
            ServerBrowserEvent:FireServer("Join", u24.id);
            render();
            task.delay(55, function() -- Line: 150
                -- upvalues: u9 (ref), u3 (ref), LocalPlayer (ref), Panel (ref), render (ref)
                if u9 and (u3 and LocalPlayer:GetAttribute("ServerBrowserTransferring") ~= true) then
                    u3 = false;
                    Panel.Status.Text = "No transfer started. Please try again.";
                    render();
                end;
            end);
        end));
        u25.Parent = Panel.List;
        table.insert(u7, u25);
        local _ = i;
    end;

    if u9 and (u2 and ServerBrowser.Enabled) then
        if not Panel.Visible then
            return;
        end;

        local success, result = pcall(function() -- Line: 42
            -- upvalues: LocalPlayer (ref)
            return LocalPlayer:GetNetworkPing() * 1000;
        end);
        local v28 = success and (result == result and (result > 0 and math.floor(result + 0.5))) or nil;
        Panel.Connection.Text = v28 and ("YOUR CONNECTION  ·  " .. v28 .. " ms" or "YOUR CONNECTION  ·  measuring…") or "YOUR CONNECTION  ·  measuring…";

        if u16 and u16.Parent then
            u16.Ping.Text = v28 and v28 .. " ms · you" or "Measuring…";
        end;
    end;
end;

local function renderCountries() -- Line: 164
    -- upvalues: GuiService (copy), Panel (copy), u15 (copy), u17 (ref), u12 (ref), ServerBrowserView (copy), u13 (ref), render (copy), ServerBrowser (copy)
    local SelectedObject = GuiService.SelectedObject;
    local v29 = SelectedObject and SelectedObject:IsDescendantOf(Panel.Countries) and SelectedObject.Name;

    for _, v in u15 do
        v:Destroy();
    end;

    table.clear(u15);
    local v30 = {};

    for _, v in u17.rows or {} do
        local location = v.location;
        v30[location and (location.countryCode or "UNKNOWN") or "UNKNOWN"] = location and location.country or "Unknown region";
    end;

    local v31 = { {
            code = "ALL",
            name = "ALL COUNTRIES"
        } };

    for i, v in v30 do
        table.insert(v31, {
            code = i,
            name = v
        });
    end;

    table.sort(v31, function(p32, p33) -- Line: 180
        if p32.code == "ALL" then
            return p33.code ~= "ALL";
        end;

        if p33.code == "ALL" then
            return false;
        end;

        return p32.name < p33.name;
    end);

    if u12 ~= "ALL" and not v30[u12] then
        u12 = "ALL";
    end;

    for i, v in v31 do
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "Country_" .. v.code;
        TextButton.Text = v.name;
        TextButton.LayoutOrder = i;
        TextButton.BorderSizePixel = 0;
        TextButton.Parent = Panel.Countries;
        ServerBrowserView.styleCountry(TextButton, u12 == v.code);

        if v29 == TextButton.Name then
            GuiService.SelectedObject = TextButton;
        end;

        TextButton.Activated:Connect(function() -- Line: 203
            -- upvalues: u12 (ref), v (copy), u13 (ref), u15 (ref), ServerBrowserView (ref), TextButton (copy), Panel (ref), render (ref)
            u12 = v.code;
            u13 = 1;

            for _, v2 in u15 do
                ServerBrowserView.styleCountry(v2, v2 == TextButton);
            end;

            Panel.List.CanvasPosition = Vector2.zero;
            render();
        end);
        table.insert(u15, TextButton);
    end;

    ServerBrowserView.layout(ServerBrowser);
end;

local function request() -- Line: 216
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), Panel (copy), u7 (copy), ServerBrowserEvent (copy), u9 (ref), u3 (ref)
    if u4 or os.clock() - u5 < 2 then
        return;
    end;

    u4 = true;
    u5 = os.clock();
    u6 = u6 + 1;
    local u34 = u6;
    Panel.Refresh.Text = "…";

    if #u7 == 0 then
        Panel.Empty.Text = "Looking for servers…";
    end;

    ServerBrowserEvent:FireServer("List");
    task.delay(10, function() -- Line: 229
        -- upvalues: u9 (ref), u4 (ref), u6 (ref), u34 (copy), Panel (ref), u3 (ref)
        if u9 and (u4 and u6 == u34) then
            u4 = false;
            Panel.Refresh.Text = "REFRESH";

            if not u3 then
                Panel.Status.Text = "The server list is taking longer than usual. Try refreshing.";
            end;
        end;
    end);
end;

local function permitted() -- Line: 239
    -- upvalues: LocalPlayer (copy)
    local v35;

    if workspace:GetAttribute("ServerBrowserAvailable") == true and (LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and ((LocalPlayer:GetAttribute("GameRole") or "Lobby") == "Lobby" and (LocalPlayer:GetAttribute("TutorialSession") ~= true and (LocalPlayer:GetAttribute("TutorialRouting") ~= true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true))))) then
        v35 = LocalPlayer:GetAttribute("AdminRefreshActive") ~= true;
    else
        v35 = false;
    end;

    return v35;
end;

local function setOpen(p36) -- Line: 249
    -- upvalues: permitted (copy), HudNavigation (copy), u2 (ref), LocalPlayer (copy), Panel (copy), ServerBrowserShade (copy), u10 (ref), GuiService (copy), TweenService (copy), ServerBrowserView (copy), ServerBrowser (copy), u9 (ref), u16 (ref), request (copy), UserInputService (copy)
    if p36 and not permitted() then
        return;
    end;

    if p36 then
        HudNavigation.opening("Servers");
    end;

    if u2 == p36 then
        return;
    end;

    u2 = p36;
    LocalPlayer:SetAttribute("ServerBrowserOpen", p36);
    Panel.Visible = p36;
    ServerBrowserShade.Enabled = p36;

    if p36 then
        u10 = GuiService.SelectedObject;
        ServerBrowserShade.Shade.BackgroundTransparency = 1;
        TweenService:Create(ServerBrowserShade.Shade, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.4
        }):Play();
        ServerBrowserView.layout(ServerBrowser);

        if u9 and (u2 and (ServerBrowser.Enabled and Panel.Visible)) then
            local success, result = pcall(function() -- Line: 42
                -- upvalues: LocalPlayer (ref)
                return LocalPlayer:GetNetworkPing() * 1000;
            end);
            local v37 = success and (result == result and (result > 0 and math.floor(result + 0.5))) or nil;
            Panel.Connection.Text = v37 and ("YOUR CONNECTION  ·  " .. v37 .. " ms" or "YOUR CONNECTION  ·  measuring…") or "YOUR CONNECTION  ·  measuring…";

            if u16 and u16.Parent then
                u16.Ping.Text = v37 and v37 .. " ms · you" or "Measuring…";
            end;
        end;

        request();

        if UserInputService.GamepadEnabled then
            GuiService.SelectedObject = Panel.Close;
        end;
    else
        local SelectedObject = GuiService.SelectedObject;

        if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
            GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
        end;
    end;
end;

local function availability() -- Line: 280
    -- upvalues: ServerBrowser (copy), HudNavigation (copy), permitted (copy), u2 (ref), LocalPlayer (copy), Panel (copy), ServerBrowserShade (copy), GuiService (copy), u10 (ref)
    ServerBrowser.Open.Visible = false;
    HudNavigation.setAvailable("Servers", (permitted()));

    if not permitted() then
        if u2 == false then
            return;
        end;

        u2 = false;
        LocalPlayer:SetAttribute("ServerBrowserOpen", false);
        Panel.Visible = false;
        ServerBrowserShade.Enabled = false;
        local SelectedObject = GuiService.SelectedObject;

        if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
            GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
        end;
    end;
end;

HudNavigation.register("Servers", function() -- Line: 287
    -- upvalues: setOpen (copy), u2 (ref)
    setOpen(not u2);
end);
HudNavigation.Opening.Event:Connect(function(p38) -- Line: 290
    -- upvalues: u2 (ref), LocalPlayer (copy), Panel (copy), ServerBrowserShade (copy), GuiService (copy), ServerBrowser (copy), u10 (ref)
    if p38 ~= "Servers" then
        if u2 == false then
            return;
        end;

        u2 = false;
        LocalPlayer:SetAttribute("ServerBrowserOpen", false);
        Panel.Visible = false;
        ServerBrowserShade.Enabled = false;
        local SelectedObject = GuiService.SelectedObject;

        if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
            GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
        end;
    end;
end);
ServerBrowser.Open.Activated:Connect(function() -- Line: 295
    -- upvalues: setOpen (copy), u2 (ref)
    setOpen(not u2);
end);
Panel.Close.Activated:Connect(function() -- Line: 298
    -- upvalues: u2 (ref), LocalPlayer (copy), Panel (copy), ServerBrowserShade (copy), GuiService (copy), ServerBrowser (copy), u10 (ref)
    if u2 == false then
        return;
    end;

    u2 = false;
    LocalPlayer:SetAttribute("ServerBrowserOpen", false);
    Panel.Visible = false;
    ServerBrowserShade.Enabled = false;
    local SelectedObject = GuiService.SelectedObject;

    if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
        GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
    end;
end);
Panel.Refresh.Activated:Connect(request);

local function changePage(p39) -- Line: 303
    -- upvalues: u13 (ref), u14 (ref), Panel (copy), render (copy)
    local math_clamp_ret = math.clamp(u13 + p39, 1, u14);

    if math_clamp_ret == u13 then
        return;
    end;

    u13 = math_clamp_ret;
    Panel.List.CanvasPosition = Vector2.zero;
    render();
end;

Panel.PreviousPage.Activated:Connect(function() -- Line: 312
    -- upvalues: u13 (ref), u14 (ref), Panel (copy), render (copy)
    local math_clamp_ret = math.clamp(u13 + -1, 1, u14);

    if math_clamp_ret == u13 then
        return;
    end;

    u13 = math_clamp_ret;
    Panel.List.CanvasPosition = Vector2.zero;
    render();
end);
Panel.NextPage.Activated:Connect(function() -- Line: 315
    -- upvalues: u13 (ref), u14 (ref), Panel (copy), render (copy)
    local math_clamp_ret = math.clamp(u13 + 1, 1, u14);

    if math_clamp_ret == u13 then
        return;
    end;

    u13 = math_clamp_ret;
    Panel.List.CanvasPosition = Vector2.zero;
    render();
end);
Panel.Sort.Activated:Connect(function() -- Line: 318
    -- upvalues: u13 (ref), Panel (copy), u11 (ref), render (copy)
    u13 = 1;
    Panel.List.CanvasPosition = Vector2.zero;
    u11 = not u11;
    Panel.Sort.Text = u11 and "SORT: AVG PING" or "SORT: PLAYERS";
    render();
end);
UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 325
    -- upvalues: UserInputService (copy), setOpen (copy), u2 (ref), LocalPlayer (copy), Panel (copy), ServerBrowserShade (copy), GuiService (copy), ServerBrowser (copy), u10 (ref)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if p41 or p40.KeyCode ~= Enum.KeyCode.B then
        if u2 and (p40.KeyCode == Enum.KeyCode.ButtonB or p40.KeyCode == Enum.KeyCode.Escape) then
            if u2 == false then
                return;
            end;

            u2 = false;
            LocalPlayer:SetAttribute("ServerBrowserOpen", false);
            Panel.Visible = false;
            ServerBrowserShade.Enabled = false;
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
                GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
            end;
        end;

        return;
    end;

    setOpen(not u2);
end);
ServerBrowserEvent.OnClientEvent:Connect(function(p42, p43) -- Line: 335
    -- upvalues: u4 (ref), u6 (ref), Panel (copy), u17 (ref), renderCountries (copy), render (copy), u3 (ref)
    if type(p43) ~= "table" then
        return;
    end;

    if p42 == "List" then
        u4 = false;
        u6 = u6 + 1;
        Panel.Refresh.Text = "REFRESH";
        u17 = p43;
        renderCountries();
        render();

        if not u3 then
            Panel.Status.Text = p43.notice or p43.joinReason or "Switch servers between matches.";
        end;
    else
        if p42 == "Joining" then
            u3 = true;
            Panel.Status.Text = p43.message or "Switch servers between matches.";
            render();

            return;
        end;

        if p42 == "JoinResult" then
            u3 = false;
            Panel.Status.Text = p43.message or "Switch servers between matches.";
            render();

            return;
        end;

        if p42 == "Error" then
            u4 = false;
            Panel.Refresh.Text = "REFRESH";

            if not u3 then
                Panel.Status.Text = p43.message or "Switch servers between matches.";
            end;
        end;
    end;
end);

for _, v in { "ClientReady", "InMatch", "GameRole", "TutorialSession", "TutorialRouting", "ScreenPresentationActive", "AdminRefreshActive" } do
    LocalPlayer:GetAttributeChangedSignal(v):Connect(availability);
end;

workspace:GetAttributeChangedSignal("ServerBrowserAvailable"):Connect(availability);
Panel.Visible = false;
ServerBrowserShade.Enabled = false;
LocalPlayer:SetAttribute("ServerBrowserOpen", false);
ServerBrowser.Open.Visible = false;
HudNavigation.setAvailable("Servers", (permitted()));

if not permitted() and u2 ~= false then
    u2 = false;
    LocalPlayer:SetAttribute("ServerBrowserOpen", false);
    Panel.Visible = false;
    ServerBrowserShade.Enabled = false;
    local SelectedObject = GuiService.SelectedObject;

    if SelectedObject and SelectedObject:IsDescendantOf(ServerBrowser) then
        GuiService.SelectedObject = u10 and (u10.Parent and u10) or nil;
    end;
end;

task.spawn(function() -- Line: 383
    -- upvalues: u9 (ref), u2 (ref), ServerBrowser (copy), Panel (copy), LocalPlayer (copy), u16 (ref), request (copy)
    local v44 = 0;

    while u9 do
        task.wait(1);
        v44 = v44 + 1;

        if u2 then
            if u9 and (u2 and (ServerBrowser.Enabled and Panel.Visible)) then
                local success, result = pcall(function() -- Line: 42
                    -- upvalues: LocalPlayer (ref)
                    return LocalPlayer:GetNetworkPing() * 1000;
                end);
                local v45 = success and (result == result and (result > 0 and math.floor(result + 0.5))) or nil;
                Panel.Connection.Text = v45 and ("YOUR CONNECTION  ·  " .. v45 .. " ms" or "YOUR CONNECTION  ·  measuring…") or "YOUR CONNECTION  ·  measuring…";

                if u16 and u16.Parent then
                    u16.Ping.Text = v45 and v45 .. " ms · you" or "Measuring…";
                end;
            end;

            if v44 >= 16 then
                request();
                v44 = 0;
            end;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 397
    -- upvalues: u1 (copy), u9 (ref), LocalPlayer (copy), ServerBrowserShade (copy), clearRows (copy)
    u1:Disconnect();
    u9 = false;
    LocalPlayer:SetAttribute("ServerBrowserOpen", false);
    ServerBrowserShade.Enabled = false;
    clearRows();
end);