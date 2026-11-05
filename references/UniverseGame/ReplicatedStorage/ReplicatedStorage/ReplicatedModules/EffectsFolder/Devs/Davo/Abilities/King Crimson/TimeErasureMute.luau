  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);

return function(u2) -- Line: 15
    -- upvalues: LocalPlayer (copy), u1 (ref), CollectionService (copy)
    if u2 == LocalPlayer.Character then
        return;
    end;

    local u3 = u1.new();
    u3:AttachToInstance(u2);
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect");
    EqualizerSoundEffect.Priority = 1000;
    EqualizerSoundEffect.HighGain = -80;
    EqualizerSoundEffect.MidGain = -80;
    EqualizerSoundEffect.LowGain = -80;
    u3:Add(EqualizerSoundEffect);
    u3:Connect(CollectionService:GetInstanceRemovedSignal("TimeErase"), function(p4) -- Line: 30
        -- upvalues: u2 (copy), u3 (copy)
        if p4 == u2 then
            u3:Destroy();
        end;
    end);

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Sound") then
            local v5 = Instance.fromExisting(EqualizerSoundEffect);
            v5.Parent = descendant;
            u3:Add(v5);
        end;

        if not u3 then
            break;
        end;
    end;
end;