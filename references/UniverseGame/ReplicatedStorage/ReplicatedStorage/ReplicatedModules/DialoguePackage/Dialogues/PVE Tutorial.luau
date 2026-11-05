  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local GetLevelRecommendation = require(PathShortcuts.ReplicatedModules.GetLevelRecommendation);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetTitle("The Guide");
u4:SetStarterText("You seem to be new around here, perhaps I could answer some questions before you depart.");
local u5 = nil;
u5 = u4:AddResponse("Got any quests for me to help understand these concepts?", function() -- Line: 19
    -- upvalues: u5 (ref), u3 (copy), u2 (copy), u4 (copy)
    local u6 = {
        OpenChest_Quest = { "Open a Chest", "Quest Given" },
        TraitHand_Quest = { "Obtain a Trait Hand", "Quest Given" },
        BlackmarketItem_Quest = { "Sell an item to Blackmarket", "Quest Given" },
        RollAbilityGacha_Quest = { "Roll on Ability Gacha", "Quest Given" },
        CraftAbility_Quest = { "Craft an Ability", "Quest Given" }
    };

    local function GenerateResponses() -- Line: 31
        -- upvalues: u5 (ref), u6 (copy), u3 (ref), u2 (ref), u4 (ref), GenerateResponses (copy)
        u5:ClearLinkedResponses();

        for i, v in u6 do
            if not u3:GetQuestlineInfo(i):expect() then
                u5:LinkResponse(v[1], function() -- Line: 37
                    -- upvalues: u2 (ref), i (copy), u4 (ref), v (copy), u5 (ref), GenerateResponses (ref)
                    u2:CheckDialogue(i):expect();
                    u4:SetText(v[2]);

                    if #u5:GetLinkedResponses() <= 1 then
                        print("SUCCESSFULLY TALKED TO THE GUIDE!");
                        u2:TalkedToTheGuide("The Guide");
                    end;

                    GenerateResponses();
                end);
            end;
        end;

        u5:RefreshResponses();
    end;

    GenerateResponses();

    if #u5:GetLinkedResponses() <= 0 then
        u4:SetText("Sorry, but I don\'t have anymore quests for you");
        u2:TalkedToTheGuide("The Guide");
    else
        u4:SetText("I\'ve got a few here that you can complete to help you learn more about this world quickly.");
    end;

    return "Continue";
end);
local v7 = u4:AddResponse("What is an ability?", function() -- Line: 65
    -- upvalues: u4 (copy)
    u4:SetText("An ability is the power you currently possess. The one that you have currently is <AbilityName>. As you fight great foes and do quests around here, you will start to grow even stronger than previously known.");

    return "Continue";
end);
u4:AddResponse("How do I obtain an ability?", function() -- Line: 70
    -- upvalues: u4 (copy)
    u4:SetText("You can obtain an ability through crafting. Crafting requires the shards of an ability which can be obtained from Ability Gacha or chests/gamemodes.");

    return "Continue";
end);
local v9 = u4:AddResponse("Where can I find more powerful opponents?", function() -- Line: 76
    -- upvalues: GetLevelRecommendation (copy), u4 (copy)
    local v8 = game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Ability"):GetAttribute("AbilityLevel");
    u4:SetText((`You must explore the vast world to discover opponents who can match your strength. At your level, I recommend searching for a place named "{GetLevelRecommendation.GetRegionNameForLevel(v8)}"`));

    return "Continue";
end);
local v10 = u4:AddResponse("How do I unlock new moves?", function() -- Line: 83
    -- upvalues: u4 (copy)
    u4:SetText("You will start to learn new moves upon reaching their required levels (as shown in the ability page). You can configure and customize moves to your liking if you take a look at the ability page. Once learned, you will not lose them, even if you perform an ascension.");
end);
local v11 = u4:AddResponse("What are traits?", function() -- Line: 87
    -- upvalues: u4 (copy)
    u4:SetText("Traits are frequently obtained as you power up. You will get a set of cards to choose a trait from, with many different rarities and special benefits that could be good or bad. I\'ve heard there was a person around here who will give you a new trait for a certain cost...");
end);
local v12 = u4:AddResponse("How do I get UShards or UPoints?", function() -- Line: 91
    -- upvalues: u4 (copy)
    u4:SetText("You can obtain UShards from many diverse gameplay sources (Black Market, Achievements, Quests, etc...). Alternatively, most vendors also accept the more luxurious \"UPoint\" currency which can be obtained in the shop for robux.");
end);
v7:LinkResponse("How do I access more of the potential within my ability?", function() -- Line: 95
    -- upvalues: u4 (copy)
    u4:SetText("Your ability can be powered up by doing a variety of things. Killing the enemies that are invading this place is a good way to start. The more you power up, the higher limit your ability has. Who knows? Maybe you can possess an extremely strong ability.");
end);
v7:AddLinkedResponse(v11);
v7:AddLinkedResponse(v10);
v7:AddLinkedResponse(v9);
v7:AddLinkedResponse(u5);
v7:AddLinkedResponse(v12);

return u4;