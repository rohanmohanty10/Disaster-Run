  

 

local TweenService = game:GetService("TweenService");
local PlayerGui = game.Players.LocalPlayer.PlayerGui;

return function(p1) -- Line: 4
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
    TextLabel.TextStrokeTransparency = 0;
    local v2 = { { 0, "face" }, { 0.75, "talk1", "Ironic, isn\'t it?" }, { 0.85, "talk2" }, { 0.95, "talk1" }, { 1.05, "talk2" }, { 1.1, "talk1" }, { 1.2, "face" }, { 1.25, "talk2" }, { 1.4, "talk1" }, { 1.8, "face", true }, { 2.4, "talk1", "When granted everything, ", "you can\'t do anything." }, { 2.5, "talk2" }, { 2.65, "face" }, { 2.7, "talk2" }, { 2.75, "talk1" }, { 3, "talk2" }, { 3.1, "talk1" }, { 3.15, "talk2" }, { 3.2, "talk1" }, { 3.25, "talk2" }, { 3.3, "face" }, { 3.35, "talk2" }, { 3.4, "talk1" }, { 3.45, "talk2" }, { 3.5, "face" }, { 3.55, "talk1" }, { 3.6, "talk2" }, { 3.65, "face" }, { 3.7, "talk2" }, { 4, "face" }, { 4.5, "talk1", "you can\'t do anything.", true }, { 4.55, "talk2" }, { 4.65, "talk1" }, { 4.7, "talk2" }, { 4.8, "face" }, { 4.85, "talk2" }, { 4.95, "face" }, { 5, "talk1" }, { 5.1, "face" }, { 5.15, "talk2" }, { 5.2, "talk1" }, { 5.3, "talk2" }, { 5.6, "face", true } };

    for i, v in pairs(v2) do
        if i > 1 then
            wait(v[1] - v2[i - 1][1]);
        end;

        if v[3] then
            if type(v[3]) == "boolean" then
                TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
            else
                TextLabel.MaxVisibleGraphemes = (not v[4] or type(v[4]) ~= "boolean") and 0 or TextLabel.MaxVisibleGraphemes;
                TextLabel.Text = not v[4] and v[3] or (type(v[4]) ~= "boolean" and v[3] .. v[4] or TextLabel.Text);
                TweenService:Create(TextLabel, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = (v[4] and type(v[4]) == "boolean" or not v[4]) and #TextLabel.Text or #v[3]
                }):Play();
                TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 0,
                    TextStrokeTransparency = 0
                }):Play();
            end;
        end;
    end;
end;