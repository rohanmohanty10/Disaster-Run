 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local KnifeAbilities = require(ChickenOrHero.Weapons:WaitForChild("KnifeAbilities"));
local StepOverMotion = require(ChickenOrHero.Movement:WaitForChild("StepOverMotion"));
local CannonMotion = require(ChickenOrHero.Movement:WaitForChild("CannonMotion"));
local Session = ChickenOrHero.Game.Session;
local AbilityRule = require(ChickenOrHero.Game:WaitForChild("AbilityRule"));
local u1 = Panels.screen(LocalPlayer, "TruckAbilityHUD", 35);
local u2 = Panels.button(u1, "Truck", "", 0, 0, 156, 80);
Theme.button(u2, KnifeAbilities.Skins.Football.Base);
u2.BackgroundColor3 = Color3.new(1, 1, 1);
u2.Corner.CornerRadius = UDim.new(0, 12);
local u3 = u2:FindFirstChild("SkinGradient") or Instance.new("UIGradient");
u3.Name = "SkinGradient";
u3.Rotation = 90;
u3.Parent = u2;
u2.AnchorPoint = Vector2.new(1, 0.5);
u2.Visible = false;
local u4 = Panels.text(u2, "Label", "TRUCK", 12, 13, 132, 27, 18, Theme.Paper);
u4.TextXAlignment = Enum.TextXAlignment.Center;
u4.Font = Enum.Font.GothamBold;
local u5 = Panels.text(u2, "Hint", "R / SHOULDER", 12, 45, 132, 19, 11, Theme.Paper);
u5.TextXAlignment = Enum.TextXAlignment.Center;
local v6 = Panels.make("Frame", u2, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(12, 69),
    Size = UDim2.fromOffset(132, 4),
    BackgroundColor3 = Skin.Palette.track
});
Panels.corner(v6, 4);
local u7 = Panels.make("Frame", v6, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1)
});
Panels.corner(u7, 4);
local UIScale = Instance.new("UIScale");
UIScale.Parent = u2;
local u8 = nil;

local function style(p9) -- Line: 56
    -- upvalues: u8 (ref), u2 (copy), u3 (copy), Theme (copy), u5 (copy), u7 (copy)
    if u8 == p9 then
        return;
    end;

    u8 = p9;
    u2.Border.Color = p9.Accent;
    u3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Theme.Ink), ColorSequenceKeypoint.new(0.55, Theme.Ink), ColorSequenceKeypoint.new(1, p9.AccentDark) });
    u5.TextColor3 = p9.Accent;
    u7.BackgroundColor3 = p9.Accent;
end;

style(KnifeAbilities.Skins.Football);
local u10 = {};

local function on(p11, p12) -- Line: 72
    -- upvalues: u10 (copy)
    table.insert(u10, p11:Connect(p12));
end;

local function current() -- Line: 76
    -- upvalues: KnifeAbilities (copy), LocalPlayer (copy)
    return KnifeAbilities.forSkin(LocalPlayer:GetAttribute("EquippedKnife"));
end;

local function available(p13) -- Line: 79
    -- upvalues: LocalPlayer (copy), KnifeAbilities (copy), Session (copy), AbilityRule (copy)
    local v14;

    if p13 == nil or (LocalPlayer:GetAttribute("ClientReady") ~= true or (LocalPlayer:GetAttribute("InMatch") ~= true or LocalPlayer:GetAttribute("RunState") ~= "Active")) then
        v14 = false;
    else
        v14 = KnifeAbilities.allows(p13, LocalPlayer:GetAttribute("GameRole")) and not (Session:GetAttribute("GlobalPaused") or Session:GetAttribute("MapChanging")) and not AbilityRule.knifeBlocked(LocalPlayer);
    end;

    return v14;
end;

local u15 = (-1 / 0);

