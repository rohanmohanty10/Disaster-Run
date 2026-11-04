 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
workspace:FindFirstChild("Debris");
local _ = workspace.CurrentCamera;

return function(p1, p2) -- Line: 16
    -- upvalues: Knit (copy), SfxManager (copy), CameraShaker (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    local Controller = Knit.GetController("CameraController");

    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "Za Warudo Goal",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 71
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        local v3 = script.Score:Clone();
        v3:PivotTo(p2.CFrame);
        v3.Parent = workspace.Debris;
        VfxManager.DestroyEffect(v3, 2);
        local Model = Instance.new("Model");
        v3.Parent = Model;
        Model.PrimaryPart = v3;
        Model:ScaleTo(0.2);
        v3.Parent = workspace.Debris;
        Model:Destroy();
        shared.vfx.emit(v3);
        task.wait(4);

        return;
    end;

    SfxManager:playSound({
        Sound = "Za Warudo Goal",
        Parent = workspace
    });
    Controller.CamShake:Shake(CameraShaker.Presets.Explosion);
    local v4 = script.Score:Clone();
    v4.Parent = workspace.Debris;
    v4:PivotTo(p2.CFrame);
    VfxManager.DestroyEffect(v4, 3);
    local v5 = script.CameraFX:Clone();
    v5.Parent = workspace.Debris;
    VfxManager.DestroyEffect(v5, 3);
    shared.vfx.emit(v4, v5);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u6 = ColorCorrection:Clone();
    u6.Name = "CC";
    u6.Parent = Lighting;
    u6.Enabled = true;
    task.delay(3.825, function() -- Line: 43
        -- upvalues: u6 (copy), Lighting (ref), ColorCorrection (copy)
        u6:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    TweenService:Create(u6, TweenInfo.new(0.175), {
        Contrast = 2,
        TintColor = Color3.fromRGB(0, 85, 255)
    }):Play();
    task.delay(0.175, function() -- Line: 51
        -- upvalues: TweenService (ref), u6 (copy), ColorCorrection (copy)
        TweenService:Create(u6, TweenInfo.new(0.175), {
            TintColor = Color3.fromRGB(100, 229, 255)
        }):Play();
        task.wait(0.175);
        TweenService:Create(u6, TweenInfo.new(0.975), {
            TintColor = Color3.fromRGB(255, 255, 255),
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(2.5, function() -- Line: 57
        -- upvalues: TweenService (ref), u6 (copy), ColorCorrection (copy)
        TweenService:Create(u6, TweenInfo.new(0.175), {
            Contrast = 2,
            TintColor = Color3.fromRGB(0, 85, 255)
        }):Play();
        task.delay(0.175, function() -- Line: 59
            -- upvalues: TweenService (ref), u6 (ref), ColorCorrection (ref)
            TweenService:Create(u6, TweenInfo.new(0.175), {
                TintColor = Color3.fromRGB(100, 229, 255)
            }):Play();
            task.wait(0.175);
            TweenService:Create(u6, TweenInfo.new(0.975), {
                TintColor = Color3.fromRGB(255, 255, 255),
                Contrast = ColorCorrection.Contrast
            }):Play();
        end);
    end);
end;