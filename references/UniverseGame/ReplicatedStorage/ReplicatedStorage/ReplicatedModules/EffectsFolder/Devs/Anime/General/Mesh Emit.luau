  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = {};

for _, child in script:GetChildren() do
    u1[child.Name] = require(child);
end;

return function(p2) -- Line: 12
    -- upvalues: u1 (copy), ParticleHandler (copy)
    local Effect = p2.Effect;
    local Origin = p2.Origin;
    local v3 = p2.Offset or CFrame.identity;
    local Extra = p2.Extra;

    if Effect and (Origin and u1[Effect]) then
        local v4 = ParticleHandler.TranslateToCFrame(Origin) * ParticleHandler.TranslateToCFrame(v3);
        u1[Effect](v4, Extra);
    end;
end;