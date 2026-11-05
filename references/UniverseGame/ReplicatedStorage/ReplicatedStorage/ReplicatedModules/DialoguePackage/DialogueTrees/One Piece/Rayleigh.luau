  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);

return {
    Start = "start",
    Title = "Rayleigh",
    Nodes = {
        start = {
            Text = "What can I help you with?",
            Options = {
                {
                    Response = "I wish to change my Haki color",
                    Next = nil,

                    Callback = function(p1) -- Line: 15, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowHakiUI");
                    end
                }
            }
        }
    }
};