 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local UserInputService = game:GetService("UserInputService");
local TextService = game:GetService("TextService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Nametags = require(ReplicatedStorage.Shared.Tables.Nametags);
local LocalPlayer = Players.LocalPlayer;
local Attributes = Nametags.Attributes;
local Nametag = ReplicatedStorage.Assets.UI.Nametag;
local Device = ReplicatedStorage.Controllers.Device;
local u1 = nil;
local v2 = Knit.CreateController({
    Name = "NametagController"
});

function v2.PublishPresence(u3) -- Line: 22
    -- upvalues: Nametags (copy), u1 (ref), Device (copy)
    if u3.PresenceTask then
        return;
    end;

    u3.PresenceTask = task.delay(Nametags.PresenceDelay, function() -- Line: 24
        -- upvalues: u3 (copy), u1 (ref), Device (ref)
        u3.PresenceTask = nil;
        u1.Presence:Fire(Device.Value, u3.Idle or not u3.Focused);
    end);
end;

function v2.FitName(u4, u5, u6) -- Line: 30
    -- upvalues: TextService (copy)
    local DisplayName = u5.DisplayName;
    local PlayerNameDs = u6.Gui.Container.NameFrame.PlayerNameDs;
    PlayerNameDs.Text = DisplayName;
    PlayerNameDs.PlayerName.Text = DisplayName;
    u6.Gui.Container.Username.Text = `@{u5.Name}`;
    PlayerNameDs.Size = UDim2.fromScale(0.7, 0.8);
    u6.Cleanup:Add(task.spawn(function() -- Line: 38
        -- upvalues: DisplayName (copy), PlayerNameDs (copy), TextService (ref), u4 (copy), u5 (copy), u6 (copy)
        local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
        GetTextBoundsParams.Text = DisplayName;
        GetTextBoundsParams.Font = PlayerNameDs.FontFace;
        GetTextBoundsParams.Size = 100;
        GetTextBoundsParams.Width = 10000;
        local success, result = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams);

        if not (success and (result.Y > 0 and (u4.Plates[u5] == u6 and u5.DisplayName == DisplayName))) then
            return;
        end;

        local Parent = PlayerNameDs.Parent;
        local v7 = u6.Gui.Size.X.Scale * u6.Gui.Container.Size.X.Scale * Parent.Size.X.Scale;
        local v8 = u6.Gui.Size.Y.Scale * u6.Gui.Container.Size.Y.Scale * Parent.Size.Y.Scale;

        if v7 <= 0 or v8 <= 0 then
            return;
        end;

        local v9 = v7 / v8;
        local Scale = Parent.UIListLayout.Padding.Scale;
        local v10 = 0;

        for _, v in ipairs({ Parent.Verified, Parent.Friend }) do
            if v.Visible then
                local v11 = v:FindFirstChildOfClass("UIAspectRatioConstraint");
                v10 = v10 + (v.Size.Y.Scale * (not v11 and 1 or v11.AspectRatio) / v9 + Scale);
            end;
        end;

        PlayerNameDs.Size = UDim2.fromScale(math.clamp(0.8 * result.X / result.Y / v9 * 1.06, 0.06, 1 - v10), 0.8);
    end));
end;

function v2.UpdateVisibility(p12, p13) -- Line: 68
    -- upvalues: LocalPlayer (copy), ReplicatedFirst (copy), Attributes (copy), TweenService (copy)
    local v14 = p12.Plates[p13];

    if not v14 then
        return;
    end;

    local v15;

    if p13.Team == game.Teams.Visitor and LocalPlayer.Team == game.Teams.Visitor then
        v15 = not ReplicatedFirst.InLoadingScreen.Value;

        if v15 then
            if v14.Humanoid.Health > 0 and (p13:GetAttribute(Attributes.Level) ~= nil and p13:GetAttribute(Attributes.Overall) ~= nil) then
                v15 = p13:GetAttribute(Attributes.RankIcon) ~= nil;
            else
                v15 = false;
            end;
        end;
    else
        v15 = false;
    end;

    if v14.Gui.Enabled == v15 then
        return;
    end;

    v14.Motion:Clean();
    v14.Gui.Enabled = v15;

    if not v15 then
        if v14.HiddenDisplay then
            v14.HiddenDisplay = false;

            if v14.Humanoid.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
                v14.Humanoid.DisplayDistanceType = v14.OriginalDisplay;
            end;
        end;

        return;
    end;

    v14.OriginalDisplay = v14.Humanoid.DisplayDistanceType;
    v14.HiddenDisplay = true;
    v14.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    local Container = v14.Gui.Container;
    Container.GroupTransparency = 1;
    v14.Scale.Scale = 0.6;
    v14.Motion:Add(TweenService:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    })):Play();
    v14.Motion:Add(TweenService:Create(v14.Scale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    })):Play();
