 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local CloneAbilityConfig = require(ChickenOrHero.Weapons:WaitForChild("CloneAbilityConfig"));
local CloneAbilityEvent = ChickenOrHero.Weapons:WaitForChild("CloneAbilityEvent");
local CloneSplitEffects = require(ChickenOrHero.Weapons:WaitForChild("CloneSplitEffects"));
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local ControlGate = require(ChickenOrHero.Movement.ControlGate);
local EquipmentHudLayoutLegacy = require(ChickenOrHero.Presentation:WaitForChild("EquipmentHudLayoutLegacy"));
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local Session = ChickenOrHero.Game.Session;
local AbilityRule = require(ChickenOrHero.Game:WaitForChild("AbilityRule"));
local u1 = Panels.screen(LocalPlayer, "KnifeAbilityHUD", 35);
local u2 = Panels.button(u1, "Clone", "", 0, 0, 156, 80);
Theme.button(u2, Theme.Blue);
local u3 = Skin.HudAccents.clone[1];
local v4 = Skin.HudAccents.clone[2];
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Theme.Ink), ColorSequenceKeypoint.new(0.55, Theme.Ink), ColorSequenceKeypoint.new(1, v4) });
u2.BackgroundColor3 = Color3.new(1, 1, 1);
u2.Border.Color = u3;
u2.Corner.CornerRadius = UDim.new(0, 12);
u2.AnchorPoint = Vector2.new(1, 0.5);
u2.Position = UDim2.new(1, -24, 0.43, 0);
u2.Visible = false;
local u5 = Panels.text(u2, "Label", "CLONE", 49, 13, 100, 22, 15, Theme.Paper);
u5.TextXAlignment = Enum.TextXAlignment.Center;
local u6 = Panels.text(u2, "Hint", "R  /  2 COPIES", 49, 39, 100, 18, 10, u3);
u6.TextXAlignment = Enum.TextXAlignment.Center;
u5.Font = Enum.Font.GothamBold;
u6.Font = Enum.Font.GothamBold;
local u7 = Panels.make("UIGradient", u2, "Shimmer", {
    Rotation = 25,
    Color = ColorSequence_new_ret
});

for i = 1, 3 do
    local v8 = (i - 1) * 9 + 9;
    local v9 = Panels.make("Frame", u2, "CloneHead" .. i, {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(v8, 22 - (i == 2 and 4 or 0)),
        Size = UDim2.fromOffset(10, 10),
        BackgroundColor3 = u3,
        BackgroundTransparency = i == 2 and 0 or 0.4
    });
    Panels.corner(v9, 5);
    local v10 = Panels.make("Frame", u2, "CloneBody" .. i, {
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(v8 - 2, 33 - (i == 2 and 4 or 0)),
        Size = UDim2.fromOffset(14, 20),
        BackgroundColor3 = u3,
        BackgroundTransparency = i == 2 and 0 or 0.4
    });
    Panels.corner(v10, 4);
    local _ = i;
end;

local v11 = Panels.make("Frame", u2, "Track", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(12, 69),
    Size = UDim2.fromOffset(132, 4),
    BackgroundColor3 = Skin.Palette.track
});
Panels.corner(v11, 4);
local u12 = Panels.make("Frame", v11, "Fill", {
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = u3
});
Panels.corner(u12, 4);
local UIScale = Instance.new("UIScale");
UIScale.Parent = u2;

local function pop() -- Line: 81
    -- upvalues: TweenService (copy), u2 (copy)
    TweenService:Create(u2, TweenInfo.new(0.09), {
        Rotation = 3
    }):Play();
    task.delay(0.09, function() -- Line: 83
        -- upvalues: u2 (ref), TweenService (ref)
        if u2.Parent then
            TweenService:Create(u2, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                Rotation = 0
            }):Play();
        end;
    end);
end;

local u13 = (-1 / 0);
local u14 = {};

local function on(p15, p16) -- Line: 91
    -- upvalues: u14 (copy)
    table.insert(u14, p15:Connect(p16));
end;

local function available() -- Line: 94
    -- upvalues: CloneAbilityConfig (copy), LocalPlayer (copy), Session (copy), AbilityRule (copy)
    local Enabled = CloneAbilityConfig.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("EquippedKnife") == CloneAbilityConfig.Skin and (LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("RunState") == "Active" and (LocalPlayer:GetAttribute("GameRole") == "Runner" or LocalPlayer:GetAttribute("GameRole") == "Catcher")))) then
            Enabled = not (Session:GetAttribute("GlobalPaused") or Session:GetAttribute("MapChanging")) and not AbilityRule.knifeBlocked(LocalPlayer);
        else
            Enabled = false;
        end;
    end;

    return Enabled;
end;

local function request() -- Line: 106
    -- upvalues: available (copy), ControlGate (copy), LocalPlayer (copy), u13 (ref), pop (copy), CloneAbilityEvent (copy), CloneSplitEffects (copy)
    if not (available() and (not ControlGate.reason(LocalPlayer) and os.clock() - u13 >= 0.5)) then
        return;
    end;

    if (LocalPlayer:GetAttribute("CloneAbilityReadyAt") or 0) > workspace:GetServerTimeNow() then
        return;
    end;

    u13 = os.clock();
    pop();
    CloneAbilityEvent:FireServer("Activate");
    local v17 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v17 then
        CloneSplitEffects.play(v17.Position);
    end;
