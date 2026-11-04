  

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TextChatService");
local ContentProvider = game:GetService("ContentProvider");
require(ReplicatedStorage.Shared.ReplicaService);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Signal);
local v1 = Knit.CreateController({
    Name = "SongCryptController"
});

function v1.KnitInit(p2) -- Line: 16
    -- upvalues: Knit (copy), ContentProvider (copy)
    local Service = Knit.GetService("SongCryptService");
    local u3 = { "rbxassetid://16495822782", "rbxassetid://121746225545509", "rbxassetid://105702960085125", "rbxassetid://100859738278751", "rbxassetid://88655232862426", "rbxassetid://114352391547233", "rbxassetid://87912472456803", "rbxassetid://128611181423512", "rbxassetid://73110745626575", "rbxassetid://115869696246143" };
    Service.SendManifestKey:Connect(function(p4) -- Line: 21
        -- upvalues: u3 (copy), ContentProvider (ref)
        for i = 1, #u3 do
            ContentProvider:RegisterSessionEncryptedAsset(u3[i], p4[i]);
            local _ = i;
        end;
    end);
    Service.SendManifestKey:Fire(u3);
end;

return v1;