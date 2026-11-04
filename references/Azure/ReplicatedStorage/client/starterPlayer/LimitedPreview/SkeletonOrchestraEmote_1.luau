 
 

local v1 = {};
v1.__index = v1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("SoundService");
local emoteWiki = ReplicatedStorage.emoteWiki;
require(emoteWiki);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.forum.fastSignal);
require(ReplicatedStorage.util.raycast);
local trove = require(ReplicatedStorage.forum.trove);
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);

function v1.default(p2, p3) -- Line: 22
    -- upvalues: trove (copy), emoteWiki (copy), UwUEffects (copy)
    local v4 = trove.new();
    v4:AttachToInstance(p2);
    local _ = emoteWiki.SkeletonOrchestra;
    v4:Add((UwUEffects.createEffect({
        Character = p2
    }, "SkeletonOrchestra")));
end;

return v1.default;