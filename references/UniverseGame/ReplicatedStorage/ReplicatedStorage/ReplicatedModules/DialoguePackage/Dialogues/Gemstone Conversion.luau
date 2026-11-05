  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local v2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;
local u4 = v2.new();
u4:SetTitle("Z4");
u4:SetStarterText("Yo");
u4:AddResponse("Can I convert this ability to a gemstone?", function() -- Line: 19
    -- upvalues: u4 (copy)
    u4:SetText("Before you continue, I am going to warn you that you will lose the ability if it\'s applicable, you can back off right now if you wish not to.");

    return "Continue";
end):LinkResponse("Continue, I am going to convert the ability.", function() -- Line: 22
    -- upvalues: u3 (copy), u4 (copy)
    if u3:CheckDialogue(script.Name):expect() then
        u4:SetText("There you go.");
    else
        u4:SetText("Your current ability cannot be converted, come back once you have something like Dragon Knight or Locke. I\'d recommend talking to the slayer NPCs for Dragon Knight or finding a Kinetic Orb for Locke. You should also try for something like Dawn or Xeno, I\'d recommend asking some folks around for help as well!");
    end;

    return "ClearResponses";
end);

return u4;