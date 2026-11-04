  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), Debris (copy), EmitModule (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "NelReoHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.8);
    task.wait(0.5);
    local v2 = script.Pressure:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.5, -2.25, -1) * CFrame.fromOrientation(-1.5301476085159487, -3.138608140568883, 1.5707963267948966));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    Debris:AddItem(v2, 2);
end;