  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local SocialService = game:GetService("SocialService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Tweens = require(ReplicatedStorage.Shared.Tweens);
require(ReplicatedStorage.Shared.SoundManager);
local environment = require(ReplicatedStorage.Shared.environment);
local StylePassiveController = require(ReplicatedStorage2.Controllers.StylePassiveController);
local Icon = require(ReplicatedStorage2.Shared.TopbarPlus.Icon);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local u1 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u2:WaitForChild("Humanoid");
local HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
local workspace_CurrentCamera = workspace.CurrentCamera;
tick();
local u3 = Knit.CreateController({
    Name = "UIController"
});
u3.Frames = {
    Style = LocalPlayer.PlayerGui:WaitForChild("Style"),
    PlrStats = LocalPlayer.PlayerGui:WaitForChild("PlrStats"),
    Codes = LocalPlayer.PlayerGui:WaitForChild("Codes"),
    Settings = LocalPlayer.PlayerGui:WaitForChild("Settings"),
    Flow = LocalPlayer.PlayerGui:WaitForChild("Flow"),
    Customization = LocalPlayer.PlayerGui:WaitForChild("Customization"),
    Shop = LocalPlayer.PlayerGui:WaitForChild("Shop"),
    Spectate = LocalPlayer.PlayerGui:WaitForChild("Spectate"),
    StyleQuestLine = LocalPlayer.PlayerGui:WaitForChild("StyleQuestLine")
};

function u3.Controls(u4) -- Line: 51
    -- upvalues: LocalPlayer (copy), PlayerData (copy), UserInputService (copy)
    local InGameUI = LocalPlayer.PlayerGui:WaitForChild("InGameUI");
    local Keybind = InGameUI.Bottom.Awakening.BG.Activation.Keybind;
    local Awakening = InGameUI.Bottom.Awakening;

    local function setAwakeningKeybindText(p5, p6) -- Line: 56
        -- upvalues: Keybind (copy), Awakening (copy)
        Keybind.Text = p5;

        if not Awakening then
            return;
        end;

        for _, child in Awakening:GetChildren() do
            local v7 = child:IsA("Frame") and child:FindFirstChild("Keybind");

            if v7 and v7:IsA("TextLabel") then
                v7.Text = p6 or p5;
            end;
        end;
    end;

    local function getConsoleAwakeningText() -- Line: 69
        -- upvalues: PlayerData (ref), UserInputService (ref)
        local v8 = Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Awaken];
        local StringForKeyCode = UserInputService:GetStringForKeyCode(v8);

        if StringForKeyCode == "" then
            StringForKeyCode = v8.Name;
        end;

        if string.sub(StringForKeyCode, 1, 6) == "Button" then
            StringForKeyCode = string.sub(StringForKeyCode, 7);
        end;

        return `PRESS {string.upper(StringForKeyCode)} TO AWAKEN`;
    end;

    local function refreshConsoleButtons() -- Line: 83
        -- upvalues: LocalPlayer (ref), u4 (copy), PlayerData (ref)
        for _, descendant in LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole"):GetDescendants() do
            local Attribute = descendant:GetAttribute("ConsoleKeyCode");
            local Attribute2 = descendant:GetAttribute("SettingName");

            if Attribute or Attribute2 then
                if Attribute2 then
                    descendant.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console[Attribute2]]);
                elseif Attribute then
                    descendant.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[Attribute]);
                end;
            end;
        end;
    end;

    local function controlUI() -- Line: 105
        -- upvalues: UserInputService (ref), setAwakeningKeybindText (copy), LocalPlayer (ref), getConsoleAwakeningText (copy), u4 (copy), PlayerData (ref), refreshConsoleButtons (copy)
        if UserInputService.TouchEnabled then
            setAwakeningKeybindText("", "");
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = false;
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = false;

            return;
        end;

        if not UserInputService.GamepadEnabled then
            if not PlayerData.Data then
                return;
            end;

            setAwakeningKeybindText((`PRESS {PlayerData.Data.PlayerKeybinds.PC.Awaken} TO AWAKEN`));
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = true;
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability1;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability2;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability3;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.RequestCR;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = false;

            return;
        end;

        local _ = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA";
        setAwakeningKeybindText("TO AWAKEN", (getConsoleAwakeningText()));
        LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Awaken]);
        LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = false;
        LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability1]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability2]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability3]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.RequestCR]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = true;
        refreshConsoleButtons();
    end;

    local u9 = nil;

    local function chrolloCheck() -- Line: 167
        -- upvalues: PlayerData (ref), u9 (ref), setAwakeningKeybindText (copy), LocalPlayer (ref), UserInputService (ref), getConsoleAwakeningText (copy), u4 (copy), refreshConsoleButtons (copy)
        if not PlayerData.Data then
            return;
        end;

        if u9 == Enum.UserInputType.Touch then
            setAwakeningKeybindText("", "");
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = false;
            LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = "";
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = false;
            LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Visible = false;

            return;
        end;

        if u9 ~= Enum.UserInputType.Gamepad1 and u9 ~= Enum.UserInputType.Gamepad2 then
            if u9 == Enum.UserInputType.Keyboard then
                if not PlayerData.Data then
                    return;
                end;

                setAwakeningKeybindText((`PRESS {PlayerData.Data.PlayerKeybinds.PC.Awaken} TO AWAKEN`));
                LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = true;
                LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability1;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability2;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.Ability3;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = PlayerData.Data.PlayerKeybinds.PC.RequestCR;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = false;
            end;

            return;
        end;

        local _ = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA";
        setAwakeningKeybindText("TO AWAKEN", (getConsoleAwakeningText()));
        LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Awaken]);
        LocalPlayer.PlayerGui:WaitForChild("InGameUI").Bottom.Awakening.BG.Activation.KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC").Visible = false;
        LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole").Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.Keybind.Text = "";
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability1]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability2]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Ability3]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Image = u4.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.RequestCR]);
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["1"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["2"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities["3"].KeybindIcon.Visible = true;
        LocalPlayer.PlayerGui.InGameUI.Bottom.Abilities.CR.KeybindIcon.Visible = true;
        refreshConsoleButtons();
    end;

    task.spawn(function() -- Line: 238
        -- upvalues: PlayerData (ref), controlUI (copy)
        PlayerData:WaitForLoaded();
        controlUI();
    end);
    u4.BaseTrove:Connect(UserInputService:GetPropertyChangedSignal("GamepadEnabled"), function() -- Line: 243
        -- upvalues: controlUI (copy)
        controlUI();
    end);
    PlayerData:Observe({ "PlayerKeybinds" }, controlUI);
    u4.BaseTrove:Connect(LocalPlayer.PlayerStats.InAwakening.Changed, function(p10) -- Line: 249
        -- upvalues: PlayerData (ref), controlUI (copy), chrolloCheck (copy)
        if p10 or not PlayerData.Data then
            return;
        end;

        controlUI();
        chrolloCheck();
    end);
    u4.BaseTrove:Connect(UserInputService.LastInputTypeChanged, function(p11) -- Line: 256
        -- upvalues: u9 (ref), chrolloCheck (copy)
        if p11 == Enum.UserInputType.TextInput then
            return;
        end;

        if u9 ~= p11 then
            u9 = p11;
            chrolloCheck();
        end;

        u9 = p11;
    end);
end;

local function updateTeamScore(p12) -- Line: 267
    -- upvalues: ReplicatedStorage (copy)
    for _, child in ReplicatedStorage.Goals:GetChildren() do
        if p12.Scoreboard.Frame:FindFirstChild(child.Name) then
            local TextLabel = p12.Scoreboard.Frame[child.Name].Score.TextLabel;
            local math_round_ret = math.round(child.Value);
            TextLabel.Text = tostring(math_round_ret);
        end;
    end;
end;

function u3.Heartbeat(u13, u14, u15) -- Line: 276
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), UserInputService (copy), PlayerData (copy), RunService (copy), TweenService (copy), Debris (copy), updateTeamScore (copy), Essentials (copy), Tweens (copy), StylePassiveController (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
    local u16 = tick();

    local function ActivateFlow() -- Line: 281
        -- upvalues: u16 (ref), LocalPlayer (ref), u13 (copy)
        if u16 > tick() then
            return;
        end;

        if LocalPlayer.PlayerStats.InFlow.Value then
            return;
        end;

        if math.round(LocalPlayer.PlayerStats.FlowBar.Value) < 30 then
            return;
        end;

        u16 = tick() + 0.25;
        u13.FlowService.Activate:Fire();
    end;

    u13.BaseTrove:Connect(UserInputService.InputBegan, function(p17, p18) -- Line: 291
        -- upvalues: PlayerData (ref), ActivateFlow (copy)
        if p18 then
            return;
        end;

        if not PlayerData.Data then
            return;
        end;

        if p17.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Flow] or p17.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Flow] then
            ActivateFlow();
        end;
    end);

    if UserInputService.TouchEnabled then
        u13.BaseTrove:Connect(LocalPlayer.PlayerGui.Mobile.Ball.Flow.MouseButton1Click, ActivateFlow);
        u13.BaseTrove:Connect(LocalPlayer.PlayerGui.Mobile.NoBall.Flow.MouseButton1Click, ActivateFlow);
    end;

    u13.BaseTrove:Connect(RunService.Heartbeat, function() -- Line: 305
        -- upvalues: FormatNumber (copy), LocalPlayer (ref), TweenService (ref), TweenInfo_new_ret (copy), Debris (ref), UserInputService (ref), u13 (copy), PlayerData (ref), updateTeamScore (ref), u14 (copy), ReplicatedStorage (ref), u15 (copy), Essentials (ref), Tweens (ref), StylePassiveController (ref)
        if workspace:FindFirstChild("Limiteds") then
            local Timer = workspace.GameObjects.OnSaleLimiteds.Timer;
            local Attribute = workspace:GetAttribute("limitedTimer");

            if Attribute then
                Timer.timer2.ButtonName.Text = "ENDS IN: " .. FormatNumber.AdaptiveClockString(Attribute - workspace:GetServerTimeNow(), false);
                Timer.timer1.ButtonName.Text = "ENDS IN: " .. FormatNumber.AdaptiveClockString(Attribute - workspace:GetServerTimeNow(), false);
            else
                Timer.timer2.ButtonName.Text = "LOADING TIMER";
                Timer.timer1.ButtonName.Text = "LOADING TIMER";
            end;
        end;

        if workspace:FindFirstChild("Mythics") then
            local Attribute = workspace:GetAttribute("mythicLimitedTimer");

            for _, v in { "Timer", "Timer2" } do
                local v19 = workspace.Mythics:FindFirstChild(v);

                if v19 then
                    if Attribute then
                        v19.timer2.ButtonName.Text = "ENDS IN: " .. FormatNumber.AdaptiveClockString(Attribute - workspace:GetServerTimeNow(), false);
                        v19.timer1.ButtonName.Text = "ENDS IN: " .. FormatNumber.AdaptiveClockString(Attribute - workspace:GetServerTimeNow(), false);
                    else
                        v19.timer2.ButtonName.Text = "LOADING TIMER";
                        v19.timer1.ButtonName.Text = "LOADING TIMER";
                    end;
                end;
            end;
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.HUD.Enabled = false;
        end;

        if LocalPlayer.PlayerStats.AwakeningBar.Value >= 90 and LocalPlayer.PlayerStats.InAwakening.Value == false then
            LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.Visible = true;
            LocalPlayer.PlayerGui.Mobile.Ball.Awaken.Visible = true;
        else
            LocalPlayer.PlayerGui.Mobile.NoBall.Awaken.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Awaken.Visible = false;
        end;

        local math_round_ret = math.round(LocalPlayer.PlayerStats.FlowBar.Value);
        local v20 = TweenService:Create(LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.UIGradient, TweenInfo_new_ret, {
            Offset = Vector2.new(math_round_ret / 90 + -0.7)
        });
        v20:Play();
        Debris:AddItem(v20, 0.15);

        if math_round_ret >= 30 and LocalPlayer.PlayerStats.InFlow.Value == false then
            if UserInputService.GamepadEnabled then
                local _ = UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonA";
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.KeybindIcon.Visible = true;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.KeybindIcon.Image = u13.Settings:GetConsoleKeybindImage(Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Flow]) or "";
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.Keybind.Text = "TO ACTIVATE FLOW";
            elseif UserInputService.TouchEnabled then
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.Keybind.Text = "ACTIVATE FLOW";
            else
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.KeybindIcon.Visible = false;
                LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.Keybind.Text = `PRESS {PlayerData.Data.PlayerKeybinds.PC.Flow} TO ACTIVATE FLOW`;
            end;
        else
            LocalPlayer.PlayerGui.InGameUI.Bottom.Flow.BG.Bar.Keybind.Text = tostring(math_round_ret) .. "%";
        end;

        if LocalPlayer.PlayerStats.FlowBar.Value < 30 or LocalPlayer.PlayerStats.InFlow.Value then
            LocalPlayer.PlayerGui.Mobile.NoBall.Flow.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Ball.Flow.Visible = false;
        else
            LocalPlayer.PlayerGui.Mobile.NoBall.Flow.Visible = true;
            LocalPlayer.PlayerGui.Mobile.Ball.Flow.Visible = true;
        end;

        LocalPlayer.PlayerGui.HUD.Buttons.Flow.Button.New.Visible = LocalPlayer.ProfileStats.FlowSpins.Value > 0;
        LocalPlayer.PlayerGui.HUD.Buttons:FindFirstChild("Style").Button.New.Visible = LocalPlayer.ProfileStats.Spins.Value > 0;
        updateTeamScore(u14);

        if ReplicatedStorage.GameValues.State.Value == "Playing" or ReplicatedStorage.GameValues.State.Value == "StartingCutscene" then
            u15.Top.Frame.LobbyStatus.Text.Text = "Join Match!";
        elseif ReplicatedStorage.GameValues.State.Value == "Ended" then
            u15.Top.Frame.LobbyStatus.Text.Text = "Match Ended!";
        else
            u15.Top.Frame.LobbyStatus.Text.Text = "Match Starts In: " .. Essentials:formatTime(ReplicatedStorage.GameValues.Timer.Value);
        end;

        u14.Scoreboard.Timer.TextLabel.Text = Essentials:formatTime(ReplicatedStorage.GameValues.Timer.Value);
        local Value = LocalPlayer.PlayerStats.Stamina.Value;
        local StaminaBar = LocalPlayer.PlayerGui.StaminaBar;
        Tweens.TweenSize(0.15, "Sine", { StaminaBar.StaminaBG.Bar }, UDim2.new(1, 0, Value / 100, 0));

        if Value >= 100 and StaminaBar.StaminaBG.BackgroundTransparency < 0.9 then
            Tweens.TweenTransparency(1, "Sine", { StaminaBar.StaminaBG }, 1);
            Tweens.TweenTransparency(1, "Sine", { StaminaBar.StaminaBG.Bar }, 1);
        elseif Value < 100 and StaminaBar.StaminaBG.BackgroundTransparency > 0.36 then
            Tweens.TweenTransparency(1, "Sine", { StaminaBar.StaminaBG.Bar }, 0);
            Tweens.TweenTransparency(1, "Sine", { StaminaBar.StaminaBG }, 0.35);
        end;

        local v21 = StylePassiveController:Read("Velocity", "VelocityPercent");

        if v21 == nil then
            StaminaBar.AccelerationBG.Visible = false;

            return;
        end;

        StaminaBar.AccelerationBG.Visible = true;
        Tweens.TweenSize(0.15, "Sine", { StaminaBar.AccelerationBG.Bar }, UDim2.new(1, 0, math.clamp(v21, 0, 1), 0));

        if v21 ~= 0 or StaminaBar.AccelerationBG.BackgroundTransparency >= 0.9 then
            if v21 > 0 and StaminaBar.AccelerationBG.BackgroundTransparency > 0.36 then
                Tweens.TweenTransparency(1, "Sine", { StaminaBar.AccelerationBG.Bar }, 0);
                Tweens.TweenTransparency(1, "Sine", { StaminaBar.AccelerationBG }, 0.35);
            end;

            return;
        end;

        Tweens.TweenTransparency(1, "Sine", { StaminaBar.AccelerationBG }, 1);
        Tweens.TweenTransparency(1, "Sine", { StaminaBar.AccelerationBG.Bar }, 1);
    end);
