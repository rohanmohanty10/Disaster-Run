  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 18683569577
        },
        Movement = {
            ["Bike Fall"] = 18683581030,
            ["Bike Forward"] = 18683578575,
            ["Bike Idle"] = 18683574452,
            ["Bike Legs"] = false,
            ["Bike Left"] = 18683563678,
            ["Bike Right"] = 18683558244,
            ["Bike Wheels"] = 18684012420
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v1:CreateAnimatorFolder(script);

return v1;