  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

return function(p3) -- Line: 20
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and (game.Players.LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (game.Players.LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        table.clear(p3);

        return;
    end;

    local Team = p3.Team;
    local u4 = ReplicatedStorage.Assets.GoalEffects.Grillz.VFX["Environment Effect"]:Clone();
    u4.Parent = workspace.Debris;
    local v5 = ReplicatedStorage.Assets.GoalEffects.Grillz.VFX.Money:Clone();
    local Pos = p3.Pos;
    v5.Parent = workspace.Debris;

    if Team and Team.Name == "Away" then
        Pos = Pos * CFrame.Angles(0, -3.141592653589793, 0) or Pos;
    end;

    v5.CFrame = Pos;
    v5.CFrame = v5.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
    VfxManager.Emit(v5);
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Brightness = 0.1;
    ColorCorrection.Contrast = 0.6;
    ColorCorrection.Saturation = -0.5;
    ColorCorrection.TintColor = Color3.fromRGB(255, 255, 82);
    TweenService:Create(ColorCorrection, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Contrast = 0.25,
        Saturation = 0.5,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    EnableVFX(u4);

    for _, descendant in u4.Particles.Folder:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(1.3, function() -- Line: 56
                -- upvalues: TweenService (ref), descendant (copy), Width0 (copy), Width1 (copy), u4 (copy)
                local v6 = TweenService:Create(descendant, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                    Width0 = 0,
                    Width1 = 0
                });
                v6:Play();
                v6.Completed:Once(function() -- Line: 60
                    -- upvalues: descendant (ref), Width0 (ref), Width1 (ref)
                    descendant.Enabled = false;
                    descendant.Width0 = Width0;
                    descendant.Width1 = Width1;
                end);
                EnableVFX(u4, false);
            end);
        end;
    end;

    task.delay(3, function() -- Line: 69
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;