 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.ShotEffect:FireAllClients(ReplicatedStorage.Effects.ShotEffects.Client.EmitEffects, {
        Vfx = p2.Vfx,
        Char = p2.Char,
        Ball = ReplicatedStorage.Basketball.Value
    });
end;