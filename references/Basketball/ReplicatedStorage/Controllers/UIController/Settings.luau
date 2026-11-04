 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
game:GetService("GuiService");
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local RelicsXYZ = require(ReplicatedStorage.Packages.RelicsXYZ);
local Trove = require(ReplicatedStorage.Packages.Trove);
local CustomScrollbar = require(ReplicatedStorage.Shared.Utility.CustomScrollbar);
require(ReplicatedStorage.Shared.Utility.Essentials);
local TopbarPlus = require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local DefaultKeybinds = require(ReplicatedStorage.Shared.Tables.DefaultKeybinds);
local Mouse = LocalPlayer:GetMouse();
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Settings"):WaitForChild("Content");
local u1 = CustomScrollbar.new(Content:WaitForChild("Settings"):WaitForChild("Content"), Content.Settings:WaitForChild("Scrollbar"));
local u2 = CustomScrollbar.new(Content:WaitForChild("Keybinds"):WaitForChild("Content"), Content.Keybinds:WaitForChild("Scrollbar"));
local u3 = Knit.CreateController({
    Name = "SettingsController"
});

function u3.OpenGui() -- Line: 47
    -- upvalues: u3 (copy), Content (copy), u1 (copy), u2 (copy)
    u3.CloseGui();
    Content.Parent.Enabled = true;
    u1:Start();
    u2:Start();
end;

function u3.CloseGui() -- Line: 56
    -- upvalues: Content (copy), u1 (copy), u2 (copy)
    Content.Parent.Enabled = false;
    u1:Stop();
    u2:Stop();
end;

function u3.SetupSwitchGui(u4, u5) -- Line: 63
    -- upvalues: Knit (copy), ReplicatedStorage (copy)
    local Controller = Knit.GetController("Network");
    local u6 = nil;

    local function UpdateValue(p7: boolean, p8: boolean?) -- Line: 67
        -- upvalues: u6 (ref), u5 (copy), u4 (copy), Controller (copy), Knit (ref)
        if u6 == p7 then
            return;
        end;

        u6 = p7;
        u5.Button.On.ImageTransparency = p7 == true and 0 or 0.65;
        u5.Button.Off.ImageTransparency = p7 == false and 0 or 0.65;

        if u4.PSOption and p8 then
            return;
        end;

        if u4.OnChangedCallback then
            u4.OnChangedCallback(p7);
        end;

        if u4.SettingIndex ~= nil and p7 ~= Controller.Player.Customization.Settings[u4.SettingIndex] then
            Knit.GetService("SettingsService"):UpdateSetting(u4.SettingIndex, p7);
        end;
    end;

    local ForcedDefaultValue = u4.ForcedDefaultValue;

    if not ForcedDefaultValue then
        if u4.SettingIndex == nil then
            ForcedDefaultValue = false;
        else
            ForcedDefaultValue = Controller.Player.Customization.Settings[u4.SettingIndex];
        end;
    end;

    UpdateValue(ForcedDefaultValue, true);
    u5.Button.On.MouseButton1Click:Connect(function() -- Line: 91
        -- upvalues: UpdateValue (copy)
        UpdateValue(true);
    end);
    u5.Button.Off.MouseButton1Click:Connect(function() -- Line: 94
        -- upvalues: UpdateValue (copy)
        UpdateValue(false);
    end);

    if u4.SettingIndex ~= nil then
        ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 99
            -- upvalues: Controller (copy), u4 (copy), u6 (ref), UpdateValue (copy)
            if Controller.Player.Customization.Settings[u4.SettingIndex] ~= u6 then
                UpdateValue(Controller.Player.Customization.Settings[u4.SettingIndex]);
            end;
        end);
    end;

    if u4.PSSettingIndex ~= nil then
        ReplicatedStorage.PSSettings:GetAttributeChangedSignal(u4.PSSettingIndex):Connect(function() -- Line: 107
            -- upvalues: UpdateValue (copy), ReplicatedStorage (ref), u4 (copy)
            UpdateValue(ReplicatedStorage.PSSettings:GetAttribute(u4.PSSettingIndex), true);
        end);
        UpdateValue(ReplicatedStorage.PSSettings:GetAttribute(u4.PSSettingIndex), true);
    end;

    if u4.UpdateSignal ~= nil then
        u4.UpdateSignal:Connect(function() -- Line: 115
            -- upvalues: UpdateValue (copy), u4 (copy)
            UpdateValue(u4.Update(), true);
        end);
        UpdateValue(u4.Update(), true);
    end;
end;

function u3.SetupSliderGui(u9, u10) -- Line: 123
    -- upvalues: Trove (copy), Knit (copy), RunService (copy), Mouse (copy), UserInputService (copy), ReplicatedStorage (copy)
    local u11 = nil;
    local u12 = false;
    local u13 = Trove.new();

    local function u16(p14: number, p15: boolean?) -- Line: 128
        -- upvalues: u11 (ref), u10 (copy), u9 (copy)
        if u11 == p14 then
            return;
        end;

        u11 = p14;
        u10.Slider.Background.Bar.Size = UDim2.fromScale((p14 - u9.MinValue) / (u9.MaxValue - u9.MinValue), 0.6);
        u10.Slider.Outline.Value.Text = `{p14}{u9.Unit}`;

        if u9.PSOption and p15 then
            return;
        end;

        u9.OnChangedCallback(p14);
    end;

    local Controller = Knit.GetController("Network");
    u16(Controller.Player.Customization.Settings[u9.SettingIndex], true);
    u10.Slider.Button.MouseButton1Down:Connect(function() -- Line: 151
        -- upvalues: u12 (ref), u10 (copy), u13 (copy), RunService (ref), Mouse (ref), u9 (copy), u16 (copy)
        u12 = true;
        local X = u10.Slider.Outline.AbsolutePosition.X;
        local u17 = X + u10.Slider.Outline.AbsoluteSize.X;
        u13:Add(RunService.RenderStepped:Connect(function() -- Line: 157
            -- upvalues: Mouse (ref), X (copy), u17 (copy), u9 (ref), u16 (ref)
            local math_clamp_ret = math.clamp((Mouse.X - X) / (u17 - X), 0, 1);
            u16(math.round((u9.MinValue + (u9.MaxValue - u9.MinValue) * math_clamp_ret) / u9.Increment) * u9.Increment);
        end));
    end);
    UserInputService.InputEnded:Connect(function(p18) -- Line: 165
        -- upvalues: u12 (ref), u13 (copy), Controller (copy), u9 (copy), u11 (ref), Knit (ref)
        if p18.UserInputType ~= Enum.UserInputType.MouseButton1 and (p18.UserInputType ~= Enum.UserInputType.Touch and (p18.UserInputType.Value < 12 or p18.UserInputType.Value > 20)) then
            return;
        end;

        if not u12 then
            return;
        end;

        u12 = false;
        u13:Clean();

        if Controller.Player.Customization.Settings[u9.SettingIndex] ~= u11 then
            Knit.GetService("SettingsService"):UpdateSetting(u9.SettingIndex, u11);
        end;
    end);

    if u9.SettingIndex ~= nil then
        ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 191
            -- upvalues: Controller (copy), u9 (copy), u11 (ref), u16 (copy)
            if Controller.Player.Customization.Settings[u9.SettingIndex] ~= u11 then
                u16(Controller.Player.Customization.Settings[u9.SettingIndex]);
            end;
        end);
    end;

    if u9.PSSettingIndex ~= nil then
        ReplicatedStorage.PSSettings:GetAttributeChangedSignal(u9.PSSettingIndex):Connect(function() -- Line: 199
            -- upvalues: u16 (copy), ReplicatedStorage (ref), u9 (copy)
            u16(ReplicatedStorage.PSSettings:GetAttribute(u9.PSSettingIndex), true);
        end);
        u16(ReplicatedStorage.PSSettings:GetAttribute(u9.PSSettingIndex), true);
    end;

    if u9.UpdateSignal ~= nil then
        u9.UpdateSignal:Connect(function() -- Line: 207
            -- upvalues: u16 (copy), u9 (copy)
            u16(u9.Update(), true);
        end);
        u16(u9.Update(), true);
    end;
