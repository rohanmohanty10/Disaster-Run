  

 

local TweenService = game:GetService("TweenService");

return {
    Air = function(p1) -- Line: 4, Name: Air
        -- upvalues: TweenService (copy)
        TweenService:Create(p1, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(10, 1, 10),
            CFrame = p1.CFrame * CFrame.new(0, -4, 0)
        }):Play();
        task.delay(0.25, p1.Destroy, p1);
    end,

    Shockwave = function(p2) -- Line: 14, Name: Shockwave
        -- upvalues: TweenService (copy)
        TweenService:Create(p2, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1,
            Size = Vector3.new(10, 10, 10),
            CFrame = p2.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(1.0471975511965976, 0, 0)
        }):Play();
        task.delay(0.35, p2.Destroy, p2);
    end,

    Swirl = function(p3) -- Line: 24, Name: Swirl
        -- upvalues: TweenService (copy)
        TweenService:Create(p3, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
            Transparency = 1,
            Size = Vector3.new(10, 2, 10),
            CFrame = p3.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
        task.delay(0.5, p3.Destroy, p3);
    end,

    BigSwirl = function(p4) -- Line: 34, Name: BigSwirl
        -- upvalues: TweenService (copy)
        TweenService:Create(p4, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = p4.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        }):Play();
        TweenService:Create(p4.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(p4.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.6, 0.4, 0.4)
        }):Play();
        task.delay(0.3, p4.Destroy, p4);
    end
};