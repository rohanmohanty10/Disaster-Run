  

 

local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local v7 = require(Knit.Util.TableUtil).Reconcile({
    Tracks = {},
    Animations = {
        Action = {
            Jump = 18332385632
        },
        Movement = {
            ["Bike Fall"] = 18332371352,
            ["Bike Idle"] = 18332382056,
            ["Bike Wheels"] = 18332378799
        }
    },

    Step = function(p1, p2, p3, p4, p5) -- Line: 23, Name: Step
        local _ = math.abs(p2) > 0;
        local v6 = p1.OnGround();
        p1.Tracks["Bike Idle"]:AdjustWeight(v6 and 1 or 0.0001);
        p1.Tracks["Bike Fall"]:AdjustWeight(v6 and 0.0001 or 1);
        p1.Tracks["Bike Wheels"]:AdjustSpeed(p2 / (p5 / 3));
    end
}, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.BikeAnimator));
v7:CreateAnimatorFolder(script);

return v7;