  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 5
    -- upvalues: TweenService (copy)
    if not p1 then
        for _, child in pairs(game.Lighting:GetChildren()) do
            if child.Name == "OCEAN_SAILOR_POSE" then
                TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Saturation = 0,
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                game.Debris:AddItem(child, 1);
            end;
        end;

        return;
    end;

    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "OCEAN_SAILOR_POSE";
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Saturation = 0.1,
        TintColor = Color3.new(1, 0.741176, 0.654902)
    }):Play();
end;