end;

function u3.Close(p22) -- Line: 440
    -- upvalues: LocalPlayer (copy), Icon (copy), workspace_CurrentCamera (copy), TweenService (copy), Debris (copy)
    local Children = LocalPlayer.PlayerGui:GetChildren();

    for _, v in pairs(Children) do
        if v.Name ~= "RelicsPlayer" then
            local Descendants = v:GetDescendants();
            local u23 = v;

            for _, v2 in pairs(Descendants) do
                if v2.Name == "Close" and not v2:GetAttribute("DisableDefaultClose") then
                    local function close() -- Line: 449
                        -- upvalues: u23 (copy), Icon (ref), workspace_CurrentCamera (ref), TweenService (ref), Debris (ref), LocalPlayer (ref)
                        if not u23.Enabled then
                            return;
                        end;

                        Icon.setTopbarEnabled(true);
                        u23.Enabled = false;

                        if workspace_CurrentCamera:FindFirstChild("WeldConstraint") then
                            workspace_CurrentCamera:FindFirstChild("WeldConstraint"):Destroy();
                        end;

                        task.spawn(function() -- Line: 460
                            -- upvalues: TweenService (ref), Debris (ref)
                            if not game.Lighting:FindFirstChild("Blur") then
                                return;
                            end;

                            local v24 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Size = 3
                            });
                            v24:Play();
                            Debris:AddItem(v24, 0.2);
                        end);
                        local v25 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            FieldOfView = 70
                        });
                        v25:Play();
                        Debris:AddItem(v25, 0.2);

                        if LocalPlayer.Team == game.Teams.Visitor then
                            if not LocalPlayer.PlayerGui.PickTeam.Enabled then
                                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                                local NEL = LocalPlayer.PlayerGui:FindFirstChild("NEL");

                                if not (NEL and NEL.Enabled) then
                                    LocalPlayer.PlayerGui.HUD.Enabled = true;
                                end;
                            end;
                        else
                            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
                        end;
                    end;

                    p22.BaseTrove:Connect(LocalPlayer.PlayerGui.PickTeam:GetPropertyChangedSignal("Enabled"), function() -- Line: 490
                        -- upvalues: LocalPlayer (ref), close (copy)
                        if LocalPlayer.PlayerGui.PickTeam.Enabled or LocalPlayer.PlayerGui.InGameUI.Enabled then
                            close();
                        end;
                    end);
                    p22.BaseTrove:Connect(v2.MouseButton1Click, close);

                    if u23.Name ~= "CharlesBundle" or u23.Name ~= "ProdigyTrack" then
                        break;
                    end;
                end;
            end;

            table.clear(Descendants);
        end;
    end;

    table.clear(Children);
