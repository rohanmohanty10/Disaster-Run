  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(u1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local v2 = ReplicatedStorage.Assets.GoalEffects["Monster Army"];
    local u3 = v2.GoalEffect:Clone();
    local v4 = v2["Monster FullBody"]:Clone();
    local u5 = v2["Monster Ghost"];
    v4.Parent = workspace.Debris;
    u3.Parent = workspace.Debris;
    VfxManager.Enable(u3, false);
    u3:PivotTo(u1.Pos * CFrame.new(0, 5, 0));
    local v6 = v4.AnimationController:LoadAnimation(v4.Animation);
    v6.Looped = false;
    v6:Play();
    v6:AdjustSpeed(0.5);

    while v6.Length == 0 do
        task.wait();
    end;

    local u7 = v6.Length * 2 - 0.25;

    for i = 1, 24 do
        task.spawn(function() -- Line: 32
            -- upvalues: i (copy), u5 (copy), VfxManager (ref), u1 (copy), TweenService (ref), u7 (copy)
            local v8 = u5:Clone();
            local v9 = {};

            for _, child in v8:GetChildren() do
                if child:IsA("BasePart") then
                    v9[child] = child.Transparency;
                    child.Transparency = 1;
                end;
            end;

            v8.Parent = workspace.Debris;
            VfxManager.Enable(v8, false);
            local v10 = v8.AnimationController:LoadAnimation(v8.Animation);
            v10.Looped = true;
            v10:Play();

            while v10.Length == 0 do
                task.wait();
            end;

            local v11 = u1.Pos * CFrame.new(0, math.random(8, 40), (i - 10) * 18) * CFrame.Angles(0, -1.5707963267948966, 0);
            v8:PivotTo(v11);
            local v12 = v11 * CFrame.new(0, 0, -400);
            local TweenInfo_new_ret = TweenInfo.new(7, Enum.EasingStyle.Linear);
            local v13 = TweenService:Create(v8.PrimaryPart, TweenInfo_new_ret, {
                CFrame = v12
            });

            for _, child in v8:GetChildren() do
                if child:IsA("BasePart") then
                    TweenService:Create(child, TweenInfo.new(0.3), {
                        Transparency = v9[child]
                    }):Play();
                end;
            end;

            VfxManager.Enable(v8, true);
            v13:Play();
            task.wait(u7);
            v8:Destroy();
        end);
        local _ = i;
    end;

    task.wait(0.2);
    v4.RootPart.Sound:Play();
    v4.RootPart.Sound1:Play();
    v4:PivotTo(u1.Pos * CFrame.new(5, -4.8, 0) * CFrame.Angles(0, -1.5707963267948966, 0));
    VfxManager.Enable(u3, true);
    task.delay(2.5, function() -- Line: 79
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, false);
        task.delay(0.3, function() -- Line: 81
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
    end);
    task.wait(v6.Length * 2 - 0.25);
    v4:Destroy();
end;