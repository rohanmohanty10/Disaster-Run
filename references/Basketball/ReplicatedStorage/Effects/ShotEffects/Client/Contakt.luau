 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), Essentials (copy), Lighting (copy), TweenService (copy), VfxManager (copy), SfxManager (copy), ReplicatedStorage (copy)
    local Ball = p2.Ball;
    local Torso = p2.Char:FindFirstChild("Torso");
    local v3 = p2.Locker and Ball.CFrame or Torso.CFrame;
    local v4 = p2.Vfx.Ball:Clone();
    v4.Parent = Debris;
    v4.CFrame = Ball.CFrame;
    Essentials:Weld(v4, Ball);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(0.25, function() -- Line: 28
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 5;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.25);
    ColorCorrectionEffect.Brightness = 0.15;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(155, 215, 255);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    SfxManager:playSound({
        Sound = ReplicatedStorage.Assets.SFX.ShotEffects.Contakt,
        Parent = v4
    });
    local Emit = p2.Vfx:FindFirstChild("Emit");

    if Emit then
        local v5 = Emit:Clone();
        v5.Parent = Debris;
        v5.CFrame = v3.Position.Y < 16 and CFrame.new(v3.Position.X, 1, v3.Position.Z) * CFrame.fromOrientation(v3:ToOrientation()) or v3 + Vector3.new(0, -3, 0);
        VfxManager.BetterEmit(v5);
        VfxManager.DestroyEffect(v5, 6);
    end;

    local v6 = tick();

    if p2.Locker then
        repeat
            task.wait();
        until tick() - v6 > 5 or not (Ball and (Ball:IsDescendantOf(Debris) and Ball.Position.Y >= 4));
    else
        repeat
            task.wait();
        until tick() - v6 > 5 or (Ball.Transparency == 1 or Ball.Position.Y < 4);
    end;

    VfxManager.Enable(v4, false);
    VfxManager.DestroyEffect(v4, 6);
end;