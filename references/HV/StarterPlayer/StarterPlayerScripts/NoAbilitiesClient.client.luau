 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TextService = game:GetService("TextService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local AbilityRule = require(ChickenOrHero.Game:WaitForChild("AbilityRule"));
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local GothamBold = Enum.Font.GothamBold;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "NoAbilitiesHUD";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = false;
ScreenGui.DisplayOrder = 20;
ScreenGui:SetAttribute("SelfManagedText", true);
ScreenGui.Parent = PlayerGui;
local Frame = Instance.new("Frame");
Frame.Name = "NoAbilities";
Frame.BackgroundTransparency = 1;
Frame.Visible = false;
Frame.Parent = ScreenGui;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Line";
TextLabel.BackgroundTransparency = 1;
TextLabel.Font = GothamBold;
TextLabel.Text = "NO ABILITIES / NO ITEMS";
TextLabel.TextColor3 = Color3.new(1, 1, 1);
TextLabel.TextStrokeTransparency = 0.3;
TextLabel.TextScaled = false;
TextLabel.Parent = Frame;

local function findBanner() -- Line: 46
    -- upvalues: PlayerGui (copy)
    local Notifications = PlayerGui:FindFirstChild("Notifications");

    if Notifications then
        Notifications = Notifications:FindFirstChild("MainFrame");
    end;

    if Notifications then
        Notifications = Notifications:FindFirstChild("NotificationsF");
    end;

    return Notifications;
end;

local function shown(p1, p2) -- Line: 51
    while p1 and p1 ~= p2 do
        if p1:IsA("GuiObject") and not p1.Visible then
            return false;
        end;

        if p1:IsA("ScreenGui") and not p1.Enabled then
            return false;
        end;

        p1 = p1.Parent;
    end;

    return true;
end;

local function measure(p3) -- Line: 64
    -- upvalues: TextService (copy), GothamBold (copy)
    local math_floor_ret = math.floor(p3 + 0.5);
    local math_max_ret = math.max(9, math_floor_ret);
    local TextSize = TextService:GetTextSize("NO ABILITIES / NO ITEMS", math_max_ret, GothamBold, Vector2.new(1000, 1000));

    return {
        size = Vector2.new(TextSize.X + 4, math_max_ret + 2),
        text = math_max_ret
    };
end;

local function layout(p4, p5, p6, u7, p8, p9, p10) -- Line: 73
    -- upvalues: measure (copy)
    local v11 = measure(p8);
    local math_max_ret = math.max(6, p8 * 0.7);

    local function middle(p12) -- Line: 76
        -- upvalues: u7 (copy)
        return u7 - p12.size.Y / 2;
    end;

    local v13 = p5.X + p6.X + math_max_ret;

    if v13 + v11.size.X <= p4.X - 8 then
        v11.at = Vector2.new(v13, u7 - v11.size.Y / 2);

        return v11;
    end;

    local v14 = p9 + math_max_ret;
    local v15 = p4.X - 8 - v14;

    if v11.size.X <= v15 then
        v11.at = Vector2.new(v14, u7 - v11.size.Y / 2);

        return v11;
    end;

    local v16 = measure(p8 * math.max(0.7, v15 / v11.size.X));

    if v16.size.X <= v15 then
        v16.at = Vector2.new(v14, u7 - v16.size.Y / 2);

        return v16;
    end;

    v11.at = Vector2.new(p5.X + p6.X / 2 - v11.size.X / 2, p10 + math_max_ret);

    return v11;
end;

local u17 = nil;

local function place() -- Line: 99
    -- upvalues: u17 (ref), PlayerGui (copy), ScreenGui (copy), shown (copy), layout (copy), measure (copy), Frame (copy), TextLabel (copy)
    local v18 = u17 and (u17.Parent and u17);

    if not v18 then
        v18 = PlayerGui:FindFirstChild("Notifications");

        if v18 then
            v18 = v18:FindFirstChild("MainFrame");
        end;

        if v18 then
            v18 = v18:FindFirstChild("NotificationsF");
        end;
    end;

    u17 = v18;
    local AbsoluteSize = ScreenGui.AbsoluteSize;
    local v19;

    if u17 and (u17.AbsoluteSize.X > 0 and shown(u17, PlayerGui)) then
        local Frame2 = u17:FindFirstChild("Frame");
        local v20;

        if Frame2 then
            v20 = Frame2:FindFirstChild("Location");
        else
            v20 = Frame2;
        end;

        local v21;

        if v20 and (v20:IsA("TextLabel") and v20.TextBounds.Y > 0) then
            v21 = v20.TextBounds.Y;
        else
            v21 = u17.AbsoluteSize.Y * 0.17;
        end;

        local v22 = u17.AbsolutePosition.X + u17.AbsoluteSize.X / 2;
        local v23 = v22;

        for _, child in (Frame2 or u17):GetChildren() do
            if child:IsA("TextLabel") and (child.Visible and child.Text ~= "") then
                v23 = math.max(v23, v22 + child.TextBounds.X / 2);
            end;
        end;

        local v24;

        if Frame2 then
            v24 = Frame2:FindFirstChild("WhatsHappening");
        else
            v24 = Frame2;
        end;

        local v25;

        if v24 and v24:IsA("GuiObject") then
            v25 = v24.AbsolutePosition.Y + v24.AbsoluteSize.Y / 2;
        else
            v25 = u17.AbsolutePosition.Y + u17.AbsoluteSize.Y / 2;
        end;

        local v26 = u17.AbsolutePosition.Y + u17.AbsoluteSize.Y;

        for _, child in u17:GetChildren() do
            if child ~= Frame2 and (child:IsA("GuiObject") and (child.Visible and child.AbsolutePosition.Y >= v26 - 1)) then
                v26 = math.max(v26, child.AbsolutePosition.Y + child.AbsoluteSize.Y);
            end;
        end;

        v19 = layout(AbsoluteSize, u17.AbsolutePosition, u17.AbsoluteSize, v25, math.clamp(v21, 9, 28), v23, v26);
    else
        v19 = measure((math.clamp(AbsoluteSize.Y * 0.022, 9, 22)));
        v19.at = Vector2.new(AbsoluteSize.X / 2 - v19.size.X / 2, 8);
    end;

    Frame.Position = UDim2.fromOffset(v19.at.X, v19.at.Y);
    Frame.Size = UDim2.fromOffset(v19.size.X, v19.size.Y);
    TextLabel.TextSize = v19.text;
    TextLabel.Size = UDim2.fromScale(1, 1);
end;

local function render() -- Line: 140
    -- upvalues: Frame (copy), AbilityRule (copy), LocalPlayer (copy), place (copy)
    local v27 = AbilityRule.blocked(LocalPlayer) and (LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true);
    Frame.Visible = v27;

    if Frame.Visible then
        place();
    end;
end;

local u28 = {};

for _, v in AbilityRule.watch(LocalPlayer, render) do
    table.insert(u28, v);
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u28, AttributeChangedSignal:Connect(render));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("Spectating");
table.insert(u28, AttributeChangedSignal2:Connect(render));
local u29 = 0;
table.insert(u28, RunService.Heartbeat:Connect(function(p30) -- Line: 154
    -- upvalues: u29 (ref), Frame (copy), place (copy)
    u29 = u29 + p30;

    if u29 >= 0.25 and Frame.Visible then
        u29 = 0;
        place();
    end;
end));
script.Destroying:Connect(function() -- Line: 161
    -- upvalues: u28 (copy), ScreenGui (copy)
    for _, v in u28 do
        v:Disconnect();
    end;

    ScreenGui:Destroy();
end);
local v31 = AbilityRule.blocked(LocalPlayer) and (LocalPlayer:GetAttribute("InMatch") == true and true or LocalPlayer:GetAttribute("Spectating") == true);
Frame.Visible = v31;

if Frame.Visible then
    place();
end;