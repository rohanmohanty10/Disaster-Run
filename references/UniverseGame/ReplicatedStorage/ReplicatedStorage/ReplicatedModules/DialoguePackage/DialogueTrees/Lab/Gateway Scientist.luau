  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");

return {
    Title = "Gateway Researcher",

    Start = function() -- Line: 8, Name: Start
        return `start_{math.random(1, 3)}`;
    end,

    Nodes = {
        start_1 = {
            Text = "You ever wonder what happens if the tether doesn’t pull you back?",
            Options = { {
                    Response = "No... should I be wondering?",
                    Next = {
                        Text = "We have no records of a failure. Yet. But if it happens, I hope you’re not the one out there.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "It’ll work. Right?",
                    Next = {
                        Text = "Statistically? Probably. Emotionally? I wouldn\'t bet my arm on it.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                } }
        },
        start_2 = {
            Text = "I haven’t slept in 36 hours. The generator won’t calibrate itself.",
            Options = { {
                    Response = "Should you even be working?",
                    Next = {
                        Text = "If I stop working, someone else will take over - and I\'m not sure if I trust that.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "Want me to take a look?",
                    Next = {
                        Text = "You certified in cross-dimensional phase alignment? No? I thought so.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                } }
        },
        start_3 = {
            Text = "We detected a shift in the wormholes\' outer boundary again. That\'s about the third time this week.",
            Options = { {
                    Response = "Is that bad?",
                    Next = {
                        Text = "Bad? No. Catastrophic? Possibly.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "What’s causing it?",
                    Next = {
                        Text = "Unknown. But it\'s changing, and not on our schedule.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                } }
        }
    }
};