  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");

return {
    Start = "start",
    Title = "Mech Pilot",
    Nodes = {
        start = {
            Text = "Hey you! Are you from our Field Security Branch?",
            Options = { {
                    Response = "Yes, that would be me.",
                    Next = {
                        Text = "About time the head honchos began recruiting more personnel to this force. We\'re going to need every help we can get, considering our last investigation.",
                        Options = { {
                                Response = "What happened during your previous investigation?",
                                Next = {
                                    Text = "We were unprepared and not well-equipped during a field expedition. We\'ve lost so many.",
                                    Options = { {
                                            Response = "My condolences.",
                                            Next = nil
                                        } }
                                }
                            } }
                    }
                }, {
                    Response = "I think you\'re mistaking me for someone else.",
                    Next = {
                        Text = "Well, that\'s just great. I don\'t think my squadron is going to last another field investigation.",
                        Options = { {
                                Response = "...",
                                Next = nil
                            } }
                    }
                } }
        }
    }
};