  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1) -- Line: 6
    -- upvalues: environment (copy), ReplicatedStorage (copy), Knit (copy)
    if environment.env ~= "Dev" then
        return "This command only works in the dev place.";
    end;

    for _, child in ReplicatedStorage.Assets.GameEvents:GetChildren() do
        if workspace:FindFirstChild(child.Name) then
            return "An event is already running on this server.";
        end;
    end;

    Knit.GetService("GameEventService"):StartEvent("UbersMatching");

    return "Started Ubers Matching on this server. The portal is open for 60 seconds.";
end;