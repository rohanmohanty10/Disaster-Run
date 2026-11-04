  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
require(ReplicatedStorage.Shared.BLRTypes);
local v1 = require("./EmoteTypes/standardEmote");
local v2 = RunService:IsServer();
local v3 = {};

for _, child in script.Parent.New:GetChildren() do
    for _, child2 in child:GetChildren() do
        local v4 = require(child2);
        v3[child2.Name] = v4;

        if v2 then
            if v4.anims then
                local v5 = v4.trackToDisplay or "walk";
                local Animation = Instance.new("Animation");
                Animation.Parent = ReplicatedStorage.Assets.Emotes;
                Animation.Name = child2.Name;
                Animation.AnimationId = v4.anims[v5];
                Animation:SetAttribute("Rarity", v4.meta.rarity);
            else
                local Animation = Instance.new("Animation");
                Animation.Parent = ReplicatedStorage.Assets.Emotes;
                Animation.Name = child2.Name;
                Animation.AnimationId = v4.animationId;
                Animation:SetAttribute("Rarity", v4.meta.rarity);
            end;
        end;
    end;
end;

local v6;

if v2 then
    v6 = require(ServerScriptService.KnitServer.Services.EmoteService.EmoteFunctions);
else
    v6 = v2;
end;

local v7 = { "Ninja Run", "Dragon Ride", "Sleigh", "T Pose Walk", "Zombie Walk", "Isagi\'s Slide", "Skull Ride" };

for i, v in require(script.legacyEmotes) do
    local v8 = v[1];
    local v9 = v[2];
    local u10 = v[3];

    if v2 then
        if u10 then
            u10 = v6[u10];
        end;
    else
        u10 = v2;
    end;

    v3[i] = v1({
        animationId = v8,
        effect = u10 and function(...) -- Line: 62
            -- upvalues: u10 (copy)
            local v11 = u10(...);

            return not v11 and function() -- Line: 68
            end or v11:WrapClean();
        end or nil,
        maxWalkDistance = table.find(v7, i) and (1 / 0) or 2,
        meta = {
            rarity = v9
        }
    });

    if v2 then
        local Animation = Instance.new("Animation");
        Animation.Parent = ReplicatedStorage.Assets.Emotes;
        Animation.Name = i;
        Animation.AnimationId = v8;
        Animation:SetAttribute("Rarity", v9);

        if v[4] then
            Animation:SetAttribute("Run", true);
        end;
    end;
end;

return v3;