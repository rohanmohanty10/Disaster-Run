 
 

local TweenService = game:GetService("TweenService");
local u2 = {
    SineMode = function(p1) -- Line: 6
        return TweenInfo.new(p1, Enum.EasingStyle.Sine);
    end
};

local function u3(...) -- Line: 12
    -- upvalues: TweenService (copy)
    return TweenService:Create(...);
end;

return {
    Shrink = function(p4, p5) -- Line: 20
        -- upvalues: u3 (copy), u2 (copy)
        local u6 = u3(p4, u2.SineMode(p5), {
            Size = Vector3.new(0, 0, 0)
        });
        u6:Play();
        task.spawn(function() -- Line: 25
            -- upvalues: u6 (copy)
            u6.Completed:Wait();
            u6:Destroy();
        end);
    end,

    Melt = function(p7, p8) -- Line: 31
        -- upvalues: u3 (copy), u2 (copy)
        local u9 = u3(p7, u2.SineMode(p8), {
            Position = p7.Position + Vector3.new(0, -p7.Size.X * 1.5, 0)
        });
        u9:Play();
        task.spawn(function() -- Line: 36
            -- upvalues: u9 (copy)
            u9.Completed:Wait();
            u9:Destroy();
        end);
    end,

    FadeOut = function(p10, p11) -- Line: 42
        -- upvalues: u3 (copy), u2 (copy)
        local u12 = u3(p10, u2.SineMode(p11), {
            Transparency = 1
        });
        u12:Play();
        task.spawn(function() -- Line: 47
            -- upvalues: u12 (copy)
            u12.Completed:Wait();
            u12:Destroy();
        end);
    end,

    Enlarge = function(p13, p14, p15) -- Line: 54
        -- upvalues: u3 (copy), u2 (copy)
        local Size = p13.Size;
        p13.CFrame = p15.CFrame;
        p13.Size = Vector3.new(0, 0, 0);
        local u16 = u3(p13, u2.SineMode(p14), {
            Size = Size
        });
        u16:Play();
        task.spawn(function() -- Line: 60
            -- upvalues: u16 (copy)
            u16.Completed:Wait();
            u16:Destroy();
        end);
    end,

    Grow = function(p17, p18, p19) -- Line: 66
        -- upvalues: u3 (copy), u2 (copy)
        p17.CFrame = p17.CFrame * CFrame.new(0, -p17.Size.X / 1.5, 0);
        local u20 = u3(p17, u2.SineMode(p18), p19);
        u20:Play();
        task.spawn(function() -- Line: 70
            -- upvalues: u20 (copy)
            u20.Completed:Wait();
            u20:Destroy();
        end);
    end,

    FadeIn = function(p21, p22, p23) -- Line: 76
        -- upvalues: u3 (copy), u2 (copy)
        p21.CFrame = p23.CFrame;
        local Transparency = p21.Transparency;
        p21.Transparency = 1;
        local u24 = u3(p21, u2.SineMode(p22), {
            Transparency = Transparency
        });
        u24:Play();
        task.spawn(function() -- Line: 84
            -- upvalues: u24 (copy)
            u24.Completed:Wait();
            u24:Destroy();
        end);
    end
};