  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if p1.Type == "Startup" then
        local v2 = script.StartupSimple:Clone();
        v2:PivotTo(Char.HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = script.Hit4Emit:Clone();
    v3.CFrame = Char.HumanoidRootPart.CFrame;
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(2);
    v3:Destroy();
end;