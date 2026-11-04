 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    if p2.Preview then
        local u3 = script.Model:Clone();
        u3.Parent = workspace.Debris;
        local _, _, _ = p2.CFrame:ToOrientation();
        u3:PivotTo(p2.CFrame);
        u3:ScaleTo(0.2);
        u3.Humanoid.Animator:LoadAnimation(script.Animation):Play();
        task.delay(2.3, function() -- Line: 76
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3, false);

            for _, descendant in u3:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                end;
            end;
        end);
        VfxManager.DestroyEffect(u3, 8);

        return;
    end;

    local u4 = script.Model:Clone();
    u4.Parent = Debris;
    local _, _, _ = p2.CFrame:ToOrientation();
    u4:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u4.Humanoid.Animator:LoadAnimation(script.Animation):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(2.755, function() -- Line: 30
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.6);
    u5.Brightness = 1;
    u5.TintColor = Color3.fromRGB(255, 108, 75);
    TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(2.3, function() -- Line: 46
        -- upvalues: VfxManager (ref), u4 (copy), Lighting (ref), TweenService (ref), u5 (copy), ColorCorrection (copy)
        VfxManager.Enable(u4, false);

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
            end;
        end;

        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 15;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.6);
        u5.Brightness = 1;
        u5.TintColor = Color3.fromRGB(255, 108, 75);
        TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    VfxManager.DestroyEffect(u4, 8);
end;