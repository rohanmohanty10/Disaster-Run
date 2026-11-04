  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local v2 = script.Dazh1:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    v2.Parent = workspace.Debris;

    for _, child in pairs(v2:GetChildren()) do
        EmitModule.emit(child);
    end;

    local v3 = script.Startup:Clone();
    v3.Parent = workspace.Debris;
    local Weld = Instance.new("Weld");
    Weld.Parent = v3.GroundFX;
    Weld.Part0 = v3.GroundFX;
    Weld.Part1 = HumanoidRootPart;
    EmitModule.emit(v3);
    local Folder = Instance.new("Folder");
    Folder.Name = "BMRinHighlight";
    Folder.Parent = Char;
    task.wait(0.8);
    VfxManager.Enable(v3, false);
    Folder:Destroy();
    task.wait(1);
    v3:Destroy();
    v2:Destroy();
end;