 

game:GetService("TweenService")
game:GetService("Debris")
local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.TrackingProjectile)
return {
    ["start"] = function(_, u3, p4) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u3 then
            function p4.TravelFunction() --[[ Line: 13 ]] end
            function p4.FunctionCheck() --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                return u3:GetAttribute("StormChaserTravel") == nil
            end
            u2(p4)
        end
    end
}