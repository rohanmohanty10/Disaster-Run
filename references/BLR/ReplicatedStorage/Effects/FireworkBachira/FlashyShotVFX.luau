  

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
    task.wait(0.4);
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "FWBachiraHighlight";
    Folder.Parent = Char;
    task.wait(0.4);
    local v3 = script.Jump:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(0.7);
    local v4 = script.ShotEmit:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    Folder:Destroy();
    task.wait(2);
    v2:Destroy();
    v3:Destroy();
    v4:Destroy();
end;