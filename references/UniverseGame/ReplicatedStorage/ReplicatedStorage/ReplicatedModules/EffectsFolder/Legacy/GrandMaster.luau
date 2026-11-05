  

 

local TweenService = game:GetService("TweenService");
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");

return function() -- Line: 4
    -- upvalues: PlayerGui (copy), TweenService (copy)
    local ScreenGui = Instance.new("ScreenGui", PlayerGui);
    ScreenGui.Name = "Subtitles";
    local TextLabel = Instance.new("TextLabel", ScreenGui);
    TextLabel.Size = UDim2.new(0.7, 0, 0.08, 0);
    TextLabel.Position = UDim2.new(0.5, 0, 0.9, 0);
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextTransparency = 1;
    TextLabel.TextScaled = true;
    TextLabel.Font = Enum.Font.RobotoMono;
    TextLabel.TextStrokeTransparency = 1;
    TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextStrokeTransparency = 0,
        TextTransparency = 0
    }):Play();

    for i = 1, 41 do
        TextLabel.Text = string.sub("You feel your soul has been strengthened.", 1, i);
        local Sound = Instance.new("Sound");
        Sound.Parent = workspace;
        Sound.SoundId = "rbxassetid://6564956178";
        Sound.Volume = 1;
        Sound.PlayOnRemove = true;
        Sound:Destroy();
        wait(0.04);
    end;

    wait(2);
    TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextStrokeTransparency = 1,
        TextTransparency = 1
    }):Play();
    wait(0.5);
    ScreenGui:Destroy();
    TextLabel:Destroy();
end;