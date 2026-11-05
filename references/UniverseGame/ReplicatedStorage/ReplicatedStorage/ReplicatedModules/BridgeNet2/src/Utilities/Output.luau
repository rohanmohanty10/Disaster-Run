  

 

local RunService = game:GetService("RunService");
local u3 = {
    silent = function(p1) -- Line: 10, Name: silent
        -- upvalues: RunService (copy)
        if RunService:IsStudio() then
            print((`[BridgeNet2] {p1}`));
        end;
    end,

    log = function(p2) -- Line: 16, Name: log
        print((`[BridgeNet2] {p2}`));
    end
};

function u3.logAssert(p4, p5) -- Line: 20
    -- upvalues: u3 (copy)
    if not p4 then
        u3.log(p5);
    end;
end;

function u3.warn(p6) -- Line: 26
    warn((`[BridgeNet2] {p6}`));
end;

function u3.warnAssert(p7, p8) -- Line: 30
    -- upvalues: u3 (copy)
    if not p7 then
        u3.warn(p8);
    end;
end;

function u3.typecheck(p9, p10, p11, p12) -- Line: 43
    local v13 = typeof(p12);

    if v13 ~= p9 then
        error(`[BridgeNet2] {p10} parameter {p11} takes {p9}, got {v13}`, 0);
    end;
end;

function u3.fatal(p14) -- Line: 51
    error(`[BridgeNet2] {p14}`, 0);
end;

function u3.fatalAssert(p15, p16) -- Line: 55
    if not p15 then
        error(`[BridgeNet2] {p16}`, 0);
    end;
end;

return u3;