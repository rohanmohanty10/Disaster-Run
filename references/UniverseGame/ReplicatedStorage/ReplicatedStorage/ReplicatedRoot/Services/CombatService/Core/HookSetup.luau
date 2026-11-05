  

 

return {
    Init = function(u1) -- Line: 4, Name: Init
        u1._Hooks = {};

        function u1.AddHook(p2, p3) -- Line: 7
            -- upvalues: u1 (copy)
            if u1._Hooks[p2] then
                error((`{p2} hook already exists`));

                return;
            end;

            u1._Hooks[p2] = p3;
        end;

        function u1.GetHook(p4) -- Line: 12
            -- upvalues: u1 (copy)
            return u1._Hooks[p4];
        end;
    end,

    Start = function(p5) -- Line: 17, Name: Start
    end
};