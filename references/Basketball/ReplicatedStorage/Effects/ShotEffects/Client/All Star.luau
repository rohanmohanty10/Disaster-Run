 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), RunService (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local Ball = p2.Ball;
    local Torso = p2.Char:FindFirstChild("Torso");
    local v3 = p2.Locker and CFrame.new(71.57, 4, -297.507) * CFrame.Angles(0, 1.5707963267948966, 0) or Torso.CFrame;
    local u4 = p2.Vfx.Ball:Clone();
    u4.Parent = Debris;
    u4.CFrame = Ball.CFrame;
    local u5 = nil;
    u5 = RunService.RenderStepped:Connect(function() -- Line: 23
        -- upvalues: u4 (copy), u5 (ref), Ball (copy)
        if u4 and u4:IsDescendantOf(workspace) then
            u4.CFrame = CFrame.lookAt(Ball.Position, Ball.Position + (Ball.Velocity.Magnitude > 0 and Ball.Velocity or Ball.CFrame.LookVector));

            return;
        end;

        u5:Disconnect();
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u6 = ColorCorrection:Clone();
    u6.Name = "CC";
    u6.Parent = Lighting;
    u6.Enabled = true;
    task.delay(0.25, function() -- Line: 40
        -- upvalues: u6 (copy), Lighting (ref), ColorCorrection (copy)
        u6:Destroy();

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
    u6.Brightness = 0.65;
    u6.TintColor = Color3.fromRGB(130, 99, 243);
    TweenService:Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    local Emit = p2.Vfx:FindFirstChild("Emit");

    if Emit then
        local v7 = Emit:Clone();
        v7.Parent = Debris;
        v7.CFrame = v3.Position.Y < 16 and CFrame.new(v3.Position.X, 1, v3.Position.Z) * CFrame.fromOrientation(v3:ToOrientation()) or v3 + Vector3.new(0, -3, 0);
        VfxManager.BetterEmit(v7);
        VfxManager.DestroyEffect(v7, 6);
    end;

    local v8 = tick();

    if p2.Locker then
        repeat
            task.wait();
        until tick() - v8 > 5 or not (Ball and (Ball:IsDescendantOf(Debris) and Ball.Position.Y >= 4));
    else
        repeat
            task.wait();
        until tick() - v8 > 5 or (Ball.Transparency == 1 or Ball.Position.Y < 4);
    end;

    VfxManager.Enable(u4, false);
    VfxManager.DestroyEffect(u4, 2);
    task.delay(2, function() -- Line: 76
        -- upvalues: u5 (ref)
        if u5 then
            u5:Disconnect();
        end;
    end);
end;