end;

function u3.SetupTextBoxGui(u19, u20) -- Line: 215
    -- upvalues: Knit (copy), ReplicatedStorage (copy)
    local Controller = Knit.GetController("Network");
    local Settings = Controller.Player.Customization.Settings;
    local u21 = nil;

    local function u24(p22: string, p23: boolean?) -- Line: 220
        -- upvalues: u20 (copy), u21 (ref), u19 (copy), Controller (copy), Knit (ref)
        u20.TextBox.Text = p22 or "";

        if u21 == p22 then
            return;
        end;

        u21 = p22;

        if u19.PSOption and p23 then
            return;
        end;

        u19.OnChangedCallback(p22);

        if u19.SettingIndex ~= nil and Controller.Player.Customization.Settings[u19.SettingIndex] ~= u21 then
            Knit.GetService("SettingsService"):UpdateSetting(u19.SettingIndex, u21);
        end;
    end;

    if u19.DisableInitialUpdate ~= true then
        local ForcedDefaultValue = u19.ForcedDefaultValue;

        if not ForcedDefaultValue then
            if u19.SettingIndex == nil then
                ForcedDefaultValue = false;
            else
                ForcedDefaultValue = Settings[u19.SettingIndex];
            end;
        end;

        u24(ForcedDefaultValue, true);
    end;

    u20.TextBox.PlaceholderText = u19.PlaceholderText;
    u20.TextBox.ReturnPressedFromOnScreenKeyboard:Connect(function() -- Line: 245
        -- upvalues: u24 (copy), u20 (copy)
        u24(u20.TextBox.Text);
    end);
    u20.TextBox.FocusLost:Connect(function() -- Line: 248
        -- upvalues: u20 (copy), u19 (copy), u24 (copy), u21 (ref)
        if u20.TextBox.Text == "" and not u19.AllowBlanking then
            u24(u21);

            return;
        end;

        u24(u20.TextBox.Text);
    end);

    if u19.SettingIndex ~= nil then
        ReplicatedStorage.Controllers.NewData.Changed:Connect(function() -- Line: 257
            -- upvalues: Controller (copy), u19 (copy), u21 (ref), u24 (copy)
            if Controller.Player.Customization.Settings[u19.SettingIndex] ~= u21 then
                u24(Controller.Player.Customization.Settings[u19.SettingIndex]);
            end;
        end);
    end;

    if u19.PSSettingIndex ~= nil then
        ReplicatedStorage.PSSettings:GetAttributeChangedSignal(u19.PSSettingIndex):Connect(function() -- Line: 265
            -- upvalues: u24 (copy), ReplicatedStorage (ref), u19 (copy)
            u24(ReplicatedStorage.PSSettings:GetAttribute(u19.PSSettingIndex), true);
        end);
        u24(ReplicatedStorage.PSSettings:GetAttribute(u19.PSSettingIndex), true);
    end;

    if u19.UpdateSignal ~= nil then
        u19.UpdateSignal:Connect(function() -- Line: 273
            -- upvalues: u24 (copy), u19 (copy)
            u24(u19.Update(), true);
        end);
        u24(u19.Update(), true);
    end;
end;

function u3.SetupButtonGui(u25, u26) -- Line: 281
    u26.Button.Button.Text = u25.ButtonText or "";
    u26.Button.Button.MouseButton1Click:Connect(function() -- Line: 284
        -- upvalues: u25 (copy), u26 (copy)
        if u25.OnClicked then
            task.spawn(u25.OnClicked, u25, u26);
        end;
    end);
end;

function u3.CreateSetting(u27: table) -- Line: 293
    -- upvalues: u3 (copy), Content (copy), MarketplaceService (copy), LocalPlayer (copy)
    local u28 = nil;
    local u29 = nil;

    if u27.Type == "Switch" then
        u28 = script.SettingSwitch:Clone();
        u29 = u3.SetupSwitchGui;
    elseif u27.Type == "Slider" then
        u28 = script.SettingSlider:Clone();
        u29 = u3.SetupSliderGui;
    elseif u27.Type == "TextBox" then
        u28 = script.SettingTextBox:Clone();
        u29 = u3.SetupTextBoxGui;
    elseif u27.Type == "Button" then
        u28 = script.SettingButton:Clone();
        u29 = u3.SetupButtonGui;
    elseif u27.Type == "Category" then
        u28 = script.SettingCategory:Clone();

        u29 = function() -- Line: 311
        end;
    end;

    if u27.Type ~= "Category" then
        u28.Description.Text = u27.Description;
    end;

    u28.Title.Text = u27.Title;
    u28.LayoutOrder = 0;
    u28.Parent = Content.Settings.Content;

    if u27.LockedReason then
        local function CreateLockedBuyGui(p30: string, u31: number, u32: string) -- Line: 323
            -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u28 (ref), u29 (ref), u27 (copy)
            local u33 = script.LockedBuy:Clone();
            u33.Container.Reason.Text = p30;
            u33.Container.Buy.MouseButton1Down:Connect(function() -- Line: 326
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), u31 (copy)
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, u31);
            end);
            u33.Parent = u28;
            task.spawn(function() -- Line: 331
                -- upvalues: u33 (copy), MarketplaceService (ref), u31 (copy)
                local TextLabel = u33.Container.Buy.TextLabel;
                local PriceInRobux = MarketplaceService:GetProductInfo(u31, Enum.InfoType.GamePass).PriceInRobux;
                TextLabel.Text = `{utf8.char(57346)}{PriceInRobux}`;
            end);
            local u34 = nil;
            u34 = LocalPlayer:GetAttributeChangedSignal(u32):Connect(function() -- Line: 338
                -- upvalues: LocalPlayer (ref), u32 (copy), u34 (ref), u33 (copy), u29 (ref), u27 (ref), u28 (ref)
                if LocalPlayer:GetAttribute(u32) ~= true then
                    return;
                end;

                u34:Disconnect();
                u33:Destroy();
                u29(u27, u28);
            end);
        end;

        local u35 = nil;
        local u36;

        if typeof(u27.LockedReason) == "function" then
            u36, u35 = u27.LockedReason();
        else
            u36 = u27.LockedReason;
        end;

        if u36 == "!PS+" then
            CreateLockedBuyGui("PrivateServers+ Gamepass Needed", 1128008025, "HasPrivateServerPlus");
        elseif u36 == "!CustomGoal" then
            CreateLockedBuyGui("Custom Goal Effect SFX Gamepass Needed", 1173405252, "HasCustomGoalSFX");
        elseif u36 == "!CustomAnkle" then
            CreateLockedBuyGui("Custom Ankle Break SFX Gamepass Needed", 1174790953, "HasCustomAnkleBreakSFX");
        elseif u36 == "!CustomBlock" then
            CreateLockedBuyGui("Custom Block SFX Gamepass Needed", 1174129054, "HasCustomBlockSFX");
        elseif u36 ~= nil then
            local u37 = script.Locked:Clone();
            u37.Reason.Text = u36;
            u37.Parent = u28;
            local u38 = { u35 };
            local u39 = nil;

            local function update() -- Line: 374
                -- upvalues: u36 (ref), u35 (ref), u27 (copy), u37 (copy), u28 (ref), u38 (copy), u39 (ref), update (copy)
                local v40, v41 = u27.LockedReason();
                u36 = v40;
                u35 = v41;

                if u36 == nil then
                    u37.Parent = nil;
                else
                    u37.Reason.Text = u36;
                    u37.Parent = u28;
                end;

                if u35 and not table.find(u38, u35) then
                    if u39 then
                        u39:Disconnect();
                    end;

                    u39 = u35:Connect(update);
                end;
            end;

            if u35 then
                u35:Connect(update);
            end;
        end;
    end;

    u29(u27, u28);

    return u28;
