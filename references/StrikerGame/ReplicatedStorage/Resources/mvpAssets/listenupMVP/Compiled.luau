 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.thousand);
        end },
    { 411, function(p2) -- Line: 8
            for _, v in p2.Head do
                shared.vfx.emit(v);
            end;
        end },
    { 732, function(p3) -- Line: 15
            shared.vfx.emit(p3.work);
        end }
};