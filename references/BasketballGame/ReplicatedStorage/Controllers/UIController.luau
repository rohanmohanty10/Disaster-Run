 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Teams = game:GetService("Teams");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local PlayerGui = LocalPlayer.PlayerGui;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local Jerseys = require(ReplicatedStorage.Shared.Tables.Jerseys);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local StatsSettings = require(ReplicatedStorage.Shared.Tables.StatsSettings);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.TopbarPlus);
require(ReplicatedStorage.Shared.Tables.KeybindIcons);
local Visitor = Teams.Visitor;
local GameValues = ReplicatedStorage.GameValues;
local u9 = Knit.CreateController({
    Name = "UIController"
});
local u10 = {
    Style = { LocalPlayer.PlayerGui.Style, true },
    Zone = { LocalPlayer.PlayerGui.Zone, true },
    Locker = { LocalPlayer.PlayerGui.Locker, true },
    Shop = { LocalPlayer.PlayerGui.Shop, false },
    Stats = { LocalPlayer.PlayerGui.Stats, false },
    Codes = { LocalPlayer.PlayerGui.Codes, false },
    Gamemodes = { LocalPlayer.PlayerGui.Gamemodes, true },
    DailyRewards = { LocalPlayer.PlayerGui.DailyRewards, false },
    PostMatch = { LocalPlayer.PlayerGui.PostMatch, true },
    Quests = { LocalPlayer.PlayerGui.Quests, true },
    DiscordRewards = { LocalPlayer.PlayerGui.DiscordRewards, true },
    SpinWheel = { LocalPlayer.PlayerGui.SpinWheel, true },
    ZoneQuests = { LocalPlayer.PlayerGui.ZoneQuests, true },
    StyleQuests = { LocalPlayer.PlayerGui.ZoneQuests, true }
};
u9.fromHUD = u10;
local u11 = { "Dunk", "Score", "Assist", "AnkleBreaker", "AnkleBroken", "AnkleBreakerNEW" };
local u12 = {
    Dunk = "%s (UNDER HOOP)",
    Shoot = "%s (HOLD)"
};

function u9.Heartbeat(p13) -- Line: 71
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), RunService (copy), u3 (ref), u4 (ref), u6 (ref), u5 (ref)
    local _ = LocalPlayer.PlayerGui.Mobile;
    local _ = LocalPlayer.PlayerGui.HUD;
    local InGame = LocalPlayer.PlayerGui.InGame;
    local Spectate = LocalPlayer.PlayerGui.Spectate;

    for i = 1, 4 do
        local v14 = ReplicatedStorage.Assets.UI.PassKeybind:Clone();
        v14.Name = tostring(i);
        v14.Visible = false;
        v14.Parent = InGame.PassKeybinds;
        local _ = i;
    end;

    local u15 = true;
    RunService.PreRender:Connect(function(p16) -- Line: 87
        -- upvalues: u3 (ref), u4 (ref), LocalPlayer (ref), u6 (ref), u15 (ref), u5 (ref)
        if not (u3.Player.Customization.Settings.KeybindPassing and (u4.GetPlatform() == "Keyboard" and (LocalPlayer.Team ~= game.Teams.Visitor and (LocalPlayer.Team ~= nil and u6:PlayerPossessesBall(LocalPlayer))))) then
            if u15 then
                u15 = false;

                for _, child in LocalPlayer.PlayerGui.InGame.PassKeybinds:GetChildren() do
                    child.Visible = false;
                end;
            end;

            return;
        end;

        u15 = true;

        for i = 1, 4 do
            local v17 = LocalPlayer.PlayerGui.InGame.PassKeybinds:FindFirstChild((tostring(i)));
            local TeammateFromKeybind = u5:GetTeammateFromKeybind(i);
            local v18;

            if TeammateFromKeybind then
                if LocalPlayer.Character == nil or (TeammateFromKeybind.Character:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude < 180 then
                    local v19 = workspace.CurrentCamera:WorldToViewportPoint(TeammateFromKeybind.Character.Head.Position + Vector3.new(0, 2, 0));

                    if v19.Z < 0 then
                        v17.Visible = false;
                        v18 = i;
                    else
                        v17.Position = UDim2.fromOffset(v19.X, v19.Y);
                        v17.Visible = true;
                        v18 = i;
                    end;
                else
                    v17.Visible = false;
                    v18 = i;
                end;
            else
                v17.Visible = false;
                v18 = i;
            end;
        end;
    end);

    local function updateTeam(u20) -- Line: 141
        -- upvalues: InGame (copy), Spectate (copy)
        return function() -- Line: 142
            -- upvalues: u20 (copy), InGame (ref), Spectate (ref)
            local v21 = game.Teams[u20]:GetAttribute("DisplayName"):upper();
            InGame.BG.Top[u20].TextLabel.Text = v21;
            Spectate.Top[u20].TextLabel.Text = v21;
        end;
    end;

    local u22 = "Home";
    game.Teams.Home:GetAttributeChangedSignal("DisplayName"):Connect(function() -- Line: 142
        -- upvalues: u22 (copy), InGame (copy), Spectate (copy)
        local v23 = game.Teams[u22]:GetAttribute("DisplayName"):upper();
        InGame.BG.Top[u22].TextLabel.Text = v23;
        Spectate.Top[u22].TextLabel.Text = v23;
    end);
    local u24 = "Away";
    game.Teams.Away:GetAttributeChangedSignal("DisplayName"):Connect(function() -- Line: 142
        -- upvalues: u24 (copy), InGame (copy), Spectate (copy)
        local v25 = game.Teams[u24]:GetAttribute("DisplayName"):upper();
        InGame.BG.Top[u24].TextLabel.Text = v25;
        Spectate.Top[u24].TextLabel.Text = v25;
    end);
end;

function u9.UpdateControlsUI() -- Line: 211
    -- upvalues: PlayerGui (copy), u4 (ref), LocalPlayer (copy), Visitor (copy), u7 (ref), u3 (ref), u12 (copy)
    local Mobile = PlayerGui.Mobile;
    local Controls = PlayerGui.InGame.BG.Controls;
    local Bottom = PlayerGui.InGame.BG.Bottom;
    local PassKeybinds = PlayerGui.InGame.PassKeybinds;
    local Platform = u4.GetPlatform();
    local v26 = Platform == "Touchscreen";
    local v27;

    if v26 then
        if LocalPlayer.Team == Visitor then
            v27 = false;
        else
            v27 = not u7:CutsceneEndedLessThanXSecondsAgo(0);
        end;
    else
        v27 = v26;
    end;

    local v28 = not v27 and u3.Player.Customization.Settings.ControlsManual;
    Mobile.Enabled = v27;
    Controls.Visible = v28;

    if v26 then
        return;
    end;

    for _, child in Controls:GetChildren() do
        if child:IsA("Frame") then
            local Name = child.Name;
            child.KeyIcon.Image = u4.GetKeybindIcon(Name);
            local KeyText = child.KeyText;
            local string_upper = string.upper;

            if u12[Name] then
                Name = string.format(u12[Name], Name) or Name;
            end;

            KeyText.Text = string_upper(Name);
        end;
    end;

    for i = 1, 3 do
        Bottom[`Ability{i}`].KeybindIcon.Image = u4.GetKeybindIcon((`Ability {i}`));
        local _ = i;
    end;

    if Platform ~= "Keyboard" then
        return;
    end;

    for i = 1, 4 do
        PassKeybinds[tostring(i)].Image = u4.GetKeybindIcon((`Pass Teammate {i}`));
        local _ = i;
    end;
end;

function u9.InitializeControlKeybindUIs(p29) -- Line: 257
    -- upvalues: u7 (ref), u4 (ref), u8 (ref), LocalPlayer (copy)
    u7:OnCutsceneStateChangedConnect(p29.UpdateControlsUI, false);
    u4:OnPlatformChangedConnect(p29.UpdateControlsUI, false);
    u8.KeybindsChanged:Connect(p29.UpdateControlsUI);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(p29.UpdateControlsUI);
    p29.UpdateControlsUI();
end;

function u9.InitializeMobileBallUI(p30) -- Line: 268
    -- upvalues: PlayerGui (copy), u6 (ref), LocalPlayer (copy)
    local Mobile = PlayerGui.Mobile;
    local NoBall = Mobile.NoBall;
    local Ball = Mobile.Ball;
    u6:OnPlayerPossessingBallChangedConnect(function(p31) -- Line: 273
        -- upvalues: NoBall (copy), LocalPlayer (ref), Ball (copy)
        NoBall.Visible = p31 ~= LocalPlayer;
        Ball.Visible = p31 == LocalPlayer;
    end);
end;

function u9.InitializeScoreboardUIs(p32) -- Line: 279
    -- upvalues: GameValues (copy), PlayerGui (copy)
    local Away = GameValues.Away;
    local Home = GameValues.Home;
    local InGame = PlayerGui.InGame;
    local Spectate = PlayerGui.Spectate;
    local Txt = InGame.BG.Top.Away.ScoreBoard.Txt;
    local Txt2 = InGame.BG.Top.Home.ScoreBoard.Txt;
    local Txt3 = Spectate.Top.Away.ScoreBoard.Txt;
    local Txt4 = Spectate.Top.Home.ScoreBoard.Txt;

    local function updateAwayScoreboardText(p33) -- Line: 292
        -- upvalues: Txt (copy), Txt3 (copy)
        local v34 = tostring(p33);
        Txt.Text = v34;
        Txt3.Text = v34;
    end;

    local function updateHomeScoreboardText(p35) -- Line: 298
        -- upvalues: Txt2 (copy), Txt4 (copy)
        local v36 = tostring(p35);
        Txt2.Text = v36;
        Txt4.Text = v36;
    end;

    Away:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 305
        -- upvalues: Away (copy), Txt (copy), Txt3 (copy)
        local v37 = tostring(Away.Value);
        Txt.Text = v37;
        Txt3.Text = v37;
    end);
    Home:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 309
        -- upvalues: Home (copy), Txt2 (copy), Txt4 (copy)
        local v38 = tostring(Home.Value);
        Txt2.Text = v38;
        Txt4.Text = v38;
    end);
    local v39 = tostring(Away.Value);
    Txt.Text = v39;
    Txt3.Text = v39;
    local v40 = tostring(Home.Value);
    Txt2.Text = v40;
    Txt4.Text = v40;
