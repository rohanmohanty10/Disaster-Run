 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, p2) -- Line: 9
    -- upvalues: SfxManager (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    SfxManager:playSound({
        Sound = "LSFX",
        Parent = workspace
    });
    local v3 = script.Emit:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = p2.CFrame;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(0.25, function() -- Line: 24
        -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.25);
    u4.Brightness = 0.65;
    u4.TintColor = Color3.fromRGB(255, 26, 26);
    TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.BetterEmit(v3);
    VfxManager.DestroyEffect(v3, 4);
end;