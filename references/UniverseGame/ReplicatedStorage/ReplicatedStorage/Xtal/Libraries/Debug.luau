  

 

local u1 = {};
local _ = {
    error = error,
    print = print,
    warn = warn
};

function u1.Print(p2, ...) -- Line: 10
    local script = getfenv(2).script;
    local v3 = script and script.Name or "";

    return print(v3 .. (v3 == "" and "" or "@") .. "𝐱𝐭𝐚𝐥:", ..., "");
end;

function u1.Warn(p4, ...) -- Line: 21
    local script = getfenv(2).script;
    local v5 = script and script.Name or "";

    return warn(v5 .. (v5 == "" and "" or "@") .. "𝐱𝐭𝐚𝐥:", ..., "");
end;

function u1.Wrap(p6, p7, ...) -- Line: 32
    -- upvalues: u1 (copy)
    return xpcall(p7, function(p8) -- Line: 33
        -- upvalues: u1 (ref)
        u1:Warn(p8:format(p8, debug.traceback()));
    end, ...);
end;

return u1;