end;

function u9.InitializeTimerUIs(p41) -- Line: 317
    -- upvalues: GameValues (copy), PlayerGui (copy), RunService (copy), Essentials (copy)
    local State = GameValues.State;
    local Timer = GameValues.Timer;
    local Timer2 = PlayerGui.HUD.MatchTimer.Timer;
    local Timer3 = PlayerGui.InGame.BG.TimerBG.MatchTimer.Timer;
    local Timer4 = PlayerGui.Spectate.TimerBG.MatchTimer.Timer;
    local workspace_Court = workspace.Court;
    local Val = workspace_Court.Timer1.UI.Val;
    local Val2 = workspace_Court.Timer2.UI.Val;
    local u42 = 0;
    RunService.Heartbeat:Connect(function(p43) -- Line: 334
        -- upvalues: u42 (ref), Essentials (ref), Timer (copy), State (copy), Timer2 (copy), Timer3 (copy), Timer4 (copy), Val (copy), Val2 (copy)
        u42 = u42 + p43;

        if u42 < 0.25 then
            return;
        end;

        u42 = 0;
        local v44 = Essentials:formatTime(Timer.Value);
        local v45 = State.Value == "Playing";
        Timer2.Text = v45 and "MATCH STARTED!" or v44;
        Timer3.Text = v44;
        Timer4.Text = v44;

        if v45 then
            Val.Text = v44;
            Val2.Text = v44;
        end;
    end);
end;

