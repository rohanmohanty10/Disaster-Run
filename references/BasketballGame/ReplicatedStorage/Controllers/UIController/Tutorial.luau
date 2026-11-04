 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local KeybindIcons = require(ReplicatedStorage.Shared.Tables.KeybindIcons);
local Tutorial = require(ReplicatedStorage.Shared.Tables.Tutorial);
local LocalPlayer = Players.LocalPlayer;
local Tutorial2 = LocalPlayer.PlayerGui:WaitForChild("Tutorial");
local u1 = nil;
local u2 = nil;
local u3 = nil;
Trove.new();
local u4 = Knit.CreateController({
    Name = "Tutorial"
});

function u4.Step(p5) -- Line: 26
    -- upvalues: u2 (ref), Tutorial (copy), TweenService (copy), Tutorial2 (copy), u3 (ref), KeybindIcons (copy), UserInputService (copy)
    local v6 = u2.CharValues.HasBall and "Attack" or "Defend";
    local v7 = p5.CompletedSteps[v6];

    if #Tutorial[v6] <= v7 then
        v6 = v6 == "Attack" and "Defend" or "Attack";
        v7 = p5.CompletedSteps[v6];
    end;

    if p5.CompletedSteps.Attack >= #Tutorial.Attack and p5.CompletedSteps.Defend >= #Tutorial.Defend then
        TweenService:Create(Tutorial2.BG, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.fromScale(0, 0)
        }):Play();

        return;
    end;

    TweenService:Create(Tutorial2.BG, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.25, 0.096)
    }):Play();
    local v8 = Tutorial[v6][v7 + 1];
    Tutorial2.Enabled = true;

    if u3.GetPlatform() == "Touchscreen" then
        Tutorial2.BG.Icon.Visible = false;
        Tutorial2.BG.TextLabel.Text = `{string.upper(v8.Keybind)} {v8.Text}`;
        Tutorial2.BG.TextLabel.Position = UDim2.fromScale(0.5, 0.5);
        Tutorial2.BG.TextLabel.Size = UDim2.fromScale(0.9, 0.45);
        Tutorial2.BG.TextLabel.TextXAlignment = Enum.TextXAlignment.Center;

        return;
    end;

    Tutorial2.BG.Icon.Visible = true;

    if v8.Keybind == "Jump" then
        Tutorial2.BG.Icon.Image = u3.GetPlatform() == "Controller" and KeybindIcons.Gamepad[UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) or Enum.KeyCode.ButtonA] or KeybindIcons.Dark[Enum.KeyCode.Space];
    else
        Tutorial2.BG.Icon.Image = u3.GetKeybindIcon(v8.Keybind);
    end;

    Tutorial2.BG.TextLabel.Text = v8.Text;
    Tutorial2.BG.TextLabel.Position = UDim2.fromScale(0.6, 0.5);
    Tutorial2.BG.TextLabel.Size = UDim2.fromScale(0.6, 0.45);
    Tutorial2.BG.TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
end;

function u4.KnitInit(p9) -- Line: 70
end;

function u4.KnitStart(u10) -- Line: 74
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), LocalPlayer (copy), u4 (copy), RunService (copy), Tutorial2 (copy)
    u1 = Knit.GetService("TutorialService");
    u2 = Knit.GetController("Network");
    u3 = Knit.GetController("KeybindsController");
    u10.CompletedSteps = {
        Attack = 0,
        Defend = 0
    };

    if u2.ServerType == "Tutorial" then
        local Return = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InGame"):WaitForChild("BG"):WaitForChild("Return");
        Return.TextLabel.Text = "SKIP TUTORIAL";
        Return.MouseButton1Click:Connect(function() -- Line: 88
            -- upvalues: u1 (ref)
            u1:SkipTutorial();
        end);
        u1.StepCompleted:Connect(function(p11, p12) -- Line: 92
            -- upvalues: u10 (copy), u4 (ref)
            u10.CompletedSteps[p11] = p12;
            u4:Step();
        end);
        u4:Step();
        local u13 = nil;
        u1.TutorialCompleted:Connect(function() -- Line: 99
            -- upvalues: u13 (ref), LocalPlayer (ref), Knit (ref)
            if u13 then
                return;
            end;

            u13 = true;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Visible = true;
            local Controller = Knit.GetController("AbilityController");
            Controller:Input();
            Controller:CooldownUI();
        end);
        local HasBall = u2.CharValues.HasBall;
        RunService.Heartbeat:Connect(function() -- Line: 111
            -- upvalues: u2 (ref), HasBall (ref), u4 (ref)
            if u2.CharValues.HasBall ~= HasBall then
                HasBall = u2.CharValues.HasBall;
                u4:Step();
            end;
        end);
        LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 118
            -- upvalues: LocalPlayer (ref), Tutorial2 (ref)
            if LocalPlayer.Team == game.Teams.Visitor then
                Tutorial2.Enabled = false;

                return;
            end;

            Tutorial2.Enabled = true;
        end);
    end;
end;

return u4;