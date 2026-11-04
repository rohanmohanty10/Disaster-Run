 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 8
    -- upvalues: Essentials (copy), ReplicatedStorage (copy)
    Essentials:RagdollBack(p2);
    ReplicatedStorage.Remotes.GoalEffect:FireAllClients(ReplicatedStorage.Effects.GoalEffects.Client["Za Warudo"], {
        Player = p2.Plr,
        Vfx = p2.Vfx,
        CFrame = p2.CFrame
    });
end;