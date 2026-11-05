  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);

return {
    Start = "start",
    Title = "Test",
    Nodes = {
        start = {
            Text = "Example start text",
            Options = { {
                    Response = "Hello",
                    Next = "~/DialogueDocumentation/reply"
                }, {
                    Response = "Bye",
                    Next = nil
                } }
        },
        reply = {
            Mutable = true,
            Text = "Hi %s",

            Transformer = function(p1, p2) -- Line: 25, Name: Transformer
                p2.Text = string.format(p2.Text, game:GetService("Players").LocalPlayer.Name);
            end,

            Options = {
                {
                    Response = "Ok bye",
                    Next = nil,

                    Callback = function(p3, p4) -- Line: 32, Name: Callback
                        local Model = p3:GetMetadata().Model;
                        print(Model);
                        print(game:GetService("Players").LocalPlayer:DistanceFromCharacter(Model:GetPivot().Position));
                    end
                }
            }
        }
    }
};