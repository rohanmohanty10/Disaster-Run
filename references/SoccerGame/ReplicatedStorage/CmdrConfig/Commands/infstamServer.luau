  

require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 4
    p2.Character.Values.NoDrain.Value = true;
end;