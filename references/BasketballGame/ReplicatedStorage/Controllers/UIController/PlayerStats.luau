 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local PlayerInspection = require(ReplicatedStorage.Shared.Tables.StatsSettings).PlayerInspection;
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local v3 = Knit.CreateController({
    Name = "PlayerStatsController"
});
local u4 = {
    Level = "Level",
    Points = "Points",
    Assists = "Assists",
    ["3Pointers"] = "Points3",
    Blocks = "Blocks",
    MatchesPlayed = "Matches",
    Dunks = "Dunks",
    AnkleBreakers = "AnkleBreaks",
    Mvp = "MVP"
};

local function formatNumber(p5) -- Line: 35
    local math_floor_ret = math.floor(p5);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function setBadge(p6, p7, p8) -- Line: 40
    -- upvalues: Rarities (copy)
    local v9 = p8[p7];
    local v10 = v9 and Rarities.Colors[v9.Rarity] or Color3.new(1, 1, 1);

    if v9 then
        p7 = v9.UIName or (v9.Name or p7);
    end;

    p6.ZoneName.Text = p7;
    p6.ImageColor3 = v10;
    p6.ImageLabel.ImageColor3 = v10;
end;

function v3.IsAvailable(p11, p12) -- Line: 48
    -- upvalues: Players (copy), LocalPlayer (copy), u1 (ref), PlayerInspection (copy)
    if p12.Parent ~= Players or (LocalPlayer.Team ~= game.Teams.Visitor or p12.Team ~= game.Teams.Visitor) then
        return false;
    end;

    if game.ReplicatedFirst.InLoadingScreen.Value or workspace:FindFirstChild("CamRig") then
        return false;
    end;

    if u1.FocusOpen and u1.FocusedUI ~= p11.UI then
        return false;
    end;

    local Spectate = LocalPlayer.PlayerGui:FindFirstChild("Spectate");

    if Spectate and Spectate.Enabled then
        return false;
    end;

    local Character = LocalPlayer.Character;
    local Character2 = p12.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    local v14;

    if Character2 then
        v14 = Character2:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character2;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character2 then
        Character2 = Character2:FindFirstChildOfClass("Humanoid");
    end;

    local v15;

    if v13 == nil or (v14 == nil or (Character == nil or (Character2 == nil or (Character.Health <= 0 or Character2.Health <= 0)))) then
        v15 = false;
    else
        v15 = (v13.Position - v14.Position).Magnitude <= PlayerInspection.Distance;
    end;

    return v15;
end;

function v3.Render(u16, u17) -- Line: 74
    -- upvalues: Styles (copy), Rarities (copy), Zones (copy), LocalPlayer (copy)
    local Contents = u16.UI.Holder.Contents;
    Contents.NameFrame.DisplayName.Text = u17.DisplayName;
    Contents.NameFrame.Username.Text = `@{u17.Username}`;
    Contents.PlayerCardHolder.PlayerRender.Image = `rbxthumb://type=AvatarHeadShot&id={u17.UserId}&w=420&h=420`;
    Contents.OvrLogo.Amount.Text = tostring(u17.Overall);
    local EquippedStyle = Contents.EquippedStyle;
    local Style = u17.Style;
    local v18 = Styles.Styles[Style];
    local v19 = v18 and Rarities.Colors[v18.Rarity] or Color3.new(1, 1, 1);

    if v18 then
        Style = v18.UIName or (v18.Name or Style);
    end;

    EquippedStyle.ZoneName.Text = Style;
    EquippedStyle.ImageColor3 = v19;
    EquippedStyle.ImageLabel.ImageColor3 = v19;
    local EquippedZone = Contents.EquippedZone;
    local Zone = u17.Zone;
    local v20 = Zones.Zones[Zone];
    local v21 = v20 and Rarities.Colors[v20.Rarity] or Color3.new(1, 1, 1);

    if v20 then
        Zone = v20.UIName or (v20.Name or Zone);
    end;

    EquippedZone.ZoneName.Text = Zone;
    EquippedZone.ImageColor3 = v21;
    EquippedZone.ImageLabel.ImageColor3 = v21;

    for i, v in pairs(u16.Amounts) do
        local v22;

        if i == "Level" then
            v22 = u17.Level;
        else
            v22 = u17.Statistics[i];
        end;

        local math_floor_ret = math.floor(v22);
        v.Text = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    local Icons = Contents.NameFrame.Icons;
    Icons.Premium.Visible = u17.IsPremium;
    Icons.Verified.Visible = u17.IsVerified;
    Icons.Friend.Visible = u16.Friend == u17.UserId;

    if u16.BadgeUserId ~= u17.UserId then
        u16.BadgeUserId = u17.UserId;
        u16.Friend = nil;
        Icons.Friend.Visible = false;

        if u17.UserId ~= LocalPlayer.UserId then
            task.spawn(function() -- Line: 96
                -- upvalues: LocalPlayer (ref), u17 (copy), u16 (copy), Icons (copy)
                local success, result = pcall(LocalPlayer.IsFriendsWith, LocalPlayer, u17.UserId);

                if u16.Target and (u16.Target.UserId == u17.UserId and u16.BadgeUserId == u17.UserId) then
                    local v23;

                    if success and result then
                        v23 = u17.UserId;
                    else
                        v23 = nil;
                    end;

                    u16.Friend = v23;
                    Icons.Friend.Visible = u16.Friend ~= nil;
                end;
            end);
        end;
    end;