end;

function u3.Scale(p26) -- Line: 512
    -- upvalues: LocalPlayer (copy)
    tick();

    for _, child in pairs(LocalPlayer.PlayerGui:GetChildren()) do
        if child.Name ~= "Iris_Root" then
            local Descendants = child:GetDescendants();

            for _, v in Descendants do
                if v:IsA("ImageButton") and not (v:GetAttribute("DisableDefaultTween") or v:FindFirstAncestor("TouchGui")) then
                    v:AddTag("ButtonEffects");
                end;
            end;

            table.clear(Descendants);
        end;
    end;
end;

local u27 = tick();

function u3.CloseMenus(p28) -- Line: 536
    -- upvalues: u3 (copy), Icon (copy), workspace_CurrentCamera (copy), TweenService (copy), Debris (copy), LocalPlayer (copy)
    local v29 = false;

    for _, v in pairs(u3.Frames) do
        if v.Enabled then
            v.Enabled = false;
            v29 = true;
        end;
    end;

    if not v29 then
        return;
    end;

    Icon.setTopbarEnabled(true);

    if workspace_CurrentCamera:FindFirstChild("WeldConstraint") then
        workspace_CurrentCamera:FindFirstChild("WeldConstraint"):Destroy();
    end;

    task.spawn(function() -- Line: 547
        -- upvalues: TweenService (ref), Debris (ref)
        if not game.Lighting:FindFirstChild("Blur") then
            return;
        end;

        local v30 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 3
        });
        v30:Play();
        Debris:AddItem(v30, 0.2);
    end);
    local v31 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 70
    });
    v31:Play();
    Debris:AddItem(v31, 0.2);

    if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.PickTeam.Enabled then
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    end;
end;

