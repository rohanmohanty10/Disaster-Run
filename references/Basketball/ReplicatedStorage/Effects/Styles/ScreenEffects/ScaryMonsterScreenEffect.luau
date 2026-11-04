 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LocalPlayer = Players.LocalPlayer;
local Camera = game.Workspace.Camera;
local Debris = workspace:FindFirstChild("Debris");
local u1 = nil;
local u2 = nil;

return function(p3, p4) -- Line: 17
    -- upvalues: Knit (copy), Camera (copy), LocalPlayer (copy), TweenService (copy), VfxManager (copy), Lighting (copy), Essentials (copy), u2 (ref), u1 (ref), Debris (copy)
    local Controller = Knit.GetController("CameraController");
    local math_clamp_ret = math.clamp(25 / (Camera.CFrame.Position - p4.Position).Magnitude, LocalPlayer.Character == p3 and 0.5 or 0, 1);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local v5 = script.Vignette:Clone();
    v5.Parent = PlayerGui;
    v5.Enabled = true;
    v5.Vignette2.ImageTransparency = 1 - math_clamp_ret;
    TweenService:Create(v5.Vignette2, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        ImageTransparency = 1
    }):Play();
    VfxManager.DestroyEffect(v5, 1);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(0.905, function() -- Line: 36
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect:Destroy();
    end);
    local FieldOfView = Camera.FieldOfView;
    Camera.FieldOfView = Essentials:Lerp(Camera.FieldOfView, 125, math_clamp_ret);
    local ServerTimeNow = workspace:GetServerTimeNow();
    u2 = ServerTimeNow;

    if u1 then
        u1:Cancel();
        u1 = nil;
    end;

    u1 = TweenService:Create(Camera, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        FieldOfView = FieldOfView
    });
    u1:Play();
    Controller.FOVActive = false;
    task.delay(0.45, function() -- Line: 55
        -- upvalues: u2 (ref), ServerTimeNow (copy), Controller (copy)
        if u2 ~= ServerTimeNow then
            return;
        end;

        Controller.FOVActive = true;
    end);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = math_clamp_ret * 10;
    TweenService:Create(BlurEffect, TweenInfo.new(1.25), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 1.25);
    task.spawn(function() -- Line: 65
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), math_clamp_ret (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
            TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(120, 255, 57), math_clamp_ret)
        }):Play();
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
            TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 234, 3), math_clamp_ret)
        }):Play();
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
            TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(32, 54, 255), math_clamp_ret)
        }):Play();
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
            TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 39, 39), math_clamp_ret)
        }):Play();
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
            TintColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(78, 42, 255), math_clamp_ret)
        }):Play();
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.655), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    local v6 = script.Distortion:Clone();
    v6.Parent = Debris;
    v6:PivotTo(p4);
    VfxManager.DestroyEffect(v6, 0.423);
    shared.vfx.emit(v6);
end;