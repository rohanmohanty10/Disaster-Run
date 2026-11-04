  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("Lighting");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), VfxManager (copy)
    local Char = p1.Char;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "NELNagiHighlight";
    Folder.Parent = Char;
    local v2 = script.Start:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(0.25);
    local v3 = script.Flick:Clone();
    v3:PivotTo(Char.HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(0.4);
    local v4 = script.Trap:Clone();
    v4:PivotTo(Char.HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    task.wait(0.35);
    local v5 = script.mesh:Clone();
    v5:PivotTo(Char.HumanoidRootPart.CFrame);
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    task.wait(0.3);
    Folder:Destroy();
    task.wait(2);
    v4:Destroy();
    v3:Destroy();
    v4:Destroy();
    v2:Destroy();
end;