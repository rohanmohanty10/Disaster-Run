  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
local u1 = Random.new();
local u2 = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
local u3 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u4 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u5 = {};

for _, child in script:WaitForChild("Gradients"):GetChildren() do
    u5[child.Name] = {};
end;

script.Gradients.ChildAdded:Connect(function(p6) -- Line: 96
    -- upvalues: u5 (copy)
    u5[p6.Name] = {};
end);

return function(u7, p8, p9, p10, p11) -- Line: 100
    -- upvalues: LocalPlayer (copy), u5 (copy), u2 (copy), u1 (copy), u3 (copy), TweenService (copy), u4 (copy)
    if not LocalPlayer:FindFirstChild("Settings") then
        return;
    end;

    if not LocalPlayer.Settings.DamageIndicator.Value then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u12 = p9 or "Damage";

    if not (u7 and (u7:IsDescendantOf(workspace) and u7.PrimaryPart)) then
        return;
    end;

    u7:FindFirstChild("Humanoid");
    local v13 = u7:FindFirstChild("HumanoidRootPart") or (u7.PrimaryPart or u7:FindFirstChildWhichIsA("BasePart"));

    if p10 then
        v13 = u7:FindFirstChild(p10);
    end;

    if not u5[u12] then
        return;
    end;

    local v14 = u5[u12][u7];

    if not (v14 or v13) or (HumanoidRootPart.CFrame.Position - v13.CFrame.Position).Magnitude > 150 then
        return;
    end;

    local v15;

    if v14 then
        v15 = false;
    else
        v15 = true;
        local u16 = script.DamageIndicator:Clone();
        u16.Name = `{u12}Indicator`;
        u16.Enabled = true;
        u16.Adornee = workspace.Terrain;
        u16.Archivable = false;
        local v17 = script.Gradients:FindFirstChild(u12);

        if v17 then
            v17:Clone().Parent = u16.Label;
        end;

        u16.Parent = u7;
        v14 = {
            Value = 0,
            LastPart = nil,
            Indicator = u16,
            Tweens = {}
        };
        u5[u12][u7] = v14;
        task.spawn(function() -- Line: 158
            -- upvalues: u16 (copy), u5 (ref), u12 (copy), u7 (copy)
            while u16 and (u16:IsDescendantOf(workspace) and u16.Label.TextTransparency <= 0.99) do
                task.wait();
            end;

            if u16 then
                u16:Destroy();
            end;

            u5[u12][u7] = nil;
        end);
    end;

    v14.Value = v14.Value + p8;
    local Indicator = v14.Indicator;
    Indicator.Label.Text = p11 and p11.CustomText or nil or (v14.Value > 10000000000 and "Inf" or (v14.Value % 1 > 0 and string.format("%.2f", v14.Value) or math.floor(v14.Value)));
    Indicator.Label.TextTransparency = 0;
    Indicator.Label.TextStrokeTransparency = 0;

    for _, v in v14.Tweens do
        v:Cancel();
    end;

    table.clear(v14.Tweens);
    Indicator.Size = UDim2.new(15, 0, 2, 0);

    for _, v in {
        {
            Indicator,
            u2,
            {
                Size = UDim2.new(10, 0, 1.5, 0)
            }
        },
        {
            Indicator.Label,
            u2,
            {
                Rotation = u1:NextNumber(-8, 8)
            }
        },
        {
            Indicator.Label,
            u3,
            {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }
        },
        {
            Indicator,
            u3,
            {
                StudsOffset = Vector3.new(0, 3, 0)
            }
        }
    } do
        local v18 = TweenService:Create(table.unpack(v));
        table.insert(v14.Tweens, v18);
        v18:Play();
    end;

    local v19 = v13 or v14.LastPart;

    if v15 then
        local Position = v19.CFrame.Position;
        local v20 = u1:NextNumber(-1, 1);
        local v21 = u1:NextNumber(-1, 1);
        Indicator.StudsOffsetWorldSpace = Position + Vector3.new(v20, v21, u1:NextNumber(-1, 1));
    else
        if v14.MoveTween then
            v14.MoveTween:Pause();
        end;

        local v22 = {};
        local Position = v19.CFrame.Position;
        local v23 = u1:NextNumber(-1, 1);
        local v24 = u1:NextNumber(-1, 1);
        v22.StudsOffsetWorldSpace = Position + Vector3.new(v23, v24, u1:NextNumber(-1, 1));
        local v25 = TweenService:Create(Indicator, u4, v22);
        table.insert(v14.Tweens, v25);
        v25:Play();
        v14.MoveTween = v25;
    end;

    v14.LastPart = v19;
end;