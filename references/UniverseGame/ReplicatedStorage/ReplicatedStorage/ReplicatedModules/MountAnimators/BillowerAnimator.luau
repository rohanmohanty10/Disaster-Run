  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 18332452299
        },
        Movement = {
            18332450961,
            ["Bike Idle"] = 18332448015,
            ["Bike Wheels"] = 18332453703,
            ["Bike Fall"] = 18332450961
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.MopedAnimator));
v1:CreateAnimatorFolder(script);

return v1;