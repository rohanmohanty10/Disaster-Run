  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 103242601540893
        },
        Movement = {
            ["Bike Fall"] = 120279459574179,
            ["Bike Forward"] = 129701140491129,
            ["Bike Idle"] = 88170848331903,
            ["Bike Left"] = 135610601784060,
            ["Bike Legs"] = 17675724783,
            ["Bike Right"] = 128354514392602,
            ["Bike Wheels"] = 134004198444694
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v1:CreateAnimatorFolder(script);

return v1;