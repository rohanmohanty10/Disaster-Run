 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local v3 = script.Score:Clone();
    v3.Parent = Debris;
    v3:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(0.855, function() -- Line: 23
        -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u4.Brightness = 1;
    u4.Contrast = 2;
    u4.TintColor = Color3.fromRGB(0, 0, 0);
    TweenService:Create(u4, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast
    }):Play();
    TweenService:Create(u4, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.BetterEmit(v3);
    VfxManager.DestroyEffect(v3, 8);
end;