 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Weapons = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Weapons");
local KnifePerks = require(Weapons:WaitForChild("KnifePerks"));
local Session = Weapons.Parent:WaitForChild("Game"):WaitForChild("Session");
local AbilityRule = require(Weapons.Parent.Game:WaitForChild("AbilityRule"));
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "EquippedKnifeBonuses";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = false;
ScreenGui.DisplayOrder = 12;
ScreenGui:SetAttribute("SelfManagedText", true);
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Bonuses";
TextLabel.AnchorPoint = Vector2.new(1, 1);
TextLabel.Position = UDim2.new(1, -18, 1, -16);
TextLabel.Size = UDim2.fromOffset(330, 38);
TextLabel.BackgroundTransparency = 1;
TextLabel.Font = Enum.Font.GothamMedium;
TextLabel.TextSize = 11;
TextLabel.TextColor3 = Color3.fromRGB(235, 201, 137);
TextLabel.TextXAlignment = Enum.TextXAlignment.Right;
TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
TextLabel.TextStrokeTransparency = 0.55;
TextLabel.TextWrapped = true;
TextLabel.Parent = ScreenGui;

local function render() -- Line: 33
    -- upvalues: LocalPlayer (copy), KnifePerks (copy), TextLabel (copy), AbilityRule (copy), Session (copy), ScreenGui (copy)
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");
    local v1 = KnifePerks.forSkin(Attribute);
    local v2;

    if v1.Key == "None" then
        v2 = false;
    else
        v2 = not AbilityRule.blocked(LocalPlayer);
    end;

    TextLabel.Visible = v2;
    TextLabel.Text = string.format("%s KNIFE  ·  +%.2f SPEED\nITEM / ABILITY COOLDOWNS −%.2fs  ·  DODGE −%.2fs", string.upper(v1.Key), v1.SpeedBonus, v1.CooldownReduction, v1.DashCooldownReduction);
    TextLabel.TextColor3 = v1.Key == "Mythical" and Color3.fromRGB(255, 130, 145) or (v1.Key == "Legendary" and Color3.fromRGB(235, 201, 137) or Color3.fromRGB(184, 157, 241));

    if Session:GetAttribute("Ranked") == true then
        TextLabel.Visible = true;
        TextLabel.Text = "RANKED  ·  KNIFE BONUSES OFF";
        TextLabel.TextColor3 = Color3.fromRGB(255, 214, 120);
    end;

    local AbsoluteSize = ScreenGui.AbsoluteSize;
    local v3 = AbsoluteSize.X < 700 and true or AbsoluteSize.Y < 500;
    TextLabel.TextScaled = false;
    TextLabel.TextSize = v3 and 9 or 12;
    local UDim2_fromOffset = UDim2.fromOffset;
    local math_min_ret = math.min(v3 and 250 or 360, AbsoluteSize.X - 36);
    TextLabel.Size = UDim2_fromOffset(math.max(160, math_min_ret), v3 and 26 or 38);
end;

LocalPlayer:GetAttributeChangedSignal("EquippedKnife"):Connect(render);
local u4 = AbilityRule.watch(LocalPlayer, render);
local AttributeChangedSignal = Session:GetAttributeChangedSignal("Ranked");
table.insert(u4, AttributeChangedSignal:Connect(render));
ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(render);
render();
script.Destroying:Connect(function() -- Line: 64
    -- upvalues: u4 (copy), ScreenGui (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    ScreenGui:Destroy();
end);