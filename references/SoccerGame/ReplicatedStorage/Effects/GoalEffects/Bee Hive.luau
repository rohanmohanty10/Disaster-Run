  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: ReplicatedStorage (copy), RunService (copy)
    local v2 = ReplicatedStorage.Assets.GoalEffects["Bee Hive"];
    local v3 = v2.Hive:Clone();
    local Bee = v2.Bee;
    local u4 = p1.Pos * CFrame.new(0, 5, 0);
    v3.Main.Main.Sound:Play();
    v3.Parent = workspace.Debris;
    v3:PivotTo(p1.Pos * CFrame.new(0, 5, 0));
    local u5 = {};

    for i = 1, 32 do
        task.spawn(function() -- Line: 21
            -- upvalues: Bee (copy), u5 (copy)
            local v6 = Bee:Clone();
            v6.Parent = workspace.Debris;
            u5[v6] = { math.random() + math.random(8, 18), math.random(240, 480), math.random(-8, 12) };
        end);
        local _ = i;
    end;

    local v14 = RunService.RenderStepped:Connect(function(p7) -- Line: 33
        -- upvalues: u5 (copy), u4 (copy)
        for i, v in pairs(u5) do
            local v8 = v[1];
            local v9 = v[2];
            local v10 = tick() * v9 % 360;
            local CFrame_new = CFrame.new;
            local math_rad_ret = math.rad(v10);
            local v11 = math.cos(math_rad_ret) * v8;
            local v12 = v[3];
            local math_rad_ret2 = math.rad(v10);
            local v13 = CFrame_new(v11, v12, math.sin(math_rad_ret2) * v8);
            i:PivotTo(CFrame.new(u4.Position + v13.Position, u4.Position) * CFrame.Angles(0, -1.5707963267948966, 0));
        end;
    end);
    task.wait(4);
    v14:Disconnect();
    v3:Destroy();

    for i, _ in u5 do
        i:Destroy();
    end;
end;