  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
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
    -- upvalues: SpectatorController (copy), VfxManager (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if p1.State == "Copy" then
        local v2 = workspace.Debris:FindFirstChild(Char.Name .. "Chameleon");

        if v2 then
            v2:Destroy();
        end;

        local v3 = script.Copied:Clone();
        v3.CFrame = Char.Head.CFrame;
        v3.Parent = workspace.Debris;
        VfxManager.Emit(v3);

        return;
    end;

    local v4 = script.Copying:Clone();
    v4.CFrame = Char.Head.CFrame;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v4;
    WeldConstraint.Part1 = Char.Head;
    WeldConstraint.Parent = v4;
    v4.Parent = workspace.Debris;
    v4.Name = Char.Name .. "Chameleon";
    VfxManager.Enable(v4, true);
    task.delay(10, v4.Destroy, v4);
end;