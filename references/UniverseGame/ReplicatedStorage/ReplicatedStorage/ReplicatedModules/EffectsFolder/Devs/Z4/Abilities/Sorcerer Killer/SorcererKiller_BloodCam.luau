  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local RunService = game:GetService("RunService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LocalPlayer = game.Players.LocalPlayer;

return function() -- Line: 10
    -- upvalues: LocalPlayer (copy), AssetHandler (copy), ParticleHandler (copy), RunService (copy)
    local CurrentCamera = workspace.CurrentCamera;

    if LocalPlayer.Settings.CutsceneCamera.Value ~= true then
        return;
    end;

    local v1 = AssetHandler.CloneAsset("Particles/SwiftFinisher/CameraEmit", {
        AbilityName = "Sorcerer Killer"
    });
    v1.Parent = CurrentCamera;
    local v2 = os.clock();
    ParticleHandler.EnableParticle(v1, true);

    while os.clock() - v2 <= 0.8 do
        v1.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 1);
        RunService.RenderStepped:Wait();
    end;

    ParticleHandler.EnableParticle(v1, false);
    ParticleHandler.DestroyEmit(v1);
end;