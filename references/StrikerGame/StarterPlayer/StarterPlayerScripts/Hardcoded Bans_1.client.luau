 
 

if game.PlaceId == 121877399209259 and not table.find({ 1974243283, 125271750 }, game.Players.LocalPlayer.UserId) then
    return;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = ({})[LocalPlayer.UserId];

if not v1 then
    return;
end;

if v1 ~= "inf" and v1 < os.time() then
    return;
end;

local v8 = (function(p2) -- Line: 23, Name: getRemainingTime
    local v3 = p2 - os.time();

    if v3 <= 0 then
        return "Time already passed!";
    end;

    local math_floor_ret = math.floor(v3 / 31536000);
    local v4 = v3 % 31536000;
    local math_floor_ret2 = math.floor(v4 / 2592000);
    local v5 = v4 % 2592000;
    local math_floor_ret3 = math.floor(v5 / 86400);
    local v6 = v5 % 86400;
    local math_floor_ret4 = math.floor(v6 / 3600);
    local v7 = v6 % 3600;

    return {
        Years = math_floor_ret,
        Months = math_floor_ret2,
        Days = math_floor_ret3,
        Hours = math_floor_ret4,
        Minutes = math.floor(v7 / 60),
        Seconds = v7 % 60
    };
end)(v1);

if typeof(v8) ~= "table" then
    return;
end;

local v9 = v1 == "inf" and "" or string.format("%d years, %d months, %d days, %d hours, %d minutes, %d seconds remaining", v8.Years, v8.Months, v8.Days, v8.Hours, v8.Minutes, v8.Seconds);
LocalPlayer:Kick((`You have recieved a hardcoded ban, you get unbanned {v1 == "inf" and "NEVER" or "in "}{v9}`));