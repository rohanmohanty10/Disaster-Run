  

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
    -- upvalues: SpectatorController (copy), Debris (copy), EmitModule (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Name = "NessHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.8);
    local v2 = script.Trail:Clone();
    v2.Parent = Char["Right Arm"];
    local v3 = script.Trail:Clone();
    v3.Parent = Char["Left Arm"];
    task.wait(0.4);
    local v4 = script.GroundFX:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0);
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    task.wait(0.2);
    local v5 = script.GroundFX:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0);
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    task.wait(2);
    v2:Destroy();
    v3:Destroy();
    Folder:Destroy();
    v4:Destroy();
    v5:Destroy();
end;