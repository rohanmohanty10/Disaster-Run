 

 

local u5 = {
    status = function(p1, p2) -- Line: 3, Name: status
        if type(p1) ~= "table" then
            return "Unavailable";
        end;

        local v3 = p1.StartsAt or 0;
        local v4 = p1.EndsAt or 0;

        return type(v3) == "number" and (type(v4) == "number" and (v3 == v3 and (v4 == v4 and (v3 >= 0 and (v4 >= 0 and (v4 <= 0 or v4 > v3)))))) and (v3 > 0 and p2 < v3 and "Upcoming" or (v4 > 0 and v4 <= p2 and "Expired" or "Active")) or "Unavailable";
    end
};

function u5.active(p6, p7) -- Line: 12
    -- upvalues: u5 (copy)
    return u5.status(p6, p7) == "Active";
end;

function u5.countdown(p8, p9) -- Line: 14
    -- upvalues: u5 (copy)
    local v10 = u5.status(p8, p9);

    if v10 == "Expired" then
        return "OFFER ENDED";
    end;

    if v10 == "Unavailable" then
        return "";
    end;

    local v11 = v10 == "Upcoming" and p8.StartsAt or p8.EndsAt;

    if not v11 or v11 <= 0 then
        return "";
    end;

    local math_ceil_ret = math.ceil(v11 - p9);
    local math_max_ret = math.max(0, math_ceil_ret);
    local v12 = math_max_ret // 86400;
    local v13 = math_max_ret % 86400 // 3600;
    local v14 = math_max_ret % 3600 // 60;
    local v15 = v12 > 0 and string.format("%dD %dH %dM", v12, v13, v14) or string.format("%dH %dM %dS", v13, v14, math_max_ret % 60);

    return (v10 == "Upcoming" and "STARTS IN " or "ENDS IN ") .. v15;
end;

function u5.ukSaturdayDeadline(u16, p17, p18) -- Line: 27
    local UnixTimestamp = DateTime.fromUniversalTime(u16, p17, p18, 15).UnixTimestamp;
    local v19 = os.date("!*t", UnixTimestamp).wday == 7;
    assert(v19, "Weekly shop date must be a Saturday");

    local function lastSunday(p20) -- Line: 30
        -- upvalues: u16 (copy)
        local UnixTimestamp2 = DateTime.fromUniversalTime(u16, p20, 31, 1).UnixTimestamp;

        return UnixTimestamp2 - (os.date("!*t", UnixTimestamp2).wday - 1) * 86400;
    end;

    local UnixTimestamp2 = DateTime.fromUniversalTime(u16, 3, 31, 1).UnixTimestamp;
    local v21;

    if UnixTimestamp2 - (os.date("!*t", UnixTimestamp2).wday - 1) * 86400 <= UnixTimestamp then
        local UnixTimestamp3 = DateTime.fromUniversalTime(u16, 10, 31, 1).UnixTimestamp;
        v21 = UnixTimestamp < UnixTimestamp3 - (os.date("!*t", UnixTimestamp3).wday - 1) * 86400;
    else
        v21 = false;
    end;

    return UnixTimestamp - (v21 and 3600 or 0);
end;

return u5;