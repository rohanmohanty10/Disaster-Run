 

 

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Emotes = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Emotes");
local EmoteCatalog = require(Emotes:WaitForChild("EmoteCatalog"));
local EmotePieces = require(Emotes:WaitForChild("EmotePieces"));
RunService.PreSimulation:Connect(function() -- Line: 11
    -- upvalues: CollectionService (copy), EmotePieces (copy), EmoteCatalog (copy)
    for _, v in CollectionService:GetTagged(EmotePieces.HIDE_TAG) do
        local Attribute = v:GetAttribute("PieceEmote");

        if type(Attribute) == "string" then
            EmotePieces.hold(v, EmoteCatalog.get(Attribute));
        end;
    end;
end);