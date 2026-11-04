  

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
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.7, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    task.wait(0.3);
    local Folder = Instance.new("Folder");
    Folder.Name = "BMRinHighlight";
    Folder.Parent = Char;
    local v3 = script.Startup2:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.7, 0));
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(0.5);
    local v4 = script.Dazh1:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    v4.Parent = workspace.Debris;

    for _, child in pairs(v4:GetChildren()) do
        EmitModule.emit(child);
    end;

    local v5 = script.ZDDirtEmit:Clone();
    v5.Parent = HumanoidRootPart;
    EmitModule.emit(v5);
    task.wait(0.5);
    local v6 = script.End:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.7, 0));
    v6.Parent = workspace.Debris;

    for _, child in pairs(v6:GetChildren()) do
        EmitModule.emit(child);
    end;

    Folder:Destroy();
    task.wait(1);
    v6:Destroy();
    v5:Destroy();
    v4:Destroy();
    v2:Destroy();
    v3:Destroy();
end;