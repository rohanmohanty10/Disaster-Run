  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);

return {
    Start = "start",
    Title = "Ability Banner",
    Nodes = {
        start = {
            Text = "What can I help you with?",
            Options = {
                {
                    Response = "I would like to access the ability banner",
                    Next = nil,

                    Callback = function(p1) -- Line: 15, Name: Callback
                    end
                }
            }
        }
    }
};