  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v6 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
                Priority = 4
            }
        },
        MovesInfo = require(script.Moves)
    },
    Sounds = require(script.Sounds),
    Animations = require(script.Animations),
    Metadata = {
        PostRig = function(p5) -- Line: 79, Name: PostRig
            -- upvalues: CollectionService (copy)
            local Character = p5.Character;
            local Player = p5.Player;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player then
                Player:HasAppearanceLoaded();
            end;

            CollectionService:AddTag(Character, "Summoned");
        end
    }
};

for _, v in { "Spin Charge", "Dark Determination", "Nail Barrage", "Lesson 2", "Lesson 3", "Lesson 4", "Nail Glide", "Herbal Tea", "Bloodshed" } do
    v6.Stats[v] = {
        From = "Tusk ACT1." .. v
    };
end;

v6.Stats["Rush Attack"] = {
    From = "Tusk ACT1.Rush Attack"
};
v6.Stats["Pay Your Respects"] = {
    Active = true,
    Damage = 20,
    Stun = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    }
};
v6.Stats.Pose = {
    From = "Combat.Pose"
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Quickstep = {
    From = "Combat.Quickstep"
};

return v6;