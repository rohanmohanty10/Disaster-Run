 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local TextChatService = game:GetService("TextChatService");
local LocalPlayer = Players.LocalPlayer;
local AdminEvent = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Admin"):WaitForChild("AdminEvent");
local u1 = script.Parent.AdminUI:Clone();
u1.Notice:SetAttribute("SelfManagedText", true);

for _, v in { "Console", "OpenConsole" } do
    local v2 = u1:FindFirstChild(v);

    if v2 then
        v2:Destroy();
    end;
end;

u1.Parent = LocalPlayer:WaitForChild("PlayerGui");
u1.Enabled = true;
local Refresh = u1.Refresh;
local Notice = u1.Notice;
local ValleyTheme = require(game.ReplicatedStorage.ChickenOrHero.Presentation.ValleyTheme);
Notice.RichText = false;
Notice:SetAttribute("UIProportionalGroup", nil);

for _, child in Notice:GetChildren() do
    if child:IsA("UIScale") or (child:IsA("UIAspectRatioConstraint") or child:IsA("UISizeConstraint")) then
        child:Destroy();
    end;
end;

Notice.BackgroundTransparency = 1;
Notice.TextColor3 = ValleyTheme.Paper;
Notice.TextStrokeColor3 = ValleyTheme.Ink;
Notice.TextStrokeTransparency = 0.2;
Notice.Font = Enum.Font.GothamBold;
Notice.AnchorPoint = Vector2.new(0.5, 0);
Notice.Position = UDim2.fromScale(0.5, 0.18);
Notice.Size = UDim2.fromScale(0.75, 0.13);
Notice.TextScaled = true;
Notice.TextWrapped = true;
local v3 = Notice:FindFirstChildOfClass("UITextSizeConstraint") or Instance.new("UITextSizeConstraint");
v3.MinTextSize = 12;
v3.MaxTextSize = 23;
v3.Parent = Notice;
local u4 = Notice:FindFirstChildOfClass("UITextSizeConstraint");
u1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 30, Name: fitNotice
    -- upvalues: u1 (copy), u4 (copy)
    local AbsoluteSize = u1.AbsoluteSize;

    if u4 and AbsoluteSize.X > 0 then
        u4.MaxTextSize = (AbsoluteSize.X < 700 or AbsoluteSize.Y < 500) and 14 or 23;
    end;
end);
local AbsoluteSize = u1.AbsoluteSize;

if u4 and AbsoluteSize.X > 0 then
    u4.MaxTextSize = (AbsoluteSize.X < 700 or AbsoluteSize.Y < 500) and 14 or 23;
end;

local BlurEffect = Instance.new("BlurEffect");
BlurEffect.Name = "AdminRefreshBlur";
BlurEffect.Size = 0;
BlurEffect.Parent = Lighting;
local u5 = nil;
local u6 = 0;
local u7 = 0;
local u8 = false;
local u9 = false;
local u10 = 0;
local u11 = 0;

