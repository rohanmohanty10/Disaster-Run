  

 

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
    local u4 = u3.Offset or CFrame.identity;
    local v5 = u3.Delay or 0;
    local u6 = u3.BothSides or false;

    if not Origin then
        return;
    end;

    for _ = 1, u3.Amount or 3 do
        task.spawn(function() -- Line: 30
            -- upvalues: u3 (ref), u1 (ref), u6 (copy), TweenService (ref), Origin (copy), u4 (copy)
            local v7 = u3.Height or math.random(200, 500) / 1000;
            local v8 = u3.Degree or math.random(100, 200) / 10;

            if typeof(v8) == "Vector2" then
                v8 = u1:NextNumber(v8.X, v8.Y);
            end;

            local v9 = v8 * (u6 and (math.random(1, 2) == 1 and -1 or 1) or 1);
            local v10 = u3.Radius or 5;
            local v11 = u3.Duration or 0.45;
            local v12 = os.clock();
            local v13 = math.random(-360, 360);
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3.fromRGB(0, 0, 0);
            Part.Transparency = 0;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.Massless = true;
            Part.Parent = workspace.Effects;
            task.delay(v11 + 1, Part.Destroy, Part);
            TweenService:Create(Part, TweenInfo.new(v11, Enum.EasingStyle.Cubic), {
                Size = Vector3.new(0, 0, 0),
                Color = Color3.fromRGB(138, 243, 1)
            }):Play();
            local v14 = 0;

            while Part:IsDescendantOf(game) and os.clock() - v12 <= v11 do
                local v15 = typeof(Origin) == "Vector3" and CFrame.new(Origin) or Origin;

                if typeof(v15) == "Instance" then
                    v15 = v15.CFrame;
                end;

                local new = CFrame.new;
                local v16 = math.rad(v13);
                local v17 = math.cos(v16) * v10;
                local v18 = math.rad(v13);
                local v19 = v15 * u4 * new(v17, v14, -math.sin(v18) * v10);
                local Angles = CFrame.Angles;
                local v20 = u1:NextNumber(180, -180);
                local v21 = math.rad(v20);
                local v22 = u1:NextNumber(180, -180);
                local v23 = math.rad(v22);
                local v24 = u1:NextNumber(180, -180);
                Part.CFrame = v19 * Angles(v21, v23, (math.rad(v24)));
                local v25 = task.wait() * 60;
                v13 = v13 + v9 * v25;
                v14 = v14 + v7 * v25;
            end;
        end);
        task.wait(v5);
    end;
end;