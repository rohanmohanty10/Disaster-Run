 

 

return table.freeze({
    read = function(p1, p2) -- Line: 3, Name: read
        local math_max_ret = math.max(0, p1.cooldown or 0);
        local v3 = math_max_ret / math.max(p2.Cooldown, 0.01);
        local v4 = 1 - math.clamp(v3, 0, 1);

        return p1.paused and {
            label = "CATCH PAUSED",
            hint = "Waiting for the run",
            tone = "Muted",
            fill = v4
        } or (p1.active and (p1.elapsed < p1.duration and {
            hint = "Catch in progress",
            tone = "Red",
            fill = v4,
            label = string.upper(p1.variant or "Catch")
        } or {
            label = "RECOVERING",
            hint = "Catch recovery",
            tone = "Gold",
            fill = v4
        }) or (math_max_ret > 0.02 and {
            hint = "Recharging",
            tone = "Blue",
            fill = v4,
            label = ("CATCH  ·  %.1fs"):format(math_max_ret)
        } or (p1.grounded and {
            fill = 1,
            label = "CATCH READY",
            tone = "Mint",
            ready = true,
            hint = (p1.variant or "Dive") .. "  ·  " .. (p1.control or "Catch")
        } or {
            fill = 1,
            label = "CATCH",
            hint = "Land to catch",
            tone = "Muted"
        })));
    end
});