  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 13
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), RunService (copy), TweenService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local RinCurve = ReplicatedStorage.Assets.Vfx.RinCurve;
    local u2 = RinCurve.area:Clone();
    local u3 = RinCurve["RinImpact 1"]:Clone();
    local u4 = RinCurve["rin cutscene"].Head.eye:Clone();
    local u5 = RinCurve.Cam:Clone();
    u5.Parent = workspace;
    u2.Parent = workspace;
    u3.Parent = workspace;
    u4.Parent = u1.Char.Head;
    u5.CFrame = u5.CFrame * CFrame.new(0, 0, -1.5);
    u2.CFrame = u1.Char.HumanoidRootPart.CFrame * CFrame.new(-4, 0, 0);
    u3.CFrame = u1.Char.HumanoidRootPart.CFrame * CFrame.new(-1, -2.75, -2);
    local u6 = RunService.RenderStepped:Connect(function() -- Line: 32
        -- upvalues: u5 (copy)
        u5.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1.5);
    end);
    task.spawn(function() -- Line: 36
        -- upvalues: TweenService (ref)
        local u7 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Haze = 3,
            Glare = 0,
            Density = 1,
            Offset = 1,
            Color = Color3.new(0.262745, 0.654902, 0.513725)
        });
        local u8 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Haze = 2.04,
            Glare = 5,
            Density = 0.3,
            Offset = 0.5,
            Color = Color3.new(0.34902, 0.368627, 0.780392)
        });
        local u9 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Contrast = 3,
            Saturation = -3,
            TintColor = Color3.new(1, 0.294118, 0.294118)
        });
        local u10 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Contrast = 0.25,
            Saturation = 0.5,
            TintColor = Color3.new(1, 1, 1)
        });
        u7:Play();
        task.delay(1.92, function() -- Line: 54
            -- upvalues: u9 (copy), u10 (copy)
            u9:Play();
            task.delay(0.15, function() -- Line: 56
                -- upvalues: u10 (ref)
                u10:Play();
            end);
        end);
        task.delay(4.25, function() -- Line: 61
            -- upvalues: u8 (copy)
            u8:Play();
        end);
        task.delay(8, function() -- Line: 65
            -- upvalues: u7 (copy), u8 (copy), u10 (copy), u9 (copy)
            u7:Destroy();
            u8:Destroy();
            u10:Destroy();
            u9:Destroy();
        end);
    end);
    task.spawn(function() -- Line: 73
        -- upvalues: VfxManager (ref), u4 (copy), u3 (copy), u2 (copy), u5 (copy), u6 (ref), u1 (ref)
        task.delay(1.9, function() -- Line: 75
            -- upvalues: VfxManager (ref), u4 (ref)
            VfxManager.Emit(u4);
        end);
        task.delay(4.35, function() -- Line: 79
            -- upvalues: VfxManager (ref), u3 (ref)
            VfxManager.Emit(u3);
        end);
        task.delay(4.5, function() -- Line: 83
            -- upvalues: VfxManager (ref), u2 (ref), u5 (ref)
            VfxManager.Enable(u2, false);
            VfxManager.Enable(u5, false);
        end);
        task.delay(8, function() -- Line: 88
            -- upvalues: u6 (ref), u2 (ref), u5 (ref), u4 (ref), u3 (ref), u1 (ref)
            u6:Disconnect();
            u2:Destroy();
            u5:Destroy();
            u4:Destroy();
            u3:Destroy();
            table.clear(u1);
            u1 = nil;
        end);
    end);
end;