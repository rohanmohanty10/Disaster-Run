  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1) -- Line: 5
    -- upvalues: Knit (copy)
    local v2, v3 = Knit.GetService("CCPanelService"):OpenPrivatePanel(p1.Executor);

    return v2 and "Opened your private CC panel." or v3;
end;