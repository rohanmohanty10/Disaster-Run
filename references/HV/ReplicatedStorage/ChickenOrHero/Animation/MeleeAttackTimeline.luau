 

 

return table.freeze({
    sample = function(p1, p2, p3) -- Line: 4, Name: sample
        if p1 < p2.Windup then
            return "Windup", math.max(0, p1) * p3.WindupRate, p3.WindupRate;
        end;

        local v4 = p1 - p2.Windup;
        local StabContactStart = p3.StabContactStart;
        local StabContactEnd = p3.StabContactEnd;

        if v4 < p2.ActiveDuration then
            local v5 = (StabContactEnd - StabContactStart) / p2.ActiveDuration;

            return "Active", StabContactStart + math.max(0, v4) * v5, v5;
        end;

        local v6 = v4 - p2.ActiveDuration;

        if v6 >= p2.Recovery then
            return "Complete", p3.StabDuration, 0;
        end;

        local v7 = (p3.StabDuration - StabContactEnd) / p2.Recovery;

        return "Recovery", StabContactEnd + math.max(0, v6) * v7, v7;
    end
});