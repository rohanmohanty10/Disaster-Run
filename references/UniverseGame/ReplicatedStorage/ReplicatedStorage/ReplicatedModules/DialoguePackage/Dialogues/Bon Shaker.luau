  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function GetStep(u5, u6) -- Line: 13
    return function(p7) -- Line: 14
        -- upvalues: u5 (copy), u6 (copy)
        return u5 == u6;
    end;
end;

function u4.Setup(p8) -- Line: 19
    -- upvalues: u4 (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p9) -- Line: 20
        table.clear(p9._Responses);
    end);
    local u10 = u3:GetCurrentStep("Reaper Quest"):expect() or 1;
    local v11 = u2:CheckRequirement("ItemCountCheck", "ITEM_4"):expect();
    local u12 = u2:CheckRequirement("ItemCountCheck", "ITEM_39"):expect();

    if type(v11) == "number" and v11 > 0 then
        local v13 = u4:AddResponse("Do you have any idea what this corrupted soul does?", function() -- Line: 30
            -- upvalues: u4 (ref)
            u4:SetText("How interesting, if you collect the remaining materials I believe we can restore an ancient weapon to its full power again");

            return "Continue";
        end);
        local u14 = 1;

        function v13.GetStep(p15) -- Line: 14
            -- upvalues: u10 (copy), u14 (copy)
            return u10 == u14;
        end;

        v13:LinkResponse("So what do I need to collect?", function() -- Line: 36
            -- upvalues: u4 (ref)
            u4:SetText("First, we need to reap souls of the weak (defeat npcs) using a cursed ability (STWR, SPR, or Umbra) to enhance this corrupted soul");

            return "Continue";
        end):LinkResponse("Got it", function() -- Line: 39
            -- upvalues: u2 (ref), u4 (ref)
            u2:CheckDialogue("Reaper Quest"):expect();
            u4:Destroy();
        end);
        local u16 = 2;

        u4:AddResponse("How do I reap souls again?", function() -- Line: 44
            -- upvalues: u4 (ref)
            u4:SetText("Defeat NPCS using a cursed ability (STWR, SPR, or Umbra)");
        end).GetStep = function(p17) -- Line: 14
            -- upvalues: u10 (copy), u16 (copy)
            return u10 == u16;
        end;

        local v18 = u4:AddResponse("I have finished reaping souls", function() -- Line: 48
            -- upvalues: u4 (ref)
            u4:SetText("Excellent work, now bring me a (Requiem Arrow) so I can imbue it with the corrupted soul, you can obtain the (Requiem Arrow) from defeating Diavolo");

            return "Continue";
        end);
        local u19 = 3;

        function v18.GetStep(p20) -- Line: 14
            -- upvalues: u10 (copy), u19 (copy)
            return u10 == u19;
        end;

        v18:LinkResponse("Very well", function() -- Line: 54
            -- upvalues: u2 (ref), u4 (ref)
            u2:CheckDialogue("Reaper Quest"):expect();
            u4:Destroy();
        end);
        local u21 = 4;

        u4:AddResponse("I have brought the requiem arrow", function() -- Line: 59
            -- upvalues: u12 (copy), u2 (ref), u4 (ref)
            if type(u12) == "number" and u12 > 0 then
                if u2:CheckDialogue("Reaper Quest"):expect() == "CAPACITY" then
                    u4:SetText("Your inventory seems to be full... Clear out your inventory before I imbue the arrow.");
                else
                    u4:SetText("Alright I have imbued the arrow with the corrupted soul. Your final step is to summon the previous Reaper and defeat it to gain its power, good luck.");
                end;

                return "Continue";
            end;

            u4:SetText("Don\'t play around with me kid, I don\'t see it in your Item Inventory");

            return "ClearResponses";
        end).GetStep = function(p22) -- Line: 14
            -- upvalues: u10 (copy), u21 (copy)
            return u10 == u21;
        end;
    end;
end;

u4:SetTitle("Bon Shaker");
u4:SetStarterText("RESTORES ARE DECLINED FOR NOW");

return u4;