  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local v2 = p1.Part or error("No origin part");
    local v3 = p1.StartDuration or 0.5;
    local v4 = p1.LifeTime or 0.4;
    local u5 = p1.EndDuration or 0.1;
    local v6 = p1.Distance or 30;
    local v7 = p1.Color or Color3.new(1, 0, 0);
    local v8 = p1.Offset or CFrame.new(0, -2.999, -3);
    local v9 = p1.Width or 8;
    local u10 = script.FloorIndicator:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = v2;
    Weld.Part1 = u10;
    Weld.C0 = v8;
    Weld.Parent = u10;
    local Beams = u10.Beams;
    local Indicator = u10.Indicator;
    local End = u10.End;
    End.Position = Vector3.new(0, 0, 0);

    for _, child in Beams:GetChildren() do
        child.Color = ColorSequence.new(v7);
    end;

    Beams.Centre.Width0 = v9;
    Beams.Centre.Width1 = v9;
    Indicator.Left.CFrame = CFrame.new(0, v9 / 2 - 0.25, 0);
    Indicator.Right.CFrame = CFrame.new(0, -(v9 / 2) + 0.25, 0);
    End.Left.CFrame = CFrame.new(0, v9 / 2 - 0.25, 0);
    End.Right.CFrame = CFrame.new(0, -(v9 / 2) + 0.25, 0);
    u10.Parent = workspace.Effects;
    TweenService:Create(End, TweenInfo.new(v3, Enum.EasingStyle.Linear), {
        Position = vector.create(0, 0, -v6)
    }):Play();
    task.delay(v3 + v4, function() -- Line: 47
        -- upvalues: Indicator (copy), End (copy), TweenService (ref), u5 (copy), Beams (copy), u10 (copy)
        for _, v in { Indicator, End } do
            for _, child in v:GetChildren() do
                TweenService:Create(child, TweenInfo.new(u5, Enum.EasingStyle.Sine), {
                    Position = Vector3.new(0, 0, 0)
                }):Play();
            end;
        end;

        for _, child in Beams:GetChildren() do
            TweenService:Create(child, TweenInfo.new(u5, Enum.EasingStyle.Sine), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;

        task.wait(u5);
        u10:Destroy();
    end);
end;