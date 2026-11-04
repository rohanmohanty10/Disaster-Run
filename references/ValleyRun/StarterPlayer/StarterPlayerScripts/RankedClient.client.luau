 

 

local Players = game:GetService("Players");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Session = ChickenOrHero:WaitForChild("Game"):WaitForChild("Session");
local RankedConfig = require(ChickenOrHero.Game:WaitForChild("RankedConfig"));
local LocalPlayer = Players.LocalPlayer;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).Ranked ~= true then
    return;
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 202, 58);
local Color3_fromRGB_ret2 = Color3.fromRGB(253, 60, 85);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "RankedBadge";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 6;
ScreenGui.Enabled = false;
local Frame = Instance.new("Frame");
Frame.Name = "Pill";
Frame.AnchorPoint = Vector2.new(0.5, 0);
Frame.Position = UDim2.new(0.5, 0, 0, 96);
Frame.Size = UDim2.fromOffset(132, 30);
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24);
Frame.BackgroundTransparency = 0.15;
Frame.BorderSizePixel = 0;
Frame.Parent = ScreenGui;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(1, 0);
UICorner.Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Thickness = 2;
UIStroke.Color = Color3_fromRGB_ret;
UIStroke.Parent = Frame;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Text";
TextLabel:SetAttribute("SelfManagedText", true);
TextLabel.BackgroundTransparency = 1;
TextLabel.Size = UDim2.fromScale(1, 1);
TextLabel.Font = Enum.Font.GothamBlack;
TextLabel.TextSize = 17;
TextLabel.TextColor3 = Color3_fromRGB_ret;
TextLabel.Text = "RANKED";
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Color = Color3.new(0, 0, 0);
UIStroke2.Thickness = 1.5;
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
UIStroke2.Parent = TextLabel;
TextLabel.Parent = Frame;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

local function refresh() -- Line: 55
    -- upvalues: Session (copy), ScreenGui (copy), TextLabel (copy), RankedConfig (copy), Color3_fromRGB_ret2 (copy), UIStroke (copy), Frame (copy), Color3_fromRGB_ret (copy)
    local v1 = Session:GetAttribute("Ranked") == true;
    ScreenGui.Enabled = v1;

    if not v1 then
        return;
    end;

    local Attribute = Session:GetAttribute("RankedEndEvent");

    if type(Attribute) == "number" then
        TextLabel.Text = ("END EVENT  %d / %d"):format(Attribute, RankedConfig.EndEventRounds);
        TextLabel.TextColor3 = Color3_fromRGB_ret2;
        UIStroke.Color = Color3_fromRGB_ret2;
        Frame.Size = UDim2.fromOffset(210, 30);

        return;
    end;

    TextLabel.Text = "RANKED";
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    UIStroke.Color = Color3_fromRGB_ret;
    Frame.Size = UDim2.fromOffset(132, 30);
end;

local TweenService = game:GetService("TweenService");
local ScreenGui2 = Instance.new("ScreenGui");
ScreenGui2.Name = "RankedWipe";
ScreenGui2.ResetOnSpawn = false;
ScreenGui2.IgnoreGuiInset = true;
ScreenGui2.DisplayOrder = 90;
ScreenGui2.Enabled = false;
local Frame2 = Instance.new("Frame");
Frame2.Name = "Cover";
Frame2.Size = UDim2.fromScale(1, 1);
Frame2.BackgroundColor3 = Color3.fromRGB(6, 12, 28);
Frame2.BorderSizePixel = 0;
Frame2.Active = true;
Frame2.Parent = ScreenGui2;
local u2 = TextLabel:Clone();
u2.Name = "Heading";
u2.AnchorPoint = Vector2.new(0.5, 0.5);
u2.Position = UDim2.fromScale(0.5, 0.46);
u2.Size = UDim2.fromOffset(700, 70);
u2.TextSize = 54;
u2.Parent = Frame2;
local u3 = TextLabel:Clone();
u3.Name = "Sub";
u3.AnchorPoint = Vector2.new(0.5, 0.5);
u3.Position = UDim2.new(0.5, 0, 0.46, 52);
u3.Size = UDim2.fromOffset(700, 30);
u3.TextSize = 20;
u3.Font = Enum.Font.GothamBold;
u3.TextColor3 = Color3.fromRGB(170, 196, 240);
u3.Parent = Frame2;
ScreenGui2.Parent = LocalPlayer:WaitForChild("PlayerGui");
local u4 = nil;

local function wipeIn() -- Line: 108
    -- upvalues: Session (copy), u2 (copy), Color3_fromRGB_ret (copy), u3 (copy), u4 (ref), Frame2 (copy), ScreenGui2 (copy), TweenService (copy)
    local Attribute = Session:GetAttribute("RankedRefreshAt");

    if type(Attribute) ~= "number" or workspace:GetServerTimeNow() - Attribute > 4 then
        return;
    end;

    local v5 = Session:GetAttribute("RankedRefreshOn") == true;
    u2.Text = v5 and "ENTERING RANKED" or "LEAVING RANKED";
    local v6;

    if v5 then
        v6 = Color3_fromRGB_ret;
    else
        v6 = Color3.new(1, 1, 1);
    end;

    u2.TextColor3 = v6;
    u3.Text = not v5 and "Back to normal matches" or (require(game.ReplicatedStorage.ChickenOrHero.Game.RankedConfig).LoadoutEnabled and "Loadout  ·  Map vote  ·  Match  ·  Results" or "Map vote  ·  Match  ·  Results");
    local u7 = {};
    u4 = u7;
    Frame2.BackgroundTransparency = 1;
    u2.TextTransparency = 1;
    u3.TextTransparency = 1;
    ScreenGui2.Enabled = true;
    local TweenInfo_new_ret = TweenInfo.new(0.3);
    TweenService:Create(Frame2, TweenInfo_new_ret, {
        BackgroundTransparency = 0
    }):Play();
    TweenService:Create(u2, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    TweenService:Create(u3, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    task.delay(1.9, function() -- Line: 129
        -- upvalues: u4 (ref), u7 (copy), TweenService (ref), Frame2 (ref), u2 (ref), u3 (ref), ScreenGui2 (ref)
        if u4 ~= u7 then
            return;
        end;

        local TweenInfo_new_ret2 = TweenInfo.new(0.5);
        TweenService:Create(Frame2, TweenInfo_new_ret2, {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u2, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
        TweenService:Create(u3, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
        task.delay(0.55, function() -- Line: 137
            -- upvalues: u4 (ref), u7 (ref), ScreenGui2 (ref)
            if u4 == u7 then
                ScreenGui2.Enabled = false;
            end;
        end);
    end);
end;

local u8 = { Session:GetAttributeChangedSignal("Ranked"):Connect(refresh), Session:GetAttributeChangedSignal("RankedEndEvent"):Connect(refresh), Session:GetAttributeChangedSignal("RankedRefreshAt"):Connect(wipeIn) };
refresh();
script.Destroying:Connect(function() -- Line: 150
    -- upvalues: u8 (copy), ScreenGui (copy), ScreenGui2 (copy)
    for _, v in u8 do
        v:Disconnect();
    end;

    ScreenGui:Destroy();
    ScreenGui2:Destroy();
end);