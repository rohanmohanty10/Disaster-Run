  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("Parkour shot", 0.9, Char.HumanoidRootPart, 130, false);
    local Folder = Instance.new("Folder");
    Folder.Name = "ChigiriHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.7);
    local v2 = script.StartupSimple:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    EmitModule.emit(v2);
    task.wait(0.55);
    local v3 = script.Shot:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(HumanoidRootPart.CFrame);
    EmitModule.emit(v3);
    task.wait(2);
    v2:Destroy();
    v3:Destroy();
end;