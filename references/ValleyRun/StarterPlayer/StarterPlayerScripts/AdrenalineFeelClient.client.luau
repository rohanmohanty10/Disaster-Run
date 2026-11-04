 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local Gear = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Gear");
local GearPredictionClient = require(Gear:WaitForChild("GearPredictionClient"));
local Color3_fromRGB_ret = Color3.fromRGB(125, 205, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(205, 35, 45);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "AdrenalineFeel";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 1;
ScreenGui.Enabled = false;
local u1 = {};

for _, v in {
    { UDim2.fromScale(1, 0.24), UDim2.fromScale(0, 0), 90 },
    { UDim2.fromScale(1, 0.24), UDim2.fromScale(0, 0.76), -90 },
    { UDim2.fromScale(0.16, 1), UDim2.fromScale(0, 0), 0 },
    { UDim2.fromScale(0.16, 1), UDim2.fromScale(0.84, 0), 180 }
} do
    local Frame = Instance.new("Frame");
    Frame.Name = "Edge";
    local v2 = v[2];
    Frame.Size = v[1];
    Frame.Position = v2;
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Interactable = false;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = v[3];
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.45, 0.6), NumberSequenceKeypoint.new(1, 1) });
    UIGradient.Parent = Frame;
    Frame.Parent = ScreenGui;
    table.insert(u1, Frame);
end;

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local u3 = {};

local function fade(p4, p5, p6) -- Line: 53
    -- upvalues: u3 (copy), u1 (copy), TweenService (copy)
    for _, v in u3 do
        v:Cancel();
    end;

    table.clear(u3);

    for _, v in u1 do
        local v7 = TweenService:Create(v, TweenInfo.new(p5, p6, Enum.EasingDirection.Out), {
            BackgroundTransparency = p4
        });
        table.insert(u3, v7);
        v7:Play();
    end;
end;

local u8 = false;
local u9 = 0;
local u10 = 0;

local function set(p11) -- Line: 68
    -- upvalues: u8 (ref), u9 (ref), LocalPlayer (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u1 (copy), ScreenGui (copy), fade (copy)
    if p11 == u8 then
        return;
    end;

    u8 = p11;
    u9 = u9 + 1;
    local u12 = u9;
    LocalPlayer:SetAttribute("AdrenalineFeel", p11 and true or nil);

    if not p11 then
        fade(1, 0.6, Enum.EasingStyle.Sine);
        task.delay(0.65, function() -- Line: 91
            -- upvalues: u8 (ref), u9 (ref), u12 (copy), ScreenGui (ref)
            if not u8 and u9 == u12 then
                ScreenGui.Enabled = false;
            end;
        end);

        return;
    end;

    local v13;

    if LocalPlayer:GetAttribute("GameRole") == "Catcher" then
        v13 = Color3_fromRGB_ret2;
    else
        v13 = Color3_fromRGB_ret;
    end;

    for _, v in u1 do
        v.BackgroundColor3 = v13;
    end;

    ScreenGui.Enabled = true;
    fade(0.35, 0.15, Enum.EasingStyle.Quad);
    task.delay(0.2, function() -- Line: 84
        -- upvalues: u8 (ref), u9 (ref), u12 (copy), fade (ref)
        if u8 and u9 == u12 then
            fade(0.62, 0.7, Enum.EasingStyle.Sine);
        end;
    end);
end;

local function refresh() -- Line: 98
    -- upvalues: set (copy), LocalPlayer (copy), u10 (ref)
    set(LocalPlayer:GetAttribute("GearBoost") == true and true or os.clock() < u10);
end;

local u16 = { LocalPlayer:GetAttributeChangedSignal("GearBoost"):Connect(refresh), GearPredictionClient.FX.Event:Connect(function(p14) -- Line: 104
        -- upvalues: LocalPlayer (copy), u10 (ref), set (copy), refresh (copy)
        if type(p14) == "table" and (p14.kind == "Adrenaline" and p14.ownerId == LocalPlayer.UserId) then
            u10 = os.clock() + 1;
            set(LocalPlayer:GetAttribute("GearBoost") == true and true or os.clock() < u10);
            task.delay(1.05, refresh);
        end;
    end), GearPredictionClient.Cancel.Event:Connect(function(p15) -- Line: 111
        -- upvalues: u10 (ref), set (copy), LocalPlayer (copy)
        if type(p15) == "table" and p15.item == "Adrenaline" then
            u10 = 0;
            set(LocalPlayer:GetAttribute("GearBoost") == true and true or os.clock() < u10);
        end;
    end) };
set(LocalPlayer:GetAttribute("GearBoost") == true and true or os.clock() < u10);
script.Destroying:Connect(function() -- Line: 120
    -- upvalues: u16 (copy), u3 (copy), LocalPlayer (copy), ScreenGui (copy)
    for _, v in u16 do
        v:Disconnect();
    end;

    for _, v in u3 do
        v:Cancel();
    end;

    LocalPlayer:SetAttribute("AdrenalineFeel", nil);
    ScreenGui:Destroy();
end);