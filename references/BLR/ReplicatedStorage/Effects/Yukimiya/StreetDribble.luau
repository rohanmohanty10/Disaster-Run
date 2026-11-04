  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local u2 = script.YukiTrail:Clone();
    u2.CFrame = p1.Char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 1.5707963267948966, 0);
    u2.Parent = p1.Char;
    Essentials:Weld(u2, p1.Char.HumanoidRootPart);
    VfxManager.Enable(u2, false);
    local u3 = script.FloorTexture:Clone();
    u3.Parent = workspace;
    local u4 = TweenService:Create(u3.SurfaceGui.ImageLabel.UIGradient, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Offset = Vector2.new(0, 1)
    });
    local u5 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Density = 0.52,
        Color = Color3.new(0, 0, 0),
        Decay = Color3.new(0, 0, 0)
    });
    local u6 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Saturation = 1
    });
    local u7 = TweenService:Create(game.Lighting, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        OutdoorAmbient = Color3.new(0.764706, 0.72549, 0.694118)
    });
    u4:Play();
    u5:Play();
    u6:Play();
    u7:Play();
    task.delay(2, function() -- Line: 47
        -- upvalues: TweenService (ref), u3 (copy), VfxManager (ref), u2 (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy)
        local u8 = TweenService:Create(u3.SurfaceGui.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        });
        local u9 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Density = 0.3,
            Color = Color3.new(0.34902, 0.368627, 0.780392),
            Decay = Color3.new(0.192157, 0.196078, 0.388235)
        });
        local u10 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Saturation = 0.5
        });
        local u11 = TweenService:Create(game.Lighting, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            OutdoorAmbient = Color3.new(0.313725, 0.396078, 0.54902)
        });
        VfxManager.Enable(u2, true);
        task.delay(2.5, function() -- Line: 63
            -- upvalues: VfxManager (ref), u2 (ref)
            VfxManager.Enable(u2, false);
            task.delay(1, function() -- Line: 65
                -- upvalues: u2 (ref)
                u2:Destroy();
            end);
        end);
        u8:Play();
        u9:Play();
        u10:Play();
        u11:Play();
        task.delay(0.25, function() -- Line: 73
            -- upvalues: u3 (ref), u4 (ref), u8 (copy), u5 (ref), u9 (copy), u6 (ref), u10 (copy), u11 (copy), u7 (ref)
            u3:Destroy();
            u4:Destroy();
            u8:Destroy();
            u5:Destroy();
            u9:Destroy();
            u6:Destroy();
            u10:Destroy();
            u11:Destroy();
            u7:Destroy();
        end);
    end);
end;