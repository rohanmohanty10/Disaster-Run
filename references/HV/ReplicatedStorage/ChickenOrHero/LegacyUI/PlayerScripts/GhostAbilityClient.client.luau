 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local GhostAbilityEvent = ChickenOrHero.Weapons:WaitForChild("GhostAbilityEvent");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local Session = ChickenOrHero.Game.Session;
local AbilityRule = require(ChickenOrHero.Game:WaitForChild("AbilityRule"));
local u1 = Panels.screen(LocalPlayer, "GhostAbilityHUD", 35);
local u2 = Panels.button(u1, "Ghost", "", 0, 0, 156, 80);
Theme.button(u2, Color3.fromRGB(74, 175, 166));
local v3 = Skin.HudAccents.ghost[1];
local v4 = Skin.HudAccents.ghost[2];
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Theme.Ink), ColorSequenceKeypoint.new(0.55, Theme.Ink), ColorSequenceKeypoint.new(1, v4) });
u2.BackgroundColor3 = Color3.new(1, 1, 1);
u2.Border.Color = v3;
u2.Corner.CornerRadius = UDim.new(0, 12);
local v5 = u2:FindFirstChild("SkinGradient") or Instance.new("UIGradient");
v5.Name = "SkinGradient";
v5.Rotation = 90;
v5.Color = ColorSequence_new_ret;
v5.Parent = u2;
u2.AnchorPoint = Vector2.new(1, 0.5);
u2.Visible = false;
local u6 = Panels.text(u2, "Label", "GHOST", 12, 13, 132, 27, 18, Theme.Paper);
u6.TextXAlignment = Enum.TextXAlignment.Center;
u6.Font = Enum.Font.GothamBold;
local u7 = Panels.text(u2, "Hint", "R / FADE", 12, 45, 132, 19, 11, v3);
u7.TextXAlignment = Enum.TextXAlignment.Center;
local v8 = Panels.make("Frame", u2, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(12, 69),
    Size = UDim2.fromOffset(132, 4),
    BackgroundColor3 = Skin.Palette.track
});
Panels.corner(v8, 4);
local u9 = Panels.make("Frame", v8, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = v3
});
Panels.corner(u9, 4);
local UIScale = Instance.new("UIScale");
UIScale.Parent = u2;
local u10 = {};

local function on(p11, p12) -- Line: 60
    -- upvalues: u10 (copy)
    table.insert(u10, p11:Connect(p12));
end;

local function available() -- Line: 63
    -- upvalues: LocalPlayer (copy), Session (copy), AbilityRule (copy)
    local v13;

    if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("EquippedKnife") == "GhostScythe" and (LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("RunState") == "Active" and (LocalPlayer:GetAttribute("GameRole") == "Runner" or LocalPlayer:GetAttribute("GameRole") == "Catcher")))) then
        v13 = not (Session:GetAttribute("GlobalPaused") or Session:GetAttribute("MapChanging")) and not AbilityRule.knifeBlocked(LocalPlayer);
    else
        v13 = false;
    end;

    return v13;
end;

local u14 = (-1 / 0);

local function request() -- Line: 75
    -- upvalues: available (copy), ControlGate (copy), LocalPlayer (copy), u14 (ref), GhostAbilityEvent (copy)
    if not (available() and (not ControlGate.reason(LocalPlayer) and os.clock() - u14 >= 0.5)) then
        return;
    end;

    if (LocalPlayer:GetAttribute("GhostAbilityReadyAt") or 0) > workspace:GetServerTimeNow() then
        return;
    end;

    u14 = os.clock();
    GhostAbilityEvent:FireServer("Activate");
end;

table.insert(u10, u2.Activated:Connect(request));
table.insert(u10, UserInputService.InputBegan:Connect(function(p15, p16) -- Line: 86
    -- upvalues: request (copy)
    if not (p16 or p15.KeyCode ~= Enum.KeyCode.R and p15.KeyCode ~= Enum.KeyCode.ButtonL1) then
        request();
    end;
end));

local function cue(p17) -- Line: 91
    -- upvalues: Debris (copy), TweenService (copy)
    local Character = p17.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://8408521761";
    Sound.Volume = 0.35;
    Sound.RollOffMaxDistance = 100;
    Sound.Parent = Character;
    Sound:Play();
    Debris:AddItem(Sound, 3);
    local Part = Instance.new("Part");
    Part.Name = "GhostScythePulse";
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(155, 255, 230);
    Part.Transparency = 0.55;
    Part.Size = Vector3.new(2, 3, 2);
    Part.CFrame = CFrame.new(Character.Position);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Parent = workspace;
    TweenService:Create(Part, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {
        Size = Vector3.new(9, 9, 9),
        Transparency = 1
    }):Play();
    Debris:AddItem(Part, 0.5);
end;

table.insert(u10, GhostAbilityEvent.OnClientEvent:Connect(function(p18, p19) -- Line: 123
    -- upvalues: Players (copy), cue (copy)
    local v20 = p18 == "Activated" and (type(p19) == "number" and Players:GetPlayerByUserId(p19));

    if v20 then
        cue(v20);
    end;
end));
local u21 = 0;
table.insert(u10, RunService.RenderStepped:Connect(function(p22) -- Line: 132
    -- upvalues: u21 (ref), u2 (copy), available (copy), ControlGate (copy), LocalPlayer (copy), u1 (copy), UIScale (copy), UserInputService (copy), EquipmentHudLayoutLegacy (copy), u6 (copy), u7 (copy), u9 (copy)
    u21 = u21 + p22;

    if u21 < 0.1 then
        return;
    end;

    u21 = 0;
    local v23 = available() and not ControlGate.reason(LocalPlayer);
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

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v25 = (LocalPlayer:GetAttribute("GhostAbilityReadyAt") or 0) - ServerTimeNow;
    local math_ceil_ret = math.ceil(v25);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v26 = ServerTimeNow < (LocalPlayer:GetAttribute("GhostImmuneUntil") or 0);
    u6.Text = v26 and "GHOSTED" or (math_max_ret > 0 and (string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60) or "GHOST") or "GHOST");
    u7.Text = v26 and "IMMUNE · 2 SECONDS" or (math_max_ret > 0 and "RECHARGING" or (UserInputService.TouchEnabled and "TAP TO FADE" or (UserInputService.GamepadEnabled and "L1 / FADE" or "R / FADE")));
    u2.BackgroundTransparency = math_max_ret > 0 and 0.5 or 0.15;
    u9.Size = UDim2.fromScale(math.clamp(1 - math_max_ret / 45, 0, 1), 1);
end));
script.Destroying:Connect(function() -- Line: 169
    -- upvalues: u10 (copy)
    for _, v in u10 do
        v:Disconnect();
    end;
end);