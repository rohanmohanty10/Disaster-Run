  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 5
    -- upvalues: TweenService (copy), u1 (copy)
    if not p2 then
        local u3 = workspace.Effects:FindFirstChild(game.Players.LocalPlayer.Name .. "BlizzardShaperSnow");

        if u3 then
            for _, child in pairs(u3:GetChildren()) do
                child.Enabled = false;
            end;

            task.delay(2, function() -- Line: 33
                -- upvalues: u3 (copy)
                u3:Destroy();
            end);
        end;

        for _, child in pairs(game.Lighting:GetChildren()) do
            if child.Name == "BLIZZARD_SHAPER_COLOR_CORRECTION_POSE" then
                TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Saturation = 0,
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                game.Debris:AddItem(child, 1);
            end;
        end;

        return;
    end;

    local LocalPlayer = game.Players.LocalPlayer;
    local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "BLIZZARD_SHAPER_COLOR_CORRECTION_POSE";
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Saturation = -0.1,
        TintColor = Color3.new(0.596078, 0.756863, 1)
    }):Play();
    local v4 = u1["P//S_R"].BlizzardShaperSnow:Clone();
    v4.CFrame = HumanoidRootPart.CFrame;
    v4.Anchored = false;
    v4.Name = LocalPlayer.Name .. "BlizzardShaperSnow";
    v4.Parent = workspace.Effects;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
end;