end;

function v2.UpdatePlate(p16, p17) -- Line: 97
    -- upvalues: Attributes (copy)
    local v18 = p16.Plates[p17];

    if not v18 then
        return;
    end;

    local Container = v18.Gui.Container;
    local DetailsFrame = Container.DetailsFrame;
    local Level = DetailsFrame.Level.Level;
    local v19 = p17:GetAttribute(Attributes.Level) or 0;
    Level.Text = tostring(v19);
    local Ovr = DetailsFrame.Ovr.Ovr;
    local v20 = p17:GetAttribute(Attributes.Overall) or 50;
    Ovr.Text = tostring(v20);
    DetailsFrame.Ranked.Image = p17:GetAttribute(Attributes.RankIcon) or "";
    DetailsFrame.Ranked.Visible = DetailsFrame.Ranked.Image ~= "";
    local Attribute = p17:GetAttribute(Attributes.Device);
    DetailsFrame.PcIcon.Visible = Attribute == "PC";
    DetailsFrame.MobileIcon.Visible = Attribute == "Mobile";
    DetailsFrame.ConsoleIcon.Visible = Attribute == "Console";
    Container.Afk.Visible = p17:GetAttribute(Attributes.AFK) == true;
    p16:UpdateVisibility(p17);
end;

function v2.BindPlayer(u21, u22) -- Line: 114
    -- upvalues: Trove (copy), Players (copy), Nametag (copy), LocalPlayer (copy), Attributes (copy)
    if u21.Players[u22] then
        return;
    end;

    local u23 = Trove.new();
    local u24 = u23:Add(Trove.new());
    u21.Players[u22] = u23;

    local function bindCharacter(p25) -- Line: 120
        -- upvalues: u24 (copy), u22 (copy), Players (ref), u21 (copy), u23 (copy), Nametag (ref), LocalPlayer (ref), Trove (ref)
        u24:Clean();
        local Head = p25:WaitForChild("Head", 10);
        local Humanoid = p25:WaitForChild("Humanoid", 10);

        if not (Head and (Humanoid and (u22.Character == p25 and (u22.Parent == Players and u21.Players[u22] == u23)))) then
            return;
        end;

        local v26 = Nametag:Clone();
        v26.Name = `Nametag_{u22.UserId}`;
        v26.Adornee = Head;
        v26.Enabled = false;
        local Container = v26.Container;
        local UIScale = Instance.new("UIScale");
        UIScale.Parent = Container;
        Container.NameFrame.PlayerNameDs.RichText = false;
        Container.NameFrame.PlayerNameDs.PlayerName.RichText = false;
        Container.Username.RichText = false;
        Container.NameFrame.Verified.Visible = u22.HasVerifiedBadge;
        Container.NameFrame.Friend.Visible = u21.Friends[u22] == true;
        v26.Parent = LocalPlayer.PlayerGui;
        u24:Add(v26);
        local u27 = {
            Gui = v26,
            Humanoid = Humanoid,
            Scale = UIScale,
            Cleanup = u24,
            Motion = u24:Add(Trove.new())
        };
        u21.Plates[u22] = u27;
        u24:Add(function() -- Line: 153
            -- upvalues: u21 (ref), u22 (ref), u27 (copy), Humanoid (copy)
            if u21.Plates[u22] == u27 then
                u21.Plates[u22] = nil;
            end;

            if u27.HiddenDisplay and (Humanoid.Parent and Humanoid.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None) then
                Humanoid.DisplayDistanceType = u27.OriginalDisplay;
            end;
        end);
        u24:Connect(Humanoid.HealthChanged, function() -- Line: 159
            -- upvalues: u21 (ref), u22 (ref)
            u21:UpdateVisibility(u22);
        end);
        u21:FitName(u22, u27);
        u21:UpdatePlate(u22);
    end;

    u23:Connect(u22.CharacterAdded, bindCharacter);
    u23:Connect(u22.CharacterRemoving, function() -- Line: 167
        -- upvalues: u24 (copy)
        u24:Clean();
    end);
    u23:Connect(u22:GetPropertyChangedSignal("Team"), function() -- Line: 170
        -- upvalues: u21 (copy), u22 (copy)
        u21:UpdateVisibility(u22);
    end);
    u23:Connect(u22:GetPropertyChangedSignal("DisplayName"), function() -- Line: 173
        -- upvalues: u21 (copy), u22 (copy)
        local v28 = u21.Plates[u22];

        if v28 then
            u21:FitName(u22, v28);
        end;
    end);

    for _, v in pairs(Attributes) do
        u23:Connect(u22:GetAttributeChangedSignal(v), function() -- Line: 178
            -- upvalues: u21 (copy), u22 (copy)
            u21:UpdatePlate(u22);
        end);
    end;

    if u22.Character then
        u23:Add(task.spawn(bindCharacter, u22.Character));
    end;

    if u22 ~= LocalPlayer then
        u23:Add(task.spawn(function() -- Line: 187
            -- upvalues: LocalPlayer (ref), u22 (copy), u21 (copy), u23 (copy)
            local success, result = pcall(LocalPlayer.IsFriendsWithAsync, LocalPlayer, u22.UserId);

            if u21.Players[u22] ~= u23 then
                return;
            end;

            u21.Friends[u22] = success and result;
            local v29 = u21.Plates[u22];

            if v29 then
                v29.Gui.Container.NameFrame.Friend.Visible = u21.Friends[u22] == true;
                u21:FitName(u22, v29);
            end;
        end));
    end;
