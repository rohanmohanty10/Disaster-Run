  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: Essentials (copy), Debris (copy)
    local Enemy = p1.Enemy;
    local v2 = script.DizzyVFX:Clone();
    v2.CFrame = Enemy.Head.CFrame;
    v2.Parent = workspace.Debris;
    Essentials:Weld(v2, Enemy.Head);
    Debris:AddItem(v2, 2);
end;