end;

function v3.ClearView(p24) -- Line: 107
    -- upvalues: ContextActionService (copy)
    p24.RequestId = p24.RequestId + 1;
    p24.Pending = false;
    p24.Target = nil;
    ContextActionService:UnbindAction("ClosePlayerStats");
end;

function v3.Close(p25) -- Line: 114
    -- upvalues: u1 (ref)
    p25:ClearView();

    if u1.FocusedUI == p25.UI then
        u1:Focus(false);

        return;
    end;

    p25.Gui.Enabled = false;
end;

function v3.Inspect(u26, u27, u28) -- Line: 123
    -- upvalues: PlayerInspection (copy), Effects (copy), u2 (ref), u1 (ref), ContextActionService (copy)
    if u26.Pending or not u26:IsAvailable(u27) then
        return;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - u26.LastRequest < PlayerInspection.RequestInterval then
        return;
    end;

    u26.LastRequest = os_clock_ret;
    u26.RequestId = u26.RequestId + 1;
    local RequestId = u26.RequestId;
    u26.Pending = true;
    u26:UpdateHover(nil);
    task.delay(5, function() -- Line: 137
        -- upvalues: u26 (copy), RequestId (copy), u28 (copy), Effects (ref)
        if u26.RequestId ~= RequestId or not u26.Pending then
            return;
        end;

        u26:ClearView();

        if u28 then
            u26:Close();

            return;
        end;

        Effects:Popup("Couldn\'t load that player\'s stats. Please try again.");
    end);
    task.spawn(function() -- Line: 149
        -- upvalues: u2 (ref), u27 (copy), u26 (copy), RequestId (copy), u28 (copy), Effects (ref), u1 (ref), ContextActionService (ref)
        local v29, v30, v31 = pcall(u2.GetPublicStats, u2, u27);

        if u26.RequestId ~= RequestId then
            return;
        end;

        u26.Pending = false;

        if not u26:IsAvailable(u27) then
            if u28 then
                u26:Close();
            end;

            return;
        end;

        if not v29 or v30 == nil then
            if u28 then
                u26:Close();

                return;
            end;

            Effects:Popup(v29 and v31 and v31 or "Couldn\'t load that player\'s stats. Please try again.");

            return;
        end;

        u26.Target = u27;
        u26.RefreshAt = os.clock() + 2;
        u26:Render(v30);

        if not u28 then
            u1:Focus(true, u26.UI);
            u26.Gui.Enabled = true;
            ContextActionService:BindActionAtPriority("ClosePlayerStats", function(p32, p33) -- Line: 174
                -- upvalues: u26 (ref)
                if p33 == Enum.UserInputState.Begin then
                    u26:Close();
                end;

                return Enum.ContextActionResult.Sink;
            end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB);
        end;
    end);
end;