end;

function u3.KnitInit(p42) -- Line: 406
    -- upvalues: TopbarPlus (copy), Content (copy), u3 (copy)
    TopbarPlus.new():setName("Settings"):setImage(125540873446932):oneClick(true):setImageScale(0.7):setOrder(0).toggled:Connect(function(p43) -- Line: 414
        -- upvalues: Content (ref), u3 (ref)
        if not p43 then
            return;
        end;

        if Content.Parent.Enabled then
            u3.CloseGui();

            return;
        end;

        u3.OpenGui();
    end);
end;

function u3.KnitStart(u44) -- Line: 427
    -- upvalues: Knit (copy), UserInputService (copy), ReplicatedStorage (copy), Trove (copy), DefaultKeybinds (copy), Content (copy), u3 (copy), RunService (copy), SoundService (copy), RelicsXYZ (copy), LocalPlayer (copy), Lighting (copy), Players (copy), Effects (copy)
    local Controller = Knit.GetController("MusicController");
    Knit.GetController("MovementController");
    local Controller2 = Knit.GetController("Network");
    local Controller3 = Knit.GetController("KeybindsController");
    local Controller4 = Knit.GetController("InGameQuestsController");

    if UserInputService.GamepadEnabled or UserInputService.TouchEnabled then
        task.spawn(function() -- Line: 435
            -- upvalues: ReplicatedStorage (ref)
            task.wait(1);

            for _, descendant in ReplicatedStorage.Assets.VFX:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Rate = descendant.Rate / 1.5;
                end;
            end;

            for _, descendant in ReplicatedStorage.Effects:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Rate = descendant.Rate / 1.5;
                end;
            end;

            local function optimize() -- Line: 450
                for _, child in workspace:WaitForChild("Map1"):WaitForChild("Buildings"):GetChildren() do
                    if child.Name == "LowGfx" then
                        child:Destroy();
                    end;
                end;

                for i, child in workspace.Map1.Foliage:GetChildren() do
                    if i % 3 == 0 then
                        child:Destroy();
                    end;
                end;
            end;

            if workspace:WaitForChild("Map1", 5) then
                optimize();

                return;
            end;

            local u45 = nil;
            u45 = workspace.ChildAdded:Connect(function(p46) -- Line: 468
                -- upvalues: u45 (ref), optimize (copy)
                if p46.Name == "Map1" then
                    u45:Disconnect();
                    optimize();
                end;
            end);

            if workspace:WaitForChild("Map3", 5) then
                for i, child in workspace.Map3.Foliage:GetChildren() do
                    if i % 3 == 0 then
                        child:Destroy();
                    end;
                end;
            end;
        end);
    end;

    local u47 = Trove.new();
    require(ReplicatedStorage.Shared.Tables.KeybindIcons);
    Controller3.GetPlatform();
    local v48 = { "Ability", "Pass Teammate" };

    for i in DefaultKeybinds do
        Controller3.GetInputs(i);
        local u49 = i;
        local v50 = 0;

        for i2, v in v48 do
            if string.find(u49, v) then
                local string_sub_ret = string.sub(u49, -1, -1);
                v50 = i2 * 100 + tonumber(string_sub_ret);
                break;
            end;
        end;

        local v51 = script.Keybind:Clone();
        v51.Name = u49;
        v51.LayoutOrder = v50;
        v51.Reset.Visible = false;
        v51.KeybindText.InputName.Text = u49;
        v51.Parent = Content.Keybinds.Content;
        local KeybindIcon = Controller3.GetKeybindIcon(u49);

        if KeybindIcon == nil then
            v51.Visible = false;
        else
            v51.KeybindInput.InputIcon.Image = KeybindIcon;
            v51.KeybindInput.InputIcon.Visible = true;
            v51.KeybindInput.Input.Visible = false;
        end;

        v51.KeybindInput.MouseButton1Click:Connect(function() -- Line: 524
            -- upvalues: u47 (copy), Content (ref), u49 (copy), UserInputService (ref), Controller3 (copy)
            u47:Clean();
            Content.KeybindConfirmation.Visible = true;
            Content.KeybindConfirmation.Text = `Rebinding {u49}...`;
            u47:Add(function() -- Line: 530
                -- upvalues: Content (ref)
                Content.KeybindConfirmation.Visible = false;
            end);
            u47:Add(UserInputService.InputBegan:Connect(function(p52, p53) -- Line: 533
                -- upvalues: Controller3 (ref), u49 (ref), u47 (ref)
                local Platform = Controller3.GetPlatform();

                if not (p53 or p52.KeyCode == Enum.KeyCode.Unknown and p52.UserInputType == Enum.UserInputType.None) and Platform ~= "Touchscreen" then
                    Controller3:ChangeKeybind(u49, p52.KeyCode ~= Enum.KeyCode.Unknown and p52.KeyCode or p52.UserInputType, Platform);
                    u47:Clean();
                end;
            end));
        end);
        v51.Reset.MouseButton1Click:Connect(function() -- Line: 545
            -- upvalues: Controller3 (copy), u49 (copy)
            Controller3.RemoveKeybind(u49, Controller3.GetPlatform());
        end);
    end;

    local function UpdateKeybinds() -- Line: 550
        -- upvalues: Controller3 (copy), DefaultKeybinds (ref), Content (ref)
        local Platform = Controller3.GetPlatform();

        for i, v in DefaultKeybinds do
            local Inputs = Controller3.GetInputs(i);
            local v54 = Content.Keybinds.Content:FindFirstChild(i);
            local KeybindIcon = Controller3.GetKeybindIcon(i);

            if KeybindIcon == nil then
                v54.Visible = false;
            else
                v54.Visible = true;
                v54.KeybindInput.InputIcon.Image = KeybindIcon;
                v54.KeybindInput.InputIcon.Visible = true;
                v54.KeybindInput.Input.Visible = false;
                v54.Reset.Visible = Inputs[Platform] ~= v[Platform];
            end;
        end;
    end;

    local Service = Knit.GetService("SettingsService");
    Service.KeybindsChanged:Connect(UpdateKeybinds);

    local function OnDeviceChanged() -- Line: 576
        -- upvalues: Controller3 (copy), Content (ref), UpdateKeybinds (copy)
        local Platform = Controller3.GetPlatform();
        local v55 = Platform ~= "Touchscreen";
        Content.Keybinds.Visible = v55;
        Content.Keybinds_Background.Visible = v55;
        Content.Keybinds_Outline.Visible = v55;
        Content.Keybinds_Title.Visible = v55;
        Content.ResetKeybinds.Visible = v55;

        for i = 1, 4 do
            Content.Keybinds.Content:FindFirstChild((`Pass Teammate {i}`)).Visible = Platform == "Keyboard";
            local _ = i;
        end;

        UpdateKeybinds();
    end;

    task.spawn(OnDeviceChanged);
    Controller3.PlatformChanged:Connect(OnDeviceChanged);
    Content.ResetKeybinds.MouseButton1Click:Connect(function() -- Line: 596
        -- upvalues: Controller3 (copy), DefaultKeybinds (ref)
        local Platform = Controller3.GetPlatform();

        for i, _ in DefaultKeybinds do
            Controller3.RemoveKeybind(i, Platform);
        end;
    end);
    u3.CreateSetting({
        Type = "Category",
        Title = "Audio"
    });

    if RunService:IsStudio() then
        Service:UpdateSetting("Music", 0);
    end;

    u3.CreateSetting({
        Type = "Slider",
        Title = "Music Volume",
        Description = "Changes how loud the background music is",
        SettingIndex = "Music",
        Increment = 5,
        MinValue = 0,
        MaxValue = 150,
        Unit = "%",

        OnChangedCallback = function(p56: number) -- Line: 625, Name: OnChangedCallback
            -- upvalues: Controller (copy)
            Controller:AdjustGroupVolume(p56 / 100);
        end
    });
    u3.CreateSetting({
        Type = "Slider",
        Title = "Custom SFX Volume",
        Description = "Changes how loud custom player sound effects are",
        SettingIndex = "CustomSFX",
        Increment = 5,
        MinValue = 0,
        MaxValue = 150,
        Unit = "%",

        OnChangedCallback = function(p57: number) -- Line: 640, Name: OnChangedCallback
            -- upvalues: SoundService (ref)
            SoundService.CustomSounds.Volume = p57 / 100;
        end
    });
    u3.CreateSetting({
        Type = "Slider",
        Title = "Match SFX Volume",
        Description = "Changes how loud match sound effects are",
        SettingIndex = "MatchSFX",
        Increment = 5,
        MinValue = 0,
        MaxValue = 150,
        Unit = "%",

        OnChangedCallback = function(p58: number) -- Line: 655, Name: OnChangedCallback
            -- upvalues: SoundService (ref)
            SoundService.MatchSounds.Volume = p58 / 100;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Emote Music",
        Description = "Toggles emote music",
        SettingIndex = "EmoteMusic",

        OnChangedCallback = function(p59: boolean) -- Line: 666, Name: OnChangedCallback
            -- upvalues: SoundService (ref)
            SoundService.EmoteMusicSounds.Volume = p59 and 1 or 0;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Boombox Music",
        Description = "Toggles other players\' boombox music",
        SettingIndex = "BoomboxMusic",

        OnChangedCallback = function(p60: boolean) -- Line: 677, Name: OnChangedCallback
            -- upvalues: RelicsXYZ (ref)
            RelicsXYZ.ChangeSettingAsync("GlobalMute", not p60);
        end
    });
    u3.CreateSetting({
        Type = "Category",
        Title = "Gameplay"
    });
    local u62 = u3.CreateSetting({
        Type = "Switch",
        Title = "Pass To Teammate Keybinds",
        Description = "Enables passing to teammates using your keyboard",
        SettingIndex = "KeybindPassing",

        OnChangedCallback = function(p61: boolean) -- Line: 705, Name: OnChangedCallback
        end
    });
    u62.UIGradient.Color = ColorSequence.new(Color3.fromRGB(176, 113, 57), Color3.fromRGB(255, 167, 44));
    u3.CreateSetting({
        Type = "Switch",
        Title = "Emote Popup",
        Description = "Toggles whether the UI popup after scoring pops up",
        SettingIndex = "EmotePopup",

        OnChangedCallback = function(p63: boolean) -- Line: 718, Name: OnChangedCallback
            -- upvalues: u44 (copy)
            u44.EmotePopup = p63;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Controls Manual",
        Description = "Toggles whether the controls manual in the bottom right is visible",
        SettingIndex = "ControlsManual",

        OnChangedCallback = function(p64: boolean) -- Line: 729, Name: OnChangedCallback
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.PlayerGui:WaitForChild("InGame"):WaitForChild("BG"):WaitForChild("Controls").Visible = p64;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Match Quests",
        Description = "Toggles whether the quests on the left side are visible during matches",
        SettingIndex = "MatchQuests",

        OnChangedCallback = function(p65: boolean) -- Line: 740, Name: OnChangedCallback
            -- upvalues: Controller4 (copy)
            Controller4:SetVisible(p65);
        end
    });
    u3.CreateSetting({
        Type = "Category",
        Title = "Graphics"
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Global Shadows",
        Description = "Toggles whether shadows are enabled",
        SettingIndex = "GlobalShadows",

        OnChangedCallback = function(p66: boolean) -- Line: 757, Name: OnChangedCallback
            -- upvalues: Lighting (ref)
            Lighting.GlobalShadows = p66;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Low Quality Map",
        Description = "Disables maps and replaces them with low-quality alternates",
        SettingIndex = "LowQualityMap",

        OnChangedCallback = function(p67: boolean) -- Line: 769, Name: OnChangedCallback
            -- upvalues: ReplicatedStorage (ref)
            workspace:SetAttribute("LowQualityMap", p67);

            if p67 then
                ReplicatedStorage.LowQualityMap:Clone().Parent = workspace;
                local MapFolder = workspace:FindFirstChild("MapFolder");

                if MapFolder then
                    MapFolder.Parent = ReplicatedStorage;
                end;
            else
                local LowQualityMap = workspace:FindFirstChild("LowQualityMap");

                if LowQualityMap then
                    LowQualityMap:Destroy();
                end;

                local MapFolder = ReplicatedStorage:FindFirstChild("MapFolder");

                if MapFolder then
                    MapFolder.Parent = workspace;
                end;
            end;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Low Quality VFX",
        Description = "Reduces emit rate on VFX",
        SettingIndex = "LowQualityVFX",

        OnChangedCallback = function(p68: boolean) -- Line: 802, Name: OnChangedCallback
            workspace:SetAttribute("LowQualityVFX", p68);
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Night Mode",
        Description = "Toggles whether the in-game time is always set to night",
        SettingIndex = "NightMode",

        OnChangedCallback = function(p69: boolean) -- Line: 814, Name: OnChangedCallback
            -- upvalues: u44 (copy), Lighting (ref)
            workspace:SetAttribute("NightMode", p69);

            if p69 then
                u44.ClockTime = Lighting.ClockTime;
                Lighting.ClockTime = 0;
                local MapFolder = workspace:FindFirstChild("MapFolder");

                if MapFolder then
                    for _, descendant in MapFolder:GetDescendants() do
                        if descendant:IsA("SurfaceLight") then
                            if not descendant:GetAttribute("Brightness") then
                                descendant:SetAttribute("Brightness", descendant.Brightness);
                            end;

                            descendant.Brightness = descendant:GetAttribute("Brightness") * 0.25;
                        end;
                    end;
                end;
            else
                if u44.ClockTime then
                    Lighting.ClockTime = u44.ClockTime;
                end;

                local MapFolder = workspace:FindFirstChild("MapFolder");

                if MapFolder then
                    for _, descendant in MapFolder:GetDescendants() do
                        if descendant:IsA("SurfaceLight") then
                            if not descendant:GetAttribute("Brightness") then
                                descendant:SetAttribute("Brightness", descendant.Brightness);
                            end;

                            descendant.Brightness = descendant:GetAttribute("Brightness");
                        end;
                    end;
                end;
            end;
        end
    });
    workspace.ChildAdded:Connect(function(p70) -- Line: 854
        -- upvalues: ReplicatedStorage (ref)
        if p70.Name == "MapFolder" then
            if workspace:GetAttribute("LowQualityMap") then
                local MapFolder = ReplicatedStorage:FindFirstChild("MapFolder");

                if MapFolder then
                    MapFolder:Destroy();
                end;

                p70.Parent = ReplicatedStorage;

                return;
            end;

            if workspace:GetAttribute("NightMode") then
                for _, descendant in p70:GetDescendants() do
                    if descendant:IsA("SurfaceLight") then
                        if not descendant:GetAttribute("Brightness") then
                            descendant:SetAttribute("Brightness", descendant.Brightness);
                        end;

                        descendant.Brightness = descendant:GetAttribute("Brightness") * 0.25;
                    end;
                end;
            end;
        end;
    end);
    Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function() -- Line: 877
        -- upvalues: Lighting (ref), u44 (copy)
        if not workspace:GetAttribute("NightMode") then
            u44.ClockTime = Lighting.ClockTime;

            return;
        end;

        if Lighting.ClockTime == 0 then
            return;
        end;

        u44.ClockTime = Lighting.ClockTime;
        Lighting.ClockTime = 0;
    end);

    if Lighting.ClockTime ~= 0 then
        u44.ClockTime = Lighting.ClockTime;
    end;

    u3.CreateSetting({
        Type = "Category",
        Title = "Misc."
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Music Subtitles",
        Description = "Toggles music subtitles for tracks with lyrics",
        SettingIndex = "MusicSubtitles",

        OnChangedCallback = function(p71: boolean) -- Line: 919, Name: OnChangedCallback
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.PlayerGui:WaitForChild("Subtitle"):WaitForChild("MusicContainer").Visible = p71;
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "TV Cameras",
        Description = "Toggles the camera view from the TV cameras on certain maps",
        SettingIndex = "TVCameras"
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Banners",
        Description = "Toggles banners for players",
        SettingIndex = "Banners",

        OnChangedCallback = function(p72: boolean) -- Line: 939, Name: OnChangedCallback
            -- upvalues: Players (ref), LocalPlayer (ref)
            for _, v in Players:GetPlayers() do
                if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("Banner")) then
                    local v73 = v;

                    for _, child in v.Character.HumanoidRootPart:GetChildren() do
                        if child.Name == "Banner" then
                            if LocalPlayer.Team == game.Teams.Visitor and (v73.Team == game.Teams.Visitor and p72) then
                                child.Container.Visible = true;
                            else
                                child.Container.Visible = false;
                            end;
                        end;
                    end;
                end;
            end;
        end
    });
    u3.CreateSetting({
        Type = "Category",
        Title = "Cards"
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "Personal Cards Sound Effect",
        Description = "Toggles Personal Card SFX",
        SettingIndex = "PersonalCardsSFX",

        OnChangedCallback = function(p74: boolean) -- Line: 968, Name: OnChangedCallback
        end
    });
    u3.CreateSetting({
        Type = "Switch",
        Title = "All Cards Sound Effect",
        Description = "Toggles All Cards SFX",
        SettingIndex = "AllCardsSFX",

        OnChangedCallback = function(p75: boolean) -- Line: 980, Name: OnChangedCallback
        end
    });
    u3.CreateSetting({
        Type = "Category",
        Title = "Custom SFX"
    });
    u3.CreateSetting({
        Type = "TextBox",
        Title = "Goal Sound Effect",
        Description = "Custom Goal SFX",
        SettingIndex = "GoalEffectSFX",
        PlaceholderText = "Sound Effect ID",
        LockedReason = LocalPlayer:GetAttribute("HasCustomSounds") ~= true and LocalPlayer:GetAttribute("HasCustomGoalSFX") ~= true and "!CustomGoal" or nil,

        OnChangedCallback = function(p76: string) -- Line: 1000, Name: OnChangedCallback
        end
    });
    u3.CreateSetting({
        Type = "TextBox",
        Title = "Ankle Breaker Sound Effect",
        Description = "Custom Ankle Breaker SFX",
        SettingIndex = "AnkleBreakerSFX",
        PlaceholderText = "Sound Effect ID",
        LockedReason = LocalPlayer:GetAttribute("HasCustomSounds") ~= true and LocalPlayer:GetAttribute("HasCustomAnkleBreakSFX") ~= true and "!CustomAnkle" or nil,

        OnChangedCallback = function(p77: string) -- Line: 1014, Name: OnChangedCallback
        end
    });
    u3.CreateSetting({
        Type = "TextBox",
        Title = "Block Sound Effect",
        Description = "Custom Block SFX",
        SettingIndex = "BlockSFX",
        PlaceholderText = "Sound Effect ID",
        LockedReason = LocalPlayer:GetAttribute("HasCustomSounds") ~= true and LocalPlayer:GetAttribute("HasCustomBlockSFX") ~= true and "!CustomBlock" or nil,

        OnChangedCallback = function(p78: string) -- Line: 1028, Name: OnChangedCallback
        end
    });

    local function ValidatePrivateServer(u79: boolean?, u80: boolean?) -- Line: 1033
        -- upvalues: LocalPlayer (ref)
        return function() -- Line: 1034
            -- upvalues: u80 (copy), LocalPlayer (ref), u79 (copy)
            if u80 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
                return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
            end;

            if LocalPlayer:GetAttribute("PSAdmin") then
                return u79 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
            end;

            return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
        end;
    end;

    local Service2 = Knit.GetService("CommandService");
    local Controller5 = Knit.GetController("GiftingController");
    u3.CreateSetting({
        Type = "Category",
        Title = "Private Servers"
    });
    local CreateSetting = u3.CreateSetting;
    local v81 = {
        Type = "Button",
        Title = "Promote Player",
        Description = "Promotes a player to PS Admin",
        ButtonText = "PICK",
        PSOption = true
    };
    local u82 = true;
    local u83 = false;

    function v81.LockedReason() -- Line: 1034
        -- upvalues: u82 (copy), LocalPlayer (ref), u83 (copy)
        if u82 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u83 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v81.OnClicked(p84, p85) -- Line: 1069
        -- upvalues: Controller5 (copy), Service2 (copy)
        Controller5.PromptPlayerSelect(function(p86: userdata) -- Line: 1070
            -- upvalues: Service2 (ref)
            Service2:RunCommand("Promote", p86);
        end, function(p87: userdata) -- Line: 1072
            return not p87:GetAttribute("PSAdmin");
        end);
    end;

    CreateSetting(v81);
    local CreateSetting2 = u3.CreateSetting;
    local v88 = {
        Type = "Button",
        Title = "Demote Player",
        Description = "Demotes another PS Admin",
        ButtonText = "PICK",
        PSOption = true
    };
    local u89 = true;
    local u90 = false;

    function v88.LockedReason() -- Line: 1034
        -- upvalues: u89 (copy), LocalPlayer (ref), u90 (copy)
        if u89 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u90 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v88.OnClicked(p91, p92) -- Line: 1088
        -- upvalues: Controller5 (copy), Service2 (copy), LocalPlayer (ref)
        Controller5.PromptPlayerSelect(function(p93: userdata) -- Line: 1089
            -- upvalues: Service2 (ref)
            Service2:RunCommand("Demote", p93);
        end, function(p94: userdata) -- Line: 1091
            -- upvalues: LocalPlayer (ref)
            local v95 = p94:GetAttribute("PSAdmin") and p94 ~= LocalPlayer;

            return v95;
        end);
    end;

    CreateSetting2(v88);
    local CreateSetting3 = u3.CreateSetting;
    local v96 = {
        Type = "Button",
        Title = "Kick Player",
        Description = "Kicks a selected Player",
        ButtonText = "PICK",
        PSOption = true
    };
    local u97 = nil;
    local u98 = nil;

    function v96.LockedReason() -- Line: 1034
        -- upvalues: u97 (copy), LocalPlayer (ref), u98 (copy)
        if u97 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u98 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v96.OnClicked(p99, p100) -- Line: 1107
        -- upvalues: Controller5 (copy), Service2 (copy)
        Controller5.PromptPlayerSelect(function(p101: userdata) -- Line: 1108
            -- upvalues: Service2 (ref)
            Service2:RunCommand("KickPlayer", p101);
        end);
    end;

    CreateSetting3(v96);
    local CreateSetting4 = u3.CreateSetting;
    local v102 = {
        Type = "Button",
        Title = "Kick All",
        Description = "Kicks all players except the server owner",
        ButtonText = "KICK",
        PSOption = true
    };
    local u103 = nil;
    local u104 = nil;

    function v102.LockedReason() -- Line: 1034
        -- upvalues: u103 (copy), LocalPlayer (ref), u104 (copy)
        if u103 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u104 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v102.OnClicked(p105, p106) -- Line: 1123
        -- upvalues: Service2 (copy)
        Service2:RunCommand("KickAll");
    end;

    CreateSetting4(v102);
    local CreateSetting5 = u3.CreateSetting;
    local v107 = {
        Type = "Button",
        Title = "Serverban Player",
        Description = "Bans a player from your server (permanent until shutdown!)",
        ButtonText = "PICK",
        PSOption = true
    };
    local u108 = nil;
    local u109 = nil;

    function v107.LockedReason() -- Line: 1034
        -- upvalues: u108 (copy), LocalPlayer (ref), u109 (copy)
        if u108 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u109 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v107.OnClicked(p110, p111) -- Line: 1137
        -- upvalues: Controller5 (copy), Service2 (copy)
        Controller5.PromptPlayerSelect(function(p112: userdata) -- Line: 1138
            -- upvalues: Service2 (ref)
            Service2:RunCommand("ServerbanPlayer", p112);
        end);
    end;

    CreateSetting5(v107);
    local CreateSetting6 = u3.CreateSetting;
    local v113 = {
        Type = "Button",
        Title = "Shutdown",
        Description = "Shuts down the server fully",
        ButtonText = "SHUTDOWN",
        PSOption = true
    };
    local u114 = true;
    local u115 = false;

    function v113.LockedReason() -- Line: 1034
        -- upvalues: u114 (copy), LocalPlayer (ref), u115 (copy)
        if u114 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u115 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v113.OnClicked(p116, p117) -- Line: 1153
        -- upvalues: Service2 (copy)
        Service2:RunCommand("Shutdown");
    end;

    CreateSetting6(v113);
    local CreateSetting7 = u3.CreateSetting;
    local v118 = {
        Type = "Switch",
        Title = "Lock Server",
        Description = "Prevents Players from joining the Private Server",
        PSSettingIndex = "IsServerLocked",
        PSOption = true
    };
    local u119 = nil;
    local u120 = nil;

    function v118.LockedReason() -- Line: 1034
        -- upvalues: u119 (copy), LocalPlayer (ref), u120 (copy)
        if u119 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u120 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v118.OnChangedCallback(p121: boolean) -- Line: 1167
        -- upvalues: Service2 (copy)
        Service2:RunCommand("LockServer", p121);
    end;

    CreateSetting7(v118);
    local CreateSetting8 = u3.CreateSetting;
    local v122 = {
        Type = "Switch",
        Title = "No Ability Cooldowns",
        Description = "Disables ability cooldowns",
        PSSettingIndex = "NoAbilityCooldowns",
        PSOption = true
    };
    local u123 = nil;
    local u124 = true;

    function v122.LockedReason() -- Line: 1034
        -- upvalues: u123 (copy), LocalPlayer (ref), u124 (copy)
        if u123 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u124 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v122.OnChangedCallback(p125: boolean) -- Line: 1181
        -- upvalues: Service2 (copy)
        Service2:RunCommand("NoAbilityCooldowns", p125);
    end;

    CreateSetting8(v122);
    local CreateSetting9 = u3.CreateSetting;
    local v126 = {
        Type = "Switch",
        Title = "No Rejoin Cooldowns",
        Description = "Disables the cooldown for switching positions",
        PSSettingIndex = "SkipRejoinCooldown",
        PSOption = true
    };
    local u127 = nil;
    local u128 = true;

    function v126.LockedReason() -- Line: 1034
        -- upvalues: u127 (copy), LocalPlayer (ref), u128 (copy)
        if u127 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u128 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v126.OnChangedCallback(p129: boolean) -- Line: 1195
        -- upvalues: Service2 (copy)
        Service2:RunCommand("SkipRejoinCooldown", p129);
    end;

    CreateSetting9(v126);
    local CreateSetting10 = u3.CreateSetting;
    local v130 = {
        Type = "Button",
        Title = "Max Zone",
        Description = "Sets the selected Player\'s zone to max",
        ButtonText = "PICK",
        PSOption = true
    };
    local u131 = nil;
    local u132 = true;

    function v130.LockedReason() -- Line: 1034
        -- upvalues: u131 (copy), LocalPlayer (ref), u132 (copy)
        if u131 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u132 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v130.OnClicked(p133, p134) -- Line: 1209
        -- upvalues: Controller5 (copy), Service2 (copy)
        Controller5.PromptPlayerSelect(function(p135: userdata) -- Line: 1210
            -- upvalues: Service2 (ref)
            Service2:RunCommand("SetZoneMax", p135);
        end);
    end;

    CreateSetting10(v130);
    local CreateSetting11 = u3.CreateSetting;
    local v136 = {
        Type = "Button",
        Title = "Awaken",
        Description = "Gives awakening to the selected player",
        ButtonText = "PICK",
        ForcedDefaultValue = false,
        PSOption = true
    };
    local u137 = nil;
    local u138 = true;

    function v136.LockedReason() -- Line: 1034
        -- upvalues: u137 (copy), LocalPlayer (ref), u138 (copy)
        if u137 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u138 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v136.OnClicked(p139, p140) -- Line: 1226
        -- upvalues: Controller5 (copy), Service2 (copy)
        Controller5.PromptPlayerSelect(function(p141: userdata) -- Line: 1227
            -- upvalues: Service2 (ref)
            Service2:RunCommand("GiveAwakening", p141);
        end);
    end;

    CreateSetting11(v136);
    local CreateSetting12 = u3.CreateSetting;
    local v142 = {
        Type = "TextBox",
        Title = "Set Timer",
        Description = "Sets the ingame timer to selected value",
        PlaceholderText = "Time (In Seconds)",
        DisableInitialUpdate = true,
        PSOption = true
    };
    local u143 = nil;
    local u144 = true;

    function v142.LockedReason() -- Line: 1034
        -- upvalues: u143 (copy), LocalPlayer (ref), u144 (copy)
        if u143 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u144 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v142.OnChangedCallback(p145: string) -- Line: 1244
        -- upvalues: Effects (ref), Service2 (copy)
        if tonumber(p145) then
            Service2:RunCommand("SetTimer", (tonumber(p145)));

            return;
        end;

        Effects:Popup(`'{p145}' is not a valid number`, 4, Color3.fromRGB(255, 0, 0));
    end;

    CreateSetting12(v142);
    local CreateSetting13 = u3.CreateSetting;
    local v146 = {
        Type = "Switch",
        Title = "Pause Timer",
        Description = "Pauses the ingame timer",
        ButtonText = "PAUSE",
        PSSettingIndex = "IsTimerPaused",
        PSOption = true
    };
    local u147 = nil;
    local u148 = true;

    function v146.LockedReason() -- Line: 1034
        -- upvalues: u147 (copy), LocalPlayer (ref), u148 (copy)
        if u147 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u148 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v146.OnChangedCallback(p149: boolean) -- Line: 1265
        -- upvalues: Service2 (copy)
        Service2:RunCommand("PauseTimer", p149);
    end;

    CreateSetting13(v146);
    u3.CreateSetting({
        Type = "Category",
        Title = "Tournament Config"
    });
    local CreateSetting14 = u3.CreateSetting;
    local v150 = {
        Type = "TextBox",
        Title = "Score Limit",
        Description = "Sets a score limit, 0 disables.",
        PlaceholderText = "Score",
        PSSettingIndex = "ScoreLimit",
        PSOption = true
    };
    local u151 = nil;
    local u152 = true;

    function v150.LockedReason() -- Line: 1034
        -- upvalues: u151 (copy), LocalPlayer (ref), u152 (copy)
        if u151 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u152 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v150.OnChangedCallback(p153: string) -- Line: 1288
        -- upvalues: Effects (ref), Service2 (copy)
        if tonumber(p153) then
            Service2:RunCommand("ScoreLimit", (tonumber(p153)));

            return;
        end;

        Effects:Popup(`'{p153}' is not a valid number`, 4, Color3.fromRGB(255, 0, 0));
    end;

    CreateSetting14(v150);
    local CreateSetting15 = u3.CreateSetting;
    local v154 = {
        Type = "Switch",
        Title = "Use Mercy Rules",
        Description = "Makes the score limit use mercy rules rather than first-to-x.",
        PSSettingIndex = "UseMercyRules",
        PSOption = true
    };
    local u155 = nil;
    local u156 = true;

    function v154.LockedReason() -- Line: 1034
        -- upvalues: u155 (copy), LocalPlayer (ref), u156 (copy)
        if u155 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u156 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v154.OnChangedCallback(p157: boolean) -- Line: 1308
        -- upvalues: Service2 (copy)
        Service2:RunCommand("UseMercyRules", p157);
    end;

    CreateSetting15(v154);
    local CreateSetting16 = u3.CreateSetting;
    local v158 = {
        Type = "TextBox",
        Title = "Home Team",
        Description = "Sets the name of the home team. Blank to reset.",
        PlaceholderText = "Home Team",
        PSSettingIndex = "HomeDisplayName",
        AllowBlanking = true,
        PSOption = true
    };
    local u159 = nil;
    local u160 = true;

    function v158.LockedReason() -- Line: 1034
        -- upvalues: u159 (copy), LocalPlayer (ref), u160 (copy)
        if u159 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u160 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v158.OnChangedCallback(p161: string) -- Line: 1325
        -- upvalues: Service2 (copy)
        Service2:RunCommand("TeamName", "Home", p161);
    end;

    CreateSetting16(v158);
    local CreateSetting17 = u3.CreateSetting;
    local v162 = {
        Type = "TextBox",
        Title = "Away Team",
        Description = "Sets the name of the away team. Blank to reset.",
        PlaceholderText = "Away Team",
        PSSettingIndex = "AwayDisplayName",
        AllowBlanking = true,
        PSOption = true
    };
    local u163 = nil;
    local u164 = true;

    function v162.LockedReason() -- Line: 1034
        -- upvalues: u163 (copy), LocalPlayer (ref), u164 (copy)
        if u163 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u164 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v162.OnChangedCallback(p165: string) -- Line: 1342
        -- upvalues: Service2 (copy)
        Service2:RunCommand("TeamName", "Away", p165);
    end;

    CreateSetting17(v162);
    local CreateSetting18 = u3.CreateSetting;
    local v166 = {
        Type = "Switch",
        Title = "Disable Awakenings",
        Description = "Prevents awakenings from being issued or used",
        PSSettingIndex = "DisableAwks",
        PSOption = true
    };
    local u167 = nil;
    local u168 = true;

    function v166.LockedReason() -- Line: 1034
        -- upvalues: u167 (copy), LocalPlayer (ref), u168 (copy)
        if u167 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u168 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v166.OnChangedCallback(p169: boolean) -- Line: 1356
        -- upvalues: Service2 (copy)
        Service2:RunCommand("DisableAwks", p169);
    end;

    CreateSetting18(v166);
    local CreateSetting19 = u3.CreateSetting;
    local v170 = {
        Type = "Switch",
        Title = "Wait For Host",
        Description = "Games won\'t start until server host permits it",
        PSSettingIndex = "WaitForHost",
        PSOption = true
    };
    local u171 = nil;
    local u172 = true;

    function v170.LockedReason() -- Line: 1034
        -- upvalues: u171 (copy), LocalPlayer (ref), u172 (copy)
        if u171 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u172 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v170.OnChangedCallback(p173: boolean) -- Line: 1370
        -- upvalues: Service2 (copy)
        Service2:RunCommand("WaitForHost", p173);
    end;

    CreateSetting19(v170);
    local CreateSetting20 = u3.CreateSetting;
    local v174 = {
        Type = "Button",
        Title = "Start Round",
        Description = "If using Wait For Host, this will start the round",
        ButtonText = "START",
        PSOption = true
    };
    local u175 = nil;
    local u176 = true;

    function v174.LockedReason() -- Line: 1034
        -- upvalues: u175 (copy), LocalPlayer (ref), u176 (copy)
        if u175 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u176 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    function v174.OnClicked(p177, p178) -- Line: 1384
        -- upvalues: Service2 (copy)
        Service2:RunCommand("HostStart");
    end;

    CreateSetting20(v174);
    u3.CreateSetting({
        Type = "Category",
        Title = "Game Tweaks"
    });
    u3.CreateSetting({
        Type = "Category",
        Title = "These options let you enable/disable bugfixes or tweak core game mechanics. Be careful!"
    });
    local CreateSetting21 = u3.CreateSetting;
    local v179 = {
        Type = "Switch",
        Title = "Jump Abilities",
        Description = "Allow players to jump and use certain abilities.",
        PSOption = true
    };
    local u180 = nil;
    local u181 = true;

    function v179.LockedReason() -- Line: 1034
        -- upvalues: u180 (copy), LocalPlayer (ref), u181 (copy)
        if u180 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u181 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    v179.UpdateSignal = ReplicatedStorage.GameTweaks:GetAttributeChangedSignal("JumpAbilities");

    function v179.Update() -- Line: 1406
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.GameTweaks:GetAttribute("JumpAbilities");
    end;

    function v179.OnChangedCallback(p182: boolean) -- Line: 1412
        -- upvalues: Service2 (copy)
        Service2:RunCommand("GameTweak", "JumpAbilities", p182);
    end;

    CreateSetting21(v179);
    local CreateSetting22 = u3.CreateSetting;
    local v183 = {
        Type = "Switch",
        Title = "Disable Buzzer Beaters",
        Description = "Removes buzzer beaters at the end of the game.",
        PSOption = true
    };
    local u184 = nil;
    local u185 = true;

    function v183.LockedReason() -- Line: 1034
        -- upvalues: u184 (copy), LocalPlayer (ref), u185 (copy)
        if u184 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u185 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    v183.UpdateSignal = ReplicatedStorage.GameTweaks:GetAttributeChangedSignal("DisableBuzzerBeaters");

    function v183.Update() -- Line: 1425
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.GameTweaks:GetAttribute("DisableBuzzerBeaters");
    end;

    function v183.OnChangedCallback(p186: boolean) -- Line: 1431
        -- upvalues: Service2 (copy)
        Service2:RunCommand("GameTweak", "DisableBuzzerBeaters", p186);
    end;

    CreateSetting22(v183);
    local CreateSetting23 = u3.CreateSetting;
    local v187 = {
        Type = "Switch",
        Title = "Disable Shot Contest",
        Description = "Removes the shot contest system.",
        PSOption = true
    };
    local u188 = nil;
    local u189 = true;

    function v187.LockedReason() -- Line: 1034
        -- upvalues: u188 (copy), LocalPlayer (ref), u189 (copy)
        if u188 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u189 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    v187.UpdateSignal = ReplicatedStorage.GameTweaks:GetAttributeChangedSignal("DisableShotContest");

    function v187.Update() -- Line: 1443
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.GameTweaks:GetAttribute("DisableShotContest");
    end;

    function v187.OnChangedCallback(p190: boolean) -- Line: 1449
        -- upvalues: Service2 (copy)
        Service2:RunCommand("GameTweak", "DisableShotContest", p190);
    end;

    CreateSetting23(v187);
    local CreateSetting24 = u3.CreateSetting;
    local v191 = {
        Type = "TextBox",
        Title = "Gravity",
        Description = "Changes gravity, 100 is default.",
        PlaceholderText = "Gravity",
        PSOption = true
    };
    local u192 = nil;
    local u193 = true;

    function v191.LockedReason() -- Line: 1034
        -- upvalues: u192 (copy), LocalPlayer (ref), u193 (copy)
        if u192 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u193 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    v191.UpdateSignal = workspace:GetPropertyChangedSignal("Gravity");

    function v191.Update() -- Line: 1463
        return workspace.Gravity;
    end;

    function v191.OnChangedCallback(p194: string) -- Line: 1469
        -- upvalues: Effects (ref), Service2 (copy)
        if tonumber(p194) then
            Service2:RunCommand("GameTweak", "Gravity", (tonumber(p194)));

            return;
        end;

        Effects:Popup(`'{p194}' is not a valid number`, 4, Color3.fromRGB(255, 0, 0));
    end;

    CreateSetting24(v191);
    local CreateSetting25 = u3.CreateSetting;
    local v195 = {
        Type = "TextBox",
        Title = "Aim Assist Multiplier",
        Description = "Changes the aim assist multiplier, 1 is default.",
        PlaceholderText = "Aim Assist",
        PSOption = true
    };
    local u196 = nil;
    local u197 = true;

    function v195.LockedReason() -- Line: 1034
        -- upvalues: u196 (copy), LocalPlayer (ref), u197 (copy)
        if u196 and workspace:GetAttribute("PrivateServerOwner") ~= LocalPlayer.UserId then
            return "Private Server Owner Only", workspace:GetAttributeChangedSignal("PrivateServerOwner");
        end;

        if LocalPlayer:GetAttribute("PSAdmin") then
            return u197 and not workspace:GetAttribute("HasPrivateServerPlus") and "!PS+" or nil;
        end;

        return "Private Server Admin Only", LocalPlayer:GetAttributeChangedSignal("PSAdmin");
    end;

    v195.UpdateSignal = ReplicatedStorage.GameTweaks:GetAttributeChangedSignal("AimAssistMultiplier");

    function v195.Update() -- Line: 1489
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.GameTweaks:GetAttribute("AimAssistMultiplier");
    end;

    function v195.OnChangedCallback(p198: string) -- Line: 1495
        -- upvalues: Effects (ref), Service2 (copy)
        if tonumber(p198) then
            Service2:RunCommand("GameTweak", "AimAssistMultiplier", (tonumber(p198)));

            return;
        end;

        Effects:Popup(`'{p198}' is not a valid number`, 4, Color3.fromRGB(255, 0, 0));
    end;

    CreateSetting25(v195);
    UserInputService.LastInputTypeChanged:Connect(function(p199) -- Line: 1507
        -- upvalues: Controller3 (copy), u62 (copy)
        local v200 = Controller3.GetPlatform() ~= "Controller" and p199 ~= Enum.UserInputType.Touch;
        u62.Visible = v200;
    end);
    RelicsXYZ.SettingChanged:Connect(function(p201, p202) -- Line: 1516
        -- upvalues: Controller2 (copy), Knit (ref)
        if p201 == "GlobalMute" and not p202 ~= Controller2.Player.Customization.Settings.BoomboxMusic then
            Knit.GetService("SettingsService"):UpdateSetting("BoomboxMusic", not p202);
        end;
    end);
end;

return u3;