  

local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "EncryptedAssetsController"
});

function v1.KnitStart(p2) -- Line: 10
    -- upvalues: Knit (copy), ContentProvider (copy)
    for i, v in Knit.GetService("EncryptedAssetsService"):RequestEncryptedKeys() do
        ContentProvider:RegisterSessionEncryptedAsset(i, v);
    end;
end;

return v1;