function u3.Open(p32: table, p33: string) -- Line: 561
    -- upvalues: u27 (ref), Icon (copy), u3 (copy), environment (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), TweenService (copy), Debris (copy), Popup (copy), HumanoidRootPart (ref)
    if u27 > tick() then
        return;
    end;

    Icon.setTopbarEnabled(true);
    local u34 = u3.Frames[p33];

    if not u34 and p33 ~= "Play" then
        return;
    end;

    for _, v in pairs(u3.Frames) do
        v.Enabled = false;

        if not v:GetAttribute("DefaultSize") then
            v:SetAttribute("DefaultSize", v.BG.Size);
        end;
    end;

    if p33 ~= "Play" then
        if p33 ~= "Spectate" then
            if p33 == "Style" or (p33 == "Flow" or p33 == "Customization") then
                if environment.mode == "Ranked" and (p33 == "Style" or p33 == "Flow") then
                    Popup.Popup(LocalPlayer, "Cannot change " .. p33:lower() .. " during a ranked match!");

                    return;
                end;

                Icon.setTopbarEnabled(false);

                if p33 ~= "Flow" then
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                end;

                workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                task.spawn(function() -- Line: 663
                    -- upvalues: TweenService (ref), Debris (ref)
                    if not game.Lighting:FindFirstChild("Blur") then
                        return;
                    end;

                    local v35 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = 3
                    });
                    v35:Play();
                    Debris:AddItem(v35, 0.1);
                end);
                local v36 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 70
                });
                v36:Play();
                Debris:AddItem(v36, 0.1);
            else
                LocalPlayer.PlayerGui.HUD.Enabled = false;
                u34.BG.Size = UDim2.new(0, 0, 0, 0);
                task.spawn(function() -- Line: 684
                    -- upvalues: TweenService (ref), u34 (copy), Debris (ref)
                    local v37 = TweenService:Create(u34.BG, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = u34:GetAttribute("DefaultSize")
                    });
                    v37:Play();
                    Debris:AddItem(v37, 0.1);
                end);
                task.spawn(function() -- Line: 692
                    -- upvalues: TweenService (ref), Debris (ref)
                    if not game.Lighting:FindFirstChild("Blur") then
                        return;
                    end;

                    local v38 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = 15
                    });
                    v38:Play();
                    Debris:AddItem(v38, 0.1);
                end);
                local v39 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 80
                });
                v39:Play();
                Debris:AddItem(v39, 0.1);
            end;

            if p33 == "Flow" then
                u27 = tick() + 1.5;
                Popup.BlackoutLocal(LocalPlayer, "Flow1", "Flow2", nil, 2);
                Popup.BlackoutLocal(LocalPlayer, "Flow1", "Flow2", true, 2);
                task.delay(0.5, function() -- Line: 715
                    -- upvalues: LocalPlayer (ref), u34 (copy)
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                    u34.Enabled = true;
                end);
            else
                u34.Enabled = true;
            end;

            if p33 == "Customization" then
                local v40 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(-2, 0, -6.5) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0)
                });
                v40:Play();
                Debris:AddItem(v40, 0.25);
            end;

            if p33 == "Style" then
                local v41 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -9) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0)
                });
                v41:Play();
                Debris:AddItem(v41, 0.25);
            end;

            return;
        end;

        if #p32.Spectator.SpectateTargets == 0 then
            Popup.Popup(nil, "No one to spectate!");

            return;
        end;

        if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            return;
        end;

        local v42 = #p32.Spectator.SpectateTargets <= 1 and 1 or math.random(2, #p32.Spectator.SpectateTargets);
        p32.Spectator:Spectate(p32.Spectator.SpectateTargets[v42]);
        LocalPlayer.PlayerGui.HUD.Enabled = false;

        return;
    end;

    u27 = tick() + 2;

    if environment.mode == "Ranked" then
        return;
    end;

    if environment.config.TeamLocked then
        return;
    end;

    if not LocalPlayer.PlayerGui.HUD.Enabled then
        return;
    end;

    if LocalPlayer.Team ~= game:GetService("Teams").Visitor then
        return;
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    task.spawn(function() -- Line: 594
        -- upvalues: TweenService (ref), Debris (ref)
        local v43 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 3
        });
        v43:Play();
        Debris:AddItem(v43, 0.1);
    end);
    local v44 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 70
    });
    v44:Play();
    Debris:AddItem(v44, 0.1);
    Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", nil, 2);
    Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", true, 2);
    p32.EmoteService.EndEmote:Fire();
    task.delay(0.375, function() -- Line: 614
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), Debris (ref), LocalPlayer (ref)
        local v45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = workspace:WaitForChild("TeamSelect").CFrame
        });
        v45:Play();
        Debris:AddItem(v45, 0.25);
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.PickTeam.Enabled = true;
    end);
