  

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
    -- upvalues: SpectatorController (copy), Debris (copy), EmitModule (copy), ReplicatedStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local _ = p1.State;
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Name = "RaichiHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1);
    local v2 = script.Protractor:Clone();
    v2.Parent = workspace.Debris;
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    EmitModule.emit(v2);
    local v3 = script.BlockEmit:Clone();
    v3.CFrame = ReplicatedStorage.Football.Value.CFrame;
    v3.Parent = workspace.Debris;
    EmitModule.emit(v3);
    task.wait(3);
    v3:Destroy();
    Folder:Destroy();
    v2:Destroy();
end;