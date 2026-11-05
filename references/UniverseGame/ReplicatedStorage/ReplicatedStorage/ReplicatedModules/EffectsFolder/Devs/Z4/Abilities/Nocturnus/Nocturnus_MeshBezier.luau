  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage2:FindFirstChild("Client Assets");
local u1 = Random.new();

return function(p2) -- Line: 16
    -- upvalues: u1 (copy), TweenService (copy)
    local u3 = p2 or {};
    local Origin = u3.Origin;
    local v4 = u3.Amount or 3;
    local u5 = u3.Offset or CFrame.identity;
    local v6 = u3.Delay or 0;
    local u7 = u3.BothSides or false;
    local v8 = u3.Colors or {};
    local u9 = v8[1] or Color3.fromRGB(0, 0, 0);
    local u10 = v8[2] or Color3.fromRGB(145, 0, 2);

    if not Origin then
        return;
    end;

    for i = 1, v4 do
        task.spawn(function() -- Line: 33
            -- upvalues: u3 (ref), u1 (ref), u7 (copy), i (copy), u9 (copy), u10 (copy), TweenService (ref), Origin (copy), u5 (copy)
            local v11 = u3.Height or math.random(200, 500) / 1000;
            local v12 = u3.Degree or math.random(100, 200) / 10;

            if typeof(v12) == "Vector2" then
                v12 = u1:NextNumber(v12.X, v12.Y);
            end;

            local v13 = v12 * (u7 and (math.random(1, 2) == 1 and -1 or 1) or 1);
            local v14 = u3.Radius or 5;
            local v15 = u3.Duration or 0.45;
            local v16 = os.clock();
            local v17 = math.random(-360, 360);
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.Material = Enum.Material.Neon;
            Part.Color = i % 2 ~= 0 and u9 or u10;
            Part.Transparency = 0;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.Massless = true;
            Part.Parent = workspace.Effects;
            task.delay(v15 + 1, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(v15, Enum.EasingStyle.Cubic), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            local v18 = 0;

            while Part:IsDescendantOf(game) and os.clock() - v16 <= v15 do
                local v19 = typeof(Origin) == "Vector3" and CFrame.new(Origin) or Origin;

                if typeof(v19) == "Instance" then
                    v19 = v19.CFrame;
                end;

                local new = CFrame.new;
                local v20 = math.rad(v17);
                local v21 = math.cos(v20) * v14;
                local v22 = math.rad(v17);
                local v23 = v19 * u5 * new(v21, v18, -math.sin(v22) * v14);
                local Angles = CFrame.Angles;
                local v24 = u1:NextNumber(180, -180);
                local v25 = math.rad(v24);
                local v26 = u1:NextNumber(180, -180);
                local v27 = math.rad(v26);
                local v28 = u1:NextNumber(180, -180);
                Part.CFrame = v23 * Angles(v25, v27, (math.rad(v28)));
                local v29 = task.wait() * 60;
                v17 = v17 + v13 * v29;
                v18 = v18 + v11 * v29;
            end;
        end);
        task.wait(v6);
    end;
end;