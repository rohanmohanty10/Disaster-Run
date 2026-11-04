  

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
    local v2 = script.Startup:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    local v3 = script.JumpEmit:Clone();
    v3:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(0.5);
    local v4 = script.NagiControl:Clone();
    v4:PivotTo(Char.HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    task.wait(2);
    Folder:Destroy();
    v4:Destroy();
    v3:Destroy();
    v2:Destroy();
end;