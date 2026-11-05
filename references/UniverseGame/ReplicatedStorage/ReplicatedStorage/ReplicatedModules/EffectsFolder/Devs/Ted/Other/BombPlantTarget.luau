  

 

local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local LocalPlayer = game.Players.LocalPlayer;
require(PathShortcuts.ReplicatedModules.Independent.TagService);

return function(p1, p2, u3) -- Line: 6
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    local u4 = 1;
    local Head = p1:FindFirstChild("Head");

    if not Head then
        return;
    end;

    local BillboardGui = Instance.new("BillboardGui", LocalPlayer.PlayerGui);
    local ImageLabel = Instance.new("ImageLabel", BillboardGui);
    BillboardGui.Adornee = Head;
    BillboardGui.Size = UDim2.new(4 / u4, 0, 4.2 / u4, 0);
    BillboardGui.StudsOffset = Vector3.new(0, 4.5, 0);
    BillboardGui.AlwaysOnTop = true;
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://6566851937";
    local u5 = BillboardGui:Clone();
    u5.Parent = LocalPlayer.PlayerGui;
    local v6 = TweenService:Create(u5, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(8 / u4, 0, 8.4 / u4, 0)
    });
    v6:Play();
    v6.Completed:Connect(function() -- Line: 29
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
    TweenService:Create(u5.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    local Highlight = Instance.new("Highlight", Head.Parent);
    Highlight.FillColor = Color3.new(1, 0, 0);
    Highlight.OutlineColor = Highlight.FillColor;
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 0;
    TweenService:Create(Highlight, TweenInfo.new(0.5), {
        FillTransparency = 0.5,
        OutlineTransparency = 0.5
    }):Play();
    task.spawn(function() -- Line: 43
        -- upvalues: BillboardGui (copy), ImageLabel (copy), u4 (ref)
        while BillboardGui do
            local new = UDim2.new;
            local v7 = tick();
            ImageLabel.Position = new(0, 0, math.sin(v7) / 10 / u4, 0);
            task.wait();
        end;
    end);

    local function CheckTagged(p8, p9) -- Line: 50
        -- upvalues: u3 (copy)
        local Humanoid = p8:FindFirstChild("Humanoid");

        if Humanoid then
            if p8.Humanoid.Health > 0 then
                Humanoid = p8:GetAttribute("KQ_BombTarget" .. u3.Name);
            else
                Humanoid = false;
            end;
        end;

        return Humanoid;
    end;

    while true do
        task.wait(0.1);

        if not p1:IsDescendantOf(game) then
            break;
        end;

        local Humanoid = p1:FindFirstChild("Humanoid");

        if Humanoid then
            if p1.Humanoid.Health > 0 then
                Humanoid = p1:GetAttribute("KQ_BombTarget" .. u3.Name);
            else
                Humanoid = false;
            end;
        end;

        if not (Humanoid and u3:IsDescendantOf(game)) then
            break;
        end;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.5), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(1, Highlight.Destroy, Highlight);
    BillboardGui:Destroy();
end;