function u9.ScaleAll(p46) -- Line: 366
    -- upvalues: TweenService (copy), SfxManager (copy), LocalPlayer (copy)
    local u47 = {};
    local u48 = {};
    local u49 = {};

    local function animateButton(u50) -- Line: 371
        -- upvalues: u47 (copy), TweenService (ref), SfxManager (ref), u48 (copy), u49 (copy)
        if u50:IsA("ImageButton") == false and not u50:IsA("TextButton") then
            return;
        end;

        local v51 = u50:FindFirstAncestorWhichIsA("ScreenGui");

        if v51 and (v51.Name == "TouchGui" or (string.find(string.lower(v51.Name), "topbar") or (v51:HasTag("AnimationExempt") or u50:HasTag("AnimationExempt")))) then
            return;
        end;

        local Size = u50.Size;
        local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
        u47[u50] = u50.MouseEnter:Connect(function() -- Line: 384
            -- upvalues: TweenService (ref), u50 (copy), TweenInfo_new_ret (copy), Size (copy), SfxManager (ref)
            TweenService:Create(u50, TweenInfo_new_ret, {
                Size = UDim2.new(Size.X.Scale * 1.075, 0, Size.Y.Scale * 1.075, 0)
            }):Play();
            SfxManager:playSound({
                Sound = "HoverUI",
                Parent = workspace
            });
        end);
        u48[u50] = u50.MouseLeave:Connect(function() -- Line: 389
            -- upvalues: TweenService (ref), u50 (copy), TweenInfo_new_ret (copy), Size (copy)
            TweenService:Create(u50, TweenInfo_new_ret, {
                Size = Size
            }):Play();
        end);
        u49[u50] = u50.MouseButton1Click:Connect(function() -- Line: 393
            -- upvalues: TweenService (ref), u50 (copy), TweenInfo_new_ret (copy), Size (copy), SfxManager (ref)
            TweenService:Create(u50, TweenInfo_new_ret, {
                Size = UDim2.new(Size.X.Scale * 0.9, 0, Size.Y.Scale * 0.9, 0)
            }):Play();
            task.delay(0.25, function() -- Line: 395
                -- upvalues: TweenService (ref), u50 (ref), TweenInfo_new_ret (ref), Size (ref)
                TweenService:Create(u50, TweenInfo_new_ret, {
                    Size = Size
                }):Play();
            end);
            SfxManager:playSound({
                Sound = "Click",
                Parent = workspace
            });
        end);
    end;

    for _, descendant in LocalPlayer.PlayerGui:GetDescendants() do
        animateButton(descendant);
    end;

    LocalPlayer.PlayerGui.DescendantAdded:Connect(function(p52) -- Line: 406
        -- upvalues: animateButton (copy)
        animateButton(p52);
    end);
    LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(p53) -- Line: 410
        -- upvalues: u47 (copy), u49 (copy), u48 (copy)
        if u47[p53] then
            u47[p53]:Disconnect();
            u47[p53] = nil;
        end;

        if u49[p53] then
            u49[p53]:Disconnect();
            u49[p53] = nil;
        end;

        if u48[p53] then
            u48[p53]:Disconnect();
            u48[p53] = nil;
        end;
    end);
end;

function u9.Focus(p54, p55, p56, p57) -- Line: 417
    -- upvalues: TweenService (copy), LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if p55 then
        if p54.FocusOpen then
            p54:Focus(false, p56, true);
        else
            local StatBlur = p54.StatBlur;

            if not StatBlur then
                StatBlur = Instance.new("BlurEffect");
                StatBlur.Parent = game.Lighting;
                p54.StatBlur = StatBlur;
            end;

            StatBlur.Size = 0;
            TweenService:Create(StatBlur, TweenInfo.new(0.3), {
                Size = 15
            }):Play();
        end;

        if p56 and p56:FindFirstChild("UIScale") then
            local UIScale = p56.UIScale;
            UIScale.Scale = 0;
            TweenService:Create(UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
                Scale = 1
            }):Play();
        end;

        if p56 and p56:GetAttribute("FadeContents") then
            local Holder = p56:FindFirstChild("Holder");
            Holder.GroupTransparency = 1;
            TweenService:Create(Holder, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
                GroupTransparency = 0
            }):Play();
        end;

        p54.FocusedUI = p56;
        LocalPlayer:SetAttribute("Focused", true);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            FieldOfView = 90
        }):Play();
    else
        if not p54.FocusOpen then
            return;
        end;

        if p54.FocusedUI and p54.FocusedUI:FindFirstChild("UIScale") then
            local v58;

            if p56 then
                v58 = p56:FindFirstAncestorWhichIsA("ScreenGui");
            else
                v58 = p56;
            end;

            local FocusedUI = p54.FocusedUI;

            if FocusedUI:GetAttribute("FadeContents") then
                TweenService:Create(FocusedUI.Holder, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
                    GroupTransparency = 1
                }):Play();
            end;

            local u59 = FocusedUI:FindFirstAncestorWhichIsA("ScreenGui");
            local UIScale = FocusedUI.UIScale;
            UIScale.Scale = 1;
            TweenService:Create(UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
                Scale = 0
            }):Play();

            if u59 then
                if u59 == v58 then
                    if FocusedUI ~= p56 then
                        task.delay(0.15, function() -- Line: 465
                            -- upvalues: UIScale (copy), FocusedUI (copy)
                            if math.round(UIScale.Scale * 100) / 100 == 0 then
                                FocusedUI.Visible = false;
                            end;
                        end);
                    end;
                else
                    task.delay(0.15, function() -- Line: 472
                        -- upvalues: UIScale (copy), u59 (copy)
                        if math.round(UIScale.Scale * 100) / 100 == 0 then
                            u59.Enabled = false;
                        end;
                    end);
                end;
            end;
        end;

        if not p57 then
            p54.FocusedUI = nil;
            LocalPlayer:SetAttribute("Focused", false);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
                FieldOfView = 63
            }):Play();
            local StatBlur = p54.StatBlur;

            if StatBlur then
                TweenService:Create(StatBlur, TweenInfo.new(0.3), {
                    Size = 0
                }):Play();
            end;
        end;
    end;

    p54.FocusOpen = p55;
end;

