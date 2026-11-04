  

local os_time_ret = os.time();

return function() -- Line: 3
    -- upvalues: os_time_ret (copy)
    local v1 = os.time() - os_time_ret;

    return ("%dd %dh %dm %ds"):format(math.floor(v1 / 86400), math.floor(v1 / 3600) % 24, math.floor(v1 / 60) % 60, math.floor(v1) % 60);
end;