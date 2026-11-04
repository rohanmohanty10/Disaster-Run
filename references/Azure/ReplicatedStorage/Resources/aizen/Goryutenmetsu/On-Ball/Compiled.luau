 

 

return {
    { 0, function(p1) -- Line: 3
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p1.windup2);
        end },
    { 22, function(p2) -- Line: 10
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p2.shot);
        end }
};