  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "GBCharlesHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.6);
    task.wait(0.15);
    local v3 = script.Step:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(-1.5707963267948966, 2.007128639793479, 0));
    v3.Parent = workspace.Debris;

    for _, child in pairs(v3:GetChildren()) do
        EmitModule.emit(child);
    end;

    task.wait(2);
    v3:Destroy();
    v2:Destroy();
end;