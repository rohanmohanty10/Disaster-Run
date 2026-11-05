  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("ShopService");
Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetTitle("Bike Rack");
u4:SetStarterText("Would you like to take a bike from the rack? (costs 3500 UCoins)");
u4:AddResponse("YES", function() -- Line: 21
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v5 = u2:CheckDialogue(script.Name):expect();

    if v5 ~= true then
        u4:SetText(string.format("You need [%s] UCoins", v5));

        return "ClearResponses";
    end;

    u3:BuyBike();
    u4:Destroy();
end);
u4:AddResponse("No", function() -- Line: 14, Name: ResetDialogue
    -- upvalues: u4 (copy)
    u4:Destroy();
end);

return u4;