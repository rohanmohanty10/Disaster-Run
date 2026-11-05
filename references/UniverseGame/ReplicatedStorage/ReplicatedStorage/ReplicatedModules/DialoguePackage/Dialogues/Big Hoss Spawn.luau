  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("ShopService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
u3:SetTitle("Big Hoss");
u3:SetStarterText("I\'m in dire need of a McChicken. I can let you take on my Shadow, however I\'ll be needing a [Monochromatic Orb] and [5.000.000] UCoins to cover those costs.");
u3:AddResponse("Sure", function() -- Line: 21
    -- upvalues: u2 (copy), u3 (copy)
    local v4 = u2:CheckRequirement("ItemCountCheck", "ITEM_530"):expect();

    if typeof(v4) ~= "number" or v4 <= 0 then
        u3:SetText("It seems you\'re missing the item I need. Get it pronto, I really need that McChicken.");

        return;
    end;

    local v5 = u2:CheckDialogue(script.Name):expect();

    if v5 ~= true then
        if typeof(v5) == "number" then
            u3:SetText(string.format("You poor as hell, get back when you have gathered another [%s] UCoins", (tostring(v5))));
        elseif v5 == false then
            u3:SetText("Hey man, I can\'t hear you from over there.");

            return;
        end;

        return "ClearResponses";
    end;

    u3:Destroy();
end);
u3:AddResponse("No", function() -- Line: 14, Name: ResetDialogue
    -- upvalues: u3 (copy)
    u3:Destroy();
end);

return u3;