 
 

local ServerTimeNow = workspace:GetServerTimeNow();
local u1 = DateTime.now().UnixTimestampMillis / 1000;
local u2 = ServerTimeNow - u1;
local u3 = time();

return function(p4: boolean?) -- Line: 8
    -- upvalues: u3 (ref), ServerTimeNow (ref), u1 (ref), u2 (ref)
    if time() - u3 > 1 then
        u3 = time();
        ServerTimeNow = workspace:GetServerTimeNow();
        u1 = DateTime.now().UnixTimestampMillis / 1000;
        u2 = ServerTimeNow - u1;
    end;

    if p4 == true then
        return DateTime.now().UnixTimestampMillis / 1000 + u2;
    end;

    local v5 = DateTime.now().UnixTimestamp + u2;

    return math.round(v5);
end;