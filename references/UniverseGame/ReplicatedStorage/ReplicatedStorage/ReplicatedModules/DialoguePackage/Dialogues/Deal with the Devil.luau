  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 17
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("You haven\'t completed my tasks.");
    end;

    return v5;
end);
u4:SetTitle("Ghost Rider");
u4:SetStarterText("Man... I should\'ve been called Daredevil. It really doesn\'t make sense... This dude... he has the abilities of a bat, but hes called Daredevil? Total non-sense, right? What do you say?");
local v6 = u4:AddResponse("So true man. Anyways, cool bike you got there.", function() -- Line: 28
    -- upvalues: u4 (copy)
    u4:SetText("I TOTALLY AGREE! Hey, would you like to take a drive? I can\'t lie... it is pretty FIRE!");

    return "Continue";
end);
v6:LinkResponse("HELL yeah! Got it? Hell... yeah...", function() -- Line: 33
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue(script.Name):expect() then
        u4:SetText("Alright, here are some objectives.. to make sure u can HANDLE THE HEAT!");
    else
        u4:SetText("You already have my ride.");
    end;

    return "ClearResponses";
end);
v6:LinkResponse("You creep me out bro", function() -- Line: 13, Name: ResetDialogue
    -- upvalues: u4 (copy)
    u4:Destroy();
end);

return u4;