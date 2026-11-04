  

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Component.new({
    Tag = "GradientOffset"
});
local TweenInfo_new_ret = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.3);

function v1.Construct(p2) -- Line: 14
    -- upvalues: Trove (copy)
    p2.Trove = Trove.new();
end;

function v1.Stop(p3) -- Line: 18
    p3.Trove:Destroy();
end;

function v1.Start(u4) -- Line: 22
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    u4.Trove:Destroy();
    local u5 = TweenService:Create(u4.Instance, TweenInfo_new_ret, {
        Offset = Vector2.new(1.25, 0)
    });
    local u6 = TweenService:Create(u4.Instance, TweenInfo_new_ret2, {
        Offset = Vector2.new(-1.23, 0)
    });
    u4.Trove:Add(u6.Completed:Connect(function() -- Line: 36
        -- upvalues: u5 (ref)
        u5:Play();
    end));
    u4.Trove:Add(u5.Completed:Connect(function() -- Line: 40
        -- upvalues: u4 (copy), u6 (ref)
        u4.Instance.Offset = Vector2.new(-1.25, 0);
        u6:Play();
    end));
    u4.Trove:Add(function() -- Line: 45
        -- upvalues: u5 (ref), u6 (ref)
        u5:Cancel();
        u5:Destroy();
        u5 = nil;
        u6:Cancel();
        u6:Destroy();
        u6 = nil;
    end);
    u5:Play();
end;

function v1.HeartbeatUpdate(p7, p8) -- Line: 58
end;

function v1.RenderSteppedUpdate(p9, p10) -- Line: 61
end;

return v1;