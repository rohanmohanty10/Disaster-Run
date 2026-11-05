  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local u3 = false;

return {
    Title = "Usopp",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: u2 (copy), u3 (ref), u1 (copy)
        if not u2:GetQuestlineInfo("Save_The_Village_Adventure"):expect() then
            return u3 and "thanks" or "welcome";
        end;

        local v4, v5 = u1:CheckDialogue("Save_The_Village_Adventure"):expect();

        if v4 then
            if v5 == 2 then
                return "in_danger";
            end;

            if v5 == 3 then
                return "completed";
            end;
        elseif v5 == 2 then
            return "reminder";
        end;

        return "welcome";
    end,

    Nodes = {
        welcome = {
            Text = "Oh, uhh... Hey! Welcome to Syrup Village!",
            Options = {}
        },
        thanks = {
            Text = "Thank you for saving our village! You\'re welcome here any time!",
            Options = {}
        },
        in_danger = {
            Text = "Help us! Save us! Our village, Syrup Village, is being attacked by Kuro!",
            Options = {}
        },
        completed = {
            Mutable = true,
            Text = "Thank you... Please, take my rewards!",
            Options = {},

            Callback = function() -- Line: 57, Name: Callback
                -- upvalues: u3 (ref)
                u3 = true;
            end
        },
        reminder = {
            Text = "What are you doing? Please save us, I beg of you! Don\'t let him ruin our village!",
            Options = {}
        }
    }
};