  

 

local function msg(...) -- Line: 1
    return `[Forge Emit API]: {table.concat({ ... }, " ")}`;
end;

return {
    error = function(...) -- Line: 7, Name: error
        -- upvalues: msg (copy)
        error(msg(..., "\n"));
    end,

    warn = function(...) -- Line: 11, Name: warn
        -- upvalues: msg (copy)
        warn(msg(...));
        warn(msg(debug.traceback("stack trace:")));
    end,

    info = function(...) -- Line: 16, Name: info
        -- upvalues: msg (copy)
        print(msg(...));
    end
};