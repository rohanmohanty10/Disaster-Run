  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");

return {
    Start = "start",
    Title = "Scientist",
    Nodes = {
        start = {
            Text = "Hey, have you seen my Clonkus?",
            Options = { {
                    Response = "Your what?",
                    Next = {
                        Text = "A Clonkus, a small grey creature made of \'Clonkite\', a resource scarcely found in the \'Fractured Islands\'. I seem to have misplaced mine and I can\'t find it anywhere, do tell me if you ever stumble upon it.",
                        Options = { {
                                Response = "I\'ll see what I can do, I guess.",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "<i>Back away slowly</i>",
                    Next = nil
                } }
        }
    }
};