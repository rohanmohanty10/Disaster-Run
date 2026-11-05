  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("ranNum");

return function(u2) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), u1 (copy), TweenService (copy)
    for _ = 1, 10 do
        task.spawn(function() -- Line: 9
            -- upvalues: ReplicatedStorage (ref), u1 (ref), u2 (copy), TweenService (ref)
            local v3 = ReplicatedStorage["Client Assets"].Undertale.Bone:Clone();
            local v4 = u1(-10, 10);
            local v5 = u1(-1, 1);
            local v6 = u1(-10, 10);
            local v7 = u1(70, 110);
            local v8 = math.rad(v7);
            local v9 = u1(-10, 10);
            local v10 = math.rad(v9);
            local v11 = u1(-10, 10);
            local v12 = math.rad(v11);
            v3.CFrame = CFrame.new(u2 + Vector3.new(v4, v5, v6)) * CFrame.Angles(v8, v10, v12);
            v3.Size = Vector3.new(0.25, 0.5, 3.5);
            v3.Transparency = 1;
            v3.Parent = workspace.Effects;
            game.Debris:AddItem(v3, 1.5);
            local v13 = v3.Size * u1(20, 30) / 10;
            TweenService:Create(v3, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                Transparency = 0,
                Size = v13,
                Position = v3.Position + v3.CFrame.lookVector * 2
            }):Play();
            wait(1);
            TweenService:Create(v3, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                Transparency = 1,
                Size = v13 / 10,
                Position = v3.Position - v3.CFrame.lookVector * 3
            }):Play();
        end);
    end;
end;