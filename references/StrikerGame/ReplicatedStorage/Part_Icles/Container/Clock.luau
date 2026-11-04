 

 

return {
    position = function(p1, p2, p3, p4) -- Line: 27, Name: position
        local v5 = 0;

        if p1 == "Relative" then
            v5 = p4.delay;
        elseif p1 == "Relative Lifetime" then
            v5 = p4.delay;
            p3 = p4.life;
        elseif p1 == "Relative Span" then
            v5 = p4.delay;
            p3 = p4.duration + p4.life;
        end;

        return p2 <= v5 and 0 or (p3 <= 0 and 1 or math.min((p2 - v5) / p3, 1));
    end,

    playLength = function(p6, p7, p8) -- Line: 48, Name: playLength
        local math_max_ret = math.max(p8 or 1, 0.1);

        for _, v in ipairs(p7) do
            local v9 = v.delay + v.duration + v.life / math_max_ret;

            if p6 < v9 then
                p6 = v9;
            end;
        end;

        return math.min(p6, 120);
    end,

    maxDuration = function(p10) -- Line: 60, Name: maxDuration
        if type(p10) == "number" then
            return math.max(p10, 0);
        end;

        if type(p10) ~= "string" then
            return 0;
        end;

        local v11 = 0;

        for i in string.gmatch(p10, "[^,]+") do
            local string_gsub_ret = string.gsub(i, "%s", "");
            local v12 = tonumber(string_gsub_ret);

            if v12 and v11 < v12 then
                v11 = v12;
            end;
        end;

        return v11;
    end
};