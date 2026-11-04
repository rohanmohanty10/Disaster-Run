 
 

return {
    { 10, function(p1) -- Line: 3
            local Lighting = game:GetService("Lighting");
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p1.dribble1.firstkick, p1.dribble1.smoke1, p1.dribble1.light, Lighting.purple1);
        end },
    { 30, function(p2) -- Line: 19
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p2.dribble1.flashleft);
        end },
    { 40, function(p3) -- Line: 31
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p3.dribble1.flashright);
        end },
    { 55, function(p4) -- Line: 43
            local Lighting = game:GetService("Lighting");
            local shared_vfx = shared.vfx;
            shared_vfx.init();
            shared_vfx.emit(p4.dribble1.flashleft, Lighting.purple1, p4.dribble1.last, p4.dribble1.smoke2);
        end }
};