  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");

return {
    Title = "Lab Debug 2",

    Start = function() -- Line: 8, Name: Start
        -- upvalues: u1 (copy)
        return u1:HasTalkedToLabNPC("testing"):expect() and "start_2" or "start";
    end,

    Nodes = {
        start = {
            Mutable = true,
            Text = "hi",
            Options = {
                {
                    Response = "hello",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p2) -- Line: 27, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:SetTalkedToLabNPC("testing");
                    end
                }
            }
        },
        start_2 = {
            Mutable = true,
            Text = "hi again",
            Options = { {
                    Response = "cool",
                    Next = nil
                } }
        },
        invalid = {
            Text = "...",
            Options = { {
                    Response = "...",
                    Next = nil
                } }
        }
    }
};