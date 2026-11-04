 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy), SfxManager (copy)
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = u3["Meshes/1_Circle.001 (3)"];
    task.delay(0.5166666666666667, function() -- Line: 22
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Land);
    end);
    task.delay(1.15, function() -- Line: 26
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.3166666666666667, function() -- Line: 32
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.4833333333333334, function() -- Line: 38
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.65, function() -- Line: 44
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.8166666666666667, function() -- Line: 50
        -- upvalues: TweenService (ref), Highlight (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 0,
            FillColor = Color3.fromRGB(255, 128, 38)
        }):Play();
        task.wait(0.1);
        TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.55, function() -- Line: 56
        -- upvalues: SfxManager (ref)
        SfxManager:playSound({
            Sound = "TNTSFX",
            Parent = workspace
        });
    end);
    task.delay(2.1333333333333333, function() -- Line: 60
        -- upvalues: u3 (copy), VfxManager (ref), TweenService (ref)
        u3["Meshes/1_Circle.001 (3)"].Transparency = 1;
        VfxManager.Emit(u3.Explosion);
        VfxManager.Emit(u3.Slam);
        u3.Light.PointLight.Enabled = true;
        TweenService:Create(u3.Light.PointLight, TweenInfo.new(1), {
            Range = 0
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 6);
end;