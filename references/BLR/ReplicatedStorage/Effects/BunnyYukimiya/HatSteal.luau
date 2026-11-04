  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Controllers.AnimationController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = game.Players.LocalPlayer;

return function(p1) -- Line: 18
    -- upvalues: SpectatorController (copy), EmitModule (copy), Debris (copy), LocalPlayer (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    Debris:AddItem(v2, 5);
    local v3 = script.hat2:Clone();
    v3.Parent = Char;
    v3.hat2.Part0 = HumanoidRootPart;
    v3.hat2.Part1 = v3;
    local _ = Char == LocalPlayer.Character;
    task.wait(0.1);
    local v4 = script.Emit1:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame);
    v4.Parent = workspace.Debris;
    EmitModule.emit(v4);
    Debris:AddItem(v4, 5);
    task.wait(1.1);
    local v5 = script.ShotEmit:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame);
    v5.Parent = workspace.Debris;
    EmitModule.emit(v5);
    Debris:AddItem(v5, 5);
    v3:Destroy();
end;