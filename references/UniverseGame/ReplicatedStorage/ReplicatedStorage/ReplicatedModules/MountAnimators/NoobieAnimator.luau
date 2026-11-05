  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            ["Bike Jump"] = 17400245014
        },
        Movement = {
            ["Bike Fall"] = 17400245014,
            ["Bike Forward"] = 17400245014
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v1:CreateAnimatorFolder(script);

return v1;