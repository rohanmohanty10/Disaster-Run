  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Name = "BMRinHighlight";
    Folder.Parent = Char;
    task.wait(0.5);
    local v2 = script["Kick EMIT"]:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -2));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.5);
    v2:Destroy();
    Folder:Destroy();
end;