 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");
local workspace_CurrentCamera = workspace.CurrentCamera;

local function CloneCharacter(p1, p2, p3) -- Line: 16
    -- upvalues: Debris (copy)
    local Archivable = p1.Archivable;
    p1.Archivable = true;
    local v4 = p1:Clone();
    v4.Parent = p2 or Debris;
    v4.HumanoidRootPart.Anchored = true;
    v4.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v4.HumanoidRootPart.CFrame = p3 or p1.HumanoidRootPart.CFrame;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
        elseif descendant:IsA("Highlight") or (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and not descendant:FindFirstAncestorWhichIsA("Accessory") then
            descendant:Destroy();
        end;
    end;

    p1.Archivable = Archivable;

    return v4;
end;

return function(p5, p6) -- Line: 40
    -- upvalues: Knit (copy), SfxManager (copy), TweenService (copy), workspace_CurrentCamera (copy), CameraShaker (copy), CloneCharacter (copy), VfxManager (copy), Lighting (copy)
    local Controller = Knit.GetController("CameraController");
    local Character = p6.Player.Character;

    if not Character then
        return;
    end;

    if p6.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p6.CFrame.Position;
        SfxManager:playSound({
            Sound = "Za Warudo Goal",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 124
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        local v7 = script.Score:Clone();
        v7:PivotTo(p6.CFrame);
        v7.Parent = workspace.Debris;
        VfxManager.DestroyEffect(v7, 2);
        local Model = Instance.new("Model");
        v7.Parent = Model;
        Model.PrimaryPart = v7;
        Model:ScaleTo(0.2);
        v7.Parent = workspace.Debris;
        Model:Destroy();
        shared.vfx.emit(v7);
        task.wait(4);

        return;
    end;

    SfxManager:playSound({
        Sound = "Za Warudo Player",
        Parent = Character:FindFirstChild("HumanoidRootPart")
    });
    local v8 = Character.Humanoid:LoadAnimation(script.StartAnimation);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play();
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
        FieldOfView = 40
    }):Play();
    task.wait(0.5);
    SfxManager:playSound({
        Sound = "Za Warudo Goal",
        Parent = workspace
    });
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FieldOfView = 70
    }):Play();
    Controller.CamShake:Shake(CameraShaker.Presets.Explosion);
    local v9 = CloneCharacter(Character, workspace.Debris, CFrame.new(p6.CFrame.Position.X, 13, p6.CFrame.Position.Z) * p6.CFrame.Rotation * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, 0, -10));
    v9:ScaleTo(3);
    VfxManager.DestroyEffect(v9, 2.5);
    local u10 = v9.Humanoid:LoadAnimation(script.EndAnimation);
    u10:Play();
    task.delay(1.5, function() -- Line: 69
        -- upvalues: u10 (copy)
        u10:AdjustSpeed(0);
    end);
    local v11 = script.Score:Clone();
    v11.Parent = workspace.Debris;
    v11:PivotTo(p6.CFrame);
    VfxManager.DestroyEffect(v11, 2.5);
    local v12 = script.CameraFX:Clone();
    v12.Parent = workspace.Debris;
    VfxManager.DestroyEffect(v12, 2.5);
    shared.vfx.emit(v11, v12);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local Lig = Instance.new("Lig");
    Lig.Name = "CCAddon";
    Lig.Parent = Lighting;
    Lig.Enabled = true;
    task.delay(4, function() -- Line: 92
        -- upvalues: Lig (copy), Lighting (ref), ColorCorrection (copy)
        Lig:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    TweenService:Create(Lig, TweenInfo.new(0.175), {
        Contrast = 2,
        TintColor = Color3.fromRGB(112, 30, 255)
    }):Play();
    task.delay(0.175, function() -- Line: 100
        -- upvalues: TweenService (ref), Lig (copy), ColorCorrection (copy)
        TweenService:Create(Lig, TweenInfo.new(0.175), {
            TintColor = Color3.fromRGB(120, 255, 57)
        }):Play();
        task.wait(0.175);
        TweenService:Create(Lig, TweenInfo.new(0.175), {
            TintColor = Color3.fromRGB(255, 234, 3)
        }):Play();
        task.wait(0.175);
        TweenService:Create(Lig, TweenInfo.new(0.975), {
            Saturation = -1,
            TintColor = Color3.fromRGB(255, 255, 255),
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(2.5, function() -- Line: 108
        -- upvalues: TweenService (ref), Lig (copy), ColorCorrection (copy)
        TweenService:Create(Lig, TweenInfo.new(0.175), {
            Contrast = 2,
            TintColor = Color3.fromRGB(255, 234, 3),
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(0.175, function() -- Line: 110
            -- upvalues: TweenService (ref), Lig (ref), ColorCorrection (ref)
            TweenService:Create(Lig, TweenInfo.new(0.175), {
                TintColor = Color3.fromRGB(120, 255, 57)
            }):Play();
            task.wait(0.175);
            TweenService:Create(Lig, TweenInfo.new(0.175), {
                TintColor = Color3.fromRGB(112, 30, 255)
            }):Play();
            task.wait(0.175);
            TweenService:Create(Lig, TweenInfo.new(0.975), {
                TintColor = Color3.fromRGB(255, 255, 255),
                Contrast = ColorCorrection.Contrast
            }):Play();
        end);
    end);
end;