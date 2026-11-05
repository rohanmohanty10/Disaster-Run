  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(p1, p2) -- Line: 4
    -- upvalues: TweenService (copy), Debris (copy)
    local v3 = game.ReplicatedStorage["Client Assets"].Omnitrix.FireballHit:Clone();
    v3.Parent = workspace.Effects;
    v3:SetPrimaryPartCFrame(p1.HumanoidRootPart.CFrame * CFrame.Angles(4.71238898038469, 0, 0));

    for _, child in pairs(v3:GetChildren()) do
        if child.Name == "Shock" then
            local v4 = math.random(1, 10) / 2;
            local v5 = TweenInfo.new(0.5, Enum.EasingStyle.Quint);
            local v6 = {
                Transparency = 1
            };
            local v7 = math.random(5, 15) / 2;
            v6.Size = Vector3.new(v4, v7, v4);
            local v8 = child.CFrame * CFrame.new(0, 1, 0);
            local Angles = CFrame.Angles;
            local v9 = math.random(0, 360);
            v6.CFrame = v8 * Angles(0, math.rad(v9), 0);
            TweenService:Create(child, v5, v6):Play();
        elseif child.Name == "Wind" then
            local v10 = math.random(10, 20) / 2;
            local v11 = TweenInfo.new(0.5, Enum.EasingStyle.Quint);
            local v12 = {
                Transparency = 1,
                Size = Vector3.new(v10, child.Size.Y, v10)
            };
            local CFrame2 = child.CFrame;
            local Angles = CFrame.Angles;
            local v13 = math.random(0, 360);
            local v14 = math.rad(v13);
            local v15 = math.random(0, 360);
            local v16 = math.rad(v15);
            local v17 = math.random(0, 360);
            v12.CFrame = CFrame2 * Angles(v14, v16, (math.rad(v17)));
            TweenService:Create(child, v11, v12):Play();
        end;
    end;

    Debris:AddItem(v3, 0.6);
end;