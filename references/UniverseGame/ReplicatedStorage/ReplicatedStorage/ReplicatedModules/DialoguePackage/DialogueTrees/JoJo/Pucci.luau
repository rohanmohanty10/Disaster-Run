  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u2 = Knit.GetService("InventoryService");

local function CheckQuest(u3) -- Line: 12
    -- upvalues: u1 (copy)
    return function(p4, p5) -- Line: 13
        -- upvalues: u1 (ref), u3 (copy)
        if u1:CheckDialogue(u3):expect() then
            p5.Next = {
                Text = "Good Luck"
            };

            return;
        end;

        p5.Next = {
            Text = "You already have the quest"
        };
    end;
end;

local v6 = {
    Start = "start",
    Title = "Pucci"
};
local v7 = {};
local v8 = {
    Mutable = true,
    Text = "What do you want?"
};
local v9 = {};
local v10 = {
    Response = "TWOH Quest"
};
local u11 = "TWOH Quest";

function v10.Callback(p12, p13) -- Line: 13
    -- upvalues: u1 (copy), u11 (copy)
    if u1:CheckDialogue(u11):expect() then
        p13.Next = {
            Text = "Good Luck"
        };

        return;
    end;

    p13.Next = {
        Text = "You already have the quest"
    };
end;

v10.Next = Dialogue.PLACEHOLDER;
local v14 = {
    Response = "C-Moon Quest"
};
local u15 = "C-Moon Quest";

function v14.Callback(p16, p17) -- Line: 13
    -- upvalues: u1 (copy), u15 (copy)
    if u1:CheckDialogue(u15):expect() then
        p17.Next = {
            Text = "Good Luck"
        };

        return;
    end;

    p17.Next = {
        Text = "You already have the quest"
    };
end;

v14.Next = Dialogue.PLACEHOLDER;
local v18 = {
    Response = "MIH Quest"
};
local u19 = "MIH Quest";

function v18.Callback(p20, p21) -- Line: 13
    -- upvalues: u1 (copy), u19 (copy)
    if u1:CheckDialogue(u19):expect() then
        p21.Next = {
            Text = "Good Luck"
        };

        return;
    end;

    p21.Next = {
        Text = "You already have the quest"
    };
end;

v18.Next = Dialogue.PLACEHOLDER;
v9[1], v9[2], v9[3], v9[4], v9[5] = {
    Response = "Give me standless",

    Callback = function(p22) -- Line: 34, Name: Callback
        -- upvalues: u2 (copy)
        u2:GiveMeStandless();
    end,

    Next = {
        Text = "Alright."
    }
}, v10, v14, v18, {
    Response = "Just passing by.",
    Next = nil
};
v8.Options = v9;
v7.start = v8;
v6.Nodes = v7;

return v6;