 

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(p1) -- Line: 6
    -- upvalues: TweenService (copy), Debris (copy)
    local v2 = p1.Pos or Vector3.new(0, 0, 0);
    local v3 = p1.Quantity or 20;
    local v4 = p1.Properties or {};
    local v5 = p1.Offsets or {
        X = { -10, 10 },
        Y = { 0, 10 },
        Z = { -10, 10 },
        Offset = { 10, 20 }
    };
    local v6 = p1.TweenInfo or TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local v7 = p1.Goal or {};

    for i = 1, v3 do
        local v8 = script.Orb:Clone();
        local _ = i;

        for i2, v in next, v4 do
            v8[i2] = v;
        end;

        local math_random_ret = math.random(v5.X[1], v5.X[2]);
        local math_random_ret2 = math.random(v5.Y[1], v5.Y[2]);
        local v9 = v2 + Vector3.new(math_random_ret, math_random_ret2, math.random(v5.Z[1], v5.Z[2]));
        v8.CFrame = CFrame.lookAt(v9, v9 - Vector3.new(0, 5, 0));
        v8.Parent = workspace.Effects;
        v7.CFrame = v8.CFrame * CFrame.new(0, 0, math.random(v5.Offset[1], v5.Offset[2]));
        local v10 = TweenService:Create(v8, v6, v7);
        v10:Play();
        v10:Destroy();
        Debris:AddItem(v8, 1);
    end;
end;