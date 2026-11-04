 
 

local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = Knit.CreateController({
    Name = "EncryptedAssetsController"
});

function u1.KnitStart(p2) -- Line: 10
    -- upvalues: Knit (copy), ContentProvider (copy), u1 (copy)
    for i, v in Knit.GetService("EncryptedAssetsService"):RequestEncryptedKeys() do
        ContentProvider:RegisterSessionEncryptedAsset(i, v);
    end;

    u1.HasLoaded = true;
end;

return u1;