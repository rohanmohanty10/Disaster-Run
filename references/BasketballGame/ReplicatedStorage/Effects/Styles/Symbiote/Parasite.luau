 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1) -- Line: 5
    -- upvalues: SfxManager (copy)
    SfxManager:playSound({
        Sound = "BBZ Symbiote FaceTendril Swipe",
        Parent = p1.ParasiteChar
    });
end;