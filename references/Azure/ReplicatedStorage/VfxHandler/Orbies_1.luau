 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(u1) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), Debris (copy), TweenService (copy)
    local v2 = u1.Sphere or false;

    if u1.Circle or false then
        coroutine.wrap(function() -- Line: 10
            -- upvalues: u1 (copy), ReplicatedStorage (ref), Debris (ref), TweenService (ref)
            for i = 1, u1.Amount do
                local v3 = ReplicatedStorage.Assets.Effects.Meshes.HitPart2:Clone();
                v3.Rotation = u1.Rotation or v3.Rotation;
                v3.Color = u1.Color or Color3.fromRGB(255, 255, 255);
                v3.Transparency = 0.25;
                v3.Material = u1.Material or Enum.Material.Neon;
                v3.Size = u1.Size or Vector3.new(0.3, 0.3, 2);
                local CFrame_new = CFrame.new;
                local Position = u1.Parent.Position;
                local math_random_ret = math.random(-1, 1);
                local math_random_ret2 = math.random(-1, 1);
                v3.CFrame = CFrame_new(Position + Vector3.new(math_random_ret, math_random_ret2, math.random(-1, 1)), u1.Parent.Position);
                v3.Parent = workspace.Effects;
                Debris:AddItem(v3, u1.Speed);
                v3.Color = i >= 5 and u1.Type == "Yes" and Color3.fromRGB(255, 96, 33) or (u1.Color or Color3.fromRGB(255, 255, 255));
                local v4 = TweenService:Create(v3, TweenInfo.new(u1.Speed or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                    CFrame = v3.CFrame * u1.Cframe or CFrame.new(0, 0, 5),
                    Size = v3.Size + Vector3.new(0, 0, math.random(1.8, 3.5))
                });
                v4:Play();
                v4:Destroy();
                local v5 = TweenService:Create(v3, TweenInfo.new(u1.Speed or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false), {
                    Size = Vector3.new(0, 0, 0.8),
                    Transparency = 1
                });
                v5:Play();
                v5:Destroy();
                local _ = i;
            end;
        end)();
    end;

    if v2 then
        coroutine.wrap(function() -- Line: 40
            -- upvalues: u1 (copy), ReplicatedStorage (ref), Debris (ref), TweenService (ref)
            for i = 1, u1.Amount do
                local v6 = ReplicatedStorage.Assets.Effects.Meshes.HitPart1:Clone();
                v6.Rotation = u1.Rotation or v6.Rotation;
                v6.Color = u1.Color or Color3.fromRGB(255, 255, 255);
                v6.Transparency = 0.25;
                v6.Size = u1.Size or Vector3.new(0.2, 0.3, 3.79);
                local CFrame_new = CFrame.new;
                local Position = u1.Parent.Position;
                local math_random_ret = math.random(-1, 1);
                local math_random_ret2 = math.random(-1, 1);
                v6.CFrame = CFrame_new(Position + Vector3.new(math_random_ret, math_random_ret2, math.random(-1, 1)), u1.Parent.Position);
                v6.Parent = workspace.Effects;
                Debris:AddItem(v6, u1.Speed);
                local v7 = TweenService:Create(v6, TweenInfo.new(u1.Speed or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                    CFrame = v6.CFrame * u1.Cframe or CFrame.new(0, 0, 5),
                    Size = v6.Size + Vector3.new(0, 0, math.random(1.8, 3.5))
                });
                v7:Play();
                v7:Destroy();
                local v8 = TweenService:Create(v6, TweenInfo.new(u1.Speed or 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false), {
                    Size = Vector3.new(0, 0, 0.8),
                    Transparency = 1
                });
                v8:Play();
                v8:Destroy();
                local _ = i;
            end;
        end)();
    end;
end;