 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), VfxManager (copy), CameraShaker (copy), Lighting (copy), TweenService (copy)
    local Controller = Knit.GetController("CameraController");

    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "Purple EyeSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 24
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "Purple EyeSFX",
            Parent = workspace
        });
    end;

    local u3 = script.Score:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    VfxManager.DestroyEffect(u3, 6);

    if p2.Preview then
        u3:ScaleTo(0.2);
        u3.ScreenEffect:Destroy();
    else
        Controller.CamShake:Shake(CameraShaker.Presets.Explosion);
        task.delay(3, function() -- Line: 41
            -- upvalues: Controller (copy), CameraShaker (ref)
            Controller.CamShake:Shake(CameraShaker.Presets.Dunk);
        end);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CCAddon";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(3, function() -- Line: 50
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
        ColorCorrectionEffect.Brightness = 0.5;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -1;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(142, 82, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75), {
            Brightness = 0,
            Contrast = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(0.75, function() -- Line: 59
            -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.25), {
                Contrast = 1
            }):Play();
        end);
        task.delay(2, function() -- Line: 62
            -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1), {
                Contrast = 0,
                Saturation = 0
            }):Play();
        end);
    end;

    shared.vfx.emit(u3);
    task.delay(2, function() -- Line: 69
        -- upvalues: u3 (copy), TweenService (ref)
        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("PointLight") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;
        end;
    end);
end;