function u9.Alert(p60, u61, p62) -- Line: 496
    -- upvalues: TweenService (copy)
    local GlowOutline = u61:WaitForChild("GlowOutline");
    local UIScale = GlowOutline:WaitForChild("UIScale");
    local Alert = u61:WaitForChild("Alert");
    local Position = Alert.Position;

    if p62 then
        if u61:GetAttribute("Alert") then
            return;
        end;

        u61:SetAttribute("Alert", true);
        GlowOutline.Visible = true;
        Alert.Visible = true;
        Alert.Position = Position;
        task.spawn(function() -- Line: 523
            -- upvalues: u61 (copy), UIScale (copy), GlowOutline (copy), TweenService (ref)
            while u61.Parent and u61:GetAttribute("Alert") do
                UIScale.Scale = 0.5;
                GlowOutline.ImageTransparency = 1;
                TweenService:Create(UIScale, TweenInfo.new(0.72, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 0.9
                }):Play();
                TweenService:Create(GlowOutline, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 0.25
                }):Play();
                task.delay(0.62, function() -- Line: 536
                    -- upvalues: u61 (ref), TweenService (ref), GlowOutline (ref)
                    if u61:GetAttribute("Alert") then
                        return;
                    end;

                    TweenService:Create(GlowOutline, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    }):Play();
                end);
                task.wait(0.8);
            end;
        end);
        task.spawn(function() -- Line: 548
            -- upvalues: u61 (copy), TweenService (ref), Alert (copy), Position (copy)
            while u61.Parent and u61:GetAttribute("Alert") do
                local v63 = TweenService:Create(Alert, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - 0.05, Position.Y.Offset)
                });
                v63:Play();
                v63.Completed:Wait();

                if not u61:GetAttribute("Alert") then
                    break;
                end;

                local v64 = TweenService:Create(Alert, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Position = Position
                });
                v64:Play();
                v64.Completed:Wait();
            end;

            Alert.Position = Position;
        end);

        return;
    end;

    if not u61:GetAttribute("Alert") then
        return;
    end;

    u61:SetAttribute("Alert", nil);
    GlowOutline.Visible = false;
    GlowOutline.ImageTransparency = 1;
    UIScale.Scale = 0.5;
    Alert.Visible = false;
    Alert.Position = Position;
end;

