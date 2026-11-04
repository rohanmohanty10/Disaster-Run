  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 12
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), SoundManager (copy), VfxManager (copy), TweenService (copy), Popup (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.Vfx.ShidouFloor:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 0, -1.5707963267948966);
    SoundManager.SpawnSound("ShidouCutscene", 1, workspace, 150);
    task.wait(0.38);
    VfxManager.Emit(u2);
    game.Lighting.ColorCorrection.Contrast = -100;
    game.Lighting.ColorCorrection.Saturation = -1;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.new(0, 0, 0);
    Highlight.Parent = u1.Plr.Character;
    task.delay(0.1, function() -- Line: 33
        -- upvalues: Highlight (copy)
        game.Lighting.ColorCorrection.Contrast = 100;
        game.Lighting.ColorCorrection.Saturation = -1;
        Highlight.FillColor = Color3.new(1, 1, 1);
    end);
    task.delay(0.2, function() -- Line: 39
        -- upvalues: Highlight (copy)
        game.Lighting.ColorCorrection.Contrast = 0.25;
        game.Lighting.ColorCorrection.Saturation = 0.5;
        Highlight:Destroy();
    end);
    task.wait(1);
    local v3 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Density = 0.8,
        Color = Color3.new(0, 0, 0),
        Decay = Color3.new(0, 0, 0)
    });
    v3:Play();
    task.wait(1);
    v3:Destroy();
    Popup.Subtitle(game.Players.LocalPlayer, "Lets start.", 2);
    task.wait(2);
    local v4 = TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Density = 0.3,
        Color = Color3.new(0, 0, 0),
        Decay = Color3.new(0.192157, 0.196078, 0.388235)
    });
    v4:Play();
    Debris:AddItem(v4, 1);
    VfxManager.Enable(u2, false);
    task.delay(10, function() -- Line: 68
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.delay(12, function() -- Line: 72
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;