function v3.BindPlayer(u34, u35) -- Line: 182
    -- upvalues: LocalPlayer (copy), Trove (copy), Players (copy), PlayerInspection (copy)
    if u35 == LocalPlayer or u34.Players[u35] then
        return;
    end;

    local v36 = Trove.new();
    local u37 = v36:Add(Trove.new());
    u34.Players[u35] = v36;

    local function bindCharacter(p38) -- Line: 190
        -- upvalues: u37 (copy), u35 (copy), Players (ref), PlayerInspection (ref), u34 (copy)
        u37:Clean();
        local HumanoidRootPart = p38:WaitForChild("HumanoidRootPart", 10);

        if not (HumanoidRootPart and (u35.Character == p38 and u35.Parent == Players)) then
            return;
        end;

        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt.Name = "ViewPlayerStats";
        ProximityPrompt.ActionText = "View Stats";
        ProximityPrompt.ObjectText = u35.DisplayName;
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
        ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX;
        ProximityPrompt.HoldDuration = 0;
        ProximityPrompt.MaxActivationDistance = PlayerInspection.Distance;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.ClickablePrompt = true;
        ProximityPrompt.Enabled = false;
        ProximityPrompt.Parent = HumanoidRootPart;
        u37:Add(ProximityPrompt);
        u34.Prompts[u35] = ProximityPrompt;
        u37:Add(function() -- Line: 212
            -- upvalues: u34 (ref), u35 (ref), ProximityPrompt (copy)
            if u34.Prompts[u35] == ProximityPrompt then
                u34.Prompts[u35] = nil;
            end;
        end);
        u37:Connect(ProximityPrompt.Triggered, function() -- Line: 215
            -- upvalues: u34 (ref), u35 (ref)
            u34:Inspect(u35);
        end);
    end;

    v36:Connect(u35.CharacterAdded, bindCharacter);
    v36:Connect(u35.CharacterRemoving, function() -- Line: 221
        -- upvalues: u37 (copy), u34 (copy), u35 (copy)
        u37:Clean();

        if u34.Target == u35 then
            u34:Close();
        end;
    end);

    if u35.Character then
        task.spawn(bindCharacter, u35.Character);
    end;
end;

local function getPlayerFromPart(p39) -- Line: 230
    -- upvalues: Players (copy), LocalPlayer (copy)
    while p39 and p39 ~= workspace do
        if p39:IsA("Model") then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p39);

            if PlayerFromCharacter and PlayerFromCharacter ~= LocalPlayer then
                return PlayerFromCharacter;
            end;
        end;

        p39 = p39.Parent;
    end;
end;

function v3.SelectPart(p40, p41) -- Line: 242
    -- upvalues: getPlayerFromPart (copy)
    local v42 = getPlayerFromPart(p41);

    if v42 then
        p40:Inspect(v42);
    end;
end;

function v3.UpdateHover(p43, p44) -- Line: 247
    -- upvalues: getPlayerFromPart (copy), UserInputService (copy)
    local v45 = getPlayerFromPart(p44);
    local v46;

    if v45 and not (p43.Gui.Enabled or (p43.Pending or not (p43.WindowFocused and (not p43.HoverInputBlocked and (UserInputService.MouseEnabled and p43:IsAvailable(v45)))))) then
        v46 = v45.Character;
    else
        v46 = nil;
    end;

    if p43.HoverHighlight.Adornee == v46 then
        return;
    end;

    p43.HoverHighlight.Adornee = v46;
    p43.HoverHighlight.Enabled = v46 ~= nil;
end;