end;

function u3.HUD(u46) -- Line: 749
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Tweens (copy)
    local Children = LocalPlayer.PlayerGui:WaitForChild("HUD"):WaitForChild("Buttons"):GetChildren();
    tick();

    local function removeHover() -- Line: 752
        -- upvalues: Children (copy)
        for _, v in pairs(Children) do
            if v:IsA("Frame") ~= false and v:FindFirstChild("Hover") then
                v.Hover:Destroy();
            end;
        end;
    end;

    for _, v in pairs(Children) do
        if v:IsA("Frame") ~= false then
            local Size = v.Size;
            u46.BaseTrove:Connect(v.MouseEnter, function() -- Line: 765
                -- upvalues: removeHover (copy), ReplicatedStorage (ref), v (copy), Tweens (ref), Size (copy)
                removeHover();
                ReplicatedStorage.Assets.UI.Hover:Clone().Parent = v;
                Tweens.TweenSize(0.25, "Sine", { v }, UDim2.new(Size.X.Scale * 1.15, 0, Size.Y.Scale * 1.15, 0));
            end);
            u46.BaseTrove:Connect(v.MouseLeave, function() -- Line: 773
                -- upvalues: Tweens (ref), v (copy), Size (copy)
                Tweens.TweenSize(0.25, "Sine", { v }, Size);
            end);
            u46.BaseTrove:Connect(v.Button.MouseButton1Click, function() -- Line: 777
                -- upvalues: u46 (copy), v (copy), Tweens (ref), Size (copy)
                u46:Open((tostring(v)));
                Tweens.TweenSize(0.1, "Sine", { v }, UDim2.new(Size.X.Scale * 0.85, 0, Size.Y.Scale * 0.85, 0));
                task.delay(0.1, function() -- Line: 780
                    -- upvalues: Tweens (ref), v (ref), Size (ref)
                    Tweens.TweenSize(0.1, "Sine", { v }, Size);
                end);
            end);
        end;
    end;
