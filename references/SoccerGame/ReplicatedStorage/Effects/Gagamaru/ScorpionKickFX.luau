  

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

    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local v2 = script.Jump:Clone();
    v2.Parent = workspace.Debris;
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    EmitModule.emit(v2);
    Debris:AddItem(v2, 3);
    task.wait(0.2);
    local v3 = script.Impact:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = HumanoidRootPart.CFrame;
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
end;