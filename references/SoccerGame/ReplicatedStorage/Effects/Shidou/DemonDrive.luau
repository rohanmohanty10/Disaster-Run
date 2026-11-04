  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), TweenService (copy), Essentials (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    SoundManager.SpawnSound("DemonDrive", 0.7, Char.HumanoidRootPart, 130, false);
    local _ = game.Players.LocalPlayer;
    local u2 = script.demondriverunvfx:Clone();
    u2.CFrame = Char.HumanoidRootPart.CFrame;
    u2.Parent = workspace.Debris;
    VfxManager.Enable(u2, true);
    task.delay(0.33, function() -- Line: 23
        -- upvalues: u2 (copy), TweenService (ref)
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    LocalTransparencyModifier = 1
                }):Play();
            end;
        end;
    end);
    Essentials:WeldOffset(Char.HumanoidRootPart, u2, CFrame.new(0.161811829, -0.451106787, -0.698946953, 0, 0, 1, 0, 1, 0, -1, 0, 0));
    Debris:AddItem(u2, 12);
    task.delay(0.78, VfxManager.Enable, u2, false);
end;