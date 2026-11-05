  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local _ = PathShortcuts.RemotesPath.UIOutput;
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Knit.GetService("TitleService");
local u5 = Dialogue.new();
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(PathShortcuts.ItemDataModule);

local function GuideToSanji() -- Line: 18
    -- upvalues: LocalPlayer (copy)
    local Sanji = workspace.NPCS.Sanji;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

    if HumanoidRootPart:FindFirstChild("SanjiWaypoint") then
        return;
    end;

    local u6 = script.SanjiWaypoint:Clone();
    u6.Parent = HumanoidRootPart;
    task.spawn(function() -- Line: 31
        -- upvalues: Sanji (copy), HumanoidRootPart (copy), u6 (copy)
        while true do
            task.wait();
            local Position = Sanji.HumanoidRootPart.Position;
            local Magnitude = (Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude < 50 then
                u6.Transparency = 1 - math.max(0, (Magnitude - 15) / 50);
            end;

            u6.CFrame = CFrame.new(HumanoidRootPart.Position, Position) * CFrame.new(0, 0, -10) * CFrame.Angles(0, 1.5707963267948966, 0);

            if not u6:IsDescendantOf(game) then
                return;
            end;
        end;
    end);
end;

u5:SetCheckStep(function() -- Line: 62
    -- upvalues: u3 (copy), u5 (copy)
    local v7 = u3:GetQuestlineInfo("Baroque Work Contract"):expect() or {};
    local Step = v7.Step;
    local Completed = v7.Completed;

    if Step == 2 or Step == 5 then
        u5:SetText(Completed and "..." or "The other side appears to be silent. You think to yourself that you should complete your assigment first.");
    end;

    return Step;
end);

function u5.Setup(p8, p9) -- Line: 75
    -- upvalues: LocalPlayer (copy), u5 (copy), u4 (copy), GuideToSanji (copy), u2 (copy)
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local u10 = Character:FindFirstChild("Baroque Works Contractor Den Den");

    if not u10 then
        u5:Destroy();

        return;
    end;

    local u12 = Character.ChildRemoved:Connect(function(p11) -- Line: 87
        -- upvalues: u10 (copy), u5 (ref)
        if p11 == u10 then
            u5:Destroy();
        end;
    end);
    u5:AddCallback("OnDestroy", function(p13) -- Line: 91
        -- upvalues: Humanoid (copy), u12 (ref)
        Humanoid:UnequipTools();
        table.clear(p13._Responses);

        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;
    end);

    if not p9 then
        u5:SetTitle("Den Den Mushi");
        u5:SetText("No response.");

        return "ClearResponses";
    end;

    if (u4:GetOwnedTitles():expect() or {}).TITLE_31 then
        u5:SetTitle("Mr 0");
        u5:SetText("Good job slaying Mr Prince. I no longer have the need for your help, Contractor. [TALK TO SANJI AT THE DESERT\'S APPROACH TO CONTINUE QUESTLINE");
        GuideToSanji();

        return "ClearResponses";
    end;

    u5:SetTitle("???");
    u5:SetText("Ahem. Is this the contractor hired by Miss All Sunday?");
    u5:AddResponse("...Who are you?", function() -- Line: 120
        -- upvalues: u5 (ref)
        u5:SetText("I will not repeat myself again.");

        return "Continue";
    end):SetStep(1):LinkResponse("Uh, yeah. I\'m the contractor. Whats up?", function() -- Line: 123
        -- upvalues: u5 (ref)
        u5:SetText("Good... good. Then I assume you know what to do. Get in contact with me once you have got rid of those pesks. You better be quick about it, too.");

        return "Continue";
    end):LinkResponse("For sure.", function() -- Line: 126
        -- upvalues: u2 (ref), u5 (ref)
        u2:CheckDialogue("Baroque Work Contract"):expect();
        u5:SetText("Just keep in mind... I will not tolerate such disrespect in the future.");

        return "ClearResponses";
    end);
    u5:AddResponse("No thats not me.", function() -- Line: 132
        -- upvalues: u5 (ref)
        u5:SetText("Get off this line, kid.");

        return "ClearResponses";
    end):SetStep(1);
    u5:AddResponse("I have purged our enemies.", function() -- Line: 137
        -- upvalues: u5 (ref)
        u5:SetText("Great job on making a quick work of those fools. Miss All Sunday never misses when it comes to hiring contractors.");

        return "Continue";
    end):SetStep(3):LinkResponse("What is the next assignment?", function() -- Line: 140
        -- upvalues: u5 (ref)
        u5:SetText("Hm... I have some unfinished business with someone who dared to betray me. I am quite the busy man so I cannot make any time to get rid of him myself. I want you to interrogate the fool to make sure.");

        return "Continue";
    end):LinkResponse("I will do so.", function() -- Line: 143
        -- upvalues: u2 (ref), u5 (ref)
        task.delay(0.1, function() -- Line: 144
            -- upvalues: u2 (ref)
            u2:CheckDialogue("Baroque Work Contract"):expect();
        end);
        u5:SetText("Show that traitor that no one betrays Baroque Works.");

        return "ClearResponses";
    end);
    u5:AddResponse("I have got rid of your traitor.", function() -- Line: 152
        -- upvalues: u5 (ref)
        u5:SetText("You have proven to be insanely useful so far... You will be rewarded greatly if you complete this last assignment.");

        return "Continue";
    end):SetStep(4):LinkResponse("What is the next assignment?", function() -- Line: 155
        -- upvalues: u5 (ref)
        u5:SetTitle("Mr 0");
        u5:SetText("I have a personal matter that is urgent. There are certain individuals threatening my reign of the Kingdom of Alabasta. They are taunting me through calls and going after my men. I need you to get rid of this anonymous caller who seems to be their leader, named \"Mr Prince\". Your capability will be determined by this objective. I wish you luck. [SPAWN AT THE BOSS ALTAR]");

        return "Continue";
    end):LinkResponse("Understood. I will get rid of Mr Prince.", function() -- Line: 159
        -- upvalues: u2 (ref), u5 (ref)
        u2:CheckDialogue("Baroque Work Contract"):expect();
        u5:SetText("He shall realize who we are.");

        return "ClearResponses";
    end);
end;

return u5;