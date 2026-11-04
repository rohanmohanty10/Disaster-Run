 

 

return {
    read = function(p1, p2) -- Line: 3, Name: read
        local math_max_ret = math.max(0, p1.cooldown or 0);
        local v3 = math_max_ret / math.max(p2.Dash.Cooldown, 0.01);
        local v4 = 1 - math.clamp(v3, 0, 1);

        return p2.Dash.Enabled and (p1.paused and {
            label = "DASH PAUSED",
            hint = "Waiting for movement",
            tone = "Muted",
            fill = v4
        } or (p1.boosting and {
            label = "DASHING",
            hint = "Speed burst",
            tone = "Mint",
            fill = v4
        } or ((p1.recovery or 0) > 0 and {
            label = "RECOVERING",
            hint = "Brief speed slowdown",
            tone = "Gold",
            fill = v4
        } or (math_max_ret > 0.02 and {
            hint = "Recharging",
            tone = "Blue",
            fill = v4,
            label = ("%s  ·  %.1fs"):format("DASH", math_max_ret)
        } or (p1.grounded and ((p1.speed or 0) <= p2.StopThreshold and {
            fill = 1,
            label = "DASH READY",
            hint = "Move, then turn + dash",
            tone = "Muted"
        } or {
            fill = 1,
            label = "DASH READY",
            hint = "Turn + press to dodge",
            tone = "Mint",
            ready = true
        }) or {
            fill = 1,
            label = "DASH",
            hint = "Land to dash",
            tone = "Muted"
        }))))) or {
            fill = 0,
            label = "DASH OFF",
            hint = "Disabled",
            tone = "Muted"
        };
    end
};