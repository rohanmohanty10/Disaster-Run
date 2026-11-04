 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local BoostRequest = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("BoostRequest");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "PerfectDodgeFeedback";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 65;
ScreenGui:SetAttribute("UIProportionalExclude", true);
ScreenGui.Parent = PlayerGui;
local Sound = Instance.new("Sound");
Sound.Name = "PerfectDodgeSound";
Sound.SoundId = "rbxassetid://132570658772029";
Sound.Volume = 0.35;
Sound.Parent = ScreenGui;
local Frame = Instance.new("Frame");
Frame.BackgroundTransparency = 1;
Frame.AnchorPoint = Vector2.new(0.5, 1);
Frame.Parent = ScreenGui;
local TextLabel = Instance.new("TextLabel");
TextLabel.Size = UDim2.fromScale(1, 1);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "PERFECT DODGE";
TextLabel.TextColor3 = Color3.fromHex("FFCA3A");
TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
TextLabel.TextStrokeTransparency = 0.3;
TextLabel.TextScaled = true;
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.Visible = false;
TextLabel.Parent = Frame;
local u1 = 0;
local u2 = nil;

local function place() -- Line: 39
    -- upvalues: PlayerGui (copy), Frame (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local v3 = (1 / 0);
    local v4 = (-1 / 0);
    local v5 = (1 / 0);

    for _, v in { "AbilityControls", "GearControls" } do
        local v6 = PlayerGui:FindFirstChild(v);

        if v6 and v6.Enabled then
            for _, child in v6:GetChildren() do
                if child:IsA("GuiButton") and child.Visible then
                    local AbsolutePosition = child.AbsolutePosition;
                    local AbsoluteSize = child.AbsoluteSize;
                    v3 = math.min(v3, AbsolutePosition.X);
                    v4 = math.max(v4, AbsolutePosition.X + AbsoluteSize.X);
                    v5 = math.min(v5, AbsolutePosition.Y);
                end;
            end;
        end;
    end;

    local math_clamp_ret = math.clamp(ViewportSize.X * 0.18, 125, 210);
    local math_clamp_ret2 = math.clamp(ViewportSize.Y * 0.025, 16, 24);
    local v7 = v5 < (1 / 0) and (v3 + v4) * 0.5 or ViewportSize.X * 0.5;
    local v8 = v5 < (1 / 0) and v5 - 8 or ViewportSize.Y * 0.76;
    Frame.Size = UDim2.fromOffset(math_clamp_ret, math_clamp_ret2);
    Frame.Position = UDim2.fromOffset(math.clamp(v7, math_clamp_ret / 2 + 4, ViewportSize.X - math_clamp_ret / 2 - 4), (math.max(math_clamp_ret2 + 4, v8)));
end;

local u11 = BoostRequest.OnClientEvent:Connect(function(p9) -- Line: 66
    -- upvalues: TextLabel (copy), Sound (copy), u1 (ref), u2 (ref), place (copy), TweenService (copy), ScreenGui (copy)
    if p9 ~= "PerfectDodge" and p9 ~= "Trucked" then
        return;
    end;

    TextLabel.Text = p9 == "Trucked" and "TRUCKED!" or "PERFECT DODGE";
    TextLabel.TextColor3 = p9 == "Trucked" and Color3.fromRGB(255, 178, 96) or Color3.fromHex("FFCA3A");
    Sound:Stop();
    Sound:Play();
    u1 = u1 + 1;
    local u10 = u1;

    if u2 then
        u2:Cancel();
    end;

    place();
    TextLabel.Visible = true;
    TextLabel.Position = UDim2.fromScale(0, 0.3);
    TextLabel.TextTransparency = 1;
    TextLabel.TextStrokeTransparency = 1;
    u2 = TweenService:Create(TextLabel, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        TextStrokeTransparency = 0.3,
        Position = UDim2.fromScale(0, 0)
    });
    u2:Play();
    task.delay(0.85, function() -- Line: 91
        -- upvalues: u10 (copy), u1 (ref), ScreenGui (ref), u2 (ref), TweenService (ref), TextLabel (ref)
        if u10 ~= u1 or not ScreenGui.Parent then
            return;
        end;

        u2 = TweenService:Create(TextLabel, TweenInfo.new(0.22), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        });
        u2:Play();
        task.delay(0.22, function() -- Line: 97
            -- upvalues: u10 (ref), u1 (ref), TextLabel (ref)
            if u10 == u1 then
                TextLabel.Visible = false;
            end;
        end);
    end);
end);
local u12 = RunService.RenderStepped:Connect(function() -- Line: 104
    -- upvalues: TextLabel (copy), place (copy)
    if TextLabel.Visible then
        place();
    end;
end);
script.Destroying:Connect(function() -- Line: 109
    -- upvalues: u1 (ref), u11 (copy), u12 (copy), u2 (ref), ScreenGui (copy)
    u1 = u1 + 1;
    u11:Disconnect();
    u12:Disconnect();

    if u2 then
        u2:Cancel();
    end;

    ScreenGui:Destroy();
end);