function v3.KnitStart(u47) -- Line: 257
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), LocalPlayer (copy), u4 (copy), Trove (copy), UserInputService (copy), Players (copy), RunService (copy)
    u1 = Knit.GetController("UIController");
    u2 = Knit.GetService("StatsService");
    u47.Gui = LocalPlayer.PlayerGui:WaitForChild("PlayerStats");
    u47.UI = u47.Gui.BG;
    u47.Players = {};
    u47.Prompts = {};
    u47.Amounts = {};
    u47.RequestId = 0;
    u47.LastRequest = (-1 / 0);
    u47.Pending = false;
    u47.WindowFocused = true;
    u47.HoverInputBlocked = false;
    u47.HoverHighlight = Instance.new("Highlight");
    u47.HoverHighlight.Name = "PlayerStatsHover";
    u47.HoverHighlight.FillColor = Color3.new(1, 1, 1);
    u47.HoverHighlight.OutlineColor = Color3.new(1, 1, 1);
    u47.HoverHighlight.FillTransparency = 0.92;
    u47.HoverHighlight.OutlineTransparency = 0.85;
    u47.HoverHighlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    u47.HoverHighlight.Enabled = false;
    u47.HoverHighlight.Parent = workspace;
    local ScrollingFrame = u47.UI.Holder.Contents.ScrollingFrame;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();

    for _, descendant in ipairs(ScrollingFrame:GetDescendants()) do
        local v48 = u4[descendant.Name];

        if v48 and descendant:FindFirstChild("TextFrame") then
            u47.Amounts[v48] = descendant.TextFrame.Amount;
        end;
    end;

    local Holder = u47.UI.Holder;
    local Size = Holder.Size;
    local u49 = Trove.new();

    local function bindCamera() -- Line: 293
        -- upvalues: u49 (copy), Holder (copy), UserInputService (ref), Size (copy)
        u49:Clean();
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        local function updateLayout() -- Line: 297
            -- upvalues: Holder (ref), UserInputService (ref), workspace_CurrentCamera (copy), Size (ref)
            local v50;

            if UserInputService.TouchEnabled and workspace_CurrentCamera.ViewportSize.Y < 500 then
                v50 = UDim2.fromScale(0.8, 0.76);
            else
                v50 = Size;
            end;

            Holder.Size = v50;
        end;

        u49:Connect(workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"), updateLayout);
        u49:Connect(UserInputService:GetPropertyChangedSignal("TouchEnabled"), updateLayout);
        local v51;

        if UserInputService.TouchEnabled and workspace_CurrentCamera.ViewportSize.Y < 500 then
            v51 = UDim2.fromScale(0.8, 0.76);
        else
            v51 = Size;
        end;

        Holder.Size = v51;
    end;

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(bindCamera);
    bindCamera();
    u47.UI.Holder.Header.CloseButton.Hitbox.Activated:Connect(function() -- Line: 308
        -- upvalues: u47 (copy)
        u47:Close();
    end);
    u47.UI.UIScale:GetPropertyChangedSignal("Scale"):Connect(function() -- Line: 311
        -- upvalues: u47 (copy), u1 (ref)
        if u47.UI.UIScale.Scale == 0 and not (u47.Target or (u47.Pending or u1.FocusedUI == u47.UI)) then
            u47.Gui.Enabled = false;
        end;
    end);
    u47.Gui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 316
        -- upvalues: u47 (copy), u1 (ref)
        if not u47.Gui.Enabled then
            u47:ClearView();

            if u1.FocusedUI == u47.UI then
                u1:Focus(false);
            end;
        end;
    end);
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 322
        -- upvalues: u47 (copy)
        u47:Close();
    end);
    local Mouse = LocalPlayer:GetMouse();
    UserInputService.InputChanged:Connect(function(p52, p53) -- Line: 327
        -- upvalues: u47 (copy), Mouse (copy)
        if p52.UserInputType == Enum.UserInputType.MouseMovement then
            u47.HoverInputBlocked = p53;
            u47:UpdateHover(Mouse.Target);
        end;
    end);
    UserInputService.WindowFocusReleased:Connect(function() -- Line: 333
        -- upvalues: u47 (copy)
        u47.WindowFocused = false;
        u47:UpdateHover(nil);
    end);
    UserInputService.WindowFocused:Connect(function() -- Line: 337
        -- upvalues: u47 (copy)
        u47.WindowFocused = true;
    end);
    UserInputService.InputEnded:Connect(function(p54, p55) -- Line: 340
        -- upvalues: u47 (copy), Mouse (copy)
        if not (u47.Gui.Enabled or (p55 or p54.UserInputType ~= Enum.UserInputType.MouseButton1)) then
            u47:SelectPart(Mouse.Target);
        end;
    end);
    UserInputService.TouchTapInWorld:Connect(function(p56, p57) -- Line: 345
        -- upvalues: u47 (copy), LocalPlayer (ref)
        if p57 or u47.Gui.Enabled then
            return;
        end;

        local v58 = workspace.CurrentCamera:ViewportPointToRay(p56.X, p56.Y);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = LocalPlayer.Character and { LocalPlayer.Character } or {};
        local v59 = workspace:Raycast(v58.Origin, v58.Direction * 200, RaycastParams_new_ret);

        if v59 then
            u47:SelectPart(v59.Instance);
        end;
    end);
    Players.PlayerAdded:Connect(function(p60) -- Line: 355
        -- upvalues: u47 (copy)
        u47:BindPlayer(p60);
    end);
    Players.PlayerRemoving:Connect(function(p61) -- Line: 358
        -- upvalues: u47 (copy)
        if u47.Target == p61 then
            u47:Close();
        end;

        local v62 = u47.Players[p61];

        if v62 then
            v62:Destroy();
        end;

        u47.Players[p61] = nil;
    end);

    for _, v in ipairs(Players:GetPlayers()) do
        u47:BindPlayer(v);
    end;

    local u63 = 0;
    RunService.Heartbeat:Connect(function(p64) -- Line: 369
        -- upvalues: u63 (ref), u47 (copy), Mouse (copy), u1 (ref)
        u63 = u63 + p64;

        if u63 < 0.2 then
            return;
        end;

        u63 = 0;
        u47:UpdateHover(Mouse.Target);

        for i, v in pairs(u47.Prompts) do
            local v65 = not u47.Gui.Enabled and u47:IsAvailable(i);
            v.Enabled = v65;
        end;

        if not u47.Target then
            return;
        end;

        if u1.FocusedUI ~= u47.UI then
            u47:ClearView();

            return;
        end;

        if u47:IsAvailable(u47.Target) then
            if os.clock() >= u47.RefreshAt then
                u47:Inspect(u47.Target, true);
            end;

            return;
        end;

        u47:Close();
    end);
end;

return v3;