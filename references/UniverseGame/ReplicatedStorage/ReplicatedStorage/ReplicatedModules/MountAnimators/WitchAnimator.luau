  

 

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
            ["Mount Idle"] = 17630817524
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.NimbusAnimator));
v1:CreateAnimatorFolder(script);

return v1;