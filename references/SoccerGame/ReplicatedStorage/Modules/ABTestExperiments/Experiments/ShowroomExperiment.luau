  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);

return {
    RemoteConfig = "ShowroomTest",
    Disabled = true,
    DefaultState = game:GetService("RunService"):IsStudio(),
    States = {
        [true] = {
            Server = function(p1: userdata, p2: any) -- Line: 15, Name: Server
                p1:SetAttribute("AB_ShowroomMethod", "New");
            end,

            Client = function(p3: userdata, p4: any) -- Line: 19, Name: Client
            end
        },
        [false] = {
            Server = function(p5: userdata, p6: any) -- Line: 24, Name: Server
                p5:SetAttribute("AB_ShowroomMethod", "Old");
            end,

            Client = function(p7: userdata, p8: any) -- Line: 28, Name: Client
            end
        }
    }
};