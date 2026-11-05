  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];

return function(p2, p3) -- Line: 5
    -- upvalues: u1 (copy), TweenService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local Humanoid = p2:FindFirstChild("Humanoid");

    if not (HumanoidRootPart and Humanoid) then
        return;
    end;

    local FNFArrows = p2:FindFirstChild("FNFArrows");

    if not p3 then
        if FNFArrows then
            FNFArrows:Destroy();
        end;

        return;
    end;

    if FNFArrows then
        return;
    end;

    local v4 = u1.Emotes.FNFArrows:Clone();
    v4.Parent = p2;
    v4:SetPrimaryPartCFrame(HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, 5, -1));
    local v5 = { "Down", "Left", "Right", "Up" };

    while v4.Parent == p2 and (p2:IsDescendantOf(workspace) and (Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and (p2 and p2.Parent))) do
        local u6 = v4:FindFirstChild(v5[math.random(1, #v5)]):Clone();
        u6.Parent = workspace.Effects;
        u6.Size = u6.Size + Vector3.new(0.1, 0.1, 0.1);
        u6.Color = u6.ColorValue.Value;
        u6.Position = u6.Position - Vector3.new(0, 5, 0);
        TweenService:Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Position = u6.Position + Vector3.new(0, 5, 0)
        }):Play();
        task.delay(0.25, function() -- Line: 56
            -- upvalues: u6 (copy), TweenService (ref)
            u6.Material = Enum.Material.Neon;
            TweenService:Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = u6.Size + Vector3.new(0.1, 2, 2)
            }):Play();
            task.wait(0.25);
            u6:Destroy();
        end);
        task.wait(0.1);
    end;
end;