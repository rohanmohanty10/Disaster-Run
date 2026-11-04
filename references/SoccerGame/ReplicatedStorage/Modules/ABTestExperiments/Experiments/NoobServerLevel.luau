  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "NoobServerLevel",
    Disabled = false,
    DefaultState = true,
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 15, Name: Server
                p1:SetAttribute("AB_NoobServerLevel", 10);
            end,

            Client = function(p3: userdata, p4: any) -- Line: 20, Name: Client
            end
        },
        [false] = {
            Server = function(p5: userdata, p6: any) -- Line: 25, Name: Server
                p5:SetAttribute("AB_NoobServerLevel", 3);
            end,

            Client = function(p7: userdata, p8: any) -- Line: 29, Name: Client
            end
        }
    }
};