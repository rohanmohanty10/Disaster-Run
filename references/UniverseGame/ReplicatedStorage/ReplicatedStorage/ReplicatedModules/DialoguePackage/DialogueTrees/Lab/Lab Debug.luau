  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");

return {
    Start = "start",
    Title = "Lab Debug",
    Nodes = {
        start = {
            Mutable = true,
            Text = "...",

            Transformer = function(p2, p3) -- Line: 15, Name: Transformer
            end,

            Options = {
                {
                    Response = "Reputation rewards",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p4) -- Line: 28, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:DisplayRankRewards();
                    end
                },
                {
                    Response = "Reputation exchange",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p5) -- Line: 35, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowReputationExchange");
                    end
                },
                {
                    Response = "Test research",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p6) -- Line: 42, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowLabResearch");
                    end
                },
                {
                    Response = "Test refining",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p7) -- Line: 51, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowLabRefining");
                    end
                },
                {
                    Response = "Add reputation",
                    Next = "start",

                    Callback = function(p8) -- Line: 60, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:TestAddReputation();
                    end
                },
                {
                    Response = "Reset reputation",
                    Next = "start",

                    Callback = function(p9) -- Line: 67, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:TestResetReputation();
                    end
                },
                {
                    Response = "Wipe NPC memory",
                    Next = "start",

                    Callback = function(p10) -- Line: 74, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:TestWipeNPCMemory();
                    end
                },
                {
                    Response = "Wipe Research",
                    Next = "start",

                    Callback = function(p11) -- Line: 81, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:TestWipeResearch();
                    end
                },
                {
                    Response = "Bye",
                    Next = nil
                }
            }
        }
    }
};