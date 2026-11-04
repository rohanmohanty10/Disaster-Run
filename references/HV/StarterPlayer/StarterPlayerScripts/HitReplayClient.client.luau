 

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local CombatPrediction = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero").Game:WaitForChild("CombatPrediction"));
CombatPrediction.start();

if game.PlaceId ~= 130574217370467 then
    return;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "HitReplayStatus";
ScreenGui:SetAttribute("TestOnlyUI", true);
ScreenGui.Enabled = LocalPlayer:GetAttribute("TestUIHidden") == false;
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 119;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.AnchorPoint = Vector2.new(0, 1);
TextLabel.Position = UDim2.fromScale(0.01, 0.775);
TextLabel.Size = UDim2.fromScale(0.34, 0.04);
TextLabel.BackgroundTransparency = 0.3;
TextLabel.BackgroundColor3 = Color3.fromRGB(12, 22, 29);
TextLabel.TextColor3 = Color3.fromRGB(184, 231, 250);
TextLabel.Font = Enum.Font.GothamMedium;
TextLabel.TextScaled = true;
TextLabel.TextWrapped = true;
TextLabel.Text = "HIT REPLAY · waiting for contacts";
TextLabel.Parent = ScreenGui;
local u1 = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots and require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;

local function targetName(p2) -- Line: 33
    -- upvalues: Players (copy), u1 (copy)
    local targetId = p2.targetId;
    local v3;

    if type(targetId) == "number" then
        v3 = Players:GetPlayerByUserId(targetId) or u1 and u1.get(targetId);
    else
        v3 = false;
    end;

    if v3 then
        return v3.DisplayName;
    end;

    return typeof(p2.target) == "Instance" and p2.target.Name or nil;
end;

local u7 = CombatPrediction.subscribe(function(p4) -- Line: 41
    -- upvalues: Players (copy), u1 (copy), TextLabel (copy)
    local targetId = p4.targetId;
    local v5;

    if type(targetId) == "number" then
        v5 = Players:GetPlayerByUserId(targetId) or u1 and u1.get(targetId);
    else
        v5 = false;
    end;

    local v6;

    if v5 then
        v6 = v5.DisplayName;
    elseif typeof(p4.target) == "Instance" then
        v6 = p4.target.Name or nil;
    else
        v6 = nil;
    end;

    TextLabel.Text = string.format("%s: %s · %s%s%s", p4.kind or "HIT", p4.verdict or (p4.accepted == true and "HIT" or (p4.accepted == false and "MISS" or "RESULT")), p4.reason or "", v6 and " · " .. v6 or "", type(p4.latencyMs) == "number" and (string.format(" · %dms", p4.latencyMs) or "") or "");
end);
local u8 = LocalPlayer:GetAttributeChangedSignal("TestUIHidden"):Connect(function() -- Line: 52
    -- upvalues: ScreenGui (copy), LocalPlayer (copy)
    ScreenGui.Enabled = LocalPlayer:GetAttribute("TestUIHidden") == false;
end);
script.Destroying:Connect(function() -- Line: 55
    -- upvalues: u7 (copy), u8 (copy), ScreenGui (copy)
    u7:Disconnect();
    u8:Disconnect();
    ScreenGui:Destroy();
end);