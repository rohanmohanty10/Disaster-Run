  

return {
    LoopForTime = function(p1: number, p2: function, p3: number?) -- Line: 3, Name: LoopForTime
        local v4 = tick();
        local v5 = p3 or 0.1;

        while tick() - v4 < p1 do
            p2();
            task.wait(v5);
        end;
    end
};