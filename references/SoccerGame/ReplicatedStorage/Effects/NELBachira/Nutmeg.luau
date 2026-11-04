  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: Essentials (copy), Debris (copy), VfxManager (copy)
    local Enemy = p1.Enemy;
    local v2 = script.Nutmeg:Clone();
    v2.CFrame = Enemy.PrimaryPart.CFrame;
    v2.Parent = workspace.Debris;
    Essentials:Weld(v2, Enemy.PrimaryPart);
    Debris:AddItem(v2, 2);
    VfxManager.Emit(v2);
end;