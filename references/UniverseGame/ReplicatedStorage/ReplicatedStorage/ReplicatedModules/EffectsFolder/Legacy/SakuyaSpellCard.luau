  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 2
    -- upvalues: TweenService (copy)
    local v3 = game.ReplicatedStorage["Client Assets"].Sakuya.SpellCard:Clone();
    v3.Parent = game.Players.LocalPlayer.PlayerGui;
    v3.s:Play();

    for _, child in pairs(p1:GetChildren()) do
        if v3.ViewportFrame.NeedAGate:FindFirstChild(child.Name) and child:IsA("BasePart") then
            v3.ViewportFrame.NeedAGate:FindFirstChild(child.Name).Color = child.Color;
        end;

        if (child:IsA("Accessory") or (child:IsA("Shirt") or (child:IsA("Pants") or child:IsA("ShirtGraphic")))) and (child.Name ~= "SakuyaKnives" and child.Name ~= "SakuyaWatch") then
            local v4 = child:Clone();
            v4.Parent = v3.ViewportFrame.NeedAGate;

            if v4:IsA("Accessory") then
                local v5 = v4.Handle:FindFirstChildOfClass("Attachment");
                v4.Handle.CFrame = v3.ViewportFrame.NeedAGate:FindFirstChild(v5.Name, true).WorldCFrame * v5.CFrame:Inverse();
            end;
        end;
    end;

    v3.ViewportFrame.Position = UDim2.new(1, 0, 0.25, 0);
    v3.ViewportFrame.ImageTransparency = 1;
    v3.Frame.TextLabel.Text = p2;
    v3.Frame.TextLabel.TextTransparency = 1;
    v3.Frame.Size = UDim2.new(1, 0, 0, 72);
    v3.Frame.Position = UDim2.new(0, 0, 0.65, -24);
    TweenService:Create(v3.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 0.35,
        Position = UDim2.new(0.5, 0, 0.65, 0),
        Size = UDim2.new(0.35, 0, 0, 24)
    }):Play();
    TweenService:Create(v3.ViewportFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        ImageTransparency = 0,
        Position = UDim2.new(0.725, 0, 0.25, 0)
    }):Play();
    wait(0.5);
    v3.Frame.TextLabel.TextTransparency = 0;
    wait(1.5);
    v3.Frame.TextLabel.TextTransparency = 1;
    TweenService:Create(v3.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(v3.ViewportFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        ImageTransparency = 1,
        Position = UDim2.new(-0.15, 0, 0.25, 0)
    }):Play();
    wait(5);
    v3:Destroy();
end;