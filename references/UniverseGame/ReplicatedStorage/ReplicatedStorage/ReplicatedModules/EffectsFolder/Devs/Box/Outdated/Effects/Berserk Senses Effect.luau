  

 

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(u2) -- Line: 5
    -- upvalues: u1 (copy), TweenService (copy), CollectionService (copy)
    local u3;

    if u2 then
        local _ = u2:FindFirstChild("HumanoidRootPart") or u2.PrimaryPart;
        u3 = u2:FindFirstChild("Humanoid");
    else
        u3 = nil;
    end;

    local u4 = u1["Gold Experience"].LifePunchEffect1:Clone();
    u4.Parent = game.Lighting;
    local v5 = u1["Gold Experience"].LifePunchEffect2:Clone();
    v5.Parent = game.Lighting;
    TweenService:Create(u4, TweenInfo.new(0.25), {
        Contrast = 1
    }):Play();
    TweenService:Create(v5, TweenInfo.new(0.25), {
        Saturation = -0.05
    }):Play();
    TweenService:Create(v5, TweenInfo.new(0.25), {
        Contrast = 1
    }):Play();
    task.wait(0.25);
    u4.Contrast = -0.3;
    TweenService:Create(u4, TweenInfo.new(0.25), {
        Contrast = 1
    }):Play();
    TweenService:Create(v5, TweenInfo.new(0.25), {
        Saturation = -0.5
    }):Play();
    task.wait(0.25);
    TweenService:Create(v5, TweenInfo.new(0.25), {
        Saturation = -0.3
    }):Play();
    TweenService:Create(u4, TweenInfo.new(0.5), {
        TintColor = Color3.fromRGB(54, 57, 127)
    }):Play();
    coroutine.wrap(function() -- Line: 36
        -- upvalues: CollectionService (ref), u2 (copy), u3 (ref), TweenService (ref), u4 (copy)
        repeat
            task.wait();
        until not CollectionService:HasTag(u2, "Life Punch") or (u3.Health <= 0 or u2:IsDescendantOf(workspace) ~= true);

        TweenService:Create(u4, TweenInfo.new(0.5), {
            Contrast = 0
        }):Play();
        TweenService:Create(u4, TweenInfo.new(0.5), {
            Saturation = 0
        }):Play();
        TweenService:Create(u4, TweenInfo.new(0.5), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.5);
        u4:Destroy();
    end)();
    task.wait(0.3);
    v5:Destroy();
end;