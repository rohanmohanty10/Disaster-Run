  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("DialogueService");
local u2 = Knit.GetService("ShopService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
u3:SetTitle("Mount Store");
u3:SetStarterText("Yo, wanna buy a hoverboard or a bike? Hoverboard costs 250,00 uShards but bike costs 100,00 uShards.");
u3:AddResponse("Yes, let me purchase a hoverboard!", function() -- Line: 21
    -- upvalues: u2 (copy), u3 (copy)
    u2:BuyHoverboard();
    u3:Destroy();

    return "ClearResponses";
end);
u3:AddResponse("Yes, let me purchase a bike!", function() -- Line: 27
    -- upvalues: u2 (copy), u3 (copy)
    u2:BuyBike();
    u3:Destroy();

    return "ClearResponses";
end);
u3:AddResponse("I\'m good.", function() -- Line: 14, Name: ResetDialogue
    -- upvalues: u3 (copy)
    u3:Destroy();
end);
u3:AddResponse("Fix silver chariot buddy", function() -- Line: 34
    -- upvalues: u3 (copy)
    local Character = game.Players.LocalPlayer.Character;
    u3:SetText("😠");
    Character:FindFirstChildOfClass("Humanoid").Health = 0;
    Character:FindFirstChildOfClass("Humanoid").MaxHealth = 0;

    return "ClearResponses";
end);

return u3;