end;

function u3.KnitStart(u47) -- Line: 788
    -- upvalues: LocalPlayer (copy), Knit (copy), workspace_CurrentCamera (copy), u2 (ref), environment (copy), TweenService (copy), Debris (copy), Popup (copy), SocialService (copy), Essentials (copy), ReplicatedStorage (copy), UserInputService (copy), updateTeamScore (copy)
    local InGameUI = LocalPlayer.PlayerGui:WaitForChild("InGameUI");
    local HUD = LocalPlayer.PlayerGui:WaitForChild("HUD");
    local Service = Knit.GetService("EffectsService");
    u47.FlowService = Knit.GetService("FlowService");
    u47.Settings = Knit.GetController("Settings");
    u47.Camera = Knit.GetController("CameraController");
    u47.Spectator = Knit.GetController("SpectatorController");
    u47.EmoteService = Knit.GetService("EmoteService");
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    local u48 = tick();
    u47.BaseTrove:Connect(workspace:WaitForChild("SelectTeam").Touched, function(p49) -- Line: 803
        -- upvalues: u2 (ref), environment (ref), LocalPlayer (ref), u48 (ref), workspace_CurrentCamera (ref), TweenService (ref), Debris (ref), Popup (ref), u47 (copy)
        if p49.Parent ~= u2 then
            return;
        end;

        if environment.mode == "Ranked" then
            return;
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if u48 > tick() then
            return;
        end;

        u48 = tick() + 1;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        task.spawn(function() -- Line: 813
            -- upvalues: TweenService (ref), Debris (ref)
            if not game.Lighting:FindFirstChild("Blur") then
                return;
            end;

            local v50 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = 3
            });
            v50:Play();
            Debris:AddItem(v50, 0.1);
        end);
        local v51 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 70
        });
        v51:Play();
        Debris:AddItem(v51, 0.1);
        Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", nil, 2);
        Popup.BlackoutLocal(LocalPlayer, "Tp1", "Tp2", true, 2);
        u47.EmoteService.EndEmote:Fire();
        u47.Spectator:StopSpectating(true);
        task.delay(0.375, function() -- Line: 836
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), Debris (ref), LocalPlayer (ref)
            local v52 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = workspace:WaitForChild("TeamSelect").CFrame
            });
            v52:Play();
            Debris:AddItem(v52, 0.25);
            LocalPlayer.PlayerGui.HUD.Enabled = false;
            LocalPlayer.PlayerGui.PickTeam.Enabled = true;
        end);
    end);
    u47.BaseTrove:Connect(LocalPlayer.PlayerGui.InGameUI.Invite.MouseButton1Click, function() -- Line: 848
        -- upvalues: SocialService (ref), LocalPlayer (ref)
        SocialService:PromptGameInvite(LocalPlayer);
    end);
    TweenService:Create(LocalPlayer.PlayerGui.Style.BG.BuySpins.UIGradient, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
        Rotation = 180
    }):Play();
    LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.LevelAmount.Text = "Level " .. tostring(LocalPlayer.ProfileStats.Level.Value);
    local EXPAmount = LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.EXPAmount;
    local v53 = math.round(LocalPlayer.ProfileStats.Exp.Value) .. "/" .. tostring(LocalPlayer.ProfileStats.Level.Value * 80);
    EXPAmount.Text = tostring(v53);
    LocalPlayer.PlayerGui.HUD.Top.Currencies.Yen.Amount.Text = "$" .. Essentials:formatNumberWithCommas((math.round(LocalPlayer.ProfileStats.Money.Value)));
    LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.Exp.Bar.Size = UDim2.new(LocalPlayer.ProfileStats.Exp.Value / (LocalPlayer.ProfileStats.Level.Value * 80), 0, 1, 0);
    require(ReplicatedStorage.Shared.environment);
    u47.BaseTrove:Connect(LocalPlayer.ProfileStats.Money:GetPropertyChangedSignal("Value"), function() -- Line: 865
        -- upvalues: LocalPlayer (ref), Essentials (ref)
        LocalPlayer.PlayerGui.HUD.Top.Currencies.Yen.Amount.Text = "$" .. Essentials:formatNumberWithCommas((math.round(LocalPlayer.ProfileStats.Money.Value)));
    end);
    u47.BaseTrove:Connect(LocalPlayer.ProfileStats.Exp:GetPropertyChangedSignal("Value"), function() -- Line: 869
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.LevelAmount.Text = "Level " .. tostring(LocalPlayer.ProfileStats.Level.Value);
        local EXPAmount2 = LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.EXPAmount;
        local v54 = math.round(LocalPlayer.ProfileStats.Exp.Value) .. "/" .. tostring(LocalPlayer.ProfileStats.Level.Value * 80);
        EXPAmount2.Text = tostring(v54);
        LocalPlayer.PlayerGui.HUD.Top.Currencies.Level.Exp.Bar.Size = UDim2.new(LocalPlayer.ProfileStats.Exp.Value / (LocalPlayer.ProfileStats.Level.Value * 80), 0, 1, 0);
    end);
    u47.BaseTrove:Connect(LocalPlayer:GetPropertyChangedSignal("Team"), function() -- Line: 875
        -- upvalues: LocalPlayer (ref), u47 (copy), workspace_CurrentCamera (ref), UserInputService (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            if UserInputService.TouchEnabled then
                LocalPlayer.PlayerGui.Mobile.Enabled = true;
                LocalPlayer.PlayerGui.Mobile.NoBall.Visible = true;
                LocalPlayer.PlayerGui.Mobile.Ball.Visible = false;
            end;

            return;
        end;

        u47.Camera:SetShiftlock(false);
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.Mobile.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    end);
    InGameUI.Scoreboard.Timer.TextLabel.Text = Essentials:formatTime(ReplicatedStorage.GameValues.Timer.Value);
    updateTeamScore(InGameUI);
    local StaminaBar = LocalPlayer.PlayerGui.StaminaBar;
    StaminaBar.AccelerationBG:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() -- Line: 897
        -- upvalues: StaminaBar (copy)
        local BackgroundTransparency = StaminaBar.AccelerationBG.BackgroundTransparency;
        StaminaBar.AccelerationBG.Tier1.BackgroundTransparency = BackgroundTransparency;
        StaminaBar.AccelerationBG.Tier2.BackgroundTransparency = BackgroundTransparency;
        StaminaBar.AccelerationBG.Tier3.BackgroundTransparency = BackgroundTransparency;
    end);
    u47.BaseTrove:Connect(Service.Popup, function(p55, p56) -- Line: 904
        -- upvalues: LocalPlayer (ref), u47 (copy), Popup (ref)
        if LocalPlayer.Team == game.Teams.Visitor and not u47.Spectator.IsSpectating then
            return;
        end;

        Popup.PopTxt(LocalPlayer, p55);
    end);
    u47:Heartbeat(InGameUI, HUD);
    u47:Controls();
    u47:Scale();
    u47:HUD();
    u47:Close();
    local script_UIStrokeAdjuster = require(script.UIStrokeAdjuster);

    for _, child in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if child:IsA("ScreenGui") or child:IsA("BillboardGui") then
            task.spawn(function() -- Line: 918
                -- upvalues: script_UIStrokeAdjuster (copy), child (copy)
                script_UIStrokeAdjuster:TagScreenGui(child);
            end);
        end;
    end;
