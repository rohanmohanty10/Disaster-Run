  

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
    local v2 = script.Pressure:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
    task.wait(0.2);
    local v3 = script.EndDash:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(7.494, 0, -8.383) * CFrame.fromOrientation(0, 2.722835806158794, 1.573780839815807));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
end;