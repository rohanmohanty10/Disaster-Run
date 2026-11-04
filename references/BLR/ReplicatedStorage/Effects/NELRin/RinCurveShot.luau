  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;
    local v2 = script.KickStartUp:Clone();
    v2.CFrame = Char.Torso.CFrame * CFrame.Angles(0.7853981633974483, 0, 0);
    v2.Parent = workspace.Debris;
    Essentials:Weld(v2, Char.HumanoidRootPart);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 1);
    task.wait(0.85);
    local v3 = script.Kick:Clone();
    v3.CFrame = Char.Torso.CFrame * CFrame.Angles(0.7853981633974483, 0, 0);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 1);
end;