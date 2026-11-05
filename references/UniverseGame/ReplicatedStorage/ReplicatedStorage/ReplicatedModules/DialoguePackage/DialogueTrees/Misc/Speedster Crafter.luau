  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

local function make_response_for_item(p1) -- Line: 6
    return {
        Response = `I want to make a {p1}`,
        Next = {
            Text = "kk",

            Callback = function(p2, p3) -- Line: 11, Name: Callback
            end
        }
    };
end;

return {
    Start = "step_1",
    Title = "Strange Individual",
    Nodes = {
        reject = {
            Text = "ay bruh its yo life"
        },
        step_1 = {
            Text = "Arrghh... Hey there, young man. Can you help me find some scraps?",
            Options = {
                make_response_for_item("Fragment"),
                make_response_for_item("Shard"),
                make_response_for_item("Conduit"),
                make_response_for_item("Nexus"),
                {
                    Response = "Im good, thanks.",
                    Next = "reject"
                }
            }
        }
    }
};