function u9.HUD(u65) -- Line: 578
    -- upvalues: LocalPlayer (copy), u3 (ref), Essentials (copy), StatsSettings (copy), ReplicatedStorage (copy), TweenService (copy), Knit (copy), SfxManager (copy), RunService (copy), u10 (copy)
    local HUD = LocalPlayer.PlayerGui.HUD;
    local Buttons = HUD.Buttons;
    local Top = HUD.Top;
    local u66 = nil;
    local u67 = nil;
    local u68 = nil;

    local function renewHUD() -- Line: 587
        -- upvalues: u66 (ref), u3 (ref), u67 (ref), u68 (ref), Top (copy), Essentials (ref), StatsSettings (ref)
        if u66 == u3.Player.Money and (u67 == u3.Player.Level and u68 == u3.Player.Exp) then
            return;
        end;

        Top.Currency.Amount.Text = `${Essentials:formatNumberWithCommas(u3.Player.Money)}`;
        Top.Level.Lvl.Text = `Level {tostring(u3.Player.Level)}`;
        Top.Level.LevelBar.Fill.Size = UDim2.new(math.clamp(u3.Player.Exp / (u3.Player.Level * StatsSettings.Multiplier), 0, 1), 0, 1, 0);
        u67 = u3.Player.Level;
        u66 = u3.Player.Money;
        u68 = u3.Player.Exp;
    end;

    renewHUD();
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 601
        -- upvalues: renewHUD (copy)
        renewHUD();
    end);

    local function iconWiggle(p69) -- Line: 605
        -- upvalues: TweenService (ref)
        while p69.Parent do
            TweenService:Create(p69, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = 4
            }):Play();
            task.wait(0.8);
            TweenService:Create(p69, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = -4
            }):Play();
            task.wait(0.8);
        end;
    end;

    task.spawn(iconWiggle, Top.Currency.Icon);
    task.spawn(iconWiggle, Top.Level.Icon);
    Top.Currency.PlusButton.MouseButton1Down:Connect(function() -- Line: 624
        -- upvalues: Knit (ref), LocalPlayer (ref)
        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Shop"):FindFirstChild("BG"));
        LocalPlayer.PlayerGui.Shop.Enabled = true;
    end);
    local Position = Buttons.Position;
    local Position2 = Top.Position;
    HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 633
        -- upvalues: HUD (copy), Buttons (copy), Position (copy), Top (copy), Position2 (copy), TweenService (ref), SfxManager (ref)
        if HUD.Enabled then
            for _, child in Buttons:GetChildren() do
                if child:FindFirstChild("ImageButton") then
                    child.UIScale.Scale = 0;
                else
                    for _, child2 in child:GetChildren() do
                        if child2:IsA("Frame") ~= false and child2:FindFirstChild("ImageButton") then
                            child2.UIScale.Scale = 0;
                        end;
                    end;
                end;
            end;

            Buttons.Position = UDim2.new(Position.X.Scale, 0, 1.25, 0);
            Top.Position = UDim2.new(Position2.X.Scale, 0, -0.25, 0);
            TweenService:Create(Buttons, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = Position
            }):Play();
            TweenService:Create(Top, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = Position2
            }):Play();
            local v70 = {};

            for _, child in Buttons:GetChildren() do
                if child:IsA("Frame") ~= false then
                    table.insert(v70, child);
                end;
            end;

            table.sort(v70, function(p71, p72) -- Line: 663
                return p71.LayoutOrder < p72.LayoutOrder;
            end);

            for _, child in Buttons.Play:GetChildren() do
                if child:IsA("Frame") ~= false and child:FindFirstChild("ImageButton") then
                    TweenService:Create(child.UIScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                end;
            end;

            local v73 = table.find(v70, Buttons.Play) or math.ceil(#v70 / 2);
            SfxManager:playSound({
                Sound = "Appear",
                Parent = workspace
            }).PlaybackSpeed = 1;
            task.wait(0.075);
            local v74 = 0;

            for i = 1, #v70 do
                if HUD.Enabled == false then
                    return;
                end;

                local v75 = v70[v73 - i];
                local v76 = v70[v73 + i];

                if not (v75 or v76) then
                    break;
                end;

                v74 = v74 + 1;
                SfxManager:playSound({
                    Sound = "Appear",
                    Parent = workspace
                }).PlaybackSpeed = v74 * 0.03 + 1;

                if v75 then
                    TweenService:Create(v75.UIScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                end;

                if v76 then
                    TweenService:Create(v76.UIScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                end;

                task.wait(0.055);
                local _ = i;
            end;
        end;
    end);

    local function setupButton(p77) -- Line: 710
        -- upvalues: HUD (copy), RunService (ref), TweenService (ref), LocalPlayer (ref), u65 (copy), u10 (ref)
        local Parent = p77.Parent;
        local u78 = false;
        local u79 = false;

        if Parent.Name == "Play" then
            task.spawn(function() -- Line: 717
                -- upvalues: Parent (copy), HUD (ref), RunService (ref)
                local BgHighlight = Parent:WaitForChild("BgHighlight");
                local UIGradient = BgHighlight:WaitForChild("UIGradient");
                BgHighlight.ImageTransparency = 0;
                task.spawn(function() -- Line: 723
                    -- upvalues: Parent (ref), HUD (ref), RunService (ref), UIGradient (copy)
                    while Parent and Parent.Parent do
                        if HUD.Enabled then
                            local v80 = -0.22;

                            while v80 <= 1.22 and Parent.Parent do
                                v80 = v80 + RunService.Heartbeat:Wait() * 1.45;
                                UIGradient.Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 1),
                                    NumberSequenceKeypoint.new(math.clamp(v80 - 0.22, 0, 1), 1),
                                    NumberSequenceKeypoint.new(math.clamp(v80 - 0.17, 0, 1), 0.65),
                                    NumberSequenceKeypoint.new(math.clamp(v80, 0, 1), 0.15),
                                    NumberSequenceKeypoint.new(math.clamp(v80 + 0.17, 0, 1), 0.65),
                                    NumberSequenceKeypoint.new(math.clamp(v80 + 0.22, 0, 1), 1),
                                    NumberSequenceKeypoint.new(1, 1)
                                });
                            end;

                            task.wait(1);
                        else
                            task.wait(1);
                        end;
                    end;
                end);
            end);
        end;

        HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 760
            -- upvalues: HUD (ref), u78 (ref), u79 (ref), TweenService (ref), Parent (copy)
            if HUD.Enabled == false then
                u78 = false;
                u79 = false;
                TweenService:Create(Parent.UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();

                if Parent:FindFirstChild("Icon") then
                    TweenService:Create(Parent.Icon.UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Scale = 1
                    }):Play();
                end;
            end;
        end);
        p77.MouseEnter:Connect(function() -- Line: 772
            -- upvalues: u78 (ref), u79 (ref), TweenService (ref), Parent (copy)
            u78 = true;

            if u79 then
                return;
            end;

            TweenService:Create(Parent.UIScale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1.08
            }):Play();

            if Parent:FindFirstChild("Icon") then
                TweenService:Create(Parent.Icon.UIScale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1.18
                }):Play();
            end;
        end);
        p77.MouseLeave:Connect(function() -- Line: 782
            -- upvalues: u78 (ref), TweenService (ref), Parent (copy)
            u78 = false;
            TweenService:Create(Parent.UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();

            if Parent:FindFirstChild("Icon") then
                TweenService:Create(Parent.Icon.UIScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1
                }):Play();
            end;
        end);
        p77.MouseButton1Down:Connect(function() -- Line: 791
            -- upvalues: u79 (ref), TweenService (ref), Parent (copy), LocalPlayer (ref), HUD (ref), u65 (ref), u10 (ref)
            u79 = true;
            TweenService:Create(Parent.UIScale, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 0.98
            }):Play();

            if Parent:FindFirstChild("Icon") then
                TweenService:Create(Parent.Icon.UIScale, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = 1.04
                }):Play();
            end;

            if Parent.Name ~= "Play" then
                if u10[Parent.Name][1] then
                    for _, v in u10 do
                        v[1].Enabled = false;
                    end;

                    local FocusedUI = u65.FocusedUI;
                    u65:Focus(false);
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;

                    if FocusedUI and u10[Parent.Name][1] == FocusedUI.Parent then
                        return;
                    end;

                    if Parent.Name == "Stats" then
                        u65:Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Stats"):FindFirstChild("BG"));
                    elseif Parent.Name == "Shop" then
                        u65:Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Shop"):FindFirstChild("BG"));
                    elseif Parent.Name == "Codes" then
                        u65:Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Codes"):FindFirstChild("Content"));
                    end;

                    u10[Parent.Name][1].Enabled = true;

                    if u10[Parent.Name][2] then
                        HUD.Enabled = false;
                    end;
                end;

                return;
            end;

            LocalPlayer.PlayerGui.PickTeam.Enabled = true;
            HUD.Enabled = false;
            u65:Focus(false);
        end);
        p77.MouseButton1Up:Connect(function() -- Line: 840
            -- upvalues: u79 (ref), TweenService (ref), Parent (copy), u78 (ref)
            u79 = false;
            TweenService:Create(Parent.UIScale, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = u78 and 1.08 or 1
            }):Play();

            if Parent:FindFirstChild("Icon") then
                TweenService:Create(Parent.Icon.UIScale, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Scale = u78 and 1.18 or 1
                }):Play();
            end;
        end);
    end;

    for _, child in Buttons:GetChildren() do
        if child:IsA("Frame") ~= false then
            if child:FindFirstChild("ImageButton") then
                setupButton(child.ImageButton);
            else
                for _, child2 in child:GetChildren() do
                    if child2:IsA("Frame") ~= false and child2:FindFirstChild("ImageButton") then
                        setupButton(child2.ImageButton);
                    end;
                end;
            end;
        end;
    end;

    for _, descendant in LocalPlayer.PlayerGui:GetDescendants() do
        local u81 = descendant:FindFirstAncestorOfClass("ScreenGui");

        if descendant.Name == "Close" and (descendant:IsA("ImageButton") and not descendant:GetAttribute("IgnoreClose")) then
            descendant.MouseButton1Click:Connect(function() -- Line: 874
                -- upvalues: u65 (copy), u81 (copy), LocalPlayer (ref), HUD (copy), u10 (ref)
                local v82 = u65.FocusedUI and u81 == u65.FocusedUI.Parent and 0.15 or 0;
                u65:Focus(false);
                task.delay(v82, function() -- Line: 889
                    -- upvalues: u81 (ref)
                    u81.Enabled = false;
                end);

                if u81.Name == "PickTeam" then
                    if LocalPlayer.Team == game.Teams.Visitor then
                        HUD.Enabled = true;
                    else
                        LocalPlayer.PlayerGui.InGame.Enabled = true;
                    end;
                end;

                if not LocalPlayer.PlayerGui.PickTeam.Enabled and u10[u81.Name] then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;

                    if LocalPlayer.Team == game.Teams.Visitor then
                        HUD.Enabled = true;
                    else
                        LocalPlayer.PlayerGui.InGame.Enabled = true;
                    end;

                    workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
                end;
            end);
        end;
    end;

    LocalPlayer.PlayerGui.PickTeam:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 915
        -- upvalues: LocalPlayer (ref), TweenService (ref)
        if not LocalPlayer.PlayerGui.PickTeam.Enabled then
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;

            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = workspace.PlayCamera.CFrame * CFrame.new(0, 0, -20);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
            CFrame = workspace.PlayCamera.CFrame
        }):Play();
        LocalPlayer.PlayerGui.Style.Enabled = false;
        LocalPlayer.PlayerGui.Zone.Enabled = false;
    end);

    for i, _ in require(ReplicatedStorage.Shared.Tables.DefaultKeybinds) do
        if not (string.find(i, "Ability") or (string.find(i, "Pass Teammate") or (i == "Zone" or i == "Awaken"))) then
            local v83 = ReplicatedStorage.Assets.UI.Keybind:Clone();
            v83.Name = i;
            v83.Parent = LocalPlayer.PlayerGui.InGame.BG.Controls;
        end;
    end;
