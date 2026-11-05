  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17514613460
        },
        Movement = {
            Idle = 18287795737,
            Forward = 18287802603
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.HoverboardAnimator));
v1:CreateAnimatorFolder(script);

return v1;