end;

function u3.KnitInit(u57) -- Line: 925
    -- upvalues: Trove (copy), u1 (ref), Knit (copy), LocalPlayer (copy), HumanoidRootPart (ref), u2 (ref), Humanoid (ref), workspace_CurrentCamera (copy)
    u57.BaseTrove = Trove.new();
    u1 = Knit.GetController("StatesController");
    LocalPlayer.PlayerGui.StaminaBar.Adornee = HumanoidRootPart;
    LocalPlayer.PlayerGui.MoneyPopups.Adornee = HumanoidRootPart;
    LocalPlayer.PlayerGui.MoneyPopups.Enabled = true;
    u57.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p58) -- Line: 933
        -- upvalues: u2 (ref), Humanoid (ref), HumanoidRootPart (ref), workspace_CurrentCamera (ref), LocalPlayer (ref)
        u2 = p58;
        Humanoid = u2:WaitForChild("Humanoid");
        HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        LocalPlayer.PlayerGui.StaminaBar.Adornee = HumanoidRootPart;
        LocalPlayer.PlayerGui.MoneyPopups.Adornee = HumanoidRootPart;
    end);
    u57.BaseTrove:Connect(game.Players.PlayerRemoving, function(p59) -- Line: 946
        -- upvalues: LocalPlayer (ref), u2 (ref), HumanoidRootPart (ref), Humanoid (ref), u57 (copy)
        if p59 == LocalPlayer then
            u2 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u57.BaseTrove:Destroy();
        end;
    end);
end;

return u3;