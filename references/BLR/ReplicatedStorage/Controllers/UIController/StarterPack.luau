  

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.TableUtil);
local u1 = nil;
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Functions.FastTween);
local Button = require(ReplicatedStorage.Modules.Button);
local UpdateGuisScale = require(ReplicatedStorage.Modules.UpdateGuisScale);
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u2 = nil;
local u3 = nil;

local function formatCountdown(p4: number) -- Line: 23
    local math_floor_ret = math.floor(p4);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%02d:%02d:%02d", math_max_ret // 3600, math_max_ret % 3600 // 60, math_max_ret % 60);
end;

local v5 = Knit.CreateController({
    Name = "StarterPackInterface"
});

function v5.UnixTimestamp(p6) -- Line: 35
    -- upvalues: u2 (ref)
    return DateTime.now().UnixTimestamp - u2:GetPlayerData().StarterPackSession;
end;

function v5.Purchased(p7) -- Line: 39
    -- upvalues: u2 (ref)
    return u2:GetPlayerData().StarterPackPurchased;
end;

function v5.IsActive(p8) -- Line: 43
    -- upvalues: u2 (ref)
    local v9 = p8:UnixTimestamp();
    local _ = u2:GetPlayerData().RobuxSpent;
    local v10 = 0;
    local v11;

    if v9 >= 600 and v9 <= 86400 then
        v11 = v10 <= 0;
    else
        v11 = false;
    end;

    return v11;
end;

function v5.PromptStarterPackForABTest(p12) -- Line: 50
    -- upvalues: LocalPlayer (copy)
    if p12:Purchased() then
        return;
    end;

    if LocalPlayer.Team ~= game.Teams.Visitor then
        return;
    end;

    if not p12:IsActive() then
        return;
    end;

    p12.Screen.Enabled = true;
    p12.MainFrame.Visible = true;
    p12.Screen.BlackBG.Visible = p12.MainFrame.Visible;
end;

function v5.GuiStart(u13) -- Line: 66
    -- upvalues: LocalPlayer (copy), Button (copy), ABTests (copy), MarketplaceService (copy)
    coroutine.wrap(function(...) -- Line: 67
        -- upvalues: u13 (copy), LocalPlayer (ref)
        while task.wait(1) do
            local v14 = u13:UnixTimestamp();
            local Screen = u13.Screen;
            local v15 = not u13.InGameUI.Enabled and (not u13:Purchased() and u13:IsActive()) and LocalPlayer.Team == game.Teams.Visitor;
            Screen.Enabled = v15;
            local Countdown = u13.OpenScreenButton.Countdown;
            local math_floor_ret = math.floor(86400 - v14);
            local math_max_ret = math.max(0, math_floor_ret);
            Countdown.Text = string.format("%02d:%02d:%02d", math_max_ret // 3600, math_max_ret % 3600 // 60, math_max_ret % 60);
        end;
    end)();
    Button.CreateDefaultButton(u13.MainFrame.Purchase).OnEnded:Connect(function() -- Line: 76
        -- upvalues: ABTests (ref), LocalPlayer (ref), MarketplaceService (ref)
        MarketplaceService:PromptProductPurchase(LocalPlayer, (ABTests.GetAttributeAsync(LocalPlayer, "StarterPack.ProductId", 2673669038)));
    end);
end;

function v5.KnitStart(u16) -- Line: 82
    -- upvalues: Players (copy), Knit (copy), UpdateGuisScale (copy), LocalPlayer (copy), u1 (ref), u3 (ref), Button (copy)
    u16.Screen.Enabled = false;

    repeat
        task.wait();
    until Players.LocalPlayer:GetAttribute("FullyLoaded");

    task.wait(3);

    if u16:Purchased() then
        return;
    end;

    Knit.OnStart():andThenCall(UpdateGuisScale, u16.Screen.UIScale):andThenCall(u16.GuiStart, u16):andThen(function() -- Line: 98
        -- upvalues: u16 (copy), LocalPlayer (ref), u1 (ref), u3 (ref), Button (ref)
        local function ToggleScreen() -- Line: 101
            -- upvalues: u16 (ref), LocalPlayer (ref)
            local Screen = u16.Screen;
            local v17 = u16:IsActive() and not u16.InGameUI.Enabled and LocalPlayer.Team == game.Teams.Visitor;
            Screen.Enabled = v17;
        end;

        local Screen = u16.Screen;
        local v18 = u16:IsActive() and not u16.InGameUI.Enabled and LocalPlayer.Team == game.Teams.Visitor;
        Screen.Enabled = v18;
        u1.TutorialEnded:Connect(function() -- Line: 107
            -- upvalues: u16 (ref), LocalPlayer (ref)
            print("recv tutorialended client");
            local Screen2 = u16.Screen;
            local v19 = u16:IsActive() and not u16.InGameUI.Enabled and LocalPlayer.Team == game.Teams.Visitor;
            Screen2.Enabled = v19;
        end);
        u16.InGameUI:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 112
            -- upvalues: u16 (ref), LocalPlayer (ref)
            if not u16:Purchased() then
                local Screen2 = u16.Screen;
                local v20 = u16:IsActive() and not u16.InGameUI.Enabled and LocalPlayer.Team == game.Teams.Visitor;
                Screen2.Enabled = v20;
            end;
        end);
        u3.OnPurchasedStarterPack:Connect(function() -- Line: 118
            -- upvalues: u16 (ref)
            u16.Screen.Enabled = false;
        end);
        Button.CreateDefaultButton(u16.OpenScreenButton).OnEnded:Connect(function() -- Line: 123
            -- upvalues: u16 (ref)
            u16.MainFrame.Visible = not u16.MainFrame.Visible;
            u16.Screen.BlackBG.Visible = u16.MainFrame.Visible;
        end);
        Button.CreateDefaultButton(u16.CloseScreenButton).OnEnded:Connect(function() -- Line: 129
            -- upvalues: u16 (ref)
            u16.MainFrame.Visible = false;
            u16.Screen.BlackBG.Visible = u16.MainFrame.Visible;
        end);
    end);
end;

function v5.KnitInit(p21) -- Line: 136
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u1 (ref), PlayerGui (copy)
    u2 = Knit.GetService("StatsService");
    u3 = Knit.GetService("MarketService");
    u1 = Knit.GetService("OnboardingService");
    p21.InGameUI = PlayerGui:WaitForChild("InGameUI");
    p21.Screen = PlayerGui:WaitForChild("StarterPack");
    p21.OpenScreenButton = p21.Screen.Open;
    p21.MainFrame = p21.Screen.MainFrame;
    p21.CloseScreenButton = p21.MainFrame.Close;
    p21.DefaultMainFrameSize = p21.MainFrame.Size;
end;

return v5;