end;

table.insert(u14, u2.Activated:Connect(request));
table.insert(u14, u2.MouseEnter:Connect(function() -- Line: 122
    -- upvalues: TweenService (copy), u7 (copy)
    TweenService:Create(u7, TweenInfo.new(0.2), {
        Rotation = 70
    }):Play();
end));
table.insert(u14, u2.MouseLeave:Connect(function() -- Line: 125
    -- upvalues: TweenService (copy), u7 (copy)
    TweenService:Create(u7, TweenInfo.new(0.2), {
        Rotation = 25
    }):Play();
end));
table.insert(u14, UserInputService.InputBegan:Connect(function(p18, p19) -- Line: 128
    -- upvalues: request (copy)
    if not (p19 or p18.KeyCode ~= Enum.KeyCode.R and p18.KeyCode ~= Enum.KeyCode.ButtonL1) then
        request();
    end;
end));

local function pulse(p20) -- Line: 133
    -- upvalues: Theme (copy), TweenService (copy), Debris (copy)
    if typeof(p20) ~= "Vector3" then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or (workspace_CurrentCamera.CFrame.Position - p20).Magnitude > 110 then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "ClonePulse";
    Part.Shape = Enum.PartType.Ball;
    Part.Size = Vector3.new(2, 4, 2);
    Part.CFrame = CFrame.new(p20);
    Part.Material = Enum.Material.Neon;
    Part.Color = Theme.Blue;
    Part.Transparency = 0.65;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = workspace;
    TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = Vector3.new(6, 6, 6),
        Transparency = 1
    }):Play();
    Debris:AddItem(Part, 0.45);
end;

table.insert(u14, CloneAbilityEvent.OnClientEvent:Connect(function(p21, p22) -- Line: 159
    -- upvalues: HudNavigation (copy), LocalPlayer (copy), u13 (ref), CloneSplitEffects (copy), pulse (copy)
    if p21 == "Notice" and type(p22) == "string" then
        HudNavigation.Notice:Fire(p22);

        return;
    end;

    if p21 == "Split" and type(p22) == "table" then
        if p22.ownerId ~= LocalPlayer.UserId or os.clock() - u13 > 1 then
            CloneSplitEffects.play(p22.position);
        end;
    elseif p21 == "Dissolve" and type(p22) == "table" then
        pulse(p22.position);
    end;
end));
local u23 = 0;
local u24 = false;
table.insert(u14, RunService.RenderStepped:Connect(function(p25) -- Line: 173
    -- upvalues: u23 (ref), u2 (copy), available (copy), ControlGate (copy), LocalPlayer (copy), u1 (copy), UIScale (copy), UserInputService (copy), EquipmentHudLayoutLegacy (copy), u5 (copy), u6 (copy), u12 (copy), CloneAbilityConfig (copy), Theme (copy), u3 (copy), u24 (ref), pop (copy)
    u23 = u23 + p25;

    if u23 < 0.1 then
        return;
    end;

    u23 = 0;
    local v26 = available() and not ControlGate.reason(LocalPlayer);
    u2.Visible = v26;
    local AbsoluteSize = u1.AbsoluteSize;
    local math_min_ret = math.min(AbsoluteSize.X / 1000, AbsoluteSize.Y / 650);
    UIScale.Scale = math.clamp(math_min_ret, 0.58, 1);
    local v27 = UserInputService.TouchEnabled and EquipmentHudLayoutLegacy.touchStack;

    if v27 then
        UIScale.Scale = v27.factor;
        u2.AnchorPoint = Vector2.new(1, 1);
        local AbsolutePosition = u1.AbsolutePosition;
        u2.Position = UDim2.fromOffset(v27.right - AbsolutePosition.X, v27.top - v27.gap - AbsolutePosition.Y);
    else
        u2.AnchorPoint = Vector2.new(1, 0.5);
        u2.Position = UDim2.new(1, -24, 0.5, -140 * UIScale.Scale);
    end;

    if not u2.Visible then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v28 = (LocalPlayer:GetAttribute("CloneAbilityReadyAt") or 0) - ServerTimeNow;
    local math_ceil_ret = math.ceil(v28);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v29 = ServerTimeNow < (LocalPlayer:GetAttribute("CloneAbilityActiveUntil") or 0);
    u5.Text = v29 and "CLONES OUT" or (math_max_ret > 0 and (string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60) or "CLONE") or "CLONE");
    u6.Text = v29 and "TWO OF A KIND" or (math_max_ret > 0 and "RECHARGING" or (UserInputService.TouchEnabled and "TAP TO SPLIT" or (UserInputService.GamepadEnabled and "L1  /  2 COPIES" or "R  /  2 COPIES")));
    u2.BackgroundTransparency = math_max_ret > 0 and 0.5 or 0.15;
    u12.Size = UDim2.fromScale(math.clamp(1 - math_max_ret / (CloneAbilityConfig.Cooldown or 45), 0, 1), 1);
    u12.BackgroundColor3 = v29 and Theme.Paper or u3;
    local v30 = math_max_ret == 0;

    if v30 and not u24 then
        pop();
    end;

    u24 = v30;
end));
script.Destroying:Connect(function() -- Line: 216
    -- upvalues: u14 (copy), u1 (copy)
    for _, v in u14 do
        v:Disconnect();
    end;

    u1:Destroy();
end);