end;

function u9.PlayFlipbook(p84, p85, p86, p87, p88) -- Line: 1012
    -- upvalues: ReplicatedStorage (copy)
    local v89 = p84.ImageModules[p86];

    if not v89 then
        warn("Book not found");

        return;
    end;

    local v90 = ReplicatedStorage.Assets.ImageTables:FindFirstChild(p86);

    if not v90 then
        warn("Image module not found");

        return;
    end;

    time();

    if v90:GetAttribute("IsSpritesheet") then
        local Attribute = v90:GetAttribute("Framerate");
        local Attribute2 = v90:GetAttribute("SpriteResolution");
        local Attribute3 = v90:GetAttribute("SpritResY");
        local Attribute4 = v90:GetAttribute("Resolution");
        local Attribute5 = v90:GetAttribute("PlaysHorizontalFirst");
        local v91;

        if Attribute3 then
            v91 = Vector2.new(Attribute2, Attribute3);
        else
            v91 = Vector2.one * Attribute2;
        end;

        local v92 = 1 / Attribute;
        local math_floor_ret = math.floor(Attribute4 / v91.X);
        local math_floor_ret2 = math.floor(Attribute4 / v91.Y);
        local v93 = math_floor_ret * math_floor_ret2;

        for i = 1, #v89 do
            local v94 = v89[i];
            local v95;

            if v94 then
                p85.Image = v94;
                p85.ImageRectSize = v91;
                p85.ImageRectOffset = Vector2.zero;

                if Attribute5 then
                    v95 = i;

                    for i2 = 0, math_floor_ret2 - 1 do
                        local v96 = i2;

                        for i3 = 0, math_floor_ret - 1 do
                            p85.ImageRectOffset = Vector2.new(i3 * v91.X, v96 * v91.Y);
                            task.wait(v92);
                            local _ = i3;
                        end;
                    end;
                else
                    v95 = i;

                    for i2 = 0, math_floor_ret - 1 do
                        local v97 = i2;

                        for i3 = 0, math_floor_ret2 - 1 do
                            p85.ImageRectOffset = Vector2.new(v97 * v91.X, i3 * v91.Y);
                            task.wait(v92);
                            local _ = i3;
                        end;
                    end;
                end;

                local u98 = p85:Clone();
                u98.Parent = p85.Parent;
                u98.ZIndex = 0;
                task.delay(v92 * v93, function() -- Line: 1076
                    -- upvalues: u98 (copy)
                    u98:Destroy();
                end);
            else
                task.wait(v92 * v93);
                v95 = i;
            end;
        end;

        p85.BackgroundTransparency = 1;
        p85.ImageTransparency = 1;
    else
        local v99 = p87 or 0.016666666666666666;

        if p88 then
            local v100 = tick() - p88;

            for i = 1, #v89 do
                local v101 = v89[i];
                local v102;

                if v101 then
                    p85.Image = v101;
                    v102 = i;

                    while tick() < v100 + v99 * i do
                        task.wait();
                    end;

                    p85.BackgroundTransparency = 1;
                    local u103 = p85:Clone();
                    u103.Parent = p85.Parent;
                    u103.ZIndex = 0;
                    task.delay(v99 * 10, function() -- Line: 1104
                        -- upvalues: u103 (copy)
                        u103:Destroy();
                    end);
                else
                    v102 = i;
                end;
            end;
        else
            for i = 1, #v89 do
                local v104 = v89[i];
                local v105;

                if v104 then
                    p85.Image = v104;
                    task.wait(v99);
                    p85.BackgroundTransparency = 1;

                    if p86 == "Anklebreaker" or (p86 == "Assist" or (p86 == "Dunk" or (p86 == "MatchStart" or (p86 == "Victory" or p86 == "Defeat")))) then
                        v105 = i;
                    else
                        local u106 = p85:Clone();
                        u106.Parent = p85.Parent;
                        u106.ZIndex = 0;
                        task.delay(v99 * 10, function() -- Line: 1126
                            -- upvalues: u106 (copy)
                            u106:Destroy();
                        end);
                        v105 = i;
                    end;
                else
                    v105 = i;
                end;
            end;
        end;
    end;

    p85.Image = "";
end;

