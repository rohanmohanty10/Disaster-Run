  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MxitzMeshes = require(ReplicatedStorage.ReplicatedModules.Independent.MxitzMeshes);

return function(...) -- Line: 5
    -- upvalues: MxitzMeshes (copy)
    return MxitzMeshes(...);
end;