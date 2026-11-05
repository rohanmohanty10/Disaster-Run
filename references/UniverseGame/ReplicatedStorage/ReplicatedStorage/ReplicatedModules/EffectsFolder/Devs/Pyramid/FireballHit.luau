  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

local function audio(p1, p2, p3, p4, p5) -- Line: 4
    local Sound = Instance.new("Sound", p5);
    Sound.SoundId = "rbxassetid://" .. p1;
    Sound.Volume = p2 or 0.5;
    Sound.TimePosition = p3 or 0;
    Sound.Looped = p4 or false;
    Sound.RollOffMaxDistance = 60;
    Sound.RollOffMinDistance = 5;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;

    return Sound;
end;

return function(p6, p7, p8) -- Line: 16
    -- upvalues: TweenService (copy), Debris (copy)
    local v9 = typeof(p6) == "Vector3" and p6 and p6 or p6.Torso.Position;
    local v10 = typeof(p7) == "Vector3" and -p7 or p7.Torso.Position;
    local v11 = game.ReplicatedStorage["Client Assets"].Omnitrix.FireballHit:Clone();
    v11.Parent = workspace.Effects;
    v11:SetPrimaryPartCFrame(CFrame.new(v9, v10) * CFrame.Angles(-1.5707963267948966, 0, 0));

    for _, child in pairs(v11:GetChildren()) do
        if child.Name == "Shock" then
            local v12 = math.random(1, 10) * 1;
            local v13 = TweenInfo.new(1, Enum.EasingStyle.Quint);
            local v14 = {
                Transparency = 1
            };
            local v15 = math.random(5, 15) * 1;
            v14.Size = Vector3.new(v12, v15, v12);
            local v16 = child.CFrame * CFrame.new(0, 2, 0);
            local Angles = CFrame.Angles;
            local v17 = math.random(0, 360);
            v14.CFrame = v16 * Angles(0, math.rad(v17), 0);
            TweenService:Create(child, v13, v14):Play();
        elseif child.Name == "Wind" then
            local v18 = math.random(10, 20) * 1;
            local v19 = TweenInfo.new(1, Enum.EasingStyle.Quint);
            local v20 = {
                Transparency = 1,
                Size = Vector3.new(v18, child.Size.Y, v18)
            };
            local CFrame2 = child.CFrame;
            local Angles = CFrame.Angles;
            local v21 = math.random(0, 360);
            local v22 = math.rad(v21);
            local v23 = math.random(0, 360);
            local v24 = math.rad(v23);
            local v25 = math.random(0, 360);
            v20.CFrame = CFrame2 * Angles(v22, v24, (math.rad(v25)));
            TweenService:Create(child, v19, v20):Play();
        end;
    end;

    Debris:AddItem(v11, 1.1);
    local v26 = game.ReplicatedStorage["Client Assets"].Projectiles[(p8 == nil or p8.ball ~= "small") and "Fireball" or "FireballSmol"]:Clone();
    v26:SetPrimaryPartCFrame(CFrame.new(v9, v10));
    v26.Parent = workspace.Effects;
    local v27 = (p8 == nil or p8.ball ~= "small") and 1 or 2;

    for _, child in pairs(v26:GetChildren()) do
        child.Anchored = true;

        if child ~= v26.PrimaryPart then
            local v28 = TweenInfo.new(0.5, Enum.EasingStyle.Quint);
            local v29 = {
                Transparency = 1,
                Size = child.Size + Vector3.new(10, 10, 10) / v27
            };
            local v30 = child.Orientation.X + math.random(0, 120);
            local v31 = child.Orientation.Y + math.random(0, 120);
            local v32 = child.Orientation.Z + math.random(0, 120);
            v29.Orientation = Vector3.new(v30, v31, v32);
            TweenService:Create(child, v28, v29):Play();
        end;
    end;

    Debris:AddItem(v26, 0.6);

    if typeof(p6) ~= "Vector3" then
        local Sound = Instance.new("Sound", p6.Torso);
        Sound.SoundId = "rbxassetid://" .. 6769947344;
        Sound.Volume = 1;
        Sound.TimePosition = 0;
        Sound.Looped = false;
        Sound.RollOffMaxDistance = 60;
        Sound.RollOffMinDistance = 5;
        Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
        Sound.Ended:Connect(function() -- Line: 50
            -- upvalues: Sound (copy)
            Sound:Destroy();
        end);
        Sound:Play();
    end;
end;