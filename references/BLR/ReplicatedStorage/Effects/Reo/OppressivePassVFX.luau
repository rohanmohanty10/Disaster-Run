  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), Debris (copy), VfxManager (copy)
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
    local v2 = script.StartupSimple:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-1.1, -2.5, -3.5));
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
    task.wait(p1.State and 0.25 or 0.5);
    local v3 = script.Shot:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.fromOrientation(-1.5707963267948966, 0, 0));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
end;