  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), SoundManager (copy), EmitModule (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("Scythe pass", 1.5, p1.Char.HumanoidRootPart, 150, nil);
    task.wait(0.4);
    local v2 = script.ShOOT:Clone();
    v2:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.new(0, 0, -2.5));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    Debris:AddItem(v2, 3);
    local v3 = script.ShootMesh:Clone();
    v3:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, -1.5707963267948966));
    v3.Parent = workspace.Debris;
    local v4 = script.Model:Clone();
    v4:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(0, 3.141592653589793, -1.5707963267948966));
    v4.Parent = workspace.Debris;
    local v5 = script.Mesh1:Clone();
    v5:PivotTo(p1.Char.PrimaryPart.CFrame * CFrame.fromOrientation(1.5707963267948966, 3.141592653589793, 0));
    v5.Parent = workspace.Debris;
    EmitModule.emit(v3);
    EmitModule.emit(v4);
    EmitModule.emit(v5);
    Debris:AddItem(v3, 2);
    Debris:AddItem(v4, 2);
    Debris:AddItem(v5, 2);
end;