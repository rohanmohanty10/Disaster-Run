 

 

return {
    getSeason = function() -- Line: 6, Name: getSeason
        local os_date_ret = os.date("*t");

        return (os_date_ret.year - 2026) * 12 + (os_date_ret.month - 6) + 1;
    end
};