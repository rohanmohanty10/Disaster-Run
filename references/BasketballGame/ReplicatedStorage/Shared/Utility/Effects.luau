 
 

local v1 = {};
local ContentProvider = game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GameValues = ReplicatedStorage.GameValues;
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Jerseys = require(ReplicatedStorage.Shared.Tables.Jerseys);
local script_DerpText = require(script.DerpText);
local LocalPlayer = Players.LocalPlayer;

function v1.Popup(p2, u3, u4, u5, u6) -- Line: 18
    -- upvalues: SfxManager (copy), LocalPlayer (copy), ReplicatedStorage (copy), TweenService (copy)
    task.spawn(function() -- Line: 19
        -- upvalues: SfxManager (ref), u4 (ref), LocalPlayer (ref), ReplicatedStorage (ref), u3 (copy), u5 (copy), TweenService (ref), u6 (copy)
        SfxManager:playSound({
            Sound = "Notification",
            Parent = workspace
        });
        u4 = u4 or 1;
        local Popups = LocalPlayer.PlayerGui.Misc.Popups;
        local u7 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u7.Parent = Popups;
        u7.Text = u3;

        if u5 then
            u7.TextColor3 = u5;
        end;

        local UIGradient = u7.UIGradient;
        u7.Size = UDim2.fromScale(0.61, 0.164);
        TweenService:Create(u7, TweenInfo.new(0.3), {
            Size = u6 or UDim2.fromScale(0.697, 0.154)
        }):Play();

        for i = 1, 0, -0.05 do
            UIGradient.Transparency = NumberSequence.new(i, 1);
            task.wait(0.01);
            local _ = i;
        end;

        for i = 1, 0, -0.05 do
            UIGradient.Transparency = NumberSequence.new(0, i);
            task.wait(0.01);
            local _ = i;
        end;

        task.delay(u4, function() -- Line: 51
            -- upvalues: TweenService (ref), u7 (copy), UIGradient (copy)
            TweenService:Create(u7, TweenInfo.new(0.4), {
                Size = UDim2.fromScale(0.6, 0.134)
            }):Play();

            for i = 0, 1, 0.09 do
                UIGradient.Transparency = NumberSequence.new(i, 0);
                task.wait(0.01);
                local _ = i;
            end;

            for i = 0, 1, 0.09 do
                UIGradient.Transparency = NumberSequence.new(1, i);
                task.wait(0.01);
                local _ = i;
            end;

            u7:Destroy();
        end);
    end);
end;

function v1.Subtitle(p8, u9, u10) -- Line: 71
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
    task.spawn(function() -- Line: 72
        -- upvalues: u9 (ref), LocalPlayer (ref), ReplicatedStorage (ref), u10 (copy)
        u9 = u9 or 2;
        local _ = tick() + u9;
        local Misc = LocalPlayer.PlayerGui.Misc;

        if Misc:FindFirstChild("Subtitle") then
            Misc.Subtitle:Destroy();
        end;

        local u11 = ReplicatedStorage.Assets.UI.Subtitle:Clone();
        u11.Text = "";
        u11.Parent = Misc;

        for i = 1, string.len(u10) do
            u11.Text = string.sub(u10, 1, i);
            task.wait(u9 / string.len(u10) / 3);
            local _ = i;
        end;

        task.delay(u9, function() -- Line: 89
            -- upvalues: u11 (copy)
            if u11 then
                u11:Destroy();
            end;
        end);
    end);
end;

