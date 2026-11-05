  

 

local u1 = coroutine;

return {
    Create = function(p2) -- Line: 5, Name: Create
        -- upvalues: u1 (copy)
        return u1.create(p2);
    end,

    Run = function(p3) -- Line: 9, Name: Run
        -- upvalues: u1 (copy)
        return u1.resume(p3);
    end,

    createRun = function(p4) -- Line: 13, Name: createRun
        -- upvalues: u1 (copy)
        return u1.resume(u1.create(p4));
    end,

    Delay = function(p5, p6) -- Line: 17, Name: Delay
        task.delay(p5, p6);
    end
};