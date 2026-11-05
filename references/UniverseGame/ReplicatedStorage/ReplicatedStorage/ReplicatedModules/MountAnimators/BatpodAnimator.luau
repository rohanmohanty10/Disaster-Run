  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 18332527102
        },
        Movement = {
            ["Bike Fall"] = 18332523548,
            ["Bike Forward"] = 18332530496,
            ["Bike Idle"] = 18332525283,
            ["Bike Legs"] = false,
            ["Bike Left"] = 18332528704,
            ["Bike Right"] = 18332532895,
            ["Bike Wheels"] = 18332534519
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v1:CreateAnimatorFolder(script);

return v1;