 
 

return {
    { 12, function(p1, p2) -- Line: 4
            shared.vfx.emit(p1.smoke);
        end },
    { 113, function(p3) -- Line: 13
            shared.vfx.emit(p3.flares);
        end },
    { 765, function(p4, p5) -- Line: 22
            shared.vfx.emit(p4.bounce);
            shared.vfx.emit(p5["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 785, function(p6, p7) -- Line: 32
            shared.vfx.emit(p6.someflashvfx);
            shared.vfx.emit(p7["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 800, function(p8, p9) -- Line: 42
            shared.vfx.emit(p8.someflashvfx);
            shared.vfx.emit(p9["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 838, function(p10) -- Line: 52
            shared.vfx.emit(p10.smoke2);
            shared.vfx.emit(p10.CameraShake2);
        end },
    { 874, function(p11) -- Line: 62
            shared.vfx.emit(p11.smoke3);
        end },
    { 932, function(p12, p13) -- Line: 71
            shared.vfx.emit(p13["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 957, function(p14, p15) -- Line: 80
            shared.vfx.emit(p15["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 963, function(p16, p17) -- Line: 89
            shared.vfx.emit(p17["azl ballllllls_rig"].Ball.dribblesmoke);
        end },
    { 977, function(p18, p19) -- Line: 98
            shared.vfx.emit(p19.Head.flashofzone);
            shared.vfx.emit(p18.CameraShake);
        end }
};