function v1.Blackbars(p12, u13, p14) -- Line: 93
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    task.spawn(function() -- Line: 94
        -- upvalues: ReplicatedStorage (ref), u13 (copy), TweenService (ref)
        local LocalPlayer2 = game.Players.LocalPlayer;
        local Spectate = require(ReplicatedStorage.Controllers.UIController.Spectate);

        if u13 ~= "Spawn" then
            if u13 == "Back" then
                local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Controls, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.ControlsPC, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.ControlsConsole, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Top, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.416, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Bottom, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.914, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.TimerBG.MatchTimer, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.127, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Bars, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.805, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Return, TweenInfo_new_ret, {
                    Position = UDim2.new(0.771, 0, 0.06, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Surrender, TweenInfo_new_ret, {
                    Position = UDim2.new(0.771, 0, 0.06, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Requeue, TweenInfo_new_ret, {
                    Position = UDim2.new(0.771, 0, 0.16, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.Spectate.Top, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.416, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.Spectate.TimerBG.MatchTimer, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.127, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.Spectate.Spectate, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play();
                TweenService:Create(LocalPlayer2.PlayerGui.Subtitle.Container, TweenInfo_new_ret, {
                    Position = UDim2.new(0.5, 0, 0.75, 0)
                }):Play();
                Spectate.Icon:setEnabled(LocalPlayer2.Team == nil and true or LocalPlayer2.Team == game.Teams.Visitor);
            end;

            return;
        end;

        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Controls, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, 0.5, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.ControlsPC, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, 0.5, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.ControlsConsole, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 0, 0.5, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Top, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 0.216, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Bottom, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 1.24, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.TimerBG.MatchTimer, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, -0.027, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Bars, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 1.25, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Return, TweenInfo_new_ret, {
            Position = UDim2.new(0.771, 0, -0.216, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Surrender, TweenInfo_new_ret, {
            Position = UDim2.new(0.771, 0, -0.216, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.InGame.BG.Requeue, TweenInfo_new_ret, {
            Position = UDim2.new(0.771, 0, -0.056, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.Spectate.Top, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 0.216, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.Spectate.TimerBG.MatchTimer, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, -0.027, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.Spectate.Spectate, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 1, 0)
        }):Play();
        TweenService:Create(LocalPlayer2.PlayerGui.Subtitle.Container, TweenInfo_new_ret, {
            Position = UDim2.new(0.5, 0, 0.9, 0)
        }):Play();
        Spectate.Icon:setEnabled(false);
    end);
end;

local u15 = nil;

function v1.SubtitleV2(p16, u17) -- Line: 166
    -- upvalues: LocalPlayer (copy), TweenService (copy), u15 (ref), Jerseys (copy), GameValues (copy), script_DerpText (copy)
    local u18 = false;
    local Container = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Subtitle"):WaitForChild("Container");
    local Speaker = Container:WaitForChild("Speaker");
    local SubtitleText = Container:WaitForChild("SubtitleText");
    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    local function hideSubtitles() -- Line: 173
        -- upvalues: u18 (ref), TweenService (ref), Speaker (copy), TweenInfo_new_ret (copy)
        if not u18 then
            return;
        end;

        TweenService:Create(Speaker, TweenInfo_new_ret, {
            TextTransparency = 1
        }):Play();
        TweenService:Create(Speaker.UIStroke, TweenInfo_new_ret, {
            Transparency = 1
        }):Play();
        u18 = false;
    end;

    if u15 ~= nil then
        u15:Destroy();
        u15 = nil;
    end;

    local function subtitle(p19, p20, p21, p22, p23) -- Line: 192
        -- upvalues: Speaker (copy), Jerseys (ref), GameValues (ref), u18 (ref), TweenService (ref), TweenInfo_new_ret (copy), u15 (ref), script_DerpText (ref), SubtitleText (copy), hideSubtitles (copy)
        if typeof(p19) == "string" then
            Speaker.Text = `<font color="#ffffff">{p19}</font>`;
            Speaker.UIStroke.Color = Color3.new(0, 0, 0);
        else
            local v24;

            if p19.Team == game.Teams.Home then
                v24 = Jerseys.Home[GameValues.HomeIndex.Value].Color;
            elseif p19.Team == game.Teams.Away then
                v24 = Jerseys.Away[GameValues.AwayIndex.Value].Color;
            else
                v24 = Color3.new(1, 1, 1);
            end;

            Speaker.Text = `<font color="#{v24:ToHex()}">{p19.DisplayName}</font>`;
            local _, _, v25 = v24:ToHSV();

            if v25 <= 0.5 then
                Speaker.UIStroke.Color = Color3.new(1, 1, 1);
            else
                Speaker.UIStroke.Color = Color3.new(0, 0, 0);
            end;
        end;

        if not u18 then
            TweenService:Create(Speaker, TweenInfo_new_ret, {
                TextTransparency = 0
            }):Play();
            TweenService:Create(Speaker.UIStroke, TweenInfo_new_ret, {
                Transparency = 0
            }):Play();
            u18 = true;
        end;

        if u15 ~= nil then
            u15:Destroy();
        end;

        local v26 = {
            DefaultTimeBetweenStep = 0.025,
            FallbackAnimationLength = 0.5,
            DefaultTextSize = 20,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            DefaultFont = Font.fromName("Montserrat", Enum.FontWeight.SemiBold)
        };

        if p23 then
            v26.TextStrokeColor = p23;
        end;

        local v27 = script_DerpText.new(SubtitleText, p20, v26);
        v27:Play(false);
        u15 = v27;
        task.wait(p21);

        if u15 ~= v27 then
            return false;
        end;

        for _, descendant in SubtitleText:GetDescendants() do
            if descendant:IsA("TextLabel") then
                TweenService:Create(descendant, TweenInfo_new_ret, {
                    TextTransparency = 1
                }):Play();
            elseif descendant:IsA("UIStroke") then
                TweenService:Create(descendant, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            end;
        end;

        if p22 then
            hideSubtitles();
        end;

        task.wait(TweenInfo_new_ret.Time);

        return true;
    end;

    task.spawn(function() -- Line: 269
        -- upvalues: u17 (copy), subtitle (copy)
        for i, v in u17 do
            if not subtitle(v[1], v[2], v[3], i == #u17, v[5]) then
                return;
            end;

            if v[4] then
                task.wait(v[4]);
            end;
        end;
    end);
end;

function v1.MusicSubtitles(p28: table, u29: userdata, u30: any) -- Line: 284
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    local SubtitleText = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Subtitle"):WaitForChild("MusicContainer"):WaitForChild("SubtitleText");
    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    task.spawn(function() -- Line: 288
        -- upvalues: u29 (copy), LocalPlayer (ref), u30 (copy), SubtitleText (copy), TweenService (ref), TweenInfo_new_ret (copy)
        local v31 = (-1 / 0);
        local v32 = false;

        while u29:IsDescendantOf(game) and (u29.IsPlaying and (LocalPlayer.Team ~= game.Teams.Visitor or LocalPlayer.PlayerGui.Spectate.Enabled)) do
            if u29.TimePosition < v31 then
                v31 = u29.TimePosition;
            end;

            for i, v in u30 do
                if i > v31 and u29.TimePosition >= i then
                    if v == "" then
                        TweenService:Create(SubtitleText, TweenInfo_new_ret, {
                            TextTransparency = 1
                        }):Play();
                        TweenService:Create(SubtitleText.UIStroke, TweenInfo_new_ret, {
                            Transparency = 1
                        }):Play();
                        v31 = i;
                        v32 = false;
                    else
                        SubtitleText.Text = `♪\t{v}`;

                        if v32 then
                            v31 = i;
                        else
                            TweenService:Create(SubtitleText, TweenInfo_new_ret, {
                                TextTransparency = 0
                            }):Play();
                            TweenService:Create(SubtitleText.UIStroke, TweenInfo_new_ret, {
                                Transparency = 0
                            }):Play();
                            v31 = i;
                            v32 = true;
                        end;
                    end;
                end;
            end;

            task.wait();
        end;

        TweenService:Create(SubtitleText, TweenInfo_new_ret, {
            TextTransparency = 1
        }):Play();
        TweenService:Create(SubtitleText.UIStroke, TweenInfo_new_ret, {
            Transparency = 1
        }):Play();
    end);
end;

if RunService:IsClient() then
    local Subtitle = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Subtitle");
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 350, Name: recalculateSubtitleScale
        -- upvalues: Subtitle (copy)
        local math_min_ret = math.min(workspace.CurrentCamera.ViewportSize.Y / 540, workspace.CurrentCamera.ViewportSize.X / 1350);
        Subtitle.Container.UIScale.Scale = math_min_ret;
        Subtitle.MusicContainer.UIScale.Scale = math_min_ret;
    end);
    local math_min_ret = math.min(workspace.CurrentCamera.ViewportSize.Y / 540, workspace.CurrentCamera.ViewportSize.X / 1350);
    Subtitle.Container.UIScale.Scale = math_min_ret;
    Subtitle.MusicContainer.UIScale.Scale = math_min_ret;
    task.spawn(function() -- Line: 359
        -- upvalues: ContentProvider (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.FontFace = Font.fromName("Montserrat", Enum.FontWeight.SemiBold);
        ContentProvider:PreloadAsync({ TextLabel });
    end);
end;

return v1;