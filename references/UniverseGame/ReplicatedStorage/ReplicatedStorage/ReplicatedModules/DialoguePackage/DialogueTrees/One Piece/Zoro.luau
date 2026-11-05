  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Knit.GetService("AdventureService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u5 = nil;

return {
    Title = "Zoro",

    Start = function() -- Line: 14, Name: GetStart
        -- upvalues: u3 (copy)
        local v6 = u3:GetQuestlineInfo("Zoros_Swords_Adventure"):expect();

        return v6 and (v6.Completed == true and "step_Completed" or (v6.Step == 3 and "step_Return" or "step_Quest")) or "step_None";
    end,

    Nodes = {
        step_None = {
            Text = "Huh? What are you doing here?"
        },
        step_Completed = {
            Text = "You\'ve already collected my swords!"
        },
        step_Quest = {
            Text = "Hello, are you the one who has come to help me?",
            Options = {
                {
                    Response = "Yes, you needed someone to find your arsenal?",
                    Next = {
                        Text = "Oh, right! Well, I\'ve lost my swords and I do not have a good sense of direction, though I do remember being at <Color=#8f8fff>%s<Color=/>, <Color=#8f8fff>%s<Color=/> and <Color=#8f8fff>%s<Color=/>. Perhaps you can locate my swords?",
                        Mutable = true,

                        Transformer = function(p7, p8) -- Line: 50, Name: Transformer
                            -- upvalues: u2 (copy), PathShortcuts (copy), LocalPlayer (copy), u4 (copy)
                            local _, v9 = u2:CheckDialogue("Zoros_Swords_Adventure"):expect();
                            p8.Text = string.format(p8.Text, v9.SwordLocations[1].Region, v9.SwordLocations[2].Region, v9.SwordLocations[3].Region);

                            for i = 1, 3 do
                                local u10 = PathShortcuts.ClientAssets["Zoro Swords"][`Sword{tostring(i)}`]:Clone();
                                u10:PivotTo(v9.SwordLocations[i].Location);
                                local ProximityPrompt = Instance.new("ProximityPrompt");
                                ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
                                ProximityPrompt.ObjectText = "Zoro\'s Sword";
                                ProximityPrompt.ActionText = "Pick up";
                                ProximityPrompt.Parent = u10.Root;
                                u10.Parent = workspace;
                                ProximityPrompt.Triggered:Connect(function(p11) -- Line: 63
                                    -- upvalues: LocalPlayer (ref), u4 (ref), i (copy), u10 (copy)
                                    if p11 == LocalPlayer and u4:PickedUpSword(i):expect() then
                                        u10:Destroy();
                                    end;
                                end);
                            end;
                        end
                    }
                }
            }
        },
        step_Return = {
            Text = "Have you returned my sword?",
            Options = {
                {
                    Response = "Yes, I have, here they are.",

                    Callback = function(p12, p13) -- Line: 85, Name: Callback
                        -- upvalues: u2 (copy), u5 (ref)
                        local v14, v15 = u2:CheckDialogue("Zoros_Swords_Adventure"):expect();
                        u5 = v15;

                        if v14 == false then
                            if v15.State == 1 then
                                p13.Next = "step_Return_Fail";
                            end;
                        else
                            p13.Next = "step_Finale";
                        end;
                    end
                }
            }
        },
        step_Return_Fail = {
            Text = "You don\'t seem to have all of my swords. Remember, I was at <Color=#8f8fff>%s<Color=/>, <Color=#8f8fff>%s<Color=/> and <Color=#8f8fff>%s<Color=/> today.",
            Mutable = true,

            Transformer = function(p16, p17) -- Line: 101, Name: Transformer
                -- upvalues: u5 (ref)
                p17.Text = string.format(p17.Text, u5.SwordLocations[1].Region, u5.SwordLocations[2].Region, u5.SwordLocations[3].Region);
            end
        },
        step_Finale = {
            Text = "Oh, you did indeed find my swords! Here\'s a reward for your efforts."
        },
        step_Error = {
            Text = "omg hi"
        }
    }
};