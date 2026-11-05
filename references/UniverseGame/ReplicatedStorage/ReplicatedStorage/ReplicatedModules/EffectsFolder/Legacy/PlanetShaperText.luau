  

 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: Debris (copy), TweenService (copy)
    local v5 = game.ReplicatedStorage["Client Assets"].PS.Dialogue:Clone();

    if p4 then
        v5.bg.tl.TextColor3 = p4;
    end;

    v5.bg.tl.Text = p2;
    v5.CFrame = p1.CFrame;
    v5.Parent = workspace;

    if p3 then
        v5.Sound.SoundId = p3;
    end;

    v5.Sound:Play();
    Debris:AddItem(v5, 8);
    local v6 = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local v7 = {};
    local v8 = v5.CFrame + Vector3.new(0, 3, 0);
    local v9 = math.random(-10, 10) / 10;
    local v10 = math.random(-10, 10) / 10;
    local v11 = math.random(-10, 10) / 10;
    v7.CFrame = v8 + Vector3.new(v9, v10, v11);
    TweenService:Create(v5, v6, v7):Play();
    TweenService:Create(v5.bg, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(8.8, 0, 1.1, 0)
    }):Play();
    wait(6);
    TweenService:Create(v5, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        CFrame = v5.CFrame + Vector3.new(0, -16, 0)
    }):Play();
    TweenService:Create(v5.bg.tl, TweenInfo.new(2), {
        TextTransparency = 1
    }):Play();
end;