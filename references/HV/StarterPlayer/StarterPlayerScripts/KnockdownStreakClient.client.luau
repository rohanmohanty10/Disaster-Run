 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(255, 170, 60);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 214, 90);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "KnockdownStreak";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 21;
ScreenGui:SetAttribute("SelfManagedText", true);
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Streak";
TextLabel.AnchorPoint = Vector2.new(0.5, 0);
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 36);
TextLabel.Size = UDim2.fromOffset(280, 26);
TextLabel.BackgroundTransparency = 1;
TextLabel.Font = Enum.Font.GothamBlack;
TextLabel.TextColor3 = Color3_fromRGB_ret;
TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
TextLabel.TextTransparency = 1;
TextLabel.TextStrokeTransparency = 1;
local UIScale = Instance.new("UIScale");
UIScale.Parent = TextLabel;
TextLabel.Parent = ScreenGui;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

local function fit() -- Line: 41
    -- upvalues: TextLabel (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v1 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    TextLabel.TextSize = (v1.X < 700 or v1.Y < 500) and 14 or 18;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;
local v2 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
TextLabel.TextSize = (v2.X < 700 or v2.Y < 500) and 14 or 18;
local u3 = {};

if workspace.CurrentCamera then
    local PropertyChangedSignal = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize");
    table.insert(u3, PropertyChangedSignal:Connect(fit));
end;

local u4 = 0;
local u5 = LocalPlayer:GetAttribute("KnockdownStreak") or 0;

local function show(p6) -- Line: 54
    -- upvalues: u4 (ref), TextLabel (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), UIScale (copy), TweenService (copy), SoundService (copy)
    u4 = u4 + 1;
    local u7 = u4;
    TextLabel.Text = p6 .. "x KNOCKDOWNS";
    TextLabel.TextColor3 = p6 >= 5 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
    TextLabel.TextTransparency = 0;
    TextLabel.TextStrokeTransparency = 0.3;
    UIScale.Scale = 1.45;
    TweenService:Create(UIScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play();
    task.delay(2.2, function() -- Line: 62
        -- upvalues: u4 (ref), u7 (copy), TweenService (ref), TextLabel (ref)
        if u4 == u7 then
            TweenService:Create(TextLabel, TweenInfo.new(0.4), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
        end;
    end);
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://9126073001";
    Sound.Volume = 0.5;
    Sound.PlaybackSpeed = math.min(2, 1 + (p6 - 1) * 0.08);
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 73
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    task.delay(5, function() -- Line: 76
        -- upvalues: Sound (copy)
        if Sound.Parent then
            Sound:Destroy();
        end;
    end);
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("KnockdownStreak");
table.insert(u3, AttributeChangedSignal:Connect(function() -- Line: 83
    -- upvalues: LocalPlayer (copy), u5 (ref), show (copy)
    local v8 = LocalPlayer:GetAttribute("KnockdownStreak") or 0;

    if type(v8) == "number" and u5 < v8 then
        show(v8);
    end;

    u5 = type(v8) == "number" and v8 and v8 or 0;
end));
script.Destroying:Connect(function() -- Line: 91
    -- upvalues: u3 (copy), ScreenGui (copy)
    for _, v in u3 do
        v:Disconnect();
    end;

    ScreenGui:Destroy();
end);