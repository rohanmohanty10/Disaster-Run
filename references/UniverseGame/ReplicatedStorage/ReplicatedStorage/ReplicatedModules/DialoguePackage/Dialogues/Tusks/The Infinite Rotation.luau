  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function ResetDialogue() -- Line: 15
    -- upvalues: u2 (copy)
    u2:Destroy();
end;

local function GetStep(u5, u6) -- Line: 19
    return function(p7) -- Line: 20
        -- upvalues: u6 (copy), u5 (copy)
        return typeof(u6) == "table" and table.find(u6, u5) or u5 == u6;
    end;
end;

u2:SetTitle("Gyro Zeppeli (Q: The Infinite Rotation)");
u2:SetCheckStep(function(p8, p9) -- Line: 27
    -- upvalues: u4 (copy), u2 (copy), LocalPlayer (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();
    print(v10);

    if v10 == 2 then
        u2:SetText("Did you defeat those hooligans yet? Come back to me when you\'re done.");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Nice work with those idiots. Now, the real reason I called you — <Color=158,239,255>Funny Valentine<Color=/> and <Color=255,236,125>Diego Brando<Color=/>. Valentine executed Diego during the <Color=191,255,107>Steel Ball Run<Color=/>. I need you to investigate him. Something about his movements doesn’t add up. Start where he last dined, a spot nearby where he met with some... shady people. Find clues and report back to me. <Color=Red>Be careful though, they may catch a hold of you.<Color=/>");

        return v10;
    end;

    if v10 == 4 then
        if LocalPlayer:GetAttribute("InInvestigation") then
            u2:SetText("Please hurry up with the investigation, you don\'t have much time. [Investigate Albasta]");

            return v10;
        end;

        u2:SetText("Keep your eyes open.");

        return v10;
    end;

    if v10 == 5 then
        u2:SetText("Blood stains, a napkin, a corpse part, and the flag — perfect. This confirms it. Valentine’s been here, and he\'s making his moves. Now listen carefully. To find him outside of his safe spot, you\'ll need to use these clues.");

        return v10;
    end;

    if v10 == 6 then
        u2:SetText("Funny Valentine is still around, make sure you finish him off with your Tusk Act 3.");

        return v10;
    end;

    if v10 == 7 then
        u2:SetText("You\'ve done a good job. The true potential of the infinite rotation is yours.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 52
    -- upvalues: u2 (copy), u4 (copy), LocalPlayer (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 53
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    local v15 = u4:GetCurrentStep(script.Name):expect();

    if not v15 then
        u2:SetText(".");

        return "ClearResponses";
    end;

    local v16 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v17 = LocalPlayer.Data.Ability:GetAttribute("AbilityLevel");

    if (v16 ~= "Tusk ACT3" and v16 ~= "Tusk ACT4" or v17 < 200) and v15 < 7 then
        task.delay(0.05, function() -- Line: 71
            -- upvalues: u2 (ref)
            u2:SetText("You\'re not ready yet. Come back when you\'ve got the power to handle this. [Level 200, and have Tusk Act 3 or 4 equipped]");
        end);

        return "ClearResponses";
    end;

    if v16 == "Tusk ACT4" then
        u2:SetText("So, Tusk Act 4. You\'ve really mastered its power. But listen, I need to tell you about two key figures — <Color=158,239,255>Funny Valentine<Color=/> and <Color=255,236,125>Diego Brando<Color=/>. Did you know Valentine executed Diego during the <Color=191,255,107>Steel Ball Run<Color=/>? Strange times, huh? I need your help.");
    else
        u2:SetText("So, Tusk Act 3, huh? You\'re really mastering its power. But listen, I need to tell you about two key figures — <Color=158,239,255>Funny Valentine<Color=/> and <Color=255,236,125>Diego Brando<Color=/>. Did you know Valentine executed Diego during the <Color=191,255,107>Steel Ball Run<Color=/>? Strange times, huh? I need your help.");
    end;

    local v18 = u2:AddResponse("What do you need?", function() -- Line: 84
        -- upvalues: u2 (ref)
        u2:SetText("I’ve got some unfinished business... group of hooligans has been causing me trouble. I need you to take care of them. Once you\'re done, I\'ll tell you more.");

        return "Continue";
    end);
    u2:AddResponse("Sorry, I can\'t help right now.", function() -- Line: 89
        -- upvalues: u2 (ref)
        u2:SetText("Understood, come back another time.");

        return "ClearResponses";
    end);
    v18:LinkResponse("Alright, I\'ll get it done.", function() -- Line: 95
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Appreciated.");

        return "ClearResponses";
    end);
    v18:LinkResponse("Sorry, I can\'t help right now.", function() -- Line: 101
        -- upvalues: u2 (ref)
        u2:SetText("Understood, come back another time.");

        return "ClearResponses";
    end);

    if v15 == 4 then
        u3:CheckDialogue(script.Name):expect();
    end;

    u2:AddResponse("Got it, I\'ll see what I can find. [Investigate Albasta]", function() -- Line: 112
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name, "BeginInvestigation"):expect();
        u2:SetText("Good luck.");

        return "ClearResponses";
    end):SetStep(3);
    u2:AddResponse("Not now.", function() -- Line: 118
        -- upvalues: u2 (ref)
        u2:SetText("Suit yourself.");

        return "ClearResponses";
    end):SetStep(3);
    local v19 = u2:AddResponse("Tell me more.", function() -- Line: 124
        -- upvalues: u2 (ref)
        u2:SetText("The flag and the corpse part — use them to track him. Valentine’s not easy to pin down, but these will help. Find him, and you know what to do. Take him out with Tusk Act 3, this way you might find the true potential of your ability.");

        return "Continue";
    end):SetStep(5);
    v19:LinkResponse("Will do.", function() -- Line: 129
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Don\'t let your guard down.");

        return "ClearResponses";
    end);
    v19:LinkResponse("Sorry, I can\'t help right now.", function() -- Line: 135
        -- upvalues: u2 (ref)
        u2:SetText("Come back soon.");

        return "ClearResponses";
    end);
    u2:AddResponse("Glad I could be of help.", function() -- Line: 140
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Good luck on your journey.");

        return "ClearResponses";
    end):SetStep(7);
end;

return u2;