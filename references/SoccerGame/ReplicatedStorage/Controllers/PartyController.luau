  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v1 = Knit.CreateController({
    Name = "PartyController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = 1;
local u14 = nil;
local u15 = nil;

local function clearPartyClones() -- Line: 36
    -- upvalues: u5 (ref)
    for _, child in u5:GetChildren() do
        if child:GetAttribute("IsClone") then
            child:Destroy();
        end;
    end;
end;

local function addPartyMember(u16, p17, u18, p19, p20, p21, p22) -- Line: 44
    -- upvalues: u8 (ref), u5 (ref), Players (copy), u2 (ref), u14 (ref), LocalPlayer (copy)
    local u23 = u8:Clone();
    u23.Name = "Member_" .. u18;
    u23.LayoutOrder = p19;
    u23.Visible = true;
    u23:SetAttribute("IsClone", true);
    u23.Parent = u5;
    u23.PlayerName.Text = u16;
    u23.DisplayName.Text = p17 or u16;
    u23.PartyLeader.Visible = p20;
    task.spawn(function() -- Line: 56
        -- upvalues: Players (ref), u18 (copy), u23 (copy)
        local success, result = pcall(function() -- Line: 57
            -- upvalues: Players (ref), u18 (ref)
            return Players:GetUserThumbnailAsync(u18, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
        end);

        if success and (result and u23.Parent) then
            u23.Player.profilepic.Image = result;
        end;
    end);
    local ActionButton = u23.ActionButton;

    if not p22 then
        ActionButton.Visible = false;

        return u23;
    end;

    if p21 and p20 then
        ActionButton.Visible = true;
        ActionButton.option.Text = "DISBAND";
        ActionButton.Activated:Connect(function() -- Line: 72
            -- upvalues: u2 (ref)
            u2:LeaveParty();
        end);

        return u23;
    end;

    if p21 and not p20 then
        ActionButton.Visible = true;
        ActionButton.option.Text = "LEAVE";
        ActionButton.Activated:Connect(function() -- Line: 78
            -- upvalues: u2 (ref)
            u2:LeaveParty();
        end);

        return u23;
    end;

    if p21 or u14 ~= LocalPlayer.Name then
        ActionButton.Visible = false;

        return u23;
    end;

    ActionButton.Visible = true;
    ActionButton.option.Text = "KICK";
    ActionButton.Activated:Connect(function() -- Line: 84
        -- upvalues: Players (ref), u16 (copy), u2 (ref)
        local v24 = Players:FindFirstChild(u16);

        if v24 then
            u2:KickFromParty(v24);
        end;
    end);

    return u23;
end;

local function updatePartyDisplay(p25) -- Line: 97
    -- upvalues: clearPartyClones (copy), u13 (ref), u14 (ref), u15 (ref), LocalPlayer (copy), u8 (ref), u5 (ref), Players (copy), u10 (ref), addPartyMember (copy)
    clearPartyClones();

    if p25 then
        u13 = #p25.members;
        u14 = p25.leader;
        u15 = p25.members;
        local v26 = 9;

        for _, v in p25.members do
            local v27 = v.Name == LocalPlayer.Name;
            addPartyMember(v.Name, v.DisplayName or v.Name, v.UserId, v27 and 10 or v26, v.Name == p25.leader, v27, true);

            if not v27 then
                v26 = v26 - 1;
            end;
        end;

        u10.Visible = u13 < 5;

        return;
    end;

    u13 = 1;
    u14 = nil;
    u15 = nil;
    local Name = LocalPlayer.Name;
    local DisplayName = LocalPlayer.DisplayName;
    local UserId = LocalPlayer.UserId;
    local u28 = u8:Clone();
    u28.Name = "Member_" .. UserId;
    u28.LayoutOrder = 10;
    u28.Visible = true;
    u28:SetAttribute("IsClone", true);
    u28.Parent = u5;
    u28.PlayerName.Text = Name;
    u28.DisplayName.Text = DisplayName or Name;
    u28.PartyLeader.Visible = false;
    task.spawn(function() -- Line: 56
        -- upvalues: Players (ref), UserId (copy), u28 (copy)
        local success, result = pcall(function() -- Line: 57
            -- upvalues: Players (ref), UserId (ref)
            return Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
        end);

        if success and (result and u28.Parent) then
            u28.Player.profilepic.Image = result;
        end;
    end);
    u28.ActionButton.Visible = false;
    u10.Visible = true;
end;

local function clearPlayersList() -- Line: 129
    -- upvalues: u7 (ref)
    for _, child in u7:GetChildren() do
        if child:IsA("Frame") and child:GetAttribute("IsClone") then
            child:Destroy();
        end;
    end;
end;

local function showModesPage() -- Line: 137
    -- upvalues: u7 (ref), u6 (ref), u11 (ref), u12 (ref)
    u7.Visible = false;
    u6.Visible = true;

    if u11 then
        u11.Visible = true;
    end;

    if u12 then
        u12.Visible = false;
    end;
end;

local function addPlayerToList(u29) -- Line: 144
    -- upvalues: LocalPlayer (copy), u9 (ref), u7 (ref), Players (copy), u14 (ref), u2 (ref), u6 (ref), u11 (ref), u12 (ref)
    if u29 == LocalPlayer then
        return;
    end;

    local u30 = u9:Clone();
    u30.Name = "Player_" .. u29.UserId;
    u30.Visible = true;
    u30:SetAttribute("IsClone", true);
    u30:SetAttribute("UserId", u29.UserId);
    u30.Parent = u7;
    u30.PlayerName.Text = u29.Name;
    u30.Nickname.Text = u29.DisplayName;
    task.spawn(function() -- Line: 157
        -- upvalues: Players (ref), u29 (copy), u30 (copy)
        local success, result = pcall(function() -- Line: 158
            -- upvalues: Players (ref), u29 (ref)
            return Players:GetUserThumbnailAsync(u29.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
        end);

        if success and (result and u30.Parent) then
            u30.Player.profilepic.Image = result;
        end;
    end);
    local Invite = u30:FindFirstChild("Invite");

    if Invite then
        Invite.Visible = not u14 or u14 == LocalPlayer.Name;
        Invite.Activated:Connect(function() -- Line: 170
            -- upvalues: u2 (ref), u29 (copy), u7 (ref), u6 (ref), u11 (ref), u12 (ref)
            u2:InviteToParty(u29);
            u7.Visible = false;
            u6.Visible = true;

            if u11 then
                u11.Visible = true;
            end;

            if u12 then
                u12.Visible = false;
            end;
        end);
    end;
end;

local function populatePlayersList() -- Line: 177
    -- upvalues: clearPlayersList (copy), Players (copy), addPlayerToList (copy)
    clearPlayersList();

    for _, v in Players:GetPlayers() do
        addPlayerToList(v);
    end;
end;

local function showPlayersPage() -- Line: 184
    -- upvalues: clearPlayersList (copy), Players (copy), addPlayerToList (copy), u6 (ref), u7 (ref), u11 (ref), u12 (ref)
    clearPlayersList();

    for _, v in Players:GetPlayers() do
        addPlayerToList(v);
    end;

    u6.Visible = false;
    u7.Visible = true;

    if u11 then
        u11.Visible = false;
    end;

    if u12 then
        u12.Visible = true;
    end;
end;

function v1.GetSize(p31) -- Line: 192
    -- upvalues: u13 (ref)
    return u13;
end;

function v1.IsLeader(p32) -- Line: 196
    -- upvalues: u14 (ref), LocalPlayer (copy)
    return not u14 and true or u14 == LocalPlayer.Name;
end;

function v1.GetMembers(p33) -- Line: 201
    -- upvalues: u15 (ref)
    return u15;
end;

function v1.KnitStart(p34) -- Line: 205
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), PlayerGui (copy), u4 (ref), ReplicatedStorage (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), clearPlayersList (copy), Players (copy), addPlayerToList (copy), clearPartyClones (copy), u14 (ref), u15 (ref), LocalPlayer (copy), Popup (copy), updatePartyDisplay (copy), TweenService (copy)
    u2 = Knit.GetService("PartyService");
    u3 = PlayerGui:WaitForChild("Modes");
    u4 = u3:WaitForChild("Frame");
    local InviteList = PlayerGui:WaitForChild("InviteList");
    local InviteList2 = InviteList.Frame.InviteList;
    ReplicatedStorage.Loaded.OnClientEvent:Once(function() -- Line: 214
        -- upvalues: InviteList (copy)
        InviteList.Enabled = true;
    end);
    local Invite = InviteList2:FindFirstChild("Invite");

    if Invite then
        Invite.Visible = false;
    end;

    u5 = u4:WaitForChild("Party");
    u6 = u4:WaitForChild("Modes");
    u7 = u4:WaitForChild("Players");
    u8 = u5:WaitForChild("PartyLeader");
    u8.Visible = false;
    local v35 = false;

    for _, child in u7:GetChildren() do
        if child:IsA("Frame") and (child.Name == "Player" and not v35) then
            u9 = child;
            child.Visible = false;
            v35 = true;
        elseif child:IsA("Frame") and child.Name == "Player" then
            child:Destroy();
        end;
    end;

    u10 = u5:WaitForChild("Add");
    u11 = u4:FindFirstChild("Close");
    u12 = u4:FindFirstChild("Return");

    if u12 then
        u12.Visible = false;
        u12.Activated:Connect(function() -- Line: 244
            -- upvalues: u7 (ref), u6 (ref), u11 (ref), u12 (ref)
            u7.Visible = false;
            u6.Visible = true;

            if u11 then
                u11.Visible = true;
            end;

            if u12 then
                u12.Visible = false;
            end;
        end);
    end;

    u10.Activated:Connect(function() -- Line: 249
        -- upvalues: u13 (ref), clearPlayersList (ref), Players (ref), addPlayerToList (ref), u6 (ref), u7 (ref), u11 (ref), u12 (ref)
        if u13 >= 5 then
            return;
        end;

        clearPlayersList();

        for _, v in Players:GetPlayers() do
            addPlayerToList(v);
        end;

        u6.Visible = false;
        u7.Visible = true;

        if u11 then
            u11.Visible = false;
        end;

        if u12 then
            u12.Visible = true;
        end;
    end);
    Players.PlayerAdded:Connect(function(p36) -- Line: 254
        -- upvalues: u7 (ref), addPlayerToList (ref)
        if u7.Visible then
            addPlayerToList(p36);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p37) -- Line: 260
        -- upvalues: u7 (ref)
        local v38 = u7:FindFirstChild("Player_" .. p37.UserId);

        if v38 then
            v38:Destroy();
        end;
    end);
    clearPartyClones();
    u13 = 1;
    u14 = nil;
    u15 = nil;
    local Name = LocalPlayer.Name;
    local DisplayName = LocalPlayer.DisplayName;
    local UserId = LocalPlayer.UserId;
    local u39 = u8:Clone();
    u39.Name = "Member_" .. UserId;
    u39.LayoutOrder = 10;
    u39.Visible = true;
    u39:SetAttribute("IsClone", true);
    u39.Parent = u5;
    u39.PlayerName.Text = Name;
    u39.DisplayName.Text = DisplayName or Name;
    u39.PartyLeader.Visible = false;
    task.spawn(function() -- Line: 56
        -- upvalues: Players (ref), UserId (copy), u39 (copy)
        local success, result = pcall(function() -- Line: 57
            -- upvalues: Players (ref), UserId (ref)
            return Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
        end);

        if success and (result and u39.Parent) then
            u39.Player.profilepic.Image = result;
        end;
    end);
    u39.ActionButton.Visible = false;
    u10.Visible = true;
    u2.PartyUpdate:Connect(function(p40) -- Line: 269
        -- upvalues: u13 (ref), Popup (ref), LocalPlayer (ref), u15 (ref), updatePartyDisplay (ref)
        if p40 or u13 <= 1 then
            if p40 and u13 < #p40.members then
                if u13 <= 1 and (not u15 and p40.leader ~= LocalPlayer.Name) then
                    Popup.Popup(LocalPlayer, "You have joined the party");
                else
                    for _, v in p40.members do
                        local v41 = false;
                        local v42;

                        if u15 then
                            v42 = v;

                            for _, v2 in u15 do
                                if v2.Name == v42.Name then
                                    v41 = true;
                                    break;
                                end;
                            end;
                        else
                            v42 = v;
                        end;

                        if not v41 and v42.Name ~= LocalPlayer.Name then
                            Popup.Popup(LocalPlayer, v42.Name .. " has joined the party");
                        end;
                    end;
                end;
            elseif p40 and (#p40.members < u13 and u15) then
                for _, v in u15 do
                    local v43 = v;
                    local v44 = false;

                    for _, v2 in p40.members do
                        if v43.Name == v2.Name then
                            v44 = true;
                            break;
                        end;
                    end;

                    if not v44 then
                        Popup.Popup(LocalPlayer, v43.Name .. " left the party");
                    end;
                end;
            end;
        else
            Popup.Popup(LocalPlayer, "Party disbanded");
        end;

        updatePartyDisplay(p40);
    end);
    local u45 = {};

    local function removeInvite(p46) -- Line: 310
        -- upvalues: u45 (copy)
        local v47 = u45[p46];

        if v47 then
            v47.frame:Destroy();
            u45[p46] = nil;
        end;
    end;

    local function createInviteUI(p48) -- Line: 318
        -- upvalues: u45 (copy), InviteList2 (copy), TweenService (ref), u2 (ref), Popup (ref), LocalPlayer (ref)
        local from = p48.from;
        local fromUserId = p48.fromUserId;
        local v49 = u45[from] and u45[from];

        if v49 then
            v49.frame:Destroy();
            u45[from] = nil;
        end;

        local v50 = InviteList2;
        local Invite2 = v50:FindFirstChild("Invite");

        if not Invite2 then
            return;
        end;

        local u51 = Invite2:Clone();
        u51.Name = "Invite_" .. from;
        u51.Visible = true;
        u51.Nickname.Text = from;
        u51.Parent = v50;
        task.spawn(function() -- Line: 336
            -- upvalues: fromUserId (copy), u51 (copy)
            local success, result = pcall(function() -- Line: 337
                -- upvalues: fromUserId (ref)
                return game.Players:GetUserThumbnailAsync(fromUserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
            end);

            if success and u51.Parent then
                u51.Player.profilepic.Image = result;
            end;
        end);
        local ActualBar = u51.Bar.ActualBar;
        local Size = ActualBar.Size;
        ActualBar.Size = UDim2.new(1, 0, Size.Y.Scale, Size.Y.Offset);
        local v52 = TweenService:Create(ActualBar, TweenInfo.new(15, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
        });
        v52:Play();
        u45[from] = {
            frame = u51,
            tween = v52
        };
        local u53 = false;
        u51.Accept.Activated:Connect(function() -- Line: 357
            -- upvalues: u53 (ref), u2 (ref), from (copy), u45 (ref)
            if u53 then
                return;
            end;

            u53 = true;
            u2:AcceptInvite();
            local v54 = from;
            local v55 = u45[v54];

            if v55 then
                v55.frame:Destroy();
                u45[v54] = nil;
            end;
        end);
        u51.Decline.Activated:Connect(function() -- Line: 364
            -- upvalues: u53 (ref), u2 (ref), from (copy), u45 (ref), Popup (ref), LocalPlayer (ref)
            if u53 then
                return;
            end;

            u53 = true;
            u2:DeclineInvite();
            local v56 = from;
            local v57 = u45[v56];

            if v57 then
                v57.frame:Destroy();
                u45[v56] = nil;
            end;

            Popup.Popup(LocalPlayer, "Declined " .. from .. "\'s invite");
        end);
        task.delay(15, function() -- Line: 372
            -- upvalues: from (copy), u45 (ref)
            local v58 = from;
            local v59 = u45[v58];

            if v59 then
                v59.frame:Destroy();
                u45[v58] = nil;
            end;
        end);
    end;

    u2.InviteReceived:Connect(function(p60) -- Line: 377
        -- upvalues: createInviteUI (copy)
        createInviteUI(p60);
    end);
    u2.InviteExpired:Connect(function(p61) -- Line: 381
        -- upvalues: u45 (copy)
        local v62 = u45[p61];

        if v62 then
            v62.frame:Destroy();
            u45[p61] = nil;
        end;
    end);
    p34:SetupModesHUD();
    local Modes = workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):FindFirstChild("Modes");
    local v63 = Modes and Modes:FindFirstChild("Rig");

    if v63 then
        local HumanoidRootPart = v63:FindFirstChild("HumanoidRootPart");
        local v64 = HumanoidRootPart and HumanoidRootPart:FindFirstChild("ProximityPrompt");

        if v64 then
            v64.Triggered:Connect(function() -- Line: 395
                -- upvalues: u3 (ref), PlayerGui (ref), Knit (ref)
                u3.Enabled = not u3.Enabled;

                if u3.Enabled then
                    PlayerGui.HUD.Enabled = false;
                    local Controller = Knit.GetController("ModesController");

                    if Controller then
                        Controller:UpdateRankLabels();
                        Controller:UpdateLockStates();
                    end;
                else
                    PlayerGui.HUD.Enabled = true;
                end;
            end);
        end;
    end;
end;

function v1.SetupModesHUD(p65) -- Line: 414
    -- upvalues: PlayerGui (copy)
    local Modes = PlayerGui:WaitForChild("Modes");
    local Close = Modes.Frame:FindFirstChild("Close");

    if Close then
        Close.Activated:Connect(function() -- Line: 419
            -- upvalues: Modes (copy)
            Modes.Enabled = false;
        end);
    end;

    local InviteList = PlayerGui:FindFirstChild("InviteList");
    Modes:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 426
        -- upvalues: Modes (copy), PlayerGui (ref), InviteList (copy)
        if Modes.Enabled then
            PlayerGui.HUD.Enabled = false;

            if InviteList then
                InviteList.Enabled = true;
            end;
        else
            PlayerGui.HUD.Enabled = true;
        end;
    end);
end;

return v1;