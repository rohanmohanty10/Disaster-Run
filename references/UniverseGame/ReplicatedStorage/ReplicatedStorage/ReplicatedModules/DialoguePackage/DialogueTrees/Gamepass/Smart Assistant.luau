  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("ShopService");
local u2 = { {
        Name = "The Shady Person",
        Color = "#000000",
        Topic = "black market",
        AssistantNumber = 1
    }, {
        Name = "The Slayer Master",
        Color = "#FF0000",
        Topic = "slayer contracts",
        AssistantNumber = 2
    }, {
        Name = "The Master Crafter",
        Color = "#00FF00",
        Topic = "crafting",
        AssistantNumber = 3
    }, {
        Name = "The Adventurer",
        Color = "#0000FF",
        Topic = "adventure board",
        AssistantNumber = 4
    }, {
        Name = "The Haki Master",
        Color = "#00FFFF",
        Topic = "haki customization",
        AssistantNumber = 6
    }, {
        Name = "The Unusual Merchant",
        Color = "#ca53e1",
        Topic = "unusuals",
        AssistantNumber = 7
    } };

return {
    Start = "StartNode",
    Title = "UniversalOS Smart Assistant",
    Nodes = (function() -- Line: 46, Name: SetupNodes
        -- upvalues: u2 (copy), u1 (copy)
        local v3 = {};
        local v4 = {};

        for _, v in u2 do
            ("Proceed_%*"):format(v.AssistantNumber);
            local v6 = {
                Next = nil,
                Response = string.format("I would like to contact \"<font color=\"%s\">%s</font>\" about the %s.", v.Color, v.Name, v.Topic),

                Callback = function(p5) -- Line: 57, Name: Callback
                    -- upvalues: u1 (ref), v (copy)
                    u1:RequestSmartAssistant(v.AssistantNumber):expect();
                end
            };
            table.insert(v3, v6);
        end;

        table.insert(v3, {
            Response = "Nevermind.",
            Next = nil
        });
        v4.StartNode = {
            Mutable = true,
            Text = "Hello, %s. How may I help?",

            Transformer = function(p7, p8) -- Line: 70, Name: Transformer
                p8.Text = string.format(p8.Text, game:GetService("Players").LocalPlayer.Name);
            end,

            Options = v3
        };

        return v4;
    end)()
};