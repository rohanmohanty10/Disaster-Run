  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Knit.GetService("ShopService");
local u5 = Dialogue.new();
local u6 = nil;

local function ResetDialogue() -- Line: 15
    -- upvalues: u5 (copy)
    u5:Destroy();
end;

local function HasLinkedResponses() -- Line: 19
    -- upvalues: u6 (ref)
    return #u6:GetLinkedResponses() > 0;
end;

local function ClearResponses() -- Line: 23
    -- upvalues: u6 (ref)
    if #u6:GetLinkedResponses() > 0 then
        u6:ClearLinkedResponses();
    end;
end;

u5:SetCheckStep(function() -- Line: 29
    -- upvalues: u3 (copy), u5 (copy)
    local v7 = u3:GetCurrentStep(script.Name):expect();

    if v7 == 2 then
        u5:SetText("You should complete that daily quest soon.");
    end;

    return v7;
end);
u5:SetTitle("Akira_Blade");
u5:SetStarterText("Here for a daily quest?");
u6 = u5:AddResponse("Yes my good sir", function() -- Line: 40
    -- upvalues: u2 (copy), u5 (copy), u6 (ref), u4 (copy)
    local v8, v9 = u2:CheckDialogue(script.Name):expect();

    if v8 == true then
        u5:SetText(string.format("Daily quest has been given. (%s double drops left)", v9));
        u5:Destroy();
    elseif type(v8) == "string" then
        u5:SetText(string.format("Daily quest will reset in [%s]. (%s double drops left)", v8, v9));
    end;

    if #u6:GetLinkedResponses() > 0 then
        if #u6:GetLinkedResponses() > 0 then
            u6:ClearLinkedResponses();
        end;
    else
        u6:LinkResponse("I want to reset my Daily quest cooldown.", function() -- Line: 50
            -- upvalues: u5 (ref)
            u5:SetText("Are you sure? This will cost you [1 uFragment].");

            return "Continue";
        end):LinkResponse("Yes", function() -- Line: 53
            -- upvalues: u4 (ref), u5 (ref)
            u4:BuyDailyQuestReset();
            u5:Destroy();

            return "ClearResponses";
        end);
    end;

    return "Continue";
end);

return u5;