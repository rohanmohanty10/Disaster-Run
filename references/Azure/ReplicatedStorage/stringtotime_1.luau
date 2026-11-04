 
 

local u1 = {
    January = 1,
    February = 2,
    March = 3,
    April = 4,
    May = 5,
    June = 6,
    July = 7,
    August = 8,
    September = 9,
    October = 10,
    November = 11,
    December = 12
};

return function(p2) -- Line: 3
    -- upvalues: u1 (copy)
    if p2 == nil then
        warn("at least gimme sumthin");

        return;
    end;

    local string_match_ret = string.match(p2, "%a+");
    local v3 = tonumber(string.match(p2, "%d+"));

    if u1[string_match_ret] then
        return os.time({
            day = 1,
            hour = 0,
            min = 0,
            sec = 0,
            year = v3,
            month = u1[string_match_ret]
        });
    end;

    warn("idk what u mean");
end;