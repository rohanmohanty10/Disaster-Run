 

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Events = ChickenOrHero:WaitForChild("Audio"):WaitForChild("Events");
local VerifiedName = require(ChickenOrHero.Presentation:WaitForChild("VerifiedName"));
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "CatchConfirmation";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 28;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local CanvasGroup = Instance.new("CanvasGroup");
CanvasGroup.Name = "Confirmed";
CanvasGroup.BackgroundTransparency = 1;
CanvasGroup.AnchorPoint = Vector2.new(0.5, 0.5);
CanvasGroup.Position = UDim2.fromScale(0.5, 0.46);
CanvasGroup.Size = UDim2.fromScale(0.45, 0.2);
CanvasGroup.Visible = false;
CanvasGroup.Parent = ScreenGui;
local Frame = Instance.new("Frame");
Frame.BackgroundTransparency = 1;
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.Position = UDim2.fromScale(0.5, 0.5);
Frame.Size = UDim2.fromOffset(38, 38);
Frame.Parent = CanvasGroup;

for _, v in { { -1, -1 }, { 1, -1 }, { -1, 1 }, { 1, 1 } } do
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;
    Frame2.BackgroundColor3 = Color3.fromRGB(255, 247, 220);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Size = UDim2.fromOffset(11, 3);
    Frame2.Position = UDim2.new(0.5, v[1] * 11, 0.5, v[2] * 11);
    Frame2.Rotation = v[1] * v[2] * 45;
    Frame2.Parent = Frame;
end;

local TextLabel = Instance.new("TextLabel");
TextLabel.BackgroundTransparency = 1;
TextLabel.Size = UDim2.fromScale(1, 0.28);
TextLabel.Position = UDim2.fromScale(0, 0.72);
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.TextColor3 = Color3.fromRGB(255, 247, 220);
TextLabel.TextStrokeTransparency = 0.4;
TextLabel.TextScaled = true;
TextLabel.Parent = CanvasGroup;
local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
UITextSizeConstraint.MinTextSize = 12;
UITextSizeConstraint.MaxTextSize = 20;
UITextSizeConstraint.Parent = TextLabel;
local u1 = 0;
local u2 = nil;
Events.OnClientEvent:Connect(function(p3, p4) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), TextLabel (copy), VerifiedName (copy), CanvasGroup (copy), Frame (copy), TweenService (copy)
    if p3 ~= "CatchConfirmed" or (type(p4) ~= "table" or p4.catcher ~= LocalPlayer.UserId) then
        return;
    end;

    u1 = u1 + 1;
    local u5 = u1;

    if u2 then
        u2:Cancel();
    end;

    TextLabel.RichText = true;
    TextLabel.Text = "CAUGHT · " .. VerifiedName.format(p4.name or "Runner", p4.verified, p4.runner);
    CanvasGroup.Visible = true;
    CanvasGroup.GroupTransparency = 0;
    Frame.Size = UDim2.fromOffset(48, 48);
    TweenService:Create(Frame, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(38, 38)
    }):Play();
    task.delay(0.6, function() -- Line: 32
        -- upvalues: u1 (ref), u5 (copy), u2 (ref), TweenService (ref), CanvasGroup (ref)
        if u1 ~= u5 then
            return;
        end;

        u2 = TweenService:Create(CanvasGroup, TweenInfo.new(0.25), {
            GroupTransparency = 1
        });
        u2:Play();
        u2.Completed:Once(function() -- Line: 35
            -- upvalues: u1 (ref), u5 (ref), CanvasGroup (ref)
            if u1 == u5 then
                CanvasGroup.Visible = false;
            end;
        end);
    end);
end);