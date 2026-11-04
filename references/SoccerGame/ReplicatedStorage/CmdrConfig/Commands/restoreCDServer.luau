  

require(game.ServerScriptService.Profile.ProfileManager);
game:GetService("ReplicatedStorage");

return function(p1, p2) -- Line: 3
    workspace.ServerSettings:SetAttribute("NoAbilityCooldown", false);
end;