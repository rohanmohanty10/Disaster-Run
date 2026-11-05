  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v1 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17675720994
        },
        Movement = {
            ["Bike Fall"] = 17675714754,
            ["Bike Forward"] = 17675718339,
            ["Bike Idle"] = 17675719740,
            ["Bike Left"] = 17675723575,
            ["Bike Legs"] = 17675724783,
            ["Bike Right"] = 17675725851,
            ["Bike Wheels"] = 17477073229
        }
    }
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v1:CreateAnimatorFolder(script);

return v1;