  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
u3:SetTitle("Sanji, the Prince");

function u3.Setup(p4) -- Line: 15
    -- upvalues: u2 (copy), u3 (copy)
    if not u2:CheckDialogue(script.Name):expect() then
        u3:SetText("I have no need in talking to you. [POSSESS THE BAROQUE WORKS CONTRACTOR TITLE]");

        return "ClearResponses";
    end;

    u3:SetText("You better have not brought anyone else with you, Baroque Works Contractor.");
    u3:AddResponse("I haven\'t, believe me.", function() -- Line: 20
        -- upvalues: u3 (ref)
        u3:SetText("Good, because I have really valuable intel I have to tell you. Crocodile, or as you know him, Mr 0, is the current lead of the Kingdom of Alabasta. He seeks to destabilize and conquer it for his own gain on finding the ancient weapon \"Pluton\", forged during the Void Century. We must take him down as no man should be able to possess such a weapon. Are you with me on this?");

        return "Continue";
    end):LinkResponse("I am with you. Lets do it.", function() -- Line: 23
        -- upvalues: u3 (ref)
        u3:SetText("Thats the spirit! Lets get rid of him and maybe I\'ll cook you something up later. He\'s up just ahead");

        return "Continue";
    end);
    local SanjiWaypoint = game.Players.LocalPlayer.Character:FindFirstChild("SanjiWaypoint", true);

    if not SanjiWaypoint then
        return;
    end;

    SanjiWaypoint:Destroy();
end;

return u3;