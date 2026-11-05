  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
u2:SetTitle("Rayleigh");
u2:SetStarterText("What can I help you with?");
u2:AddResponse("I wish to change my Haki color", function(p3) -- Line: 13
    -- upvalues: u2 (copy)
    game.ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowHakiUI");
    u2:Destroy();

    return "ClearResponses";
end);

return u2;