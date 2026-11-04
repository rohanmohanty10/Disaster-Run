 

 

return {
    { 0, function(p1) -- Line: 3
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p1.wind);
            shared_vfx.emit(p1.windup);
        end },
    { 21, function(p2) -- Line: 10
            shared.vfx.emit(p2.volleyshot);
        end }
};