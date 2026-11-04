 

 

return {
    { 0, function(p1) -- Line: 4
            shared.vfx.emit(p1.main);
        end },
    { 504, function(p2, p3) -- Line: 10
            shared.vfx.emit(p3.transition);
        end },
    { 535, function(p4, p5) -- Line: 16
            shared.vfx.emit(p5.Speedline);

            for _, v in p4.Head do
                shared.vfx.emit(v);
            end;
        end }
};