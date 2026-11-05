  

 

local TweenService = game:GetService("TweenService");

return {
    Circle = function(p1) -- Line: 4, Name: Circle
        -- upvalues: TweenService (copy)
        TweenService:Create(p1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(14, 0.5, 14),
            CFrame = p1.CFrame * CFrame.new(0, 5, 0)
        }):Play();
        task.delay(0.75, p1.Destroy, p1);
    end,

    Swirl = function(p2) -- Line: 14, Name: Swirl
        -- upvalues: TweenService (copy)
        TweenService:Create(p2, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(20, 0.5, 20),
            CFrame = p2.CFrame * CFrame.new(0, -6, 0) * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
        task.delay(0.75, p2.Destroy, p2);
    end,

    Tube = function(p3) -- Line: 24, Name: Tube
        -- upvalues: TweenService (copy)
        TweenService:Create(p3, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = p3.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
        TweenService:Create(p3.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(p3.Mesh, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.02, 0.005, 0.02)
        }):Play();
        task.delay(0.75, p3.Destroy, p3);
    end,

    Cone = function(p4) -- Line: 39, Name: Cone
        -- upvalues: TweenService (copy)
        TweenService:Create(p4, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            CFrame = p4.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        }):Play();
        TweenService:Create(p4.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(p4.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.1, 0.4, 0.4)
        }):Play();
        task.delay(1, p4.Destroy, p4);
    end,

    BigWind = function(p5) -- Line: 55, Name: BigWind
        -- upvalues: TweenService (copy)
        TweenService:Create(p5, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = p5.CFrame * CFrame.new(0, 0, -2)
        }):Play();
        TweenService:Create(p5.Decal, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(p5.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.8, 0.8, 0.3)
        }):Play();
        task.delay(0.8, p5.Destroy, p5);
    end,

    Shock = function(p6) -- Line: 71, Name: Shock
        -- upvalues: TweenService (copy)
        TweenService:Create(p6, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            CFrame = p6.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play();
        TweenService:Create(p6.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.02, 0.02, 0.02)
        }):Play();
        task.delay(1, p6.Destroy, p6);
    end
};