function u9.PreloadImageTables(u107) -- Line: 1138
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
    task.spawn(function() -- Line: 1139
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u107 (copy)
        local Misc = LocalPlayer.PlayerGui:WaitForChild("Misc");
        local ImageTables = ReplicatedStorage.Assets.ImageTables;

        for _, child in ImageTables:GetChildren() do
            if child:IsA("ModuleScript") then
                local v108 = require(child);
                u107.ImageModules[child.Name] = v108;
            end;
        end;

        for _, child in ImageTables:GetChildren() do
            if child:IsA("ModuleScript") then
                local v109 = u107.ImageModules[child.Name];

                if v109 then
                    for i = 1, #v109, 60 do
                        local _ = i;

                        for i2 = 1, math.min(i + 60 - 1, #v109) do
                            local v110 = v109[i2];
                            local v111;

                            if v110 then
                                local u112 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
                                u112.Name = "Image" .. tostring(i2);
                                u112.Position = UDim2.new(0.99, 0, 0, 0);
                                u112.ImageTransparency = 0.999;
                                u112.Image = v110;
                                u112.Parent = Misc;
                                task.defer(function() -- Line: 1166
                                    -- upvalues: u112 (copy)
                                    task.wait(1);
                                    u112:Destroy();
                                end);
                                v111 = i2;
                            else
                                v111 = i2;
                            end;
                        end;

                        task.wait();
                        task.wait(1);
                    end;
                end;
            end;
        end;

        print("Images Loaded");
    end);
end;

function u9.FrameText(p113, p114) -- Line: 1247
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u11 (copy), SfxManager (copy)
    local u115 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
    u115.Parent = LocalPlayer.PlayerGui.Misc.TextFrame;

    if table.find(u11, p114) then
        u115.Size = UDim2.fromScale(0.5, 0.5);
        u115.Position = UDim2.fromScale(0.5, 0.3);
    end;

    if p114 == "Dunk" then
        SfxManager:playSound({
            Sound = "DunkImage",
            Parent = workspace
        });
    elseif p114 == "AnkleBreaker" then
        SfxManager:playSound({
            Sound = "AnkleBreak",
            Parent = workspace
        });
    end;

    p113:PlayFlipbook(u115, p114);
    task.delay(6, function() -- Line: 1269
        -- upvalues: u115 (copy)
        u115:Destroy();
    end);
end;

function u9.TeamCheck(p116) -- Line: 1274
    warn("UIController:TeamCheck() was called before UIController:KnitStart() could define the method.");
end;

local function _(p117) -- Line: 1281
    return tostring(p117):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
end;

function u9.IsLoaded(p118) -- Line: 1286
    if p118.Loaded == nil then
        return false;
    end;

    return p118.Loaded;
end;

local function IsWeekend() -- Line: 1294
    local ServerTimeNow = workspace:GetServerTimeNow();
    local os_date_ret = os.date("*t", ServerTimeNow);

    return os_date_ret.wday == 1 or os_date_ret.wday == 7;
end;

function u9.KnitStart(u119) -- Line: 1304
    -- upvalues: u7 (ref), Knit (copy), u4 (ref), u5 (ref), u6 (ref), u3 (ref), u8 (ref), LocalPlayer (copy), ReplicatedStorage (copy), UserInputService (copy), Jerseys (copy), u9 (copy), Effects (copy), u1 (ref), SfxManager (copy), TweenService (copy), RunService (copy), GuiService (copy)
    u7 = Knit.GetController("AwakeningController");
    u4 = Knit.GetController("KeybindsController");
    u5 = Knit.GetController("PassController");
    u6 = Knit.GetController("BallController");
    u3 = Knit.GetController("Network");
    u8 = Knit.GetService("SettingsService");
    local InLoadingScreen = game:GetService("ReplicatedFirst"):WaitForChild("InLoadingScreen");

    while InLoadingScreen.Value == true do
        InLoadingScreen.Changed:Wait();
    end;

    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local InGame = LocalPlayer.PlayerGui:WaitForChild("InGame");
    local Spectate = LocalPlayer.PlayerGui:WaitForChild("Spectate");
    HUD.Enabled = true;
    HUD:GetPropertyChangedSignal("Enabled", function() -- Line: 1326
        -- upvalues: HUD (copy), LocalPlayer (ref)
        if HUD.Enabled and LocalPlayer.Team ~= game.Teams.Visitor then
            HUD.Enabled = false;
        end;
    end);

    local function actionUI(p120, p121) -- Line: 1332
        for _, child in p120:GetChildren() do
            if child:IsA("ImageLabel") then
                child.Visible = p121;
            end;
        end;
    end;

    ReplicatedStorage.Controllers.Device:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 1338
        -- upvalues: ReplicatedStorage (ref), actionUI (copy), InGame (copy)
        if ReplicatedStorage.Controllers.Device.Value == "PC" then
            actionUI(InGame.BG.ControlsPC, true);

            return;
        end;

        actionUI(InGame.BG.ControlsPC, false);
    end);
    local u122 = {};
    local u123 = true;
    UserInputService.InputBegan:Connect(function(p124, p125) -- Line: 1351
        -- upvalues: u123 (ref), LocalPlayer (ref), u122 (copy)
        if p124.KeyCode == Enum.KeyCode.F10 then
            if u123 then
                for _, child in LocalPlayer.PlayerGui:GetChildren() do
                    if child:IsA("ScreenGui") then
                        u122[child.Name] = child.Enabled;
                        child.Enabled = false;
                    end;
                end;
            else
                for _, child in LocalPlayer.PlayerGui:GetChildren() do
                    if child:IsA("ScreenGui") and u122[child.Name] then
                        child.Enabled = u122[child.Name];
                    end;
                end;

                table.clear(u122);
            end;

            u123 = not u123;
        end;
    end);

    function u9.TeamCheck(p126) -- Line: 1373
        -- upvalues: HUD (copy), LocalPlayer (ref), u122 (copy), Spectate (copy), InGame (copy), Jerseys (ref), ReplicatedStorage (ref)
        if HUD.Enabled then
            HUD.Enabled = false;
        end;

        for _, child in LocalPlayer.PlayerGui:GetChildren() do
            if child:IsA("ScreenGui") and u122[child.Name] then
                child.Enabled = u122[child.Name];
            end;
        end;

        table.clear(u122);

        if not Spectate.Enabled then
            HUD.Enabled = LocalPlayer.Team == game.Teams.Visitor;
            InGame.Enabled = LocalPlayer.Team ~= game.Teams.Visitor;
        end;

        local v127, v128, v129 = Jerseys.Away[ReplicatedStorage.GameValues.AwayIndex.Value].Color:ToHSV();
        local v130, v131, v132 = Jerseys.Home[ReplicatedStorage.GameValues.HomeIndex.Value].Color:ToHSV();
        local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Jerseys.Away[ReplicatedStorage.GameValues.AwayIndex.Value].Color), ColorSequenceKeypoint.new(0.5, Color3.fromHSV(v127, math.clamp(v128 - 0.3, 0, 1), v129)), ColorSequenceKeypoint.new(1, Jerseys.Away[ReplicatedStorage.GameValues.AwayIndex.Value].Color) });
        local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Jerseys.Home[ReplicatedStorage.GameValues.HomeIndex.Value].Color), ColorSequenceKeypoint.new(0.5, Color3.fromHSV(v130, math.clamp(v131 - 0.3, 0, 1), v132)), ColorSequenceKeypoint.new(1, Jerseys.Home[ReplicatedStorage.GameValues.HomeIndex.Value].Color) });
        InGame.BG.Top.Away.UIGradient.Color = ColorSequence_new_ret;
        InGame.BG.Top.Home.UIGradient.Color = ColorSequence_new_ret2;
        Spectate.Top.Away.UIGradient.Color = ColorSequence_new_ret;
        Spectate.Top.Home.UIGradient.Color = ColorSequence_new_ret2;
    end;

    Spectate:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1412
        -- upvalues: u119 (copy)
        u119:TeamCheck();
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 1416
        -- upvalues: u119 (copy)
        u119:TeamCheck();
    end);
    u119:Heartbeat();
    u119:HUD();
    u119:ScaleAll();
    u119:PreloadImageTables();
    u119:InitializeControlKeybindUIs();
    u119:InitializeMobileBallUI();
    u119:InitializeScoreboardUIs();
    u119:InitializeTimerUIs();
    Knit.GetService("MarketService").OnPlayerPurchased:Connect(function() -- Line: 1433
        -- upvalues: Effects (ref)
        Effects:Popup("Thank you for your purchase! 😊", 3, Color3.fromRGB(0, 255, 0));
    end);
    ReplicatedStorage.Remotes.MoneyPopup.OnClientEvent:Connect(function(p133) -- Line: 1437
        -- upvalues: u1 (ref), ReplicatedStorage (ref), SfxManager (ref), TweenService (ref)
        local MoneyUI = u1.PrimaryPart:FindFirstChild("MoneyUI");

        if not MoneyUI then
            MoneyUI = ReplicatedStorage.Assets.UI.MoneyUI:Clone();
            MoneyUI.Parent = u1.PrimaryPart;
        end;

        SfxManager:playSound({
            Sound = "MoneyGain",
            Parent = u1.PrimaryPart
        });
        local u134 = ReplicatedStorage.Assets.UI.MoneyFrame:Clone();
        u134.Parent = MoneyUI.List;
        u134.Moni.Text = "+$" .. tostring(p133):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
        u134.UIScale.Scale = 1.7;
        TweenService:Create(u134.UIScale, TweenInfo.new(1), {
            Scale = 1.4
        }):Play();
        task.delay(2, function() -- Line: 1452
            -- upvalues: TweenService (ref), u134 (copy)
            TweenService:Create(u134.Moni, TweenInfo.new(0.5), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(u134.Moni.UIStroke, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
            task.wait(0.5);
            u134:Destroy();
        end);
    end);

    if LocalPlayer.Team ~= game.Teams.Visitor then
        u119:TeamCheck();

        if u3.Gamemode == "Match-3v3" then
            LocalPlayer.PlayerGui.InGame.Enabled = false;
            LocalPlayer.PlayerGui.PickTeam.Enabled = true;
        end;
    end;

    if RunService:IsStudio() then
        UserInputService.InputBegan:Connect(function(p135, p136) -- Line: 1473
            -- upvalues: u119 (copy)
            if p136 then
                return;
            end;

            if p135.KeyCode == Enum.KeyCode.N then
                u119:FrameText("RubberSprite1");

                return;
            end;

            if p135.KeyCode == Enum.KeyCode.M then
                u119:FrameText("RubberSprite2");
            end;
        end);
    end;

    task.spawn(function() -- Line: 1486
        -- upvalues: LocalPlayer (ref), UserInputService (ref), GuiService (ref)
        local Version = LocalPlayer.PlayerGui:WaitForChild("Misc").Version;

        while not (workspace:GetAttribute("ServerEnvironment") and workspace:GetAttribute("ServerType")) do
            task.wait();
        end;

        Version.Text = `v{game.PlaceVersion} [{workspace:GetAttribute("ServerEnvironment")}] [{workspace:GetAttribute("ServerType")}]`;
        Version.Visible = workspace:GetAttribute("ServerEnvironment") == "Dev";
        UserInputService.InputBegan:Connect(function(p137, p138) -- Line: 1496
            -- upvalues: UserInputService (ref), Version (copy)
            if not (p138 or (p137.KeyCode ~= Enum.KeyCode.V or not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift))) then
                Version.Visible = not Version.Visible;
            end;
        end);
        GuiService.MenuOpened:Connect(function() -- Line: 1502
            -- upvalues: Version (copy)
            if workspace:GetAttribute("IsPrivateServer") then
                Version.Text = `v{game.PlaceVersion} [{workspace:GetAttribute("ServerType")}]`;
                Version.Visible = true;
            end;
        end);
        GuiService.MenuClosed:Connect(function() -- Line: 1509
            -- upvalues: Version (copy)
            if workspace:GetAttribute("IsPrivateServer") then
                Version.Text = `v{game.PlaceVersion} [{workspace:GetAttribute("ServerEnvironment")}] [{workspace:GetAttribute("ServerType")}]`;
                Version.Visible = workspace:GetAttribute("ServerEnvironment") == "Dev";
            end;
        end);
    end);
    task.spawn(function() -- Line: 1517
        -- upvalues: HUD (copy)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local os_date_ret = os.date("*t", ServerTimeNow);

            if os_date_ret.wday == 1 or os_date_ret.wday == 7 then
                HUD.Top.Currency.BoostMultiplier.Visible = true;
            else
                HUD.Top.Currency.BoostMultiplier.Visible = false;
            end;

            task.wait(60);
        end;
    end);
    u119.Loaded = true;
end;

function u9.KnitInit(u139) -- Line: 1554
    -- upvalues: LocalPlayer (copy), HumanoidRootPart (ref), u1 (ref), u2 (ref), ReplicatedStorage (copy)
    u139.ImageModules = {};
    LocalPlayer.PlayerGui.DribbleBar.Adornee = HumanoidRootPart;
    LocalPlayer.PlayerGui.ShotMeter.Adornee = HumanoidRootPart;
    LocalPlayer.CharacterAdded:Connect(function(p140) -- Line: 1560
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), LocalPlayer (ref)
        u1 = p140;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        LocalPlayer.PlayerGui.DribbleBar.Adornee = HumanoidRootPart;
        LocalPlayer.PlayerGui.ShotMeter.Adornee = HumanoidRootPart;
    end);
    ReplicatedStorage.Remotes.FrameText.OnClientEvent:Connect(function(p141) -- Line: 1569
        -- upvalues: LocalPlayer (ref), u139 (copy)
        if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled then
            return;
        end;

        u139:FrameText(p141);
    end);
end;

return u9;