local function request() -- Line: 92
    -- upvalues: KnifeAbilities (copy), LocalPlayer (copy), available (copy), ControlGate (copy), u15 (ref), StepOverMotion (copy), CannonMotion (copy), ChickenOrHero (copy)
    local v16 = KnifeAbilities.forSkin(LocalPlayer:GetAttribute("EquippedKnife"));

    if not (available(v16) and (not ControlGate.reason(LocalPlayer) and os.clock() - u15 >= 0.5)) then
        return;
    end;

    if (LocalPlayer:GetAttribute(v16.ReadyAt) or 0) > workspace:GetServerTimeNow() then
        return;
    end;

    if v16.Key == "StepOver" then
        if not StepOverMotion.request() then
            return;
        end;
    elseif v16.Key == "Cannon" then
        if not CannonMotion.request() then
            return;
        end;
    else
        local v17 = ChickenOrHero.Weapons:FindFirstChild(v16.Remote);

        if not v17 then
            return;
        end;

        v17:FireServer("Activate");
    end;

    u15 = os.clock();
end;

table.insert(u10, u2.Activated:Connect(request));
table.insert(u10, UserInputService.InputBegan:Connect(function(p18, p19) -- Line: 119
    -- upvalues: request (copy)
    if not (p19 or p18.KeyCode ~= Enum.KeyCode.R and p18.KeyCode ~= Enum.KeyCode.ButtonL1) then
        request();
    end;
end));
local u20 = 0;
table.insert(u10, RunService.RenderStepped:Connect(function(p21) -- Line: 125
    -- upvalues: u20 (ref), KnifeAbilities (copy), LocalPlayer (copy), u2 (copy), available (copy), ControlGate (copy), u1 (copy), UIScale (copy), UserInputService (copy), EquipmentHudLayoutLegacy (copy), style (copy), u4 (copy), u5 (copy), u7 (copy)
    u20 = u20 + p21;

    if u20 < 0.1 then
        return;
    end;

    u20 = 0;
    local v22 = KnifeAbilities.forSkin(LocalPlayer:GetAttribute("EquippedKnife"));
    local v23 = available(v22) and not ControlGate.reason(LocalPlayer);
    u2.Visible = v23;
    local AbsoluteSize = u1.AbsoluteSize;
    local math_min_ret = math.min(AbsoluteSize.X / 1000, AbsoluteSize.Y / 650);
    UIScale.Scale = math.clamp(math_min_ret, 0.58, 1);
    local v24 = UserInputService.TouchEnabled and EquipmentHudLayoutLegacy.touchStack;

    if v24 then
        UIScale.Scale = v24.factor;
        u2.AnchorPoint = Vector2.new(1, 1);
        local AbsolutePosition = u1.AbsolutePosition;
        u2.Position = UDim2.fromOffset(v24.right - AbsolutePosition.X, v24.top - v24.gap - AbsolutePosition.Y);
    else
        u2.AnchorPoint = Vector2.new(1, 0.5);
        u2.Position = UDim2.new(1, -24, 0.5, -140 * UIScale.Scale);
    end;

    if not u2.Visible then
        return;
    end;

    style(v22);
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v25 = (LocalPlayer:GetAttribute(v22.ReadyAt) or 0) - ServerTimeNow;
    local math_ceil_ret = math.ceil(v25);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v26 = ServerTimeNow < (LocalPlayer:GetAttribute(v22.Until) or 0);
    local string_upper_ret = string.upper(v22.Hint);
    u4.Text = v26 and string.upper(v22.ActiveLabel) or (math_max_ret > 0 and string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60) or string.upper(v22.Label));
    u5.Text = v26 and string.upper(v22.ActiveHint) or (math_max_ret > 0 and "RECHARGING" or (UserInputService.TouchEnabled and string.upper(v22.TouchHint) or (UserInputService.GamepadEnabled and "L1 / " .. string_upper_ret or "R / " .. string_upper_ret)));
    u2.BackgroundTransparency = math_max_ret > 0 and 0.5 or 0.15;
    u7.Size = UDim2.fromScale(math.clamp(1 - math_max_ret / v22.Cooldown, 0, 1), 1);
end));
script.Destroying:Connect(function() -- Line: 165
    -- upvalues: u10 (copy), u1 (copy)
    for _, v in u10 do
        v:Disconnect();
    end;

    u1:Destroy();
end);