  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function ResetDialogue() -- Line: 13
    -- upvalues: u4 (copy)
    u4:Destroy();
end;

u4:SetCheckStep(function() -- Line: 17
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetTitle("DELTA Captain");
        u4:SetText("Hello, can I help you?");

        return v5;
    end;

    if v5 == 3 then
        u4:SetTitle("DELTA Captain");
        u4:SetText("Back already? Have you gathered the shards yet?");

        return v5;
    end;

    if v5 == 4 then
        u4:SetTitle("DELTA Captain");
        u4:SetText("Oh, I remember you. Back already? Have you gathered the shards yet?");

        return v5;
    end;

    if v5 ~= 5 then
        if v5 == 6 then
            u4:SetTitle("...");
            u4:SetText("Its aura mesmerizes you, leaving you in a trance. It begs for you to speak your mind.");
        end;

        return v5;
    end;

    u4:SetTitle("DELTA Captain");
    u4:SetText("Be sure to open up the astral chest and beat the flight minigame to progress");

    return v5;
end);
u4:BindNPC(1, "DELTA Cult", {});
u4:BindNPC(
    2,
    "DELTA Captain",
    {
        ["DELTA Cult"] = "Have you found the captain yet? He is at the spray painting mural."
    }
);
u4:BindNPC(3, "DELTA Captain");
u4:BindNPC(4, "DELTA Captain");
u4:BindNPC(5, "DELTA Captain", {
    ["..."] = "You feel a cold, unnerving presence."
});
u4:BindNPC(6, "...");
u4:SetStarterTitle("DELTA Cult");
u4:SetStarterText("The day of the ‘Second Fracture’ is upon us! We must band together to find the one who can stop it all!");
local v6 = u4:AddResponse("Sounds interesting. I want in.", function() -- Line: 53
    -- upvalues: u4 (copy)
    u4:SetText("Is that so? Meet one of our Captains around the spray painting mural.. It’s too dangerous for them to be out here with us..");

    return "Continue";
end);
v6:LinkResponse("Will do.", function() -- Line: 57
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end);
v6:LinkResponse("Uhh.. on second thought, this sounds insane.", ResetDialogue);
u4:AddResponse("You people sound crazy.", ResetDialogue);
u4:AddResponse("I\'m one of the new recruits.", function() -- Line: 65
    -- upvalues: u4 (copy)
    u4:SetText("I assume the other members already told you of what we’re doing here, correct?");

    return "Continue";
end):SetStep(2):LinkResponse("No..", function() -- Line: 68
    -- upvalues: u4 (copy)
    u4:SetText("They haven’t?.. I guess I’ll have to give you the rundown for now, we’re looking towards finding the ‘Shaper’ and the ‘Delta’.. They’ll preserve us in the upcoming ‘Second Fracture’.");

    return "Continue";
end):LinkResponse(". . .", function() -- Line: 71
    -- upvalues: u4 (copy)
    u4:SetText("Oh yeah.. I’m supposed to give you this too. He hands you a transmitter. Look towards finding each and every piece of the ‘Key’.");

    return "Continue";
end):LinkResponse(". . .", function() -- Line: 74
    -- upvalues: u4 (copy)
    u4:SetText("Don’t think you\'re special. This is standard procedure for every new recruit. Take this too, it\'s an introductory gift. He hands you Tome 1 of PLANET//SHAPER.");

    return "Continue";
end):LinkResponse("Got it", function() -- Line: 77
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end);
u4:AddResponse("Yes.", function() -- Line: 82
    -- upvalues: u4 (copy)
    u4:SetText("Haha, very funny. Now go find the shards please.");

    return "Continue";
end):SetStep(3):LinkResponse("Alright... Sorry.", function() -- Line: 85
    -- upvalues: u4 (copy)
    u4:SetText("It’s whatever. Everybody else gets stuck on this part anyways.");

    return "ClearResponses";
end);
u4:AddResponse("Yes. (You hand him the shards).", function() -- Line: 90
    -- upvalues: u4 (copy)
    u4:SetText("Really? No recruit has gotten this far before.. Here it is. He reassembles the key. The key should be drawn to the chest. Look out for anything telling you about its presence.");

    return "Continue";
end):SetStep(4):LinkResponse("I see.. Thank you.", function() -- Line: 93
    -- upvalues: u2 (copy)
    u2:CheckDialogue(script.Name):expect();

    return "ClearResponses";
end);
u4:AddResponse("I need the key again", function() -- Line: 98
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("There you go");

    return "ClearResponses";
end):SetStep(5);
u4:AddResponse("I’ve seen it all. I wish to become a servant of the ‘Delta’.", function() -- Line: 104
    -- upvalues: u4 (copy)
    u4:SetText("The figure groans, raising itself above you.");

    return "Continue";
end):SetStep(6):LinkResponse("I willingly give myself to the ‘Delta’.. I wish to undo the mess you have created by taking the place of the ‘Shaper’.", function() -- Line: 107
    -- upvalues: u4 (copy)
    u4:SetText("A weight feels as if it\'s been draped over your shoulders. Your heart stops for a brief moment.");

    return "Continue";
end):LinkResponse(". . .", function() -- Line: 110
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end);

return u4;