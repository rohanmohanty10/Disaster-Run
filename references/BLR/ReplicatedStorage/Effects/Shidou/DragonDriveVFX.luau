  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if p1.Type == "Startup" then
        local v2 = script.StartupSimple:Clone();
        v2:PivotTo(Char.HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        EmitModule.emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = script.catchVFX:Clone();
    v3.CFrame = Char.HumanoidRootPart.CFrame;
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(0.5);
    local v4 = script.Shot1:Clone();
    v4:PivotTo(Char.HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    task.wait(2);
    v4:Destroy();
    v3:Destroy();
end;