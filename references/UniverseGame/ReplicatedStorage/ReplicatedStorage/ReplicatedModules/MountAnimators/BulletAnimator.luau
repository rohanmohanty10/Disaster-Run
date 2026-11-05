  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17461741279
        },
        Movement = {
            Idle = 18331976682,
            Forward = 18331998818
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.HoverboardAnimator));
v1:CreateAnimatorFolder(script);

return v1;