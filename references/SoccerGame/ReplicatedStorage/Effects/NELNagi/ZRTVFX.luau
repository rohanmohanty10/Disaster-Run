  

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
    local v2 = script.eSCAPE:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(0.2);
    local v3 = script.Trap:Clone();
    v3:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.fromOrientation(0, 3.4033920413889427, 0));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    local v4 = script["Flame Ground"]:Clone();
    v4:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.fromOrientation(0, 0.2617993877991494, 0) * CFrame.new(0, -2.5, 7));
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    task.wait(1);
    Folder:Destroy();
    task.wait(2);
    v3:Destroy();
    v4:Destroy();
    v2:Destroy();
end;