end;

function v2.KnitStart(u30) -- Line: 200
    -- upvalues: u1 (ref), Knit (copy), UserInputService (copy), LocalPlayer (copy), Device (copy), ReplicatedFirst (copy), Players (copy)
    u1 = Knit.GetService("PlayerService");
    u30.Players = {};
    u30.Plates = {};
    u30.Friends = {};
    u30.Idle = false;
    u30.Focused = true;

    local function activity() -- Line: 208
        -- upvalues: u30 (copy)
        if not u30.Idle then
            return;
        end;

        u30.Idle = false;
        u30:PublishPresence();
    end;

    UserInputService.InputBegan:Connect(activity);
    UserInputService.InputChanged:Connect(activity);
    UserInputService.WindowFocused:Connect(function() -- Line: 215
        -- upvalues: u30 (copy)
        u30.Focused = true;
        u30.Idle = false;
        u30:PublishPresence();
    end);
    UserInputService.WindowFocusReleased:Connect(function() -- Line: 220
        -- upvalues: u30 (copy)
        u30.Focused = false;
        u30:PublishPresence();
    end);
    LocalPlayer.Idled:Connect(function() -- Line: 224
        -- upvalues: u30 (copy)
        u30.Idle = true;
        u30:PublishPresence();
    end);
    Device:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 228
        -- upvalues: u30 (copy)
        u30:PublishPresence();
    end);
    u30:PublishPresence();

    local function updateVisibility() -- Line: 233
        -- upvalues: u30 (copy)
        for i in pairs(u30.Plates) do
            u30:UpdateVisibility(i);
        end;
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(updateVisibility);
    ReplicatedFirst.InLoadingScreen.Changed:Connect(updateVisibility);
    Players.PlayerAdded:Connect(function(p31) -- Line: 238
        -- upvalues: u30 (copy)
        u30:BindPlayer(p31);
    end);
    Players.PlayerRemoving:Connect(function(p32) -- Line: 241
        -- upvalues: u30 (copy)
        local v33 = u30.Players[p32];

        if v33 then
            v33:Destroy();
        end;

        u30.Players[p32] = nil;
        u30.Friends[p32] = nil;
    end);

    for _, v in ipairs(Players:GetPlayers()) do
        u30:BindPlayer(v);
    end;
end;

return v2;