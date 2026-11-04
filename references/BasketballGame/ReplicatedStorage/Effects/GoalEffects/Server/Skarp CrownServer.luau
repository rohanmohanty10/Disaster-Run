 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 8
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.GoalEffect:FireAllClients(ReplicatedStorage.Effects.GoalEffects.Client["Skarp Crown"], {
        Vfx = p2.Vfx,
        CFrame = p2.CFrame,
        Plr = p2.Plr
    });
end;