local function tween(p12, p13, p14) -- Line: 38
    -- upvalues: TweenService (copy)
    TweenService:Create(p12, TweenInfo.new(p13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p14):Play();
end;

local function chatReply(p15, p16) -- Line: 41
    -- upvalues: TextChatService (copy)
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXSystem");
    end;

    if not TextChannels then
        return;
    end;

    local v17 = p15:match("^[^\n]*");
    local v18 = #v17 < #p15;
    local utf8_offset_ret = utf8.offset(v17, 201);

    if utf8_offset_ret then
        v17 = v17:sub(1, utf8_offset_ret - 1);
        v18 = true;
    end;

    local v19 = v17:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
    pcall(TextChannels.DisplaySystemMessage, TextChannels, (p16 or "[Admin] ") .. v19 .. (v18 and " … (open the staff panel with F4 for the rest)" or ""));
end;

local function reply(p20) -- Line: 49
    -- upvalues: u5 (ref), chatReply (copy), LocalPlayer (copy)
    if u5 then
        return;
    end;

    chatReply(tostring(p20), LocalPlayer:GetAttribute("AdminAuthorized") == true and "[Admin] " or "");
end;

local function clear(p21) -- Line: 53
    -- upvalues: u5 (ref), u6 (ref), u9 (ref), u8 (ref), LocalPlayer (copy), BlurEffect (copy), TweenService (copy), Refresh (copy)
    if p21 and u5 ~= p21 then
        return;
    end;

    u6 = u6 + 1;
    u5 = nil;
    u9 = false;
    u8 = false;
    LocalPlayer:SetAttribute("AdminRefreshActive", nil);
    TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    TweenService:Create(Refresh, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    local u22 = u6;
    task.delay(0.35, function() -- Line: 60
        -- upvalues: u6 (ref), u22 (copy), Refresh (ref)
        if u6 == u22 then
            Refresh.Visible = false;
        end;
    end);
end;

local function teleportScreen() -- Line: 62
    -- upvalues: TeleportService (copy)
    local v23 = script.Parent.AdminTeleportUI:Clone();
    require(game.ReplicatedFirst.UIProportions).prepareTeleport(v23, workspace.CurrentCamera.ViewportSize);
    TeleportService:SetTeleportGui(v23);
end;

local function show(p24) -- Line: 67
    -- upvalues: u10 (ref), u5 (ref), u7 (ref), u8 (ref), u9 (ref), u6 (ref), Refresh (copy), LocalPlayer (copy), BlurEffect (copy), TweenService (copy), TeleportService (copy)
    if type(p24) ~= "table" or type(p24.id) ~= "string" then
        return;
    end;

    u10 = os.clock();
    local v25 = u5 ~= p24.id;
    u5 = p24.id;
    u7 = p24.deadline or workspace:GetServerTimeNow();
    u8 = p24.transfer == true;
    u9 = false;
    u6 = u6 + 1;
    local u26 = u6;
    Refresh.Visible = true;
    Refresh.Content.Retry.Visible = false;
    Refresh.Content.Dismiss.Visible = false;
    Refresh.Content.Heading.Text = p24.title or "REFRESHING VALLEY RUN";

    if v25 then
        Refresh.GroupTransparency = 1;
        Refresh.Content.Body.MaxVisibleGraphemes = 0;
    end;

    Refresh.Content.Body.Text = p24.message or "Please hold on while you are refreshed.";
    LocalPlayer:SetAttribute("AdminRefreshActive", true);
    TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = 22
    }):Play();
    TweenService:Create(Refresh, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    local v27 = script.Parent.AdminTeleportUI:Clone();
    require(game.ReplicatedFirst.UIProportions).prepareTeleport(v27, workspace.CurrentCamera.ViewportSize);
    TeleportService:SetTeleportGui(v27);

    if v25 then
        task.spawn(function() -- Line: 81
            -- upvalues: Refresh (ref), u6 (ref), u26 (copy)
            for i = 1, utf8.len(Refresh.Content.Body.Text) or #Refresh.Content.Body.Text do
                if u6 ~= u26 then
                    return;
                end;

                Refresh.Content.Body.MaxVisibleGraphemes = i;
                task.wait(0.025);
                local _ = i;
            end;

            Refresh.Content.Body.MaxVisibleGraphemes = -1;
        end);

        return;
    end;

    Refresh.Content.Body.MaxVisibleGraphemes = -1;
end;

local function showFailure(p28, p29) -- Line: 91
    -- upvalues: u6 (ref), u10 (ref), u9 (ref), Refresh (copy), LocalPlayer (copy), BlurEffect (copy), TweenService (copy)
    u6 = u6 + 1;
    u10 = os.clock();
    u9 = true;
    Refresh.Visible = true;
    Refresh.GroupTransparency = 0;
    Refresh.Content.Body.MaxVisibleGraphemes = -1;
    Refresh.Content.Heading.Text = "RECONNECTING PAUSED";
    Refresh.Content.Body.Text = p28;
    Refresh.Content.Status.Text = p29 and "Tap retry when you\'re ready." or "You can keep playing.";
    Refresh.Content.Retry.Visible = p29 == true;
    Refresh.Content.Dismiss.Visible = not p29;

    if not p29 then
        LocalPlayer:SetAttribute("AdminRefreshActive", nil);
        TweenService:Create(BlurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end;
end;

Refresh.Content.Retry.Activated:Connect(function() -- Line: 99
    -- upvalues: Refresh (copy), u9 (ref), u10 (ref), AdminEvent (copy)
    Refresh.Content.Retry.Visible = false;
    Refresh.Content.Status.Text = "Trying again…";
    u9 = false;
    u10 = os.clock();
    AdminEvent:FireServer("RetryTransfer");
end);
Refresh.Content.Dismiss.Activated:Connect(function() -- Line: 103
    -- upvalues: clear (copy)
    clear();
end);
AdminEvent.OnClientEvent:Connect(function(p30, p31, p32) -- Line: 104
    -- upvalues: u5 (ref), chatReply (copy), LocalPlayer (copy), show (copy), clear (copy), showFailure (copy), u11 (ref), Notice (copy), TweenService (copy)
    if p30 == "Reply" then
        if u5 then
            return;
        end;

        chatReply(tostring(p31), LocalPlayer:GetAttribute("AdminAuthorized") == true and "[Admin] " or "");

        return;
    end;

    if p30 == "Refresh" then
        show(p31);

        return;
    end;

    if p30 == "CancelRefresh" then
        clear(p31);

        return;
    end;

    if p30 == "TransferFailed" then
        showFailure(p31, p32);

        return;
    end;

    if p30 == "Announcement" then
        u11 = u11 + 1;
        local u33 = u11;
        Notice.Text = p31;
        Notice.Visible = true;
        Notice.TextTransparency = 1;
        TweenService:Create(Notice, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
        task.delay(7, function() -- Line: 113
            -- upvalues: u11 (ref), u33 (copy), Notice (ref), TweenService (ref)
            if u11 == u33 then
                TweenService:Create(Notice, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 1
                }):Play();
                task.wait(0.35);

                if u11 == u33 then
                    Notice.Visible = false;
                end;
            end;
        end);
    end;
end);
RunService.RenderStepped:Connect(function() -- Line: 119
    -- upvalues: u5 (ref), u9 (ref), u7 (ref), Refresh (copy), u8 (ref), u10 (ref), showFailure (copy)
    if not u5 or u9 then
        return;
    end;

    local v34 = u7 - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v34);
    local math_max_ret = math.max(0, math_ceil_ret);

    if math_max_ret > 0 then
        Refresh.Content.Status.Text = "Refreshing in " .. math_max_ret .. "…";
    else
        Refresh.Content.Status.Text = u8 and "Reconnecting…" or "Saving your progress…";
    end;

    if os.clock() - u10 > 140 then
        showFailure("Reconnecting is taking longer than expected. Please rejoin from Roblox if needed.", false);
    end;
end);
script.Destroying:Connect(function() -- Line: 129
    -- upvalues: LocalPlayer (copy), BlurEffect (copy), u1 (copy)
    LocalPlayer:SetAttribute("AdminRefreshActive", nil);
    BlurEffect:Destroy();
    u1:Destroy();
end);
LocalPlayer:WaitForChild("PlayerGui").ChildRemoved:Connect(function(p35) -- Line: 134
    -- upvalues: LocalPlayer (copy)
    if p35.Name == "StaffPanel" and LocalPlayer:GetAttribute("StaffPanelOpen") then
        LocalPlayer:SetAttribute("StaffPanelOpen", nil);
        LocalPlayer:SetAttribute("AdminConsoleActive", nil);
    end;
end);
local success, result = pcall(function() -- Line: 139
    -- upvalues: TeleportService (copy)
    return TeleportService:GetLocalPlayerTeleportData();
end);

if success and (type(result) == "table" and result.destination == "Refresh") then
    show({
        title = "REJOINING VALLEY RUN",
        message = "Your progress is saved. Finding a refreshed server…",
        transfer = true,
        id = result.refreshId or "arrival"
    });
end;

AdminEvent:FireServer("Sync");