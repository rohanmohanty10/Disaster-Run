  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);

return {
    Start = "start_node",
    Title = "Example",
    Nodes = {
        start_node = {
            Text = "Example start text",
            Options = { {
                    Response = "Hello",
                    Next = "reply_node"
                }, {
                    Response = "Bye",
                    Next = nil
                } }
        },
        reply_node = {
            Mutable = true,
            Text = "Hi %s",
            Title = "Joyous Example",

            Transformer = function(p1, p2) -- Line: 47, Name: Transformer
                p2.Text = string.format(p2.Text, game:GetService("Players").LocalPlayer.Name);
            end,

            Options = {
                {
                    Response = "Ok bye",
                    Next = nil,

                    Callback = function(p3, p4) -- Line: 62, Name: Callback
                        print("Left");
                    end
                }
            }
        }
    }
};